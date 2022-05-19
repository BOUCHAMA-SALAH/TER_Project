#!/bin/bash

SOFTWARE=${SOFTWARE:='aspartix-V-interface.sh'}

echo "Test suite for ICCMA interface"
echo -n "Enabled semantics: "

# Output activated semantics
if [ "$ENABLE_PRF" -eq "1" ];
then
echo -n "preferred, "
fi
if [ "$ENABLE_STB" -eq "1" ];
then
echo -n "stable, "
fi
if [ "$ENABLE_SST" -eq "1" ];
then
echo -n "semi-stable, "
fi
if [ "$ENABLE_STG" -eq "1" ];
then
echo -n "stage, "
fi
if [ "$ENABLE_COM" -eq "1" ];
then
echo -n "complete, "
fi
if [ "$ENABLE_ADM" -eq "1" ];
then
echo -n "admissible, "
fi
if [ "$ENABLE_ID" -eq "1" ];
then
echo -n "ideal, "
fi
if [ "$ENABLE_IDS" -eq "1" ];
then
echo -n "ideal sets, "
fi
if [ "$ENABLE_GR" -eq "1" ];
then
echo -n "grounded, "
fi
if [ "$ENABLE_NAI" -eq "1" ];
then
echo -n "naive, "
fi
if [ "$ENABLE_CF" -eq "1" ];
then
echo -n "conflict-free, "
fi
if [ "$ENABLE_CF2" -eq "1" ];
then
echo -n "cf2, "
fi
if [ "$ENABLE_STG2" -eq "1" ];
then
echo -n "stage2, "
fi
if [ "$ENABLE_STRADM" -eq "1" ];
then
echo -n "strongly admissible, "
fi
if [ "$ENABLE_RBG" -eq "1" ];
then
echo -n "resolution-based grounded, "
fi

echo "Performing simple input-output tests"

########################################################################
# preferred
########################################################################
if [ "$ENABLE_PRF" -eq "1" ];
then

RESULT=`/bin/bash $SOFTWARE -p DS-PR -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DS-PR
fi

RESULT=`/bin/bash $SOFTWARE -p DS-PR -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-PR
fi

RESULT=`/bin/bash $SOFTWARE -p DC-PR -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-PR
fi

RESULT=`/bin/bash $SOFTWARE -p DC-PR -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DC-PR
fi

RESULT=`/bin/bash $SOFTWARE -p SE-PR -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[1,3,5,7]" ];
then
  echo error SE-PR
fi

RESULT=`/bin/bash $SOFTWARE -p EE-PR -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[
[1,3,5,7]
]" ];
then
  echo error EE-PR
fi

RESULT=`/bin/bash $SOFTWARE -p CE-PR -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "1" ];
then
  echo error CE-PR
fi

fi
########################################################################
# semi-stable
########################################################################
if [ "$ENABLE_SST" -eq "1" ];
then

RESULT=`/bin/bash $SOFTWARE -p DS-SST -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DS-SST
fi

RESULT=`/bin/bash $SOFTWARE -p DS-SST -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-SST
fi

RESULT=`/bin/bash $SOFTWARE -p DC-SST -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-SST
fi

RESULT=`/bin/bash $SOFTWARE -p DC-SST -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DC-SST
fi

RESULT=`/bin/bash $SOFTWARE -p SE-SST -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[1,3,5,7]" ];
then
  echo error SE-SST
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p EE-SST -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[
[1,3,5,7]
]" ];
then
  echo error EE-SST
fi

RESULT=`/bin/bash $SOFTWARE -p EE-SST -fo apx -f tests/self-attack.apx 2>/dev/null`
if [ "$RESULT" != "[
[]
]" ];
then
  echo "error EE-SST (no stable extension example)"
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p CE-SST -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "1" ];
then
  echo error CE-SST
  echo $RESULT
fi

fi

########################################################################
# stage
########################################################################
if [ "$ENABLE_STG" -eq "1" ];
then

RESULT=`/bin/bash $SOFTWARE -p DS-STG -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DS-STG
fi

RESULT=`/bin/bash $SOFTWARE -p DS-STG -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-STG
fi

RESULT=`/bin/bash $SOFTWARE -p DC-STG -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-STG
fi

RESULT=`/bin/bash $SOFTWARE -p DC-STG -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DC-STG
fi

RESULT=`/bin/bash $SOFTWARE -p SE-STG -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[1,3,5,7]" ];
then
  echo error SE-STG
fi

RESULT=`/bin/bash $SOFTWARE -p EE-STG -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[
[1,3,5,7]
]" ];
then
  echo error EE-STG
fi

RESULT=`/bin/bash $SOFTWARE -p EE-STG -fo apx -f tests/self-attack.apx 2>/dev/null`
if [ "$RESULT" != "[
[]
]" ];
then
  echo "error CE-STG (no stable extension example)"
  echo $RESULT
fi


RESULT=`/bin/bash $SOFTWARE -p CE-STG -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "1" ];
then
  echo error CE-STG
fi

fi

########################################################################
# stable
########################################################################
if [ "$ENABLE_STB" -eq "1" ];
then

RESULT=`/bin/bash $SOFTWARE -p DS-ST -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DS-ST
fi

RESULT=`/bin/bash $SOFTWARE -p DS-ST -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-ST
fi

RESULT=`/bin/bash $SOFTWARE -p DC-ST -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-ST 
fi

RESULT=`/bin/bash $SOFTWARE -p DC-ST -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DC-ST
fi

RESULT=`/bin/bash $SOFTWARE -p SE-ST -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[1,3,5,7]" ];
then
  echo error SE-ST
fi

RESULT=`/bin/bash $SOFTWARE -p SE-ST -fo apx -f tests/self-attack.apx 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error SE-ST no stable extension
fi

RESULT=`/bin/bash $SOFTWARE -p EE-ST -fo apx -f tests/self-attack.apx 2>/dev/null`
if [ "$RESULT" != "[]" ];
then
  echo error EE-ST no stable extension
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p CE-ST -fo apx -f tests/self-attack.apx 2>/dev/null`
if [ "$RESULT" != "0" ];
then
  echo error CE-ST no stable extension
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p EE-ST -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[
[1,3,5,7]
]" ];
then
  echo error EE-ST
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p CE-ST -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "1" ];
then
  echo error CE-ST
  echo $RESULT
fi

fi

########################################################################
# complete
########################################################################
if [ "$ENABLE_COM" -eq "1" ];
then

RESULT=`/bin/bash $SOFTWARE -p DS-CO -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DS-CO
fi

RESULT=`/bin/bash $SOFTWARE -p DS-CO -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-CO
fi

RESULT=`/bin/bash $SOFTWARE -p DC-CO -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-CO
fi

RESULT=`/bin/bash $SOFTWARE -p DC-CO -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DC-CO
fi

RESULT=`/bin/bash $SOFTWARE -p SE-CO -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[1,3,5,7]" ];
then
  echo error SE-CO
fi

RESULT=`/bin/bash $SOFTWARE -p EE-CO -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[
[1,3,5,7]
]" ];
then
  echo error EE-CO
fi

RESULT=`/bin/bash $SOFTWARE -p CE-CO -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "1" ];
then
  echo error CE-CO
fi

fi

########################################################################
# admissible
########################################################################
if [ "$ENABLE_ADM" -eq "1" ];
then

RESULT=`/bin/bash $SOFTWARE -p DS-ADM -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-ADM
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DS-ADM -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-ADM
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DC-ADM -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-ADM
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DC-ADM -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DC-ADM
  echo $RESULT
fi

# Problematic Test as the solver might pick another solution
RESULT=`/bin/bash $SOFTWARE -p SE-ADM -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[1,3,5,7]" ];
then
  echo "error SE-ADM (maybe just a different solution)"
  echo $RESULT
fi

# Problematic Test as the order of the extension might vary.
RESULT=`/bin/bash $SOFTWARE -p EE-ADM -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[
[1,3,5,7]
[1,3,5]
[1,3]
[1]
[]
]" ];
then
  echo "error EE-ADM(maybe just a different order of extensions)"
  echo $RESULT
fi


RESULT=`/bin/bash $SOFTWARE -p SE-ADM -fo apx -f tests/self-attack.apx 2>/dev/null`
if [ "$RESULT" != "[]" ];
then
  echo "error SE-ADM"
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p EE-ADM -fo apx -f tests/self-attack.apx 2>/dev/null`
if [ "$RESULT" != "[
[]
]" ];
then
  echo "error EE-ADM"
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p CE-ADM -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "5" ];
then
  echo error CE-ADM
  echo $RESULT
fi

fi

########################################################################
# grounded
########################################################################

if [ "$ENABLE_GR" -eq "1" ];
then
RESULT=`/bin/bash $SOFTWARE -p DC-GR -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-GR
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DC-GR -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DC-GR
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DS-GR -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DS-GR
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DS-GR -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-GR
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p SE-GR -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[1,3,5,7]" ];
then
  echo error SE-GR
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p EE-GR -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[
[1,3,5,7]
]" ];
then
  echo error EE-GR
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p EE-GR -fo apx -f tests/self-attack.apx 2>/dev/null`
if [ "$RESULT" != "[
[]
]" ];
then
  echo "error EE-GR"
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p CE-GR -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "1" ];
then
  echo error CE-GR
  echo $RESULT
fi
fi

########################################################################
# ideal
########################################################################
if [ "$ENABLE_ID" -eq "1" ];
then

RESULT=`/bin/bash $SOFTWARE -p DC-ID -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-ID
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DC-ID -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DC-ID
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DS-ID -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DS-ID
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DS-ID -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-ID
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p SE-ID -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[1,3,5,7]" ];
then
  echo error SE-ID
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p EE-ID -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[
[1,3,5,7]
]" ];
then
  echo error EE-ID
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p CE-ID -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "1" ];
then
  echo error CE-ID
  echo $RESULT
fi

fi
########################################################################
# ideal sets
########################################################################
if [ "$ENABLE_IDS" -eq "1" ];
then

RESULT=`/bin/bash $SOFTWARE -p DC-IDS -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-IDS
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DC-IDS -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DC-ID
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DS-IDS -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-IDS
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DS-IDS -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-IDS
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p SE-IDS -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[]" ];
then
  echo "error SE-IDS (we test for [] but other solutions are possible)"
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p EE-IDS -fo apx -f tests/chain.apx 2>/dev/null`
echo $RESULT | sed 's/a//g' | tr -d '\n' | sed 's/[[:space:]]//g; s/\]\[/\],\[/g' > right.tmp
echo "[[1,3,5,7],[1,3,5],[1,3],[],[1]]" | sed 's/a//g' > left.tmp
OUT=`python2 tools/compare-results.py left.tmp right.tmp`
if [ "$OUT" != "set([])" ];
then
  echo "error EE-IDS"
  echo $RESULT
  echo Symmetric Difference: $OUT
fi
rm left.tmp
rm right.tmp

RESULT=`/bin/bash $SOFTWARE -p CE-IDS -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "5" ];
then
  echo error CE-IDS
  echo $RESULT
fi

fi

########################################################################
# naive semantics
########################################################################

if [ "$ENABLE_NAI" -eq "1" ];
then

RESULT=`/bin/bash $SOFTWARE -p DC-NAI -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-NAI
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DC-NAI -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-NAI
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DC-NAI -fo apx -f tests/self-attack.apx -a 1 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DC-NAI
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DS-NAI -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-NAI
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DS-NAI -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-NAI
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p SE-NAI -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[1,4,6,8]" ];
then
  echo "error SE-NAI (we test for [1,4,6,8] but other extensions are possible)" 
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p SE-NAI -fo apx -f tests/self-attack.apx 2>/dev/null`
if [ "$RESULT" != "[]" ];
then
  echo "error SE-NAI" 
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p EE-NAI -fo apx -f tests/chain.apx 2>/dev/null`
echo $RESULT | sed 's/a//g' | tr -d '\n' | sed 's/[[:space:]]//g; s/\]\[/\],\[/g' > right.tmp
echo "[[1,4,6,8],[1,3,6,8],[1,3,5,8],[1,4,7],[1,3,5,7],[2,5,8],[2,4,6,8],[2,4,7],[2,5,7]]" | sed 's/a//g' > left.tmp
OUT=`python2 tools/compare-results.py left.tmp right.tmp`
if [ "$OUT" != "set([])" ];
then
  echo "error EE-NAI"
  echo $RESULT
  echo Symmetric Difference: $OUT
fi
rm left.tmp
rm right.tmp

RESULT=`/bin/bash $SOFTWARE -p CE-NAI -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "9" ];
then
  echo error CE-NAI
  echo $RESULT
fi

fi

########################################################################
# conflict-free sets
########################################################################

if [ "$ENABLE_CF" -eq "1" ];
then

RESULT=`/bin/bash $SOFTWARE -p DC-CF -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-CF
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DC-CF -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-CF
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DC-CF -fo apx -f tests/self-attack.apx -a 1 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DC-CF
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DS-CF -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-CF
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DS-CF -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-CF
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p SE-CF -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[]" ];
then
  echo "error SE-CF (we test for [] but other extensions are possible)" 
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p SE-CF -fo apx -f tests/self-attack.apx 2>/dev/null`
if [ "$RESULT" != "[]" ];
then
  echo "error SE-CF" 
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p EE-CF -fo apx -f tests/chain.apx 2>/dev/null`
echo $RESULT | sed 's/a//g' | tr -d '\n' | sed 's/[[:space:]]//g; s/\]\[/\],\[/g' > right.tmp
echo "[[2,4,7],[2,4,6,8],[2,4,6],[2,4,8],[2,4],[2,6,8],[2,6],[2,5,7],[2,7],[2,5,8],[2,5],[2,8],[2],[1,3,5,7],[3,5,7],[1,3,7],[3,7],[1,3,5,8],[3,5,8],[1,3,5],[3,5],[1,3,6,8],[1,3,6],[3,6,8],[3,6],[1,3,8],[3,8],[1,3],[3],[1,4,6,8],[4,6,8],[1,4,6],[4,6],[1,6,8],[1,6],[6,8],[6],[1,5,7],[5,7],[1,5,8],[1,5],[5,8],[5],[1,4,7],[4,7],[1,7],[7],[1,4,8],[4,8],[1,4],[4],[1,8],[1],[8],[]]" | sed 's/a//g' > left.tmp
OUT=`python2 tools/compare-results.py left.tmp right.tmp`
if [ "$OUT" != "set([])" ];
then
  echo "error EE-CF"
  echo $RESULT
  echo Symmetric Difference: $OUT
fi
rm left.tmp
rm right.tmp

RESULT=`/bin/bash $SOFTWARE -p CE-CF -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "55" ];
then
  echo error CE-CF
  echo $RESULT
fi

fi

########################################################################
# cf2 semantics
########################################################################

if [ "$ENABLE_CF2" -eq "1" ];
then

RESULT=`/bin/bash $SOFTWARE -p DC-CF2 -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-CF2
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DC-CF2 -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DC-CF2
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DC-CF2 -fo apx -f tests/self-attack.apx -a 1 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo "error DC-CF2 (self-attack)"
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DS-CF2 -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DS-CF2
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DS-CF2 -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-CF2
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p SE-CF2 -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[1,3,5,7]" ];
then
  echo "error SE-CF2" 
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p SE-CF2 -fo apx -f tests/self-attack.apx 2>/dev/null`
if [ "$RESULT" != "[]" ];
then
  echo "error SE-CF2" 
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p EE-CF2 -fo apx -f tests/chain.apx 2>/dev/null`
echo $RESULT | sed 's/a//g' | tr -d '\n' | sed 's/[[:space:]]//g; s/\]\[/\],\[/g' > right.tmp
echo "[[1,3,5,7]]" | sed 's/a//g' > left.tmp
OUT=`python2 tools/compare-results.py left.tmp right.tmp`
if [ "$OUT" != "set([])" ];
then
  echo "error EE-CF2"
  echo $RESULT
  echo Symmetric Difference: $OUT
fi
rm left.tmp
rm right.tmp

RESULT=`/bin/bash $SOFTWARE -p CE-CF2 -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "1" ];
then
  echo error CE-CF2
  echo $RESULT
fi

fi

########################################################################
# stage2 semantics
########################################################################

if [ "$ENABLE_STG2" -eq "1" ];
then

RESULT=`/bin/bash $SOFTWARE -p DC-STG2 -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-STG2
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DC-STG2 -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DC-STG2
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DC-STG2 -fo apx -f tests/self-attack.apx -a 1 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo "error DC-STG2 (self-attack)"
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DS-STG2 -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DS-STG2
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DS-STG2 -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-STG2
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p SE-STG2 -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[1,3,5,7]" ];
then
  echo "error SE-STG2" 
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p SE-STG2 -fo apx -f tests/self-attack.apx 2>/dev/null`
if [ "$RESULT" != "[]" ];
then
  echo "error SE-STG2" 
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p EE-STG2 -fo apx -f tests/chain.apx 2>/dev/null`
echo $RESULT | sed 's/a//g' | tr -d '\n' | sed 's/[[:space:]]//g; s/\]\[/\],\[/g' > right.tmp
echo "[[1,3,5,7]]" | sed 's/a//g' > left.tmp
OUT=`python2 tools/compare-results.py left.tmp right.tmp`
if [ "$OUT" != "set([])" ];
then
  echo "error EE-STG2"
  echo $RESULT
  echo Symmetric Difference: $OUT
fi
rm left.tmp
rm right.tmp

RESULT=`/bin/bash $SOFTWARE -p CE-STG2 -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "1" ];
then
  echo error CE-STG2
  echo $RESULT
fi

fi

########################################################################
# strongly admissible semantics
########################################################################

if [ "$ENABLE_STRADM" -eq "1" ];
then

RESULT=`/bin/bash $SOFTWARE -p DC-STRADM -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-STRADM
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DC-STRADM -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DC-STRADM
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DC-STRADM -fo apx -f tests/self-attack.apx -a 1 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo "error DC-STRADM (self-attack)"
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DS-STRADM -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-STRADM
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DS-STRADM -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-STRADM
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p SE-STRADM -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[]" ];
then
  echo "error SE-STRADM (we test for [] but other extensions are possible)" 
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p SE-STRADM -fo apx -f tests/self-attack.apx 2>/dev/null`
if [ "$RESULT" != "[]" ];
then
  echo "error SE-STRADM" 
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p EE-STRADM -fo apx -f tests/chain.apx 2>/dev/null`
echo $RESULT | sed 's/a//g' | tr -d '\n' | sed 's/[[:space:]]//g; s/\]\[/\],\[/g' > right.tmp
echo "[[],[1],[1,3],[1,3,5],[1,3,5,7]]" | sed 's/a//g' > left.tmp
OUT=`python2 tools/compare-results.py left.tmp right.tmp`
if [ "$OUT" != "set([])" ];
then
  echo "error EE-STRADM"
  echo $RESULT
  echo Symmetric Difference: $OUT
fi
rm left.tmp
rm right.tmp

RESULT=`/bin/bash $SOFTWARE -p CE-STRADM -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "5" ];
then
  echo error CE-STRADM
  echo $RESULT
fi

fi
########################################################################
# resolution-based grounded semantics
########################################################################

if [ "$ENABLE_RBG" -eq "1" ];
then

RESULT=`/bin/bash $SOFTWARE -p DC-RBG -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DC-RBG
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DC-RBG -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DC-RBG
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DC-RBG -fo apx -f tests/self-attack.apx -a 1 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo "error DC-RBG (self-attack)"
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DS-RBG -fo apx -f tests/chain.apx -a 1 2>/dev/null`
if [ "$RESULT" != "YES" ];
then
  echo error DS-RBG
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p DS-RBG -fo apx -f tests/chain.apx -a 2 2>/dev/null`
if [ "$RESULT" != "NO" ];
then
  echo error DS-RBG
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p SE-RBG -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "[1,3,5,7]" ];
then
  echo "error SE-RBG" 
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p SE-RBG -fo apx -f tests/self-attack.apx 2>/dev/null`
if [ "$RESULT" != "[]" ];
then
  echo "error SE-RBG" 
  echo $RESULT
fi

RESULT=`/bin/bash $SOFTWARE -p EE-RBG -fo apx -f tests/chain.apx 2>/dev/null`
echo $RESULT | sed 's/a//g' | tr -d '\n' | sed 's/[[:space:]]//g; s/\]\[/\],\[/g' > right.tmp
echo "[[1,3,5,7]]" | sed 's/a//g' > left.tmp
OUT=`python2 tools/compare-results.py left.tmp right.tmp`
if [ "$OUT" != "set([])" ];
then
  echo "error EE-RBG"
  echo $RESULT
  echo Symmetric Difference: $OUT
fi
rm left.tmp
rm right.tmp

RESULT=`/bin/bash $SOFTWARE -p CE-RBG -fo apx -f tests/chain.apx 2>/dev/null`
if [ "$RESULT" != "1" ];
then
  echo error CE-RBG
  echo $RESULT
fi

fi
##########################################################################
