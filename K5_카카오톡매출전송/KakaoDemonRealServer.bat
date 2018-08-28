cls
echo off

:loop
path="C:\devtool\jdk1.6.0_30\bin";
set classpath=.;.\javalib\tools.jar;.\javalib\dt.jar;.\gcmlib\gcm.jar;.\gcmlib\gcm-server.jar;.\gcmlib\json-simple-1.1.1.jar;.\jdbc\sqljdbc4.jar

"C:\devtool\jdk1.6.0_30\bin\javac" KakaoSend.java
"C:\devtool\jdk1.6.0_30\bin\java" KakaoSend REAL
Goto loop

