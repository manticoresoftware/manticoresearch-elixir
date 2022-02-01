# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Api.Utils do
  @moduledoc """
  API calls for all endpoints tagged `Utils`.
  """

  alias Manticoresearch.Connection
  import Manticoresearch.RequestBuilder


  @doc """
  Perform SQL requests
  Run a query in SQL format. Expects a query parameters string that can be in two modes: * Select only query as `query=SELECT * FROM myindex`. The query string MUST be URL encoded * any type of query in format `mode=raw&query=SHOW TABLES`. The string must be as is (no URL encoding) and `mode` must be first. The response object depends on the query executed. In select mode the response has same format as `/search` operation. 

  ## Parameters

  - connection (Manticoresearch.Connection): Connection to server
  - body (String.t): Expects is a query parameters string that can be in two modes:    * Select only query as `query=SELECT * FROM myindex`. The query string MUST be URL encoded    * any type of query in format `mode=raw&query=SHOW TABLES`. The string must be as is (no URL encoding) and `mode` must be first. 
  - opts (KeywordList): [optional] Optional parameters
    - :raw_response (boolean()): 
  ## Returns

  {:ok, } on success
  {:error, info} on failure
  """
  @spec sql(Tesla.Env.client, String.t, keyword()) :: {:ok, map()} | {:ok, Manticoresearch.Model.ErrorResponse.t} | {:error, Tesla.Env.t}
  def sql(connection, body, opts \\ []) do
    optional_params = %{
      :"raw_response" => :query
    }
    %{}
    |> method(:post)
    |> url("/sql")
    |> add_param(:body, :body, body)
    |> add_optional_params(optional_params, opts)
    |> Enum.into([])
    |> (&Connection.request(connection, &1)).()
    |> evaluate_response([
      { 200, %{}}
      { :default, %Manticoresearch.Model.ErrorResponse{}}
    ])
  end
end
