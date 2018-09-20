echo off
del/q *.bak
cls
echo off
path="D:\devtool\jdk1.8\bin";
set classpath=.;.\javalib\tools.jar;.\javalib\dt.jar;.\gcmlib\gcm.jar;.\gcmlib\gcm-server.jar;.\gcmlib\json-simple-1.1.1.jar;.\jdbc\sqljdbc4.jar


javac PowerDemon.java
java PowerDemon TEST


rem Pause


