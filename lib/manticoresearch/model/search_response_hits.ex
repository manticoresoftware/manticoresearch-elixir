# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.SearchResponseHits do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :"max_score",
    :"total",
    :"total_relation",
    :"hits"
  ]

  @type t :: %__MODULE__{
    :"max_score" => integer() | nil,
    :"total" => integer() | nil,
    :"total_relation" => String.t | nil,
    :"hits" => [Map] | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.SearchResponseHits do
  def decode(value, _options) do
    value
  end
end

