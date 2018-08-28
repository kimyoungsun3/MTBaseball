<!--기본적인 FILE UPLOAD HTML FORM-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<form action="fileupload_ok.jsp" method="post" enctype="multipart/form-data">
	<!--
	//파일전송일 때는 항상 METHOD는 POST로 하고 ENCTYPE을 항상 주 어야 함<br>
	//TYPE은 FILE로 주어야 함!!<br>
	-->
	파일1: <input type="file" name="file1"/><br>
	파일2: <input type="file" name="file2"/><br>
	파일3: <input type="file" name="file3"/><br>
	<input type="submit" value="전송" />
</form>
</body>
</html>