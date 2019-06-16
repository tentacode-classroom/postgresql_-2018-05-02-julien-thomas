# postgresql_-2018-05-02-julien-thomas

*Note: if one of the script fails to call an SQL file, it is suggested that you `cd` into the scripts directory.*

## Installation

First you need to have PostgreSQL v11 installed on your debian (up to date in version 9).
To install it quickly, we've created a script.
After cloning the repo and `cd` into the folder, run `./scripts/setup_postgresql`.

It should ask you the password for `sudo` then it should display something like:
![screenshot of setup result](https://raw.githubusercontent.com/tentacode-classroom/postgresql_-2018-05-02-julien-thomas/master/assets/screnshot_setup_result.png)

If not, you have a problem with the installer. Please check the wiki, issues or the officiel documentation.

Go [here](https://www.postgresql.org/download/) for more informations and other OS.

### `Setting locale failed` error

![picture of the error](https://raw.githubusercontent.com/tentacode-classroom/postgresql_-2018-05-02-julien-thomas/master/assets/screenshot_lang_error.png)

If you have an error as in the above picture when you run the installer, you can try `dpkg-reconfigure locales` to setup your language a second time.

If it doesn't change anything, you will need to add variables in your `~/.bashrc` :
```bash
#Locales
export LANGUAGE=[YOUR LANG SETUP HERE]
export LANG=[YOUR LANG SETUP HERE]
export LC_ALL=[YOUR LANG SETUP HERE]
```

After saving you can restart or use `source ~/.bashrc` to apply the changes.
Finaly, you won't see this annoying error anymore 👌

## Download data

To download data you just need to run the script `import_github`. Use `./scripts/import_github` to do this.
It'll automaticly dowwnload multiple data, extract it and concatenated in one dated json file.

## Create database 

To initialize the database you just need to run `./scripts/create_event_database`

## Alter configuration

If you want to change the port and the memory, we have created a script to optimize it. It's pre-configure. You can change settings by editing global variables of the sql script `./scripts/sql/update_conf.sql`.
You just need to run it `./scripts/update_configuration`.

## Create users

To work, the project need to have 2 users (super_admin & github). To setup users just run `./scripts/create_users`
You can change the passwords by editing the sql script `./scripts/sql/create_user_admin.sql`, `./scripts/sql/create_user_github.sql` and `./scripts/create_users`

After that, you need to edit the `pg_hba` file to be able to connect on accounts.
Edit `/etc/postgresql/11/main/pg_hba.conf` as `./etc/pg_hba.conf`.

[Documentation](https://www.postgresql.org/docs/9.1/auth-pg-hba-conf.html)

## Populate raw with json

To populate the database with imports downloaded before, you just need to launch `./scripts/populate_raw_events` script.

## Install pgAdmin

1. Edit `/etc/postgresql/11/main/pg_hba.conf` as `./etc/pg_hba.conf`.
2. Run `./scripts/pg_admin_install`
3. Download and setup your client with [Official documentation](https://www.pgadmin.org/download/) or use [this](https://askubuntu.com/questions/831262/how-to-install-pgadmin-4-in-desktop-mode-on-ubuntu) thread to install it in your debian distribution.

## Populate raw

To populate the database with imports downloaded before, you just need to launch `./scripts/populate_events` script.

## Create views

To create view you just need to launch `./scripts/create_views` script.

## Backups

To backup the data of the database `github_events` with it's roles, you just need to launch `./scripts/backup` script.

For more informations about backup, you can read our short documentation [here](https://github.com/tentacode-classroom/postgresql_-2018-05-02-julien-thomas/blob/master/doc/backup_restore.md)
