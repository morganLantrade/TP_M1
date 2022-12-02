# Résolution d'une instance de sac a dos lue dans un fichier
# Suppose que les commentaires commencent par #, que la capacité est sur la première ligne non commentée, et que les autres lignes décrivent les objets : 1 par ligne, d'abord une id puis le poids puis la valeur

param fichier := "./u20_00.bpa" ;
param name := read fichier as "1n" comment "#" use 1 ;
param capacite :=  read fichier as "1n" comment "#" use 1 ;
param nb_objets:=  read fichier as "2n" comment "#" use 1 ;
do print "capacite : " , capacite ;
do print "nb_objets : " , nb_objets ;

set Objets := { 1 to nb_objets by 1 } ;
set Boites := { 1 to nb_objets by 1 } ;

set tmp [ <i > in I ] := { read file as " <1n >" skip 1+ i use 1} ;
param taille [ <i > in I ] := ord ( tmp [ i ] ,1 ,1);


param poids[Objets] := read fichier as "<1s> 2n" comment "#" skip 1 ;
param valeurs[Objets] := read fichier as "<1s> 3n" comment "#" skip 1 ;
do forall <i> in Objets: print "objet " , i, " : poids = ", poids[i] , " valeurs = " , valeurs[i] ;

var y[Boites] binary;
var x[Objets*Boites] binary;

minimize y : sum<j> in Boites: y[j];
subto unObjet_uneBoite :
	forall <i> in Objets:
		sum<j> in Boites: x[i,j] == 1;

subto uneBoiteUtilisee_unObjet:
	forall <j> in Boites:
		forall <i> in Objets : x[i,j] <= y[j];

subto capaciteBoite:
	forall <j> in Boites:
		sum<i> in Objets : x[i,j]* taille[i] <= capacite;
