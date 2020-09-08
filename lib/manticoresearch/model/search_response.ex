# Do not edit the class manually.

defmodule Manticoresearch.Model.SearchResponse do
  @moduledoc """
  Response object of a search request
  """

  @derive [Poison.Encoder]
  defstruct [
    :"took",
    :"timed_out",
    :"hits",
    :"profile"
  ]

  @type t :: %__MODULE__{
    :"took" => integer() | nil,
    :"timed_out" => boolean() | nil,
    :"hits" => SearchResponseHits | nil,
    :"profile" => Map | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.SearchResponse do
  import Manticoresearch.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:"hits", :struct, Manticoresearch.Model.SearchResponseHits, options)
  end
end

