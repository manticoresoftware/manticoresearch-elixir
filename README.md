# Manticoresearch

Experimental low-level client for Manticore Search. 

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


Documentation available at [HexDocs](https://hexdocs.pm/manticoresearch).
