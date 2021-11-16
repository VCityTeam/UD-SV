# Setup PostgreSQL/PostGIS on Ubuntu

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
