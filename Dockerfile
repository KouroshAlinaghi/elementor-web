FROM sashaegorov/docker-alpine-sinatra

WORKDIR /elementor
RUN gem install little-elementor -v 0.1.2
RUN gem install sinatra
COPY . /elementor

CMD ["ruby", "server.rb"]
