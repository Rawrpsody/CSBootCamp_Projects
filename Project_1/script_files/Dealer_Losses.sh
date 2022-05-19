#!bin/bash


#Get Losses in Roulette_Loss_Investigation/Player_Analysis/Roulette_Losses
#date
d=($(awk '{print $1}' Roulette_Loss_Investigation/Player_Analysis/Roulette_Losses))
#time
t=($(awk '{print $2 $3}' Roulette_Loss_Investigation/Player_Analysis/Roulette_Losses | sed 's/ AM/AM/' | sed 's/ PM/PM/'))
#Get Dealer in Roulette_Loss_Investigation/Dealer_Analysis/

#Ask User for date lookup of days with Loss

printf 'Enter date [0000]:'
read user_input

#Get and Filter only lines with losses
player_loss_log=$(grep -i - Roulette_Player_WinLoss_0310/$user_input\_win_loss_player_data | sed 's/   */\t/g')
loss_log_count=$(printf "$player_loss_log" | wc -l)
player_loss_log_time=($(printf "$player_loss_log" | awk -F'\t' '{print $1}'))
dealer_log=$(cat Roulette_Loss_Investigation/Dealer_Analysis/$user_input\_Dealer_schedule)
max_line_loss_log=$(printf "$player_loss_log" | wc -l)

GET_DEALERS () {
for (( i=1; i<=$max_line_loss_log; i++ ))
do
	test=$(printf ${t[i-1]} | sed -e 's/AM/ AM/' -e 's/PM/ PM/')
	printf "$dealer_log" | grep -i "$test"
done
}

dealers=$(GET_DEALERS)
roulette_dealers=$(printf "$dealers" | awk -F'\t' '{print $1 "	" $3}')
sussy_bakka_dealer=$(printf "$roulette_dealers" | awk -F'\t' '{print $2}' | sort | uniq -d)
sussy_bakka_dealer_count=$(printf "$roulette_dealers" | awk -F'\t' '{print $2}' | wc -l)

#Filter repeating names
player_names=$(printf "$player_loss_log" | awk -F'\t' '{print $3}')
sussy_bakka_player=$(printf "$player_names" | sed 's/\t//g' | sed 's/, /,/g' | sed 's/ ,/,/g' | sed 's/,/\n/g' | sed 's/ *$//g' | sed 's/\t,/,/g' | sed 's/,\t/,/g' | sort | uniq -d)
sussy_bakka_player_count=$(printf "$player_names" | sed 's/\t//g' | sed 's/, /,/g' | sed 's/ ,/,/g' | sed 's/,/\n/g' | sed 's/ *$//g' | sort | uniq -cd | awk '{print $1}')
#Display

evidence_player_log=$(printf "Date: [$user_input]\nLosses Occured: $loss_log_count times\n$player_loss_log\nSuspicious: $sussy_bakka_player with $sussy_bakka_player_count plays during loss\n\n")
evidence_dealer_log=$(printf "Date: [$user_input]\n$roulette_dealers\nPrimary dealer during loss: $sussy_bakka_dealer worked $sussy_bakka_dealer_count times\n\n")

printf "$evidence_player_log\n\n$evidence_dealer_log\n"

printf "Log Player and Dealer evidence? (Y/N): "
read user_input_log

user_input_log=${user_input_log:0:1}
user_input_log=$(printf "$user_input_log" | tr '[:upper:]' '[:lower:]' | sed 's/y/1/' | sed 's/n/0/')

if [ "$user_input_log" -eq 1 ]
then
#Copy Evidence Player - LOG
	printf "$evidence_player_log" >> Roulette_Loss_Investigation/Players_playing_during_losses
#Copy Evidence Dealer - LOG
	printf "$evidence_dealer_log" >> Roulette_Loss_Investigation/Dealers_working_during_losses 
	printf ""
	printf "PRINTING COMPLETE!"
fi
