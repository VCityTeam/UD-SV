# Setup PostgreSQL/PostGIS on Ubuntu

First, install PostgreSQL and Postgis

```bash
$ sudo apt-get update
$ sudo apt-get install postgresql-10 postgresql-10-postgis-2.4
$ sudo service postgresql restart
```

If the package `postgresql-10` couldn't be located, try:

```bash
$ sudo apt-get install wget ca-certificates
$ wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
$ sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
$ sudo apt-get update
$ sudo apt-get install postgresql-10 postgresql-10-postgis-2.4
$ sudo service postgresql restart
```

Setup a password for `postgres` user

```bash
$ sudo su - postgres
$ psql
postgres=# \password postgres
Enter new password: <new-password>
postgres=# \q
```

Locate and edit 'pg_hba.conf'

```bash
$ sudo vim /etc/postgresql/10/main/pg_hba.conf
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
