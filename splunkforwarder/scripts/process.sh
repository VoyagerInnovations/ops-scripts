#\bin\bash
RESULT=$(ps -e -o command | sort | uniq)

echo "$RESULT"
