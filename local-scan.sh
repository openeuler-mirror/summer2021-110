##########################################################################
# File Name: local-scan.sh
# Author: Anaïs Huang
# mail: anaishuangc0conut@gmail.com
# Created Time: Mon 28 Jun 2021 09:16:21 AM CST
#########################################################################
#!/bin/sh

#PROGRAM_NAME="EG_local_scan"
#PROGRAM_AUTHOR="c0conut"

#banner
echo -e "\e[1;32m---------------------------------------\n"
echo -e "Welcome to use Euler Guardian!\n"
echo -e "---------------------------------------\n"

#######################################################################
# check current id
#######################################################################

#check current id
CurrentId=""
if [ -x /usr/xpg4/bin/id ]; then #Solaris
	CurrentId=$(/usr/xpg4/bin/id -u 2>/dev/null)
elif [ "$(uname)" = "SunOS" ]; then
	CurrentId=$(id | tr '=' ' ' | tr '(' ' ' | awk '{ print $2 }' 2>/dev/null)
else #"$(uname)" = "Linux", for Euler, ubuntu, etc
	CurrentId=$(id -u 2>/dev/null)
fi

#check if UID = 0(root)
if [ ${CurrentId} -eq 0 ]; then
	IsRoot=1
	ScanMode=0
else
	IsRoot=0
	ScanMode=1
fi

#####################################################################
#path
#####################################################################
#check SetUID ("s")
if [ -u "$0" ]; then
	echo -e "\e[0;36mStopped because of unusual SetUID. Exit.\n"
	exit 1
fi

#pwd
WorkDir=$(pwd)

########################################################################
# system info
########################################################################
echo -e "\e[1;32mSystem information check starts...\n"

# kernel info
UnameInfo=`uname -a 2>/dev/null`	#`uname -a`
if [ "$UnameInfo" ]; then
	# standard output and add to $report
	echo -e "\e[1;34mKernel info:\e[00m\n$UnameInfo\n" |tee -a $report 2>/dev/null
else
	echo -e "\e[0;36mUname failed.\n" |tee -a $report 2>/dev/null
fi

# kernel version, gcc version to compile, time of compilation
KernelVersion=`cat /proc/version 2>/dev/null`
if [ "$KernelVersion" ]; then
	echo -e "\e[1;34mKernel version:\e[00m\n$KernelVersion\n" |tee -a $report 2>/dev/null
else
	echo -e "\e[0;36mcat /proc/version failed.\n"|tee -a $report 2>/dev/null
fi

#release info
ReleaseInfo=`cat /etc/*-release 2>/dev/null`
if [ "$ReleaseInfo" ]; then
	echo -e "\e[1;34mrelease info:\e[00m\n$ReleaseInfo\n" |tee -a $report 2>/dev/null
else
	echo -e "\e[0;36mcat /etc/*-release failed.\n"|tee -a $report 2>/dev/null
fi


########################################################################
# user info
########################################################################
echo -e "\e[1;32mUser information check starts...\n"

# hostname
Hostname=`hostname 2>/dev/null`
if [ "$Hostname" ]; then
	echo -e "\e[1;34mHostname:\e[00m\n$Hostname\n" |tee -a $report 2>/dev/null
else
	echo -e "\e[0;36mhostname failed.\n"|tee -a $report 2>/dev/null
fi

#id
Id=`id 2>/dev/null`
if [ "$Id" ]; then
	echo -e "\e[1;34mCurrent user and group IDs:\e[00m\n$Id\n" |tee -a $report 2>/dev/null
else
	echo -e "\e[0;36mid failed.\n"|tee -a $report 2>/dev/null
fi

#user accounts info
Passwd=`cat /etc/passwd | cut -d ":" -f 1,2,3,4 2>/dev/null`
if [ "$Passwd" ]; then
	echo -e "\e[1;34mUsers and permissions:"
	echo -e "\e[0;34mUsername:Password:UID:GID"
	echo -e "\e[00m$Passwd\n" |tee -a $report 2>/dev/null
	#group memebership
	GroupIdInfo=`for i in $(cat /etc/passwd 2>/dev/null| cut -d":" -f1 2>/dev/null);do id $i;done 2>/dev/null`
	if [ "$GroupIdInfo" ]; then
		echo -e "\e[1;34mGroup memberships:\e[00m\n$GroupIdInfo\n" |tee -a $report 2>/dev/null
	else
		:
	fi
	#if password stored in /etc/passwd as hash
	HashPw=`grep -v '^[^:]*:[x]' /etc/passwd 2>/dev/null`
	if [ "$HashPw" ]; then
		echo -e "\e[1;34mFound password stored in /etc/passwd as hash:\n\e[00m$HashPw\n" | tee -a $report 2>/dev/null
	else
		echo -e "\e[0;34mNo password is stored in /etc/passwd as hash.\n" |tee -a $report 2>/dev/null
	fi
else
	echo -e "\e[0;36m cat /etc/passwd failed.\n" |tee -a $report 2>/dev/null
fi

#last log for each user
LastLogUser=`lastlog | grep -v "Never" 2>/dev/null`
if [ "$LastLogUser" ]; then
	echo -e "\e[1;34mUsers previously logged onto system:\e[00m\n$LastLogUser\n" |tee -a $report 2>/dev/null
else
	echo -e "\e[0;36mCan't find /var/log/lastlog.\n"|tee -a $report 2>/dev/null
fi 

#######################################################################
#file permission/ownership check
#######################################################################
echo -e "\e[0;32m Files permission and ownership check starts..."

########################################################################
# log auditing
########################################################################
