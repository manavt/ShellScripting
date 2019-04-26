#!/bin/bash

echo "writting values into debconf database."

#to see the debian configuration file hit below command 
# /usr/bin/debconf-set-selections

 
sudo /bin/bash -c "debconf-set-selections <<< 'mysql-server mysql-server/root_password password root123'"

echo "confirming mysql password from the debconf database."
sudo /bin/bash -c "debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root123'"

echo "installing mysql server, it may take few mins"
sudo apt-get -y install mysql-server

# as soon as the above commands finishes its run, mysql database can be accessed using below command.
# mysql -u root -p 

echo "checking status"
x=`/etc/init.d/mysql status | egrep -oh 'running'`
y="running"
if test "$x" = $y 
then
  echo "Yes running"
else 
  echo "Not running"
fi


#note 
# is you see below exception check whether mysql is running or not
# ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2)
##

# if you see below issues , it mean apt-get is getting used by some other service so wait for sometime until then its finishes its job or kill it 

#E: Could not get lock /var/lib/dpkg/lock-frontend - open (11: Resource temporarily unavailable)
#E: Unable to acquire the dpkg frontend lock (/var/lib/dpkg/lock-frontend), is another process using it?

#manvendra@ubuntu:~$ ps aux | grep -i apt
#root       1214  0.0  0.0   4504   796 ?        Ss   08:42   0:00 /bin/sh /usr/lib/apt/apt.systemd.daily update
#root       1224  0.0  0.0   4504  1684 ?        S    08:42   0:00 /bin/sh /usr/lib/apt/apt.systemd.daily lock_is_held update
##_apt       2482 10.0  0.2  52424  5632 ?        S    08:44   0:05 /usr/lib/apt/methods/http
#_apt       2486  0.3  0.2  52420  5460 ?        S    08:44   0:00 /usr/lib/apt/methods/http
#root       2493  1.1  1.6 227044 34284 ?        SNl  08:44   0:00 /usr/bin/python3 /usr/sbin/aptd
#manvend+   2518  0.0  0.0  21292   928 pts/17   S+   08:45   0:00 grep --color=auto -i apt
#manvendra@ubuntu:~$ sudo kill -9 1214 1224

# if -p args is not passed 
# ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: NO)
