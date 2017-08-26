#!/bin/bash
#
#Main soucce  Befor use new program you want add new source you can find new source on file 
# $dir_script source.update.sh
# shell_script/source.update.sh
# Befor add new source you want delete old source from below all replect new source from bellow 
################################
#Don't Edit from main Directory
source main/main
source main/main-sc.sh
#Can Edit 
source shell_script/function.list
source shell_script/scrip.sh
source shell_script/main/main-sc.sh
source shell_script/install.sh
################################
#shell_script/source.update.sh

dir_script='shell_script/' 
name_lists='main/function.list'
Update_function_list(){ 		#update function to file name list
	if [ -d $dir_script ];then	#Check main folder  script file 
		printf "Main Script Directory  : ${green}$dir_script${blue}\n"
	else 
		mkdir $dir_script; 	# Create Main Script Directory
		printf "${green}Create Main Script Directory${blue}\n" 
	fi
	if [[  $(ls $dir_script |grep .sh) ]];then
		printf "Have Script in path    : ${green}OK${blue}\n" 
		if [ -f $name_lists ];then	# Update functionlist
			rm -rf $name_lists
			printf "${blue}Update Function        : "
			for i in $(ls "$dir_script"|grep .sh);do 

				cat "$dir_script""$i"|grep -v 'cat $dir_script$i'|grep 'function' | awk -F "(" '{print $1}'|awk '{print $2}' >> $name_lists
				
			done
			printf "${green}Updated${blue}\n"
		else
			for i in $(ls "$dir_script" |grep .sh);do 
				cat "$dir_script""$i" |grep -v 'cat $dir_script$i'|grep 'function' | awk -F "(" '{print $1}'|awk '{print $2}' >> $name_lists
				printf "${blue}Update Function\t"
				printf "${green}Updated${blue}\n"
			done
		fi
	else
                printf "Have Script in path  : ${red}NO${blue}\n"
		printf "${red}Program Can't Run${nc}\n"
		exit 0; 
        fi
}
template(){		# call function from name list function and run
	fuc_list_o=$(cat -b $name_lists |grep $option |awk '{print $2}')  
		if 
			[[ $fuc_list_o  == $fuc_list_o ]];then
				$fuc_list_o
			back2home				
		else
			printf "${red}Ener any key${nc}\n"
		fi
	 				
}
function_lists(){	# print function list on main menu
	printf "${brown}Function Lists\n${blue}"
	cat -b $name_lists  |awk '{print $1")\t"$2}'
}
back2home(){		# Back to main menu
	
	printf "\n\n${blue}Enter any key  back to home ${red}Enter 0  Exit\t${nc}"
	read back2home_in
	if [ $back2home_in == '0' ];then
		exit 0
	else
		home
		
	fi	
}
update_souce(){		# Update main source files
	if [ -f 'shell_script/source.update.sh' ];then
		rm -rf 'shell_script/source.update.sh'
		for i in $(ls $dir_script );do
                        echo 'source' "$dir_script""$i" >> shell_script/source.update.sh
                done
	else
		for i in $(ls $dir_script );do
			echo 'source' "dir_script""$i" >> shell_script/source.update.sh
		done
	fi
	chmod +x shell_script/source.update.sh
}

update_su(){             # call function from name list function and run
        su_list_o=$(cat 'shell_script/source.update.sh')
                for i in $su_list_o ;do
			$su_list_o
		done
}

#Home
home(){
clear 

update_souce

printf "${blue}Update new sources\n"
Update_function_list
function_lists
printf "${brown}Select Program   	:\t${nc}"
read option
template
}

home






