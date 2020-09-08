# Do not edit the class manually.

defmodule Manticoresearch.Model.SearchResponseHits do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :"total",
    :"hits"
  ]

  @type t :: %__MODULE__{
    :"total" => integer() | nil,
    :"hits" => [Map] | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.SearchResponseHits do
  def decode(value, _options) do
    value
  end
end

