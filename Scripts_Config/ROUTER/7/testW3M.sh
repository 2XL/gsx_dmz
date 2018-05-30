#! /bin/bash



echo 'provar si podem accedir a lo servidor desde el client'

echo ' 
>>>>>>>>>>>>>>>>>>>>>>>>>>>>
contingut de la pagina
w3m -dump www.gsx.ct
<<<<<<<<<<<<<<<<<<<<<<<<<<<<
'
w3m -dump www.gsx.ct

echo ' 
>>>>>>>>>>>>>>>>>>>>>>>>>>>>
contingut de la pagina
w3m -dump www.cataleg.gsx.ct
<<<<<<<<<<<<<<<<<<<<<<<<<<<<
'
w3m -dump www.cataleg.gsx.ct

echo '
>>>>>>>>>>>>>>>>>>>>>>>>>>>>
contingut de la pagina
w3m -dump www.productes.gsx.ct
<<<<<<<<<<<<<<<<<<<<<<<<<<<<
'
w3m -dump www.productes.gsx.ct

echo ' 
>>>>>>>>>>>>>>>>>>>>>>>>>>>>
contingut de la pagina
w3m -dump www.botiga.gsx.ct
<<<<<<<<<<<<<<<<<<<<<<<<<<<<
'
w3m -dump https://www.botiga.gsx.ct

echo ' 
>>>>>>>>>>>>>>>>>>>>>>>>>>>>
contingut de la pagina
w3m -dump www.intranet.gsx
<<<<<<<<<<<<<<<<<<<<<<<<<<<<
'

w3m -dump www.intranet.gsxb 

 echo 'fin test' && echo 'el test t`ha realitzat amb éxit! trolface...'
