#!/bin/bash

TODAY=$(date +%Y%m%d)
echo "==== $TODAY - Starting Wordpress installation proccess ===="

echo -e "Path installation (like '/home/user/'): "
read wp_path
echo "Moving to $wp_path"
cd $wp_path

echo "Downloading latest version of Wordpress"
curl -O http://wordpress.org/latest.zip
unzip latest.zip
rm latest.zip
echo "Moving into Wordpres folder"
cd wordpress/

echo "Downloading config file"
curl -O http://res.pedrobachiega.com/wordpress/wp-config.php
#salt=$(curl "https://api.wordpress.org/secret-key/1.1/salt/")
#sed_expression="s/\/\/ Authentication Unique Keys and Salts/'$salt'/g"
#sed -e "$sed_expression" wp-config.php
echo -e "Enter your MySQL database: "
read wp_db_database
sed -i.bkp "s/database_name_here/$wp_db_database/g" wp-config.php
echo -e "Enter your MySQL user: "
read wp_db_user
sed -i.bkp "s/username_here/$wp_db_user/g" wp-config.php
echo -e "Enter your MySQL password: "
read wp_db_passwd
sed -i.bkp "s/password_here/$wp_db_passwd/g" wp-config.php
echo -e "Enter your MySQL host: "
read wp_db_host
sed -i.bkp "s/localhost/$wp_db_host/g" wp-config.php
wp_db_prefix=$[ ( $RANDOM % 999 )  + 1 ]_
sed -i.bkp "s/wp_xpto_/wp_$wp_db_prefix/g" wp-config.php

