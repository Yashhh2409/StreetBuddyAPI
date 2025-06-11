# Use official PHP image with Apache
FROM php:8.2-apache

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    git zip unzip libzip-dev libpng-dev libonig-dev curl \
    && docker-php-ext-install pdo pdo_mysql zip

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy Laravel project files
COPY . .

# Set proper Apache document root to public/
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|' /etc/apache2/sites-available/000-default.conf

# Set permissions for Laravel storage and cache
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Install Composer (from official image)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install Laravel dependencies (no dev for production)
RUN composer install --no-dev --optimize-autoloader

# Add .env if needed (optional – or use Render secrets instead)

# Expose port 80
EXPOSE 80

# Start Apache in foreground (handled by base image)
CMD ["apache2-foreground"]
