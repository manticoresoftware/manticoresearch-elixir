# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.FilterString do
  @moduledoc """
  Query filter
  """

  @derive [Poison.Encoder]
  defstruct [
    :"filter_field",
    :"operation",
    :"filter_value"
  ]

  @type t :: %__MODULE__{
    :"filter_field" => String.t,
    :"operation" => String.t,
    :"filter_value" => String.t
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.FilterString do
  def decode(value, _options) do
    value
  end
end

