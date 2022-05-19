import sys
import json
from collections import Counter

with open(sys.argv[1]) as f:
    lines1 = json.load(f)

with open(sys.argv[2]) as d: 
    lines2 = json.load(d)

elements1 = []

# then use the range function to do 0 to 5 counts
for i in lines1:
  #print i
  elements1.append(sorted(i))

elements2 = []

# then use the range function to do 0 to 5 counts
for i in lines2:
  #print i
  elements2.append(sorted(i))

#print lines1
#print lines2

first_set = set(map(tuple, elements1))
secnd_set = set(map(tuple, elements2))

#print first_set
#print secnd_set

print first_set.symmetric_difference(secnd_set) 

#print sorted(lines1) == sorted(lines2)