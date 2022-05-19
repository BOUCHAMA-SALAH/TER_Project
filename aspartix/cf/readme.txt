###############################################################
#####                     README                          #####
###############################################################

This directory contains encodings for reasoning in Dung-Style AFs under
conflict-free semantics.
It is part of the ASPARTIX-V21 system [1] and features the following tasks:
* Credulous reasoning - is a given argument in at least one extension
* (Skeptical reasoning - is a given argument in every extension)
* Enumerate all       - lists all extensions
* Enumerate some      - lists some extension
* Counting            - gives the number of extensions


---------------------------------------------------------------
                           USAGE                               
---------------------------------------------------------------
Requires a current version of clingo.


-----------------  Credulous reasoning  -----------------------
Call:
echo ":- not in("<arg>")." | cat - <af.apx> | clingo - cf.dl

Returns:
* SATISFIABLE:   if the argument is in at least one extension
* UNSATISFIABLE: if the argument is in no extension


-----------------  Skeptical reasoning  -----------------------
This problem is trivially false (as the empty set is conflict-free, no
argument is in every conflict-free set).


--------------------  Enumerate all  --------------------------
clingo cf.dl <af.apx> 0

Returns:
One extension per line; the arguments in the extension are labelled "in"

--------------------  Enumerate some  -------------------------
clingo cf.dl <af.apx>

Returns:
At least one extension
One extension per line; the arguments in the extension are labelled "in"

-----------------------  Counting  ----------------------------
clingo -q cf.dl <af.apx> 0

Returns:
The number of extensions (labelled "Models: ")

References:
[1] https://www.dbai.tuwien.ac.at/proj/argumentation/systempage/
