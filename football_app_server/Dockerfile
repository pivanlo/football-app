FROM elixir:latest

COPY . .

# Install Hex
RUN mix local.hex --force

RUN mix compile

#CMD ["mix", "run", "--no-halt"]
CMD ["elixir", "--sname", "hello", "--cookie", "monster", "-S", "mix", "run", "--no-halt"]