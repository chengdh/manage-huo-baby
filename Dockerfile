FROM ruby:1.9.3

# Install NodeJS and Yarn
RUN apt-get update
RUN apt-get -y install curl
RUN apt-get install -my gnupg
RUN apt-get -y install nodejs
RUN apt-get -y install build-essential libxml2-dev libxslt-dev libreadline-dev
RUN apt-get -y install imagemagick

# Install Ruby Gems and node modules

RUN mkdir /app
WORKDIR /app
COPY . /app/
RUN bundle install --jobs 5 --retry 5 --without development test
ENV RAILS_ENV production
ENV RACK_ENV production

# Execute the Procfile
# CMD ["bin/run-dev.sh"]
CMD ["bundle", "exec", "unicorn"]
