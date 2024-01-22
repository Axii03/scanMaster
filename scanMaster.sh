#!/bin/bash

# Check if the target argument is provided
if [ $# -ne 1 ]; then #-ne means not equal. If the number of argument ne 1 then exit.
    echo "Pls enter it like : $0 <target>" # $0 is a variable used for the name of the scrit. It will print the script name.
    exit 1
fi



# Extract the target from the command-line argument
target="$1" #the first argument provided when executing is assigned to target variable



ping -c 4 "$target" #ping to check if host is reachable 
pingStatus=$? 
# $? stores the exit status of the most recent command 
 
# Check the exit status and display a message 
if [ $pingStatus -eq 0 ]; then 
    echo "Host $target is reachable. Starting Nmap scan..."  
fi

# Run an Nmap scan to find open ports
nmap -sC -Pn -T4 -oN nmapScan.txt $target
#-sV used to scan version. -oN used to specify save as normal file to nmapScan.txt file. 


transferStatus="transfer.txt" #declare a variable to store the file name where the transfer status data will be saved.

    # Check if port 21 (FTP) is open
    if grep -q '21/tcp\s*open' nmapScan.txt; then
        echo "Port 21 (FTP) is open. Sending an FTP request..."
        wget --ftp-user=anonymous --no-passive-ftp -m ftp://anonymous@$target/*
        echo "Files downloaded Successfully"
 

    fi

# Run Dirb scan to find hidden directories.
gobuster dir -u http://$target -w /usr/share/wordlists/dirb/common.txt -o foundDirectories.txt #change the wordlist according to the need.

# Run Nikto scan to test for vulnerabilities 
nikto -h "http://$target" -o vulnerability.txt

echo "Scans completed. Results saved to:"
echo "Nmap results: nmapScan.txt"
echo "Vulnerability results: vulnerability.txt"
echo "Gobuster scan Results: foundDirectories.txt"

