#!/bin/bash

#download file csv
wget -O Sandbox.csv --no-check-certificate 'https://drive.google.com/uc?export=download&id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0'

#mencari pelanggan dengan sales tertinggi
echo "Pelanggan dengan sales tertinggi: "
awk -F ',' '{print $6",",$17}' Sandbox.csv | sort -t ',' -k2,2nr | head -n 1
echo " "

#mencari costumer segment dengan profit paling kecil
echo "Costumer segment dengan profit paling kecil: "
awk -F ',' '{print $7",",$20}' Sandbox.csv | sort -t ',' -k2,2n | head -n 2 | tail -n 1
echo " "

#mencari 3 kategori dengan total profit tertinggi
echo "3 kategori dengan total profit tertinggi: "
awk -F ',' '{print $14",",$20}' Sandbox.csv | sort -t ',' -k1,1 > temp.txt

awk -F ',' '/Furniture/ {print}' temp.txt | awk -F ',' '{sum+=$2} END {print "Furniture, ",sum}' > temp2.txt
awk -F ',' '/Office Supplies/ {print}' temp.txt | awk -F ',' '{sum+=$2} END {print "Office Supplies, ",sum}' >> temp2.txt
awk -F ',' '/Technology/ {print}' temp.txt | awk -F ',' '{sum+=$2} END {print "Technology, ",sum}' >> temp2.txt

awk -F ',' '{print}' temp2.txt | sort -t ',' -k2,2nr
echo " "
rm temp.txt temp2.txt

#mencari purchase date dan amount dari customer Adriaens
echo "Purchase date dan amount/quantity dari customer Adriaens: "
awk -F ',' '/Adriaens/ {print "Customer Name: "$6,"\nPurchase Date: "$2,"\nOrder Amount: "$18}' Sandbox.csv
