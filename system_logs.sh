#!/bin/bash
# write into system logs
message="Hello guys, Hows machine doing todayyyyyyyyxyz"
# The logger utility allows you to quickly write a message to your system log with a single, simple command. 
logger $message
read_log=`cat /var/log/syslog | egrep -oh "$message"`
if test "$message" = "$read_log"
then
  echo "Hey successfully matched the result as $read_log"
else
  echo "Something wrong with the script, not able to write into log"
fi

# echo "the above result is from sys log which stores the system activity info into memory package manager log (dpkg.log), authentication log (auth.log), and graphical server log (Xorg.0.log)."

# how to see the services logs like your Bluetooth, IPv6, NET activity log 

# dmesg is the command which shows you services logs 

dmesg | less

dmesg | more
