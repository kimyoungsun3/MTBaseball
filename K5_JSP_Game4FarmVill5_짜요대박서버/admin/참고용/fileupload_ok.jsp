<!--실제적인 데이터를 전달받기 위한 JSP 파일-->
-www.apach.org-> commons ->io,FileUpload 라이브러리를 다운 받아야 한다.
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.io.IOException"%>
<%@include file="_define.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);		// multipart로 전송되었는가를 체크
	//System.out.println(2);

	if(isMultipart) {
		// multipart로 전송 되었을 경우 업로드 된 파일의 임시 저장 폴더를 설정
		//톰켓의 전체 경로를 가져오고 upload라는 폴더를 만들고 거기다
		//tmp의 폴더의 전송된 파일을 upload 폴더로 카피 한다.
		File temporaryDir = new File("c:\\tmp\\");
		String realDir = config.getServletContext().getRealPath("/etc/_ad/");

		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(1 * 1024 * 1024);								//1메가가 넘지 않으면 메모리에서 바로 사용
		factory.setRepository(temporaryDir);									//1메가 이상이면 temporaryDir 경로 폴더로 이동
			   																	//실제 구현단계 아님 설정단계였음

		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(150 * 1024 * 1024);									//최대 파일 크기(10M)
		List<FileItem> items = upload.parseRequest(request);					//실제 업로드 부분(이부분에서 파일이 생성된다)

		Iterator iter=items.iterator();											//Iterator 사용
		while(iter.hasNext()){
			FileItem fileItem = (FileItem) iter.next();							//파일을 가져온다
			if(fileItem.isFormField()){											//업로드도니 파일이 text형태인지 다른 형태인지 체크
																				//text형태면 if문에 걸림
				out.println("폼 파라미터: "+ fileItem.getFieldName()+"="+fileItem.getString("euc-kr")+"<br>");
			}else{																//파일이면 이부분의 루틴을 탄다
				if(fileItem.getSize() > 0){										//파일이 업로드 되었나 안되었나 체크 size>0이면 업로드 성공
					String fieldName 	= fileItem.getFieldName();
					String fileName 	= fileItem.getName();
					String contentType 	= fileItem.getContentType();
					boolean isInMemory 	= fileItem.isInMemory();
					long sizeInBytes	= fileItem.getSize();
					//out.print("파일 [fieldName] : "+ fieldName +"<br/>");
					out.print("파일 [fileName] : http://"+strIP+":"+strPort+"/Game4FarmVill4/etc/_ad/"+ fileName +"<br><br>");
					//out.print("파일 [contentType] : "+ contentType +"<br/>");
					//out.print("파일 [isInMemory] : "+ isInMemory +"<br/>");
					//out.print("파일 [sizeInBytes] : "+ sizeInBytes +"<br/>");

					try{
						File uploadedFile = new File(realDir,fileName);						//실제 디렉토리에 fileName으로 카피 된다.
						fileItem.write(uploadedFile);
						fileItem.delete();													//카피 완료후 temp폴더의 temp파일을 제거
					}catch(IOException ex) {
						out.println("error:" + ex + "<br>");
					}
				}
			}
		}
	}else{
		out.println("인코딩 타입이 multipart/form-data 가 아님.");
	}
%>
</body>
</html>