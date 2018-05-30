#!/bin/bash

# Author: GSX
# Version: 1.0
#
# Description:
# Permet matar diversos provessos relacionats amb un determinat string
# (Per exemple per a matar el NetworkManager i el dhclient)
#
# Parametres d'us: tres opcions
# a) l'string de la victima
# b) la variable per defecte (victima) d'aquest script
# c) la demana a l'usuari

victima="networkmanager"	# per defecte matar al NetworkManager

# 007?  es a dir, llicencia per a matar?
if [ $(id -u) != 0 ]; then
	echo "Has de ser root per a executar-me !"
	exit
fi

# recollida de parametres
if [ $# -ge 1 ]; then
	victima=$1
else
	if [ $victima = "" ]; then
		echo "Com es diu la víctima?"
		read victima
	fi
fi

# informem quants processos hi ha implicats
n=$(ps -Ao pid,cmd | grep -v grep | grep -v $0 | grep -i -c $victima)
echo "Nombre de processos $victima= $n"

IFS=$'\n' # separador pel for: tractar linies senceres 
for pid in $(ps -Ao pid,cmd | grep -v grep | grep -v $0 | grep -i $victima)
do
	echo "Segur que vols matar al seguent proces? (s/n)"
	echo $pid
	read answ
	if [ $answ = "s" -o $answ = "S" ]; then
		sudo kill -9 $(echo $pid | sed 's:^ \+::' | cut -f 1 -d ' ')
	fi
done
