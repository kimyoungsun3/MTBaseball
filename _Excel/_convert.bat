echo off
del/q *.bak
del data\*.*/q
cls
path="D:\devtool\jdk1.8\bin";
set classpath = .;"D:\devtool\jdk1.8\lib\tools.jar";"D:\devtool\jdk1.8\lib\dt.jar";
rem javac ItemTool.java
java ItemTool

