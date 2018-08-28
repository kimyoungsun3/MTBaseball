cls
echo off
path="D:\Program Files\Java\jdk1.6.0_30\bin";
set classpath=.;.\javalib\tools.jar;.\javalib\dt.jar;.\gcmlib\gcm.jar;.\gcmlib\gcm-server.jar;.\gcmlib\json-simple-1.1.1.jar;.\jdbc\sqljdbc4.jar

"D:\Program Files\Java\jdk1.6.0_30\bin\javac" KakaoSend.java
"D:\Program Files\Java\jdk1.6.0_30\bin\java" KakaoSend TEST







