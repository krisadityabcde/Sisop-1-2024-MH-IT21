#!/bin/bash

echo "Registrasi Akun Baru"

read -p "Masukkan E-mail Anda: " email

if grep -q "$email" users.txt; then
    echo "E-mail sudah terdaftar, mohon gunakan e-mail lain!"
    echo "[$(date +"%d/%m/%y %H:%M:%S")] [REGISTER FAILED] Email $email sudah terdaftar" >> auth.log
else
    read -p "Masukkan Username Anda: " username
    read -p "Masukkan Pertanyaan Keamanan: " pertanyaan
    read -p "Masukkan Jawaban dari Pertanyaan Keamanan: " jawaban
    echo "Password harus lebih dari 8 karakter, mengandung huruf besar, huruf kecil, angka, karakter spesial, dan tidak boleh sama dengan username"
    read -sp "Masukkan Password: " password
    if [[ ${#password} -lt 8 || ! ("$password" =~ [A-Z]) || ! ("$password" =~ [a-z]) || ! ("$password" =~ [0-9]) || ! ("$password" =~ [^a-zA-Z0-9]) || ! ("$password" =~ [!@#]) || ("$password" == "$username") ]]; then
        echo "Password tidak memenuhi kriteria, mohon masukkan password sesuai dengan kriteria yang telah ditentukan!"
        echo "[$(date +"%d/%m/%y %H:%M:%S")] [REGISTER FAILED] Password tidak memenuhi kriteria" >> auth.log
    else
        pass_aman=$(echo -n "$password" | base64)
        echo "$email:$username:$pertanyaan:$jawaban:$pass_aman" >> users.txt
        echo "[$(date +"%d/%m/%y %H:%M:%S")] [REGISTER SUCCESS] Pengguna $username berhasil terdaftar" >> auth.log
        printf "\nRegistrasi akun berhasil!\n"
    fi
fi
