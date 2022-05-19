#!/bin/bash
# USEAGE ./run_tests.sh [-m (io|pipes|real|full)]

# Default is just doing io tests
# All Options: "io","pipes","real","full"
testMode="io"

# Activate Semantics for tests
ENABLE_PRF=1
ENABLE_STB=1
ENABLE_SST=1
ENABLE_STG=1
ENABLE_COM=1
ENABLE_ADM=1
ENABLE_ID=1
ENABLE_IDS=1
ENABLE_GR=1
ENABLE_NAI=1
ENABLE_CF=1
ENABLE_CF2=1
ENABLE_STG2=1
ENABLE_STRADM=1
ENABLE_RBG=0


while [ "$1" != "" ]; do
	case $1 in
	  "-m")
	shift
	testMode=$1
	;;
	  "-mode")
	shift
	testMode=$1
	;;
	esac
	shift
done

if [ $testMode = "io" ]; then
   . ./tests/io-tests.sh
fi

if [ $testMode = "pipes" ]; then
   . ./tests/test-named-pipes.sh
fi

function real_tests
{
   
	ABSPATH=`realpath aspartix-V-interface.sh`
	
	echo "### Run Correctness Tests ###"
	
	if [ "$ENABLE_COM" == "1" ]; then
	echo "run tests for complete semantics"
		python3 tests/tests.py "bash $ABSPATH -p CE-CO -fo apx" tests/test-instances/com count
		python3 tests/tests.py "bash $ABSPATH -p EE-CO -fo apx" tests/test-instances/com enum
		python3 tests/tests.py "bash $ABSPATH -p DC-CO -fo apx" tests/test-instances/com cred
		python3 tests/tests.py "bash $ABSPATH -p DS-CO -fo apx" tests/test-instances/com skept
		python3 tests/tests.py "bash $ABSPATH -p SE-CO -fo apx" tests/test-instances/com some
	fi
	
	if [ "$ENABLE_PR" == "1" ]; then
		echo "run tests for preferred semantics"
		python3 tests/tests.py "bash $ABSPATH -p CE-PR -fo apx" tests/test-instances/pref count
		python3 tests/tests.py "bash $ABSPATH -p EE-PR -fo apx" tests/test-instances/pref enum
		python3 tests/tests.py "bash $ABSPATH -p DC-PR -fo apx" tests/test-instances/pref cred
		python3 tests/tests.py "bash $ABSPATH -p DS-PR -fo apx" tests/test-instances/pref skept
		python3 tests/tests.py "bash $ABSPATH -p SE-PR -fo apx" tests/test-instances/pref some
	fi
	
	if [ "$ENABLE_STB" == "1" ]; then
		echo "run tests for stable semantics"
		python3 tests/tests.py "bash $ABSPATH -p CE-ST -fo apx" tests/test-instances/stable count
		python3 tests/tests.py "bash $ABSPATH -p EE-ST -fo apx" tests/test-instances/stable enum
		python3 tests/tests.py "bash $ABSPATH -p DC-ST -fo apx" tests/test-instances/stable cred
		python3 tests/tests.py "bash $ABSPATH -p DS-ST -fo apx" tests/test-instances/stable skept
		python3 tests/tests.py "bash $ABSPATH -p SE-ST -fo apx" tests/test-instances/stable some
	fi

	if [ "$ENABLE_GR" == "1" ]; then
	echo "run tests for grounded semantics"
		python3 tests/tests.py "bash $ABSPATH -p CE-GR -fo apx" tests/test-instances/grounded count
		python3 tests/tests.py "bash $ABSPATH -p EE-GR -fo apx" tests/test-instances/grounded enum
		python3 tests/tests.py "bash $ABSPATH -p DC-GR -fo apx" tests/test-instances/grounded cred
		python3 tests/tests.py "bash $ABSPATH -p DS-GR -fo apx" tests/test-instances/grounded skept
		python3 tests/tests.py "bash $ABSPATH -p SE-GR -fo apx" tests/test-instances/grounded some
	fi

	if [ "$ENABLE_ID" == "1" ]; then
		echo "run tests for ideal semantics"
		python3 tests/tests.py "bash $ABSPATH -p CE-ID -fo apx" tests/test-instances/ideal count
		python3 tests/tests.py "bash $ABSPATH -p EE-ID -fo apx" tests/test-instances/ideal enum
		python3 tests/tests.py "bash $ABSPATH -p DC-ID -fo apx" tests/test-instances/ideal cred
		python3 tests/tests.py "bash $ABSPATH -p DS-ID -fo apx" tests/test-instances/ideal skept
		python3 tests/tests.py "bash $ABSPATH -p SE-ID -fo apx" tests/test-instances/ideal some
	fi

	if [ "$ENABLE_SST" == "1" ]; then
		echo "run tests for semi-stable semantics"
		python3 tests/tests.py "bash $ABSPATH -p CE-SST -fo apx" tests/test-instances/semi count
		python3 tests/tests.py "bash $ABSPATH -p EE-SST -fo apx" tests/test-instances/semi enum
		python3 tests/tests.py "bash $ABSPATH -p DC-SST -fo apx" tests/test-instances/semi cred
		python3 tests/tests.py "bash $ABSPATH -p DS-SST -fo apx" tests/test-instances/semi skept
		python3 tests/tests.py "bash $ABSPATH -p SE-SST -fo apx" tests/test-instances/semi some
	fi
	
	if [ "$ENABLE_STG" == "1" ]; then
		echo "run tests for stage semantics"
		python3 tests/tests.py "bash $ABSPATH -p CE-STG -fo apx" tests/test-instances/stage count
		python3 tests/tests.py "bash $ABSPATH -p EE-STG -fo apx" tests/test-instances/stage enum
		python3 tests/tests.py "bash $ABSPATH -p DC-STG -fo apx" tests/test-instances/stage cred
		python3 tests/tests.py "bash $ABSPATH -p DS-STG -fo apx" tests/test-instances/stage skept
		python3 tests/tests.py "bash $ABSPATH -p SE-STG -fo apx" tests/test-instances/stage some
	fi
}

if [ $testMode = "full" ]; then
	. ./tests/io-tests.sh
	real_tests
fi

if [ $testMode = "real" ]; then
	real_tests
fi
