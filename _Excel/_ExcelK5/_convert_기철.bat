echo off
del/q *.bak
del data\*.*/q
cls
path="C:\Program Files (x86)\Java\jdk1.8.0_51\bin";
set classpath = .;D:\devtool\jdk1.6\lib\tools.jar;"C:\Program Files (x86)\Java\jdk1.8.0_51\lib\dt.jar";
javac ItemTool.java
java ItemTool

rem !!!!!!!!!!!!!!!!!!!!!!
rem !! GG

del ..\MokJang_\Assets\Resources\txt\iteminfo.xml
copy iteminfo.xml		..\MokJang_\Assets\Resources\txt\iteminfo.xml

del ..\MokJang_\Assets\Resources\txt\gameinfo.xml
copy gameinfo.xml		..\MokJang_\Assets\Resources\txt\gameinfo.xml

del ..\MokJang_\Assets\Resources\txt\tooltip.xml
copy tooltip.xml		..\MokJang_\Assets\Resources\txt\tooltip.xml

del ..\MokJang_\Assets\Resources\txt\openning.xml
copy openning.xml		..\MokJang_\Assets\Resources\txt\openning.xml


pause