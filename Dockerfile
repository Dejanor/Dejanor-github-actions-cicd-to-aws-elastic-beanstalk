FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Update and install basic dependencies
RUN apt-get update && apt-get install -y \
    apache2 \
    wget \
    lsb-release \
    software-properties-common \
    apt-transport-https \
    gnupg2 \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add PHP repository and update
RUN add-apt-repository ppa:ondrej/php && apt-get update

# Install PHP and other required packages
RUN apt-get install -y \
    libapache2-mod-php8.1 \
    php8.1 \
    php8.1-common \
    php8.1-xml \
    php8.1-gd \
    php8.1-opcache \
    php8.1-mbstring \
    php8.1-tokenizer \
    php8.1-json \
    php8.1-bcmath \
    php8.1-zip \
    unzip \
    curl \
    php8.1-curl \
    zip \
    php8.1-mysql \
    vim \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 80

WORKDIR /var/www/html/

COPY ./laravel-realworld-example-app /var/www/html/laravel-realworld-example-app
COPY ./.env.example /var/www/html/laravel-realworld-example-app/.env
COPY ./php.ini /etc/php/8.1/apache2/php.ini

RUN chown -R www-data:www-data /var/www/html/laravel-realworld-example-app/ \
    && chmod -R 775 /var/www/html/laravel-realworld-example-app/

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

WORKDIR /var/www/html/laravel-realworld-example-app/

RUN update-alternatives --set php /usr/bin/php8.1
RUN composer create-project

COPY ./web.php /var/www/html/laravel-realworld-example-app/routes/web.php
COPY ./laravel.conf /etc/apache2/sites-available/laravel.conf

RUN a2enmod rewrite \
    && a2dissite 000-default.conf \
    && a2ensite laravel.conf \
    && service apache2 restart

CMD [ "/usr/sbin/apachectl", "-D", "FOREGROUND" ]
