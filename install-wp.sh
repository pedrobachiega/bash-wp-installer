#!/bin/bash

TODAY=$(date +%Y%m%d)
SCRIPT_PATH=$(pwd)
echo "==== $TODAY - Starting Wordpress installation proccess ===="

echo -e "Path installation (like '/home/user/'): "
read wp_path
echo "Moving to $wp_path"
cd $wp_path

echo "Downloading latest version of Wordpress"
curl --silent -O http://wordpress.org/latest.zip
unzip -q latest.zip
rm latest.zip
echo "Moving into Wordpres folder"
cd wordpress/

echo "Downloading config file"
curl --silent -O http://res.pedrobachiega.com/wordpress/wp-config.php
#TODO
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

#TODO - install wp with blog name, admin user and initial configs

echo "Downloading common plugins"
cd wp-content/plugins/
while read LINE; do
  curl --silent -O "$LINE"
  file=$(echo $LINE | sed "s/http:\/\/downloads.wordpress.org\/plugin\///g")
  unzip -qo $file
  rm $file
done < $SCRIPT_PATH/plugins-list.txt

