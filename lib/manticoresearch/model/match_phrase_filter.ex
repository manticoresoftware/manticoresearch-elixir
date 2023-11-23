# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.MatchPhraseFilter do
  @moduledoc """
  Query match expression
  """

  @derive [Poison.Encoder]
  defstruct [
    :"query_phrase",
    :"query_fields"
  ]

  @type t :: %__MODULE__{
    :"query_phrase" => String.t,
    :"query_fields" => String.t
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.MatchPhraseFilter do
  def decode(value, _options) do
    value
  end
end

