# Manticore Search Client
# Copyright (c) 2020-2025, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

defmodule Manticoresearch.Api.SearchTest do
  use ExUnit.Case

  alias Manticoresearch.Api.Index
  alias Manticoresearch.Api.Search
  alias Manticoresearch.Api.Utils

  @uuid "550e8400-e29b-41d4-a716-446655440000"

  defp connection do
    Manticoresearch.Connection.new(base_url: "http://localhost:9408")
  end

  defp ok!(result, context) do
    case result do
      {:ok, %Manticoresearch.Model.ErrorResponse{} = error} ->
        flunk("#{context} returned error: #{inspect(error)}")

      {:ok, value} ->
        value

      other ->
        flunk("#{context} failed: #{inspect(other)}")
    end
  end

  test "bulk insert, search with highlight, uuid ids and autocomplete" do
    conn = connection()

    ok!(Utils.sql(conn, "DROP TABLE IF EXISTS movies", raw_response: true), "DROP movies")
    ok!(Utils.sql(conn, "DROP TABLE IF EXISTS movies_uuid", raw_response: true), "DROP movies_uuid")

    ok!(
      Utils.sql(
        conn,
        "CREATE TABLE IF NOT EXISTS movies (title text, plot text, year bigint, rating float, code multi) min_infix_len='2'",
        raw_response: true
      ),
      "CREATE movies"
    )

    ok!(
      Utils.sql(conn, "CREATE TABLE IF NOT EXISTS movies_uuid (id uuid, title text)",
        raw_response: true
      ),
      "CREATE movies_uuid"
    )

    docs = [
      %{
        insert: %{
          table: "movies",
          id: 1,
          doc: %{
            title: "Star Trek 2: Nemesis",
            plot:
              "The Enterprise is diverted to the Romulan homeworld Romulus, supposedly because they want to negotiate a peace treaty. Captain Picard and his crew discover a serious threat to the Federation once Praetor Shinzon plans to attack Earth.",
            year: 2002,
            rating: 6.4,
            code: [1, 2, 3]
          }
        }
      },
      %{
        insert: %{
          table: "movies",
          id: 2,
          doc: %{
            title: "Star Trek 1: Nemesis",
            plot:
              "The Enterprise is diverted to the Romulan homeworld Romulus, supposedly because they want to negotiate a peace treaty. Captain Picard and his crew discover a serious threat to the Federation once Praetor Shinzon plans to attack Earth.",
            year: 2001,
            rating: 6.5,
            code: [1, 12, 3]
          }
        }
      },
      %{
        insert: %{
          table: "movies",
          id: 3,
          doc: %{
            title: "Star Trek 3: Nemesis",
            plot:
              "The Enterprise is diverted to the Romulan homeworld Romulus, supposedly because they want to negotiate a peace treaty. Captain Picard and his crew discover a serious threat to the Federation once Praetor Shinzon plans to attack Earth.",
            year: 2003,
            rating: 6.6,
            code: [11, 2, 3]
          }
        }
      },
      %{
        insert: %{
          table: "movies",
          id: 4,
          doc: %{
            title: "Star Trek 4: Nemesis",
            plot:
              "The Enterprise is diverted to the Romulan homeworld Romulus, supposedly because they want to negotiate a peace treaty. Captain Picard and his crew discover a serious threat to the Federation once Praetor Shinzon plans to attack Earth.",
            year: 2003,
            rating: 6.5,
            code: [1, 2, 4]
          }
        }
      },
      %{insert: %{table: "movies_uuid", id: @uuid, doc: %{title: "uuid doc"}}}
    ]

    bulk_body =
      docs
      |> Enum.map(&JSON.encode!/1)
      |> Enum.join("\n")

    ok!(Index.bulk(conn, bulk_body <> "\n"), "bulk insert movies")

    all = ok!(Search.search(conn, %{table: "movies"}), "search all movies")
    assert hit_total(all) == 4
    first = first_hit(all)
    assert document_id(first) != nil
    refute is_binary(document_id(first))

    uuid_res = ok!(Search.search(conn, %{table: "movies_uuid"}), "search uuid movies")
    uuid_hit = first_hit(uuid_res)
    assert uuid_hit != nil
    assert document_id(uuid_hit) == nil
    assert document_uuid(uuid_hit) == @uuid

    highlighted =
      ok!(
        Search.search(conn, %{
          table: "movies",
          query: %{query_string: "@title Trek 4"},
          highlight: %{fields: ["title"]}
        }),
        "search with highlight"
      )

    assert hit_total(highlighted) == 1
    highlight = hit_highlight(first_hit(highlighted))
    assert highlight != nil

    match_filter =
      ok!(
        Search.search(conn, %{
          table: "movies",
          query: %{bool: %{must: [%{match: %{title: "4"}}]}}
        }),
        "search match filter"
      )

    assert document_id(first_hit(match_filter)) == 4

    autocomplete =
      ok!(
        Search.autocomplete(conn, %{
          table: "movies",
          query: "Romul",
          options: %{fuzziness: 0, layouts: "us,uk"}
        }),
        "autocomplete"
      )

    queries = autocomplete_queries(autocomplete)
    assert "romulan" in queries
    assert "romulus" in queries
  end

  defp hit_total(response) do
    get_in_struct(response, [:hits, :total]) ||
      get_in_struct(response, ["hits", "total"])
  end

  defp first_hit(response) do
    hits =
      get_in_struct(response, [:hits, :hits]) ||
        get_in_struct(response, ["hits", "hits"]) ||
        []

    List.first(List.wrap(hits))
  end

  defp hit_highlight(hit) do
    get_in_struct(hit, [:highlight]) || get_in_struct(hit, ["highlight"])
  end

  defp document_id(value) do
    get_in_struct(value, [:id]) ||
      get_in_struct(value, [:_id]) ||
      get_in_struct(value, ["id"]) ||
      get_in_struct(value, ["_id"])
  end

  defp document_uuid(value) do
    get_in_struct(value, [:uuid]) ||
      get_in_struct(value, [:_uuid]) ||
      get_in_struct(value, ["uuid"]) ||
      get_in_struct(value, ["_uuid"])
  end

  defp autocomplete_queries(result) when is_list(result) do
    result
    |> Enum.flat_map(fn
      %{"data" => data} when is_list(data) -> Enum.map(data, & &1["query"])
      %{data: data} when is_list(data) -> Enum.map(data, & &1["query"])
      _ -> []
    end)
    |> Enum.reject(&is_nil/1)
  end

  defp autocomplete_queries(_), do: []

  defp get_in_struct(nil, _), do: nil

  defp get_in_struct(value, [key]) do
    cond do
      is_struct(value) -> Map.get(value, key)
      is_map(value) -> Map.get(value, key) || Map.get(value, to_string(key))
      true -> nil
    end
  end

  defp get_in_struct(value, [key | rest]) do
    get_in_struct(get_in_struct(value, [key]), rest)
  end
end
