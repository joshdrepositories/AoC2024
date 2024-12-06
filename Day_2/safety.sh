#!/bin/bash

safe_lines=0
total_lines=$(wc -l < input.txt)

for (( line_number=1; line_number<=total_lines; line_number++ )); do
    line_content=$(sed "$line_number!d" input.txt)

    read -a words <<< "$line_content"
    word_count=${#words[@]}

    line_passed=true
    direction=0

    for (( i=1; i<word_count; i++ )); do
        prev_word="${words[i-1]}"
        curr_word="${words[i]}"

        diff=$(( curr_word - prev_word ))
        abs_diff=${diff#-}  # Absolute value of diff

        #see if numbers are gradually increasing or decreasing
        if [ "$abs_diff" -lt 1 ] || [ "$abs_diff" -gt 3 ]; then
            echo "Line $line_number: Failed at word $((i+1))"
            line_passed=false
            break
        fi

        if [ $direction -eq 0 ]; then
            if [ $diff -gt 0 ]; then
                direction=1 # increasing
            else
                direction=-1 # decreasing
            fi
        else
            # Check if direction is consistent
            if [ $direction -eq 1 ] && [ $diff -le 0 ]; then
                echo "Line $line_number: Failed at word $((i+1)) (Direction changed from increasing to decreasing)"
                line_passed=false
                break
            fi
            if [ $direction -eq -1 ] && [ $diff -ge 0 ]; then
                echo "Line $line_number: Failed at word $((i+1)) (Direction changed from decreasing to increasing)"
                line_passed=false
                break
            fi
        fi
    done
    
    if $line_passed; then
        safe_lines=$((safe_lines + 1))
        echo "Line $line_number: safe"
    else
        echo "Line $line_number: failed"
    fi
done
echo $safe_lines
