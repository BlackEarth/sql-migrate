# SQL-migrate

SQL is a fantastic language — one of the most successful programming languages in the world. 

We can use SQL to manage the schema of our database and migrate data. We believe this is better than trying to replace SQL with a bespoke DSL for migrations. 

Managing the database schema of an app in development, however, can be challenging. We need some assistance to manage the complexity: 

* Generate migration files for upward and reverse migrations.
* Track migration dependencies: ensure that migrations are run in the correct order.
* Merge migrations from multiple branches: Ensure that schema changes in two or more different branches do not conflict and are resolved satisfactorily.

Behold SQL-migrate:

* Create migrations 
  * automatic migration names based on either timestamp (default, like Diesel) or sequence number (option, like Django).
  * optional descriptive label added to the migration filenames
  * configurable to use a single folder (like Django) or subfolders (like Diesel)
  * three files per migration: 
    * *NAME*.up.sql (or *NAME*/up.sql) – the SQL script to do the upward migration
    * *NAME*.dn.sql (or *NAME*/dn.sql) – the SQL script to do the downward migration
    * *NAME*.conf.yaml (or *NAME*/conf.yaml) – configuration for the migration. For now, this includes: 
      * the "name" of the migration
      * any "description" that the author has chosen to include
      * a list of the migration's "base" dependencies (so that an DAG of migrations can be modeled to ensure that migrations are applied correctly.)
      * a list of "up" SQL scripts in this migration (default *up.sql)
      * a list of "dn" SQL scripts in this migration (default *dn.sql)
  * support for COPY from an external file for easily loading / updating data.
  * support from COPY from the results of a query to ease bulk data migration.
* Apply migrations:
  * Creates a migrations table to track which migrations were applied and when.
  * Ensures that migrations are applied in dependency-order (which is not necessarily the same as filesystem order).
  * Disallows migrating a database if there are unmerged branches – ensure that branch conflicts have been resolved in a merge before continuing.
  * Each migration is run within its own transaction, treating it as a unified changeset. It's all or nothing with a given migration.
* Merge migrations:
  * When creating a new migration where there are unmerged branches, creates a new migration that has the tip of each branch as a dependency, and prompts the user to review the migrations to ensure that conflicts are resolved.