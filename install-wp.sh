#!/bin/bash

TODAY=$(date +%Y%m%d)
echo "==== $TODAY - Starting Wordpress installation proccess ===="

#echo -e "Path installation (like '/home/user/'): "
#read wp_path
#echo "Moving to $wp_path"
#cd $wp_path

#echo "Downloading latest version of Wordpress"
#curl -O http://wordpress.org/latest.zip
#unzip latest.zip
#rm latest.zip
#echo "Moving into Wordpres folder"
#cd wordpress/

echo "Downloading config file"
#curl -O https://s3-sa-east-1.amazonaws.com/pb-resources/wordpress/wp-config.php
salt=`curl "https://api.wordpress.org/secret-key/1.1/salt/" `
sed_expression="s/\/\/ Authentication Unique Keys and Salts/$salt/g"
sed -e $sed_expression wp-config.php > wp-config.php

