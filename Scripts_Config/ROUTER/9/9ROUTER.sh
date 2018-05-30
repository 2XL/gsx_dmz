#! /bin/bash


[ `whoami` = 'root' ] || exit 1
echo ' log de la practica 9 -> servei DHCP '

##################################################################################
# matem la configuració automàtica per a que no ens sobreescrigui la nostra	##
./mata_automatic.sh 								##
##################################################################################

##################################################################################
# activem el routing, la SNAT i la DNAT al PC de l'esquerra.			##
# routing 									##
echo "1" > /proc/sys/net/ipv4/ip_forward					##
sysctl -p /etc/sysctl.conf 							##
# source network address translator						##
iptables -t nat -A POSTROUTING -o eth2 -j MASQUERADE				##
# destination network address translator					##
iptables -t nat -A POSTROUTING -s 192.168.147/24 -d 0/0 -o eth2 -j MASQUERADE 	##
# -s local network mask								##
##################################################################################
# configurar una conexió per dins del rang de subxarxes del INTRANET
ifconfig eth3 172.20.0.2 netmask 255.254.0.0 
# afegir entrada en la taula de routing
# route add -net 172.20.0.0/15 gw 172.20.0.2 dev eth3	
##################################################################################
# configurem els servidors DHCP (ROUTER) 					##
	# per a que assigni adreces IP a les tres subxarxes que tenim:		##
# modificar archivo /etc/dhcp/dhcpd.conf
cp CONFIG/dhcpd.conf /etc/dhcp/
# reiniciar el dimoni de dhcp
service isc-dhcp-server restart
##################################################################################

# cal realitzar un backup
# cal configurar la xarxa per la intranet


 
