echo off
del/q *.bak
del data\*.*/q
cls
path=D:\devtool\jdk1.6\bin;
set classpath = .;D:\devtool\jdk1.6\lib\tools.jar;D:\devtool\jdk1.6\lib\dt.jar;
javac ItemTool.java
java ItemTool


del ..\_SQL\00_03Table_iteminfodata.sql
copy iteminfoQuery.sql				..\_SQL\00_03Table_iteminfodata.sql

del ..\_SQL\gameinfoQuerydata.sql
copy gameinfoQuery.sql				..\_SQL\gameinfoQuerydata.sql

del ..\_SQL\00_05Table_gameinfosub.sql
copy gameinfoQuerySub.sql			..\_SQL\00_05Table_gameinfosub.sql

del ..\_SQL\00_07Table_package.sql
copy packageQuery.sql				..\_SQL\00_07Table_package.sql

del ..\_SQL\00_09Table_roul(4차버젼).sql
copy rouletteQuery.sql				..\_SQL\00_09Table_roul(4차버젼).sql

del ..\_SQL\00_12Table_yabau.sql
copy yabauQuery.sql					..\_SQL\00_12Table_yabau.sql

del ..\MokJang_2014-06-18(1)\Assets\Resources\txt\iteminfo.xml
copy iteminfo.xml		..\MokJang_2014-06-18(1)\Assets\Resources\txt\iteminfo.xml

del ..\MokJang_2014-06-18(1)\Assets\Resources\txt\gameinfo.xml
copy gameinfo.xml		..\MokJang_2014-06-18(1)\Assets\Resources\txt\gameinfo.xml

del ..\MokJang_2014-06-18(1)\Assets\Resources\txt\tooltip.xml
copy tooltip.xml		..\MokJang_2014-06-18(1)\Assets\Resources\txt\tooltip.xml

pause