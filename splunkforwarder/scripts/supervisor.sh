#!/bin/bash

supervisorctl status > /dev/null

status=$?

if [[ $status -eq 0 ]]; then
	
	date +"%F %T.%3N %z"
	supervisorctl status
	
else

	echo "NOSUPERVISOR NOSUPERVISOR There is no supervisorctl in this server"
fi
