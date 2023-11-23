# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.SortOrder do
  @moduledoc """
  Query sort expression
  """

  @derive [Poison.Encoder]
  defstruct [
    :"attr",
    :"order"
  ]

  @type t :: %__MODULE__{
    :"attr" => String.t,
    :"order" => String.t
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.SortOrder do
  def decode(value, _options) do
    value
  end
end

