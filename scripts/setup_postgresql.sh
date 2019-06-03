#!/bin/bash

# Update & cleanup the system
sudo apt update && sudo apt upgrade && sudo apt full-upgrade && sudo apt autoremove

# Add the repository in sources
echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" | sudo tee --append /etc/apt/sources.list.d/pgdg.list

# Import the repository signing key
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add

# Update the package lists
sudo apt-get update

# Install the package
sudo apt install postgresql-11 -y

# Try the installaion
psql --version