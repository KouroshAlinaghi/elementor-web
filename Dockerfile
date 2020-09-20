FROM sashaegorov/docker-alpine-sinatra

WORKDIR /elementor
RUN gem install little-elementor -v 0.1.3
RUN gem install sinatra rake rack-test
COPY . /elementor

CMD ["ruby", "server.rb"]
