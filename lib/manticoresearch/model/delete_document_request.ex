# Do not edit the class manually.

defmodule Manticoresearch.Model.DeleteDocumentRequest do
  @moduledoc """
  Payload for delete request. Documents can be deleted either one by one by specifying the document id or by providing a query object. For more information see  [Delete API](https://docs.manticoresearch.com/latest/html/http_reference/json_delete.html) 
  """

  @derive [Poison.Encoder]
  defstruct [
    :"index",
    :"id",
    :"query"
  ]

  @type t :: %__MODULE__{
    :"index" => String.t,
    :"id" => integer() | nil,
    :"query" => Map | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.DeleteDocumentRequest do
  def decode(value, _options) do
    value
  end
end

