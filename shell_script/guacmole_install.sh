#!/bin/bash
#Main source 
#source main/main
#source 'mainSrc//main-sc.sh'
source ../main/main
source ../main/main-sc.sh
#############################
function Guacamole_Install(){

  #Variab
  logfile=install.log
  LIBJPEG_URL=http://sourceforge.net/projects/libjpeg-turbo/files/1.5.1/libjpeg-turbo-official-1.5.1.x86_64.rpm
  CENTOS_VER=`rpm -qi --whatprovides /etc/redhat-release | awk '/Version/ {print $3}'`
###########################################################################################  
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
while true;do
	echo -e "Menu Install Guacmole "
	read -p  "${Blue}Install the Proxy feature (Nginx)? Yes/No: ${Yellow}" yn
	case $yn in
		[Yy]* ) INSTALL_NGINX="yes";nginxmenu; break;;
        	[Nn]* ) INSTALL_NGINX="no"; break;;
        	* ) echo "${Blue} Please enter yes or no. ${Yellow}";;
    esac
done

}
nginxmenu()
{
certype="Self-Signed"
echo -n "${Blue} Enter the Guacamole Server IP addres or hostame (default localhost): ${Yellow}"
  read GUACASERVER_HOSTNAME
  GUACASERVER_HOSTNAME=${GUACASERVER_HOSTNAME:-localhost}
echo "Guacamole Server IP addres or hostame $GUACASERVER_HOSTNAME"
echo -n "${Blue} Enter the URI path (default guacamole): ${Yellow}"
  read GUACAMOLE_URIPATH
  GUACAMOLE_URIPATH=${GUACAMOLE_URIPATH:-guacamole}
echo "URI path $GUACAMOLE_URIPATH"
reposinstall
}


reposinstall () {
echo -e "${blue}\nChecking CentOS version\t${green}CentOS $CENTOS_VER \n"; 
sleep 1 | echo -e "\n${blue}Searching for EPEL Repository...";
rpm -qa | grep epel-release > /dev/null
RETVAL=${PIPESTATUS[1]}
if [ $RETVAL -eq 0 ]; then
	sleep 1 | echo -e "${green}found $(rpm -qa | grep epel-release) No need to install EPEL repository!"; 
	
else
	sleep 1 | echo -e "\nIs necessary to install the EPEL repositories\nInstalling..."; 
	rpm -Uvh http://dl.fedoraproject.org/pub/epel/epel-release-latest-${CENTOS_VER}.noarch.rpm || exit 1
fi

sleep 1 | echo -e "\n${blue}Searching for RPMFusion Repository...";
RETVAL=${PIPESTATUS[1]}
if [ $RETVAL -eq 0 ]; then
	sleep 1 | echo -e "${green}found $(rpm -qa | grep rpmfusion) No need to install RPMFusion repository!"; 
else
	sleep 1 | echo -e "\nIs necessary to install the RPMFusion repositories\nInstalling..."; 
	rpm -Uvh https://download1.rpmfusion.org/free/el/rpmfusion-free-release-${CENTOS_VER}.noarch.rpm || exit 1
fi
}
guacamoleinstall () {
sleep 1 | echo -e "\nInstalling Dependencies...";
rpm -qa | grep libjpeg-turbo-official-${LIBJPEG_VER} 
RETVAL=${PIPESTATUS[1]} ; echo -e "rpm -qa | grep libjpeg-turbo-official-${LIBJPEG_VER} RC is: $RETVAL" >> $logfile  2>&1

if [ $RETVAL -eq 0 ]; then
	sleep 1 | echo -e "...libjpeg-turbo-official-${LIBJPEG_VER} is installed on the system\n"; echo -e "...libjpeg-turbo-official-${LIBJPEG_VER} is installed on the system\n" >> $logfile  2>&1
else
	sleep 1 | echo -e "...libjpeg-turbo-official-${LIBJPEG_VER} is not installed on the system\n"; echo -e "...libjpeg-turbo-official-${LIBJPEG_VER} is not installed on the system\n" >> $logfile  2>&1
	yum localinstall -y ${LIBJPEG_URL}${LIBJPEG_TURBO}.${MACHINE_ARCH}.rpm | tee -a $logfile
	RETVAL=${PIPESTATUS[0]} ; echo -e "yum localinstall -y ${LIBJPEG_URL}${LIBJPEG_TURBO}.${MACHINE_ARCH}.rpm RC is: $RETVAL" >> $logfile  2>&1
	ln -vfs /opt/libjpeg-turbo/include/* /usr/include/ | tee -a $logfile || exit 1
	ln -vfs /opt/libjpeg-turbo/lib??/* /usr/lib${ARCH}/ | tee -a $logfile
fi

