#!/bin/bash

if [[ $EUID -ne 0 ]];
then
	echo "$0 is not runnign as root. Run this script with sudo."
	exit 0
else
	mapfile RS_list < Rockstarserverlist.csv
	
	for i in "${RS_list[@]}"
	do
		nmap -sS $(echo "$i" | awk -F',' '{printf $1}' | sed "s/\n//g" | awk -F'/' '{print $1}')
	done
fi
