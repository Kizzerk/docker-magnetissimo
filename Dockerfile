FROM elixir:latest

RUN git clone https://github.com/sergiotapia/magnetissimo.git

VOLUME /magnetissimo

WORKDIR /magnetissimo

RUN mix local.hex --force && \
	mix deps.get && \
	mix local.rebar --force


COPY config/dev.exs /magnetissimo/config/dev.exs

CMD mix ecto.create && mix ecto.migrate && mix phoenix.server




