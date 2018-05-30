#! /bin/bash

echo ' ROUTER 
eth2      Link encap:Ethernet  HWaddr 00:1a:92:77:70:f4  
          inet addr:10.21.6.6
'

[ `whoami` = 'root' ] || exit 1


ifconfig eth2 down

# conectar cables mirar quina targeta... 
# pasem pera parametre la targeta ethernet correcte
# mii-tool | head -n 1

if [ $# -eq 0 ]
then
ethX=$(mii-tool | head -n1 | cut -c1-4)
else
ethX=$1
fi

ethX='eth0' # definició manual dela interficie de conexió


#####################################################
# cal deshabilitar los de arg1  i pasarlos a arg2
# deshabilitar tots los eth2
# ifconfig eth2 down 
#####################################################


 
ifconfig $ethX 192.168.1.123 netmask 255.255.255.0 broadcast 192.168.1.255 up
ifconfig $ethX:0 172.18.3.100 netmask 255.254.0.0 
ifconfig $ethX:1 172.18.3.200 netmask 255.254.0.0
ifconfig $ethX:2 172.17.3.2 netmask 255.254.0.0 
# ifconfig eth0:3 172.18.0.123 netmask 255.254.0.0

rm /etc/hosts
cp FILES/hosts /etc/hosts


# canvi port botiga-ssl

rm /etc/apache2/sites-available/botiga-ssl
cp FILES/botiga-ssl /etc/apache2/sites-available/


rm /etc/apache2/sites-available/intranet
cp FILES/intranet /etc/apache2/sites-available/

# matar los network deamons
./mata_automatic.sh


# a qui pregunto si no se com se arriba la direcció tal?, al router!
# route add default gw 192.168.1.124 eth0 # ip del router i tarja eth
# route -n








service apache2 restart
