#! /bin/bash

echo ' indiqui els noms del usuaris com a
exemple:
	./createUserMyWeb.sh zappa rahuy
'
[ $@ == 0 ] && exit 0 # no s'ha torbat cap parametre

for [ $user in $* ]
do
useradd -m -d /home/$user -c "$user" -s /bin/bash $user
mkdir /home/$user/myweb

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
" > /home/$user/myweb/hola.html

done
