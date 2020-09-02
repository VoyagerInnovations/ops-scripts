#!/bin/bash




 supervisorctl status > /dev/null



 status=$?



 if [[ $status -eq 0 ]]; then



 date +"%a %b %d %H:%M:%S.%3N %z %Y"

 supervisorctl status


else

 date +"%a %b %d %H:%M:%S.%3N %z %Y"

 echo "NOSUPERVISOR NOSUPERVISOR There is no supervisorctl in this server"

 fi
