#!/bin/bash
#env files
DATABASE_USER=$MYSQL_USER
DATABASE_NAME=$DB_NAME
DATABASE_PASS=$MYSQL_PASSWORD
# Wait for MySQL to start
service php7.3-fpm restart
sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 0.0.0.0:9000/g' /etc/php/7.3/fpm/pool.d/www.conf
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
mkdir -p /run/php
cd /var/www/html
rm -rf *
wp core download --allow-root
cp wp-config-sample.php wp-config.php
wp config set DB_HOST mydb --type=constant --allow-root
wp config set DATABASE_NAME $DB_NAME --type=constant --allow-root
wp config set DATABASE_USER $MYSQL_USER --type=constant --allow-root
wp config set DATABASE_PASS $MYSQL_PASSWORD --type=constant --allow-root
wp core install --url=localhost --title="my own Website" --admin_user=skasmi --admin_password=123saife --admin_email=saife.addine123@gmail.com --skip-email --allow-root
wp user create fratello test@gmail.com --role=co_founder --user_pass=123fratello --allow-root
/usr/sbin/php-fpm7.3 -F
