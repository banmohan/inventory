@echo off
bundler\SqlBundler.exe ..\..\..\..\ "db/PostgreSQL/1.x/1.0" true
copy inventory.sql inventory-sample.sql
del inventory.sql
copy inventory-sample.sql ..\..\inventory-sample.sql