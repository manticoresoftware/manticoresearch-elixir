# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.MatchOp do
  @moduledoc """
  Query match expression with logical operator
  """

  @derive [Poison.Encoder]
  defstruct [
    :"query_info"
  ]

  @type t :: %__MODULE__{
    :"query_info" => Map
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.MatchOp do
  def decode(value, _options) do
    value
  end
end

