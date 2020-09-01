#/bin!bash

TS=$(date +"%Y-%m-%d %H:%M:%S")
dir_assets='splunkforwarder'
dir_inputs='/opt/splunkforwarder/etc/apps/search/local'
dir_scripts='/opt/splunkforwarder/bin/scripts'

chmod +x $dir_assets/scripts/*sh
cp $dir_assets/scripts/*sh $dir_scripts

if [ ! -d "$dir_inputs" ]; then
        mkdir /opt/splunkforwarder/etc/apps/search/local/
        cp $dir_assets/inputs.conf $dir_inputs/inputs.conf
else
        cp $dir_assets/inputs.conf $dir_inputs/inputs.conf
fi

/opt/splunkforwarder/bin/splunk restart
