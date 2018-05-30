#! /bin/bash

echo ' ROUTER 

eth2      Link encap:Ethernet  HWaddr 00:1a:92:77:70:f4  
          inet addr:10.21.6.6

'
[ `whoami` = 'root' ] || exit 1


# cal asignar a quina interficie esta conectat per cable el router i el servidor
if [ $# -eq 0 ]
then
ethX=$(mii-tool | head -n1 | cut -c1-4)
else
ethX=$1
fi

ethX='eth0' # forçem que sera la interficie eth0

# conectar cables mirar quina targeta... 
# se pasara per parametre ela targe o manual
ifconfig $ethX 192.168.1.124 netmask 255.255.255.0  
ifconfig $ethX:0 172.18.0.124 netmask 255.254.0.0  
# ifconfig $ethX:1 172.20.0.124 netmask 255.254.0.0 

######################################################
echo ' resetejar /etc/hosts
'
rm /etc/hosts
cp FILES/hosts /etc/



# mascara 172.16+8+4+2/15
# 172.30/15
# subneting 0.00000000.00000000 
# 1r # 172.18.0.1 --> intranet general
# 2n # 172.18.0.2 --> servidor

# sudo iptables -L -nv -t nat
# matar los network deamons
./mata_automatic.sh
# enable forewarding
echo "1" > /proc/sys/net/ipv4/ip_forward
sysctl -p /etc/sysctl.conf
# postrouting --> donar acces internet al servidor

# iptables -t nat -A POSTROUTING -o eth2 -j MASQUERADE
# iptables -t nat -A POSTROUTING -p tcp -o eth0 -j SNAT --to-source 192.168.1.0-194.236.50.160:1024-32000


# donar accés a internet al DMZ
# SNAT ->  source network addresss translator / convierte la ip font 
iptables -t nat -A POSTROUTING -s 192.168.1/24 -d 0/0 -o eth2 -j MASQUERADE
# delete specfic table all
# iptables -t @@@ --flush 

# delete rules form iptables
# iptables -t nat -D POSTROUTING 1


# list ipatbles
# iptables -L -nv -t nat
# restart counter from iptables
# iptables -t nat -Z
 



# DNAT -> destination network address translator / conviete la ip destino

# iptables -t nat -A PREROUTING -i eth2 -d 192.168.1.124 --dport 80 -j DNAT --to-destination 192.168.1.123
# iptables -t nat -D PREROUTING 1
# iptables -t nat -A PREROUTING -p tcp -d 10.10.20.99 --dport 80 -j DNAT --to-destination 10.10.14.2

# iptables -t nat -A PREROUTING -i eth2 -d 10.21.6.5 -p tcp --dport 80  -j DNAT --to-destination 192.168.1.123

# redirecció de les peticións dirigides al DMZ per el router
ip_serverDMZ='192.168.1.123'
ethInternet='eth2'
eth_ip=$(ifconfig $ethInternet | sed -n '2p' | cut -c 21-35)
iptables -t nat -A PREROUTING -i $ethInternet -d $eth_ip -p tcp --dport 80  -j DNAT --to-destination $ip_serverDMZ

 

service apache2 restart
