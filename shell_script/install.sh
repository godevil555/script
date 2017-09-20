#!/bin/bash
#Main source 
#source main/main
#source 'mainSrc//main-sc.sh'
source ../main/main
source ../main/main-sc.sh
function Gitlab(){

		check_pro_install=(postfix curl openssh-server cronie gitlab-ce)
		fuc_check_install
		port_num=(80 22 443)
		fuc_open_port
		auto_start_pro=(postfix)
		fuc_auto_start	
		curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | bash
		yum install gitlab-ce -y
		printf "\nGit Lab in stall run http://IP"
		printf "\n User : root Password : 5liveL1fe\n"	
}
function DNS_Server(){
	clear
	# Check bind Install
	check_pro_install=(bind)
	fuc_check_install
	port_num=(25)
	fuc_open_port
	auto_start_pro=(named)
	fuc_auto_start
	
	echo "test print IP ${get_ip}"
}
function Guacamole_Install(){
	clear
	echo -e "
                                                                 
                                                                 
                                                ${Yellow}'.'              
                            ${Green}'.:///:-.....'     ${Yellow}-yyys/-           
                     ${Green}.://///++++++++++++++/-  ${Yellow}.yhhhhhys/'        
                  ${Green}'.:++++++++++++++++++++++: ${Yellow}'yhhhhhhhhy-        
          ${White}.+y' ${Green}'://++++++++++++++++++++++++' ${Yellow}':yhhhhyo:'         
        ${White}-yNd. ${Green}'/+++++++++++++++++++++++++++//' ${Yellow}.+yo:' ${White}'::        
       ${White}oNMh' ${Green}./++++++++++++++++++++++++++++++/:' '''' ${White}'mMh.      
      ${White}-MMM:  ${Green}/+++++++++++++++++++++++++++++++++-.:/+:  ${White}yMMs      
      ${White}-MMMs  ${Green}./++++++++++++++++++++++++++++++++++++/' ${White}.mMMy      
      ${White}'NMMMy. ${Green}'-/+++++++++++++++++++++++++++++++/:.  ${White}:dMMMo      
       ${White}+MMMMNy:' ${Green}'.:///++++++++++++++++++++//:-.' ${White}./hMMMMN'      
       ${White}-MMMMMMMmy+-.${Green}''''.---::::::::::--..''''${White}.:ohNMMMMMMy       
        ${White}sNMMMMMMMMMmdhs+/:${Green}--..........--${White}:/oyhmNMMMMMMMMMd-       
         ${White}.+dNMMMMMMMMMMMMMMNNmmmmmmmNNNMMMMMMMMMMMMMMmy:'        
            ${White}./sdNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNmho:'           
          ${White}'     .:+shmmNNMMMMMMMMMMMMMMMMNNmdyo/-'               
          ${White}.o:.       '.-::/+ossssssso++/:-.'       '-/'          
           ${White}.ymh+-.'                           ''./ydy.           
             ${White}/dMMNdyo/-.''''         ''''.-:+shmMNh:             
               ${White}:yNMMMMMMNmdhhyyyyyyyhhdmNNMMMMMNy:               
                 ${White}':sdNNMMMMMMMMMMMMMMMMMMMNNds:'                 
                     ${White}'-/+syhdmNNNNNNmdhyo/-'            
"
}


