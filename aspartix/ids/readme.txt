###############################################################
#####                     README                          #####
###############################################################

This directory contains encodings for reasoning in Dung-Style AFs under
ideal sets semantics.
It is part of the ASPARTIX-V21 system [1] and features the following tasks:
* Credulous reasoning - is a given argument in at least one extension
* (Skeptical reasoning - is a given argument in every extension)
* Enumerate all       - lists all extensions
* Enumerate some      - lists some extension
* Counting            - gives the number of extensions


---------------------------------------------------------------
                           USAGE                               
---------------------------------------------------------------
Requires a current version of clingo
AND clingo version 4.4.0


-----------------  Credulous reasoning  -----------------------
Call:
echo ":- not in(<arg>)." | cat - <af.apx> | clingo440 - idealset_comp.lp 1  | grep -o "UNSATISFIABLE\|SATISFIABLE"

Returns:
* SATISFIABLE:   if the argument is in at least one extension
* UNSATISFIABLE: if the argument is in no extension


-----------------  Skeptical reasoning  -----------------------
This problem is trivially false (as the empty set is an ideal set, no
argument is in every ideal set).


--------------------  Enumerate all  --------------------------
echo "dummy(arg). #show dummy/1." | clingo - labBased_comp.dl <af.apx> -e brave | grep 'in(' | sed 's/in(/credIn(/g; s/)/)./g' | clingo -  idealset-outarg.lp adm.dl <af.apx> 0 | grep 'dummy(arg)\|SATISFIABLE' | sed 's/ dummy(arg)//; s/dummy(arg) //; s/dummy(arg)/]/; s/in(//g; s/) /,/g; s/)/]/; s/^/[/; s/\[SATISFIABLE/]/;'

Returns:
One extension per line

--------------------  Enumerate some  -------------------------
echo "dummy(arg). #show dummy/1." | clingo - labBased_comp.dl <af.apx> -e brave | grep 'in(' | sed 's/in(/credIn(/g; s/)/)./g' | clingo -  idealset-outarg.lp adm.dl <af.apx> | grep 'dummy(arg)\|SATISFIABLE' | sed 's/ dummy(arg)//; s/dummy(arg) //; s/dummy(arg)/]/; s/in(//g; s/) /,/g; s/)/]/; s/^/[/; s/\[SATISFIABLE/]/;'

Returns:
One extension per line

-----------------------  Counting  ----------------------------
clingo labBased_comp.dl <af.apx> -e brave | grep 'in(' | sed 's/in(/credIn(/g; s/)/)./g' | clingo -  -q idealset-outarg.lp adm.dl <af.apx> 0 |grep 'Models'

Returns:
The number of extensions (labelled "Models: ")

References:
[1] https://www.dbai.tuwien.ac.at/proj/argumentation/systempage/
