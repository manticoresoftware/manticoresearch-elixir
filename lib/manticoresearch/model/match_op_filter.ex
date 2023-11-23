# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.MatchOpFilter do
  @moduledoc """
  Query match expression
  """

  @derive [Poison.Encoder]
  defstruct [
    :"query_string",
    :"query_fields",
    :"operator"
  ]

  @type t :: %__MODULE__{
    :"query_string" => String.t,
    :"query_fields" => String.t,
    :"operator" => String.t
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.MatchOpFilter do
  def decode(value, _options) do
    value
  end
end

