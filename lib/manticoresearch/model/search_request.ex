# Do not edit the class manually.

defmodule Manticoresearch.Model.SearchRequest do
  @moduledoc """
  Payload for search operation
  """

  @derive [Poison.Encoder]
  defstruct [
    :"index",
    :"query",
    :"limit",
    :"offset",
    :"max_matches",
    :"sort",
    :"script_fields",
    :"highlight",
    :"_source",
    :"profile"
  ]

  @type t :: %__MODULE__{
    :"index" => String.t,
    :"query" => %{optional(String.t) => Map},
    :"limit" => integer() | nil,
    :"offset" => integer() | nil,
    :"max_matches" => integer() | nil,
    :"sort" => [Map] | nil,
    :"script_fields" => Map | nil,
    :"highlight" => Map | nil,
    :"_source" => [String.t] | nil,
    :"profile" => boolean() | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.SearchRequest do
  def decode(value, _options) do
    value
  end
end

