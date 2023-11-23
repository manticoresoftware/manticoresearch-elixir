# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.AggregationTerms do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :"field",
    :"size"
  ]

  @type t :: %__MODULE__{
    :"field" => String.t | nil,
    :"size" => integer() | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.AggregationTerms do
  def decode(value, _options) do
    value
  end
end

