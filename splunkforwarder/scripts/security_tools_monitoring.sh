#!/bin/bash
#===========================================================================
#== Script for checking if client is compliant
#== If security tool processes(Clam AV, Ossec and Qualyst) are running or not
#== 10.15.2018
#== JGFRUCTUOSO
#===========================================================================

#set -vx


#========SET VARIABLES HERE

EXEC_DATE_TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")



#========SCRIPT PROPER

service qualys-cloud-agent status 2> /dev/null | egrep '^qualys-cloud-agent\s\(pid\s+[0-9]+\)\sis\s\running.+$' > qualyst-processes.txt

service ossec-hids status 2> /dev/null | egrep '^(ossec\-logcollector|ossec\-syscheckd|ossec\-agentd|ossec\-execd)\sis\srunning.+$' > ossec-processes.txt

service ossec status 2> /dev/null | egrep '^(ossec\-logcollector|ossec\-syscheckd|ossec\-agentd|ossec\-execd)\sis\srunning.+$' > ossec-hids-processes.txt

service clamd status 2> /dev/null | egrep '^clamd\s\(pid\s+[0-9]+\)\sis\srunning.+$' > clamd-processes.txt

service clamd.scan status 2> /dev/null | egrep '^clamd\.scan\s\(pid\s+[0-9]+\)\sis\srunning.+$' > clamd-scan-processes.txt



QUALYST_COUNT=`cat qualyst-processes.txt | wc -l`

CLAMD_COUNT=`cat clamd-processes.txt | wc -l`

CLAMD_SCAN_COUNT=`cat clamd-scan-processes.txt | wc -l`

OSSEC_COUNT=`cat ossec-processes.txt | wc -l`

OSSEC_HIDS_COUNT=`cat ossec-hids-processes.txt | wc -l`



echo $EXEC_DATE_TIMESTAMP
echo "QUALYST_PROCESS_COUNT=\"$QUALYST_COUNT\", OSSEC_PROCESS_COUNT=\"$OSSEC_COUNT\", OSSEC_HIDS_PROCESS_COUNT=\"$OSSEC_HIDS_COUNT\", CLAMD_PROCESS_COUNT=\"$CLAMD_COUNT\", CLAMD_SCAN_PROCESS_COUNT=\"$CLAMD_SCAN_COUNT\""
