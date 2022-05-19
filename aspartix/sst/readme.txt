###############################################################
#####                     README                          #####
###############################################################

This directory contains encodings for reasoning in Dung-Style AFs under
semi-stable semantics.
It is part of the ASPARTIX-V21 system [1] and features the following tasks:
* Credulous reasoning - is a given argument in at least one extension
* Skeptical reasoning - is a given argument in every extension
* Enumerate all       - lists all extensions
* Enumerate some      - lists some extension
* Counting            - gives the number of extensions


---------------------------------------------------------------
                           USAGE                               
---------------------------------------------------------------
If used outside the ASPARTIX-V21 system, one must set the path to
* a current version of clingo
* clingo v4.4.0
in the "settings" file.


-----------------  Credulous reasoning  -----------------------
Call:
bash semi_cred.sh <af.apx> <arg>

Returns:
* SATISFIABLE:   if the argument is in at least one extension
* UNSATISFIABLE: if the argument is in no extension


-----------------  Skeptical reasoning  -----------------------
Call:
bash semi_skept.sh <af.apx> <arg>

Returns:
* UNSATISFIABLE: if the argument is in every extension (i.e. there is no counter example)
* SATISFIABLE  : if the argument is not in every extension


--------------------  Enumerate all  --------------------------
bash semi_enum.sh <af.apx>

Returns:
One extension per line; the arguments in the extension are labelled "in"

--------------------  Enumerate some  -------------------------
clingo --heuristic=domain --enum=domRec --out-hide <af.apx> semi_some_extension.lp 1

Returns:
One extension; the arguments in the extension are labelled "in"

-----------------------  Counting  ----------------------------
bash semi_count.sh <af.apx> 

Returns:
The number of extensions   


References:
[1] https://www.dbai.tuwien.ac.at/proj/argumentation/systempage/
