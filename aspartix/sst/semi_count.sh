#-------------------------------------------
# call: bash semi_count.sh <some_instance.lp>
#-------------------------------------------

# run complete encoding (in folder)
# write output to temporary file (save in folder)




#!/bin/bash

dir=$(dirname $0)
pid=$$

## get directories of clingo and old clingo
. "$dir"/settings

## create temporary files
tmpfile=$(mktemp "$dir/enum_$pid"_XXXXX)
errorfile=$(mktemp "$dir/enum_error_$pid"_XXXXX)

## remove the temporary files afterwards
trap "rm -f $tmpfile; rm -f $errorfile" 0 2 3 15

# Parameter: instance $1
if [ -z "$1" ] || [ ! -f $1 ]
then
	echo 'parameter missing or file does not exist'
	exit
fi

# run clingo complete semantics
"$dirClingo" "$dir"/comp.lp $1 0 2>$errorfile | grep "in(\|undec" > "$tmpfile"


#ex=$?
#if [[ $ex != 0 ]]; then
#	exit $ex
#fi

if grep -q "INTERRUPTED" $errorfile; then
	exit 
fi

# check if line without "undec" exists
if grep -v -q "undec" "$tmpfile"; then
	# semi = stable
	grep 'in(' "$tmpfile" | grep -v 'undec'|wc -l
else
	# no stable extension exists
        tmpname="$(basename -- $tmpfile)"
	python3 "$dir"/py_semi.py "$tmpname" "count"
fi
#echo "FIN"
