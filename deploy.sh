#/bin!bash

TS=$(date +"%Y-%m-%d %H:%M:%S")
dir_assets='splunkforwarder'
dir_inputs='/opt/splunkforwarder/etc/apps/search/local'
dir_scripts='/opt/splunkforwarder/bin/scripts'


initialize (){
echo "Newly added scripts:" | ls -lrt $dir_assets/scripts/*sh
echo "Inputs config:" | cat $dir_inputs/inputs.conf
echo ""
echo ""
echo "Initiating splunk daemon restart ( Press ctrl + c to cancel)"
sleep 1
echo "3.."
sleep 2
echo "2."
sleep 1
echo "1"

/opt/splunkforwarder/bin/splunk restart
}


chmod +x $dir_assets/scripts/*sh

cp $dir_assets/scripts/*sh $dir_scripts

if [ ! -d "$dir_inputs" ]; then
        mkdir /opt/splunkforwarder/etc/apps/search/local/
        cp $dir_assets/inputs.conf $dir_inputs/inputs.conf
        initialize
else
        echo -n "Found an existing inputs.conf file. Do you wish to proceed? o - overwrite a - append config  ctrl + c - exit : "
        read x

        if [ $x == "o" ] ; then
                cp $dir_assets/inputs.conf $dir_inputs/inputs.conf
                initialize
        elif [ $x == "a" ] ; then
                cat $dir_assets/inputs.conf >> $dir_inputs/inputs.conf
                initialize
        fi                                                    
fi
