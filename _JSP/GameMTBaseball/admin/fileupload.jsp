<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<!--기본적인 FILE UPLOAD HTML FORM-->
<html>
<head> 
<title>Insert title here</title>
</head>
<body>
<form action="fileupload_ok.jsp" method="post" enctype="multipart/form-data">     
	<!--
	//파일전송일 때는 항상 METHOD는 POST로 하고 ENCTYPE을 항상 주 어야 함<br>
	//TYPE은 FILE로 주어야 함!!<br>
	-->
	파일1 : <input type="file" name="file1"/><br>                                
	파일2: <input type="file" name="file2"/><br>
	파일3: <input type="file" name="file3"/><br>
	<!--
	파라미터1: <input type="text" name="param1"/><br>
	파라미터2: <input type="text" name="param2"/><br>
	파라미터3: <input type="text" name="param3"/><br>
	-->
	<input type="submit" value="전송" />
</form>
</body>
</html>