# Setup PostgreSQL/PostGIS on Ubuntu

First, install PostgreSQL and Postgis

```bash
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
