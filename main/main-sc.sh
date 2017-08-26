#!/bin/bash
#Main Cript for call any function
# Main source
source 'main'
################################
# VAR FUNCTION

##################################################################################################
function fuc_check_install(){
	clear
	printf "${blue}Check program install\n"
	for i in ${check_pro_install[*]};do			# Call Template 
		if rpm -qa |grep $i  > /dev/null ;then   	# check_pro_install="(name_pro_install)"
			 printf "++++ $i\t\t${green} installed${blue}\n"	# fuc_check_install
		else
			yum  -y install  $i
		fi
	done
}
##################################################################################################
function fuc_open_port(){						# Call Templat
	for i in ${port_num[*]};do				# port_num=(80 8080 443)   var
		service iptables status |awk /ACCEPT/ |grep "tcp dpt:$i" > /dev/null
		if [ $? == '0' ];then
			printf "${blue}++++ Check Port${green}\t$i \tlisten\n"
		else
			iptables -I INPUT -p tcp --dport $i -j ACCEPT          # fuc_open_port		   fuc
			printf "${green}Open port $i\n"
		fi
	done
	service iptables save > /dev/null
}
##################################################################################################

function fuc_auto_start(){
	for i in ${auto_start_pro[*]};do			# Call Tamplat
		chkconfig $i on					# auto_start_pro=(httpd nginx) var
	done							# fuc_auto_start	       fuc
}
##################################################################################################
function set_hostname(){
	#Get hostname from input 
	$hotname_input 
	

}
