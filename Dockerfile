FROM ruby:2.7.1

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

RUN curl -O https://nodejs.org/download/release/v14.5.0/node-v14.5.0-linux-x64.tar.gz
RUN tar xf node-v14.5.0-linux-x64.tar.gz
RUN mv node-v14.5.0-linux-x64/bin/* /usr/bin/

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get upgrade
RUN apt-get install -y postgresql-client
RUN apt-get install -y --no-install-recommends yarn

RUN mkdir /myapp
WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle config set path 'vendor/bundle'
RUN bundle install

COPY package.json /myapp/package.json
COPY yarn.lock /myapp/yarn.lock 
RUN yarn install --check-files

COPY . /myapp

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
