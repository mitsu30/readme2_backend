FROM ruby:3.2.2-slim

ENV TZ=Asia/Tokyo

RUN apt-get update && apt-get install -y \
    build-essential \
    default-libmysqlclient-dev && \
    rm -rf /var/lib/apt/list/* \
    && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && echo 'gem: --no-document' > ~/.gemrc \
    && mkdir /app

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
