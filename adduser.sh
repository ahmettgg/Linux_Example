#!/bin/bash
# Make sure the script is being executed with superuser privileges.
if [[ $UID -ne 0 ]]
then 
echo "you are not root user"
exit 1
fi 
# Get the username (login).
read -p "Enter your name:" USERNAME
# Get the real name (contents for the description field). 
read -p "Enter your description" REALNAME
# Get the password.
PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c12)
# Check to see if the passwd command succeeded.
if [[ $? -eq 0 ]]
then 
echo "password succesfully created"
fi
# Create the user with the password. # Set the password. 
useradd -c $REALNAME -p $PASSWORD $USERNAME  
# Check to see if the useradd command succeeded. 
if [[ $? -ne 0 ]]
then 
echo "user could not be created"
else
echo "user created"
tail -1 /etc/passwd
fi 
# Force password change on first login. 
passwd -e $USERNAME
# Display the username, password, and the host where the user was created
echo "username : $USERNAME password : $PASSWORD realname : $REALNAME "