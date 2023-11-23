# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.BoolFilter do
  @moduledoc """
  Boolean attribute filter
  """

  @derive [Poison.Encoder]
  defstruct [
    :"should",
    :"must",
    :"must_not"
  ]

  @type t :: %__MODULE__{
    :"should" => [Map] | nil,
    :"must" => [Map] | nil,
    :"must_not" => [Map] | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.BoolFilter do
  def decode(value, _options) do
    value
  end
end

