# postgresql_-2018-05-02-julien-thomas

## Installation

First you need to have PostgreSQL v11 installed on your debian (up to date in version 9).
To install it quickly, we've created a script.
After cloning the repo and `cd` into the folder, run `./scripts/setup_postgresql.sh`.

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
