#!/bin/bash

# Function to install vsftpd
install_vsftpd() {
  read -p "Enter the user name: " ftp_user
  read -sp "Enter the password for $ftp_user: " ftp_password
  read -p "Enter the root directory for FTP: " ftp_root

  # Install vsftpd
  sudo apt-get update -y
  sudo apt-get install vsftpd -y

  # Configure vsftpd
  sudo nano /etc/vsftpd.conf

  # Add the following lines to the configuration file:
  # (Replace placeholders with actual values)
  anon_root=/srv/ftp
  local_enable=YES
  write_enable=YES
  local_umask=022
  pasv_min_port=40000
  pasv_max_port=40099

  # Create the FTP user and set the password
  sudo useradd $ftp_user
  sudo passwd $ftp_user

  # Set the user's home directory and permissions
  sudo mkdir -p $ftp_root
  sudo chown $ftp_user:$ftp_user $ftp_root
  sudo chmod 755 $ftp_root

  # Restart vsftpd
  sudo systemctl restart vsftpd
}

function main_menu {
	local option
	# Main menu
	echo "What do you want to do?"
	echo "	1) install vsftp"
	echo "	0) Exit"
	read -r -p "Please enter an option: " option
	case $option in
	1) install_vsftpd ;;
  0) exit 0;;
  *) echo "Invalid option. Please enter 1 or 0." ;;
	esac
}


# Main menu
clear
main_menu
