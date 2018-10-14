#!/bin/bash
clear
echo
echo "Associate Led with performance of a process"
echo "------------------------------"
echo "Please enter the name of the program to monitor(partial names are ok):"
read pName

getPS=`pgrep -fl "$pName" &`

echo $getPS
getUsage=`ps -eo pid,comm,nice -C $pName`
echo $getUsage

cpuOverload=`ps aux | grep -v "%CPU" | awk '{if ($3 > 80){print "killing process $pName"}}'`

#echo "Do you wish to 1) monitor memory or 2) monitor cpu? [enter memory or cpu]:"
#read monitor

echo "starting to monitor $pName"


