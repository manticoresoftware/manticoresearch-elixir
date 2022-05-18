# Manticoresearch

Low-level client for Manticore Search. 

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

## Requirements

| Manticore Search  | manticoresearch-elixir |     Elixir    |
| ----------------- | ---------------------- | ------------- |
| >= 4.2.1          | 2.0.x                  | >= 2.0        |
| >= 4.0.2          | 1.0.x                  | >= 2.0        |

Documentation available at [HexDocs](https://hexdocs.pm/manticoresearch).
