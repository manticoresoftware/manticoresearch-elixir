# Manticore Search Client
# Copyright (c) 2020-2025, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

defmodule Manticoresearch.Api.UtilsTest do
  use ExUnit.Case

  alias Manticoresearch.Api.Utils

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

  test "sql drop, create, select and show tables" do
    conn = connection()

    ok!(Utils.sql(conn, "DROP TABLE IF EXISTS movies", raw_response: true), "DROP TABLE")
    ok!(
      Utils.sql(
        conn,
        "CREATE TABLE IF NOT EXISTS movies (title text, plot text, year bigint, rating float, code multi)",
        raw_response: true
      ),
      "CREATE TABLE"
    )

    parsed = ok!(Utils.sql(conn, "SELECT * FROM movies", raw_response: false), "SELECT parsed")
    assert parsed != nil

    raw = ok!(Utils.sql(conn, "SELECT * FROM movies", raw_response: true), "SELECT raw")
    assert raw != nil

    default = ok!(Utils.sql(conn, "SELECT * FROM movies", raw_response: true), "SELECT default")
    assert default != nil

    ok!(Utils.sql(conn, "TRUNCATE TABLE movies", raw_response: true), "TRUNCATE TABLE")
    tables = ok!(Utils.sql(conn, "SHOW TABLES", raw_response: true), "SHOW TABLES")
    assert tables != nil
  end
end
