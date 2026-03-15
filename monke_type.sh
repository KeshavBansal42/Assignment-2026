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
read -n 1 -s difficulty
clear

RED='\033[0;41m'
NC='\033[0m'
GREEN='\033[0;42m'

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

    # start_time=$(date +%s)

    # read -p "> " user_input
    start_time=$(date +%s)
    user_input=""
    display_input=""
    temp="$target_text"
    target_len=${#target_text}
    i=0
    # for ((i=0; i<target_len; i++ )); do
    while true; do
        current_time=$(date +%s)
        elapsed_time=$((current_time-start_time))
        echo "===================================="
        echo "Live Timer: $elapsed_time s"
        echo "===================================="
        echo "Type this MF:"
        # echo "$target_text"
        echo "===================================="
        echo -e "$display_input${temp:i}"
        IFS= read -t 0.1 -s -n 1 input_key
        if [[ -n "$input_key" ]]; then
            char_input="$input_key"
            if [[ "$char_input" == $'\x7f' ]] || [[ "$char_input" == $'\x08' ]]; then
                user_input=${user_input%?}
                display_input=${display_input%??????????????????}
                if [[ "$i" -gt "0" ]]; then
                    i=$((i-2))
                fi
            else
                user_input="$user_input$char_input"
                # temp="${temp:1}"
                if [[ "$char_input" == "${target_text:$i:1}" ]]; then
                    display_input="${display_input}${GREEN}$char_input${NC}"
                else
                    display_input="${display_input}${RED}$char_input${NC}"
                fi
            fi
            ((i++))
        fi
        # clear
        echo -ne "\033[H"
        if [[ "$i" -eq "$target_len" ]]; then
            break;
        fi
    done

    clear

    end_time=$(date +%s)
    time_taken=$((end_time - start_time))

    if [ "$time_taken" -eq 0 ]; then
        time_taken=1
    fi

    char_count=${#user_input}
    words_typed=$((char_count / 5))
    wpm=$(( (words_typed * 60) / time_taken ))

    correct_words=0
    # target_len=${#target_text}

    # for (( i=0; i<target_len; i++ )); do
    #     char_target="${target_text:$i:1}"
    #     char_user="${user_input:$i:1}"

    #     if [[ "$char_target" == "$char_user" ]]; then
    #         ((correct_chars++))
    #     fi
    # done

    # accuracy=$(( (correct_chars * 100) / target_len ))

    target_words=($target_text)
    user_words=($user_input)

    target_words_len=${#target_words[@]}

    for (( i=0; i<target_words_len; i++ )); do
        if [[ "${target_words[$i]}" == "${user_words[$i]}" ]]; then
            ((correct_words++))
        fi
    done

    accuracy=$(( (correct_words * 100) / target_words_len ))

    echo -e "\n-------RESULTS-------"
    echo "Time: $time_taken seconds"
    echo "WPM: $wpm"
    echo "Accuracy: $accuracy%"
    echo "---------------------"
    # echo "$user_input"

    timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    echo "[$timestamp] Level: $difficulty | Time taken: $time_taken seconds | WPM: $wpm | Accuracy: $accuracy%" >> score_history.txt

    echo -e "\nPress [ENTER] to try again, type 'h' for past scores or type 'q' to quit."
    read -n 1 -r -s choice

    if [[ "$choice" == "h" || "$choice" == "H" ]]; then
        if [ -f "score_history.txt" ]; then
            echo -e "\n-------Past-Scores-------\n"
            tail -n 5 score_history.txt

            echo -e "\n--- WPM PROGRESS GRAPH (Last 10 Games) ---\n"

            wpm_scores=$(tail -n 10 score_history.txt | grep -Eo 'WPM: [0-9]+' | grep -Eo '[0-9]+')
            game_num=1

            for w in $wpm_scores; do
                bar_length=$((w/3))
                bar=$(printf "%${bar_length}s" | tr ' ' '#')
                printf "Game %2d (%3d WPM): %s\n" "$game_num" "$w" "$bar"

                ((game_num++))
            done
            echo -e "\n------------------------------------------------------------"
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