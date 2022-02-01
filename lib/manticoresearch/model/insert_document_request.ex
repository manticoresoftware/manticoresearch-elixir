# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.InsertDocumentRequest do
  @moduledoc """
  Object with document data. 
  """

  @derive [Poison.Encoder]
  defstruct [
    :"index",
    :"cluster",
    :"id",
    :"doc"
  ]

  @type t :: %__MODULE__{
    :"index" => String.t,
    :"cluster" => String.t | nil,
    :"id" => integer() | nil,
    :"doc" => %{optional(String.t) => map()}
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.InsertDocumentRequest do
  def decode(value, _options) do
    value
  end
end

