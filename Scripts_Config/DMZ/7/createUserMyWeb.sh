#! /bin/bash


echo ' indiqui els noms del usuaris com a... && run as root!
exemple:
	sudo ./createUserMyWeb.sh zappa rahuy
'
echo $#
[ ! `whoami` = "root" ] && exit 1 # cal permís super user
[ $# -eq 0 ] && exit 2 # no s'ha torbat cap parametre

for user in $* 
do
if [ "$(id $user)" = "" ] 2> /dev/null
then
	useradd -m -d "/home/$user" -c "$user" -s "/bin/bash" $user
	mkdir /home/$user/myweb # hauria de tenir altres permisos...

	echo "
	<html>
		<body>
			<h1>
				Ets: $user
			</h1>
			<p> 
				la teva web està en contrucció
			</p>
		</body>
	</html>
	" > /home/$user/myweb/hola.html  # hauria de tenir altres permisos...
else
	echo "$user ya existe!"
fi
done
