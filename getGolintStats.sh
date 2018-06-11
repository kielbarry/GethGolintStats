#!/bin/bash

echo "running $0"

array=(
"receiver"
"comment on exported const"
"comment on exported function"
"comment on exported method"
"comment on exported type"
"comment on exported var"
"comment on exported struct"
"don't use leading k in Go names"
"((struct field) (.*) (should be))"
"((const) (.*) (should be))"
"((method) (.*) (should be))"
"((var) (.*) (should be))"
"((function) (.*) (should be))"
"((type) (.*) (should be))"
"don't use underscores in Go names; const"
"don't use underscores in Go names; func"
"don't use underscores in Go names; method"
"don't use underscores in Go names; type"
"don't use underscores in Go names; var"
"don't use underscores in Go names; struct"
"((error) (.*) (should))"
"if block ends with a return statement"
"((exported const) (.*) (should have comment))"
"((exported struct) (.*) (should have comment))"
"((exported function) (.*) (should have comment))"
"((exported method) (.*) (should have comment))"
"((exported type) (.*) (should have comment))"
"((exported var) (.*) (should have comment))"
)

len=${#array[@]}

cd ~/go/src/github.com/ethereum/go-ethereum
rm -rf ~/go/src/testFile
go list ./... | grep -v /vendor/ | xargs -L1 golint >> ~/go/src/testFile

total=$(cat ~/go/src/testFile | grep -c -E "$st")

for (( i=0;i<$len;i++)); do
	st=${array[${i}]}
	#subtotal="$(cat ~/go/src/testFile | grep -c -E "$st")"
	subtotal="$(cat ~/go/src/testFile | grep -c -E "$st")"
	percen=$(($subtotal/$total))
	#percen=$(awk "BEGIN { pc=${subtotal}/${total}; i=int(pc); print (pc-i<0.5)?i:i+1 }")

	#total=$((total+subtotal))
	# echo $percen
	#printf "$st: %s, or %s \n" "$subtotal" "$percen"
	printf "$st: %s \n" "$subtotal"
done

echo $total

if [[ $? ]]; then
	echo "success running $0"
else
	echo "failure running, err: $?"
fi