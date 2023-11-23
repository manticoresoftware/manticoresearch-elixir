# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.GeoDistanceFilterLocationAnchor do
  @moduledoc """
  Geo pin point object
  """

  @derive [Poison.Encoder]
  defstruct [
    :"lat",
    :"lon"
  ]

  @type t :: %__MODULE__{
    :"lat" => float() | nil,
    :"lon" => float() | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.GeoDistanceFilterLocationAnchor do
  def decode(value, _options) do
    value
  end
end

