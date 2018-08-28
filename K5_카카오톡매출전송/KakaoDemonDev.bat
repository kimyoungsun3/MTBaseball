cls
echo off
path="C:\Program Files (x86)\Java\jdk1.8.0_25\bin";
set classpath=.;.\javalib\tools.jar;.\javalib\dt.jar;.\gcmlib\gcm.jar;.\gcmlib\gcm-server.jar;.\gcmlib\json-simple-1.1.1.jar;.\jdbc\sqljdbc4.jar

javac KakaoSend.java
java KakaoSend TEST

Pause


