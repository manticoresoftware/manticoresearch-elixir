# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.QueryFilter do
  @moduledoc """
  Query string filter
  """

  @derive [Poison.Encoder]
  defstruct [
    :"query_string"
  ]

  @type t :: %__MODULE__{
    :"query_string" => String.t
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.QueryFilter do
  def decode(value, _options) do
    value
  end
end

