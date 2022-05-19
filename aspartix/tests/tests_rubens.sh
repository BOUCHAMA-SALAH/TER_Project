#!/bin/bash

##### set path to rubens-checker-1.1.2-SNAPSHOT.jar
RUBENS=${RUBENS:='/home/mk/Documents/rubens/rubens-master/fr.cril.rubens.checker/target/rubens-checker-1.1.2-SNAPSHOT.jar'}

##### CO
## EE
java -jar $RUBENS -m EE-CO -e ../aspartix-V-interface.sh  -o rubens_out
## CE
java -jar $RUBENS -m CE-CO -e ../aspartix-V-interface.sh  -o rubens_out
## DC
java -jar $RUBENS -m DC-CO -e ../aspartix-V-interface.sh  -o rubens_out
## DS
java -jar $RUBENS -m DS-CO -e ../aspartix-V-interface.sh  -o rubens_out
## SE
java -jar $RUBENS -m SE-CO -e ../aspartix-V-interface.sh  -o rubens_out


##### GR
## EE
java -jar $RUBENS -m EE-GR -e ../aspartix-V-interface.sh  -o rubens_out
## CE
java -jar $RUBENS -m CE-GR -e ../aspartix-V-interface.sh  -o rubens_out
## DC
java -jar $RUBENS -m DC-GR -e ../aspartix-V-interface.sh  -o rubens_out
## DS
java -jar $RUBENS -m DS-GR -e ../aspartix-V-interface.sh  -o rubens_out
## SE
java -jar $RUBENS -m SE-GR -e ../aspartix-V-interface.sh  -o rubens_out


##### PR
## EE
java -jar $RUBENS -m EE-PR -e ../aspartix-V-interface.sh  -o rubens_out
## CE
java -jar $RUBENS -m CE-PR -e ../aspartix-V-interface.sh  -o rubens_out
## DC
java -jar $RUBENS -m DC-PR -e ../aspartix-V-interface.sh  -o rubens_out
## DS
java -jar $RUBENS -m DS-PR -e ../aspartix-V-interface.sh  -o rubens_out
## SE
java -jar $RUBENS -m SE-PR -e ../aspartix-V-interface.sh  -o rubens_out


##### ST
## EE
java -jar $RUBENS -m EE-ST -e ../aspartix-V-interface.sh  -o rubens_out
## CE
java -jar $RUBENS -m CE-ST -e ../aspartix-V-interface.sh  -o rubens_out
## DC
java -jar $RUBENS -m DC-ST -e ../aspartix-V-interface.sh  -o rubens_out
## DS
java -jar $RUBENS -m DS-ST -e ../aspartix-V-interface.sh  -o rubens_out
## SE
java -jar $RUBENS -m SE-ST -e ../aspartix-V-interface.sh  -o rubens_out


##### SST
## EE
java -jar $RUBENS -m EE-SST -e ../aspartix-V-interface.sh  -o rubens_out
## CE
java -jar $RUBENS -m CE-SST -e ../aspartix-V-interface.sh  -o rubens_out
## DC
java -jar $RUBENS -m DC-SST -e ../aspartix-V-interface.sh  -o rubens_out
## DS
java -jar $RUBENS -m DS-SST -e ../aspartix-V-interface.sh  -o rubens_out
## SE
java -jar $RUBENS -m SE-SST -e ../aspartix-V-interface.sh  -o rubens_out


##### STG
## EE
java -jar $RUBENS -m EE-STG -e ../aspartix-V-interface.sh  -o rubens_out
## CE
java -jar $RUBENS -m CE-STG -e ../aspartix-V-interface.sh  -o rubens_out
## DC
java -jar $RUBENS -m DC-STG -e ../aspartix-V-interface.sh  -o rubens_out
## DS
java -jar $RUBENS -m DS-STG -e ../aspartix-V-interface.sh  -o rubens_out
## SE
java -jar $RUBENS -m SE-STG -e ../aspartix-V-interface.sh  -o rubens_out


##### ID
## EE
java -jar $RUBENS -m EE-ID -e ../aspartix-V-interface.sh  -o rubens_out
## CE
java -jar $RUBENS -m CE-ID -e ../aspartix-V-interface.sh  -o rubens_out
## DC
java -jar $RUBENS -m DC-ID -e ../aspartix-V-interface.sh  -o rubens_out
## DS
java -jar $RUBENS -m DS-ID -e ../aspartix-V-interface.sh  -o rubens_out
## SE
java -jar $RUBENS -m SE-ID -e ../aspartix-V-interface.sh  -o rubens_out



