# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Api.Search do
  @moduledoc """
  API calls for all endpoints tagged `Search`.
  """

  alias Manticoresearch.Connection
  import Manticoresearch.RequestBuilder


  @doc """
  Perform reverse search on a percolate index
  Performs a percolate search.  This method must be used only on percolate indexes.  Expects two parameters: the index name and an object with array of documents to be tested. An example of the documents object:    ```   {     \"query\":     {       \"percolate\":       {         \"document\":         {           \"content\":\"sample content\"         }       }     }   }   ```  Responds with an object with matched stored queries:     ```   {     'timed_out':false,     'hits':     {       'total':2,       'max_score':1,       'hits':       [         {           '_index':'idx_pq_1',           '_type':'doc',           '_id':'2',           '_score':'1',           '_source':           {             'query':             {               'match':{'title':'some'}             }           }         },         {           '_index':'idx_pq_1',           '_type':'doc',           '_id':'5',           '_score':'1',           '_source':           {             'query':             {               'ql':'some | none'             }           }         }       ]     }   }   ``` 

  ## Parameters

  - connection (Manticoresearch.Connection): Connection to server
  - index (String.t): Name of the percolate index
  - percolate_request (PercolateRequest): 
  - opts (KeywordList): [optional] Optional parameters
  ## Returns

  {:ok, %Manticoresearch.Model.SearchResponse{}} on success
  {:error, info} on failure
  """
  @spec percolate(Tesla.Env.client, String.t, Manticoresearch.Model.PercolateRequest.t, keyword()) :: {:ok, Manticoresearch.Model.SearchResponse.t} | {:ok, Manticoresearch.Model.ErrorResponse.t} | {:error, Tesla.Env.t}
  def percolate(connection, index, percolate_request, _opts \\ []) do
    %{}
    |> method(:post)
    |> url("/pq/#{index}/search")
    |> add_param(:body, :body, percolate_request)
    |> Enum.into([])
    |> (&Connection.request(connection, &1)).()
    |> evaluate_response([
      { 200, %Manticoresearch.Model.SearchResponse{}},
      { :default, %Manticoresearch.Model.ErrorResponse{}}
    ])
  end

  @doc """
  Performs a search on an index
   The method expects an object with the following mandatory properties: * the name of the index to search * the match query object For details, see the documentation on [**SearchRequest**](SearchRequest.md) The method returns an object with the following properties: - took: the time taken to execute the search query. - timed_out: a boolean indicating whether the query timed out. - hits: an object with the following properties:    - total: the total number of hits found.    - hits: an array of hit objects, where each hit object represents a matched document. Each hit object has the following properties:      - _id: the ID of the matched document.      - _score: the score of the matched document.      - _source: the source data of the matched document.  In addition, if profiling is enabled, the response will include an additional array with profiling information attached. Here is an example search response:    ```   {     'took':10,     'timed_out':false,     'hits':     {       'total':2,       'hits':       [         {'_id':'1','_score':1,'_source':{'gid':11}},         {'_id':'2','_score':1,'_source':{'gid':12}}       ]     }   }   ```  For more information about the match query syntax and additional parameters that can be added to request and response, please see the documentation [here](https://manual.manticoresearch.com/Searching/Full_text_matching/Basic_usage#HTTP-JSON). 

  ## Parameters

  - connection (Manticoresearch.Connection): Connection to server
  - search_request (SearchRequest): 
  - opts (KeywordList): [optional] Optional parameters
  ## Returns

  {:ok, %Manticoresearch.Model.SearchResponse{}} on success
  {:error, info} on failure
  """
  @spec search(Tesla.Env.client, Manticoresearch.Model.SearchRequest.t, keyword()) :: {:ok, Manticoresearch.Model.SearchResponse.t} | {:ok, Manticoresearch.Model.ErrorResponse.t} | {:error, Tesla.Env.t}
  def search(connection, search_request, _opts \\ []) do
    %{}
    |> method(:post)
    |> url("/search")
    |> add_param(:body, :body, search_request)
    |> Enum.into([])
    |> (&Connection.request(connection, &1)).()
    |> evaluate_response([
      { 200, %Manticoresearch.Model.SearchResponse{}},
      { :default, %Manticoresearch.Model.ErrorResponse{}}
    ])
  end
end
