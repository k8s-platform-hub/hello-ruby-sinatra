FROM ruby:2.2.2

RUN apt-get update && \
    apt-get install -y net-tools

# Install gems
ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
RUN bundle install

# Upload source
COPY src $APP_HOME

# Start server
ENV PORT 8080
EXPOSE 8080
CMD ["ruby", "app.rb", "-s", "Puma"]
