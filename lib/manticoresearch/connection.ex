# Do not edit the class manually.

defmodule Manticoresearch.Connection do
  @moduledoc """
  Handle Tesla connections for Manticoresearch.
  """

  use Tesla

  # Add any middleware here (authentication)
  plug Tesla.Middleware.BaseUrl, Application.fetch_env!(:manticoresearch, :base_url)
  plug Tesla.Middleware.Headers, [{"user-agent", "Elixir"}]
  plug Tesla.Middleware.EncodeJson, engine: Poison

  @doc """
  Configure an authless client connection

  # Returns

  Tesla.Env.client
  """
  @spec new() :: Tesla.Env.client
  def new do
    Tesla.client([])
  end
end
