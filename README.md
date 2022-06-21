# Dockerize Guide

- [Dockerize Guide](#dockerize-guide)
  - [Usage for Rails App](#usage-for-rails-app)
  - [Rails App](#rails-app)
    - [Docker Compose](#docker-compose)
    - [Configuring the Application to Work with PostgreSQL and Redis](#configuring-the-application-to-work-with-postgresql-and-redis)
    - [Configuring the testing](#configuring-the-testing)
## Usage for Rails App

Steps

1. [Clone the project and adding dependencies]
2. [Configuring DB](#configuring-the-application-to-work-with-postgresql-and-redis)
3. [Dockerize]
4. [Defining services with Docker Compose]
5. [Testing](#configuring-the-testing)

## Rails App

```sh
# 1. Create a docker image
docker build -t rails-toolbox -f Dockerfile.rails .

# 2. Create a Rails app using image from step 1
# -it: attaches your terminal process with the container.
# -v $PWD:/opt/app: binds your host machine current directory to the container, so files created inside are visible in your machine
# rails new --skip-bundle APP_NAME: That’s the command we’re passing to the Rails image. It creates a new project called APP_NAME.
docker run -it -v $PWD:/opt/app rails-toolbox rails new APP_NAME -c tailwind -d postgresql

# Docker run starts a new container and runs a program inside:


# Setup Gemfile, config files,
# Read below
```

### Docker Compose

Short description

* Postgres and Redis use Docker volumes to manage persistence
* Postgres, Redis and `APP` all expose a port
* `APP` and Sidekiq both have links to Postgres and Redis.
* `APP` and Sidekiq both read in environment variables from .env
* Sidekiq overwrites the default CMD to run Sidekiq instead of Unicorn.

Create volumes

```sh
  docker volume create --name app-postgres
  docker volume create --name app-redis
```

Run everything

```sh
  docker compose up --build
```

Initialize the Database

```sh
  docker­ compose run app rake db:reset
  docker­ compose run app rake db:migrate
```

Run
`docker compose up`

### Configuring the Application to Work with PostgreSQL and Redis

To work with PostgreSQL and Redis in development, we will want to do the following:

* Configure the application to work with PostgreSQL as the default adapter.
* Add an `.env` file to the project with our database username and password and Redis host.
* Create an `init.sql` script to create a sammy user for the database.
* Add an initializer for Sidekiq so that it can work with our containerized redis service.
* Add the `.env` file and other relevant files to the project’s gitignore and `dockerignore` files.
* Create database seeds so that our application has some records for us to work with when we start it up.

### Configuring the testing

[Setup RSpec on a fresh Rails 7 project](https://dev.to/adrianvalenz/setup-rspec-on-a-fresh-rails-7-project-5gp)

```sh
# RSpec
# group :development, :test do
#   gem "debug", platforms: %i[ mri mingw x64_mingw ]
#   gem "rspec-rails"
#   gem "factory_bot_rails"
#   gem "faker"
# end

bundle install
rails generate rspec:install
# when we generate model, it will generate spec too
# RSpec also provide its own spec file generators
rails generate rspec:model user
# List all RSpec generators
rails g --help | grep rspec
  # rspec:channel
  # rspec:controller
  # rspec:feature
  # rspec:generator
  # rspec:helper
  # rspec:install
  # rspec:integration
  # rspec:job
  # rspec:mailbox
  # rspec:mailer
  # rspec:model
  # rspec:request
  # rspec:scaffold
  # rspec:system
  # rspec:view

# add rspec into /bin folder
bundle binstub rspec-core
rspec --init # Similar with initial step in LOC 96

```
