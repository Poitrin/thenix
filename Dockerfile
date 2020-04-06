FROM elixir
# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /tmp
RUN mix local.hex --force
# elixir -v
# RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez --force
RUN mix archive.install hex phx_new 1.4.16 --force

# Node
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - # sudo -E bash -
RUN apt-get install -y nodejs

# Live reload
RUN apt-get install -y inotify-tools

RUN mix local.rebar --force

WORKDIR /develop