#\bin\bash
DATE=`date '+%Y-%m-%d %H:%M:%S'`
RESULT=$(ps -e -o command | sort | uniq)

echo "$RESULT"
