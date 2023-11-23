# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.MatchFilter do
  @moduledoc """
  Query match filter
  """

  @derive [Poison.Encoder]
  defstruct [
    :"query_string",
    :"query_fields"
  ]

  @type t :: %__MODULE__{
    :"query_string" => String.t,
    :"query_fields" => String.t
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.MatchFilter do
  def decode(value, _options) do
    value
  end
end

