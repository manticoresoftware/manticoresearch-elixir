# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.RangeFilter do
  @moduledoc """
  Range attribute filter
  """

  @derive [Poison.Encoder]
  defstruct [
    :"field",
    :"lte",
    :"gte",
    :"lt",
    :"gt"
  ]

  @type t :: %__MODULE__{
    :"field" => String.t,
    :"lte" => float() | nil,
    :"gte" => float() | nil,
    :"lt" => float() | nil,
    :"gt" => float() | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.RangeFilter do
  def decode(value, _options) do
    value
  end
end

