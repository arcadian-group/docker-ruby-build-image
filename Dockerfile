FROM ruby:2.7

LABEL maintainer "Sean Gilmore <sean@arcadiandigital.com.au>"

ENV DEBIAN_FRONTEND=noninteractive
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
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
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

RUN gem install bundler -v 2.1.2
