<%!
	//8859_1	cl	el
	//euc-kr	cl	el
	//KSC5601	cl	el		x
	//utf-8		cl	�ߵ�	
	//						�׳����
	
	//8859_1	cf	el
	//euc-kr	cf	ef
	//KSC5601	cf	ef
	//utf-8		cf	ef
	//						8859_1	
	
	//8859_1	cf	el
	//euc-kr	cf	el
	//KSC5601	cf	el
	//utf-8		cl	�ߵ�
	//						euc-kr
	
	//8859_1	cl	el
	//euc-kr	cl	el
	//KSC5601	cl	el
	//utf-8		cl	�ߵ�
	//						KSC5601
		
	//8859_1	cf  ex
	//euc-kr	cf  ef
	//KSC5601	cf  ef
	//utf-8		cf  ef
	//						utf-8	
	
	public String ko(String en){
		String korean = null;
		try{
			korean = new String(en.getBytes("8859_1"),"KSC5601");
			}catch(Exception e){
				System.out.println("classes => WordReplace error:"+e.toString());
				return korean;
			}
		return korean;
	}
	
	//�ѱ��� �������� �ٲپ��ִ� �κ�
	//encoding method : db data read
	public String en(String ko){
		String english = null;
		try{
			english = new String(ko.getBytes("KSC5601"),"8859_1");
			}catch(Exception e){
				System.out.println("classes => WordReplace error:"+e.toString());
				return english;
			}
		return english;
	}
%>