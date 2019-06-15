# Sauvegarde et restauration avec PostgreSQL

## Introduction

PostgreSQL propose des outils très complets pour effectuer des sauvegardes de votre base de donnée.
Pour commencer il est possible de faire 2 types de sauvegardes :

* Logique:
    * Sauvegarde à chaud (pas besoin d'éteindre le serveur)
    * Large choix d'options pour sélectionner les données
    * Large choix d'export

<br/>

* Physique
    * Sauvegarde à froid (obligé d'éteindre le serveur)
    * Sauvegarde les PGDATA
    * Savegarde des tablespaces
    * Journaux de transactions (fichiers WAL)
    * Fichiers de configuration

## Sauvegarde à l'aide des commandes

### pg_dump

`pg_dump` est utilisé pour faire un backup d'une seule base de données spécifique à la fois.
La syntaxe est similaire à psql pour l'authentification et tire partie du fichier .pgpass pour ne pas avoir à taper de password.

[Documentation officiel](https://www.postgresql.org/docs/current/app-pgdump.html)


#### Les options principales

`--schema-only` (`-c`) : ne sauvegarde que les schéma des tables.

`--table=[table]` (`-t [table]`) : ne sauvegarde que la table.

`--data-only` (`-a`) : ne sauvegarde que les données des tables.

`--exclude-table=[table]` (`-T [table]`) : exclu une table de la sauvegarde.

`--clean` (`-c`) : ajoute des commandes de suppressions du contenu avant celle d'insertion. Il est recommané d'y ajouter `--if-exists` pour éviter le erreurs. Cela peux être utile lors de la restauration de la sauvegarde.

`--file=[THE_FILE]` (`-f [THE_FILE]`) : permet de spécifier le fichier d'export.

`--format=[THE_FORMAT]`(`-F [THE_FORMAT]`) : permet de spécifier le format
    `plain` (`p`) : (choix par défaut) sauvegarde au format de requêtes SQL standard.
    `custom` (`c`) : fichier compressé idéal pour utilisez `pg_restore`.
    `directory` (`d`) : la sauvegade sera sous forme de dossiers. Cela créera un répertoire avec un fichier pour chaque table et blob à vider, ainsi qu'un fichier table des matières décrivant les objets vidés dans un format lisible par une machine que pg_restore peut lire. Fonctionne aussi avec `pg_restore`.
    `tar`(`t`) : archive au format `.tar`. Elle est organisé de la même manière que la sauvegarde sous forme de dossier. Néanmoins l'ordre relatif des éléments de données de la table ne peut pas être modifié pendant la restauration.

`--jobs=[njobs]` (`-j [njobs]`) : permet de lancer la sauvegarde sur plusieurs thread. ⚠ Ne fonctionne qu'avec le format de répertoires ⚠ Il peut être utile de monter la sauvegarde sur `njobs` équivalent aux nombre de tâbles disponibles dans la base de donnée.

`--compress=[0 à 9]` (`-Z [0 à 9]`) : permet de compresser la sauvegarde avec un niveau de 0 à 9.

`--dbname=[dbname]` (`-d [dbname]`) : permet de spécifier la base de donnée à sauvegarder.

`--host=[host]` (`-h [host]`) : permet de spécifier l'adresse de l'hôte.

`--port=[port]` (`-p [port]`) : permet de spécifier le port de connexion.

`--username=[username]` (`-U [username]`) : permet de spécifier l'utilisateur sur lequel se connecter.

`--password` (`-W`) : permet de spécifier le mot de passe de l'utilisateur.

`--role=[rolename]` : Spécifie un nom de rôle à utiliser pour créer le dump.


#### exemple : 

```bash
pg_dump --username=[THE_USER] [THE_TABLE] -f [PATH_TO_SAVE_FILE]
```

### pg_dumpall

La commande `pg_dumpall` permet de sauvegarder toutes les bases de données du serveur, ainsi que les "globals" (utilisateurs, configurations etc.). Elle dispose de la plupart des options de `pg_dump` (voir ci-dessus). PAr contre, contrairement à `pg_dump`, on est limité au fichiers SQL, on préferera donc utiliser `pg_dump` pour les bases de données (plus flexible) et utiliser `pg_dumpall` uniquement pour les globals

[Documentation officiel](https://www.postgresql.org/docs/current/app-pg-dumpall.html)

#### Les options principales

`--globals-only` (`-g`) : ne sauvegarde que les tables globales.

`--roles-only` (`-r`) : ne sauvgarde que les rôles.

`--tablespaces-only` (`-t`) : ne sauvegarde que les tablespaces.


#### exemple : 

```bash
pg_dumpall --username=[THE_USER] [THE_TABLE] -f [PATH_TO_SAVE_FILE]
```


## Restauration à l'aide des commandes

`pg_restore` est utilisé pour faire une restoration des backups. De la même manière que `pg_dump` il est possible de filtrer ce que l'on veux restorer.

[Documentation officiel](https://www.postgresql.org/docs/current/app-pgrestore.html)

#### Les options principales

`--schema-only` (`-c`) : ne sauvegarde que les schéma des tables.

`--table=[table]` (`-t [table]`) : ne sauvegarde que la table.

`--data-only` (`-a`) : ne sauvegarde que les données des tables.

`--exclude-table=[table]` (`-T [table]`) : exclu une table de la sauvegarde.

`--clean` (`-c`) : ajoute des commandes de suppressions du contenu avant celle d'insertion. Il est recommané d'y ajouter `--if-exists` pour éviter le erreurs. Cela peux être utile lors de la restauration de la sauvegarde.

`--file=[THE_FILE]` (`-f [THE_FILE]`) : permet de spécifier le fichier d'export.

`--format=[THE_FORMAT]`(`-F [THE_FORMAT]`) : permet de spécifier le format
    `plain` (`p`) : (choix par défaut) sauvegarde au format de requêtes SQL standard.
    `custom` (`c`) : fichier compressé idéal pour utilisez `pg_restore`.
    `directory` (`d`) : la sauvegade sera sous forme de dossiers. Cela créera un répertoire avec un fichier pour chaque table et blob à vider, ainsi qu'un fichier table des matières décrivant les objets vidés dans un format lisible par une machine que pg_restore peut lire. Fonctionne aussi avec `pg_restore`.
    `tar`(`t`) : archive au format `.tar`. Elle est organisé de la même manière que la sauvegarde sous forme de dossier. Néanmoins l'ordre relatif des éléments de données de la table ne peut pas être modifié pendant la restauration.

`--jobs=[njobs]` (`-j [njobs]`) : permet de lancer la sauvegarde sur plusieurs thread. ⚠ Ne fonctionne qu'avec le format de répertoires ⚠ Il peut être utile de monter la sauvegarde sur `njobs` équivalent aux nombre de tâbles disponibles dans la base de donnée.

`--compress=[0 à 9]` (`-Z [0 à 9]`) : permet de compresser la sauvegarde avec un niveau de 0 à 9.

`--dbname=[dbname]` (`-d [dbname]`) : permet de spécifier la base de donnée à sauvegarder.

`--host=[host]` (`-h [host]`) : permet de spécifier l'adresse de l'hôte.

`--port=[port]` (`-p [port]`) : permet de spécifier le port de connexion.

`--username=[username]` (`-U [username]`) : permet de spécifier l'utilisateur sur lequel se connecter.

`--password` (`-W`) : permet de spécifier le mot de passe de l'utilisateur.

`--role=[rolename]` : Spécifie un nom de rôle à utiliser pour créer le dump.


#### exemple : 

```bash
pg_restore --username=[THE_USER] [THE_TABLE] -f [PATH_TO_SAVE_FILE]
```

## Pour aller plus loin

Plusieurs outils pour faciliter les sauvegardes automatiues sont disponible comme [pgbarman](https://www.pgbarman.org/), [wal-e](https://github.com/wal-e/wal-e) ou [pgbackrest](https://pgbackrest.org/).
Une documentation complète en français est disponible [ici](http://rbdd.cnrs.fr/IMG/pdf/i3_sauvegardes_avances.pdf?166/0a484ec696fe097bd5176b37bb8aa8fa32832ea8)