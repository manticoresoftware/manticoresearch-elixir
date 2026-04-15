# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

defmodule Manticoresearch.Api.IndexTest do
  use ExUnit.Case, async: false
  doctest Manticoresearch.Api.Index

  @test_table "test_rt_#{System.os_time(:second)}"

  setup_all do
    tesla_client = Manticoresearch.Connection.new()

    sql =
      ~s[mode=raw&query=CREATE TABLE #{@test_table} ( title text, content text, gid integer)]

    create_index_response = Manticoresearch.Api.Utils.sql(tesla_client, sql)

    on_exit(fn ->
      drop_sql =
        ~s[mode=raw&query=DROP TABLE #{@test_table}]

      Manticoresearch.Api.Utils.sql(tesla_client, drop_sql)
    end)

    %{table: @test_table, client: tesla_client}
  end

  setup %{table: table, client: client} do
    truncate_sql =
      ~s[mode=raw&query=TRUNCATE TABLE #{@test_table}]

    Manticoresearch.Api.Utils.sql(client, truncate_sql)
    :ok
  end

  test "perform a search", %{table: table, client: client} do
    doc =
      %{
        index: table,
        id: 1,
        doc: %{
          title: "Hello",
          content: "world",
          gid: 1
        }
      }
      |> Poison.encode!()

    expected_response =
      {:ok,
       %Manticoresearch.Model.SearchResponse{
         hits: %Manticoresearch.Model.SearchResponseHits{
           hits: [
             %{
               "_id" => 1,
               "_score" => 2500,
               "_source" => %{"content" => "world", "gid" => 1, "title" => "Hello"}
             }
           ],
           total: 1,
           total_relation: "eq"
         },
         profile: nil,
         timed_out: false,
         took: 0
       }}

    # insert a document
    insert_response = Manticoresearch.Api.Index.insert(client, doc)

    # search for inserted one
    json = ~s[{"index": "#{table}",
               "query": {
                  "match": {
                    "*": "hello world"
                  }
                }
              }]
    api_response = Manticoresearch.Api.Search.search(client, json)

    assert api_response == expected_response
  end

  test "bulk insert", %{table: table, client: client} do
    # bulk insert
    data = [
      ["lorem", 42, "ipsum"],
      ["ipsum", 100_500, "lorum"],
      ["sator", 2, "arepo"],
      ["tenet", 12, "opera"],
      ["rotas", 21, "sator"]
    ]

    ndjson =
      data
      |> Enum.with_index()
      |> Enum.map(fn {[content, gid, title], i} ->
        doc = %{content: content, gid: gid, title: title}

        insert_operation = %{
          insert: %{
            table: table,
            id: i + 10,
            doc: doc
          }
        }

        Poison.encode!(insert_operation)
      end)
      |> Enum.join("\n")

    bulk_response = Manticoresearch.Api.Index.bulk(client, ndjson)

    # search for bulk inserted
    json = ~s[{"index": "#{table}",
               "query": {
                  "match": {
                    "*": "sator"
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
               "_id" => 12,
               "_score" => 1587,
               "_source" => %{"content" => "sator", "gid" => 2, "title" => "arepo"}
             },
             %{
               "_id" => 14,
               "_score" => 1587,
               "_source" => %{"content" => "rotas", "gid" => 21, "title" => "sator"}
             }
           ]
         },
         profile: nil,
         warning: nil
       }}

    assert search_response == expected_response
  end
end
