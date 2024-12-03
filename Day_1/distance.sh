#!/bin/bash

#grep each column, remove whitespace, sort numerically
grep -o -- '[0-9].* ' input.txt | sed 's/   //' | sort -n > column1.txt
grep -o -- ' .[0-9]*$' input.txt | sed 's/  //' | sort -n > column2.txt

for line_number in {1..1000}; do
    value1=$(sed "$line_number!d" column1.txt)
    value2=$(sed "$line_number!d" column2.txt)

    if [ $value1 -gt $value2 ]; then
        diff=$((value1 - value2))
        echo $diff
    else
        diff=$((value2 - value1))
        echo $diff
    fi

    total_diff=$((total_diff + diff))
done

echo "Total is $total_diff"

for line_number in {1..1000}; do

    value1=$(sed "$line_number!d" column1.txt)

    sim=$(grep -o "$value1" column2.txt | wc -l)

    sim_score=$((sim * value1))
    echo "$value1 similarity score: $sim_score"

    total_sim_score=$((total_sim_score + sim_score))
done
echo "total similarity score: $total_sim_score"
