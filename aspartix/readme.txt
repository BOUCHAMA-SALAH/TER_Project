###############################################################
#####                     README                          #####
###############################################################

This is ASPARTIX-V which provides a command line ICCMA-style[2] interface to the ASPARTIX[1] system for Dung style abstract argumentation frameworks. 

The latest version is available at:
https://www.dbai.tuwien.ac.at/research/argumentation/aspartix/dung.html#iccma_interface

################
# Install
################

This interface is made for Unix systems and make use of the following standard tools
# * bash 
# * cat, grep, sed
# * python (for certain reasoning tasks) 

In order to install this system make sure these tools work properly on your system and unpack this archive at an appropriate place in your system.

You can test your installation using the "run-tests.sh" script.
Either by "bash run-tests.sh" for quick i/o tests or by 
"bash run-tests.sh -m full" to run additional correctness tests.

################
# Interface
################
ASPARTIX-V can be started via the "aspartix-V-interface.sh" script.
A generic call to the solver is of the following form

bash aspartix-V-interface.sh -p TASK -fo apx -f INSTANCE -a ARG

or alternatively (if file permissions of aspartix-V-interface.sh are set to executable)

./aspartix-V-interface.sh -p TASK -fo apx -f INSTANCE -a ARG

where

    TASK is one of the abbreviations for a reasoning task in the format MODE-SEM where
        MODE is one of the reasoning modes: DS (skeptical acceptance), DC (credlous acceptance), EE (enumerate all extensions), SE (compute some extension),
		CE (count extensions)
        SEM is one of the semantics: GR (grounded), CF (conflict-free), NAI (naive), ADM (admissible), CO (complete), ST (stable), PR (preferred), ID (ideal), IDS (ideal sets), SST (semi-stable), STG (stage), CF2 (cf2), STG2 (stage2), STRADM (strongly admissible)
    INSTANCE is the file name of the instance, ie an argumentation framework, to be processed
    ARG is an argument of that instance to be considered for credulous or skeptical reasoning (can be omitted for other tasks)

Find below an example call for instance test_instance.apx and skeptical acceptance of argument 339 w.r.t. preferred semantics:

bash aspartix-V-interface.sh -p DS-PR  -fo apx 
        -f test_instance.apx -a 339 

################
# Known issues
################

Our scripts use the "sed" command line tool and is not compatible with the standard Mac OS X "sed" implementation. To use the script under Mac OS install gnu-sed and replace "sed" calls by "gsed".


################
# References
################

[1] https://www.dbai.tuwien.ac.at/research/argumentation/aspartix/
[2] http://argumentationcompetition.org/
