#!/bin/bash
set -x
set -f

grep -Eo -- "[0-9]+:" input.txt | sed 's/://' > test_values.txt
grep -Eo -- ": .*" input.txt | sed 's/: //' > equations.txt

mapfile -t values < test_values.txt
mapfile -t lines < equations.txt

total_sum=0

generate_ops() {
    local n=$1
    if [ $n -le 0 ]; then
        return
    elif [ $n -eq 1 ]; then
        echo "+"
        echo "*"
    else
        while IFS= read -r sub; do
            echo "+ $sub"
            echo "* $sub"
        done < <(generate_ops $((n-1)))
    fi
}

evaluate_left_to_right() {
    local arr=("$@")
    local val=${arr[0]}
    local i=1
    while [ $i -lt ${#arr[@]} ]; do
        op=${arr[$i]}
        next_num=${arr[$((i+1))]}
        if [ "$op" = "+" ]; then
            val=$((val + next_num))
        elif [ "$op" = "*" ]; then
            val=$((val * next_num))
        else
            exit 1
        fi
        i=$((i+2))
    done
    echo $val
}

for i in "${!values[@]}"; do
    target=${values[$i]}
    line=${lines[$i]}

    integers=($line)
    count=${#integers[@]}

    if [ $count -eq 1 ]; then
        if [ "${integers[0]}" -eq "$target" ]; then
            total_sum=$((total_sum + target))
        fi
        continue
    fi

    found="no"

    while IFS= read -r ops; do
        ops_arr=($ops)
        eval_arr=()
        eval_arr+=("${integers[0]}")
        for ((idx=1; idx<count; idx++)); do
            eval_arr+=("${ops_arr[$((idx-1))]}")
            eval_arr+=("${integers[$idx]}")
        done

        result=$(evaluate_left_to_right "${eval_arr[@]}")
        if [ "$result" -eq "$target" ]; then
            found="yes"
            break
        fi
    done < <(generate_ops $((count-1)))

    if [ "$found" = "yes" ]; then
        total_sum=$((total_sum + target))
    fi
done

echo "Sum of all computable values: $total_sum"
