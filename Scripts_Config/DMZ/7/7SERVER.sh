#! /bin/bash

echo 'script inicialitzar client
s`ha de ser usuari root
'
[ `whoami` = 'root' ] && echo 'u are root!' || exit 2
 
# afegir les ips i adreça més nom a etc host 
# en un script seria ->

# crear aquesta carpeta a ~

# 0
echo ' 0000000000000000000000000 

'
# preparar el contingut de les planes web per mostrar: index.html de cada plana
# considerem que allotjarem el contingut de les planes a la carpeta /var/*/index.html
# copiarem el contingut desde la carpeta del script

######################################################################################################
rm -r /var/general 2> 7S.err
rm -r /var/productes 2> 7S.err
rm -r /var/cataleg 2> 7S.err
rm -r /var/intranet 2> 7S.err
rm -r /var/botiga 2> 7S.err
######################################################################################################
# carregar els fitxers de configuració
cp -r CONTENT/general /var/
cp -r CONTENT/productes /var/	 
cp -r CONTENT/cataleg /var/ 
cp -r CONTENT/intranet /var/
cp -r CONTENT/botiga /var/
######################################################################################################

# 1r
echo ' 1111111111111111111111111

 

'
 
######################################################################################################
rm /etc/hosts
cp FILES/hosts /etc/hosts	# actualitzar el fitxer de etc hosts - afegint-hi les adreçes virtuals 
######################################################################################################

# 2n afegir adreçes de interficie virtual
echo ' 22222222222222222222222222



' 
######################################################################################################
ifconfig eth2:0 192.168.3.100 netmask 255.255.255.0	# instanciar els virtual hosts
ifconfig eth2:1 192.168.3.200 netmask 255.255.255.0
ifconfig eth2:2 172.17.3.2 netmask 255.255.0.0

######################################################################################################
# 3r matar el network manager

echo ' 333333333333333333333333333



 
' 
######################################################################################################
ps aux | grep Manager # mirar si existeix - dimoni del network management
./mata_automatic.sh   # matar els dimonis perque poguem editar les taules, enlloc de tmp miror
######################################################################################################

# 4t configurar la pagina web
echo ' 444444444444444444444444444



 
' 
	# configurar les webs catàleg i productes amb accés basat en noms
	# cadascun en directoris diferents
	# els activem i comprovem que funcionen 
# podem fer la prova amb un:

# eliminar si esitien
rm -r /etc/apache2/sites-available/general 2> 7S.err
rm -r /etc/apache2/sites-available/productes 2> 7S.err
rm -r /etc/apache2/sites-available/cataleg 2> 7S.err
rm -r /etc/apache2/sites-available/intranet 2> 7S.err
rm -r /etc/apache2/sites-available/botiga 2> 7S.err
######################################################################################################
# carregar els fitxers de configuració
cp -r FILES/general /etc/apache2/sites-available/	
cp -r FILES/productes /etc/apache2/sites-available/	 
cp -r FILES/cataleg /etc/apache2/sites-available/	 
cp -r FILES/intranet /etc/apache2/sites-available/ 	 
cp -r FILES/botiga /etc/apache2/sites-available/ 	 
######################################################################################################


######################################################################################################
service apache2 start # inicialitzar el servidor apache2
######################################################################################################

 

# ara caldria posar les webs en marxa i després introduirli contingut
sudo service apache2 reload
######################################################################################################
sudo a2ensite cataleg		# instanciar les webs amb la configuració especificada
sudo a2ensite productes		#
sudo a2ensite intranet		#
# sudo a2ensite botiga		# no cal encara -> aquest sera botiga-ssl
sudo a2ensite general 		#
######################################################################################################



echo ' 5555555555555555555555555



 
' 
# executar el script de crear usuaris...
######################################################################################################
# sudo ./createUserMyWeb.sh zappa rahuy	# crear els usuaris de prova
######################################################################################################


 
 

######################################################################################################
rm /etc/apache2/mods-available/dir.conf 
# rm /etc/apache2/mods-available/userdir.conf

cp FILES/dir.conf /etc/apache2/mods-available/dir.conf 		# modificació de configuració
# cp FILES/userdir.conf /etc/apache2/mods-available/userdir.conf 	# usuaris de intranet

# activar el modul userdir
a2enmod userdir
# restart the apache server to make the change take effect
# more /etc/apache2/mods-available/userdir.conf
######################################################################################################
 
## cal configurar que els usuaris només pengin del servidor per defecte,

# http://www.techytalk.info/enable-userdir-apache-module-ubuntu-debian-based-linux-distributions/

## disibleing
# http://serverfault.com/questions/238847/apache-2-userdir-for-only-one-virtualhost

  
## 5
# busqueu els missatges d'errror i apliqueu el patch catalanitzador que us proporcionem
######################################################################################################
now=`pwd`
cp patch_catapachi /usr/share/apache2/error/
cd /usr/share/apache2/error/
# patch <patch_catapachi
rm patch_catapachi
cd $now

rm /etc/apache2/conf.d/localized-error-pages 
cp FILES/localized-error-pages /etc/apache2/conf.d/

service apache2 restart
 
######################################################################################################

echo ' 6666666666666666666666666
intranet...

order deny, allow
deny all
&
allow localhost & ip
 
' 


echo ' 7777777777777777777777777

modifiqueu el default.ssl per a servir la botiga basant-nos en la IP 

 
' 

######################################################################################################
rm /etc/apache2/sites-available/botiga-ssl
cp FILES/botiga-ssl /etc/apache2/sites-available/

a2enmod ssl
apache2ctl restart
a2ensite botiga-ssl
apache2ctl restart 
######################################################################################################

# asignar correctament els permisos dels fitxers contingut de les planes web

chgrp -R www-data /var/botiga
chgrp -R www-data /var/cataleg
chgrp -R www-data /var/general
chgrp -R www-data /var/intranet
chgrp -R www-data /var/productes

 
chmod -R 2750 /var/botiga
chmod -R 2750 /var/cataleg
chmod -R 2750 /var/general
chmod -R 2750 /var/intranet
chmod -R 2750 /var/productes




























