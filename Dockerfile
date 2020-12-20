FROM ruby:2.7-alpine3.12

WORKDIR /ttt
RUN gem install little-elementor -v 0.2.0 && gem install sinatra 
COPY . /ttt

CMD ["ruby", "main.rb"]
