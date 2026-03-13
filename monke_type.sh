#!/bin/bash

sentences_easy=(
    "the quick brown fox jumps"
    "a simple test of typing speed"
    "hello world we meet again"
    "keep your fingers on the keys"
    "apples and oranges are good fruits"
)

sentences_medium=(
    "The quick brown fox jumps over the lazy dog."
    "Bash scripting can be really fun once you get the hang of it."
    "Linux terminal is a powerful tool for developers."
    "Practice makes perfect, especially when typing fast."
    "Don't forget to check your spelling and punctuation."
)

sentences_hard=(
    "awk -F':' '{print \$1}' /etc/passwd | grep 'root'"
    "The IP address 192.168.1.104 with subnet 255.255.255.0."
    "Regex pattern: ^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\$"
    "function is_valid() { return (x > 10 && y <= 20); }"
    "Wow! That #TypingTest cost me \$45.99 & took 100% effort."
)

get_random_easy_sentence() {
    local size=${#sentences_easy[@]}
    local index=$((RANDOM % size))
    echo "${sentences_easy[$index]}"
}

get_random_medium_sentence() {
    local size=${#sentences_medium[@]}
    local index=$((RANDOM % size))
    echo "${sentences_medium[$index]}"
}

get_random_hard_sentence() {
    local size=${#sentences_hard[@]}
    local index=$((RANDOM % size))
    echo "${sentences_hard[$index]}"
}

clear

echo "Welcome to MonkeType!"
echo "Select difficulty: ([e]asy/[m]edium/[h]ard)"
read difficulty

echo "Press [Enter] when you are ready to start..."
read -s

while true; do
    clear
    # target_text=$(get_random_sentence)
    if [[ "$difficulty" == "e" ]]; then
        target_text=$(get_random_easy_sentence)
    elif [[ "$difficulty" == "m" ]]; then
        target_text=$(get_random_medium_sentence)
    elif [[ "$difficulty" == "h" ]]; then
        target_text=$(get_random_hard_sentence)
    else
        target_text=$(get_random_easy_sentence)
    fi

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
    echo "Accuracy: $accuracy%"
    echo "---------------------"

    timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    echo "[$timestamp] Level: $difficulty | Time taken: $time_taken seconds | WPM: $wpm | Accuracy: $accuracy%" >> score_history.txt

    echo -e "\nPress [ENTER] to try again, type 'h' for past scores or type 'q' to quit."
    read -r choice

    if [[ "$choice" == "h" || "$choice" == "H" ]]; then
        if [ -f "score_history.txt" ]; then
            echo "-------Past-Scores-------"
            tail -n 5 score_history.txt
            echo "For more past scores check the contents of score_history.txt"

            echo "Press [ENTER] to continue to the next round."
            read -s
        else
            echo "No history yet!"
        fi
    elif [[ "$choice" == "q" || "$choice" == "Q" ]]; then
        echo "Thanks for playing!"
        break
    fi
done