#!/bin/bash

generate_ssh_key() {
   read -p "Introduce el nombre de usuario del host remoto: " remote_user
   read -p "Introduce la dirección IP del host remoto: " remote_ip
  
  if [ -z "$server_ip" ]; then
    echo "You must provide server IP address."
    return 1
  fi
    # Use a regular expression to verify the IP address syntax
  if [[ ! $remote_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "The IP address '$remote_ip' does not have a valid syntax.."
    return 1
  fi


# Pedir al usuario el nombre de usuario y la dirección IP del host remoto
   

    # Generar el par de claves SSH
    echo "Generando un par de claves SSH..."
    ssh-keygen

    # Copiar la clave pública al host remoto
    echo "Copiando la clave pública al host remoto ($remote_user@$remote_ip)..."
    ssh-copy-id "$remote_user@$remote_ip"

    echo "Proceso completado."
  # Check if the key was copied correctly
  if [ $? -eq 0 ]; then
    echo $server_ip > /usr/local/bin/server
    scp /usr/local/bin/server $(cat /usr/local/bin/server):/usr/local/bin/ #rcron
  else
    echo "The SSH key could not be copied to the server."
  fi
}

