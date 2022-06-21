# Setup ruby
FROM ruby:3.1.1 AS ruby-base

# Install apt based dependencies
RUN apt-get update -qq --fix-missing \
  && apt-get install -y --no-install-recommends postgresql-client \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set ENV
ARG RAILS_ENV
ENV RAILS_ENV ${RAILS_ENV:-development}

ENV APP_DIR /app
RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the main application.
COPY . $APP_DIR

# Start server
EXPOSE 3000
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
