###############################################################
#####                     README                          #####
###############################################################

This directory contains encodings for reasoning in Dung-Style AFs under
ideal semantics.
It is part of the ASPARTIX-V21 system [1] and features the following tasks:
* Credulous reasoning - is a given argument in at least one extension
* (Skeptical reasoning - is a given argument in every extension)
* Enumerate all       - lists all extensions
* (Enumerate some      - lists some extension)
* (Counting            - gives the number of extensions)


---------------------------------------------------------------
                           USAGE                               
---------------------------------------------------------------
Requires a current version of clingo.


-----------------  Credulous reasoning  -----------------------
Call:
echo ":- not in ("<arg>"). dummy(arg). #show dummy/1. " | cat - <af.apx> | clingo - labBased_comp.dl -e brave | grep 'UNSATISFIABLE\|in(' | sed 's/in(/credIn(/g; s/)/)./g;s/UNSATISFIABLE/credIn(dummy). :- credIn(dummy). /g;' | cat - <af.apx> | clingo - ideal-fixed-point.lp | grep 'UNSATISFIABLE\|SATISFIABLE'


Returns:
* SATISFIABLE:   if the argument is in the ideal extension
* UNSATISFIABLE: if the argument is in not in the ideal extension


-----------------  Skeptical reasoning  -----------------------
As ideal semantic yields exactly 1 extension, this coincides
with Credulous reasoning.

--------------------  Enumerate all  --------------------------
echo "dummy(arg). #show dummy/1." | cat - <af.apx> | clingo - labBased_comp.dl -e brave | grep 'in(' | sed 's/in(/credIn(/g; s/)/)./g' | cat - <af.apx> | clingo - ideal-fixed-point.lp | grep 'dummy(arg)\|SATISFIABLE' | sed 's/dummy(arg)//g;'


Returns:
The ideal extension, the arguments in the extension are labelled "in"

--------------------  Enumerate some  -------------------------
As ideal semantic yields exactly 1 extension, this coincides
with Enumerate all.

-----------------------  Counting  ----------------------------
Ideal semantic yields exactly 1 extension.


References:
[1] https://www.dbai.tuwien.ac.at/proj/argumentation/systempage/
