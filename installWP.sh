#!/bin/bash
#Orginally made by (PAS43) Paul Spedding 03/10/2014
if [ -d "/aber/$1/public_html/wordpress" ]; then
        rm -R /aber/$1/public_html/wordpress
fi
clear
if [ -d "tempWPInstall" ]; then
        echo "dir exists"
else
        mkdir tempWPInstall
fi
cd tempWPInstall
wget https://wordpress.org/latest.tar.gz -O latest.tar.gz
clear
tar -zxvf latest.tar.gz
clear
cd wordpress
clear
echo "copying file"
cp wp-config-sample.php wp-config.php
echo "editing files"
sed -i s/database_name_here/$1/ wp-config.php
sed -i s/username_here/$1/ wp-config.php
sed -i s/password_here/$2/ wp-config.php
sed -i s/localhost/db.dcs.aber.ac.uk/ wp-config.php
echo "files edited!"
cd ..
echo "Moving WordPress from temp Dir to public_html folder"
if [ -d "/aber/$1/public_html/wordpress/" ]; then
        echo "found ~/public_html/wordpress"
        cp -r ~/tempWPInstall/* ~/public_html/
else
        echo "making /wordpress dir"
        mkdir ~/public_html/wordpress
        cp -r ~/tempWPInstall/* ~/public_html/
fi
rm -R ~/tempWPInstall
cd /aber/$1/public_html/
echo "Changing file permissions"
find wordpress/ -type d -exec chmod 755 {} \;
find wordpress/ -type f -exec chmod 744 {} \;
find wordpress/ -name "*.php" -exec chmod 700 {} \;
echo "to complete installtion goto: http://users.aber.ac.uk/$1/wordpress/wp-admin/install.php"
