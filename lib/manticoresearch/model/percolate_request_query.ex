# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.PercolateRequestQuery do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :"percolate"
  ]

  @type t :: %__MODULE__{
    :"percolate" => map()
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.PercolateRequestQuery do
  def decode(value, _options) do
    value
  end
end

