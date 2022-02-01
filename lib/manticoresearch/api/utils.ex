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
  Run a query in SQL format. Expects a query string passed through `body` parameter and optional `raw_response` parameter that defines a format of response. `raw_response` can be set to `False` for Select queries only, e.g., `SELECT * FROM myindex` The query string must be URL encoded if `raw_response` parameter is set to False The query string must be as is (no URL encoding) if `raw_response` parameter is set to True or omitted. The response object depends on the query executed. In select mode the response has same format as `/search` operation. 

  ## Parameters

  - connection (Manticoresearch.Connection): Connection to server
  - body (String.t): A query parameter string. The query string must be URL encoded if `raw_response` parameter is set to False The query string must be as is (no URL encoding) if `raw_response` parameter is set to True or omitted. 
  - opts (KeywordList): [optional] Optional parameters
    - :raw_response (boolean()): Optional parameter, defines a format of response. Can be set to `False` for Select only queries and set to `True` or omitted for any type of queries: 
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
      { 200, %{}},
      { :default, %Manticoresearch.Model.ErrorResponse{}}
    ])
  end
end
