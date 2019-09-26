FROM elixir:latest

COPY . .

# Install hex
RUN mix local.hex --force

# Install rebar
RUN mix local.rebar --force

# Get dependencies
RUN mix deps.get

RUN mix compile

CMD ["mix", "run", "--no-halt"]
