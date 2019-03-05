#/bin!bash

TS=$(date +"%Y-%m-%d %H:%M:%S")
dir_assets='splunkforwarder'
dir_inputs='/opt/splunkforwarder/etc/apps/SplunkUniversalForwarder/local'
dir_scripts='/opt/splunkforwarder/bin/scripts'


initialize (){
echo "Initiating splunk daemon restart ( Press ctrl + c to cancel)"
sleep 1
echo "3.."
sleep 2
echo "2."
sleep 1
echo "1"

/opt/splunkforwarder/bin/splunk restart
}

check_outputs () {
if [ ! -d "$dir_inputs/outputs.conf" ]; then
        cp $dir_assets/outputs.conf $dir_inputs/outputs.conf
else
        clear
        cat $dir_inputs/outputs.conf
        echo -n "Found an existing outputs.conf file. Do you wish to proceed? a - append  o - overwrite  ctrl + c - exit : "
        read x

        if [ $x == "o" ] ; then
                cp $dir_assets/outputs.conf $dir_inputs/outputs.conf
                echo "Outputs config:" | cat $dir_inputs/inputs.conf
        elif [ $x == "a" ] ; then
                cat $dir_assets/outputs.conf >> $dir_inputs/outputs.conf
                echo "Outputs config:" | cat $dir_inputs/inputs.conf
        fi                                                    
fi
}


chmod +x $dir_assets/scripts/*sh

cp $dir_assets/scripts/*sh $dir_scripts

if [ ! -d "$dir_inputs" ]; then
        mkdir $dir_inputs
        cp $dir_assets/inputs.conf $dir_inputs/inputs.conf
        initialize
else
        cat $dir_inputs/inputs.conf
        echo -n "Found an existing inputs.conf file. Do you wish to proceed? a - append  o - overwrite p - proceed  ctrl + c - exit : "
        read x

        if [ $x == "o" ] ; then
                cp $dir_assets/inputs.conf $dir_inputs/inputs.conf
                echo "Inputs config:" | cat $dir_inputs/inputs.conf
                check_outputs
                initialize
        elif [ $x == "a" ] ; then
                cat $dir_assets/inputs.conf >> $dir_inputs/inputs.conf
                echo "Inputs config:" | cat $dir_inputs/inputs.conf
                check_outputs
                initialize
        fi                                                    
fi



