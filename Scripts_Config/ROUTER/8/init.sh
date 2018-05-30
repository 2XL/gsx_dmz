#! /bin/bash



echo '
0
backups dels fitxers permisos i symbolics links 


'


echo '
1 
ps aux | grep netstat # -ntp ??


'
sudo ps aux | grep netstat

echo '
2 
'
thisDIR=`pwd`
cd /var/log/apache2

echo 'error.log 
	tail -f error.log
' 
echo 'access.log 
	tail -f access.log 
'
cd $thisDIR

 

echo '
3


'
ps -a | grep 'wireshark'
[ $? -eq 1 ] && wireshark &


echo '
4

background /deamons
foreground *
'

