#!/bin/bash
#######################################################
### 08-04-2020
### JGFRUCTUOSO
### Script for managing the disk space for /var/log/audit.
### Executes every 25th day of the month
#######################################################
set -vx


#VARIABLES
timestamp=$(date +'%Y-%m-%d %H:%M:%S')

#DIRECTORIES
dir_path="/var/log/audit"



#Change directory
cd $dir_path/;


#Reset internal variable "$SECONDS" to 0. To be use in calculating the runtime of the two "find" comamnd
SECONDS=0

#Remove compressed files older than 65 days
find $dir_path/ -type f -mtime +65 -iname 'audit.log.*.gz' -not \( -iname 'audit.log' \) -exec rm -f "{}" +;

#Check if the command was successfully executed
if [[ $? == 0 ]]; then
   rm_status="$?"
else
   rm_status="$?"
fi


#Compress files older than 7 days. Ignore audit.log and all compressed files.
find $dir_path/ -type f -mtime +7 -iname 'audit.log.*' -not \( -iname 'audit.log' -or -iname 'audit.log.*.gz' \)  -exec gzip -S ".$(date +'%Y%m%d').gz" "{}" +;


#Gets the final duration in seconds from internal variable "$SECONDS"
DURATION=$SECONDS


#Check if the command was successfully executed
if [[ $? == 0 ]]; then
   gzip_mv_status="$?"
else
   gzip_mv_status="$?"
fi


#Corresponding echo spiel based on what commands were successfully executed
if [[ $rm_status == 0 && $gzip_mv_status == 0 ]]; then
   message="Removal of compressed files and compression of old files were successfully executed"
elif [[ $rm_status == 0 && $gzip_mv_status != 0 ]]; then
   message="Removal of compressed files was successfully executed and compression of old files failed"
elif [[ $rm_status != 0 && $gzip_mv_status == 0 ]]; then
   message="Removal of compressed files failed and compression of old files was successfully"
else
   message="Removal of compressed files and compression of old files failed"
fi

echo "TIMESTAMP=\"${timestamp}\",  RUNTIME_IN_SEC=\"${DURATION}\", DIR=\"${dir_path}\", OUTPUT=\"${message}\""
