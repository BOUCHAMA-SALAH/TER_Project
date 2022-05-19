#!/bin/bash

SOFTWARE=${SOFTWARE:='aspartix-V-interface.sh'}


cd ..

##########################################################################
# Test for 2019-4 semi-stable bug (reported by Andreas)
##########################################################################

RESULT=`/bin/bash $SOFTWARE -p DS-SST -fo apx -f tests/insts/huston_merge_2015-12.gml.80.apx -a 3185 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo "error DS-SST- DS-SST(2019-4) bug test 1"
  echo $RESULT
else
  echo "ok"
fi

RESULT=`/bin/bash $SOFTWARE -p DS-SST -fo apx -f tests/insts/huston_merge_2015-12.gml.80.apx -a 4643 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo "error DS-SST - DS-SST(2019-4) bug test 2"
  echo $RESULT
else
  echo "ok"
fi

RESULT=`/bin/bash $SOFTWARE -p DC-SST -fo apx -f tests/insts/huston_merge_2015-12.gml.80.apx -a 3185 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo "error DC-SST - DS-SST(2019-4) bug test 1"
  echo $RESULT
else
  echo "ok"
fi

RESULT=`/bin/bash $SOFTWARE -p DC-SST -fo apx -f tests/insts/huston_merge_2015-12.gml.80.apx -a 4643 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo "error  DC-SST - DS-SST(2019-4) bug test 2"
  echo $RESULT
else
  echo "ok"
fi
##########################################################################
