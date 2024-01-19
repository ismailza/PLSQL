# TP PROCEDURES ET FONCTIONS STOCKEES

On se place toujours au niveau du schéma Oracle : « `HR` » 

## Procédures stockées

1.	Ecrire une procédure stockée « `supprimer_employe` » permettant de supprimer un employé dont on spécifie le numéro.

    a. Exécuter la procédure dans l’environnement SQLPlus avec numero=`101`.\
  	b. Vérifier la suppression en utilisant l’ordre SQL SELECT correspondant.

2.	Ecrire une procédure stockée « `Comm_employe` » permettant d’identifier la commission d’un employé dont le numéro est introduit par l’utilisateur.

    - Si la commission est nulle alors le message « commission est nulle » est affiché.
    - Si non majorer la commission de l’employé par un taux introduit par l’utilisateur. La commission est affichée avant et après la mise à jour.

    a. Exécuter la procédure dans l’environnement SQLPlus avec les paramètres effectifs : (noemployé=`100`, txcomm=`1.1`) et avec (`102`, `1.2`).

    b. Vérifier la mise à jour en utilisant l’ordre SQL SELECT correspondant.

3.	Afficher le code source de la procédure « `supprimer_employe` » créée en 1. Utiliser la vue `USER_SOURCE (NAME, TYPE, LINE, TEXT).`

4.	Afficher la liste des objets de l’utilisateur en cours utiliser la vue `USER_OBJECTS`

5.	Afficher toutes les tables de l’utilisateur en cours

6.	Afficher la liste des procédures stockées par l’utilisateur en cours.

7.	Afficher la liste des procédures stockées par tous les utilisateurs.

8.	Créer une procédure stockées qui permet d’afficher les noms des n premiers employés d’un département donné. Gérer le cas où n est supérieur au nombre des employés du département.  

9.	Créer une procédure stockée qui permet de copier le contenu d’une table dans une nouvelle vue. Le nom de la nouvelle vue doit correspondre à cette chaine : « `Vue_nomtable` ».

10.	Ecrire une procédure stockée « `dep_nbremp` » qui récupère le nombre d’employés qu’un  département donné contient dans un paramètre de sortie `outnbremp` de type `Number`.

    a-	Déclarer une variable `cptemp` de type `Number` dans l’environnement SQLPLus\
    b-	afficher ensuite la valeur du paramètre de sortie par le biais du `cptemp`.


## Fonction stockées
 
1.	Ecrire une fonction stockée « `max_sal_job` » permettant de calculer le maximum des salaires des employés dont le job est introduit par l’utilisateur.
 
    a-	Déclarer une variable `max_sal` de type `NUMBER` dans l’environnement SQLPlus.\
    b-  Exécuter cette fonction dans l’environnement SQLPlus avec `job = 'SALE_MAN'`.
    Et afficher ensuite le contenu `max_sal`.

2.	Ecrire une fonction stockée « `dep_nbremp` » qui retourne le nombre d’employés qu’un  département donné contient.

    a-	Déclarer une variable `cptemp` de type `INTEGER` dans l’environnement SQLPLus
    b-	Exécuter cette fonction dans l’environnement SQLPlus avec numéro de département = `90`. Et afficher ensuite le contenu de `cptemp`.
 
3- Afficher la liste des fonctions stockées créées par tous les utilisateurs.

4- Afficher la liste des fonctions stockées par l’utilisateur en cours

5.	Écrire une fonction qui permet d’insérer un enregistrement dans la table employés et qui retourne le numéro d’employé inséré. l’insertion utilise une séquence.
