FROM php:8.1-apache
ENV APACHE_DOCUMENT_ROOT=/var/www/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN a2enmod rewrite
RUN apt-get update && apt-get install -y libzip-dev zip && docker-php-ext-install zip && docker-php-ext-install bcmath && docker-php-ext-install pdo_mysql
RUN apt-get install -y locales locales-all
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev libwebp-dev
RUN apt-get install -y libxml2-dev
RUN docker-php-ext-install soap
RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp
RUN docker-php-ext-install gd
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
WORKDIR /var/www
VOLUME /usr/local/etc/php