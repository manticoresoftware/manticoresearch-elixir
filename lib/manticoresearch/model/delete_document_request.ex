# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.DeleteDocumentRequest do
  @moduledoc """
  Payload for delete request. Documents can be deleted either one by one by specifying the document id or by providing a query object. For more information see  [Delete API](https://manual.manticoresearch.com/Deleting_documents) 
  """

  @derive [Poison.Encoder]
  defstruct [
    :"index",
    :"cluster",
    :"id",
    :"query"
  ]

  @type t :: %__MODULE__{
    :"index" => String.t,
    :"cluster" => String.t | nil,
    :"id" => integer() | nil,
    :"query" => map() | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.DeleteDocumentRequest do
  def decode(value, _options) do
    value
  end
end

