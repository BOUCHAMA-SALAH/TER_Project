from sklearn.model_selection import train_test_split
from definition import *
from explanationfunction import *
import pandas as pd


def remove_1(R,dict,data):
    for i in R:
        if score_argument(dict[i[0]],data) < score_argument(dict[i[1]],data) :
            R.remove(i)
    return R

def remove_2(R,dict):
    for i in R:
        if score_argument2(dict[i[0]],dict) < score_argument2(dict[i[1]],dict) :
            R.remove(i)
    return R

# pour  casser de symetrie avec l'approach 1
def process(data):
    H = plausible_explanation(data)
    print(H)
    arg = get_arg(H)
    D_arg = create_dict(arg)
    AS = Argumentation_System(D_arg)
    remove_1(AS[1],D_arg,data)
    generate_apx(AS)
    generate_man(D_arg)
    return D_arg


# pour  casser de symetrie avec l'approach 2
def process1(data):
    H = plausible_explanation(data)
    print(H)
    arg = get_arg(H)
    D_arg = create_dict(arg)
    AS = Argumentation_System(D_arg)
    remove_2(AS[1],D_arg)
    generate_apx(AS)
    generate_man(D_arg)
    return D_arg


# introduire le nom du fichier en csv
data = pd.read_csv("car.csv")


# diviser le dataset en train et test data
train, test = train_test_split(data, test_size=0.3)

# selon le choix de l'approache choisit choisir entre la fonction process et process1 
D_arg = process(train)
args = list(D_arg.keys())


# generer les argument pour la fonction
prefered =DS_PR(args)

# selectioner le nombre d'instance a prendre aleatoirement de test data
t = test.sample(8)

#generer les explication
exp = novel_explanation_function(test,prefered,D_arg)

#lancer l'interpretaur qui interprete les explications
interpreter(t,exp)

