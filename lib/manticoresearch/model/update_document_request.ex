# Do not edit the class manually.

defmodule Manticoresearch.Model.UpdateDocumentRequest do
  @moduledoc """
  Payload for update document
  """

  @derive [Poison.Encoder]
  defstruct [
    :"index",
    :"doc",
    :"id",
    :"query"
  ]

  @type t :: %__MODULE__{
    :"index" => String.t,
    :"doc" => %{optional(String.t) => Map},
    :"id" => integer() | nil,
    :"query" => %{optional(String.t) => Map} | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.UpdateDocumentRequest do
  def decode(value, _options) do
    value
  end
end

