FROM ruby:2.6.3
RUN mkdir /app
WORKDIR /app
COPY . /app
RUN gem install bundler:2.1.4 && bundle install
EXPOSE 3000

CMD ["rackup"]
