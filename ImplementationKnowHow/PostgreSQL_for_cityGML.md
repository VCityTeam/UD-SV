# PostgreSQL for cityGML

This note explains how to setup PostgreSQL to be able to create cityGML databases, for example in order to run [py3dtilers](https://github.com/VCityTeam/py3dtilers) tests.

## Ubuntu

First, install PostgreSQL and Postgis

```bash
$ sudo apt-get update
$ sudo apt-get install postgresql postgresql-12-postgis-3 postgresql-contrib
```

Setup a password for `postgres` user

```bash
$ sudo -u postgres psql
postgres=# \password postgres
Enter new password: <new-password>
postgres=# \q
```


Locate and edit 'pg_hba.conf'

```bash
$ sudo apt install mlocate
$ locate pg_hba.conf
/etc/postgresql/12/main/pg_hba.conf
$ sudo vim /etc/postgresql/12/main/pg_hba.conf
```

The line:

```bash
local   all             postgres                                peer
```

Should be:

```bash
local   all             postgres                                md5
```

Restart PostgreSQL service

```bash
$ sudo service postgresql restart
```

You can now use the `psql -U postgres <...>` commands.

## Windows

Download and install a [PostgreSQL version](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads).

Run the installer and install PostgreSQL. When PostgreSQL installation is over, execute Stack Builder and install Postgis.

![image](https://user-images.githubusercontent.com/32875283/135090973-3954ca72-da20-4711-8242-262039bc9373.png)

If your PostgreSQL password is not set, launch pgAdmin to set your `postgres` password.

To be able to use the `psql` command in Windows shell, add the `bin` folder path (for example _C:\Program Files\PostgreSQL\10\bin_) in PATH environmental variable.

You can now use the `psql -U postgres <...>` commands.
