#!/bin/bash
sudo apt-get update
sudo apt install -y samba samba-common-bin
sudo smbstatus
# or systemctl status smbd
smbd --version
#Now that Samba is installed, we need to create a directory for it to share
mkdir /home/$USER/sambashare/

#The command above creates a new folder sambashare in our home directory which we will share later.

#The configuration file for Samba is located at /etc/samba/smb.conf. To add the new directory as a share, we edit the file by running:

sudo /bin/bash -c "cat <<EOT >> /etc/samba/smb.conf
[sambashare]
    comment = Samba on Ubuntu
    path = /home/$USER/sambashare
    read only = no
    browsable = yes
EOT"

#What we've just added
#	[sambashare]: The name inside the brackets is the name of our share.
#	comment: A brief description of the share.
#	path: The directory of our share.
#	read only: Permission to modify the contents of the share folder is only granted when the value of this directive is no.
#	browsable: When set to yes, file managers such as Ubuntu's default file manager will list this share under "Network" (it could also appear as browseable).
#	Now that we have our new share configured, save it and restart Samba for it to take effect:

sudo systemctl restart smbd
sudo systemctl enable smb

# Starting with 15.04 and systemd, the command is systemctl restart smbd

# post restart use below command manually from the command line 

sudo smbpasswd -a $USER

#Note
#Username used must belong to a system account, else it won't save.

# https://tutorials.ubuntu.com/tutorial/install-and-configure-samba#3
