# Dockerfile
# Use uma imagem base apropriada para Ruby
FROM ruby:3.1.0

# Define os argumentos para as opções não interativas
ARG DEBIAN_FRONTEND=noninteractive

# Instala as dependências necessárias
RUN apt-get update -qq && apt-get install -y \
  curl \
  git \
  nodejs \
  build-essential \
  libssl-dev \
  libreadline-dev \
  zlib1g-dev \
  libsqlite3-dev \
  sqlite3 \
  libpq-dev

# Define o diretório de trabalho
WORKDIR /app

# Copia os arquivos do Gemfile e Gemfile.lock
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Instala as gems necessárias
RUN gem install bundler && bundle install

# Copia todo o código da aplicação
COPY . /app

# Copia o script interativo para o contêiner
COPY send_message_interactive.rb /app/send_message_interactive.rb

# Expõe a porta 3000
EXPOSE 3000

# Comando para iniciar o servidor Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
