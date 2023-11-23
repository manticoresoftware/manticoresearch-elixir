# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.EqualsFilter do
  @moduledoc """
  Equals attribute filter
  """

  @derive [Poison.Encoder]
  defstruct [
    :"field",
    :"value"
  ]

  @type t :: %__MODULE__{
    :"field" => String.t,
    :"value" => Map
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.EqualsFilter do
  def decode(value, _options) do
    value
  end
end

