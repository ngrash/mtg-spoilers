FROM elixir:1.5
MAINTAINER Nico Grashoff <mail@nicograshoff.de>
ARG MIX_ENV
ENV MIX_ENV ${MIX_ENV:-prod}
WORKDIR /usr/src/app/
RUN mix local.hex --force
RUN mix local.rebar --force
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -yq nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
ADD mix.* /usr/src/app/
RUN mix do deps.get, deps.compile
WORKDIR /usr/src/app/assets/
ADD ./assets/ /usr/src/app/assets
RUN npm install
RUN node /usr/src/app/assets/node_modules/brunch/bin/brunch build
WORKDIR /usr/src/app/
ADD . /usr/src/app/
RUN mix compile
VOLUME /usr/src/app/cards/
CMD mix phx.server
