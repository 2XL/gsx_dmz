#! /bin/bash

 
echo ' m`has d`executar amb permisos root '
[ `whoami` = 'root' ] || exit 1

echo ' hola, soc el router '
 
##################################################################################
# matem la config auto per a que no ens sobreescrigui la nostra			##
./mata_automatic.sh 

# configurar una conexió per dins del rang de subxarxes del SERVIDOR/DMZ
ifconfig eth0 192.168.1.124 netmask 255.255.255.0  
ifconfig eth0:0 172.17.1.124 netmask 255.254.0.0 
ifconfig eth0:1 192.18.1.124 netmask 255.255.255.0 

# configurar una conexió per dins del rang de subxarxes del INTRANET
ifconfig eth3 172.20.0.2 netmask 255.254.0.0 

echo ' activem el routing, la SNAT, la DNAT, i el DHCP del PC esquerra (¿clients de la intranet?) '

##################################################################################
# activem el routing								##
echo "1" > /proc/sys/net/ipv4/ip_forward	# activar el servei de forwarding ... 
sysctl -p /etc/sysctl.conf
# source network address translator						##
iptables -t nat -A POSTROUTING -o eth2 -j MASQUERADE				##
# destination network address translator					##
iptables -t nat -A POSTROUTING -s 192.168.147/24 -d 0/0 -o eth2 -j MASQUERADE 	##	# cal ficar mascara ip URV
# dhcp
cp FILES/dhcpd.conf /etc/dhcp/

echo ' comrpovem que els paquets son al sistema '

##################################################################################
#apt-get install bind9								##
#apt-get install bind9-doc
#apt-get install dnsutils

echo ' configurem els servidros DNS '

##################################################################################
# editem el fitxer /etc/bind/named.conf.local					##
	# hi afegim les zones :
		# gsx.ct	# dmz
		# intranet.gsx	# intranets
	# hi agegim 3 zones inverses
		# -> perque en les intranets hem fet subneting i ara no podem partir els bytes..

rm /etc/bind/named.conf.local
cp FILES/named.conf.local /etc/bind/

# actualitzar fitxer de configuració
rm /etc/bind/named.conf.options				
cp FILES/named.conf.options /etc/bind/		# editem el fitxer d'opcions globals...

# restart bind
/etc/init.d/bind9 restart

# by this point, if you "dig" a domain name multiple times you should see a drastic improvement in the Query time:
# between the first and secound query. this is due to the server caching the query.


##################################################################################
# PRIMARY MASTER SERVER CONFIGURATION 						##


#// use a existing zone file as a template....
#// cp /etc/bind/db.local /etc/bind/db.gsx.ct

#// edit the new zone file 
#// db.gsx.ct -> changing localhost. to the FQDN of the server


rm /etc/bind/*gsx*	
cp FILES/*gsx* /etc/bind/	# copiar els fitxers de zones en el directori de configuració de BIND


# after edit restart again
/etc/init.d/bind9 restart

# now that the zone file is setup and resolving names to IP @ a reverse zone is also required
# a reverse zone allows DNS to convert from an address to a name

# edit /etc/bind/named.conf.local
# replace the ip with the first three octets of whatever private network you are using

# now create the db.192 file xD --> db.172

chown bind. /var/cache/bind/*

/etc/init.d/bind restart
/etc/init.d/isc-dhcp-server restart
 
# esborar les entrades de /etc/hosts

rm /etc/hosts
cp FILES/hosts /etc/

rm /etc/resolv.conf
cp FILES/resolv.conf /etc/

 
# ultima sesió
# restart bind9
service bind9 restart

# debug bind9 
service ssh

# named -u bind -4 -f -g -d 3

# tail -f systlog












































