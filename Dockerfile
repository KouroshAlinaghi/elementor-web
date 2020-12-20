FROM ruby:2.7-alpine3.12

WORKDIR /ttt
RUN bundle install
COPY . /ttt

CMD ["ruby", "main.rb"]
