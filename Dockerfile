# Use the official image for PHP and Apache
FROM php:8.2-apache

# Set the working directory to /var/www/html
WORKDIR /var/www/html


# Enabling custom upload settings in PHP
RUN touch /usr/local/etc/php/conf.d/uploads.ini \
&& echo "file_uploads = On" >> /usr/local/etc/php/conf.d/uploads.ini \
&& echo "memory_limit = 64M" >> /usr/local/etc/php/conf.d/uploads.ini \
&& echo "upload_max_filesize = 64M" >> /usr/local/etc/php/conf.d/uploads.ini \
&& echo "post_max_size = 64M" >> /usr/local/etc/php/conf.d/uploads.ini \
&& echo "max_execution_time = 60" >> /usr/local/etc/php/conf.d/uploads.ini

# Adding required libraries and modules
RUN apt-get update \
&& apt-get install -y git curl libxml2-dev libonig-dev
RUN docker-php-ext-install mysqli mbstring xml

USER www-data
WORKDIR /var/www/html
COPY ./ /var/www/html/

# Expose port 80
EXPOSE 80
