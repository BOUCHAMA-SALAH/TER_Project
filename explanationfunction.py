import os

def DS_PR(args):
  list = []
  for i in args :
    s = os.popen(f'bash ./aspartix/aspartix-V-interface.sh -p DS-PR  -fo apx -f arg.apx -a {i} ').read()
    s=s.replace('\n', '')
    if (s == 'YES'):
      list.append(i)

  return list

def DS_NAI(args):
  list = []
  for i in args :
    s = os.popen(f'bash ./aspartix/aspartix-V-interface.sh -p DS-NAI  -fo apx -f arg.apx -a {i} ').read()
    s=s.replace('\n', '')
    if (s == 'YES'):
      list.append(i)
  return list

def interpreter(data, exp):
    j = 0
    for index in data.index:
      s = ""
      if len(exp[j]) == 0:
        print(f" **** No explanation for the instance {index}.")
      else:
        s = s + f" **** the instance {index} is classified in {data[data.columns[-1]][index]} because : "
        for r in exp[j]:
          for f in r:
            s = s + f"the value of the attribute '{f[0]}' is :'{f[1]}'|  "

      print(s)
      j = j + 1


def novel_explanation_function(test_set, arg, D_arg):
  expliacations = []
  for index in test_set.index:

    explication = []
    for i in arg:
      compatible = True
      for e in D_arg[i][0]:
        if (test_set[e[0]][index] != e[1]):
          compatible = False
      if compatible == True:
        explication.append(D_arg[i][0])
    expliacations.append(explication)

  return expliacations



### score based on how many time the argument apear in the dataset
def score_argument(arg, data):
        s = data
        for i in arg[0]:
            s = s[s[i[0]] == i[1]]
        return len(s)
### score based on how many the score of the feature used by the argument
def score(feature , args):
    score = 0
    for i in args.keys():
        for j in args[i][0]:
            if j[0] == feature :
                score = score + 1
    return score

def score_argument2 (arg, args):
    sc  = 0
    for i in arg[0]:
        sc = sc + score(i[0],args)
    return sc