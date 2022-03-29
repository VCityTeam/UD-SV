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

## Issues

### Schema

### PostGIS version
