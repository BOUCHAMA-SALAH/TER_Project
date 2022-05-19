#!/bin/bash

# ICCMA style interface of ASPARTIX-V on unix systems

# This interface is based on the Generic script interface for ICCMA 2019
# Copyright note for the Generic script interface for ICCMA 2019:
# (c)2014 Federico Cerutti <federico.cerutti@acm.org> --- MIT LICENCE
# adapted 2016 by Thomas Linsbichler <linsbich@dbai.tuwien.ac.at> --- MIT LICENSE
# adapted 2018 by Francesco Santini <francesco.santini@dmi.unipg.it> --- MIT LICENSE
# adapted 2018 by Theofrastos Mantadelis <theo.mantadelis@dmi.unipg.it> --- MIT LICENSE
# Generic script interface for ICCMA 2019


# This interfaces uses (make sure these tools work properly on your system)
# * bash 
# * cat, grep, sed
# * python (for certain tasks) 


#+------------------------------------------------------------------------+
# SUPPORTED INPUT FORMATS
formats=""
formats="${formats} apx" # "aspartix" format
# formats="${formats} tgf" # trivial graph format
#+------------------------------------------------------------------------+

#+------------------------------------------------------------------------+
# SUPPORTED TASKS as [SEMANTICS]-[TASK] string
tasks=""
# complete semantics
tasks="${tasks} DC-CO"
tasks="${tasks} DS-CO"
tasks="${tasks} SE-CO"
tasks="${tasks} EE-CO"
tasks="${tasks} CE-CO"
# preferred semantics
tasks="${tasks} DC-PR"
tasks="${tasks} DS-PR"
tasks="${tasks} SE-PR"
tasks="${tasks} EE-PR"
tasks="${tasks} CE-PR"
# stable semantics
tasks="${tasks} DC-ST"
tasks="${tasks} DS-ST"
tasks="${tasks} SE-ST"
tasks="${tasks} EE-ST"
tasks="${tasks} CE-ST"
# admissible sets
tasks="${tasks} DC-ADM"
tasks="${tasks} DS-ADM"
tasks="${tasks} EE-ADM"
tasks="${tasks} SE-ADM"
tasks="${tasks} CE-ADM"
# semi-stable semantics
tasks="${tasks} DC-SST"
tasks="${tasks} DS-SST"
tasks="${tasks} SE-SST"
tasks="${tasks} EE-SST"
tasks="${tasks} CE-SST"
# stage semantics
tasks="${tasks} DC-STG"
tasks="${tasks} DS-STG"
tasks="${tasks} EE-STG"
tasks="${tasks} SE-STG"
tasks="${tasks} CE-STG"
# grounded semantics
tasks="${tasks} DC-GR"
tasks="${tasks} SE-GR"
tasks="${tasks} DS-GR"     
tasks="${tasks} EE-GR"
tasks="${tasks} CE-GR"     
# ideal semantics
tasks="${tasks} DC-ID"
tasks="${tasks} SE-ID"
tasks="${tasks} DS-ID"     
tasks="${tasks} EE-ID"
tasks="${tasks} CE-ID"
# ideal sets 
tasks="${tasks} DC-IDS"
tasks="${tasks} DS-IDS"
tasks="${tasks} EE-IDS" 
tasks="${tasks} SE-IDS"
tasks="${tasks} CE-IDS"     
# naive extensions
tasks="${tasks} DC-NAI"
tasks="${tasks} DS-NAI"
tasks="${tasks} EE-NAI"
tasks="${tasks} SE-NAI"
tasks="${tasks} CE-NAI"
# conflict-free sets
tasks="${tasks} DC-CF"
tasks="${tasks} DS-CF"
tasks="${tasks} EE-CF"
tasks="${tasks} SE-CF"
tasks="${tasks} CE-CF"
# cf2 semantics
tasks="${tasks} DC-CF2"
tasks="${tasks} DS-CF2"
tasks="${tasks} EE-CF2"
tasks="${tasks} SE-CF2"
tasks="${tasks} CE-CF2"
# stage2 semantics
tasks="${tasks} DC-STG2"
tasks="${tasks} DS-STG2"
tasks="${tasks} EE-STG2"
tasks="${tasks} SE-STG2"
tasks="${tasks} CE-STG2"
# strongly admissible semantics
tasks="${tasks} DC-STRADM"
tasks="${tasks} DS-STRADM"
tasks="${tasks} EE-STRADM"
tasks="${tasks} SE-STRADM"
tasks="${tasks} CE-STRADM"
# resolution-based grounded 
# DISABLED per default: Be aware that the used encoding is the least efficient ASPARTIX encoding for resolution-based grounded semantics
# see: Wolfgang Dvořák, Sarah Alice Gaggl, Johannes Wallner and Stefan Woltran. Making Use of Advances in Answer-Set Programming for Abstract Argumentation Systems. INAP 2011
#tasks="${tasks} DC-RBG"
#tasks="${tasks} DS-RBG"
#tasks="${tasks} EE-RBG"
#tasks="${tasks} SE-RBG"
#tasks="${tasks} CE-RBG"

#+------------------------------------------------------------------------+

#+------------------------------------------------------------------------+
# Set Parameters
CLINGO=${CLINGO:='clingo'}
CLINGO_OLD=${CLINGO_OLD:='clingo440'}
#+------------------------------------------------------------------------+



# Here we hide the actual calls to the solvers and transform 
# the output to ICCMA format
function solver
{
    fileinput=$1    # input file with correct path
    format=$2    # format of the input file (see below)
    task=$3        # task to solve (see below)
    additional=$4    # additional information, i.e. name of an argument

    DIR=$(dirname $0)"/"
    
    case $task in
        #############################################################		
		# Complete Semantics
		#############################################################	
        "DC-CO")
			# Preprocessing with cone of influence
		   (echo ":- not in("$additional")."; (echo "queryArg("$additional")." | cat - $fileinput  | $DIR$CLINGO - "$DIR"tools/safe_cone_of_influence.lp 2>/dev/null | grep cone | sed 's/coneArg/arg/g; s/coneAtt/att/g; s/)/).\n/g')) | $DIR$CLINGO - $DIR"co/complete.lp" 1 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
        ;;
        "DS-CO")
            echo ":- in("$additional")." | cat - $fileinput | $DIR$CLINGO - $DIR"gr/grounded.lp" 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
        ;;
        "EE-CO")
			# We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            # We grep for SATISFIABLE to detect when the solver is done
			echo "["
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO - $DIR"co/complete.lp" 0 2>/dev/null  | grep 'dummy(arg)\|SATISFIABLE' | sed 's/ dummy(arg)//; s/dummy(arg) //; s/dummy(arg)/]/; s/in(//g; s/) /,/g; s/)/]/; s/^/[/; s/\[SATISFIABLE/]/;'
        ;;
        "SE-CO")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO - $DIR"gr/grounded.lp" 2>/dev/null 
        ;;
		"CE-CO")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            $DIR$CLINGO -q  $fileinput $DIR"co/complete.lp" 0 2>/dev/null | grep 'Models'
        ;;
        #############################################################		
		# Stable Semantics
		#############################################################	
        "DC-ST")
		   echo ":- not in("$additional")." | cat - $fileinput | $DIR$CLINGO - $DIR"st/stable.lp" 1 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
        ;;
        "DS-ST")
            echo ":- in("$additional")." | cat - $fileinput | $DIR$CLINGO - $DIR"st/stable.lp" 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
        ;;
        "EE-ST")	
			# We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            # By default we do not have a linebreak after [ such that we can get [] for the empty extension set
            # When clingo outputs the "Answer: 1" line we add a linebreak and then enumerate the extensions as for the other semantics
            # We grep for both SATISFIABLE and UNSATISFIABLE to detect when the solver is done
			printf "["
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO - $DIR"st/stable.lp" 0 2>/dev/null | grep 'dummy(arg)\|SATISFIABLE\|Answer: 1$'| sed 's/ dummy(arg)//; s/dummy(arg) //; s/dummy(arg)/]/; s/in(//g; s/) /,/g; s/)/]/; s/^/[/; s/\[SATISFIABLE/]/; s/\[UNSATISFIABLE/]/; s/\[Answer: 1//;'
        ;;
        "SE-ST")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO - $DIR"st/stable.lp" 2>/dev/null 
        ;;
		"CE-ST")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            $DIR$CLINGO -q  $fileinput $DIR"st/stable.lp" 0 2>/dev/null | grep 'Models'
        ;;
        #############################################################		
		# Admissible Semantics
		#############################################################	
        "DC-ADM")
		   echo ":- not in("$additional")." | cat - $fileinput | $DIR$CLINGO - $DIR"adm/adm.dl" 1 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
        ;;
        "DS-ADM")
            #echo ":- in("$additional")." | cat - $fileinput | $DIR$CLINGO - $DIR"adm/adm.dl" 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
			echo "NO"
        ;;
        "EE-ADM")
			# We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            # We grep for SATISFIABLE to detect when the solver is done
			echo "["
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO - $DIR"adm/adm.dl" 0 2>/dev/null  | grep 'dummy(arg)\|SATISFIABLE' | sed 's/ dummy(arg)//; s/dummy(arg) //; s/dummy(arg)/]/; s/in(//g; s/) /,/g; s/)/]/; s/^/[/; s/\[SATISFIABLE/]/;'
        ;;
        "SE-ADM")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO - $DIR"adm/adm.dl" 2>/dev/null 
        ;;
		"CE-ADM")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            $DIR$CLINGO -q  $fileinput $DIR"adm/adm.dl" 0 2>/dev/null | grep 'Models'
        ;;
        #############################################################		
		# Preferred Semantics
		#############################################################	
        "DC-PR")
			# via complete semantics
		   (echo ":- not in("$additional")."; (echo "queryArg("$additional")." | cat - $fileinput  | $DIR$CLINGO - "$DIR"tools/safe_cone_of_influence.lp 2>/dev/null | grep cone | sed 's/coneArg/arg/g; s/coneAtt/att/g; s/)/).\n/g')) | $DIR$CLINGO - $DIR"co/complete.lp" 1 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
        ;;
        "DS-PR")
			# use preprocessing via cone of influence
            (echo ":- in("$additional")."; (echo "queryArg("$additional")." | cat - $fileinput  | $DIR$CLINGO - "$DIR"tools/safe_cone_of_influence.lp 2>/dev/null | grep cone | sed 's/coneArg/arg/g; s/coneAtt/att/g; s/)/).\n/g')) | $DIR$CLINGO - $DIR"pr/sakama-rienstra.lp" 1 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
        ;;
        "EE-PR")
			# We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            # We grep for SATISFIABLE to detect when the solver is done
			echo "["
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO  - --heuristic=Domain --enum=domRec --out-hide $DIR"/pr/preferred.lp" 0 2>/dev/null | grep 'dummy(arg)\|SATISFIABLE' | sed 's/ dummy(arg)//; s/dummy(arg) //; s/dummy(arg)/]/; s/in(//g; s/) /,/g; s/)/]/; s/^/[/; s/\[SATISFIABLE/]/;'
        ;;
        "SE-PR")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO - --heuristic=Domain --enum=domRec --out-hide $DIR"/pr/preferred.lp" 2>/dev/null 
        ;;
		"CE-PR")
            $DIR$CLINGO  --heuristic=Domain --enum=domRec --out-hide $fileinput $DIR"/pr/preferred.lp" -q 0 2>/dev/null | grep 'Models'
        ;;
		#############################################################		
		# Semi-Stable Semantics
		#############################################################	
        "DC-SST")
			bash $DIR/sst/semi_cred.sh $fileinput $additional | grep -o "UNSATISFIABLE\|SATISFIABLE"
        ;;
        "DS-SST")
			bash $DIR/sst/semi_skept.sh $fileinput $additional | grep -o "UNSATISFIABLE\|SATISFIABLE"
        ;;
        "EE-SST")
			# We grep for FIN to detect when the solver is done
		   echo "["
           bash "$DIR"sst/semi_enum.sh $fileinput | sed 's/in(//g; s/) /,/g; s/)/]/; s/^/[/; s/\[FIN/]/; s/\[$/\[]/' 
        ;;
        "SE-SST")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO - --heuristic=Domain --enum=domRec --out-hide $DIR"sst/semi_some_extension.lp" 2>/dev/null 
        ;;
		"CE-SST")
            bash "$DIR"sst/semi_count.sh $fileinput
        ;;
		#############################################################		
		# Stage Semantics
		#############################################################	
        "DC-STG")
            bash $DIR/stg/stage_cred.sh $fileinput $additional 2>/dev/null
        ;;
        "DS-STG")
            bash $DIR/stg/stage_skept.sh $fileinput $additional | grep -o "UNSATISFIABLE\|SATISFIABLE"
        ;;
        "EE-STG")
            # Output is handled by the script
            bash "$DIR"stg/stage_enum.sh $fileinput
        ;;
        "SE-STG")
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO - --heuristic=Domain --enum=domRec --out-hide $DIR"stg/stage_some_extension.lp" 2>/dev/null
        ;;
        "CE-STG")
            # Output is handled by the script
            bash "$DIR"stg/stage_count.sh $fileinput
        ;;		
		
		
		#############################################################		
		# Grounded Semantics
		#############################################################	
        "DC-GR")
			echo ":- not in("$additional")."  | cat - $fileinput | $DIR$CLINGO - $DIR"gr/grounded.lp" 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
        ;;
        "DS-GR")
			echo ":- in("$additional")."  | cat - $fileinput | $DIR$CLINGO - $fileinput $DIR"gr/grounded.lp" 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
        ;;
        "EE-GR")
			# We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            echo "["
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO - $DIR"gr/grounded.lp" 2>/dev/null  | grep 'dummy(arg)\|SATISFIABLE' | sed 's/ dummy(arg)//; s/dummy(arg) //; s/dummy(arg)/]/; s/in(//g; s/) /,/g; s/)/]/; s/^/[/; s/\[SATISFIABLE/]/;'
        ;;
        "SE-GR")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO - $DIR"gr/grounded.lp" 2>/dev/null 
        ;;
		"CE-GR")
            echo "1"
        ;;
		#############################################################		
		# Ideal Semantics
		#############################################################	
        "DC-ID")
		   # Preprocessing with cone of influence
		   (echo ":- not in("$additional")."; (echo "queryArg("$additional")." | cat - $fileinput  | $DIR$CLINGO - $DIR"tools/safe_cone_of_influence.lp" 2>/dev/null | grep cone | sed 's/coneArg/arg/g; s/coneAtt/att/g; s/)/).\n/g')) | $DIR$CLINGO_OLD - $DIR"ids/idealset_comp.lp" 1 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
        ;;
        "DS-ID") 
			# Same problem as DC-ID  (but we have to flip the satisfiable/unsatisfiable answers)
			(echo ":- not in("$additional")."; (echo "queryArg("$additional")." | cat - $fileinput  | $DIR$CLINGO - "$DIR"tools/safe_cone_of_influence.lp 2>/dev/null | grep cone | sed 's/coneArg/arg/g; s/coneAtt/att/g; s/)/).\n/g')) | $DIR$CLINGO_OLD - $DIR"ids/idealset_comp.lp" 1 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE" |  sed 's/UNSATISFIABLE/GAUSS/g; s/SATISFIABLE/UNSATISFIABLE/g; s/GAUSS/SATISFIABLE/g;'
        ;;
        "EE-ID")
			# We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            echo "["
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO - $DIR/id/labBased_comp.dl -e brave 2>/dev/null | grep 'in(' | sed 's/in(/credIn(/g; s/)/)./g' | cat - $fileinput | $DIR$CLINGO - $DIR"id/ideal-fixed-point.lp" 2>/dev/null   | grep 'dummy(arg)\|SATISFIABLE' | sed 's/ dummy(arg)//; s/dummy(arg) //; s/dummy(arg)/]/; s/in(//g; s/) /,/g; s/)/]/; s/^/[/; s/\[SATISFIABLE/]/;'
        ;;
        "SE-ID")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO - $DIR/id/labBased_comp.dl -e brave 2>/dev/null | grep 'in(' | sed 's/in(/credIn(/g; s/)/)./g' | cat - $fileinput | $DIR$CLINGO - $DIR"id/ideal-fixed-point.lp" 2>/dev/null 
        ;;
		"CE-ID")
            echo "1"
        ;;
		#############################################################		
		# Ideal Sets
		#############################################################	
        "DC-IDS") # same as DC-ID
		   # Preprocessing with cone of influence
		   (echo ":- not in("$additional")."; (echo "queryArg("$additional")." | cat - $fileinput  | $DIR$CLINGO - $DIR"tools/safe_cone_of_influence.lp" 2>/dev/null | grep cone | sed 's/coneArg/arg/g; s/coneAtt/att/g; s/)/).\n/g')) | $DIR$CLINGO_OLD - $DIR"ids/idealset_comp.lp" 1 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
        ;;
        "DS-IDS")
            #echo ":- in("$additional")." | $DIR$SOLVEROLD - $fileinput $DIR$ENCDIR/$IDSENC 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
            echo "NO"
        ;;
        "EE-IDS")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            # We grep for SATISFIABLE to detect when the solver is done
			echo "["
			# echo "dummy(arg). #show dummy/1." | $DIR$SOLVEROLD - $fileinput $DIR$ENCDIR/$IDSENC 0 2>/dev/null | grep 'dummy(arg)\|SATISFIABLE' | sed 's/ dummy(arg)//; s/dummy(arg) //; s/dummy(arg)/]/; s/in(//g; s/) /,/g; s/)/]/; s/^/[/; s/\[SATISFIABLE/]/;' #There is a bug such that we get each extension/answer-set twice

            echo "dummy(arg). #show dummy/1." | $DIR$CLINGO - $DIR"ids/labBased_comp.dl" $fileinput -e brave 2>/dev/null | grep 'in(' | sed 's/in(/credIn(/g; s/)/)./g' | $DIR$CLINGO -  $DIR"ids/idealset-outarg.lp" $DIR"ids/adm.dl" $fileinput 0 2>/dev/null | grep 'dummy(arg)\|SATISFIABLE' | sed 's/ dummy(arg)//; s/dummy(arg) //; s/dummy(arg)/]/; s/in(//g; s/) /,/g; s/)/]/; s/^/[/; s/\[SATISFIABLE/]/;'
        ;;
        "SE-IDS") # Different from SE-ID as we can return any ideal set, eg the empty one
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            #echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO_OLD - $DIR"ids/idealset.lp" 2>/dev/null 
             
			echo "dummy(arg)"
        ;; 
		"CE-IDS")
            $DIR$CLINGO $DIR"ids/labBased_comp.dl" $fileinput -e brave 2>/dev/null | grep 'in(' | sed 's/in(/credIn(/g; s/)/)./g' | $DIR$CLINGO -  -q $DIR"ids/idealset-outarg.lp" $DIR"ids/adm.dl" $fileinput 0 2>/dev/null |grep 'Models'
        ;;
		#############################################################		
		# Naive Semantics
		#############################################################	
		"DC-NAI")
            echo ":- not in("$additional")." | cat - $fileinput | $DIR$CLINGO -  $DIR"nai/naive.dl" 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
            # TODO DC test can be simplified
        ;;
        "DS-NAI")
            echo ":- in("$additional")." | cat - $fileinput | $DIR$CLINGO -  $DIR"nai/naive.dl" 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
            # TODO DS test can be simplified
        ;;
        "EE-NAI")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            # We grep for SATISFIABLE to detect when the solver is done
			echo "["
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO -  $DIR"nai/naive.dl" 0 2>/dev/null | grep 'dummy(arg)\|SATISFIABLE' | sed 's/ dummy(arg)//; s/dummy(arg) //; s/dummy(arg)/]/; s/in(//g; s/) /,/g; s/)/]/; s/^/[/; s/\[SATISFIABLE/]/;'
        ;;
        "SE-NAI")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO -  $DIR"nai/naive.dl" 2>/dev/null 
        ;;
		"CE-NAI")
            $DIR$CLINGO -q $fileinput $DIR"nai/naive.dl" 0 2>/dev/null | grep 'Models'
        ;;
		#############################################################		
		# Conflict-free semantics
		#############################################################
        "DC-CF")
            echo ":- not in("$additional")."| cat - $fileinput | $DIR$CLINGO -  $DIR"cf/cf.dl" 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
            # TODO DC test can be simplified
        ;;
        "DS-CF")
            echo "NO"
        ;;
        "EE-CF")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            # We grep for SATISFIABLE to detect when the solver is done
			echo "["
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO -  $DIR"cf/cf.dl" 0 2>/dev/null | grep 'dummy(arg)\|SATISFIABLE' | sed 's/ dummy(arg)//; s/dummy(arg) //; s/dummy(arg)/]/; s/in(//g; s/) /,/g; s/)/]/; s/^/[/; s/\[SATISFIABLE/]/;'
        ;;
        "SE-CF")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            #echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO -  $DIR"cf/cf.dl" 2>/dev/null 
            # Could also be
            echo "dummy(arg)"   
        ;;
		"CE-CF")
            $DIR$CLINGO -q $fileinput $DIR"cf/cf.dl" 0 2>/dev/null | grep 'Models'
        ;;  		
		#############################################################		
		# cf2 semantics
		#############################################################
        "DC-CF2")
            echo ":- not in("$additional")."| cat - $fileinput | $DIR$CLINGO - $DIR"cf2/cf2.dl" 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
        ;;
        "DS-CF2")
            echo ":- in("$additional")." | cat - $fileinput | $DIR$CLINGO - $DIR"cf2/cf2.dl" 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
        ;;
        "EE-CF2")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            # We grep for SATISFIABLE to detect when the solver is done
			echo "["
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO - $DIR"cf2/cf2.dl" 0 2>/dev/null | grep 'dummy(arg)\|SATISFIABLE' | sed 's/ dummy(arg)//; s/dummy(arg) //; s/dummy(arg)/]/; s/in(//g; s/) /,/g; s/)/]/; s/^/[/; s/\[SATISFIABLE/]/;'
        ;;
        "SE-CF2")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO - $DIR"cf2/cf2.dl" 2>/dev/null 
        ;; 
		"CE-CF2")
            $DIR$CLINGO -q $fileinput $DIR"cf2/cf2.dl" 0 2>/dev/null | grep 'Models'
        ;; 
		#############################################################		
		# stage2 semantics
		#############################################################
        "DC-STG2")
            echo ":- not in("$additional")." | cat - $fileinput | $DIR$CLINGO - $DIR"stg2/stage2.lp" 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
        ;;
        "DS-STG2")
            echo ":- in("$additional")." | cat - $fileinput | $DIR$CLINGO - $DIR"stg2/stage2.lp" 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
        ;;
        "EE-STG2")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            # We grep for SATISFIABLE to detect when the solver is done
			echo "["
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO - $DIR"stg2/stage2.lp" 0 2>/dev/null | grep 'dummy(arg)\|SATISFIABLE' | sed 's/ dummy(arg)//; s/dummy(arg) //; s/dummy(arg)/]/; s/in(//g; s/) /,/g; s/)/]/; s/^/[/; s/\[SATISFIABLE/]/;'
        ;;
        "SE-STG2")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO - $DIR"stg2/stage2.lp" 2>/dev/null 
        ;;
		"CE-STG2")
            $DIR$CLINGO -q $fileinput $DIR"stg2/stage2.lp" 0 2>/dev/null | grep 'Models'
        ;;
		#############################################################		
		# strongly admissible semantics
		#############################################################
        "DC-STRADM")
            echo ":- not in("$additional")." | cat - $fileinput | $DIR$CLINGO - $DIR"stradm/str_adm.lp" 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
        ;;
        "DS-STRADM")
            #echo ":- in("$additional")." | cat - $fileinput | $DIR$CLINGO - $DIR"stradm/str_adm.lp" 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
			echo "NO"
        ;;
        "EE-STRADM")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            # We grep for SATISFIABLE to detect when the solver is done
			echo "["
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO - $DIR"stradm/str_adm.lp" 0 2>/dev/null | grep 'dummy(arg)\|SATISFIABLE' | sed 's/ dummy(arg)//; s/dummy(arg) //; s/dummy(arg)/]/; s/in(//g; s/) /,/g; s/)/]/; s/^/[/; s/\[SATISFIABLE/]/;'
        ;;
        "SE-STRADM")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            #echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO - $DIR"stradm/str_adm.lp" 2>/dev/null 
			echo "dummy(arg)"
        ;;
		"CE-STRADM")
            $DIR$CLINGO -q $fileinput $DIR"stradm/str_adm.lp" 0 2>/dev/null | grep 'Models'
        ;; 		
		#############################################################		
		# resolution-based grounded semantics
		#############################################################
        "DC-RBG")
            echo ":- not in("$additional")." | cat - $fileinput | $DIR$CLINGO -  $DIR$"rbg/res_ground.dl" 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
        ;;
        "DS-RBG")
            echo ":- in("$additional")." | cat - $fileinput | $DIR$CLINGO -  $DIR$"rbg/res_ground.dl" 2>/dev/null | grep -o "UNSATISFIABLE\|SATISFIABLE"
        ;;
        "EE-RBG")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            # We grep for SATISFIABLE to detect when the solver is done
			echo "["
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO -  $DIR$"rbg/res_ground.dl" 0 2>/dev/null | grep 'dummy(arg)\|SATISFIABLE' | sed 's/ dummy(arg)//; s/dummy(arg) //; s/dummy(arg)/]/; s/in(//g; s/) /,/g; s/)/]/; s/^/[/; s/\[SATISFIABLE/]/;'
        ;;
        "SE-RBG")
            # We use "dummy(arg)." as an easy way to identify answer sets in the clingo output. In particular for empty extensions.
            echo "dummy(arg). #show dummy/1." | cat - $fileinput | $DIR$CLINGO -  $DIR$"rbg/res_ground.dl" 2>/dev/null 
        ;;
		"CE-RBG")
            $DIR$CLINGO -q $fileinput $DIR"rbg/res_ground.dl" 0 2>/dev/null | grep 'Models'
        ;; 
        #############################################################
		#############################################################
        *)
            echo "Task $task not supported"
        ;;
    esac
    
#   check whether solver returned correctly if not return with code 1
    ex=$?
    if [[ $ex != 10 ]] && [[ $ex != 20 ]] && [[ $ex != 0 ]] && [[ $ex != 30 ]] ; then
        exit 1
    fi
}

# Parse clingo output and return iccma conform output
function parse_output()
{
    task=$1
    output=$2
    
    case "$task" in 
	SE-ST)
		# first deal with the case that there is no extension
		TMP=`echo "${output}" | grep "dummy("`
		output=$TMP
		if [[ "$output" == "" ]];
		then
		    echo "NO"
		    return
		fi
		
		echo "${output}" | grep "dummy(arg)" | sed 's/dummy(arg)//; s/undec([^()]*)//g; s/ //g; s/)in(/,/g; s/in(//g; s/)//g; s/$/]/; s/^/[/'
	;;
	SE-*)	      
	    echo "${output}" | grep "dummy(arg)" | sed 's/dummy(arg)//; s/undec([^()]*)//g; s/ //g; s/)in(/,/g; s/in(//g; s/)//g; s/$/]/; s/^/[/'
	;;
	DC-*)
	    echo $output | sed 's/UNSATISFIABLE/NO/; s/SATISFIABLE/YES/'
	;;
	DS-*)
	    echo $output | sed 's/UNSATISFIABLE/YES/; s/SATISFIABLE/NO/'
	;;
	EE-*) # currently unused branch
	;;
	CE-*) echo $output | sed 's/Models : //;'
	;;
	*)
            echoerr "unsupported format or task"
	    exit 1
        ;;
    esac
}

# Retuns information about the system (gets version number from version.txt file)
function information()
{
    echo "Solver: ASPARTIX-V"
    cat version.txt
    echo ""
    echo "Team:"
    echo "Wolfgang Dvorak <dvorak@dbai.tuwien.ac.at>"
    echo "Matthias König <mkoenig@dbai.tuwien.ac.at>"
    echo "Johannes P. Wallner <wallner@dbai.tuwien.ac.at>"
    echo "Stefan Woltran <woltran@dbai.tuwien.ac.at>"
    echo ""
    echo -n "Affiliation: "
    echo "Institute of Logic and Computation, TU Wien, Austria"
}

# Checks all the parameters, whether the given task/file format is support, and all necessary parametes are given.
# If all test are k we start the solver 
function parse_input
{
    if [ "$#" = "0" ]
    then
        information
        exit 0
    fi
    local local_problem=""
    local local_fileinput=""
    local local_format=""
    local local_additional=""
    local local_filemod=""
    local local_task=""
    local local_task_valid=""

    while [ "$1" != "" ]; do
        case $1 in
          "--formats")
        list_output 1
        exit 0
        ;;
          "--problems")
        list_output 2
        exit 0
        ;;
          "-p")
        shift
        local_problem=$1
        ;;
          "-f")
        shift
        local_fileinput=$1
        ;;
          "-fo")
        shift
        local_format=$1
        ;;
          "-a")
        shift
        local_additional=$1
        ;;
          "-m")
        shift
        local_filemod=$1
        ;;
        esac
        shift
    done

    if [ -z $local_problem ]
    then
        echo "Task missing"
        exit 0
    else
        for local_task in ${tasks}; do
            if [ $local_task = $local_problem ]
            then
              local_task_valid="true"
			  break;
            fi
        done
        if [ -z $local_task_valid ]
        then
            echo "Invalid task"
            exit 0
        fi
    fi

    if [ -z $local_fileinput ]
    then
        echo "Input file missing"
        exit 0
    fi

   if [ -z $local_filemod ]
    then
		case "$local_problem" in 
		EE-*)
            # Avoid the post processing parser for Enumeration tasks (EE-* tasks) 
            # This is necessary to allow for partial solutions
			solver $local_fileinput $local_format $local_problem $local_additional
		;;
		*)
			# All tasks but enumeration task
			res=$(solver $local_fileinput $local_format $local_problem $local_additional)
			
            # check if solver returned correctly (0), or faulty (1), in latter case don't print anything
            # This is necessary in order to deal with the timeout of ./runsolver which kills processes bottom-up,
            # ie it kills the solver before the skript (this can cause faulty output).
			ex=$?
			if [[ $ex != 0 ]]; then
				exit 1
			fi
			# We parse the clingo output
			parse_output $local_problem "$res"
		;;
		esac
	fi
}

parse_input $@

exit 0
