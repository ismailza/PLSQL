# TP Records & Curseurs

1.	Créer les blocs `PLSQL` qui répondent aux questions suivantes : (un bloc par question) 

    a)	Utiliser premièrement une variable de même type que les enregistrements de la table « `employees` » pour afficher toutes les informations initiales de l’employé dont le matricule est saisi par l’utilisateur.

    b)	Modifier ensuite le `salaire` et `l’email` de cet employé dont le `matricule` et les nouvelles valeurs sont saisies par l’utilisateur. (Vérifier à ce que le nouveau salaire est supérieur à `5000`). 

    c)	Enfin, utiliser une variable « `RECORD` » pour afficher et modifier les mêmes informations de l’employé. 

    d)	Utiliser une variable de session Oracle, pour stocker la date la plus ancienne de recrutement des employés et l’afficher à la fin.

2.	Créer un bloc `PLSQL` qui utilise un curseur `explicite` permettant d’afficher les informations des `départements` qui comptabilisent le même nombre d’employés que le département numéro `30`. Le curseur doit comprendre aussi la masse salariale par département. 

    **Indication** : Exécutez l'instruction `FETCH` dans une boucle simple.
    Utilisez l'expression `EXIT WHEN curseur%NOTFOUND` pour sortir de la boucle.

3.	Réécrire le bloc `PLSQL` précédent en intégrant le curseur dans une boucle FOR.

4.	Modifier la boucle FOR en utilisant un curseur avec paramètre « `numdep` » dont sa valeur est rentrée par l’utilisateur. Cette fois-ci, les départements affichés doivent comptabiliser le même nombre d’employés que le numéro de département passé en paramètre.
