# scanMaster
A bash script to automate a part of the recon stage


##Overview

This script is used to automate the initial part of the recon stage when testing so that it will simplify the initial process.This will come in handy as it can be used specifically in Tryhackme or CTF boxes to automate this intial recon stage

The script will run:
1.An nmap Scan  
2.If the ftp port is open it will try to log in as anonymous and get all the files.  
3.Run a gobuster scan to find for hidden directories.  
4.Run a Nikto Scan to identify Web server vulnerabilities.  



##How to use

./scanMaster.sh <ip address>
