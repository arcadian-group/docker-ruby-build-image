FROM ruby:2.5.1

LABEL maintainer "Dylan Pinn <dylan@arcadiandigital.com.au>"

ENV DEBIAN_FRONTEND=noninteractive
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y build-essential libpq-dev nodejs cmake libcurl3-dev \
        default-mysql-client default-mysql-server redis-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Global install yarn package manager
RUN apt-get update && apt-get install -y curl apt-transport-https && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# Install AWS CLI
RUN apt-get update && apt-get install -y python-dev python-pip \
    && pip install awscli

RUN gem install bundler -v 1.16.2
