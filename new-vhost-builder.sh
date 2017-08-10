#!/bin/bash

clear

echo
echo "Hello World"
echo
# VHost adress input
echo "Введите адрес будущего виртуального хоста:"
read VIRTHOSTNAME

echo 
echo ===============================================
echo "Виртуальный хост: $VIRTHOSTNAME"

# Продолжить Да/Нет
echo "Все верно? Продолжить? Y|N"
echo ===============================================
echo
read OK1
if [[ $OK1 = "y" ]]
    then 
        echo "Все хорошо, продолжаем..."
        
        mkdir /home/papa/www/SANDBOX/$VIRTHOSTNAME
	cat <<EOF > /home/papa/www/SANDBOX/$VIRTHOSTNAME/index.php
<?php
    echo "Это новый сайт $VIRTHOSTNAME (виртуальный хост)";
    echo "<br><br>";
    echo phpinfo();
?>

EOF

    cat <<EOF > /etc/apache2/sites-available/$VIRTHOSTNAME.conf
<VirtualHost *:80>
    ServerName $VIRTHOSTNAME
    ServerAdmin azwebdds@gmail.com
    DocumentRoot /home/papa/www/SANDBOX/$VIRTHOSTNAME

    ErrorLog /home/papa/www/error.log
    CustomLog /home/papa/www/access.log combined
	
    <Directory /home/papa/www/>
        Options FollowSymLinks
        AllowOverride All
        Require all granted		
    </Directory>
</VirtualHost>
EOF

	cat <<EOF >> /etc/hosts
127.0.0.1    $VIRTHOSTNAME
EOF

	a2ensite $VIRTHOSTNAME
	service apache2 reload 
	echo "... Ok."
	
	echo
	echo
	echo ===============================================
        echo "Сайт $VIRTHOSTNAME (виртуальный хост) создан."
        echo "Все настройки для созданного виртуального хоста выполнены."
        echo "Сайт (виртуальный хост) запускается в браузере ..."
        echo "Для выхода ^C"
	echo ===============================================
	
	firefox http://$VIRTHOSTNAME

        
    else
        echo "Тупо облом :("
fi


