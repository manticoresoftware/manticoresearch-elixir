# Do not edit the class manually.

defmodule Manticoresearch.Model.ErrorResponse do
  @moduledoc """
  Error response
  """

  @derive [Poison.Encoder]
  defstruct [
    :"error",
    :"status"
  ]

  @type t :: %__MODULE__{
    :"error" => %{optional(String.t) => Map},
    :"status" => integer()
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.ErrorResponse do
  def decode(value, _options) do
    value
  end
end

