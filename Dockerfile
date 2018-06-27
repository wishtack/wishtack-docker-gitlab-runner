FROM node:9-stretch

# Https repositories support.
RUN apt-get update
RUN apt-get install apt-transport-https

RUN echo "deb https://toolbelt.heroku.com/ubuntu ./" > /etc/apt/sources.list.d/heroku.list
RUN wget -O- https://toolbelt.heroku.com/apt/release.key | apt-key add -

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list

RUN apt-get update
RUN apt-get install -y \
    google-chrome-stable \
    heroku-toolbelt \
    mongodb \
    python-dev \
    python-pip \
    redis-server \
    ruby-dev \
    rubygems \
    yarn

RUN gem install dpl
RUN heroku --version

RUN easy_install --upgrade pip
RUN easy_install virtualenv
# 2018.06.25 breaks pipenv update. Downgrading 🤢.
RUN pip install pipenv==2018.05.18
