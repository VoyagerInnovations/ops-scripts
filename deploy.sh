#/bin!bash

TS=$(date +"%Y-%m-%d %H:%M:%S")
dir_assets='ops-scripts/splunkforwarder'
dir_inputs='/opt/splunkforwarder/etc/apps/search/local'
dir_scripts='/opt/splunkforwarder/bin/scripts'

git clone -b splunkforwarder-generic https://github.com/VoyagerInnovations/ops-scripts.git

chmod +x $dir_assets/scripts/*sh

if [ ! -d "$dir_inputs" ]; then
        mkdir /opt/splunkforwarder/etc/apps/search/local/
        cp $dir_assets/inputs.conf $dir_inputs/inputs.conf
else
        cp $dir_assets/inputs.conf $dir_inputs/inputs.conf
fi

/opt/splunkforwarder/bin/splunk restart
