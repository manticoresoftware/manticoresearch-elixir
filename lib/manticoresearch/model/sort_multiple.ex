# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.SortMultiple do
  @moduledoc """
  Query sort expression for multiple attributes
  """

  @derive [Poison.Encoder]
  defstruct [
    :"attrs",
    :"replace"
  ]

  @type t :: %__MODULE__{
    :"attrs" => %{optional(String.t) => Map},
    :"replace" => boolean()
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.SortMultiple do
  def decode(value, _options) do
    value
  end
end

