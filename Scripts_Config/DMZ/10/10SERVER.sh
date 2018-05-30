#! /bin/bash




# inicialitzar els virtual hosts

echo ' maquina client-servidor-dmz or whatever...'
 
 
ethX=eth0 # targeta amb el qual es conecta al servidor

# configuració manual dels netmasks # afegir les adreçes de manera manual
# perque no m'he pogut aclararme amb el identificador de dhcp

ifconfig $ethX:0 192.168.1.100 netmask 255.255.255.0 # subxarxa dmz a
ifconfig $ethX:1 192.168.1.200 netmask 255.255.255.0 # subxarxa dmz b
ifconfig $ethX:2 172.17.1.2 netmask 255.254.0.0   # subxarxa intranet	# la web s'allotja aqui! 
 

# inicialitzar apache... etc.




# extreure els hosts manualment de hosts

rm /etc/hosts
cp FILES/hosts /etc/


service ssh start
