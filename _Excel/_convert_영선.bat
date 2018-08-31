echo off
del/q *.bak
del data\*.*/q
cls
path="D:\devtool\jdk1.8\bin";
set classpath = .;"D:\devtool\jdk1.8\lib\tools.jar";"D:\devtool\jdk1.8\lib\dt.jar";
javac ItemTool.java
java ItemTool



@echo ======================================
@echo 		Client File Move
@echo ======================================
copy iteminfo.xml		..\MokJang521_NGUI270_54\MokJang_\Assets\Resources\txt\iteminfo.xml

copy gameinfo.xml		..\MokJang521_NGUI270_54\MokJang_\Assets\Resources\txt\gameinfo.xml

copy tooltip.xml		..\MokJang521_NGUI270_54\MokJang_\Assets\Resources\txt\tooltip.xml



@echo ======================================
@echo 		Server File
@echo ======================================

rem del ..\_SQL\00_03Table_iteminfodata.sql
rem copy iteminfoQuery.sql				..\_SQL\00_03Table_iteminfodata.sql

rem del ..\_SQL\00_05Table_gameinfosub.sql
rem copy gameinfoQuerySub.sql			..\_SQL\00_05Table_gameinfosub.sql

rem del ..\_SQL\00_07Table_package.sql
rem copy packageQuery.sql				..\_SQL\00_07Table_package.sql

rem del ..\_SQL\00_09Table_roul(4차버젼).sql
rem copy rouletteQuery.sql				..\_SQL\00_09Table_roul(4차버젼).sql

rem del ..\_SQL\00_12Table_yabau.sql
rem copy yabauQuery.sql					..\_SQL\00_12Table_yabau.sql

pause