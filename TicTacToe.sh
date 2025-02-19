#!/bin/bash

board=( "-" "-" "-" "-" "-" "-" "-" "-" "-" )

display_board() {
    echo "  1 2 3"
    echo "1 ${board[0]} ${board[1]} ${board[2]}"
    echo "2 ${board[3]} ${board[4]} ${board[5]}"
    echo "3 ${board[6]} ${board[7]} ${board[8]}"
    echo ""
}

convert_input() {
    local r=$1
    local c=$2
    if [[ $r == 1 && $c == 1 ]]; then
        echo 0
    elif [[ $r == 1 && $c == 2 ]]; then
        echo 1
    elif [[ $r == 1 && $c == 3 ]]; then
        echo 2
    elif [[ $r == 2 && $c == 1 ]]; then
        echo 3
    elif [[ $r == 2 && $c == 2 ]]; then
        echo 4
    elif [[ $r == 2 && $c == 3 ]]; then
        echo 5
    elif [[ $r == 3 && $c == 1 ]]; then
        echo 6
    elif [[ $r == 3 && $c == 2 ]]; then
        echo 7
    elif [[ $r == 3 && $c == 3 ]]; then
        echo 8
    fi
}

check_winner() {
    local symbol=$1
    if [[ (${board[0]} == "$symbol" && ${board[1]} == "$symbol" && ${board[2]} == "$symbol") \
            || (${board[3]} == "$symbol" && ${board[4]} == "$symbol" && ${board[5]} == "$symbol") \
            || (${board[6]} == "$symbol" && ${board[7]} == "$symbol" && ${board[8]} == "$symbol") \
            || (${board[0]} == "$symbol" && ${board[3]} == "$symbol" && ${board[6]} == "$symbol") \
            || (${board[1]} == "$symbol" && ${board[4]} == "$symbol" && ${board[7]} == "$symbol") \
            || (${board[2]} == "$symbol" && ${board[5]} == "$symbol" && ${board[8]} == "$symbol") \
            || (${board[0]} == "$symbol" && ${board[4]} == "$symbol" && ${board[8]} == "$symbol") \
            || (${board[2]} == "$symbol" && ${board[4]} == "$symbol" && ${board[6]} == "$symbol") ]]; then
        return 0
    fi
    return 1
}

is_draw() {
    for cell in "${board[@]}"; do
        if [[ $cell == "-" ]]; then
            return 1  
        fi
    done
    return 0 
}

player="X"

echo "For each turn you need to choose a pair of [row column]. For example: 3 1."
echo ""

while true; do
    echo ""
    display_board
    echo "${player} turn."
    
    while true; do
        read -r row column
        if [[("$row" == "1"|| "$row" == "2" || "$row" == "3") && ("$column" == "1" || "$column" == "2" || "$column" == "3")]]; then
            board_idx=$(convert_input $row $column)
            if [[ ${board[$board_idx]} == "-" ]]; then
                board[$board_idx]=${player}
                break
            else
                echo "Board place already used! Choose diffrent one."
                echo ""
            fi
        else
            echo "Invalid input! Row: $row Column: $column Row and column should be one of [1 2 3]"
            echo ""
        fi
    done

    if check_winner "${player}"; then
        echo ""
        display_board
        echo "${player} wins!"
        exit
    fi

    if is_draw; then
        echo ""
        display_board
        echo "It's a draw!"
        exit
    fi

    if [[ $player == "X" ]]; then
        player="O"
    else
        player="X"
    fi
done
