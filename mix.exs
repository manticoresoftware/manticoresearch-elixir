defmodule Manticoresearch.Mixfile do
  use Mix.Project

  def project do
    [app: :manticoresearch,
     description: "Manticore Search client",
     version: "1.0.0",
     elixir: "~> 1.6",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package(),
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:tesla, "~> 1.2"},
      {:poison, "~> 3.0"},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false}
    ]
  end
  defp package() do
    [
      files: ~w(lib  mix.exs README* config),
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/manticoresoftware/manticoresearch-elixir"}
    ]
  end
end
