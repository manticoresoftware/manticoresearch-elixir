# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.UpdateDocumentRequest do
  @moduledoc """
  Payload for update document
  """

  @derive [Poison.Encoder]
  defstruct [
    :"index":"doc":"id":"query"
  ]

  @type t :: %__MODULE__{
    :"index" => String.t:"doc" => %{optional(String.t) => map()}:"id" => integer() | nil:"query" => %{optional(String.t) => map()} | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.UpdateDocumentRequest do
  def decode(value, _options) do
    value
  end
end

