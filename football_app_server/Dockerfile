FROM elixir:latest

COPY . .

# Install Hex
RUN mix local.hex --force

# Get dependencies
RUN mix deps.get

RUN mix compile

CMD ["mix", "run", "--no-halt"]
