FROM sashaegorov/docker-alpine-sinatra

WORKDIR /elementor
RUN gem install little-elementor
RUN gem install sinatra
COPY . /elementor

CMD ["ruby", "server.rb"]
