#!/bin/bash
# Función para generar una clave SSH
generate_ssh_key() {
  # Generar la clave SSH en el directorio predeterminado
  ssh-keygen
  # Función para copiar la clave SSH al servidor
  read -p "Ingresa la dirección IP del servidor: " server_ip
  # Validar si se ingresó una dirección IP
  if [ -z "$server_ip" ]; then
    echo "Debes proporcionar la dirección IP del servidor."
    return 1
  fi
    # Utilizar una expresión regular para verificar la sintaxis de la dirección IP
  if [[ ! $server_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "La dirección IP '$server_ip' no tiene una sintaxis válida."
    return 1
  fi
  # Copiar la clave SSH al servidor
  ssh-copy-id "$server_ip"
  # Comprobar si la clave se copió correctamente
  if [ $? -eq 0 ]; then
    echo "La clave SSH se copió al servidor $server_ip."
  else
    echo "No se pudo copiar la clave SSH al servidor."
  fi
}

