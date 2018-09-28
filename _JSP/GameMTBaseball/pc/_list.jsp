<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@include file="_define.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title></title>
<link rel="stylesheet" href="../admin/image/intra.css" type="text/css">
<head>
<body>


<table border=1 align=center>
	<tr>
		<td>
			createid.jsp(이걸로 계정생성)
		</td>
		<td>
			<a href=createid.jsp?gameid=mtxxxx&password=049000s1i0n7t8445289&username=mtusername&birthday=19980101&phone=01011112221&email=mtxxx@xxx.xxx&nickname=mtnickname&version=100>mtxxxx생성</a><br>
			<a href=createid.jsp?gameid=mtxxxx2&password=049000s1i0n7t8445289&username=mtusername2&birthday=19980102&phone=01011112222&email=mtxxx2@xxx.xxx&nickname=mtnickname2&version=100>mtxxxx2생성</a><br>
			<a href=createid.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&username=mtusername3&birthday=19980103&phone=01011112223&email=mtxxx3@xxx.xxx&nickname=mtnickname3&version=100>mtxxxx3생성</a><br>
			
		</td>
		<td>			
			gameid=mtxxxx          <br>
			password=(암호화되어서전송됨) <br>
			username=mtusername    <br>
			birthday=19980101      <br>
			phone=01011112222      <br>
			email=mtxxx@xxx.xxx    <br>
			nickname=mtnickname    <br>
			version=100      	   <br>
		</td>
	</tr>
	<tr>
		<td>
			login.jsp
		</td>
		<td>
			<a href=login.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&version=199&connectip=127.0.0.1>로그인</a><br>
		</td>
		<td>
			gameid=xxxx           	<br>
			password=				<br>
			version=101				<br>
			connectip=101				<br>
		</td>
	</tr>	
	<tr>
		<td>
			servertime.jsp
		</td>
		<td>
			<a href=servertime.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289>서버시간</a><br>
		</td>
		<td>
			gameid=xxxx           	<br>
			password=				<br>
		</td>
	</tr>	
	<tr>
		<td>
			userparam.jsp
		</td>
		<td>
			<a href=userparam.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&mode=1&listset=0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;>저장모드</a><br>
			<a href=userparam.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&mode=2&listset=>읽기모드</a><br>
		</td>
		<td>
			gameid=mtxxxx3           	<br>
			password=xxx			<br>
			mode=xxx				<br>
			listset=xxx				<br>
		</td>
	</tr>
	<tr>
		<td>
			giftgain.jsp
		</td>
		<td>
			<a href=giftgain.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&sid=333&giftkind=-1&idx=1>쪽지받기(삭제)</a><br>
			<a href=giftgain.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&sid=333&giftkind=-3&idx=2>나무헬멧</a><br>
			<a href=giftgain.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&sid=333&giftkind=-3&idx=3>나무 헬멧 조각A</a><br>
			<a href=giftgain.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&sid=333&giftkind=-3&idx=4>나무 조각 랜덤박스</a><br>
			<a href=giftgain.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&sid=333&giftkind=-3&idx=5>나무 의상 랜덤박스</a><br>
			<a href=giftgain.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&sid=333&giftkind=-3&idx=6>조언 패키지 박스</a><br>
			<a href=giftgain.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&sid=333&giftkind=-3&idx=7>조합 주문서</a><br>
			<a href=giftgain.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&sid=333&giftkind=-3&idx=8>초월 주문서</a><br>
			<a href=giftgain.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&sid=333&giftkind=-3&idx=9>응원의 소리</a><br>
			<a href=giftgain.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&sid=333&giftkind=-3&idx=10>코치의 조언 주문서</a><br>
			<a href=giftgain.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&sid=333&giftkind=-3&idx=11>감독의 조언 주문서</a><br>
			<a href=giftgain.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&sid=333&giftkind=-3&idx=12>다이아 (5000 / 11개)</a><br>
			<a href=giftgain.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&sid=333&giftkind=-3&idx=13>다이아 (5001 / 100개)</a><br>
			<a href=giftgain.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&sid=333&giftkind=-3&idx=14>다이아 (5002 / 1000개)</a><br>
			<a href=giftgain.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&sid=333&giftkind=-3&idx=15>다이아 (5003 / 2500개)</a><br>
			<a href=giftgain.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&sid=333&giftkind=-3&idx=16>다이아 (5004 / 4000개)</a><br>
			<a href=giftgain.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&sid=333&giftkind=-3&idx=17>다이아 (5005 / 10000)</a><br>
			<a href=giftgain.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&sid=333&giftkind=-3&idx=18>다이아 (5005 / 20000)</a>
		</td>
		<td>
			gameid=xxxx3           	<br>
			password=xxx			<br>
			sid=xxxx(로그인에 할당받은)	<br>
			giftkind=xxxx			<br>
			idx=xxx(선물인덱스)			<br>
		</td>
	</tr>
	<tr>
		<td>inquire.jsp</td>
		<td>
			<a href=sysinquire.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&message=usermessage>문의하기</a><br>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
			message=			<br>
		</td>
	</tr>

	<%/*%>		
	<!--
	<tr>
		<td>
			itembuy.jsp
		</td>
		<td>
			<a href=itembuy.jsp?gameid=xxxx7&password=049000s1i0n7t8445289&listidx=-1&fieldidx=-1&quickind=-1&randserial=7772&itemcode=4>동물구매</a><br>
			<a href=itembuy.jsp?gameid=xxxx7&password=049000s1i0n7t8445289&listidx=-1&fieldidx=6&quickind=-1&randserial=122&itemcode=4>양(자리지정6)</a><br>
			<a href=itembuy.jsp?gameid=xxxx7&password=049000s1i0n7t8445289&listidx=-1&fieldidx=-1&quickind=-1&randserial=124&itemcode=701>총알</a><br>
			<a href=itembuy.jsp?gameid=xxxx7&password=049000s1i0n7t8445289&listidx=-1&fieldidx=-1&quickind=-1&randserial=123&itemcode=1401>악세</a><br>
			<a href=itembuy.jsp?gameid=xxxx7&password=049000s1i0n7t8445289&listidx=-1&fieldidx=-1&quickind=-1&randserial=126&itemcode=5105>코인환전</a><br>
			<a href=itembuy.jsp?gameid=xxxx7&password=049000s1i0n7t8445289&listidx=-1&fieldidx=-1&quickind=-1&randserial=126&itemcode=901>건초</a><br>
			<a href=itembuy.jsp?gameid=xxxx7&password=049000s1i0n7t8445289&listidx=-1&fieldidx=-1&quickind=-1&randserial=127&itemcode=2000>하트</a><br>
		</td>
		<td>
			gameid=mtxxxx3           	<br>
			password=				<br>
			itemcode=				<br>
			listidx=				<br>
			fieldidx=				<br>
			quickkind=				<br>
			randserial=				<br>
		</td>
	</tr>
	<tr>
		<td>
			itemsell.jsp
		</td>
		<td>
			<a href=itemsell.jsp?gameid=guest90269&password=2954812d7b3k0f645541&listidx=2&sellcnt=1>동물구매</a><br>
			<a href=itemsell.jsp?gameid=guest90269&password=2954812d7b3k0f645541&listidx=7&sellcnt=1>총알</a><br>
			<a href=itemsell.jsp?gameid=guest90269&password=2954812d7b3k0f645541&listidx=16&sellcnt=1>악세</a><br>
		</td>
		<td>
			gameid=mtxxxx3           	<br>
			password=				<br>
			listidx=				<br>
			sellcnt=
		</td>
	</tr>
	<tr>
		<td>
			itemselllist.jsp
		</td>
		<td>
			<a href=itemselllist.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&listset=1:65;2:69;>리스트로팔기</a><br>
		</td>
		<td>
			gameid=mtxxxx3           	<br>
			password=				<br>
			listset=
		</td>
	</tr>
	-->
	
	
	<!--
	<tr>
		<td>
			facupgrade.jsp
		</td>
		<td>
			<a href=facupgrade.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&subcategory=60&kind=1>집(시작)</a><br>
			<a href=facupgrade.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&subcategory=60&kind=2>집(즉시)</a><br>
			<a href=facupgrade.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&subcategory=61&kind=1>탱크(시작)</a><br>
			<a href=facupgrade.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&subcategory=61&kind=2>탱크(즉시)</a><br>
			<a href=facupgrade.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&subcategory=62&kind=1>저온보관(시작)</a><br>
			<a href=facupgrade.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&subcategory=62&kind=2>저온보관(즉시)</a><br>
			<a href=facupgrade.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&subcategory=63&kind=1>정화시설(시작)</a><br>
			<a href=facupgrade.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&subcategory=63&kind=2>정화시설(즉시)</a><br>
			<a href=facupgrade.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&subcategory=64&kind=1>양동이(시작)</a><br>
			<a href=facupgrade.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&subcategory=64&kind=2>양동이(즉시)</a><br>
			<a href=facupgrade.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&subcategory=65&kind=1>착유기(시작)</a><br>
			<a href=facupgrade.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&subcategory=65&kind=2>착유기(즉시)</a><br>
			<a href=facupgrade.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&subcategory=66&kind=1>주입기(시작)</a><br>
			<a href=facupgrade.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&subcategory=66&kind=2>주입기(즉시)</a><br>
		</td>
		<td>
			gameid=mtxxxx3           	<br>
			password=				<br>
			subcategory=			<br>
			kind=
		</td>
	</tr>
	<tr>
		<td>
			tutostep.jsp(new버젼)
		</td>
		<td>
			<a href=tutostep.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&tutostep=5500&ispass=-1>튜토리얼 step1</a><br>
			<a href=tutostep.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&tutostep=5501&ispass=1>튜토리얼 step2(패스)</a><br>
			<a href=tutostep.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&tutostep=5502&ispass=-1>튜토리얼 step3</a><br>
			<a href=tutostep.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&tutostep=5503&ispass=-1>튜토리얼 step4</a><br>
			<a href=tutostep.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&tutostep=5504&ispass=-1>튜토리얼 step5</a><br>
			<a href=tutostep.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&tutostep=5505&ispass=-1>튜토리얼 step6</a><br>
		</td>
		<td>
			gameid=mtxxxx3           	<br>
			password=				<br>
			tutostep=				<br>
			ispass=					<br>
		</td>
	</tr>
	<!--
	<tr>
		<td>
			deleteid.jsp
		</td>
		<td>
			<a href=deleteid.jsp?gameid=xxxx&password=049000s1i0n7t8445289>유저 본인 아이디 삭제요청</a>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289
		</td>
	</tr>
	<tr>
		<td>
			anidie.jsp
		</td>
		<td>
			<a href=anidie.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&mode=1&listidx=1>눌러죽음(1)</a><br>
			<a href=anidie.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&mode=2&listidx=4>늑대죽음(2)</a><br>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
			mode=1 or 2						<br>
			listidx=
		</td>
	</tr>
	<tr>
		<td>
			packbuy.jsp
		</td>
		<td>
			<a href=packbuy.jsp?gameid=xxxx&password=049000s1i0n7t8445289&idx=1&randserial=7772>패키지템 구매</a><br>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
			idx=							<br>
			randserial=
		</td>
	</tr>
	<tr>
		<td>
			roulbuy.jsp
		</td>
		<td>
			<a href=roulbuy.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&randserial=7772&mode=1&friendid=xxxx3>일반교배</a><br>
			<a href=roulbuy.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&randserial=7773&mode=2&friendid=xxxx3>프리미엄교배</a><br>
			<a href=roulbuy.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&randserial=7774&mode=4&friendid=xxxx3>프리미엄교배(10+1)</a><br>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
			randserial=						<br>
			mode=							<br>
			friendid=
		</td>
	</tr>
	<tr>
		<td>
			treasureupgrade.jsp
		</td>
		<td>
			<a href=treasureupgrade.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&mode=1&listidx=72&randserial=7772>일반강화</a><br>
			<a href=treasureupgrade.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&mode=2&listidx=73&randserial=7773>캐쉬강화</a>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
			mode=							<br>
			listidx=						<br>
			randserial=						<br>
		</td>
	</tr>
	<tr>
		<td>
			treasurewear.jsp
		</td>
		<td>
			<a href=treasurewear.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&listset=1:72;2:73;3:74;4:-1;5:-1;>장착하기</a><br>
			<a href=treasurewear.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&listset=1:54;2:-1;3:-1;4:-1;5:-1;>장착하기(클리어)</a>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
			listset=						<br>
		</td>
	</tr>
	<tr>
		<td>
			aniurgency.jsp
		</td>
		<td>
			<a href=aniurgency.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289>긴급지원</a>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
		</td>
	</tr>
	<tr>
		<td>
			anirestore.jsp
		</td>
		<td>
			<a href=anirestore.jsp?gameid=xxxx5&password=049000s1i0n7t8445289>다죽어서 복구요청</a>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
		</td>
	</tr>
	<tr>
		<td>
			anicompose.jsp
		</td>
		<td>
			<a href=anicompose.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&mode=1&itemcode=101002&listidxbase=19&listidxs1=20&randserial=11>합성(풀)</a><br>
			<a href=anicompose.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&mode=2&itemcode=101006&listidxbase=21&listidxs1=22&randserial=12>합성(확률)</a><br>
			<a href=anicompose.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&mode=3&itemcode=101010&listidxbase=28&listidxs1=29&randserial=13>합성(수정)</a><br>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
			mode=						<br>
			itemcode=					<br>
			listidxbase=				<br>
			listidxs1=					<br>
			listidxs2=					<br>
			listidxs3=					<br>
			listidxs4=					<br>
			randserial=					<br>
		</td>
	</tr>
	<tr>
		<td>
			anipromote.jsp
		</td>
		<td>
			<a href=anipromote.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&itemcode=102000&listidxs1=21&listidxs2=22&randserial=8888>승급</a><br>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
			itemcode=					<br>
			listidxs1=					<br>
			listidxs2=					<br>
			listidxs3=					<br>
			listidxs4=					<br>
			listidxs5=					<br>
			randserial=					<br>
		</td>
	</tr>
	<tr>
		<td>
			anicomposeinit.jsp
		</td>
		<td>
			<a href=anicomposeinit.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289>합성시간초기화</a><br>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
		</td>
	</tr>
	<!--

	<tr>
		<td>
			roulette.jsp
		</td>
		<td>
			<a href=roulette.jsp?gameid=xxxx>
				[코인사용]
			</a>
		</td>
		<td>
			gameid=xxxx
		</td>
	</tr>
	-->
	<tr>
		<td>cashbuy.jsp</td>
		<td>
			<a href=cashbuy.jsp?ikind=sandbox&mode=1&gameid=mtxxxx3&password=049000s1i0n7t8445289&giftid=&acode=ewoJInNpZ25hdHVyZSIgPSAiQW82K1lmZy9XSnFZUzZyZWlsWkhIZEI1NGRpbXBuQlRTMGY1RUpoTUY3OVdzK3NUVE5LK1B5UEthdkMxcFFNTGpsaFg5VFpPQmtxUm5DUDZBYmx2eTFucUY0NWxpbUpLK1RJZTNPUGp2bGNmVHRIOVdhTmxZWHRNWEdiZWNaR041SzR5UllFUVBVNXpCSm9IajFubkErNHhKVk9MMFlCOEYyT2E5REIzY3FsYUFBQURWekNDQTFNd2dnSTdvQU1DQVFJQ0NHVVVrVTNaV0FTMU1BMEdDU3FHU0liM0RRRUJCUVVBTUg4eEN6QUpCZ05WQkFZVEFsVlRNUk13RVFZRFZRUUtEQXBCY0hCc1pTQkpibU11TVNZd0pBWURWUVFMREIxQmNIQnNaU0JEWlhKMGFXWnBZMkYwYVc5dUlFRjFkR2h2Y21sMGVURXpNREVHQTFVRUF3d3FRWEJ3YkdVZ2FWUjFibVZ6SUZOMGIzSmxJRU5sY25ScFptbGpZWFJwYjI0Z1FYVjBhRzl5YVhSNU1CNFhEVEE1TURZeE5USXlNRFUxTmxvWERURTBNRFl4TkRJeU1EVTFObG93WkRFak1DRUdBMVVFQXd3YVVIVnlZMmhoYzJWU1pXTmxhWEIwUTJWeWRHbG1hV05oZEdVeEd6QVpCZ05WQkFzTUVrRndjR3hsSUdsVWRXNWxjeUJUZEc5eVpURVRNQkVHQTFVRUNnd0tRWEJ3YkdVZ1NXNWpMakVMTUFrR0ExVUVCaE1DVlZNd2daOHdEUVlKS29aSWh2Y05BUUVCQlFBRGdZMEFNSUdKQW9HQkFNclJqRjJjdDRJclNkaVRDaGFJMGc4cHd2L2NtSHM4cC9Sd1YvcnQvOTFYS1ZoTmw0WElCaW1LalFRTmZnSHNEczZ5anUrK0RyS0pFN3VLc3BoTWRkS1lmRkU1ckdYc0FkQkVqQndSSXhleFRldngzSExFRkdBdDFtb0t4NTA5ZGh4dGlJZERnSnYyWWFWczQ5QjB1SnZOZHk2U01xTk5MSHNETHpEUzlvWkhBZ01CQUFHamNqQndNQXdHQTFVZEV3RUIvd1FDTUFBd0h3WURWUjBqQkJnd0ZvQVVOaDNvNHAyQzBnRVl0VEpyRHRkREM1RllRem93RGdZRFZSMFBBUUgvQkFRREFnZUFNQjBHQTFVZERnUVdCQlNwZzRQeUdVakZQaEpYQ0JUTXphTittVjhrOVRBUUJnb3Foa2lHOTJOa0JnVUJCQUlGQURBTkJna3Foa2lHOXcwQkFRVUZBQU9DQVFFQUVhU2JQanRtTjRDL0lCM1FFcEszMlJ4YWNDRFhkVlhBZVZSZVM1RmFaeGMrdDg4cFFQOTNCaUF4dmRXLzNlVFNNR1k1RmJlQVlMM2V0cVA1Z204d3JGb2pYMGlreVZSU3RRKy9BUTBLRWp0cUIwN2tMczlRVWU4Y3pSOFVHZmRNMUV1bVYvVWd2RGQ0TndOWXhMUU1nNFdUUWZna1FRVnk4R1had1ZIZ2JFL1VDNlk3MDUzcEdYQms1MU5QTTN3b3hoZDNnU1JMdlhqK2xvSHNTdGNURXFlOXBCRHBtRzUrc2s0dHcrR0szR01lRU41LytlMVFUOW5wL0tsMW5qK2FCdzdDMHhzeTBiRm5hQWQxY1NTNnhkb3J5L0NVdk02Z3RLc21uT09kcVRlc2JwMGJzOHNuNldxczBDOWRnY3hSSHVPTVoydG04bnBMVW03YXJnT1N6UT09IjsKCSJwdXJjaGFzZS1pbmZvIiA9ICJld29KSW05eWFXZHBibUZzTFhCMWNtTm9ZWE5sTFdSaGRHVXRjSE4wSWlBOUlDSXlNREUwTFRBeUxUSTNJREl6T2pFek9qQTRJRUZ0WlhKcFkyRXZURzl6WDBGdVoyVnNaWE1pT3dvSkluVnVhWEYxWlMxcFpHVnVkR2xtYVdWeUlpQTlJQ0kwWkdKak1XWTBNVGRrTWpJNVl6STBNREl6TnpJMVpXSTFZekJrTjJZME5HVmhaalJsWVRKaUlqc0tDU0p2Y21sbmFXNWhiQzEwY21GdWMyRmpkR2x2YmkxcFpDSWdQU0FpTVRBd01EQXdNREV3TXpBeU16SXpNeUk3Q2draVluWnljeUlnUFNBaU1TNHdMakVpT3dvSkluUnlZVzV6WVdOMGFXOXVMV2xrSWlBOUlDSXhNREF3TURBd01UQXpNREl6TWpNeklqc0tDU0p4ZFdGdWRHbDBlU0lnUFNBaU1TSTdDZ2tpYjNKcFoybHVZV3d0Y0hWeVkyaGhjMlV0WkdGMFpTMXRjeUlnUFNBaU1UTTVNelUzTVRVNE9EUTJNaUk3Q2draWRXNXBjWFZsTFhabGJtUnZjaTFwWkdWdWRHbG1hV1Z5SWlBOUlDSkdSa1l6TlVaRVF5MUZPVFE1TFRReVFUQXRRa1ExT1MxQk9UYzBOa0kzTURZNE1FUWlPd29KSW5CeWIyUjFZM1F0YVdRaUlEMGdJbVpoY20xZk1URXdNQ0k3Q2draWFYUmxiUzFwWkNJZ1BTQWlOemt5TlRVeU1USXdJanNLQ1NKaWFXUWlJRDBnSW1OdmJTNXdhV04wYjNOdlpuUXVabUZ5YlhSNVkyOXZiaTVoY0hCc1pTSTdDZ2tpY0hWeVkyaGhjMlV0WkdGMFpTMXRjeUlnUFNBaU1UTTVNelUzTVRVNE9EUTJNaUk3Q2draWNIVnlZMmhoYzJVdFpHRjBaU0lnUFNBaU1qQXhOQzB3TWkweU9DQXdOem94TXpvd09DQkZkR012UjAxVUlqc0tDU0p3ZFhKamFHRnpaUzFrWVhSbExYQnpkQ0lnUFNBaU1qQXhOQzB3TWkweU55QXlNem94TXpvd09DQkJiV1Z5YVdOaEwweHZjMTlCYm1kbGJHVnpJanNLQ1NKdmNtbG5hVzVoYkMxd2RYSmphR0Z6WlMxa1lYUmxJaUE5SUNJeU1ERTBMVEF5TFRJNElEQTNPakV6T2pBNElFVjBZeTlIVFZRaU93cDkiOwoJImVudmlyb25tZW50IiA9ICJTYW5kYm94IjsKCSJwb2QiID0gIjEwMCI7Cgkic2lnbmluZy1zdGF0dXMiID0gIjAiOwp9&ucode=28745678911121098777bbbb66458466249504269139&itemcode=5000&cashcost=5557671427475695773506153205&cash=5557442711775695773506153210>iPhone 1100</a>							<br>
			<a href=cashbuy.jsp?ikind=GoogleID&mode=1&gameid=mtxxxx3&password=049000s1i0n7t8445289&giftid=&acode={\"receipt\":{\"orderId\":\"12999763169054705758.1373639491822994\",\"packageName\":\"com.marbles.farmvill5gg\",\"productId\":\"farm_3300\",\"purchaseTime\":1393581131311,\"purchaseState\":0,\"developerPayload\":\"optimus\",\"purchaseToken\":\"luzeyjbwahgstidpalbmxktx.AO-J1OzjxBJ8uSbkOFQNZys0oii7p5fKa8L6r2b0aqov79dJ3QfaI2v_LiRfvMgBOQoc33Qlwfwx_FSfnKqnWTt4OyXHhzgnO_eOQglB2DXZI-hUq4QsjPBd9qJPIJ3XYuVfO2npJtTJ\"},\"status\":0}&ucode=81867890233443210999dddd88670688463670395145&itemcode=5000&cashcost=310&cash=3300&kakaoUserId=91188455545412240>farm_3300</a>							<br>
			<a href=cashbuy.jsp?mode=2&gameid=mtxxxx3&giftid=xxxx3&password=049000s1i0n7t8445289&acode=xxxxx6&ucode=41767890323443210907dddd88679776060099800130&itemcode=5000&cashcost=8880086160708919982822110190&cash=4448644482164575548488776181>20캐쉬선물(mtxxxx3 > xxxx3)</a>		<br>
		</td>
		<td>
			mode=xxx							<br>
			gameid=xxxx                     	<br>
			giftid=xxxx							<br>
			password=049000s1i0n7t8445289       <br>
			acode=xxxx (승인코드)               <br>
			ucode=xxxxx <암호화루틴>    		<br>
			itemcode=xxxx						<br>
			cashcost=5557653730667094(10)		<br>
			cash=8882988816259092(1000)			<br>
			cashcost2=5557653730667094(10)		<br>
			cash2=8882988816259092(1000)		<br>
			ikind=xxxx							<br>
			idata=xxxx							<br>
			idata2=xxxx							<br>
		</td>
	</tr>
	<tr>
		<td>
			sysagreement.jsp
		</td>
		<td>
			<a href=sysagreement.jsp?lang=0>한글약관</a>			<br>
			<a href=sysagreement.jsp?lang=1>영문약관</a>			<br>
		</td>
		<td>
		</td>
	</tr>
	<tr>
		<td>
			changeinfo.jsp
		</td>
		<td>
			<a href=changeinfo.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&mode=1>추천 게시판 작성후 보상</a>	<br>
			<a href=changeinfo.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&mode=11>푸쉬받기/안받기</a>			<br>
			<a href=changeinfo.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&mode=12>카톡 메세지 블럭/해제</a>		<br>
		</td>
		<td>
			gameid=xxxx                     	<br>
			password=049000s1i0n7t8445289       <br>
			mode=xxx							<br>
		</td>
	</tr>
	<tr>
		<td>certno.jsp</td>
		<td>
			<a href=certno.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&certno=F9E93CE99BEA4A89>쿠폰등록</a><br>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
			certno=				<br>
		</td>
	</tr>
	<tr>
		<td>yabauchange.jsp</td>
		<td>
			<a href=yabauchange.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289>[행운의 주사위]리스트갱신</a><br>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
		</td>
	</tr>
	<tr>
		<td>yabaureward.jsp</td>
		<td>
			<a href=yabaureward.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289>[행운의 주사위]보상받기</a><br>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
		</td>
	</tr>
	<tr>
		<td>yabau.jsp</td>
		<td>
			<a href=yabau.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&mode=2&randserial=7772>[행운의 주사위]굴리기</a><br>
			<a href=yabau.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&mode=3&randserial=7773>[행운의 주사위]굴리기</a><br>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
			mode=				<br>
			randserial=			<br>
		</td>
	</tr>

	<tr>
		<td>
			ubboxopenopen.jsp
		</td>
		<td>
			<a href=ubboxopenopen.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&boxslotidx=1>박스오픈요구</a><br>
		</td>
		<td>
			gameid=xxxx            <br>
			password=xxxx          <br>
			boxslotidx=xxxx
		</td>
	</tr>
	<tr>
		<td>
			ubboxopencash.jsp
		</td>
		<td>
			<a href=ubboxopencash.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&boxslotidx=1>박스캐쉬오픈</a><br>
		</td>
		<td>
			gameid=xxxx            <br>
			password=xxxx          <br>
			boxslotidx=xxxx
		</td>
	</tr>
	<tr>
		<td>
			ubboxopencash2.jsp
		</td>
		<td>
			<a href=ubboxopencash2.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&boxslotidx=1>박스캐쉬2배오픈</a><br>
		</td>
		<td>
			gameid=xxxx            <br>
			password=xxxx          <br>
			boxslotidx=xxxx
		</td>
	</tr>
	<tr>
		<td>
			ubboxopengetitem.jsp
		</td>
		<td>
			<a href=ubboxopengetitem.jsp?gameid=mtxxxx3&password=049000s1i0n7t8445289&boxslotidx=1>박스시간되어 오픈</a><br>
		</td>
		<td>
			gameid=xxxx            <br>
			password=xxxx          <br>
			boxslotidx=xxxx
		</td>
	</tr>
	<%*/%>
</table>


<center>
<IFRAME src="../admin/_admin.jsp" width="800" height="700" scrolling="auto"></IFRAME><br>
</center>

<br><br><br><br><br><br><br><br>
</body>
</html>