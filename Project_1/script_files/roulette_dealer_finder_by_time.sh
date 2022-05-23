#!/bin/bash
echo "Enter date: (mmdd)"
read date
echo "Enter time: (00:00:00 AM/PM)"
read clock

dealer_log_file=$(cat $date\_Dealer_schedule)
clock=$(echo "$clock" | tr '[:lower:]' '[:upper:]' | sed 's/\.//g')
printf "\n"
echo "$dealer_log_file" | grep -i "$clock" | awk -F'\t' '{print $1, $3}'
