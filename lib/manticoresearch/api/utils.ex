# Do not edit the class manually.

defmodule Manticoresearch.Api.Utils do
  @moduledoc """
  API calls for all endpoints tagged `Utils`.
  """

  alias Manticoresearch.Connection
  import Manticoresearch.RequestBuilder


  @doc """
  Perform SQL requests
  Run a query in SQL format. Expects is a query parameters string that can be in two modes: * Select only query as `query=SELECT * FROM myindex`. The query string MUST be URL encoded * any type of query in format `mode=raw&query=SHOW TABLES`. The string must be as is (no URL encoding) and `mode` must be first. The response object depends on the query executed. In select mode the response has same format as `/search` operation. 

  ## Parameters

  - connection (Manticoresearch.Connection): Connection to server
  - body (String.t): Expects is a query parameters string that can be in two modes:    * Select only query as `query=SELECT * FROM myindex`. The query string MUST be URL encoded    * any type of query in format `mode=raw&query=SHOW TABLES`. The string must be as is (no URL encoding) and `mode` must be first. 
  - opts (KeywordList): [optional] Optional parameters
  ## Returns

  {:ok, %{}} on success
  {:error, info} on failure
  """
  @spec sql(Tesla.Env.client, String.t, keyword()) :: {:ok, map()} | {:error, Tesla.Env.t}
  def sql(connection, body, _opts \\ []) do
    %{}
    |> method(:post)
    |> url("/sql")
    |> add_param(:body, :body, body)
    |> Enum.into([])
    |> (&Connection.request(connection, &1)).()
    |> evaluate_response([
      { 200, %{}},
      { :default, %Manticoresearch.Model.ErrorResponse{}}
    ])
  end
end
