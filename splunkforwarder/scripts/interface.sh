ifconfig -s | awk 'NR>=2 {print $0}'
