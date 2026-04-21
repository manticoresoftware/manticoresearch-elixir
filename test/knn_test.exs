# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

defmodule Manticoresearch.Api.KnnTest do
  use ExUnit.Case, async: false
  doctest Manticoresearch.Api.Index

  @test_table "test_rt_knn_#{System.os_time(:second)}"
  @dimensions 1024

  setup_all do
    tesla_client = Manticoresearch.Connection.new()

    sql = ~s"""
    CREATE TABLE #{@test_table} (
      title text,
      embed float_vector knn_type='hnsw' knn_dims='#{@dimensions}' hnsw_similarity='cosine'
    )
    """

    create_index_response = Manticoresearch.Api.Utils.sql(tesla_client, sql, raw_response: true)
    # IO.inspect(create_index_response)

    on_exit(fn ->
      drop_sql = "DROP TABLE #{@test_table}"

      Manticoresearch.Api.Utils.sql(tesla_client, drop_sql, raw_response: true)
    end)

    %{table: @test_table, client: tesla_client}
  end

  setup %{table: table, client: client} do
    truncate_sql = "TRUNCATE TABLE #{@test_table}"

    Manticoresearch.Api.Utils.sql(client, truncate_sql, raw_response: true)
    :ok
  end

  def generate_uniform(seed) do
    :rand.seed(:exsss, {seed, seed, seed})
    for _ <- 1..@dimensions, do: :rand.uniform() * 2 - 1
  end

  def shuffle_string_deterministic(str, seed) do
    :rand.seed(:exsss, {seed, seed, seed})

    str
    |> String.graphemes()
    |> Enum.shuffle()
    |> Enum.join()
  end

  test "knn search", %{table: table, client: client} do
    base_strings = [
      "lorem",
      "ipsum",
      "lorum",
      "sator",
      "arepo",
      "tenet",
      "opera",
      "rotas"
    ]

    base_len = Enum.count(base_strings)

    ndjson =
      1..64
      |> Enum.map(fn i ->
        embed = generate_uniform(i)

        title =
          base_strings
          |> Enum.at(rem(i, base_len))
          |> shuffle_string_deterministic(i)

        doc = %{title: title, embed: embed}

        insert_operation = %{
          insert: %{
            table: table,
            id: i,
            doc: doc
          }
        }

        Poison.encode!(insert_operation)
      end)
      |> Enum.join("\n")

    # IO.inspect(ndjson)

    bulk_response = Manticoresearch.Api.Index.bulk(client, ndjson)
    # IO.inspect(bulk_response)

    json = ~s[{"index": "#{table}",
               "query": {
                  "match": {
                    "*": "atros"
                  }
                }
              }]
    search_response = Manticoresearch.Api.Search.search(client, json)

    expected_response =
      {:ok,
       %Manticoresearch.Model.SearchResponse{
         took: 0,
         timed_out: false,
         aggregations: nil,
         hits: %Manticoresearch.Model.SearchResponseHits{
           max_score: nil,
           total: 2,
           total_relation: "eq",
           hits: [
             %{
               "_id" => 47,
               "_source" => %{"title" => "atros"}
             }
           ]
         },
         profile: nil,
         warning: nil
       }}

    assert search_response = expected_response

    # KNN search:
    id = 47
    wanted_count = 25

    sql =
      ~s"""
      SELECT
        *,
        knn_dist() as distance
      FROM #{table}
      WHERE knn(embed, #{wanted_count}, #{id});
      """

    search_response = Manticoresearch.Api.Utils.sql(client, sql)

    expected_response =
      {:ok, [%{"data" => %{}, "error" => "", "total" => 20, "warning" => ""}]}

    assert expected_response = search_response

    {:ok, [%{"data" => data}]} = search_response
    IO.inspect(data)
    assert Enum.count(data) == 20
  end
end
