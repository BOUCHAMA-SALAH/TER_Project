#!/bin/bash

SOFTWARE=${SOFTWARE:='aspartix-V-interface.sh'}

echo "Perform ICCMA interface test with af-input via named pipes"
echo -n "Enabled semantics: "
if [ "$ENABLE_GR" == "1" ];
then
echo -n "grounded, "
fi
if [ "$ENABLE_PRF" == "1" ];
then
echo -n "preferred, "
fi
if [ "$ENABLE_SST" == "1" ];
then
echo -n "semi-stable, "
fi
if [ "$ENABLE_COM" == "1" ];
then
echo -n "complete, "
fi
if [ "$ENABLE_STG" == "1" ];
then
echo -n "stage, "
fi
if [ "$ENABLE_IDL" == "1" ];
then
echo -n "ideal, "
fi
echo "stable"

echo "Performing simple input-output tests"

# create pipe
#mkfifo input-af

# preferred
if [ "$ENABLE_PRF" == "1" ];
then
echo "test preferred"

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DS-PR -fo apx -f input-af -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DS-PR
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DS-PR -fo apx -f input-af -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-PR
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DC-PR -fo apx -f input-af -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-PR
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DC-PR -fo apx -f input-af -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DC-PR
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p SE-PR -fo apx -f input-af 2>/dev/null`
if [ "$RESULT" != "[1,3,5,7]" ];
then
  echo error SE-PR
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p EE-PR -fo apx -f input-af 2>/dev/null`
if [ "$RESULT" != "[
[1,3,5,7]
]" ];
then
  echo error EE-PR
fi

fi


# semi
if [ "$ENABLE_SST" == "1" ];
then

echo "test semi-stable"

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DS-SST -fo apx -f input-af -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DS-SST
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DS-SST -fo apx -f input-af -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-SST
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DC-SST -fo apx -f input-af -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-SST
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DC-SST -fo apx -f input-af -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DC-SST
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p SE-SST -fo apx -f input-af 2>/dev/null`
if [ "$RESULT" != "[1,3,5,7]" ];
then
  echo error SE-SST
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p EE-SST -fo apx -f input-af 2>/dev/null`
if [ "$RESULT" != "[
[1,3,5,7]
]" ];
then
  echo error EE-SST
fi

fi

# stage
if [ "$ENABLE_STG" == "1" ];
then

echo "test stage"

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DS-STG -fo apx -f input-af -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DS-STG
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DS-STG -fo apx -f input-af -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-STG
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DC-STG -fo apx -f input-af -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-STG
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DC-STG -fo apx -f input-af -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DC-STG
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p SE-STG -fo apx -f input-af 2>/dev/null`
if [ "$RESULT" != "[1,3,5,7]" ];
then
  echo error SE-STG
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p EE-STG -fo apx -f input-af 2>/dev/null`
if [ "$RESULT" != "[
[1,3,5,7]
]" ];
then
  echo error EE-STG
fi

fi


echo "test stable"

# stable
cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DS-ST -fo apx -f input-af -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DS-ST
fi



cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DS-ST -fo apx -f input-af -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-ST
fi



cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DC-ST -fo apx -f input-af -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-ST 
fi



cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DC-ST -fo apx -f input-af -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DC-ST
fi



cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p SE-ST -fo apx -f input-af 2>/dev/null`
if [ "$RESULT" != "[1,3,5,7]" ];
then
  echo error SE-ST
fi


cat tests/self-attack.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p SE-ST -fo apx -f input-af 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error SE-ST no stable extension
fi

cat tests/self-attack.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p EE-ST -fo apx -f input-af 2>/dev/null`
if [ "$RESULT" != "[]" ];
then
  echo error EE-ST no stable extension
  echo $RESULT
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p EE-ST -fo apx -f input-af 2>/dev/null`
if [ "$RESULT" != "[
[1,3,5,7]
]" ];
then
  echo error EE-ST
  echo $RESULT
fi

# complete
if [ "$ENABLE_COM" == "1" ];
then

echo "test complete"

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DS-CO -fo apx -f input-af -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DS-CO
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DS-CO -fo apx -f input-af -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-CO
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DC-CO -fo apx -f input-af -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-CO
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DC-CO -fo apx -f input-af -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DC-CO
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p SE-CO -fo apx -f input-af 2>/dev/null`
if [ "$RESULT" != "[1,3,5,7]" ];
then
  echo error SE-CO
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p EE-CO -fo apx -f input-af 2>/dev/null`
if [ "$RESULT" != "[
[1,3,5,7]
]" ];
then
  echo error EE-CO
fi

fi

# grounded
if [ "" == "1" ];
then

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DC-GR -fo apx -f input-af -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-GR
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DC-GR -fo apx -f input-af -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DC-GR
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p SE-GR -fo apx -f input-af 2>/dev/null`
if [ "$RESULT" != "[1,3,5,7]" ];
then
  echo error SE-GR
fi
fi

# ideal
if [ "$ENABLE_IDL" == "1" ];
then

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DC-ID -fo apx -f input-af -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-ID
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p DC-ID -fo apx -f input-af -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DC-ID
fi

cat tests/chain.apx > input-af &
RESULT=`/bin/bash $SOFTWARE -p SE-ID -fo apx -f input-af 2>/dev/null`
if [ "$RESULT" != "[1,3,5,7]" ];
then
  echo error SE-ID
fi

fi

rm input-af
exit