FROM elixir

RUN mix local.hex --force
RUN mix archive.install --force hex phx_new 1.5.9
RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash 
RUN apt-get install -y apt-utils
RUN apt-get install -y nodejs
RUN apt-get install -y build-essential
RUN apt-get install -y inotify-tools
RUN mix local.rebar --force

WORKDIR /app

COPY mix.exs mix.lock ./
COPY assets/package.json assets/package-lock.json ./assets/

RUN mix deps.get
RUN mix deps.compile
RUN npm install --prefix ./assets

COPY . ./