## Environment variables to set
```
export POSTGRES_USER=citydb_user
export POSTGRES_PASSWORD= <...>
export POSTGRES_DB='citydb_v3'
```

## Use ansible for the rest
```
sudo apt-get install postgresql-10-postgis-2.4
sudo useradd --password ${POSTGRES_PASSWORD} ${POSTGRES_USER}
sudo su postgres
(postgres)$ createuser --password citydb_user
            ...
(postgres)$ createdb -O citydb_user citydb_v3 
ifconfig -a
```
Edit `/etc/postgresql/10/main/pg_hba.conf` and add the line
   ???
Edit `/etc/postgresql/10/main/postgresql.conf`

```
(root)$ service postgresql restart
(root)$ su - postgres
(postgres)$ psql -d citydb_v3 -U postgres -c 'alter role citydb_user with superuser;'
(root)$ su - citydb_user
(citydb_user)$ psql -d citydb_v3 -c 'create extension postgis;'
```

## Download JRE from https://www.java.com/en/download/manual.jsp
```
(root)$ cd tmp
(root)$ tar zxvf jre-8u211-linux-x64.tar.gz 
(root)$ mkdir /usr/lib/jvm
(root)$ mv jre1.8.0_131 /usr/lib/jvm/oracle_jre1.8.0_211/
(root)$ update-alternatives --install /usr/bin/java java /usr/lib/jvm/oracle_jre1.8.0_211/bin/java 2000
(root)$ rm -f jre-8u211-linux-x64.tar.gz 
```
```
(citydb_user)$ cd && mkdir local
(citydb_user)$ cd /tmp
(citydb_user)$ wget http://www.3dcitydb.org/3dcitydb/fileadmin/downloaddata/3DCityDB-Importer-Exporter-3.3.1-Setup.jar
(citydb_user)$ java -jar 3DCityDB-Importer-Exporter-3.3.1-Setup.jar
  ... point the installer to install in e.g. ~/local/3DCityDB-Importer-Exporter
(citydb_user)$ rm -f 3DCityDB-Importer-Exporter-3.3.1-Setup.jar
```

#######
changer le script suivant our merge bati et remarquable
 	computeLyonCityEvolution.sh
utiliser le script createdabase pour les trois splits
pousser le tout a la main dans la base 

wget https://github.com/MEPP-team/RICT.git/ShellScripts/computeLyonCityEvolution/computeLyonCityEvolution.sh
