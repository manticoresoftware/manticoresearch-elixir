# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.BulkResponse do
  @moduledoc """
  Success bulk response
  """

  @derive [Poison.Encoder]
  defstruct [
    :"items",
    :"errors",
    :"error"
  ]

  @type t :: %__MODULE__{
    :"items" => Map | nil,
    :"errors" => boolean() | nil,
    :"error" => String.t | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.BulkResponse do
  def decode(value, _options) do
    value
  end
end

