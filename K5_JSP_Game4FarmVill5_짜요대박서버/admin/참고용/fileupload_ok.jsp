<!--�������� �����͸� ���޹ޱ� ���� JSP ����-->
-www.apach.org-> commons ->io,FileUpload ���̺귯���� �ٿ� �޾ƾ� �Ѵ�.
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
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);		// multipart�� ���۵Ǿ��°��� üũ
	//System.out.println(2);

	if(isMultipart) {
		// multipart�� ���� �Ǿ��� ��� ���ε� �� ������ �ӽ� ���� ������ ����
		//������ ��ü ��θ� �������� upload��� ������ ����� �ű��
		//tmp�� ������ ���۵� ������ upload ������ ī�� �Ѵ�.
		File temporaryDir = new File("c:\\tmp\\");
		String realDir = config.getServletContext().getRealPath("/etc/_ad/");

		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(1 * 1024 * 1024);								//1�ް��� ���� ������ �޸𸮿��� �ٷ� ���
		factory.setRepository(temporaryDir);									//1�ް� �̻��̸� temporaryDir ��� ������ �̵�
			   																	//���� �����ܰ� �ƴ� �����ܰ迴��

		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(150 * 1024 * 1024);									//�ִ� ���� ũ��(10M)
		List<FileItem> items = upload.parseRequest(request);					//���� ���ε� �κ�(�̺κп��� ������ �����ȴ�)

		Iterator iter=items.iterator();											//Iterator ���
		while(iter.hasNext()){
			FileItem fileItem = (FileItem) iter.next();							//������ �����´�
			if(fileItem.isFormField()){											//���ε嵵�� ������ text�������� �ٸ� �������� üũ
																				//text���¸� if���� �ɸ�
				out.println("�� �Ķ����: "+ fileItem.getFieldName()+"="+fileItem.getString("euc-kr")+"<br>");
			}else{																//�����̸� �̺κ��� ��ƾ�� ź��
				if(fileItem.getSize() > 0){										//������ ���ε� �Ǿ��� �ȵǾ��� üũ size>0�̸� ���ε� ����
					String fieldName 	= fileItem.getFieldName();
					String fileName 	= fileItem.getName();
					String contentType 	= fileItem.getContentType();
					boolean isInMemory 	= fileItem.isInMemory();
					long sizeInBytes	= fileItem.getSize();
					//out.print("���� [fieldName] : "+ fieldName +"<br/>");
					out.print("���� [fileName] : http://"+strIP+":"+strPort+"/Game4FarmVill4/etc/_ad/"+ fileName +"<br><br>");
					//out.print("���� [contentType] : "+ contentType +"<br/>");
					//out.print("���� [isInMemory] : "+ isInMemory +"<br/>");
					//out.print("���� [sizeInBytes] : "+ sizeInBytes +"<br/>");

					try{
						File uploadedFile = new File(realDir,fileName);						//���� ���丮�� fileName���� ī�� �ȴ�.
						fileItem.write(uploadedFile);
						fileItem.delete();													//ī�� �Ϸ��� temp������ temp������ ����
					}catch(IOException ex) {
						out.println("error:" + ex + "<br>");
					}
				}
			}
		}
	}else{
		out.println("���ڵ� Ÿ���� multipart/form-data �� �ƴ�.");
	}
%>
</body>
</html>