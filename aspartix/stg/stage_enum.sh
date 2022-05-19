#-------------------------------------------
# call: bash stage_enum.sh <some_instance.lp>
#-------------------------------------------



#!/bin/bash

dir=$(dirname $0)
pid=$$

## get directories of clingo and old clingo
. "$dir"/settings

## create temporary file for range
rangeList=$(mktemp "$dir/rangeList_$pid"_XXXXX)

## remove the temporary files afterwards
trap "rm -f $rangeList" 0 2 3 15

# Parameter: instance $1
if [ -z "$1" ] || [ ! -f $1 ]
then
	echo 'parameter missing or file does not exist'
	exit
fi

# echo "# running clingo to compute the ranges"

    "$dirClingo" "$dir"/heuristic_stage.lp $1 --heuristic=Domain --enum=domRec 0 2>/dev/null | grep 'range' | sed 's/)/)./g; s/range//g' > "$rangeList" 

    ## exit the script if clingo failed
    ex=$?
    if [[ $ex != 0 ]]; then
        exit $ex
    fi
	   
    #cat "$rangeList"

# echo "# Compute stable extensions"
    
    echo "["
    while read p; do
        echo "$p""#show stbExt." | "$dirClingoOld" - "$dir"/stable.lp $1 0 2>/dev/null | grep 'stbExt' | sed 's/ stbExt//; s/stbExt //; s/stbExt/]/; s/in(//g; s/) /,/g; s/)/]/; s/^/[/'
        ## exit the script if clingo failed
        ex=$?
        if [[ $ex != 0 ]]; then
            exit $ex
        fi
    done < "$rangeList"

    echo "]"
