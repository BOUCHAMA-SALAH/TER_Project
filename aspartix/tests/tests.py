#!/usr/bin/python

import json
import sys
import os
import subprocess


# call this e.g., via python3 tests/tests.py "bash /home/jwallner/Documents/papers/aspartix-v/iccma2021/solver/aspartix-V-interface.sh -p EE-CO -fo apx" tests/test-instances/com cred
# script not finished (parsing problems...)

script, solverstring, folder, mode = sys.argv

# Count successfull and failed tests
count_success=0
count_fails=0

# Output for successfull tests
def SUCCESS(file):
    global count_success
    #print("SUCCESS")
    count_success=count_success+1

# Output for failed tests
def FAIL(file):
    global count_fails
    print("ERROR","#File:",file,"#Mode:",mode,"#Solver:",teststring)
    count_fails=count_fails+1

for filename in os.listdir(folder):
    if filename.endswith(".apx"):
        #print(os.path.join(folder, filename))
        solfile = filename + ".sols"
        #print(os.path.join(folder, solfile))
        
        maxarg = 0
        
        with open(os.path.join(folder, filename), 'r') as file:
            for line in file.readlines():
                predicate, num, remainder = line.replace('(',' ').replace(')',' ').split()
                if predicate == "arg":
                    if maxarg < int(num):
                        maxarg = int(num)

        
        with open(os.path.join(folder, solfile)) as f:
            intendedresult = json.load(f)
        intendedresult[:] = [sorted(i) for i in intendedresult]
        
        if mode in {"enum", "some", "count"}:
            teststring = solverstring + " -f " + os.path.join(folder, filename)
            if sys.version_info.major == 3 and sys.version_info.minor <=6:
                solver = subprocess.Popen(teststring,shell=True, stdout=subprocess.PIPE, stderr=sys.stderr, universal_newlines=True)
            else:
                solver = subprocess.Popen(solverstring + " -f " + os.path.join(folder, filename),shell=True, stdout=subprocess.PIPE, stderr=sys.stderr, text=True)
            solvout, solverr= solver.communicate()
            solver.wait()
            del solver
        
        
        if mode == "enum":
            solvout.replace(" ","")
            if solvout != "[]\n":
                output = solvout.replace("]\n", "],").replace(",],","]").replace("[\n","[")
            else:
                output = solvout
            actualresult = json.loads(output)
            #print(actualresult)
            #print(intendedresult)
            
            actualresult[:] = [sorted(i) for i in actualresult]
            
            if sorted(actualresult) == sorted(intendedresult):
                SUCCESS(file=os.path.join(folder, filename))
            else:
                FAIL(file=os.path.join(folder, filename))
        
        elif mode == "cred":
            allcred = set()
            for el in intendedresult:
                allcred = allcred.union(set(el))
            totest = range(1,maxarg+1)
            for arg in totest:
                teststring = solverstring + " -f " + os.path.join(folder, filename) + " -a " + str(arg)
                if sys.version_info.major == 3 and sys.version_info.minor <=6:
                    credsolver = subprocess.Popen(teststring,shell=True, stdout=subprocess.PIPE, stderr=sys.stderr, universal_newlines=True)
                else:
                    credsolver = subprocess.Popen(teststring,shell=True, stdout=subprocess.PIPE, stderr=sys.stderr, text=True)
                credsolvout, credsolverr = credsolver.communicate()
                credsolver.wait()
                del credsolver
                if "YES" in credsolvout and arg in allcred:
                    SUCCESS(file=os.path.join(folder, filename))
                elif "NO" in credsolvout and arg not in allcred:
                    SUCCESS(file=os.path.join(folder, filename))
                else:
                    FAIL(file=os.path.join(folder, filename))
            
        elif mode == "skept":
            allcred = set()
            for el in intendedresult:
                allcred = allcred.union(set(el))
            allskept = allcred
            for el in intendedresult:
                allskept = allskept.intersection(set(el))
            
            if len(intendedresult) == 0:
                allskept = range(1,maxarg+1)
            
            totest = range(1,maxarg+1)
            
            for arg in totest:
                teststring = solverstring + " -f " + os.path.join(folder, filename) + " -a " + str(arg)
                if sys.version_info.major == 3 and sys.version_info.minor <=6:
                    skeptsolver = subprocess.Popen(teststring,shell=True, stdout=subprocess.PIPE, stderr=sys.stderr, universal_newlines=True)
                else:
                    skeptsolver = subprocess.Popen(teststring,shell=True, stdout=subprocess.PIPE, stderr=sys.stderr, text=True)
                skeptsolvout, skeptsolverr = skeptsolver.communicate()
                skeptsolver.wait()
                del skeptsolver
                if "YES" in skeptsolvout and arg in allskept:
                    SUCCESS(file=os.path.join(folder, filename))
                elif "NO" in skeptsolvout and arg not in allskept:
                    SUCCESS(file=os.path.join(folder, filename))
                else:
                    FAIL(file=os.path.join(folder, filename))

        elif mode == "some":
            
            if "NO" in solvout:
                actualresult = "NO"
            else:
                actualresult = json.loads(solvout)
            
            if len(intendedresult) == 0 and "NO" in actualresult:
                SUCCESS(file=os.path.join(folder, filename))
            elif sorted(actualresult) in intendedresult:
                SUCCESS(file=os.path.join(folder, filename))
            else:
                FAIL(file=os.path.join(folder, filename))
            
            
        elif mode == "count":
            actualresult = json.loads(solvout)
            
            count = len(intendedresult)
            integeractualresult = int(actualresult)
            if count == integeractualresult:
                SUCCESS(file=os.path.join(folder, filename))
            else:
                FAIL(file=os.path.join(folder, filename))
    else:
        continue




#def main(argv):
   #inputfile = ''
   #outputfile = ''
   #try:
      #opts, args = getopt.getopt(argv,"hi:o:",["ifile=","ofile="])
   #except getopt.GetoptError:
      #print 'test.py -i <inputfile> -o <outputfile>'
      #sys.exit(2)
   #for opt, arg in opts:
      #if opt == '-h':
         #print 'test.py -i <inputfile> -o <outputfile>'
         #sys.exit()
      #elif opt in ("-i", "--ifile"):
         #inputfile = arg
      #elif opt in ("-o", "--ofile"):
         #outputfile = arg
   #print 'Input file is "', inputfile
   #print 'Output file is "', outputfile
   

