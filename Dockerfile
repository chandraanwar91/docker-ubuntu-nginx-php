FROM ubuntu:18.04

MAINTAINER Seto Kuslaksono <kuslaksono@gmail.com>

# Surpress Upstart errors/warning
RUN dpkg-divert --local --rename --add /sbin/initctl \
    && ln -sf /bin/true /sbin/initctl

# Set timezone
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y tzdata
RUN cp /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# Install nginx and php
RUN apt-get update && apt-get install -y \
    php7.2 \
    php7.2-bcmath \
    php7.2-cli \
    php7.2-common \
    php7.2-curl \
    php7.2-dev \
    php7.2-fpm \
    php7.2-gd \
    php7.2-json \
    php7.2-mbstring \
    php7.2-mysql \
    php7.2-opcache \
    php7.2-readline \
    php7.2-sqlite3 \
    php7.2-xml \
    php7.2-zip \
    php-redis \
    php-mongodb \
    php-memcached \
    nginx \
    curl openssl supervisor

# Cleanup
RUN apt-get update \
    && apt-get upgrade -y
RUN apt-get remove --purge -y software-properties-common \
    build-essential
RUN apt-get autoremove -y
RUN apt-get clean
RUN apt-get autoclean