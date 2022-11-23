import numpy as np
import random



def lireMatrice(nom_fichier):
    with open(nom_fichier) as f:
        lines = f.readlines()
    lines=lines[0].strip().split()
    n=int(lines[0])
    p=int(lines[1])
    M= [ lines[i:i+n] for i in range(2,n*n,n)]
    for i in range(n):
        for j in range(n):
            M[i][j]=int(M[i][j])
    M=np.array(M)
    return M,n,p

def initial_solution(n):
    X = [ random.randint(0,1) for _ in range(n)]
    return X

def compute(Q,X):
    return sum(Q[i][j]*X[i]*X[j] for i in range(n) for j in range(n))

def best_neighbour(Q,X):
    n=len(X)
    min = compute(Q,X)
    trouve=False
    min_X = X
    for i in range(n):
        X[i]=1-X[i] #inverse
        F_x=compute(Q,X)
        if F_x < min:
            min_X=X.copy()
            min=F_x
            trouve=True
        if F_x == min and random.randint(0,1)==0: #aleatoirement
            min_X=X.copy()
            min=F_x
            trouve=True
        X[i]=1-X[i] #remet le X d'origine
    return min_X if trouve else [],min


def best_neighbour_non_tabou(Q,X,Tabou):
    n=len(X)
    min_X=None
    min=10**10
    for i in range(n):
        X[i]=1-X[i] #inverse
        F_x=compute(Q,X)
        if F_x < min and X not in Tabou:
            min_X=X.copy()
            min=F_x
            trouve=True
        if F_x == min and random.randint(0,1)==0 and not X in Tabou: #aleatoirement
            min_X=X.copy()
            min=F_x
        X[i]=1-X[i] #remet le X d'origine
    return min_X ,min


def Hill_Climbing(Q,MAX_depl):
    X=initial_solution(Q.shape[0])
    nb_depl=0
    stop=False
    while nb_depl < MAX_depl and not(stop):
        best_X,best_value=best_neighbour(Q,X)
        #verification qu'on a trouvé un meilleur voisin
        if not(best_X):
            stop=True
        else:
            nb_depl+=1
            X=best_X
    return X,best_value

def nHill_Climbing(Q,MAX_depl,MAX_essais):
    min,value=Hill_Climbing(Q,MAX_depl)
    nb_essais=0
    while nb_essais<MAX_essais:
        a,b=Hill_Climbing(Q,MAX_depl)
        if b<value: #meilleure solution
            min,value=a,b
        nb_essais+=1
    return min,value

def tabouMethode(Q,MAX_depl):
    X=initial_solution(Q.shape[0])
    Tabou=[]
    nb_depl=0
    msol=X
    STOP=False
    while not(STOP) and nb_depl < MAX_depl:
        best_X,best_value=best_neighbour_non_tabou(Q,X,Tabou)
        if best_X is None:
            STOP=True
        else:
            Tabou.append(best_X)
            print(Tabou,best_value)
            if compute(Q,msol)>best_value: #meilleur solution
                msol=best_X
        X=best_X
        nb_depl+=1
    return msol,compute(Q,msol)




print("partition6")
M,n,p=lireMatrice('partition6.txt')
print(M)
print(nHill_Climbing(M,10,10))
print(tabouMethode(M,10))
print("-----------------------------------X=initial_solution(n)----")

print("graphe1245")
M,n,p=lireMatrice('graphe12345.txt')
print(M)
print(nHill_Climbing(M,10,10))
print(tabouMethode(M,10))
