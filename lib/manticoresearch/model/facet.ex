# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.Facet do
  @moduledoc """
  Query FACET expression
  """

  @derive [Poison.Encoder]
  defstruct [
    :"attr",
    :"alias",
    :"limit"
  ]

  @type t :: %__MODULE__{
    :"attr" => String.t,
    :"alias" => String.t | nil,
    :"limit" => integer() | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.Facet do
  def decode(value, _options) do
    value
  end
end

