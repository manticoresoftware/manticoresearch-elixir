# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.InFilter do
  @moduledoc """
  In attribute filter
  """

  @derive [Poison.Encoder]
  defstruct [
    :"field",
    :"values"
  ]

  @type t :: %__MODULE__{
    :"field" => String.t,
    :"values" => [Map]
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.InFilter do
  def decode(value, _options) do
    value
  end
end

