#!/bin/bash

line_number=1

shopt -s expand_aliases

#grep each column, remove whitespace, sort numerically
grep -o -- '[0-9].* ' input.txt | sed 's/   //' | sort -n > column1.txt
grep -o -- ' .[0-9]*$' input.txt | sed 's/  //' | sort -n > column2.txt

alias column1_number='sed "$line_number!d" column1.txt'
alias column2_number='sed "$line_number!d" column2.txt'

value1=$(column1_number)
value2=$(column2_number)

#if value

awk "BEGIN { diff = $value1 - $value2; print diff }"
