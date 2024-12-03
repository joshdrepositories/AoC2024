#!/bin/bash

for line_number in {1..1000}; do
    line_content=$(sed "$line_number!d" input.txt)
    echo $line_content

    word_count=$(echo $line_content | wc -w)
    echo $word_count
done
