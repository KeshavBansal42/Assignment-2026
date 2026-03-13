#!/bin/bash

sentences=(
    "The quick brown fox jumps over the lazy dog."
    "Bash scripting can be really fun once you get the hang of it."
    "Linux terminal is a powerful tool for developers and system admins."
    "Practice makes perfect, especially when learning how to type fast."
)

get_random_sentence() {
    local size=${#sentences[@]}
    local index=$((RANDOM % size))
    echo "${sentences[$index]}"
}

clear

echo "Welcome to MonkeType!"
echo "Press [Enter] when you are ready to start..."
read -s

while true; do
    clear
    target_text=$(get_random_sentence)

    echo "===================================="
    echo "Type this MF:"
    echo "$target_text"
    echo "===================================="

    start_time=$(date +%s)

    read -p "> " user_input

    end_time=$(date +%s)
    time_taken=$((end_time - start_time))

    if [ "$time_taken" -eq 0 ]; then
        time_taken=1
    fi

    char_count=${#user_input}
    words_typed=$((char_count / 5))
    wpm=$(( (words_typed * 60) / time_taken ))

    correct_chars=0
    target_len=${#target_text}

    for (( i=0; i<target_len; i++ )); do
        char_target="${target_text:$i:1}"
        char_user="${user_input:$i:1}"

        if [[ "$char_target" == "$char_user" ]]; then
            ((correct_chars++))
        fi
    done

    accuracy=$(( (correct_chars * 100) / target_len ))

    echo -e "\n-------RESULTS-------"
    echo "Time: $time_taken seconds"
    echo "WPM: $wpm"
    echo "Accuracy: $accuracy"
    echo "---------------------"

    echo -e "\nPress [ENTER] to try again, or type 'q' to quit."
    read -r choice

    if [[ "$choice" == "q" || "$choice" == "Q" ]]; then
        echo "Thanks for playing!"
        break
    fi
done