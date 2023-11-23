# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.SourceByRules do
  @moduledoc """
  Query fields to be included/excluded to/from response
  """

  @derive [Poison.Encoder]
  defstruct [
    :"includes",
    :"excludes"
  ]

  @type t :: %__MODULE__{
    :"includes" => [String.t],
    :"excludes" => [String.t]
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.SourceByRules do
  def decode(value, _options) do
    value
  end
end

