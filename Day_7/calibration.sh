#!/bin/bash

grep -Eo -- "[0-9]+:" input.txt | sed 's/://' > test_values.txt
grep -Eo -- ": .*" input.txt | sed 's/: //' > operators.txt
