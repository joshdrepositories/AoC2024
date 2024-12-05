#!/bin/bash

for line_number in {1..1000}; do
    line_content=$(sed "$line_number!d" input.txt)
    #echo $line_content

    word_count=$(echo $line_content | wc -w)

    read -a words <<< "$line_content"

    word_number=1

    line_passed=true

    for (( i=1; i<$word_count; i++ )); do
        if [ $((${words[i]} - ${words[i-1]})) -ge 1 ] && [ $((${words[i]} - ${words[i-1]})) -lt 4 ]; then
            echo "word number $word_number is gradually increasing from word number $(( $word_number - 1 ))"
        elif [ $((${words[i-1]} - ${words[i]})) -ge 1 ] && [ $((${words[i-1]} - ${words[i]})) -lt 4 ]; then
            echo "word number $word_number is gradually decreasing from word number $(( $word_number - 1 ))"
        else
            line_passed=false
            break
        fi
        word_number=$((word_number + 1))
    done
    
    if $line_passed; then
        safe_lines=$((safe_lines + 1))
    else
        echo "Line $line_number: failed"
    fi
done
echo $safe_lines
