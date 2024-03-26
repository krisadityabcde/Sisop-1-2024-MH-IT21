# Sisop-1-2024-MH-IT21
## Anggota Kelompok:
- Rafael Ega Krisaditya	(5027231025)
- Rama Owarianto Putra Suharjito	(5027231049)
- Danar Bagus Rasendriya	(5027231055)

## Soal 1
Untuk soal ini, awalnya kita diminta untuk mendownload file Sandbox.csv dari link Google Drive
```shell
wget -O Sandbox.csv --no-check-certificate 'https://drive.google.com/uc?export=download&id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0'
```
Syntax ini akan mendownload file dari Google Drive dan langsung menyimpan file-nya dengan nama Sandbox.csv

### 1a
```shell
echo "Pelanggan dengan sales tertinggi: "
awk -F ',' '{print $6",",$17}' Sandbox.csv | sort -t ',' -k2,2nr | head -n 1
echo " "
```
Untuk mencari pelanggan dengan sales tertinggi, kolom Nama Pelanggan (6) dan kolom Sales (17) akan di-print dengan awk dari Sandbox.csv, diurutkan secara numerical reverse (besar - kecil), dan dimbil baris teratasnya saja.

### 1b
```shell
echo "Customer segment dengan profit paling kecil: "
awk -F ',' '{print $7",",$20}' Sandbox.csv | sort -t ',' -k2,2n | head -n 2 | tail -n 1
echo " "
```
Untuk mencari customer segemnt dengan profit tertinggi, kolom Customer Segment (7) dan kolom Profit (20) akan di-print dengan awk, diurutkan secara numerical, dan diambil baris keduanya dengan gabungan head dan tail karena baris pertama berisi header dari tabel pada Sandbox.csv.

### 1c
```shell
echo "3 kategori dengan total profit tertinggi: "
awk -F ',' '{print $14",",$20}' Sandbox.csv | sort -t ',' -k1,1 > temp.txt

awk -F ',' '/Furniture/ {print}' temp.txt | awk -F ',' '{sum+=$2} END {print "Furniture, ",sum}' > temp2.txt
awk -F ',' '/Office Supplies/ {print}' temp.txt | awk -F ',' '{sum+=$2} END {print "Office Supplies, ",sum}' >> temp2.txt
awk -F ',' '/Technology/ {print}' temp.txt | awk -F ',' '{sum+=$2} END {print "Technology, ",sum}' >> temp2.txt

awk -F ',' '{print}' temp2.txt | sort -t ',' -k2,2nr
echo " "
rm temp.txt temp2.txt
```
Untuk mencari 3 kategori dengan total profit tertinggi, kolom Kategori (14) dan kolom Profit (20) akan di-print dengan awk dan diurutkan di bagian kategori agar bisa mengetahui ada berapa jumlah kategori dalam tabel Sandbox.csv, hasilnya kemudian disimpan di dalam file temp.txt, dari sini dapat diketahui bahwa hanya ada 3 kategori yang terdapat di seluruh bagian tabel. Lalu profit pada setiap kategori akan dijumlahkan untuk mendapatkan total profit yang hasilnya dimasukkan ke dalam file temp2.txt. Hasil penjumlahan ini belum diurutkan maka akan diurutkan terlebih dahulu sebelum ditampilkan ke pengguna.

### 1d
```shell
echo "Purchase date dan amount/quantity dari customer Adriaens: "
awk -F ',' '/Adriaens/ {print "Customer Name: "$6,"\nPurchase Date: "$2,"\nOrder Amount: "$18}' Sandbox.csv
```
Dengan awk, line yang berisi data pembelian oleh customer atas nama Adriaens dapat diambil seluruhnya, namun karenya yang dibutuhkan hanya data purchase date dan amount/quantity, maka akan disaring lagi berdasarkan kolomnya.

### Screenshot Hasil Pengerjaan
![image](https://github.com/krisadityabcde/Sisop-1-2024-MH-IT21/assets/144150187/a591b3fc-93d2-42d7-99fe-7c75db8495a3)

### Kendala
Tidak ada kendala

## Soal 2
### 2a
### 2b
### 2c
### 2d
### 2e
### 2f
### 2g
### 2h
### 2i
### 2j
### Kendala

## Soal 3
### 3a
### 3b
### 3c
### 3d
### 3e
### Kendala

## Soal 4
### 4a
### 4b
### 4c
### 4d
### Kendala
