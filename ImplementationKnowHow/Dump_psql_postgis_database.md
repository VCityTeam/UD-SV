# Dump a PostgreSQL/PostGIS database

To create/populate a Postgresql/postgis database, follow [this tutorial](https://github.com/VCityTeam/UD-SV/blob/master/ImplementationKnowHow/PostgreSQL_for_cityGML.md).

## Dump from command line

To dump your database from command line, use:

```bash
pg_dump --inserts --column-inserts --dbname <db_name> --port <port> --username <user> --host <host> > output.sql
```

`--insets` and `--column-insets` will allow to execute the SQL dump as raw SQL.

## Dump from pgAdmin4

Right click on your database and select `Backup...`.

![image](https://user-images.githubusercontent.com/32875283/160569690-e33cce04-51ed-467a-bcf2-649711c65c5c.png)

Choose a file name and the `Plain` format.

In `Options`, check `Use Column Inserts` and `Use Insert Commands`.

![image](https://user-images.githubusercontent.com/32875283/160571639-9561fdf9-21cf-4e69-8fe0-65d39d51444f.png)

Then, run the backup.

## Issues on restore

### Schema

Sometimes, after importing your data, SQL can't find the path to find the functions if the schema isn't specified.

To handle this issue:

1. delete the line `SELECT pg_catalog.set_config('search_path', '', false);` from your dump file
2. before importing the data, run `ALTER DATABASE <db_name> SET search_path TO <schema>;`

### PostGIS version

If you try to import the dump with different version of PostgreSQL/PostGIS than the one used to create the dump, you may encounter some issues.

#### __postgis\_raster extension__

`postgis_raster` is an extension used only in Postgis versions >= 3.0. Trying to create this extension with Postgis < 3.0 will result in an error.

The best way to deal with the raster extension is to delete/add the line `CREATE EXTENSION IF NOT EXISTS postgis_raster WITH SCHEMA public;` in your dump, depending on your Postgis version. If you want to add the line, always put it __after__ the creation of `postgis` extension.

#### __Compability with older versions__

If your dump was created with a recent version of Postgis and you try to import it a database with an old version of Postgis, some lines may have to be deleted.

The only way to do it, is to try to import and delete each line causing an error.

