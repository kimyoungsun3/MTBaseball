echo off
del/q *.bak
del data\*.*/q
cls
path="D:\devtool\jdk1.8\bin";
set classpath = .;"D:\devtool\jdk1.8\lib\tools.jar";"D:\devtool\jdk1.8\lib\dt.jar";
rem javac ItemTool.java
java ItemTool



@echo ======================================
@echo 		Client File Move
@echo ======================================
copy iteminfo.xml		..\K6_NetClient\K6_NetClient\Assets\Resources\txt\iteminfo.xml

copy gameinfo.xml		..\K6_NetClient\K6_NetClient\Assets\Resources\txt\gameinfo.xml

copy tooltip.xml		..\K6_NetClient\K6_NetClient\Assets\Resources\txt\tooltip.xml



@echo ======================================
@echo 		Server File
@echo ======================================
00_02_00Table_iteminfo
del ..\_SQL\00_02_01Table_iteminfo.sql
copy iteminfoQuery.sql				..\_SQL\00_02_01Table_iteminfo.sql

rem del ..\_SQL\00_05Table_gameinfosub.sql
rem copy gameinfoQuerySub.sql			..\_SQL\00_05Table_gameinfosub.sql

rem del ..\_SQL\00_07Table_package.sql
rem copy packageQuery.sql				..\_SQL\00_07Table_package.sql

rem del ..\_SQL\00_09Table_roul(4차버젼).sql
rem copy rouletteQuery.sql				..\_SQL\00_09Table_roul(4차버젼).sql

rem del ..\_SQL\00_12Table_yabau.sql
rem copy yabauQuery.sql					..\_SQL\00_12Table_yabau.sql

pause