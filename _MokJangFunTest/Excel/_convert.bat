echo off
del/q *.bak
del data\*.*/q
cls
path=D:\devtool\jdk1.6\bin;
set classpath = .;D:\devtool\jdk1.6\lib\tools.jar;D:\devtool\jdk1.6\lib\dt.jar;
javac ItemTool.java
java ItemTool

del ..\Assets\Resources\txt\iteminfo.xml
copy iteminfo.xml		..\Assets\Resources\txt\iteminfo.xml

del ..\Assets\Resources\txt\gameinfo.xml
copy gameinfo.xml		..\Assets\Resources\txt\gameinfo.xml

pause