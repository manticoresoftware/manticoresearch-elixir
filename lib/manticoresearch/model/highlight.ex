# Manticore Search Client
# Copyright (c) 2020-2021, Manticore Software LTD (https://manticoresearch.com)
#
# All rights reserved

# Do not edit the class manually.

defmodule Manticoresearch.Model.Highlight do
  @moduledoc """
  Query HIGHLIGHT expression
  """

  @derive [Poison.Encoder]
  defstruct [
    :"fieldnames",
    :"fields",
    :"encoder",
    :"highlight_query",
    :"pre_tags",
    :"post_tags",
    :"no_match_size",
    :"fragment_size",
    :"number_of_fragments",
    :"limit",
    :"limit_words",
    :"limit_snippets",
    :"limits_per_field",
    :"use_boundaries",
    :"force_all_words",
    :"allow_empty",
    :"emit_zones",
    :"force_snippets",
    :"around",
    :"start_snippet_id",
    :"html_strip_mode",
    :"snippet_boundary"
  ]

  @type t :: %__MODULE__{
    :"fieldnames" => [String.t] | nil,
    :"fields" => [HighlightField] | nil,
    :"encoder" => String.t | nil,
    :"highlight_query" => %{optional(String.t) => Map} | nil,
    :"pre_tags" => String.t | nil,
    :"post_tags" => String.t | nil,
    :"no_match_size" => integer() | nil,
    :"fragment_size" => integer() | nil,
    :"number_of_fragments" => integer() | nil,
    :"limit" => integer() | nil,
    :"limit_words" => integer() | nil,
    :"limit_snippets" => integer() | nil,
    :"limits_per_field" => boolean() | nil,
    :"use_boundaries" => boolean() | nil,
    :"force_all_words" => boolean() | nil,
    :"allow_empty" => boolean() | nil,
    :"emit_zones" => boolean() | nil,
    :"force_snippets" => boolean() | nil,
    :"around" => integer() | nil,
    :"start_snippet_id" => integer() | nil,
    :"html_strip_mode" => String.t | nil,
    :"snippet_boundary" => String.t | nil
  }
end

defimpl Poison.Decoder, for: Manticoresearch.Model.Highlight do
  import Manticoresearch.Deserializer
  def decode(value, options) do
    value
    |> deserialize(:"fields", :list, Manticoresearch.Model.HighlightField, options)
  end
end

