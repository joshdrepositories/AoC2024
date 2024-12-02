#!/bin/bash
grep -o -- '[0-9].* ' input.txt | sed 's/   //' > column1.txt
grep -o -- ' .[0-9]*$' input.txt | sed 's/  //' > column2.txt
