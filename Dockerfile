FROM ubuntu:22.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y  \
curl \
build-essential \
postgresql \
postgresql-contrib \
postgresql-client \
libxml2-dev \
libxslt-dev \
nodejs \
yarn \
libpq-dev \
git \
gnupg2

RUN curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
RUN curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -
RUN curl -L https://get.rvm.io | bash -s stable
RUN echo "source /usr/local/rvm/scripts/rvm" >> ~/.bashrc
SHELL ["/bin/bash", "-lc"]
RUN rvm install 3.2.2  && rvm use --default 3.2.2
RUN mkdir /app
WORKDIR /app
COPY . /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle config --global silence_root_warning 1
RUN bundle install
EXPOSE 3000 3000

CMD bundle exec rake environment db:create
CMD bundle exec rake environment db:migrate
CMD bundle exec puma -C config/puma.rb
