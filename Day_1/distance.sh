#!/bin/bash

#grep each column, remove whitespace, sort numerically
grep -o -- '[0-9].* ' input.txt | sed 's/   //' | sort -n > column1.txt
grep -o -- ' .[0-9]*$' input.txt | sed 's/  //' | sort -n > column2.txt
