# Manticore Search Client
# Copyright (c) 2020-2025, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

defmodule Manticoresearch.Api.IndexTest do
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

  test "insert documents with explicit and auto-generated ids" do
    conn = connection()

    ok!(Utils.sql(conn, "DROP TABLE IF EXISTS products", raw_response: true), "DROP TABLE")

    ok!(
      Utils.sql(
        conn,
        "CREATE TABLE IF NOT EXISTS products (title text, price float, sizes multi, meta json, coeff float, tags1 multi, tags2 multi)",
        raw_response: true
      ),
      "CREATE TABLE"
    )

    inserted =
      ok!(
        Index.insert(conn, %{
          table: "products",
          id: 1,
          doc: %{title: "first", tags1: [4, 2, 1, 3]}
        }),
        "insert with id"
      )

    assert document_id(inserted) == 1

    ok!(
      Index.insert(conn, %{table: "products", id: 2, doc: %{title: "second"}}),
      "insert second document"
    )

    auto_id =
      ok!(
        Index.insert(conn, %{table: "products", doc: %{title: "auto-id"}}),
        "insert auto-generated id"
      )

    auto_id_value = document_id(auto_id)
    assert auto_id_value != nil
    refute is_binary(auto_id_value)
  end

  test "bulk insert and bulk update" do
    conn = connection()

    ok!(Utils.sql(conn, "DROP TABLE IF EXISTS products", raw_response: true), "DROP TABLE")

    ok!(
      Utils.sql(
        conn,
        "CREATE TABLE IF NOT EXISTS products (title text, price float, sizes multi, meta json, coeff float, tags1 multi, tags2 multi)",
        raw_response: true
      ),
      "CREATE TABLE"
    )

    insert_body = """
    {"insert": {"table": "products", "id": 3, "doc": {"title": "Crossbody \\"Bag with Tassel", "price": 19.85}}}
    {"insert": {"table": "products", "id": 4, "doc": {"title": "microfiber sheet set", "price": 19.99}}}
    {"insert": {"table": "products", "id": 5, "doc": {"title": "CPet Hair Remover Glove", "price": 7.99}}}
    """

    bulk_insert = ok!(Index.bulk(conn, insert_body), "bulk insert")
    refute bulk_errors?(bulk_insert)

    update_body = """
    {"update": {"table": "products", "doc": {"coeff": 1000}, "query": {"range": {"price": {"gte": 1000}}}}}
    {"update": {"table": "products", "doc": {"coeff": 0}, "query": {"range": {"price": {"lt": 1000}}}}}
    """

    bulk_update = ok!(Index.bulk(conn, update_body), "bulk update")
    refute bulk_errors?(bulk_update)
  end

  test "insert and search uuid document ids" do
    conn = connection()

    ok!(Utils.sql(conn, "DROP TABLE IF EXISTS movies_uuid", raw_response: true), "DROP TABLE")
    ok!(Utils.sql(conn, "CREATE TABLE movies_uuid (id uuid, title text)", raw_response: true), "CREATE TABLE")

    inserted =
      ok!(
        Index.insert(conn, %Manticoresearch.Model.InsertDocumentRequest{
          table: "movies_uuid",
          uuid: @uuid,
          doc: %{title: "uuid doc"}
        }),
        "insert uuid document"
      )

    assert document_id(inserted) == nil
    assert document_uuid(inserted) == @uuid

    response = ok!(Search.search(conn, %{table: "movies_uuid"}), "search uuid table")
    hit = first_hit(response)
    assert hit != nil
    assert document_id(hit) == nil
    assert document_uuid(hit) == @uuid
  end

  defp bulk_errors?(result) do
    case result do
      %{errors: errors} -> errors == true
      %{"errors" => errors} -> errors == true
      _ -> false
    end
  end

  defp first_hit(response) do
    hits =
      get_in_struct(response, [:hits, :hits]) ||
        get_in_struct(response, ["hits", "hits"]) ||
        []

    List.first(List.wrap(hits))
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
