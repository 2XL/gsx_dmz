#! /bin/bash

# pegar los fitxers a home/~/Desktop... directory /

[ ! `whoami` = 'root' ] && echo 'u have to run me as root!' && exit 1
# 1r afegir manualment
 

#####################################################################
rm /etc/hosts
cp FILES/hosts /etc/hosts	# copiar les adresçes i enllaços
#####################################################################

# 2n afegir les adreçes virtuals
#####################################################################
 
# 3r matar el network manager

ps aux | grep Manager # mirar si existeix
./mata_automatic.sh # dir sisi


if [ $# -eq 1 ]
then
ethX=$1
eth_ip=$(ifconfig $ethX | sed -n '2p' | cut -c 21-35)
echo $eth_ip
# ha sigut necesari afegir manualment les IPs de la xarxa local a les tauls de routing. Per exemple:
route add -net 192.168.3.0/24 gw $eth_ip dev $ethX #this is optional depending on machine config and router
fi




