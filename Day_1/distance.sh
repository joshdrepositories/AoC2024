#!/bin/bash


#grep each column, remove whitespace, sort numerically
grep -o -- '[0-9].* ' input.txt | sed 's/   //' | sort -n > column1.txt
grep -o -- ' .[0-9]*$' input.txt | sed 's/  //' | sort -n > column2.txt

for line_number in {1..1000}; do
    value1=$(sed "$line_number!d" column1.txt)
    value2=$(sed "$line_number!d" column2.txt)

    if [ $value1 -gt $value2 ]; then
        awk "BEGIN { diff = $value1 - $value2; print diff }"
    else
        awk "BEGIN { diff = $value2 - $value1; print diff }"
    fi
done
