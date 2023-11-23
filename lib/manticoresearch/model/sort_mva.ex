# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.SortMva do
  @moduledoc """
  Query sort expression for MVA attributes
  """

  @derive [Poison.Encoder]
  defstruct [
    :"attr",
    :"order",
    :"mode"
  ]

  @type t :: %__MODULE__{
    :"attr" => String.t,
    :"order" => String.t,
    :"mode" => String.t
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.SortMva do
  def decode(value, _options) do
    value
  end
end

