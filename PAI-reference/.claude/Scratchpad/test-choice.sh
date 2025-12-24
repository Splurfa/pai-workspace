#!/bin/bash

# Test the case statement logic with different inputs

test_choice() {
    local choice="$1"
    local PAI_DIR
    local DEFAULT_DIR="$HOME/PAI"

    case $choice in
        1)
            PAI_DIR="$HOME/PAI"
            ;;
        2)
            PAI_DIR="$HOME/Projects/PAI"
            ;;
        3)
            PAI_DIR="$HOME/Documents/PAI"
            ;;
        4)
            PAI_DIR="custom"
            ;;
        *)
            PAI_DIR="$DEFAULT_DIR"
            ;;
    esac

    echo "Input: [$choice] -> Result: $PAI_DIR"
}

echo "Testing without whitespace trim:"
test_choice "1"
test_choice "2"
test_choice "2 "
test_choice " 2"
test_choice " 2 "

echo ""
echo "Testing WITH whitespace trim:"
test_choice_trimmed() {
    local choice="$1"
    # Trim whitespace
    choice=$(echo "$choice" | xargs)

    local PAI_DIR
    local DEFAULT_DIR="$HOME/PAI"

    case $choice in
        1)
            PAI_DIR="$HOME/PAI"
            ;;
        2)
            PAI_DIR="$HOME/Projects/PAI"
            ;;
        3)
            PAI_DIR="$HOME/Documents/PAI"
            ;;
        4)
            PAI_DIR="custom"
            ;;
        *)
            PAI_DIR="$DEFAULT_DIR"
            ;;
    esac

    echo "Input: [$choice] -> Result: $PAI_DIR"
}

test_choice_trimmed "1"
test_choice_trimmed "2"
test_choice_trimmed "2 "
test_choice_trimmed " 2"
test_choice_trimmed " 2 "
