#! /bin/bash


echo ' maquina client-servidor-dmz or whatever...'
 
 
ethX=eth0 # targeta amb el qual es conecta al servidor

# configuració manual dels netmasks # afegir les adreçes de manera manual
# perque no m'he pogut aclararme amb el identificador de dhcp

ifconfig $ethX:0 172.18.3.100 netmask 255.254.0.0 # subxarxa dmz a
ifconfig $ethX:1 172.18.3.200 netmask 255.254.0.0 # subxarxa dmz b
# ifconfig $ethX:2 172.20.3.2 netmask 255.254.0.0   # subxarxa intranet	# la web s'allotja aqui! 
 
