#!/bin/bash
# Function to generate a SSH key
generate_ssh_key() {
  #Generate the SSH key in the predetermined directory
  ssh-keygen
  #Function to copy the SSH key to the server
  read -p "Enter the server IP address: " server_ip
  # Validate if an IP address was entered
  if [ -z "$server_ip" ]; then
    echo "You must provide server IP address."
    return 1
  fi
    # Use a regular expression to verify the IP address syntax
  if [[ ! $server_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "The IP address '$server_ip' does not have a valid syntax.."
    return 1
  fi
  # Copy the SSH key to the server
  ssh-copy-id "$server_ip"
  # Check if the key was copied correctly
  if [ $? -eq 0 ]; then
    echo "The SSH key was copied to the server $server_ip."
  else
    echo "The SSH key could not be copied to the server."
  fi
}

