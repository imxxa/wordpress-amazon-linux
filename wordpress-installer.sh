#!/bin/bash
# Author : n3urOn
# UPDATING ALL THE PACKAGES
yum update -y

# INSTALL HTTPD 2.4
yum install httpd24 -y

# INSTALL PHP , PHP-MYSQL CONNECTOR AND OTHER REQUIRED PACKAGES
yum install php70 php70-mysqlnd php70-imap php70-pecl-memcache php70-pecl-apcu php70-gd -y

# INSTALL MYSQL SERVER AND OTHER PACKAGES
yum install mysql57-server -y

# START  mysql SERVICE
service mysqld start

# CREATE A DATABASE CALLED AS BLOG FROM THE BASH / NOT GOING TO MYSQL SHELL OR CLIENT
mysql -e "CREATE DATABASE blog;"

# GRANT ALL PRIVILEGES TO USER ROOT ON BLOG AND ALL ITS ASSETS
mysql -e "GRANT ALL PRIVILEGES ON blog.* TO root@localhost;"

#MYSQL FLUSH PRIVILEGES
mysql -e "FLUSH PRIVILEGES;"

# NAVIGATE TO DOCUMENT ROOT OF YOUR WEBSERVER : /var/www/html
cd /var/www/html

# GET THE LATEST CODE FROM WORDPRESS WEBSITE FOR QUICKLY LAUNCHING YOUR WEBSITE
wget http://wordpress.org/latest.tar.gz

# EXTRACT AND UNCOMPRESS THE FILE
tar -xzvf latest.tar.gz

# CHANGE THE DIR NAME
mv wordpress blog

# NAVIGATE TO BLOG DIR
cd blog/

# RENAME THE FILE OF WORDPRESS CONFIG
mv wp-config-sample.php wp-config.php

# MAKE THE CONFIGURATION CHANGES IN WP-CONFIG FILE
sed "s/database_name_here/blog/g" wp-config.php > output.php && mv -f output.php wp-config.php
sed "s/username_here/root/g" wp-config.php > output.php && mv -f output.php wp-config.php
sed "s/password_here//g" wp-config.php > output.php && mv -f output.php wp-config.php

# START HTTPD SERVICE
service httpd start
