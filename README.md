# Manticore Elixir client

Сlient for Manticore Search. 

❗ WARNING: this is a development version of the client. The latest release's readme is https://github.com/manticoresoftware/manticoresearch-elixir/tree/5.0.0

## Requirements.

Minimum Manticore Search version is >= 4.0.2 with HTTP protocol enabled.

| **manticoresearch-elixir**  | **Manticore Search**                | **Elixir**     | **Compatibility**        |
| --------------------------- | ----------------------------------- | -------------- | ------------------------ |
| `dev`                       | `dev` (latest development version)  | 1.18 or newer  | ✅ Fully Compatible      |
| 5.0.0 or newer              | 28.6.6 or newer                     | 1.18 or newer  | ✅ Fully Compatible      |
| 5.0.0 or newer              | 4.2.1  to 28.6.6                    | 1.18 or newer  | ⚠️ Partially Compatible  |
| 4.0.0 to 5.0.0              | 4.2.1  to 28.6.6                    | 1.18 or newer  | ⚠️ Partially Compatible  |
| 4.0.0 to 5.0.0              | 4.0.2 to 4.2.1                      | 1.18 or newer  | ✅ Fully Compatible      |
| 2.0.0 to 4.0.0              | 4.2.1  to 28.6.6                    | 1.6 or newer   | ⚠️ Partially Compatible  |
| 2.0.0 to 4.0.0              | 4.0.2 to 4.2.1                      | 1.6 or newer   | ✅ Fully Compatible      |
| 1.0.0 to 2.0.0              | 4.2.1 to 28.6.6                     | 1.6 or newer   | ⚠️ Partially Compatible  |
| 1.0.0 to 2.0.0              | 4.0.2 to 4.2.1                      | 1.6 or newer   | ✅ Fully Compatible      |

## Building

To install the required dependencies and to build the elixir project, run:

```console
mix local.hex --force
mix do deps.get, compile
```

## Installation

The latest development version tracks the GitHub `dev` branch. Add this to your `mix.exs` dependencies:

```elixir
def deps do
  [{:manticoresearch,
    git: "https://github.com/manticoresoftware/manticoresearch-elixir.git",
    branch: "dev"}]
end
```

If a pre-release is published to Hex, you can also use `~> 5.0.0-dev`.

## Configuration

You can override the URL of your server (e.g. if you have a separate development and production server in your
configuration files).

```elixir
config :manticoresearch, base_url: "http://127.0.0.1:9308"
```

Multiple clients for the same API with different URLs can be created passing different `base_url`s when calling
`Manticoresearch.Connection.new/1`:

```elixir
client = Manticoresearch.Connection.new(base_url: "http://127.0.0.1:9308")
```

[exdoc]: https://github.com/elixir-lang/ex_doc
[hexdocs]: https://hexdocs.pm
[available in hex]: https://hex.pm/docs/publish
[docs]: https://hexdocs.pm/manticoresearch
