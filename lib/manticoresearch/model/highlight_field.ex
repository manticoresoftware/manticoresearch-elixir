# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.HighlightField do
  @moduledoc """
  Query Highlight field with options set
  """

  @derive [Poison.Encoder]
  defstruct [
    :"name",
    :"limit",
    :"limit_words",
    :"limit_snippets"
  ]

  @type t :: %__MODULE__{
    :"name" => String.t,
    :"limit" => integer() | nil,
    :"limit_words" => integer() | nil,
    :"limit_snippets" => integer() | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.HighlightField do
  def decode(value, _options) do
    value
  end
end

