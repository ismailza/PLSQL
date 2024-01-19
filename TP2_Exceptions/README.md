# TP EXCEPTIONS

1. Ecrivez un bloc `PL/SQL` pour :

    a. Entrer un `numéro` d’employé;
    b. Afficher son `numéro`, `prénom`, `nom`, `salaire` et `nom du département` où il travaille. Si cet employé n’existe pas, afficher un message d’erreur.

    **Conseil**: Utiliser l’exception `NO_DATA_FOUND`.

2. Créez une `exception` personnalisée `ID_empty` pour le bloc plsql que vous avez créée. Lever l'exception si le numéro d’employé saisi est nul.

    **Conseil** : à rappeler que les variables de substitution sont modifiées avant l’exécution du bloc plsql. Ainsi, il faut récupérer  la variable de substitution dans une variable chaine de caractère « emp_num » à tester après si elle est vide: (IF emp_num IS NULL).

3. Gérer l’exception relative à la `contrainte d’intégrité` référentielle qui interdit la suppression de tout département qui contient des employés.

    **Conseil**: Utiliser `PRAGMA EXCEPTION_INIT` pour attribuer un nom à votre exception qui porte le numéro `ORA- 2292`
