echo off
del/q *.bak
del data\*.*/q
cls
path="C:\Program Files (x86)\Java\jdk1.8.0_25\bin";
set classpath = .;"C:\Program Files (x86)\Java\jdk1.8.0_25\lib\tools.jar";"C:\Program Files (x86)\Java\jdk1.8.0_25\lib\dt.jar";
javac ItemTool.java
java ItemTool



@echo ======================================
@echo 		Client File Move
@echo ======================================
copy iteminfo.xml		..\MokJang521_NGUI270_54\MokJang_\Assets\Resources\txt\iteminfo.xml

copy gameinfo.xml		..\MokJang521_NGUI270_54\MokJang_\Assets\Resources\txt\gameinfo.xml

copy tooltip.xml		..\MokJang521_NGUI270_54\MokJang_\Assets\Resources\txt\tooltip.xml

copy openning.xml		..\MokJang521_NGUI270_54\MokJang_\Assets\Resources\txt\openning.xml


@echo ======================================
@echo 		Server File
@echo ======================================

del ..\_SQL\00_03Table_iteminfodata.sql
copy iteminfoQuery.sql				..\_SQL\00_03Table_iteminfodata.sql

del ..\_SQL\00_05Table_gameinfosub.sql
copy gameinfoQuerySub.sql			..\_SQL\00_05Table_gameinfosub.sql

del ..\_SQL\00_07Table_package.sql
copy packageQuery.sql				..\_SQL\00_07Table_package.sql

del ..\_SQL\00_09Table_roul(4차버젼).sql
copy rouletteQuery.sql				..\_SQL\00_09Table_roul(4차버젼).sql

del ..\_SQL\00_12Table_yabau.sql
copy yabauQuery.sql					..\_SQL\00_12Table_yabau.sql

pause