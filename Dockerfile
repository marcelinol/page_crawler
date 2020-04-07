FROM ruby:2.7

RUN apt-get update && \
    apt-get install -y net-tools

RUN apt-get install -y x11vnc xvfb fluxbox wget

RUN apt-get update && apt-get install -y firefox-esr wget

# Required by sinatra gem
#RUN apt-get install ruby-dev build-essential

ADD . /crawler
WORKDIR /crawler
RUN bundle install

# Install geckodriver
RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.24.0/geckodriver-v0.24.0-linux64.tar.gz
RUN tar -xvzf geckodriver-v0.24.0-linux64.tar.gz
RUN chmod +x geckodriver
ENV PATH=$PATH:./
RUN echo $PATH


# To debug sinatra app
RUN apt-get install screen
RUN apt install vim -y

CMD ["rackup"]