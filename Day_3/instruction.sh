#!/bin/bash

grep -o -- "mul(.[0-9].,.[0-9].)" input.txt | sed 's/mul//' | sed 's/,/*/' | sed 's/((/(/' | sed 's/))/)/' > uncorrupted.txt

for line_number in {1..553}; do
    line_content=$(sed "$line_number!d" uncorrupted.txt)
    echo $line_content

    product=$(($line_content))
    echo "Product for line $line_number is $product"

    product_sum=$((product_sum + product))
done
echo "Sum of all products: $product_sum"
