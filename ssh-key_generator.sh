#!/bin/bash

generate_ssh_key() {
   sleep 1 
   echo
   echo "### Please provide data from your IMPORT installation."
   echo "### You will be needing the OS user, the users' password and the IP."
   echo

   read -p "Remote host username: " remote_user
   read -p "Remote host IP: " remote_ip
  
  if [ -z "$remote_ip" ]; then
    echo "You must provide server IP address."
    return 1
  fi
    # Use a regular expression to verify the IP address syntax
  if [[ ! $remote_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "The IP address '$remote_ip' does not have a valid syntax.."
    return 1
  fi
    # Generar el par de claves SSH
    echo "Generating an SSH key pair..."
    ssh-keygen
    # Copiar la clave pública al host remoto
    echo "Copying the public key to the remote host ($remote_user@$remote_ip)..."
    ssh-copy-id "$remote_user@$remote_ip"
  # Check if the key was copied correctly
  if [ $? -eq 0 ]; then
    echo "$remote_user@$remote_ip" > /usr/local/bin/server
    scp /usr/local/bin/rcron $(cat /usr/local/bin/server):/home/import/
    echo "Connection established!"
  else
    echo "The SSH key could not be copied to the server."
  fi
}
