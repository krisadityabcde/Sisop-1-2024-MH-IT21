#!/bin/bash

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
}

for region in Inazuma Mondstat Liyue Sumeru Fontaine; do
    for image in genshin_character/"$region"/*; do
        extract_value "$image"
        sleep 1
    done
done
