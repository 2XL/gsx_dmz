#! /bin/bash


echo ' maquina client-servidor-dmz or whatever...'





echo ' es fer lo de sempre '
# configurar el fitxer etc/hosts	#
cp FILES/hosts /etc/hosts

 
ethX=eth0 # targeta amb el qual es conecta al servidor

 
# configurar el fitxer etc/network/interfaces -> per treballar sols amb una interficie fisica per dhcp
# pero n'hi agafem dues de virtuals amb una mac adderess explicicta amida per que siguin hosts coneguts epl servidor DHCP

cp FILES/interfaces /etc/network/interfaces

ifconfig $ethX:0 172.18.3.100 netmask 255.254.0.0 # subxarxa dmz a
ifconfig $ethX:1 172.18.3.200 netmask 255.254.0.0 # subxarxa dmz b
# ifconfig $ethX:2 172.20.3.2 netmask 255.254.0.0   # subxarxa intranet	# la web s'allotja aqui! 

service apache2 restart
# desconectem de xarxa i el lliguam al router
# apaguem la maquina i la rengeguem com el mateix usuari -alumne
# busquem els fitxers leases del client
# comrpovem si el nom di del nomi  del pc han canviat
# comprovem la connectivitat amb ping
# comrpovem que els servidor apache estan fucnionant correctament


# man interfaces /hwaddres 
