# Projet : Constitution dynamique d’un modèle de performance de voilier par apprentissage

**-Client :** M. GiIles LEPINARD

**-Enseignant référent:** M. GiIles LEPINARD

**-Equipe Dual Boat** 

<img src="https://github.com/morganLantrade/TP_M1/raw/main/assets_readme/DUAL_BOAT.png" alt="drawing" width="500"/>


## Description et objectifs du projet
#### Contexte
Ceci est un contexte
#### Objectifs
Ceci est une description
![Trombinoscope](https://github.com/morganLantrade/TP_M1/raw/main/assets_readme/projet.png)
Les besoins et contraintes du projet sont disponibles sur ce lien du  [backlog](https://docs.google.com/spreadsheets/d/16Uc-_3CkTmRhTnL7Bv5lchy09DF-uITX/edit?usp=sharing&ouid=103043773177032282236&rtpof=true&sd=true)

## Livrables du projet
|**Livrables organisation projet**|**Livrables développement projet**|
|--------|--------|
|   Présentation Kick-off meeting + Compte rendu   |   Processus outillé de génération de modèle de performance (**POA**)    |
|   Compte rendu réunion plan V1 | Application de génération de polaire (**AGP**)|
|Compte rendu réunion plan V2|    Application de prédiction de performance (**APP**)    |
|Compte rendu réunion plan V3  |

## Organisation du projet

### Rôles
### Communication
### Macro-planning

Ceci est un macro planning 

```mermaid
gantt
    dateFormat  YYYY-MM-DD
    title       Adding GANTT diagram functionality to mermaid
    excludes    weekends
    %% (`excludes` accepts specific dates in YYYY-MM-DD format, days of the week ("sunday") or "weekends", but not the word "weekdays".)

    section A section
    Completed task            :done,    des1, 2014-01-06,2014-01-08
    Active task               :active,  des2, 2014-01-09, 3d
    Future task               :         des3, after des2, 5d
    Future task2              :         des4, after des3, 5d

    section Critical tasks
    Completed task in the critical line :crit, done, 2014-01-06,24h
    Implement parser and jison          :crit, done, after des1, 2d
    Create tests for parser             :crit, active, 3d
    Future task in critical line        :crit, 5d
    Create tests for renderer           :2d
    Add to mermaid                      :1d
    Functionality added                 :milestone, 2014-01-25, 0d

    section Documentation
    Describe gantt syntax               :active, a1, after des1, 3d
    Add gantt diagram to demo page      :after a1  , 20h
    Add another diagram to demo page    :doc1, after a1  , 48h

    section Last section
    Describe gantt syntax               :after doc1, 3d
    Add gantt diagram to demo page      :20h
    Add another diagram to demo page    :48h
```


## Développement du projet
Ceci est l'organisation du projet

### Outils de développement
| |**Processus outillé de génération de modèle de performance (POA)**|**Application de  génération de polaire  (AGP)**|**Application de prédiction de performance (APP)**|
|:--------:|:-----------|:-------------|:-----------|
|  **Langage**  | Python    |Python|C ou C#|
|  **Environnement**  |Windows et Linux 64    |Windows et Linux 64|Windows et Linux 64|
|  **Fichiers**  |   readme,config    |readme,config |readme,config |
 
 **Bibliothèques**  
- sklean
- seaborn 
- matplotlib 
- pandas 
- numpy  
- à définir...
