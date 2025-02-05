# Manticoresearch

Сlient for Manticore Search. 

❗ WARNING: this is a development version of the client. The latest release's readme is https://github.com/manticoresoftware/manticoresearch-elixir/tree/4.0.0

### Building

To install the required dependencies and to build the elixir project, run:
```
mix local.hex --force
mix do deps.get, compile
```

## Installation

Add  `manticoresearch` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:manticoresearch, "~> 0.1.0"}]
end
```

## Compatibility table

| **manticoresearch-elixir** | **Manticore Search**  | **Elixir** | **Compatibility**       |
| ---------------------------| --------------------- | -----------| ------------------------|
| 4.0.0                      | Worked with 6.2.0     | v1.15.0    | ✅ Fully Compatible     |
| 2.0.0 to 4.0.0             | 4.2.1 to 6.2.0        | v1.13.0    | ✅ Fully Compatible     |
| 1.0.0 to 2.0.0             | 4.2.1 to 6.2.0        | v1.13.0    | ⚠️ Partially Compatible |
| 1.0.0 to 2.0.0             | 4.0.2 to 4.2.1        | v1.12.0    | ✅ Fully Compatible     |


Documentation available at [HexDocs](https://hexdocs.pm/manticoresearch).
