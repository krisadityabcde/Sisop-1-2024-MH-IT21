#!/bin/bash

echo "Login Akun"
echo "1. Login"
echo "2. Lupa Password"

read -p "Pilihan: " pilihan

if [ $pilihan -eq 1 ]; then
    read -p "Masukkan E-mail: " email
    if grep -q "$email" users.txt ; then
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

        else
            read -sp "Masukkan Password: " password
            pass_aman=$(echo -n "$password" | base64)

            if awk -F ':' -v email=$email '$1 == email{print}' users.txt | grep -q "$pass_aman"; then
                echo "Login berhasil! Selamat datang $(awk -F ':' -v email=$email '$1 == email {print $2}' users.txt)"
                echo "[$(date +"%d/%m/%y %H:%M:%S")] [LOGIN SUCCESS] Pengguna dengan email $email berhasil login" >> auth.log
            else
                echo "Login gagal, password salah!"
                echo "[$(date +"%d/%m/%y %H:%M:%S")] [LOGIN FAILED] Password salah! Pengguna dengan email $email gagal login" >> auth.log
            fi
        fi
    else
    echo "Email tidak terdaftar!"
    echo "[$(date +"%d/%m/%y %H:%M:%S")] [LOGIN FAILED] Email $email tidak terdaftar" >> auth.log
    fi
elif [ $pilihan -eq 2 ]; then
    read -p "Masukkan E-mail: " email
    if grep -q "$email" users.txt; then
        echo "Pertanyaan Keamanan: $(awk -F ':' -v email=$email '$1 == email {print $3}' users.txt)"
        read -p "Jawaban: " jawaban
        if awk -F ':' -v email=$email '$1 == email{print}' users.txt | grep -q "$jawaban"; then
            echo "Password anda: $(awk -F ':' -v email=$email '$1 == email {print $5}' users.txt | base64 -d)"
            echo "[$(date +"%d/%m/%y %H:%M:%S")] [LOGIN SUCCESS] Pengguna dengan email $email berhasil login" >> auth.log
        else
            echo "Jawaban salah!"
            echo "[$(date +"%d/%m/%y %H:%M:%S")] [LOGIN FAILED] Jawaban pertanyaan keamanan salah untuk email $email" >> auth.log
            exit
        fi
    else
        echo "Email tidak terdaftar!"
        echo "[$(date +"%d/%m/%y %H:%M:%S")] [LOGIN FAILED] Email $email tidak terdaftar" >> auth.log
    fi
else
    echo "Pilihan tidak valid!"
    exit
fi
