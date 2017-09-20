#!/bin/bash

#Variables
RED='\033[0;31m'
GREN='\033[0;32m'
NC='\033[0m' # No Color
count=1
#Function
function list(){
for i in $(ls --sort=extension);do
	if [ -f $i ];then
		printf "$((count++))\t${RED}File\t${NC}$i\n"
	elif [ -d $i ]; then 
		printf "$((count++))  ${GREN}Directory\t${NC}$i\n"
	fi
done
count=1   
}
function add_user_squid(){
	echo "Add User Ssquid Proxy"
	printf "Enter User name : "
	read User
	printf "Enter Password  : "
	read Password
	printf "User ${GREN}$User\t${NC}Password\t${GREN}$Password\n${NC}"
	if [ -f /etc/squid/passwd ];then
		htpasswd  -b /etc/squid/passwd $User $Password
	else 
		htpasswd -c  -b /etc/squid/passwd $User $Password		
	fi
}
function see_log_squid(){
	clear
	echo "log monitor"
	echo "Input user"
	read User
	tail -f /var/log/squid/access.log |grep $User |awk 'BEGIN{printf "User Name\tFrom IP\tConnection to\tWebsite\n"}{print $8"\t"$3"\t"$9"\t" $7 }'
}

#Main
#while true; do 
#echo "Select Program 
#      1 ) See log squid\n "
#
#read option;
#	if [ $option == "1" ];then
#		see_log_squid;
#	elif [ $option == "2" ];then
#		add_user_squid
#	elif [ $option == "3" ];then
#		list
#	elif [ $option == "exit" ];then
#		exit 0;
#	else
#		echo "Plest Enter options"
#	fi
#done




