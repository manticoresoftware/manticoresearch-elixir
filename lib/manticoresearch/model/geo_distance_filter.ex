# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.GeoDistanceFilter do
  @moduledoc """
  Geo distance attribute filter
  """

  @derive [Poison.Encoder]
  defstruct [
    :"location_anchor",
    :"location_source",
    :"distance_type",
    :"distance"
  ]

  @type t :: %__MODULE__{
    :"location_anchor" => GeoDistanceFilterLocationAnchor | nil,
    :"location_source" => String.t | nil,
    :"distance_type" => String.t | nil,
    :"distance" => String.t | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.GeoDistanceFilter do
  import Manticoresearch.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:"location_anchor", :struct, Manticoresearch.Model.GeoDistanceFilterLocationAnchor, options)
  end
end

