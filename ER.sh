##########################################################################
# File Name: ER.sh
# Author: Anaïs Huang
# mail: anaishuangc0conut@gmail.com
# Created Time: Sat 07 Aug 2021 06:31:58 PM CST
# 应急响应 自动分析
#########################################################################
#!/bin/bash

#####################################################################
# 基本检查
# /tmp下文件，services
#####################################################################
function BasicCheck() {
	echo -e "\e[1;32mFiles under /tmp:\n\033[0m"
	ls -alt /tmp

	echo -e "\e[1;32mServices can be started and stopped manually:\n\033[0m"
	ls -alt /etc/init.d
}

#####################################################################
# 可疑文件类型检查（如jsp等)
# 在指定目录下检查24h改变的/有777权限的特定类型文件
#####################################################################
function CertainFileTypeCheck() {
	echo -e "\e[0;36mInput file type e.g.\e[1;35mjsp\e[0;36m or \e[1;35mnext\e[0;36m to execute the next instruction.\033[0m"
	echo -e "\e[1;32mPlease input a type of file:\033[0m"
	read fileType
	while [[ "$fileType" != "next" ]]; do
		echo -e "\e[1;32mPlease input the path you want to check:\033[0m"
		read PathChk
		echo -e "\e[1;32m$fileType files that were changed in 24h \n\033[0m"
		find $PathChk -mtime 0 -name "*.$fileType"
		echo -e "\e[1;32m$fileType files that have 777 perm \n\033[0m"
		find $PathChk *.$fileType -perm 4777
		echo -e "\e[1;32mPlease input a type of file:\033[0m"
		read fileType
	done
	echo -e "\e[1;32mFiles check finished.\033[0m"
}

#####################################################################
# 文件改变时间检查
# 检查特定目录下、在特定时间改变的文件
#####################################################################
function FilesChangedTime() {
	echo -e "\e[0;36mInput time e.g.\e[1;35mFeb 27\e[0;36m or \e[1;35mnext\e[0;36m to execute the next instruction.\033[0m"
	echo -e "\e[1;32mPlease input month or next:\033[0m"
	read monOfChg
	while [[ "$monOfChg" != "next" ]]; do
		echo -e "\e[1;32mPlease input day:\033[0m"
		read dayOfChg
		timeOfChg=`printf '%s%3i' $monOfChg $dayOfChg`
		echo -e "\e[1;32mPlease input the path you want to check:\033[0m"
		read PathChk
		echo -e "\e[1;32mFiles that were changed on $timeOfChg\n\033[0m"
		ls -al $PathChk | grep "$timeOfChg"
		echo -e "\e[1;32mPlease input month:\033[0m"
		read monOfChg
	done
	echo -e "\e[1;32mFiles changed time check finished.\033[0m"
}

#####################################################################
# 检查网络进程
#
#####################################################################
function ProcAnalyse() {
	echo -e "\e[1;32mCheck net process\n\033[0m"
	netstat -antlp
}
#####################################################################
# 根据PID查看proc详情
#
#####################################################################
function PIDProcAnalyse() {
	echo -e "\e[0;36mInput PID or \e[1;35mnext\e[0;36m to execute the next instruction.\033[0m"
	echo -e "\e[1;32mPlease input the PID you want to analyse:\033[0m"
	read procID
	while [[ "$procID" != "next" ]]; do
		ps aux | grep "${procID}" | grep -v grep
		echo -e "\e[1;32mPlease input the PID you want to analyse:\033[0m"
		read procID
	done
	echo -e "\e[1;32mProcess analysis finished.\033[0m"
}

#####################################################################
#  程序开始
#####################################################################
echo -e "\e[1;34m\n-----------------------------------------------"
echo "Basic check start"
echo -e "-----------------------------------------------\033[0m\n"
BasicCheck

echo -e "\e[1;34m\n-----------------------------------------------"
echo "Files check start"
echo -e "-----------------------------------------------\033[0m\n"
CertainFileTypeCheck
FilesChangedTime

echo -e "\e[1;34m\n-----------------------------------------------"
echo "Net process check start"
echo -e "-----------------------------------------------\033[0m\n"
ProcAnalyse
PIDProcAnalyse
