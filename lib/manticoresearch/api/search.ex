# Do not edit the class manually.

defmodule Manticoresearch.Api.Search do
  @moduledoc """
  API calls for all endpoints tagged `Search`.
  """

  alias Manticoresearch.Connection
  import Manticoresearch.RequestBuilder


  @doc """
  Perform reverse search on a percolate index
  Performs a percolate search.  This method must be used only on percolate indexes.  Expects two paramenters: the index name and an object with array of documents to be tested. An example of the documents object:    ```   {\"query\":{\"percolate\":{\"document\":{\"content\":\"sample content\"}}}}   ```  Responds with an object with matched stored queries:     ```   {'timed_out':false,'hits':{'total':2,'max_score':1,'hits':[{'_index':'idx_pq_1','_type':'doc','_id':'2','_score':'1','_source':{'query':{'match':{'title':'some'},}}},{'_index':'idx_pq_1','_type':'doc','_id':'5','_score':'1','_source':{'query':{'ql':'some | none'}}}]}}   ``` 

  ## Parameters

  - connection (Manticoresearch.Connection): Connection to server
  - index (String.t): Name of the percolate index
  - percolate_request (PercolateRequest): 
  - opts (KeywordList): [optional] Optional parameters
  ## Returns

  {:ok, %Manticoresearch.Model.SearchResponse{}} on success
  {:error, info} on failure
  """
  @spec percolate(Tesla.Env.client, String.t, Manticoresearch.Model.PercolateRequest.t, keyword()) :: {:ok, Manticoresearch.Model.SearchResponse.t} | {:error, Tesla.Env.t}
  def percolate(connection, index, percolate_request, _opts \\ []) do
    %{}
    |> method(:post)
    |> url("/json/pq/#{index}/search")
    |> add_param(:body, :body, percolate_request)
    |> Enum.into([])
    |> (&Connection.request(connection, &1)).()
    |> evaluate_response([
      { 200, %Manticoresearch.Model.SearchResponse{}},
      { :default, %Manticoresearch.Model.ErrorResponse{}}
    ])
  end

  @doc """
  Performs a search
   Expects an object with mandatory properties: * the index name * the match query object Example :    ```   {'index':'movies','query':{'bool':{'must':[{'query_string':' movie'}]}},'script_fields':{'myexpr':{'script':{'inline':'IF(rating>8,1,0)'}}},'sort':[{'myexpr':'desc'},{'_score':'desc'}],'profile':true}   ```  It responds with an object with: - time of execution - if the query timed out - an array with hits (matched documents) - additional, if profiling is enabled, an array with profiling information is attached     ```   {'took':10,'timed_out':false,'hits':{'total':2,'hits':[{'_id':'1','_score':1,'_source':{'gid':11}},{'_id':'2','_score':1,'_source':{'gid':12}}]}}   ```  For more information about the match query syntax, additional paramaters that can be set to the input and response, please check: https://docs.manticoresearch.com/latest/html/http_reference/json_search.html. 

  ## Parameters

  - connection (Manticoresearch.Connection): Connection to server
  - search_request (SearchRequest): 
  - opts (KeywordList): [optional] Optional parameters
  ## Returns

  {:ok, %Manticoresearch.Model.SearchResponse{}} on success
  {:error, info} on failure
  """
  @spec search(Tesla.Env.client, Manticoresearch.Model.SearchRequest.t, keyword()) :: {:ok, Manticoresearch.Model.SearchResponse.t} | {:error, Tesla.Env.t}
  def search(connection, search_request, _opts \\ []) do
    %{}
    |> method(:post)
    |> url("/json/search")
    |> add_param(:body, :body, search_request)
    |> Enum.into([])
    |> (&Connection.request(connection, &1)).()
    |> evaluate_response([
      { 200, %Manticoresearch.Model.SearchResponse{}},
      { :default, %Manticoresearch.Model.ErrorResponse{}}
    ])
  end
end
