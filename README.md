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

### Revisi
Tidak ada revisi

## Soal 2
### 2a
Awalnya, kita diminta untuk membuat 2 Shell Script bernama regsister.sh dan login.sh
Karena saya menggunakan Visual Studio Code sebagai IDE saya, maka saya hanya menggunakan syntax `code .` di direktori tempat saya ingin membuat 2 Shell Script tersebut dan menggunakan fitur "new file", seperti halnya ketika kita menggunakan Visual Studio Code untuk membuat file baru

### 2b
Bagian soal ini dapat dikerjakan dengan Script register.sh

### 2c
Pada soal ini, setiap user dan admin yang hendak mendaftarkan akunnya harus menggunakan E-mail yang unik
```shell 
if grep -q "$email" users.txt; then
    echo "E-mail sudah terdaftar, mohon gunakan e-mail lain!"
    echo "[$(date +"%d/%m/%y %H:%M:%S")] [REGISTER FAILED] Email $email sudah terdaftar" >> auth.log
```
Kesalahan input pada bagian ini (menginputkan E-mail yang sudah terdaftar) akan tercatat di dalam `auth.log`
Sementara itu, untuk pengelompokan antara user dan admin akan dibahas lebih lanjut pada bagian login.sh

### 2d
Setiap password yang didaftarkan harus memiliki kriteria sebagai berikut:
1. Password tersebut harus di encrypt menggunakan base64
2. Password yang dibuat harus lebih dari 8 karakter
3. Harus terdapat paling sedikit 1 huruf kapital dan 1 huruf kecil
4. Harus terdapat paling sedikit 1 angka

```shell
 echo "Password harus lebih dari 8 karakter, mengandung huruf besar, huruf kecil, angka, karakter spesial, dan tidak boleh sama dengan username"
    read -sp "Masukkan Password: " password
    if [[ ${#password} -lt 8 || ! ("$password" =~ [A-Z]) || ! ("$password" =~ [a-z]) || ! ("$password" =~ [0-9]) || ! ("$password" =~ [^a-zA-Z0-9]) || ! ("$password" =~ [!@#]) || ("$password" == "$username") ]]; then
        echo "Password tidak memenuhi kriteria, mohon masukkan password sesuai dengan kriteria yang telah ditentukan!"
        echo "[$(date +"%d/%m/%y %H:%M:%S")] [REGISTER FAILED] Password tidak memenuhi kriteria" >> auth.log
    else
        pass_aman=$(echo -n "$password" | base64)
```
Untuk itu, saya memasukkan semua kondisi yang dibutuhkan dalam sebuah argumen `if` sehingga apabila terdapat 1 saja kondisi yang tidak terpenuhi, password yang di-inputkan akan ditolak oleh sistem dan langsung dicatat dalam `auth.log`

Lalu apabila password sudah sesuai kriteria, maka password akan dienkripsi menggunakan `base64`

### 2e
Semua upaya register yang telah sesuai ketentuan akan otomatis terdaftar dan akan disimpan dalam file `users.txt`
```shell
 echo "$email:$username:$pertanyaan:$jawaban:$pass_aman" >> users.txt
        echo "[$(date +"%d/%m/%y %H:%M:%S")] [REGISTER SUCCESS] Pengguna $username berhasil terdaftar" >> auth.log
        printf "\nRegistrasi akun berhasil!\n"
```
Selain itu, pendaftaran yang berhasil juga akan disimpan dan dicatat dalam `aut.log`

### 2f
Soal ini akan dibahas lebih lanjut di bawah

### 2g
Di bagian ini, kita diminta menyajikan 2 pilihan menu untuk login di mana pengguna bisa langsung login atau memilih pilihan "lupa password" sebagia upaya pencegahan apabila benar-benar ada orang yang lupa passwordnya sendiri
```shell
echo "Login Akun"
echo "1. Login"
echo "2. Lupa Password"

read -p "Pilihan: " pilihan
```

### 2h
Apabila admin melakukan login, maka admin dapat melakukan beberapa hal tambahan seperti:
- Menambahkan user
- Mengedit user
- Menghapus user

```shell
 if echo $email | grep -q "admin"; then
            read -sp "Masukkan Password: " password
            pass_aman=$(echo -n "$password" | base64)

            if awk -F ':' -v email=$email '$1 == email{print}' users.txt | grep -q "$pass_aman"; then
                echo "Login berhasil! Selamat datang Admin"
                echo "[$(date +"%d/%m/%y %H:%M:%S")] [LOGIN SUCCESS] Admin dengan email $email berhasil login" >> auth.log
                echo "Menu Admin"
                echo "1. Tambah User"
                echo "2. Edit User"
                echo "3. Hapus User"
                read -p "Pilihan: " pilihan_admin

                if [ $pilihan_admin -eq 1 ]; then
                    bash register.sh

                elif [ $pilihan_admin -eq 2 ]; then
                    read -p "Masukkan email user yang ingin diedit: " email
                    if grep -q "$email" users.txt; then
                        read -p "Masukkan Username Baru: " username_baru
                        read -p "Masukkan Pertanyaan Keamanan Baru: " pertanyaan_baru
                        read -p "Masukkan Jawaban dari Pertanyaan Keamanan Baru: " jawaban_baru
                        echo "Password harus lebih dari 8 karakter, mengandung huruf besar, huruf kecil, angka, karakter spesial, dan tidak boleh sama dengan username"
                        read -sp "Masukkan Password Baru: " password_baru
                        if [[ ${#password_baru} -lt 8 || ! ("$password_baru" =~ [A-Z]) || ! ("$password_baru" =~ [a-z]) || ! ("$password_baru" =~ [0-9]) || ! ("$password_baru" =~ [^a-zA-Z0-9]) || ! ("$password_baru" =~ [!@#]) || ("$password_baru" == "$username_baru") ]]; then
                            echo "Password tidak memenuhi kriteria, mohon masukkan password sesuai dengan kriteria yang telah ditentukan!"
                            exit
                        else
                            pass_aman=$(echo -n "$password_baru" | base64)
                            sed -i "s/$email:.*/$email:$username_baru:$pertanyaan_baru:$jawaban_baru:$pass_aman/" users.txt
                            echo "User berhasil diedit!"
                        fi
                    else
                        echo "User tidak ditemukan!"
                        exit
                    fi

                elif [ $pilihan_admin -eq 3 ]; then
                    read -p "Masukkan email user yang ingin dihapus: " email
                    if grep -q "$email" users.txt; then
                        sed -i "/$email/d" users.txt
                        echo "User berhasil dihapus!"
                    else
                        echo "User dengan email $email tidak ditemukan!"
                        exit
                    fi
                else
                    echo "Pilihan tidak valid!"
                    exit
                fi
            else
                echo "Login gagal, password salah!"
                echo "[$(date +"%d/%m/%y %H:%M:%S")] [LOGIN FAILED] Password salah! Admin dengan email $email gagal login" >> auth.log
            fi
```
Untuk Menambahkan user, program register.sh akan langsung dijalankan

### 2i
Sementara itu, untuk menghapus dan mengedit user, admin akan diminta untuk memasukkan email dari akun user yang ingin diedit/dihapus

### 2j
Semua kemungkinan keberhasilan serta kegagalan telah dicatat dengan baik dalam file auth.log

### Screenshot Hasil Pengerjaan
![Screenshot 2024-03-27 145904](https://github.com/krisadityabcde/Sisop-1-2024-MH-IT21/assets/144150187/4c8a9a24-1d56-47ce-97e5-70b0981cd8bf)

![WhatsApp Image 2024-03-27 at 15 22 14_12bb9e77](https://github.com/krisadityabcde/Sisop-1-2024-MH-IT21/assets/144150187/19cb149b-e682-4aa3-8ff2-0fef6ea37d77)

![WhatsApp Image 2024-03-27 at 15 25 40_f6cd7840](https://github.com/krisadityabcde/Sisop-1-2024-MH-IT21/assets/144150187/7c2e5315-b1e6-4ddc-8527-4afe00702b7f)

![WhatsApp Image 2024-03-27 at 15 37 01_2deff6be](https://github.com/krisadityabcde/Sisop-1-2024-MH-IT21/assets/144150187/cc80600b-c031-47fc-89d2-4e68bcc86914)

![WhatsApp Image 2024-03-27 at 15 37 01_6d9ccdf5](https://github.com/krisadityabcde/Sisop-1-2024-MH-IT21/assets/144150187/b575bbe6-864e-4b1b-976f-3b5755ee5bd3)

### Kendala
Tidak ada kendala

### Revisi
Tidak ada revisi

## Soal 3
### 3a
```shell
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
```
Pada soal ini, kita diminta untuk mendownload file (wget), unzip, rename, dan memindahkan file sesuai dengan folder regionnya

Untuk rename saya menggunakan for loop yang akan mengulangi tindakan untuk semua file dengan cara mendekripsi nama file terlebih dahulu, lalu mencari kecocokannya dengan nama yang sudah ada pada `list_character.csv` yang kemudian akan menjadi acuan bagi nama file yang bersangkutan. Dengan metode yang sama digunakan kembali untuk mencari nama region dari tiap file agar mampu mempermudah penyortiran nantinya.
Perintah `mv` pertama digunakan untuk mengubah nama file sementara `mv` kedua untuk memindahkan file ke direktori region masing-masing

### 3b
Setelah itu, untuk mencari tahu jumlah pengguna dari suatu senjata, saya menggunakan perintah `awk` dan memanfaatkan file `list_character.csv` dalam proses penghitungannya
```shell
awk -F ',' '
BEGIN {print "Jumlah karakter berdasarkan weapon : "}
/Claymore/ {a++}
/Sword/ {b++}
/Polearm/ {c++}
/Catalyst/ {d++}
/Bow/ {e++}
END {print "Claymore : "a"\nSword : "b"\nPolearm : "c"\nCatalyst : "d"\nBow : "e}
' /home/rafaelega24/SISOP/modul1/3/list_character.csv
```
Penghapusan file-file yang tidak diperlukan juga dilakukan dengan perintah `rm file.zip genshin_character.zip list_character.csv`

### 3c
Untuk mengerjakan soal ini saya menggunakan for loop yang diinisiasi untuk setiap file yang ada di dalam folder regionnya masing-masing
```
for region in Inazuma Mondstat Liyue Sumeru Fontaine; do
    for image in genshin_character/"$region"/*; do
        extract_value "$image"
        sleep 1
    done
done
```
Perintah `sleep 1` khususnya digunakan untuk menahan jalannya perintah selama 1 detik setiap kali perulangan dilakukan

Proses ekstraksi dan dekripsi akan dilakukan di dalam fungsi `extract_value()`
```
extract_value() {
    image_path="$1"
    txt_file="${image_path%.*}.txt"
    
    steghide extract -sf "$image_path" -xf "$txt_file" -p ""
    decrypted_value=$(cat "$txt_file" | base64 -d)

        if [[ $decrypted_value == *http* ]]; then
            clear
            rm "$txt_file"
            echo "Linknya ketemu bang! Ini linknya: $decrypted_value"
            echo "Link: $decrypted_value" >> link_tersembunyi.txt

            echo "Download bentar yh"
            wget -O rahasia_negara.jpg --no-check-certificate "$decrypted_value"

            echo "[$(date '+%d/%m/%y %H:%M:%S')] [FOUND] [$image_path]" >> image.log

            exit 0
        else
            echo "[$(date '+%d/%m/%y %H:%M:%S')] [NOT FOUND] [$image_path]" >> image.log
            rm "$txt_file"
        fi
```

### 3d
Setiap kali file `.txt` yang ditemukan tidak sesuai dengan yang diinginkan, maka file tersebut akan langsung dihapus, sedangkan jika file yang dimaksud telah ditemukan maka hasil dekripsi akan langsung disimpan
Tentunya setiap kali ekstraksi dan dekripsi juga akan tersimpan di dalan `image.log`

### 3e
<details>
<summary>Hasil akhir yang diharapkan telah berhasil sesuai dengan ketentuan:</summary>
  
  1. genshin_character
  2. search.sh
  3. awal.sh
  4. image.log
  5. link_tersembunyi.txt
  6. rahasia_negara.jpg
</details>

### Screenshot Hasil Pengerjaan
![WhatsApp Image 2024-03-27 at 16 06 25_bf26d35a](https://github.com/krisadityabcde/Sisop-1-2024-MH-IT21/assets/144150187/3bbbf36b-2444-4515-8e22-c095b4ff1d72)

![WhatsApp Image 2024-03-27 at 16 06 26_bb4fd049](https://github.com/krisadityabcde/Sisop-1-2024-MH-IT21/assets/144150187/e8200ac4-62eb-4f4d-8424-59c3e3b3040f)

![WhatsApp Image 2024-03-27 at 16 06 26_47031ce0](https://github.com/krisadityabcde/Sisop-1-2024-MH-IT21/assets/144150187/fadd3315-91ce-418c-b7ab-958aaef102bb)

![WhatsApp Image 2024-03-27 at 16 06 27_42485271](https://github.com/krisadityabcde/Sisop-1-2024-MH-IT21/assets/144150187/4fa73ff8-151f-43dc-baaa-b15a1ebca24e)

![WhatsApp Image 2024-03-27 at 16 06 57_dc325190](https://github.com/krisadityabcde/Sisop-1-2024-MH-IT21/assets/144150187/980314ee-48ce-41a5-9299-7e269236775f)

### Kendala
Tidak ada kendala

### Revisi
Tidak ada revisi

## Soal 4
### 4a
```shell
ram_status=$(free -m | awk 'NR==2{OFS=",";print $2,$3,$4,$5,$6,$7}')
swap_status=$(free -m | awk 'NR==3{OFS=",";print $2,$3,$4}')
disk_status=$(du -sh "/home/rafaelega24" | awk '{print $1}')

echo "mem_total,mem_used,mem_free,mem_shared,mem_buff_cache,mem_available,swap_total,swap_used,swap_free,path,path_size" > "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H%M%S').log"
echo "$ram_status,$swap_status,/home/rafaelega24,$disk_status" >> "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H%M%S').log"
```
Script ini digunakan untuk mencari tahu metrics dari ram dan storage yang kemudian akan disimpan ke dalam sebuah file dengan format `metrics_{YmdHms}.log`

### 4b
Agar script di atas mampu berjalan secara otomatis setiap 1 menit sekali, saya memanfaatkan crontab dan menggunakan konfigurasi sebagai berikut
```
* * * * * /home/rafaelega24/SISOP/modul1/4/minute_log.sh
```

### 4c
Kemudian semua file metrics di jam yang sama akan digabungkan ke dalam satu file yang sama menggunakan 
```shell
for file in /home/rafaelega24/log/*.log; do
    head -n 2 "$file" | tail -n 1 >> "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H').log"
done
```

Kumpulan metrics ini lalu diolah agar bsia mendapatkana nilai maksimum, minimum, dan rata-ratanya
```shell
min_ram_status=$(awk -F, '{OFS=",";print $1,$2,$3,$4,$5,$6}' "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H').log" | sort -n | head -1)
max_ram_status=$(awk -F, '{OFS=",";print $1,$2,$3,$4,$5,$6}' "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H').log" | sort -n | tail -1)
avg_ram_status=$(awk -F, '{OFS=",";print $1,$2,$3,$4,$5,$6}' "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H').log" | awk -F, '{for(i=1;i<=NF;i++) sum[i]+=$i} END {for(i=1;i<=NF;i++) printf sum[i]/NR ","}' | sed 's/,$//')
min_swap_status=$(awk -F, '{OFS=",";print $7,$8,$9}' "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H').log" | sort -n | head -1)
max_swap_status=$(awk -F, '{OFS=",";print $7,$8,$9}' "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H').log" | sort -n | tail -1)
avg_swap_status=$(awk -F, '{OFS=",";print $7,$8,$9}' "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H').log" | awk -F, '{for(i=1;i<=NF;i++) sum[i]+=$i} END {for(i=1;i<=NF;i++) printf sum[i]/NR ","}' | sed 's/,$//')
min_disk_status=$(awk -F, '{print $11}' "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H').log" | sort -n | head -1)
max_disk_status=$(awk -F, '{print $11}' "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H').log" | sort -n | tail -1)
avg_disk_status=$(awk -F, '{print $11}' "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H').log" | awk '{sum+=$1} END {print sum/NR}')
```

Lalu hasil olah data yang telah dilakukan digabungkan ke dalam satu file dengan format  `metrics_agg_{YmdH}.log`
```shell
echo "type,mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size
maximum,$max_ram_status,$max_swap_status,/home/rafaelega24,$max_disk_status
minimum,$min_ram_status,$min_swap_status,/home/rafaelega24,$min_disk_status 
avgerage,$avg_ram_status,$avg_swap_status,/home/rafaelega24,$avg_disk_status" | sudo tee "/home/rafaelega24/log/metrics_agg_$(date +'%Y%m%d%H').log"
```

Script untuk agregasi file ini akan dijalankan setiap 1 jam sekali juga menggunakan crontab dengan konfigurasi sebagai berikut
```
59 * * * * /home/rafaelega24/SISOP/modul1/4/aggregate_minutes_to_hourly_log.sh
```

### 4d
Semua file log harus diubah aksesnya agar bisa dibaca hanya oleh pemilik
```shell
chmod 400 "/home/rafaelega24/log/metrics_$(date +'%Y%m%d%H%M%S').log"
chmod 400 "/home/rafaelega24/log/metrics_agg_$(date +'%Y%m%d%H').log"
```

### Screenshot Hasil Pengerjaan
![WhatsApp Image 2024-03-27 at 16 40 40_0f0f5a49](https://github.com/krisadityabcde/Sisop-1-2024-MH-IT21/assets/144150187/9be3add0-23db-45b3-aa1b-c026eefd77b0)

![WhatsApp Image 2024-03-27 at 16 40 40_4919f2cb](https://github.com/krisadityabcde/Sisop-1-2024-MH-IT21/assets/144150187/da66a63b-17e0-40c5-bf89-aae41bda9d96)

![WhatsApp Image 2024-03-27 at 16 40 40_1e8cf1e8](https://github.com/krisadityabcde/Sisop-1-2024-MH-IT21/assets/144150187/7993a40a-23ac-4324-bdc1-309e2130c615)

### Kendala
Tidak ada kendala

### Revisi
Tidak ada revisi
