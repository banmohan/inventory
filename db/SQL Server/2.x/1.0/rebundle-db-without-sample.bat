@echo off
bundler\SqlBundler.exe ..\..\..\..\ "db/PostgreSQL/1.x/1.0" false
copy inventory.sql inventory-blank.sql
del inventory.sql
copy inventory-blank.sql ..\..\inventory-blank.sql

pause