###############################################################
#####                     README                          #####
###############################################################

This directory contains encodings for reasoning in Dung-Style AFs under
grounded semantics.
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
echo ":- not in("<arg>")." | cat - <af.apx> | clingo - grounded.lp

Returns:
* SATISFIABLE:   if the argument is in the grounded extension
* UNSATISFIABLE: if the argument is in not in the grounded extension


-----------------  Skeptical reasoning  -----------------------
As grounded semantic yields exactly 1 extension, this coincides
with Credulous reasoning.

--------------------  Enumerate all  --------------------------
clingo grounded.lp <af.apx>

Returns:
One extension per line; the arguments in the extension are labelled "in"

--------------------  Enumerate some  -------------------------
As grounded semantic yields exactly 1 extension, this coincides
with Enumerate all.

-----------------------  Counting  ----------------------------
Grounded semantic yields exactly 1 extension.


References:
[1] https://www.dbai.tuwien.ac.at/proj/argumentation/systempage/
