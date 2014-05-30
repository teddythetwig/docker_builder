#!/bin/bash


base_dir="/home/tfunger/ruby/docker"

#Check if the user has a directory on the server, and initialize if not
echo "Checking if the user already has a directory"
if ! [[ -d "${base_dir}/$2" ]]; then
    mkdir "${base_dir}/$2"
    cp "${base_dir}/Dockerfile" "${base_dir}/$2"
fi

#Write file to system so docker can ADD
echo "Writing user code to filesystem"
echo -e "$1" > "${base_dir}/$2/user_code.rb"

#Build the docker container 
#echo "Building the docker container"
#docker build -t somecontainer "${base_dir}/$2/"

#Capture the output from running the container
#echo "Running the docker container
#out=$(docker run somecontainer)

#Return the output to calling program, or curl to callback url
#echo "result=${out}"

