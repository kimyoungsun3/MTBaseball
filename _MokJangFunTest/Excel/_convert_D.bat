echo off
del/q *.bak
del data\*.*/q
cls
path=D:\devtool\jdk1.6\bin;
set classpath = .;D:\devtool\jdk1.6\lib\tools.jar;D:\devtool\jdk1.6\lib\dt.jar;
javac ItemTool.java
java ItemTool


del ..\MokJang_357\Assets\Resources\txt\iteminfo.xml
copy iteminfo.xml		..\MokJang_357\Assets\Resources\txt\iteminfo.xml

del ..\MokJang_357\Assets\Resources\txt\gameinfo.xml
copy gameinfo.xml		..\MokJang_357\Assets\Resources\txt\gameinfo.xml

pause