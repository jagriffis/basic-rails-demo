FROM ruby:3.1.1
RUN apt-get update -qq \
  && apt-get install -y \
  # Needed for certain gems
  build-essential \
  # Needed for postgres gem
  libpq-dev \   
  # The following are used to trim down the size of the image by removing unneeded data
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf \
  /var/lib/apt \
  /var/lib/dpkg \
  /var/lib/cache \
  /var/lib/log
RUN mkdir /blog2
WORKDIR /blog2
COPY Gemfile /blog2/Gemfile
COPY Gemfile.lock /blog2/Gemfile.lock
RUN bundle install
ADD . /blog2
CMD bash -c "rm -f tmp/pids/server.pid && rails s -p 3000 -b '0.0.0.0'"