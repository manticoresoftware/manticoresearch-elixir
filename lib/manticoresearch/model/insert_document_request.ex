# Do not edit the class manually.

defmodule Manticoresearch.Model.InsertDocumentRequest do
  @moduledoc """
  Object with document data. 
  """

  @derive [Poison.Encoder]
  defstruct [
    :"index",
    :"id",
    :"doc"
  ]

  @type t :: %__MODULE__{
    :"index" => String.t,
    :"id" => integer() | nil,
    :"doc" => %{optional(String.t) => Map}
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.InsertDocumentRequest do
  def decode(value, _options) do
    value
  end
end

