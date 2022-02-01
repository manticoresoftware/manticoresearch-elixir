# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.SearchResponse do
  @moduledoc """
  Response object of a search request
  """

  @derive [Poison.Encoder]
  defstruct [
    :"took",
    :"timed_out",
    :"aggregations",
    :"hits",
    :"profile",
    :"warning"
  ]

  @type t :: %__MODULE__{
    :"took" => integer() | nil,
    :"timed_out" => boolean() | nil,
    :"aggregations" => %{optional(String.t) => map()} | nil,
    :"hits" => Manticoresearch.Model.SearchResponseHits.t | nil,
    :"profile" => map() | nil,
    :"warning" => %{optional(String.t) => map()} | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.SearchResponse do
  import Manticoresearch.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:"hits", :struct, Manticoresearch.Model.Manticoresearch.Model.SearchResponseHits.t, options)
  end
end

