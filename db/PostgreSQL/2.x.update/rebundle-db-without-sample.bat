@echo off
bundler\SqlBundler.exe ..\..\..\ "db/PostgreSQL/2.x.update" false
copy inventory-1.1.update.sql ..\inventory-1.1.update.sql