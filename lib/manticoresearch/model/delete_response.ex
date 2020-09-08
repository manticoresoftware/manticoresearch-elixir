# Do not edit the class manually.

defmodule Manticoresearch.Model.DeleteResponse do
  @moduledoc """
  Success response
  """

  @derive [Poison.Encoder]
  defstruct [
    :"_index",
    :"deleted",
    :"_id",
    :"result"
  ]

  @type t :: %__MODULE__{
    :"_index" => String.t | nil,
    :"deleted" => integer() | nil,
    :"_id" => integer() | nil,
    :"result" => String.t | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.DeleteResponse do
  def decode(value, _options) do
    value
  end
end

