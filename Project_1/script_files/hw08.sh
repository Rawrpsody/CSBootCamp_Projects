#!/bin/bash

mapfile RS_list < Rockstarserverlist.csv

for i in "${RS_list[@]}"
do
	fping -s $(echo "$i" | awk -F',' '{printf $1}' | sed "s/\n//g" | awk -F'/' '{print $1}')
done
