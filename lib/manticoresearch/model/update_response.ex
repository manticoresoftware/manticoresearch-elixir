# Do not edit the class manually.

defmodule Manticoresearch.Model.UpdateResponse do
  @moduledoc """
  Success response
  """

  @derive [Poison.Encoder]
  defstruct [
    :"_index",
    :"updated",
    :"_id",
    :"result"
  ]

  @type t :: %__MODULE__{
    :"_index" => String.t | nil,
    :"updated" => integer() | nil,
    :"_id" => integer() | nil,
    :"result" => String.t | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.UpdateResponse do
  def decode(value, _options) do
    value
  end
end

