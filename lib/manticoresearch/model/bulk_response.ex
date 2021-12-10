# Do not edit the class manually.

defmodule Manticoresearch.Model.BulkResponse do
  @moduledoc """
  Success bulk response
  """

  @derive [Poison.Encoder]
  defstruct [
    :"items",
    :"error"
  ]

  @type t :: %__MODULE__{
    :"items" => Map | nil,
    :"error" => boolean() | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.BulkResponse do
  def decode(value, _options) do
    value
  end
end

