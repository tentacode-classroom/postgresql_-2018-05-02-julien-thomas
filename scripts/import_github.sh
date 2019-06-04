#!/bin/bash


# get or set the working directory
if [ -z ${1+x} ]
then
	directoryPath="."
else
	directoryPath=$1
fi


# search for previous imports. Delete them or not. If not exist, create the destination folder
if [ -d "$directoryPath/imports" ]
then
	echo -e "[\e[34mINFO\e[39m] Import(s) already exist !"

	read -p "	Keep old data ? (o/N)" CHOICE

	if [ "$CHOICE" = "N" ] || [ "$CHOICE" = "" ]
	then
		echo -e "[\e[31mINFO\e[39m] Your old archive(s) has been deleted\e[39m"
		rm -rf $directoryPath/imports
		mkdir $directoryPath/imports
	else
                echo -e "[\e[32mINFO\e[39m] Your old archive(s) steel here\e[39m"
	fi
else
		mkdir $directoryPath/imports
fi


# get current date of the download
date="$(date +"%d-%m-%Y_%kh%M")"


# download the archive
echo -e "\n[\e[34mINFO\e[39m] Downloading data...\e[39m"
mkdir -r $directoryPath/imports/$date-temp
wget https://data.gharchive.org/2018-05-15-{15..16}.json.gz -P $directoryPath/imports/$date-temp # TODO: ad --quiet


# extract archives
echo -e "\n[\e[34mINFO\e[39m] Extract data...\e[39m"
gunzip $directoryPath/imports/$date-temp/*.json.gz


# merge all data files into a single file
cat $directoryPath/imports/$date-temp/* > $directoryPath/imports/archives_$date.json

# delete temp download folde
rm -rf $directoryPath/imports/$date-temp

# annonce the end of the script
echo -e "\n[\e[34mINFO\e[39m] Import data \e[5mFINISHED\e[25m successfully"
