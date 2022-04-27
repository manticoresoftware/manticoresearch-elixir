# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

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
    :"aggs",
    :"expressions",
    :"highlight",
    :"_source",
    :"options",
    :"profile"
  ]

  @type t :: %__MODULE__{
    :"index" => String.t,
    :"query" => map(),
    :"limit" => integer() | nil,
    :"offset" => integer() | nil,
    :"max_matches" => integer() | nil,
    :"sort" => [map()] | nil,
    :"aggs" => %{optional(String.t) => AnyType} | nil,
    :"expressions" => map() | nil,
    :"highlight" => map() | nil,
    :"_source" => [String.t] | nil,
    :"options" => %{optional(String.t) => AnyType} | nil,
    :"profile" => boolean() | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.SearchRequest do
  import Manticoresearch.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:"aggs", :map, Manticoresearch.Model.AnyType, options)
    |> deserialize(:"options", :map, Manticoresearch.Model.AnyType, options)
  end
end

