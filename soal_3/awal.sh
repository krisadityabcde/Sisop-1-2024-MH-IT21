#!/bin/bash

wget -O file.zip --no-check-certificate 'https://drive.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN'

unzip file.zip

mkdir genshin_character
unzip genshin_character.zip
cd genshin_character || exit

mkdir Inazuma Mondstat Liyue Sumeru Fontaine

for file in *; 
do
    namaAsli=$(echo $file | xxd -r -p)
    namaEdit=$(awk -F ',' "/$namaAsli/"'{OFS = " - ";print $2,$1,$3,$4}' /home/rafaelega24/SISOP/modul1/3/list_character.csv)
    region=$(awk -F ',' "/$namaAsli/"'{print $2}' /home/rafaelega24/SISOP/modul1/3/list_character.csv)
    mv $file "$namaEdit".jpg
    mv "$namaEdit".jpg "/home/rafaelega24/SISOP/modul1/3/genshin_character/$region"
done

clear

awk -F ',' '
BEGIN {print "Jumlah karakter berdasarkan weapon : "}
/Claymore/ {a++}
/Sword/ {b++}
/Polearm/ {c++}
/Catalyst/ {d++}
/Bow/ {e++}
END {print "Claymore : "a"\nSword : "b"\nPolearm : "c"\nCatalyst : "d"\nBow : "e}
' /home/rafaelega24/SISOP/modul1/3/list_character.csv

cd ..
rm file.zip genshin_character.zip list_character.csv
