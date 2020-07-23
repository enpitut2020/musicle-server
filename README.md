# musicle-server

## Init

1. Install Docker Compose
   https://docs.docker.com/compose/install/

2. `$ docker-compose build`
3. `$ docker-compose run web rake db:create`
4. `$ docker-compose run web rails db:migrate RAILS_ENV=development`

## Start

`$ docker-compose up`

## End

`$ docker-compose down`

## Deploy

1. `$ heroku container:login`
2. `$ heroku container:push web`
3. `$ heroku container:release web`
4. `$ heroku run bundle exec rails db:migrate`
