#!/bin/bash

SCRIPT_PATH=$(pwd)
TODAY=$(date +%Y%m%d)

echo "==== Starting Wordpress installation proccess ===="

echo ">> Downloading plugins list"
curl --silent -O -L https://gist.github.com/pedrobachiega/5358338/raw/wp-plugins-list.txt

# echo -e "<< Path installation (like '/home/user/'): "
# read wp_path
# echo ">> Moving to $wp_path"
# cd $wp_path
cd $HOME

echo ">> Downloading latest version of Wordpress"
# curl --silent -O -L http://wordpress.org/latest.zip
curl --silent -O -L http://br.wordpress.org/latest-pt_BR.zip
unzip -q latest-pt_BR.zip
rm latest-pt_BR.zip
echo ">> Moving into Wordpres folder"
cd wordpress/

echo ">> Downloading config file"
curl --silent -O -L https://gist.github.com/pedrobachiega/5358302/raw/wp-config.php
#TODO
#salt=$(curl "https://api.wordpress.org/secret-key/1.1/salt/")
#sed_expression="s/\/\/ Authentication Unique Keys and Salts/'$salt'/g"
#sed -e "$sed_expression" wp-config.php
echo -e "<< Enter your MySQL database: "
read wp_db_database
sed -i.bkp "s/database_name_here/$wp_db_database/g" wp-config.php
echo -e "<< Enter your MySQL user: "
read wp_db_user
sed -i.bkp "s/username_here/$wp_db_user/g" wp-config.php
echo -e "<< Enter your MySQL password: "
read wp_db_passwd
sed -i.bkp "s/password_here/$wp_db_passwd/g" wp-config.php
echo -e "<< Enter your MySQL host: "
read wp_db_host
sed -i.bkp "s/localhost/$wp_db_host/g" wp-config.php
wp_db_prefix=$[ ( $RANDOM % 999 )  + 1 ]_
sed -i.bkp "s/wp_xpto_/wp_$wp_db_prefix/g" wp-config.php

#TODO - install wp with blog name, admin user and initial configs

echo ">> Downloading common plugins"
cd wp-content/plugins/
while read LINE; do
  curl --silent -O -L "$LINE"
  file=$(echo $LINE | sed "s/http:\/\/downloads.wordpress.org\/plugin\///g")
  unzip -qo $file
  rm $file
done < $SCRIPT_PATH/wp-plugins-list.txt

echo ">> Downloading RD Blog Theme"
cd ../themes/
r=$(git clone -q git://github.com/ResultadosDigitais/wptheme-rdblog.git)


echo "==== Wordpress installation complete! ===="
