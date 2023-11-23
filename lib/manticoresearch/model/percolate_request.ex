# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.PercolateRequest do
  @moduledoc """
  Object with documents to percolate
  """

  @derive [Poison.Encoder]
  defstruct [
    :"query"
  ]

  @type t :: %__MODULE__{
    :"query" => %{optional(String.t) => Map}
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.PercolateRequest do
  def decode(value, _options) do
    value
  end
end

