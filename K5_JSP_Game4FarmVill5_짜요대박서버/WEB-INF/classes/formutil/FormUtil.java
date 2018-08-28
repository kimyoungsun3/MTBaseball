package formutil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.io.*;

public class FormUtil  {	
		
	public FormUtil(){}
	
	public static String cutString(String longText,int size){
       		if( longText.length() > size ){
               		longText = longText.substring(0, size)+"...";
       		}
       		return longText ;
	}
	
	
	
  	public static void setCookie(HttpServletResponse res, String name, String value)
       	throws ServletException, IOException
	{ 
		Cookie	cookie_value;
        cookie_value = new Cookie (name, value); 

		res.addCookie (cookie_value); 
    } 

  	public static String getCookie(HttpServletRequest req, String cookie_name)
        throws ServletException
	{ 
		Cookie	cookies [] = req.getCookies () ;
		String  cookie_value="";

		try
		{
			if (cookies == null) return "";

			for (int i = 0; i < cookies.length; i++) {
				if ( cookies[i].getName().equals(cookie_name) ) {					
					cookie_value =  cookies[i].getValue();
					break;
				}
			}
			
		} catch(java.lang.Exception ex) {
			ex.printStackTrace();	 
		}
		return cookie_value;
  	}	
  	
    public static String toKorean(String s)
    {
        try
        {
            if(s != null)
                return new String(s.getBytes("KSC5601"),"8859_1");
            else
                return s;
        }
        catch(UnsupportedEncodingException _ex)
        {
            return "Encoding Error";
        }
    }
    
    /*
	public static String getTitle (String cmd) {
    	if (cmd.equals("bbs01"))
        	return "AO￠®E¡EcE¡E￠cEc¡E￠cE￠®Ec￠®E¡Ec￠®E ui¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E Ioo￠®E¡EcE¡E￠cEcE￠®E¡EcE¡E￠cEc¡E￠c￠®¡¿I￠®E¡Ec￠®¡×I¡E￠cE￠®EcE￠®E¡EcEc¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E ￠®E¡EcE¡E￠cEc ¡E￠cE￠®EcE￠®E¡EcEc¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E uC￠®E¡EcE¡E￠cEcE￠®E¡EcE¡E￠cEc¡E￠c￠®¡¿I￠®E¡Ec￠®¡×I￠®E¡EcE¡E￠cEcEc￠®E¡EcE¡E￠cEcE￠®E¡EcE¡E￠cEc¡E￠c￠®¡¿I￠®E¡Ec￠®¡×I| A¡E￠cE￠®EcE￠®E¡EcEcI￠®E¡EcE¡E￠cEc¡E￠cE￠®Ec￠®E¡Ec￠®E u￠®E¡EcE¡E￠cEc¡E￠cE￠®Ec￠®E¡Ec￠®E ¡E￠cE￠®EcE￠®E¡EcEc￠®E¡EcE¡E￠cEc¡E￠cE￠®Ec￠®E¡Ec￠®E u¡E￠cE￠®EcE￠®E¡EcEc¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E I ";
		else if (cmd.equals("bbs02"))
		    return "¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E I￠®E¡Ec¡E￠c￠®￠ I￠®E¡Ec¡E￠c￠®￠ ￠®E¡EcI￠®E¡EcE¡E￠cEc¡E￠cE￠®Ec￠®E¡Ec￠®E ￠®E¡EcE¡E￠cEcIAC ￠®E¡EcE¡E￠cEc¡E￠cE￠®Ec￠®E¡Ec￠®E oA￠®E¡EcE¡E￠cEcE eA¡E￠cE￠®EcE￠®E¡EcEci￠®E¡EcE¡E￠cEcIia AI￠®E¡EcE¡E￠cEc¡E￠cE￠®Ec￠®E¡Ec￠®E u¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E I￠®E¡EcE¡E￠cEc¡E￠c￠®¡¿I￠®E¡Ec￠®¡×I¡E￠cE￠®EcE￠®E¡EcEc¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E ua ";
		else if (cmd.equals("bbs03"))
		    return "￠®E¡EcE¡E￠cEc¡E￠cE￠®Ec￠®E¡Ec￠®E oA￠®E¡EcE¡E￠cEcE eA¡E￠cE￠®EcE￠®E¡EcEci￠®E¡EcE¡E￠cEcIia ¡E￠cE￠®EcE￠®E¡EcEcic¡E￠cE￠®EcE￠®E¡EcEc¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E ￠®E¡EcE¡E￠cEci.. ¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E I￠®E¡Ec¡E￠c￠®￠ I￠®E¡Ec¡E￠c￠®￠ ￠®E¡EcI￠®E¡EcE¡E￠cEc¡E￠cE￠®Ec￠®E¡Ec￠®E ￠®E¡EcE¡E￠cEcI￠®E¡EcE¡E￠cEcE￠®E¡EcE¡E￠cEcIA AI¡E￠cE￠®EcE￠®E¡EcEc¡E￠cE￠®EcE￠®E¡EcE￠®E¡EcI￠®E¡EcE¡E￠cEcE￠®E¡EcE¡E￠cEc¡E￠c￠®¡¿I￠®E¡Ec￠®¡×I¡E￠cE￠®EcE￠®E¡EcEc¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E ￠®E¡EcE¡E￠cEcO C￠®E¡EcE¡E￠cEc¡E￠cE￠®Ec￠®E¡Ec￠®E ¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E ¡E￠cE￠®EcI¡E￠cE￠®EcE￠®E¡EcEc¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E ￠®E¡EcE¡E￠cEcaC¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E I￠®E¡EcE¡E￠cEc¡E￠c￠®¡¿I￠®E¡Ec￠®¡×I￠®E¡EcE¡E￠cEcE￠®E¡EcE¡E￠cEcIU. ";
		else if (cmd.equals("bbs04"))
		    return "¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E I￠®E¡Ec¡E￠c￠®￠ I￠®E¡Ec¡E￠c￠®￠ ￠®E¡EcI¡E￠cE￠®EcE￠®E¡EcEci¡E￠cE￠®EcE￠®E¡EcEc¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E ￠®E¡EcE¡E￠cEc￠®E¡EcE¡E￠cEcE¡E￠cE￠®EcEc ￠®E¡EcE¡E￠cEcE￠®E¡EcE¡E￠cEc¡E￠c￠®¡¿I￠®E¡Ec￠®¡×I￠®E¡EcE¡E￠cEcE￠®E¡EcE¡E￠cEc¡E￠c￠®¡¿I￠®E¡Ec￠®¡×I￠®E¡EcE¡E￠cEcIia￠®E¡EcE¡E￠cEcE￠®E¡EcE¡E￠cEcIA ￠®E¡EcE¡E￠cEc¡E￠cE￠®Ec￠®E¡Ec￠®E oA￠®E¡EcE¡E￠cEcE eA¡E￠cE￠®EcE￠®E¡EcEci￠®E¡EcE¡E￠cEcIia ￠®E¡EcE¡E￠cEc¡E￠cE￠®Ec￠®E¡Ec￠®E u￠®E¡EcE¡E￠cEc¡E￠cE￠®Ec￠®E¡Ec￠®E u¡E￠cE￠®EcE￠®E¡EcEcio ";		
		else if (cmd.equals("bbs05"))
		    return "CN¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E Io¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E I¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E ¡E￠cE￠®EcI ¡E￠cE￠®EcE￠®E¡EcEc¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E ￠®E¡EcE¡E￠cEc￠®E¡EcE¡E￠cEcE¡E￠cE￠®EcEc ￠®E¡EcE¡E￠cEc¡E￠cE￠®Ec￠®E¡Ec￠®E ￠®E¡EcE¡E￠cEc¡E￠c￠®¡¿I￠®E¡Ec￠®¡×IA ! A￠®E¡EcE¡E￠cEcE¡E￠cE￠®EcE¡E￠cE￠®EcI￠®E¡EcE¡E￠cEcE￠®E¡EcE¡E￠cEc¡E￠c￠®¡¿I￠®E¡Ec￠®¡×I¡E￠cE￠®EcE￠®E¡EcEci AA￠®E¡EcE¡E￠cEcE￠®E¡EcE¡E￠cEcIo￠®E¡EcE¡E￠cEcEOo ";	
		else if (cmd.equals("bbs06"))
		    return "￠®E¡EcE¡E￠cEcE￠®E¡EcE¡E￠cEcIU￠®E¡EcE¡E￠cEc¡E￠cE￠®Ec￠®E¡Ec￠®E oA ¡E￠cE￠®EcE￠®E¡EcEc¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E ￠®E¡EcE¡E￠cEc￠®E¡EcE¡E￠cEcE¡E￠cE￠®EcEcAo￠®E¡EcE¡E￠cEcE￠®E¡EcE¡E￠cEc¡E￠c￠®¡¿I￠®E¡Ec￠®¡×I￠®E¡EcE¡E￠cEcEO. EAE￠®E¡EcE¡E￠cEcE￠®E¡EcE¡E￠cEc¡E￠c￠®¡¿I￠®E¡Ec￠®¡×ICI¡E￠cE￠®EcE￠®E¡EcEc¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E ￠®E¡EcE¡E￠cEcO ￠®E¡EcE¡E￠cEcIiA ";			    		        		    
		else
		    return "AO￠®E¡EcE¡E￠cEc¡E￠cE￠®Ec￠®E¡Ec￠®E ui¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E Ioo￠®E¡EcE¡E￠cEcE￠®E¡EcE¡E￠cEc¡E￠c￠®¡¿I￠®E¡Ec￠®¡×I¡E￠cE￠®EcE￠®E¡EcEc¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E ￠®E¡EcE¡E￠cEc ¡E￠cE￠®EcE￠®E¡EcEc¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E uC￠®E¡EcE¡E￠cEcE￠®E¡EcE¡E￠cEc¡E￠c￠®¡¿I￠®E¡Ec￠®¡×I￠®E¡EcE¡E￠cEcEc￠®E¡EcE¡E￠cEcE￠®E¡EcE¡E￠cEc¡E￠c￠®¡¿I￠®E¡Ec￠®¡×I| A¡E￠cE￠®EcE￠®E¡EcEcI￠®E¡EcE¡E￠cEc¡E￠cE￠®Ec￠®E¡Ec￠®E u￠®E¡EcE¡E￠cEc¡E￠cE￠®Ec￠®E¡Ec￠®E ¡E￠cE￠®EcE￠®E¡EcEc￠®E¡EcE¡E￠cEc¡E￠cE￠®Ec￠®E¡Ec￠®E u¡E￠cE￠®EcE￠®E¡EcEc¡E￠cE￠®Ec￠®E¡Ec¡E￠c¡E I ";
	}
	/**/

// ------------------------
//	jini (2001/12/10)
//	KTF 폰번호 추출시 사용
// ------------------------
	public static String getHeader(HttpServletRequest request, String param, String initStr) {
  		if (request.getHeader(param) == null)
	    		return initStr;
  		else
	    		return request.getHeader(param).trim();
	}
	
			
	public static String getParamStr (HttpServletRequest request, String param, String initStr) {
  		if (request.getParameter(param) == null){
	    	return initStr;
  		}else{
	    	//return toKorean(request.getParameter(param));
	    	return request.getParameter(param);
  		}
	}
	
	/*
	//test내용
	public static String getParamStr2 (HttpServletRequest request, String param, String initStr) {
  		if (request.getParameter(param) == null)
	    	return initStr;
  		else
	    	return request.getParameter(param);
	}
	/**/
		
	public static int getParamInt (HttpServletRequest request, String param, int initInt) {
  		if (request.getParameter(param) == null)
	    	return initInt;
  		else if (request.getParameter(param).equals(""))
	    	return initInt;
  		else
	    	return Integer.parseInt(request.getParameter(param));
	}	
	
	public static String getParamValues (HttpServletRequest request, String param) {
  		String values[] = request.getParameterValues(param);
  		if (values == null) return "";
  		int count = values.length;
  		switch (count) {
		    case 1:
				return values[0];
	    	default:
				StringBuffer result = new StringBuffer(values[0]);
        		int stop = count - 1;
				if (stop > 1) result.append(", ");
				for (int i = 1; i < stop; ++i) {
	  				result.append(values[i]);
	  				result.append(", ");
				}
				result.append(" and ");
				result.append(values[stop]);
				return result.toString();
  		}
	}
	
	public static boolean requestContains (HttpServletRequest request,
					String param, String test) {
  		String rp[] = request.getParameterValues(param);
  		if (rp == null)
		    return false;
	  	for (int i=0; i < rp.length; i++)
	    	if (test.equals(rp[i]))
      			return true;
  		return false;
	}
	
	public static String isChecked (HttpServletRequest request,
			 	String param, String test) {
  		if (requestContains(request, param, test))
		    return "checked";
	  	else
	    	return ""; 
	}
	
	public static String isSelected (HttpServletRequest request,
			  	String param, String test) {
  		if (requestContains(request, param, test))
		    return "selected";
	  	else
	    	return "";
	}

	public static String formatMoney(int money2) {
		String finalStr = "";
		String numvar01 = String.valueOf(money2);
		int maxit = numvar01.length();
		if (maxit <= 3) {
			finalStr = numvar01;
		}else{
			int Xrec = (maxit-1), Crec = 1;
			while (Xrec >= 0) {
				finalStr = numvar01.charAt(Xrec)+finalStr;
				if (((Crec%3)==0)&&(Xrec!=0)){
					finalStr = ","+finalStr;
				}
				Xrec--; Crec++;
			}
		}
		return finalStr;
	}
	
	/*
	public static String getPageValues (int PageNo, int MaxPage) {
		int i=0, j=0, pageIndex=1;
		int INDEX_LEN=5, MIN_PAGE=2, MAX_PAGE=0;
		StringBuffer result = new StringBuffer();			
		result.append("");
		
    	if (MaxPage > 0){
	        pageIndex=1;
        	if (MaxPage > INDEX_LEN) {
             	MAX_PAGE=(MaxPage-INDEX_LEN)+1;
             	if ((PageNo > MIN_PAGE) && (PageNo < (MaxPage-MIN_PAGE))) pageIndex=(PageNo-MIN_PAGE);
             	else if (PageNo > MAX_PAGE && PageNo > MIN_PAGE) pageIndex=MAX_PAGE;
             	else if (PageNo > MIN_PAGE) pageIndex=PageNo-MIN_PAGE;
        	}
        	if (PageNo > 1) {
	            result.append("<a href=\"javascript:SetPage('"+(PageNo-1)+"')\"> Prev¡E￠cE￠®EcE￠®E¡EcEcE￠®E¡EcE¡E￠cEcE￠®E¡EcE¡E￠cEc¡E￠c￠®¡¿I￠®E¡Ec￠®¡×I </a>");
            	if (pageIndex!=1) result.append("...");
        	}
        	for (i=pageIndex,j=1; i <= MaxPage; i++,j++) {
	            if (i != PageNo)
                 	result.append("&#160;<a href=\"javascript:SetPage('"+i+"')\">"+i+"</a><font color=\"#999999\">|</font>");
            	else
	                result.append("&#160;<font color=#FF3300>"+i+"</font> <font color=\"#999999\">|</font>");
            	if (j==INDEX_LEN) break;
        	}
        	if( PageNo < MaxPage) {
	            if ((i--) < MaxPage) result.append("...");
            	result.append("<a href=\"javascript:SetPage('"+(PageNo+1)+"')\"> ¡E￠cE￠®EcE￠®E¡EcEcE￠®E¡EcE¡E￠cEc¡E￠cE￠®Ec￠®E¡Ec￠®E ￠®E¡EcE¡E￠cEc¡E￠c￠®¡¿I￠®E¡Ec￠®¡×INext </a>");
        	}
    	}
    	
		return result.toString();
	}	
	/**/
}	