#!/bin/bash 

PRINTF=/usr/bin/printf
LS=bin/ls

PWD=/bin/pwd
SLEEP=/bin/sleep
DIR=/sys/class/leds
QUIT=0
ledName=""

######################### Task 2 ##################################

#Displays the fist menu

menu(){
	clear
	$PRINTF "\n"

	$PRINTF "Welcome to Led_Configurator!\n"
	$PRINTF "===============================\n"
	$PRINTF "Please select an led to configure:\n"
	
	cd $DIR
	list=1
	
	#Looks for all the folders in DIR=/sys/class/leds and prints then one by one in line
	for i in $( ls );
	do
		echo "$list." $i
		list=$(expr $list + 1)
	done
	$PRINTF "$list. Quit\n"
	$PRINTF "\n"
	$PRINTF "Please enter a number (1-$list) for the led to configure or quit:"	
}

######################### Task 3 ##################################

#This is the option menu where users can choose their number and the following codes will lead it to them

readOptions(){
	read num
	case $num in
		
		1) #lists all the folders and chooses the first one	

		   var=`ls | awk 'NR==1'`
		   cd $DIR/$var
		   ledName="$var"
		   readSecondMenu ;;
		   
		2) var=`ls | awk 'NR==2'`
		   cd $DIR/$var
		   ledName="$var"
		   readSecondMenu ;;
		   
		3) var=`ls | awk 'NR==3'`
		   cd $DIR/$var
		   ledName="$var"
		   readSecondMenu ;;
		   
		4) var=`ls | awk 'NR==4'`
		   cd $DIR/$var
		   ledName="$var"
		   readSecondMenu ;;

		5) var=`ls | awk 'NR==5'`
		   cd $DIR/$var
		   ledName="$var"
		   readSecondMenu ;;
		   
		$list) echo BYE 
		QUIT=1 ;;
		
		*) echo Invalid option && $SLEEP 2;;
	esac
}

#This is the second menu and shows the ledname that was set in the previous option.

secondMenu(){
	clear
	$PRINTF "\n"
	$PRINTF "$ledName\n"
	$PRINTF "=======\n"
	$PRINTF "What would you like to do with this led?\n"
	
	$PRINTF "1)turn on\n"
	$PRINTF "2)turn off\n"
	$PRINTF "3)associate with a system event\n"
	$PRINTF "4)associate with the performance of a process\n"
	$PRINTF "5)stop association with a process'performance\n"
	$PRINTF "6)quit to the main menu\n"
	$PRINTF "Please enter a number (1-6) for your choice:\n"
}

######################### Task 4 ##################################

#This is the second options and the changes will be made according to users selection
readOptions2(){
	read num2
	case $num2 in
		1)
		 
		#writes 1 to brightness files to turn on 
		 
		   sudo sh -c "echo 1 > ./brightness"
		   echo "Turing on..."
		   echo "Done" ;;
		
		2) 
		   #writes 0 to brightness files to turn off
		   
		   sudo sh -c "echo 0 > ./brightness"
		   echo "Turning off..."   
		   echo "Done" ;;
		   
		3) 
		   #shows readThirdMenu on selection of 3
		 
		   readThirdMenu ;;
		  
		  
		4) sh s_task6.sh ;;
		5) stopProcess ;;
		
		6)  #Sets QUIT value to 2 which exits the loop 
		    QUIT2=2 && $SLEEP 1 ;;
		
		*) echo Invalid option && $SLEEP 2;;
	esac
}

######################### Task 5 ##################################

#shows associated led with system event menu

associateLedMenu(){
		echo
		echo "Associate Led with a system Event"
		echo "======================================"
		echo "Associate events are:"
		echo "----------------"
		
		list=1
		for i in $( cat trigger );
		do
			
			echo "$list)" $i | more
			
			list=$(expr $list + 1)
		done
		echo "$list)Quit to previous menu"
		echo "Please select an option (1-$list):"

}

#links with the led options
associateLedOptions(){

	read num3
	listM=$(expr $list - 1)
	
	case $num3 in
		[1-32]) echo "You have choosen $num3" && $SLEEP 1 ;;
		
		$list) QUIT3=2 && $SLEEP 1 ;;
		
		*) echo Invalid option && $SLEEP 2 ;;
	esac
}

#enters into first loop until QUIT3 is equal 0
readThirdMenu(){
	QUIT3=0
	while [ $QUIT3 -eq 0 ]
	do
		associateLedMenu
		associateLedOptions
	done
		
}

#enters into first loop until QUIT2 is equal 0
readSecondMenu(){
	
	QUIT2=0
	while [ $QUIT2 -eq 0 ]
	do 
		secondMenu
		readOptions2
	done
}

#enters into first loop until QUIT is equal 0
while [ $QUIT -eq 0 ] 
	do 
		menu
		readOptions
	done
