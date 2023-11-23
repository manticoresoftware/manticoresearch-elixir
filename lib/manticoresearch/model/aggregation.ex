# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.Aggregation do
  @moduledoc """
  Aggregation Alias
  """

  @derive [Poison.Encoder]
  defstruct [
    :"terms",
    :"sort"
  ]

  @type t :: %__MODULE__{
    :"terms" => AggregationTerms | nil,
    :"sort" => [%{optional(String.t) => Map}] | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.Aggregation do
  import Manticoresearch.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:"terms", :struct, Manticoresearch.Model.AggregationTerms, options)
  end
end

