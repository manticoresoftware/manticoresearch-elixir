# Do not edit the class manually.

defmodule Manticoresearch.Model.SuccessResponse do
  @moduledoc """
  Success response
  """

  @derive [Poison.Encoder]
  defstruct [
    :"_index",
    :"_id",
    :"created",
    :"result",
    :"found"
  ]

  @type t :: %__MODULE__{
    :"_index" => String.t | nil,
    :"_id" => integer() | nil,
    :"created" => boolean() | nil,
    :"result" => String.t | nil,
    :"found" => boolean() | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.SuccessResponse do
  def decode(value, _options) do
    value
  end
end

