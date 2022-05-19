import itertools as it

# generer les explication plausible.
def plausible_explanation(data):
    H = []
    features = []
    for i in data.columns:
        features.append(i)
    target = [features[-1]]
    features.remove(features[-1])
    for index in data.index:
        features_used = []
        i = 1
        while (features_used != features) and i <= len(features):
            combinaisons = list(it.combinations([c for c in features if c not in features_used], i))
            for comb in combinaisons:
                utile = True
                red = data.filter(items=list(comb) + target)
                values = []
                for f in red.columns:
                    values.append(red[f][index])
                for n, row in red[(red[target[0]] != values[-1])].iterrows():

                    if (list(row)[0:-1] == values[0:-1]):
                        if list(row)[-1] != values[-1]:
                            utile = False
                            break


                if utile == True:
                    h = []
                    for feature in comb:
                        h.append((feature, values[comb.index(feature)]))
                        features_used.append(feature)
                    h = h+[values[-1]]
                    if h not in H: H.append(h)
            i = i + 1
    return H


"""#Construction d'argument (Definition 9)  """


def get_arg(H):
    arg = []
    for h in H:
        arg.append([h[0:-1]])
        arg[-1].insert(1, h[-1])
    return arg


def create_dict(arg):
    dictionary = {}
    it = 1
    for i in arg:
        a = f"a{it}"
        dictionary[a] = [i[0], i[1]]
        it = it + 1
    return dictionary


"""Cette fonction vérifier la consistence

"""


def is_consist(h1, h2):
    for i in h1[0]:
        for j in h2[0]:
            if i[0] == j[0] and i[1] != j[1]:
                return False

    return True


"""# Création du systém d'argumentation (Definition 10 et 11)"""


def Argumentation_System(D_arg):
    R = []
    arg = [x for x in list(D_arg.keys())]
    for i in list(it.combinations(D_arg, 2)):
        if is_consist(D_arg[i[0]], D_arg[i[1]]) == True and D_arg[i[0]][1] != D_arg[i[1]][1]:
            l = (i[1], i[0])
            R.append(i)
            R.append(l)
    return arg, R


"""Gération du fichier ASPARTIX"""


def generate_apx(AS):
    apx = ""
    for i in AS[0]:
        apx = apx + f"arg({i}).\n"
    for i in AS[1]:
        apx = apx + f"att({i[0]},{i[1]}).\n"
    with open('./arg.apx', 'w') as file:
        file.write(apx)


"""Manuel du system d'argumentation

"""


def generate_man(D_arg):
    man = ""
    for key, value in D_arg.items():
        man = man + f"{key} = {value[0]} , Class : {value[1]} \n"
    with open('./manuel.txt', 'w') as file:
        file.write(man)