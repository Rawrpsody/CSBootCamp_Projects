#!/bin/bash
echo "Enter date: (mmdd)"
read date
echo "Enter time: (00:00:00 AM/PM)"
read clock
echo "Game: [1]Blackjack | [2]Roulette | [3]Texas Hold 'Em"
read game

dealer_log_file=$(cat $date\_Dealer_schedule)
clock=$(echo "$clock" | tr '[:lower:]' '[:upper:]' | sed 's/\.//g')
game=$(echo "$game+1" | bc)
game=$(echo '$'$game)
printf "\n"
echo "$date | $clock | $game" | sed 's/\$//g'
echo "$dealer_log_file" | grep -i "$clock" | awk -F'\t' '{print $2}' | awk -F'\t' '{print $game}' 
