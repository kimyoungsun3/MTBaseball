<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@include file="_define.jsp"%>

<html><head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="image/intra.css">
<script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script type="text/javascript" async="" src="http://www.google-analytics.com/ga.js"></script><script language="javascript" src="image/script.js"></script>
<script language="javascript">
<!--
function f_Submit(f) {
	if(f_nul_chk(f.adminId, '아이디를')) return false;
	else return true;
}

//-->
</script>
<script type="text/javascript" src="chrome-extension://ekodbiinoofgjabcganpmpbffgceedkm/ganalytics.js"></script><script type="text/javascript" src="chrome-extension://gnehinmllbmphhjngobeiegcbdkjplkg/ganalytics.js"></script></head>

<body bgcolor="#ffffff" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="javascript:document.GIFTFORM.adminId.focus();">
<center><br><br><br>
<br>
<center>
<table border=1>
	<tbody>
	<tr>
		<td>
			<a href=notice_list.jsp>@공지사항10</a>				<br>
			<a href=sysinquire_list.jsp>@유저문의</a>			<br><br>
			
			<a href=pcroom_list.jsp>@PC방관리</a>				<br>
			<a href=pcroomearn_day.jsp>@PC방수익(일별/개별)</a>	<br>
			<a href=sgresult_log.jsp>@일일매출현황</a>			<br><br>
			
			<a href=lottoinfo_list.jsp>@나눔로또</a>			<br><br>

			<a href=statistics_day.jsp>@일반 접속/가입통계(일별)</a><br>
			<!--
			<a href=cashtotal_list2.jsp>캐쉬구매통계(월별)</a>	<br>
			-->
		</td>
		<td>			
			<a href=userinfo_list.jsp>@유저정보</a>						<br><br>
			
			<a href=sgbet_list.jsp>@싱글배팅정보(진행)</a>					<br>
			<a href=sgresult_list.jsp>@싱글배팅정보(완료)</a>				<br>			
			<a href=ptbet_list.jsp>@연습배팅정보(진행)</a>					<br>
			<a href=ptresult_list.jsp>@연습배팅정보(완료)</a>				<br>
			<!--
			<a href=useritembuylogtotal_mas.jsp>아이템 판매통계(일별)</a>		<br>
			<a href=useritembuylogtotal_mon.jsp>아이템 판매통계(월별)</a>		<br>
			<a href=useritemupgradelogtotal_mas.jsp>아이템 강화통계(일별)</a>	<br><br>
			(일반적인 통계자료를 수집합니다.)										<br><br>			
			<a href=cashbuy_list.jsp>루비구매로그(유저별상세)</a>				<br>
			<a href=cashtotal_list.jsp>루비구매통계(종류별)</a>					<br>
			<a href=cashtotal_list2.jsp>루비구매통계(월별)</a>					<br><br>
			<a href=cashtotal_list3.jsp>루비구매통계(일별유니크)</a>				<br><br>
			-->
		</td>
		<td>

			<a href=wgiftsend_form.jsp>@선물하기</a>					<br>
			<a href=wgiftsend_list.jsp>@선물리스트</a>				<br><br>
			<!--
			<a href=systeminfo_list.jsp>@루비,코인,하트,업글,룰렛(MAX)</a><br>
			(프로모션 루비, 코인, 하트,악세뽑기 변경)				<br>
			(아이템 테이블 변경되면 한번씩 변경함)					<br>
			(집,탱크,품질,축사,양동이,착유기,주입기Max)				<br><br>
			<a href=systempack_list.jsp>패키지상품(구성하기)</a>	<br>
			(5개의 상품을 한개묶음으로 판매)						
			-->

		</td>
		<td>
			(비활성화 될 예정)<br>
			<a href=iteminfo_list.jsp>@아이템정보(시스템)</a><br>
			<!--	
			<a href=iteminfo_list2.jsp>아이템정보(단계별:프로그램)</a>	<br>
			<a href=iteminfo_list3.jsp>아이템정보(단계별:이미지)</
			<a href=certno_list.jsp>@쿠폰리스트(관리용)</a>		<br><br>
			-->


		</td>
		<td>
			<!--
			(비활성화 될 예정)<br>
			<a href=adminuserbattlebank_list.jsp>유저배틀Bank(관리용)</a><br>
			<a href=adminusersalelog_list.jsp>거래내역(관리용)</a><br>
			<a href=adminfarmbattlelog_list.jsp>목장배틀(관리용)</a><br>
			<a href=adminuserbattlelog_list.jsp>유저배틀(관리용)</a><br>
			<a href=userdellog_list.jsp>유저판매/합성/분해(관리용)</a><br>
			<a href=userblock_list.jsp>블럭계정(치트유저)</a>	<br>
			
			-->

			<a href=unusual_list.jsp>@비정상내용(관리용)</a>		<br>
			<a href=unusual_list2.jsp>@비정상내용2(관리용)</a>		<br>			
			<a href=adminaction_list.jsp>@관리자액션(관리용)</a>	<br>
			<a href=blockphone_list.jsp>@블럭핸드폰(치트유저)</a>	<br>
			<a href=changenickname_list.jsp>@닉네임변경(관리용)</a>		<br>


		</td>
	</tr>
</tbody></table>
</center>
</body>
