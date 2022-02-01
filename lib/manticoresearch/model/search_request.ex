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
    :"profile"
  ]

  @type t :: %__MODULE__{
    :"index" => String.t,
    :"query" => %{optional(String.t) => map()},
    :"limit" => integer() | nil,
    :"offset" => integer() | nil,
    :"max_matches" => integer() | nil,
    :"sort" => [map()] | nil,
    :"aggs" => %{optional(String.t) => map()} | nil,
    :"expressions" => map() | nil,
    :"highlight" => map() | nil,
    :"_source" => [String.t] | nil,
    :"profile" => boolean() | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.SearchRequest do
  def decode(value, _options) do
    value
  end
end

