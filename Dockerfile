FROM ubuntu:16.04

MAINTAINER Seto Kuslaksono <kuslaksono@gmail.com>

# Surpress Upstart errors/warning
RUN dpkg-divert --local --rename --add /sbin/initctl \
    && ln -sf /bin/true /sbin/initctl

# Install basic packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt update \
    && apt upgrade -y \
    && apt install -y tzdata \
        software-properties-common \
        python-software-properties

# Set timezone
RUN cp /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# Install nginx and php
RUN apt-add-repository -y ppa:nginx/stable
RUN LC_ALL=en_US.UTF-8 apt-add-repository -y ppa:ondrej/php
RUN apt update && apt install -y \
        nginx \
        php7.1 \
        php7.1-bcmath \
        php7.1-cli \
        php7.1-common \
        php7.1-ctype \
        php7.1-curl \
        php7.1-dev \
        php7.1-dom \
        php7.1-fpm \
        php7.1-gd \
        php7.1-intl \
        php7.1-json \
        php7.1-mbstring \
        php7.1-mongodb \
        php7.1-mcrypt \
        php7.1-mysql \
        php7.1-opcache \
        php7.1-phar \
        php7.1-readline \
        php7.1-redis \
        php7.1-simplexml \
        php7.1-tokenizer \
        php7.1-xml \
        php7.1-zip \
        php-redis \
        php-memcached \
        curl openssl supervisor

# Cleanup
RUN apt-get remove --purge -y software-properties-common \
    python-software-properties
RUN apt-get autoremove -y
RUN apt-get clean
RUN apt-get autoclean