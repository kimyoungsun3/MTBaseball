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
	<!--
	<tr>
		<td>
			newstart.jsp
		</td>
		<td>
			<a href=newstart.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&kakaouserid=kakaouseridxxxx2>계정정지</a><br>
		</td>
		<td>
			gameid=xxxx            <br>
			password=xxxx          <br>
			kakaouserid=xxxx       <br>
		</td>
	</tr>
	-->
	<tr>
		<td>
			create.jsp(이걸로 계정생성)
		</td>
		<td>
			<a href=createguest.jsp?gameid=farm&password=049000s1i0n7t8445289&market=5&buytype=0&platform=1&ukey=xxxxx&version=101&phone=01011112222&pushid=>farm아이디생성</a><br>
			<a href=createguest.jsp?gameid=farm&password=049000s1i0n7t8445289&market=5&buytype=0&platform=1&ukey=xxxxx&version=101&phone=01011112222&pushid=&kakaotalkid=kakaotalkidxxxx2>farm 재연결</a><br>
			gameid에 farm라고만하면 자동으로 생성한다.
		</td>
		<td>
			gameid=farm           <br>
			password=(클라자동생성)<br>
			market=1               <br>
			buytype=0              <br>
			platform=1             <br>
			ukey=xxxxx             <br>
			version=101      	   <br>
			phone=01011112222      <br>
			pushid=xxxx            <br>
		</td>
	</tr>
	<tr>
		<td>
			login.jsp
		</td>
		<td>
			<a href=login.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&market=5&version=199>로그인</a><br>
		</td>
		<td>
			gameid=xxxx           	<br>
			password=				<br>
			market=1				<br>
			version=101				<br>
		</td>
	</tr>
	
	<%/*%>
	<!--
	<tr>
		<td>
			kchecknn.jsp
		</td>
		<td>
			<a href=kchecknn.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&kakaonickname=xxxx2>닉네임 변경</a><br>
		</td>
		<td>
			gameid=xxxx    <br>
			password=xxxx    <br>
			kakaonickname=xxxx    <br>
		</td>
	</tr>
	<tr>
		<td>
			kfadd.jsp
		</td>
		<td>
			<a href=kfadd.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&kakaofriendlist=0:kakaouseridxxxx;1:kakaouseridxxxx3;>카카오 친구추가</a><br>
		</td>
		<td>
			gameid=xxxx            <br>
			password=xxxx          <br>
			kakaofriendlist=kakaouseridxxxx;1:kakaouseridxxxx3;       <br>
		</td>
	</tr>
	<tr>
		<td>
			kfreset.jsp
		</td>
		<td>
			<a href=kfreset.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&kakaofriendlist=0:kakaouseridxxxx;1:kakaouseridxxxx3;>카카오 친구reset</a><br>
		</td>
		<td>
			gameid=xxxx            <br>
			password=xxxx          <br>
			kakaofriendlist=kakaouseridxxxx;1:kakaouseridxxxx3;       <br>
		</td>
	</tr>
	<tr>
		<td>
			kfinvite.jsp
			(카톡 초대)
		</td>
		<td>
			<a href=kfinvite.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&kakaouserid=kakaouseridxxxx>카카오 초대메세지 전송후</a><br>
		</td>
		<td>
			gameid=xxxx            <br>
			password=xxxx          <br>
			kakaouserid=kakaouseridxxxx<br>
		</td>
	</tr>
	<tr>
		<td>
			kfhelp.jsp
			(내동물 살려줘)
		</td>
		<td>
			<a href=kfhelp.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&friendid=xxxx&listidx=18>친구야 내동물 살려줘(xxxx2 -> xxxx)</a><br>
			<a href=kfhelp.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&friendid=xxxx3&listidx=18>친구야 내동물 살려줘(xxxx2 -> xxxx3)</a><br>
		</td>
		<td>
			gameid=xxxx            <br>
			password=xxxx          <br>
			friendid=xxxx<br>
			listidx=xxxx<br>
		</td>
	</tr>
	<tr>
		<td>
			kfhelplist.jsp
			(내게 요청한 친구들)
		</td>
		<td>
			<a href=kfhelplist.jsp?gameid=xxxx&password=049000s1i0n7t8445289>친구야 내동물 살려줘(xxxx:내게 요청한 리스트)</a><br>
			<a href=kfhelplist.jsp?gameid=xxxx3&password=049000s1i0n7t8445289>친구야 내동물 살려줘(xxxx3:내게 요청한 리스트)</a><br>
		</td>
		<td>
			gameid=xxxx            <br>
			password=xxxx          <br>
		</td>
	</tr>
	-->
	
	
	<!--
	<tr>
		<td>
			changepw.jsp
		</td>
		<td>
			<a href=changepw.jsp?gameid=xxxx&password=049000s1i0n7t8445289&phone=77887878888999897807684710811117>패스워드변경</a><br>
		</td>
		<td>
			gameid=xxxx           	<br>
			password=새로운패스워드	<br>
			phone=암호화된폰		<br>
			strPhoneNumber:01011112221<br>
			strPhoneNumberC:77887878888999897807684710811117<br>
		</td>
	</tr>
	<tr>
		<td>
			dailyreward.jsp
		</td>
		<td>
			<a href=dailyreward.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>일일보상받기</a><br>
		</td>
		<td>
			gameid=xxxx2           	<br>
			password=				<br>
		</td>
	</tr>
	-->
	
	<!--
	<tr>
		<td>
			giftgain.jsp
		</td>
		<td>
			<a href=giftgain.jsp?gameid=xxxx6&password=049000s1i0n7t8445289&giftkind=-1&idx=75&listidx=-1&fieldidx=-1&quickkind=-1>쪽지받기</a><br>
			<a href=giftgain.jsp?gameid=xxxx6&password=049000s1i0n7t8445289&giftkind=-3&idx=60&listidx=-1&fieldidx=-1&quickkind=-1>소받기</a><br>
			<a href=giftgain.jsp?gameid=xxxx6&password=049000s1i0n7t8445289&giftkind=-3&idx=61&listidx=-1&fieldidx=0&quickkind=-1>양(자리지정)</a><br>
			<a href=giftgain.jsp?gameid=xxxx6&password=049000s1i0n7t8445289&giftkind=-3&idx=69&listidx=-1&fieldidx=-1&quickkind=-1>악세받기</a><br>
			<a href=giftgain.jsp?gameid=xxxx6&password=049000s1i0n7t8445289&giftkind=-3&idx=63&listidx=-1&fieldidx=-1&quickkind=-1>총알받기</a><br>
			<a href=giftgain.jsp?gameid=xxxx6&password=049000s1i0n7t8445289&giftkind=-3&idx=63&listidx=24&fieldidx=-1&quickkind=1>총알받기(누적, 링크번호 확인요)</a><br>
			<a href=giftgain.jsp?gameid=xxxx6&password=049000s1i0n7t8445289&giftkind=-3&idx=70&listidx=-1&fieldidx=-1&quickkind=-1>하트받기</a><br>
			<a href=giftgain.jsp?gameid=xxxx6&password=049000s1i0n7t8445289&giftkind=-3&idx=74&listidx=-1&fieldidx=-1&quickkind=-1>대회티켓B받기</a><br>
			<a href=giftgain.jsp?gameid=xxxx6&password=049000s1i0n7t8445289&giftkind=-5&idx=-1&listidx=-1&fieldidx=-1&quickkind=-1>리스트보기</a><br>
		</td>
		<td>
			gameid=xxxx2           	<br>
			password=				<br>
			idx=45
		</td>
	</tr>
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
			gameid=xxxx2           	<br>
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
			gameid=xxxx2           	<br>
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
			<a href=itemselllist.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&listset=1:65;2:69;>리스트로팔기</a><br>
		</td>
		<td>
			gameid=xxxx2           	<br>
			password=				<br>
			listset=
		</td>
	</tr>
	<tr>
		<td>
			itemquick.jsp
		</td>
		<td>
			<a href=itemquick.jsp?gameid=xxxx9&password=049000s1i0n7t8445289&listidx=7&quickkind=1>총알</a><br>
			<a href=itemquick.jsp?gameid=xxxx9&password=049000s1i0n7t8445289&listidx=8&quickkind=1>치료제</a><br>
			<a href=itemquick.jsp?gameid=xxxx9&password=049000s1i0n7t8445289&listidx=9&quickkind=1>일꾼</a><br>
			<a href=itemquick.jsp?gameid=xxxx9&password=049000s1i0n7t8445289&listidx=10&quickkind=1>촉진제</a><br>
			<a href=itemquick.jsp?gameid=xxxx9&password=049000s1i0n7t8445289&listidx=7&quickkind=-1>총알(해제)</a><br>
			<a href=itemquick.jsp?gameid=xxxx9&password=049000s1i0n7t8445289&listidx=8&quickkind=-1>치료제(해제)</a><br>
			<a href=itemquick.jsp?gameid=xxxx9&password=049000s1i0n7t8445289&listidx=9&quickkind=-1>일꾼(해제)</a><br>
			<a href=itemquick.jsp?gameid=xxxx9&password=049000s1i0n7t8445289&listidx=10&quickkind=-1>촉진제(해제)</a><br>
		</td>
		<td>
			gameid=xxxx2           	<br>
			password=				<br>
			listidx=				<br>
			quickkind=
		</td>
	</tr>
	-->
	
	<!--
	<tr>
		<td>
			itemacc.jsp
		</td>
		<td>
			<a href=itemacc.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&anilistidx=1&acclistidx=16&acc2listidx=-1>1번동물에 12번악세를 머리</a><br>
			<a href=itemacc.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&anilistidx=1&acclistidx=-1&acc2listidx=17>1번동물에                  13번악세를 옆구리</a><br>
			<a href=itemacc.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&anilistidx=1&acclistidx=16&acc2listidx=17>1번동물에 12번악세를 머리, 13번악세를 옆구리</a><br>
		</td>
		<td>
			gameid=xxxx2           	<br>
			password=				<br>
			anilistidx=				<br>
			acclistidx=				<br>
			acc2listidx=			<br>
		</td>
	</tr>
	<tr>
		<td>
			itemaccnew.jsp
		</td>
		<td>
			<a href=itemaccnew.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&anilistidx=19&acclistidx=20&acc2listidx=22&randserial=7771>액세끼기</a><br>
			<a href=itemaccnew.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&anilistidx=19&acclistidx=-2&acc2listidx=-2&randserial=7772>유지</a><br>
			<a href=itemaccnew.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&anilistidx=19&acclistidx=-1&acc2listidx=-1&randserial=7773>벗기</a><br>
		</td>
		<td>
			gameid=xxxx2           	<br>
			password=				<br>
			anilistidx=				<br>
			acclistidx=				<br>
			acc2listidx=			<br>
			randserial=			<br>
		</td>
	</tr>
	-->
	
	
	<!--
	<tr>
		<td>
			iteminvenexp.jsp
		</td>
		<td>
			<a href=iteminvenexp.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&invenkind=1>동물 인벤확장.</a><br>
			<a href=iteminvenexp.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&invenkind=3>소비템 인벤확장.</a><br>
			<a href=iteminvenexp.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&invenkind=4>악세사리 인벤확장.</a><br>
			<a href=iteminvenexp.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&invenkind=1040>줄기세포 인벤확장.</a><br>
			<a href=iteminvenexp.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&invenkind=1200>보물 인벤확장.</a><br>
		</td>
		<td>
			gameid=xxxx2           	<br>
			password=				<br>
			invenkind=
		</td>
	</tr>
	<tr>
		<td>
			facupgrade.jsp
		</td>
		<td>
			<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=60&kind=1>집(시작)</a><br>
			<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=60&kind=2>집(즉시)</a><br>
			<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=61&kind=1>탱크(시작)</a><br>
			<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=61&kind=2>탱크(즉시)</a><br>
			<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=62&kind=1>저온보관(시작)</a><br>
			<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=62&kind=2>저온보관(즉시)</a><br>
			<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=63&kind=1>정화시설(시작)</a><br>
			<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=63&kind=2>정화시설(즉시)</a><br>
			<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=64&kind=1>양동이(시작)</a><br>
			<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=64&kind=2>양동이(즉시)</a><br>
			<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=65&kind=1>착유기(시작)</a><br>
			<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=65&kind=2>착유기(즉시)</a><br>
			<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=66&kind=1>주입기(시작)</a><br>
			<a href=facupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&subcategory=66&kind=2>주입기(즉시)</a><br>
		</td>
		<td>
			gameid=xxxx2           	<br>
			password=				<br>
			subcategory=			<br>
			kind=
		</td>
	</tr>
	<tr>
		<td>
			dogamlist.jsp
		</td>
		<td>
			<a href=dogamlist.jsp?gameid=xxxx&password=049000s1i0n7t8445289>도감리스트(획득, 보상받은것)</a><br>
		</td>
		<td>
			gameid=xxxx2           	<br>
			password=
		</td>
	</tr>
	<tr>
		<td>
			dogamreward.jsp
		</td>
		<td>
			<a href=dogamreward.jsp?gameid=xxxx&password=049000s1i0n7t8445289&dogamidx=1>도감보상</a><br>
		</td>
		<td>
			gameid=xxxx2           	<br>
			password=				<br>
			dogamidx=1
		</td>
	</tr>
	<tr>
		<td>
			tutorial.jsp(old버젼)<br>
			사용안할 예정임
		</td>
		<td>
			<a href=tutorial.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=1>튜토리얼 정장</a><br>
			<a href=tutorial.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=2>튜토리얼 재튜토리얼</a><br>
			<a href=tutorial.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=3>튜토리얼 스킵</a><br>
		</td>
		<td>
			gameid=xxxx2           	<br>
			password=				<br>
			mode=
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
			gameid=xxxx2           	<br>
			password=				<br>
			tutostep=				<br>
			ispass=					<br>
		</td>
	</tr>
	<tr>
		<td>
			competition.jsp
		</td>
		<td>
			<a href=competition.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&comreward=90100>경쟁모드 90100</a><br>
			<a href=competition.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&comreward=90101>경쟁모드 90101</a><br>
			<a href=competition.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&comreward=90102>경쟁모드 90102</a><br>
			<a href=competition.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&comreward=90103>경쟁모드 90103</a><br>
			<a href=competition.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&comreward=90104>경쟁모드 90104</a><br>
			<a href=competition.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&comreward=90105>경쟁모드 90105</a><br>
			<a href=competition.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&comreward=90106>경쟁모드 90106</a><br>
			<a href=competition.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&comreward=90107>경쟁모드 90107</a><br>
			<a href=competition.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&comreward=90108>경쟁모드 90108</a><br>
			<a href=competition.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&comreward=90109>경쟁모드 90109</a><br>
			<a href=competition.jsp?gameid=guest91521&password=0362431g4n3v4r824568&comreward=90106&paraminfo=0:90106;1:4;2:0;3:0;4:201304;5:06:90106&ispass=1>경쟁모드 guest91521</a><br>
		</td>
		<td>
			gameid=xxxx2           	<br>
			password=				<br>
			comreward=1				<br>
			ispass=					<br>
		</td>
	</tr>
	<tr>
		<td>
			userparam.jsp
		</td>
		<td>
			<a href=userparam.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=1&listset=0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;>저장모드</a><br>
			<a href=userparam.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=2&listset=>읽기모드</a><br>
		</td>
		<td>
			gameid=xxxx2           	<br>
			password=xxx			<br>
			mode=xxx				<br>
			listset=xxx				<br>
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
	-->
	<!--
	<tr>
		<td>
			aniset.jsp
		</td>
		<td>
			<!--<a href=aniset.jsp?gameid=xxxx&password=049000s1i0n7t8445289&listset=0:1;1:2;2:3;3:4;4:5;5:6;6:12;7:13;8:14>동물설정(정상)</a><br>
			<a href=aniset.jsp?gameid=xxxx&password=049000s1i0n7t8445289&listset=0:1;1:3;2:17;3:16;4:8>동물설정(대표, 죽은것 포함 > 자동필터)</a><br>-->

			<a href=aniset.jsp?gameid=xxxx&password=049000s1i0n7t8445289&crypt=1&listset=11110201208004>동물설정(암호화)</a><br>
			<a href=aniset.jsp?gameid=xxxx&password=049000s1i0n7t8445289&crypt=1&listset=11151:2;045010>동물설정(암호화)</a><br>
			<a href=aniset.jsp?gameid=xxxx&password=049000s1i0n7t8445289&crypt=1&listset=11341:2;2:3;3:4;4:5;5:6;6:7124>동물설정(암호화)</a><br>
			<a href=aniset.jsp?gameid=xxxx&password=049000s1i0n7t8445289&crypt=1&listset=11891:3124;2:5;3:23;5:5;21:22;22:212;23:32;24:312;41:27;51:2116;52:2211;53:2;54:2;166>동물설정(암호화)</a><br>
			<a href=aniset.jsp?gameid=xxxx&password=049000s1i0n7t8445289&crypt=1&listset=44615:9,5,5;7:9,67,4;8:9,69,-5;243>동물설정(암호화)</a><br>
			<a href=aniset.jsp?gameid=xxxx&password=049000s1i0n7t8445289&crypt=1&listset=22932:7;3:4;32:3;33:3;34:97;42:3;52:3;53:32;54:3;55:32;56:42;57:332;62:922;076>동물설정(암호화)</a><br>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
			listset=0:1;1:3	<br>
		</td>
	</tr>
	<tr>
		<td>
			anidie.jsp
		</td>
		<td>
			<a href=anidie.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=1&listidx=1>눌러죽음(1)</a><br>
			<a href=anidie.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=2&listidx=4>늑대죽음(2)</a><br>
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
			anirevival.jsp
		</td>
		<td>
			<a href=anirevival.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=1&listidx=1&fieldidx=1>필드부활(부활석x1 or 캐쉬+1) > 필드로 넣기.</a><br>
			<a href=anirevival.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=2&listidx=4&fieldidx=-1>병원부활(부활석x2 or (캐쉬+1)*2) > 인벤으로 넣기.</a><br>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
			mode=1 or 2						<br>
			listidx=						<br>
			fieldidx
		</td>
	</tr>
	<tr>
		<td>
			aniuseitem.jsp
		</td>
		<td>
			<a href=aniuseitem.jsp?gameid=xxxx5&password=049000s1i0n7t8445289&crypt=1&listset=44421:5;2:6;084>소모템(12번1개, 13번 1개)</a><br>
		</td>
		<td>
			gameid=xxxx5         			<br>
			password=049000s1i0n7t8445289	<br>
			listset=소모템리스트:사용개수...
		</td>
	</tr>
	<tr>
		<td>
			anirepreg.jsp
		</td>
		<td>
			<a href=anirepreg.jsp?gameid=xxxx&password=049000s1i0n7t8445289&listidx=0>대표동물설정(정상.)</a><br>
			<a href=anirepreg.jsp?gameid=xxx0&password=049000s1i0n7t8445289&listidx=0>대표동물설정(아이디없음.)</a><br>
			<a href=anirepreg.jsp?gameid=xxxx&password=049000s1i0n7t8445289&listidx=8>대표동물설정(소모템.)</a><br>
			<a href=anirepreg.jsp?gameid=xxxx&password=049000s1i0n7t8445289&listidx=1>대표동물설정(필드동물.)</a><br>
			<a href=anirepreg.jsp?gameid=xxxx&password=049000s1i0n7t8445289&listidx=99>대표동물설정(없음.)</a><br>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
			listidx=17	<br>
		</td>
	</tr>
	<tr>
		<td>
			anihoslist.jsp
		</td>
		<td>
			<a href=anihoslist.jsp?gameid=xxxx&password=049000s1i0n7t8445289>동물병원리스트(요청처리, 병원리스트, 내집동물 리스트)</a><br>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289
		</td>
	</tr>
	<tr>
		<td>
			aniupgrade.jsp
		</td>
		<td>
			<a href=aniupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&listidxani=2&listset=0:30;&randserial=7777>동물업그레이드</a><br>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
			listidxani=						<br>
			listset=						<br>
			randserial=
		</td>
	</tr>
	<tr>
		<td>
			anibattlestart.jsp
		</td>
		<td>
			<a href=anibattlestart.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&farmidx=6900&listset=0:2;1:39;1:38;>싸움시작</a><br>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
			farmidx=						<br>
			listset=
		</td>
	</tr>
	<tr>
		<td>
			anibattleresult.jsp
		</td>
		<td>
			<a href=anibattleresult.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&battleidx2=65&result=1&playtime=90&star=3>싸움End</a><br>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
			battleidx2=						<br>
			result=							<br>
			playtime=						<br>
			star=
		</td>
	</tr>
	<tr>
		<td>
			anibattleplaycntbuy.jsp
		</td>
		<td>
			<a href=anibattleplaycntbuy.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&farmidx=6900>부족한횟수구매</a><br>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
			farmidx=						<br>
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
			<a href=roulbuy.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&randserial=7772&mode=1&friendid=xxxx3>일반교배</a><br>
			<a href=roulbuy.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&randserial=7773&mode=2&friendid=xxxx3>프리미엄교배</a><br>
			<a href=roulbuy.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&randserial=7774&mode=4&friendid=xxxx3>프리미엄교배(10+1)</a><br>
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
			treasurebuy.jsp
		</td>
		<td>
			<a href=treasurebuy.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&randserial=7772&mode=1>일반보물뽑기</a><br>
			<a href=treasurebuy.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&randserial=7773&mode=2>프리미엄보물뽑기</a><br>
			<a href=treasurebuy.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&randserial=7774&mode=4>프리미엄보물뽑기(10+1)</a><br>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
			randserial=						<br>
			mode=
		</td>
	</tr>
	<tr>
		<td>
			treasureupgrade.jsp
		</td>
		<td>
			<a href=treasureupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=1&listidx=72&randserial=7772>일반강화</a><br>
			<a href=treasureupgrade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=2&listidx=73&randserial=7773>캐쉬강화</a>
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
			<a href=treasurewear.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&listset=1:72;2:73;3:74;4:-1;5:-1;>장착하기</a><br>
			<a href=treasurewear.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&listset=1:54;2:-1;3:-1;4:-1;5:-1;>장착하기(클리어)</a>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
			listset=						<br>
		</td>
	</tr>
	<tr>
		<td>
			apartitemcode.jsp
		</td>
		<td>
			<a href=apartitemcode.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=1&randserial=8771&listset=1:25;>1개분해(동물,보물)</a><br>
			<a href=apartitemcode.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=1&randserial=8773&listset=1:34;3:26;4:27;5:28;6:29;7:30;8:31;9:32;10:33;>여러개분해(동물,보물)</a>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
			mode=xxx						<br>
			listset=						<br>
		</td>
	</tr>
	<!--
	<tr>
		<td>
			roulacc.jsp
		</td>
		<td>
			<a href=roulacc.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>악세뽑기</a><br>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
		</td>
	</tr>
	-->
	<tr>
		<td>
			aniurgency.jsp
		</td>
		<td>
			<a href=aniurgency.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>긴급지원</a>
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
			<a href=anicompose.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=1&itemcode=101002&listidxbase=19&listidxs1=20&randserial=11>합성(풀)</a><br>
			<a href=anicompose.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=2&itemcode=101006&listidxbase=21&listidxs1=22&randserial=12>합성(확률)</a><br>
			<a href=anicompose.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=3&itemcode=101010&listidxbase=28&listidxs1=29&randserial=13>합성(수정)</a><br>
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
			<a href=anipromote.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&itemcode=102000&listidxs1=21&listidxs2=22&randserial=8888>승급</a><br>
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
			<a href=anicomposeinit.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>합성시간초기화</a><br>
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
	<tr>
		<td>
			friendls.jsp
		</td>
		<td>
			<a href=friendls.jsp?gameid=xxxx&harvest=1>
				[라커룸 실버획득]
			</a>
		</td>
		<td>
			gameid=xxxx		<br>
			harvest=1		<br>
		</td>
	</tr>
	-->
	<tr>
		<td>fsearch.jsp</td>
		<td>
			<a href=fsearch.jsp?gameid=xxxx&password=049000s1i0n7t8445289&friendid=>		검색 : 랜덤검색</a>	<br>
			<a href=fsearch.jsp?gameid=xxxx&password=049000s1i0n7t8445289&friendid=DD>		검색 : 이웃 > 0초</a><br>
			<a href=fsearch.jsp?gameid=xxxx&password=049000s1i0n7t8445289&friendid=AD>		검색 : 없음 > 0초</a>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
			friendid=DD
		</td>
	</tr>
	<tr>
		<td>fadd.jsp</td>
		<td>
			<a href=fadd.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&friendid=xxxx3>	친구 추가(계속추가가능))</a><br>
			<a href=fadd.jsp?gameid=xxxx&password=049000s1i0n7t8445289&friendid=DD>			친구 없음</a>				<br>
			<a href=fadd.jsp?gameid=xxxx&password=049000s1i0n7t8445289&friendid=xxxx>		자기추가</a>				<br>
			<a href=fadd.jsp?gameid=xxxx2&password=1111&friendid=xxxx3>						패스워드틀림</a>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
			friendid=DD
		</td>
	</tr>
	<tr>
		<td>fdelete.jsp</td>
		<td>
			<a href=fdelete.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&friendid=xxxx3>	친구 삭제</a>	<br>
			<a href=fdelete.jsp?gameid=xxxx&password=049000s1i0n7t8445289&friendid=DD>		친구 없음</a>	<br>
			<a href=fdelete.jsp?gameid=xxxx&password=1111&friendid=DD1>						패스워드틀림</a>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
			friendid=DD
		</td>
	</tr>
	<tr>
		<td>fapprove.jsp</td>
		<td>
			<a href=fapprove.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&friendid=xxxx2>	친구 승인(신청받은사람이)</a>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
			friendid=DD
		</td>
	</tr>
	<tr>
		<td>fmyfriend.jsp</td>
		<td>
			<a href=fmyfriend.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>				친구 My리스트</a>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
		</td>
	</tr>
	<tr>
		<td>fvisit.jsp</td>
		<td>
			<a href=fvisit.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&friendid=xxxx3>		친구 방문</a>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
			friendid=xxxx2
		</td>
	</tr>
	<tr>
		<td>fheart.jsp</td>
		<td>
			<a href=fheart.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&friendid=xxxx3>		친구에게 하트(난 우정포인트)</a>
		</td>
		<td>
			gameid=xxxx2		<br>
			password=			<br>
			friendid=xxxx3
		</td>
	</tr>
	<tr>
		<td>fproud.jsp</td>
		<td>
			<a href=fproud.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&friendid=xxxx>		자랑하기(가능한가를 묻는다)</a>
		</td>
		<td>
			gameid=xxxx2		<br>
			password=			<br>
			friendid=xxxx
		</td>
	</tr>
	<tr>
		<td>freturn.jsp</td>
		<td>
			<a href=freturn.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&friendid=xxxx3>친구야 돌아와줘 (요청)</a>
		</td>
		<td>
			gameid=xxxx2		<br>
			password=			<br>
			friendid=xxxx3
		</td>
	</tr>
	<tr>
		<td>frent.jsp</td>
		<td>
			<a href=frent.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&friendid=xxxx>		친구동물 빌려쓰기</a>
		</td>
		<td>
			gameid=xxxx2		<br>
			password=			<br>
			friendid=xxxx
		</td>
	</tr>
	<tr>
		<td>fpoint.jsp</td>
		<td>
			<a href=fpoint.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>우정포인트 > 캐쉬일꾼</a>
		</td>
		<td>
			gameid=xxxx2		<br>
			password=
		</td>
	</tr>
	<tr>
		<td>fwbuy.jsp</td>
		<td>
			<a href=fwbuy.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&itemcode=6900>농장 구매</a>
		</td>
		<td>
			gameid=xxxx2		<br>
			password=			<br>
			itemcode=
		</td>
	</tr>
	<tr>
		<td>fwsell.jsp</td>
		<td>
			<a href=fwsell.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&itemcode=6900>농장 판매</a>
		</td>
		<td>
			gameid=xxxx2		<br>
			password=			<br>
			itemcode=
		</td>
	</tr>
	<tr>
		<td>fwincome.jsp</td>
		<td>
			<a href=fwincome.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&itemcode=6900>농장 수익</a>
		</td>
		<td>
			gameid=xxxx2		<br>
			password=			<br>
			itemcode=
		</td>
	</tr>
	<tr>
		<td>fwincomeall.jsp</td>
		<td>
			<a href=fwincomeall.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>농장 수익(전체를 한꺼번에)</a>
		</td>
		<td>
			gameid=xxxx2		<br>
			password=			<br>
		</td>
	</tr>
	<tr>
		<td>
			seedbuy.jsp
		</td>
		<td>
			<a href=seedbuy.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=1>경작지구매(1)</a>		<br>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
			seedidx=인덱스번호
		</td>
	</tr>
	<tr>
		<td>
			seedplant.jsp
		</td>
		<td>
			<a href=seedplant.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=1&seeditemcode=600&feeduse=1>건초 > 직접</a>			<br>
			<a href=seedplant.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=6&seeditemcode=607&feeduse=1>하트 > 직접</a>			<br>
			<a href=seedplant.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=7&seeditemcode=605&feeduse=1>회복 > 소모(선물함)</a>	<br>
			<a href=seedplant.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=8&seeditemcode=606&feeduse=1>촉진 > 소모(선물함)</a>	<br>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
			seedidx=인덱스번호	<br>
			seeditemcode=씨앗아이템코드
		</td>
	</tr>
	<tr>
		<td>
			seedharvest.jsp
		</td>
		<td>
			<a href=seedharvest.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=1&mode=1&feeduse=1>일반수확(건초 > 직접)</a><br>
			<a href=seedharvest.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=6&mode=1&feeduse=1>일반수확(하트 > 직접)</a><br>
			<a href=seedharvest.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=7&mode=1&feeduse=1>일반수확(회복 > 소모(선물함))</a><br>
			<a href=seedharvest.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=8&mode=1&feeduse=1>일반수확(촉진 > 소모(선물함))</a><br>
			<a href=seedharvest.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=1&mode=2&feeduse=1>즉시수확(건초 > 직접)</a><br>
			<a href=seedharvest.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=6&mode=2&feeduse=1>즉시수확(하트 > 직접)</a><br>
			<a href=seedharvest.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=7&mode=2&feeduse=1>즉시수확(회복 > 소모(선물함))</a><br>
			<a href=seedharvest.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=8&mode=2&feeduse=1>즉시수확(촉진 > 소모(선물함))</a><br>

			<a href=seedharvest.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&seedidx=1&mode=3&feeduse=1>일반수확(건초 > 직접)</a><br>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
			seedidx=인덱스번호	<br>
			mode=
		</td>
	</tr>
	<tr>
		<td>
			save.jsp
		</td>
		<td>
			<a href=save.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&crypt=1&userinfo=66436:8679;7:9;8:79;0:0;76:77;77:767;78:87;79:867;96:72;06:-7;07:-7;08:-7;09:7;00:-7;01:-7;126&aniitem=77948:2,8,8;0:2,90,7;1:2,92,-8;243&cusitem=667170:7;71:7;72:7;186&paraminfo=55955:5;6:6;7:7;8:8;9:9;0:0;1:1;2:2;3:3;4:4;064>저장하기</a><br>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
			userinfo=			<br>
			aniitem=			<br>
			cusitem=
		</td>
	</tr>
	<tr>
		<td>
			trade.jsp
		</td>
		<td>
			<a href=trade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&crypt=1&userinfo=0:2013;1:4;2:0;4:2;10:10;11:100;12:20;13:200;30:16;43:1;&aniitem=1:5,1,1;3:5,23,0;4:5,25,-1;&cusitem=14:1;15:1;16:1;&tradeinfo=0:5;1:2;10:2;11:1;12:75;20:10;30:1;31:11;33:7;34:20;35:77;40:5119;61:-1;62:1;63:-1;&paraminfo=0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;>거래 > 저장하기(2013.3) 코인보상</a><br>
			<a href=trade.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&crypt=1&userinfo=0:2013;1:4;2:0;4:2;10:10;11:100;12:20;13:200;30:16;43:1;&aniitem=1:5,1,1;3:5,23,0;4:5,25,-1;&cusitem=14:1;15:1;16:1;&tradeinfo=0:5;1:2;10:2;11:1;12:75;20:10;30:1;31:11;33:7;34:20;35:77;40:1200;61:-1;62:1;63:-1;&paraminfo=0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;>거래 > 저장하기(2013.3) 부활석</a><br>




		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
			userinfo=			<br>
			aniitem=			<br>
			cusitem=			<br>
			tradeinfo=

		</td>
	</tr>
	<tr>
		<td>
			tradecash.jsp
		</td>
		<td>
			<a href=tradecash.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>[게임거래_캐쉬상인]</a>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
		</td>
	</tr>
	<tr>
		<td>
			tradecontinue.jsp
		</td>
		<td>
			<a href=tradecontinue.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>[게임거래_연속거래]</a>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
		</td>
	</tr>
	<tr>
		<td>
			tradechange.jsp
		</td>
		<td>
			<a href=tradechange.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&tradeinfo=0:0;1:1;2:2;3:3;4:4;5:5;6:6;>게임상인변경(기존)</a><br>
			<a href=tradechange.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&tradeinfo=0:7;1:8;2:9;3:10;4:11;5:12;6:13;>게임상인변경(신규)</a>
		</td>
		<td>
			gameid=xxxx         			<br>
			password=049000s1i0n7t8445289	<br>
			tradeinfo=:0;1:1;2:2;3:3;4:4;5:5;6:6;
		</td>
	</tr>
	<tr>
		<td>cashbuy.jsp</td>
		<td>
			<a href=cashbuy.jsp?ikind=sandbox&mode=1&gameid=xxxx2&password=049000s1i0n7t8445289&giftid=&acode=ewoJInNpZ25hdHVyZSIgPSAiQW82K1lmZy9XSnFZUzZyZWlsWkhIZEI1NGRpbXBuQlRTMGY1RUpoTUY3OVdzK3NUVE5LK1B5UEthdkMxcFFNTGpsaFg5VFpPQmtxUm5DUDZBYmx2eTFucUY0NWxpbUpLK1RJZTNPUGp2bGNmVHRIOVdhTmxZWHRNWEdiZWNaR041SzR5UllFUVBVNXpCSm9IajFubkErNHhKVk9MMFlCOEYyT2E5REIzY3FsYUFBQURWekNDQTFNd2dnSTdvQU1DQVFJQ0NHVVVrVTNaV0FTMU1BMEdDU3FHU0liM0RRRUJCUVVBTUg4eEN6QUpCZ05WQkFZVEFsVlRNUk13RVFZRFZRUUtEQXBCY0hCc1pTQkpibU11TVNZd0pBWURWUVFMREIxQmNIQnNaU0JEWlhKMGFXWnBZMkYwYVc5dUlFRjFkR2h2Y21sMGVURXpNREVHQTFVRUF3d3FRWEJ3YkdVZ2FWUjFibVZ6SUZOMGIzSmxJRU5sY25ScFptbGpZWFJwYjI0Z1FYVjBhRzl5YVhSNU1CNFhEVEE1TURZeE5USXlNRFUxTmxvWERURTBNRFl4TkRJeU1EVTFObG93WkRFak1DRUdBMVVFQXd3YVVIVnlZMmhoYzJWU1pXTmxhWEIwUTJWeWRHbG1hV05oZEdVeEd6QVpCZ05WQkFzTUVrRndjR3hsSUdsVWRXNWxjeUJUZEc5eVpURVRNQkVHQTFVRUNnd0tRWEJ3YkdVZ1NXNWpMakVMTUFrR0ExVUVCaE1DVlZNd2daOHdEUVlKS29aSWh2Y05BUUVCQlFBRGdZMEFNSUdKQW9HQkFNclJqRjJjdDRJclNkaVRDaGFJMGc4cHd2L2NtSHM4cC9Sd1YvcnQvOTFYS1ZoTmw0WElCaW1LalFRTmZnSHNEczZ5anUrK0RyS0pFN3VLc3BoTWRkS1lmRkU1ckdYc0FkQkVqQndSSXhleFRldngzSExFRkdBdDFtb0t4NTA5ZGh4dGlJZERnSnYyWWFWczQ5QjB1SnZOZHk2U01xTk5MSHNETHpEUzlvWkhBZ01CQUFHamNqQndNQXdHQTFVZEV3RUIvd1FDTUFBd0h3WURWUjBqQkJnd0ZvQVVOaDNvNHAyQzBnRVl0VEpyRHRkREM1RllRem93RGdZRFZSMFBBUUgvQkFRREFnZUFNQjBHQTFVZERnUVdCQlNwZzRQeUdVakZQaEpYQ0JUTXphTittVjhrOVRBUUJnb3Foa2lHOTJOa0JnVUJCQUlGQURBTkJna3Foa2lHOXcwQkFRVUZBQU9DQVFFQUVhU2JQanRtTjRDL0lCM1FFcEszMlJ4YWNDRFhkVlhBZVZSZVM1RmFaeGMrdDg4cFFQOTNCaUF4dmRXLzNlVFNNR1k1RmJlQVlMM2V0cVA1Z204d3JGb2pYMGlreVZSU3RRKy9BUTBLRWp0cUIwN2tMczlRVWU4Y3pSOFVHZmRNMUV1bVYvVWd2RGQ0TndOWXhMUU1nNFdUUWZna1FRVnk4R1had1ZIZ2JFL1VDNlk3MDUzcEdYQms1MU5QTTN3b3hoZDNnU1JMdlhqK2xvSHNTdGNURXFlOXBCRHBtRzUrc2s0dHcrR0szR01lRU41LytlMVFUOW5wL0tsMW5qK2FCdzdDMHhzeTBiRm5hQWQxY1NTNnhkb3J5L0NVdk02Z3RLc21uT09kcVRlc2JwMGJzOHNuNldxczBDOWRnY3hSSHVPTVoydG04bnBMVW03YXJnT1N6UT09IjsKCSJwdXJjaGFzZS1pbmZvIiA9ICJld29KSW05eWFXZHBibUZzTFhCMWNtTm9ZWE5sTFdSaGRHVXRjSE4wSWlBOUlDSXlNREUwTFRBeUxUSTNJREl6T2pFek9qQTRJRUZ0WlhKcFkyRXZURzl6WDBGdVoyVnNaWE1pT3dvSkluVnVhWEYxWlMxcFpHVnVkR2xtYVdWeUlpQTlJQ0kwWkdKak1XWTBNVGRrTWpJNVl6STBNREl6TnpJMVpXSTFZekJrTjJZME5HVmhaalJsWVRKaUlqc0tDU0p2Y21sbmFXNWhiQzEwY21GdWMyRmpkR2x2YmkxcFpDSWdQU0FpTVRBd01EQXdNREV3TXpBeU16SXpNeUk3Q2draVluWnljeUlnUFNBaU1TNHdMakVpT3dvSkluUnlZVzV6WVdOMGFXOXVMV2xrSWlBOUlDSXhNREF3TURBd01UQXpNREl6TWpNeklqc0tDU0p4ZFdGdWRHbDBlU0lnUFNBaU1TSTdDZ2tpYjNKcFoybHVZV3d0Y0hWeVkyaGhjMlV0WkdGMFpTMXRjeUlnUFNBaU1UTTVNelUzTVRVNE9EUTJNaUk3Q2draWRXNXBjWFZsTFhabGJtUnZjaTFwWkdWdWRHbG1hV1Z5SWlBOUlDSkdSa1l6TlVaRVF5MUZPVFE1TFRReVFUQXRRa1ExT1MxQk9UYzBOa0kzTURZNE1FUWlPd29KSW5CeWIyUjFZM1F0YVdRaUlEMGdJbVpoY20xZk1URXdNQ0k3Q2draWFYUmxiUzFwWkNJZ1BTQWlOemt5TlRVeU1USXdJanNLQ1NKaWFXUWlJRDBnSW1OdmJTNXdhV04wYjNOdlpuUXVabUZ5YlhSNVkyOXZiaTVoY0hCc1pTSTdDZ2tpY0hWeVkyaGhjMlV0WkdGMFpTMXRjeUlnUFNBaU1UTTVNelUzTVRVNE9EUTJNaUk3Q2draWNIVnlZMmhoYzJVdFpHRjBaU0lnUFNBaU1qQXhOQzB3TWkweU9DQXdOem94TXpvd09DQkZkR012UjAxVUlqc0tDU0p3ZFhKamFHRnpaUzFrWVhSbExYQnpkQ0lnUFNBaU1qQXhOQzB3TWkweU55QXlNem94TXpvd09DQkJiV1Z5YVdOaEwweHZjMTlCYm1kbGJHVnpJanNLQ1NKdmNtbG5hVzVoYkMxd2RYSmphR0Z6WlMxa1lYUmxJaUE5SUNJeU1ERTBMVEF5TFRJNElEQTNPakV6T2pBNElFVjBZeTlIVFZRaU93cDkiOwoJImVudmlyb25tZW50IiA9ICJTYW5kYm94IjsKCSJwb2QiID0gIjEwMCI7Cgkic2lnbmluZy1zdGF0dXMiID0gIjAiOwp9&ucode=28745678911121098777bbbb66458466249504269139&market=7&itemcode=5000&cashcost=5557671427475695773506153205&cash=5557442711775695773506153210>iPhone 1100</a>							<br>
			<a href=cashbuy.jsp?ikind=GoogleID&mode=1&gameid=xxxx2&password=049000s1i0n7t8445289&giftid=&acode={\"receipt\":{\"orderId\":\"12999763169054705758.1373639491822994\",\"packageName\":\"com.marbles.farmvill5gg\",\"productId\":\"farm_3300\",\"purchaseTime\":1393581131311,\"purchaseState\":0,\"developerPayload\":\"optimus\",\"purchaseToken\":\"luzeyjbwahgstidpalbmxktx.AO-J1OzjxBJ8uSbkOFQNZys0oii7p5fKa8L6r2b0aqov79dJ3QfaI2v_LiRfvMgBOQoc33Qlwfwx_FSfnKqnWTt4OyXHhzgnO_eOQglB2DXZI-hUq4QsjPBd9qJPIJ3XYuVfO2npJtTJ\"},\"status\":0}&ucode=81867890233443210999dddd88670688463670395145&market=5&itemcode=5000&cashcost=310&cash=3300&kakaoUserId=91188455545412240>farm_3300</a>							<br>
			<a href=cashbuy.jsp?mode=2&gameid=xxxx2&giftid=xxxx3&password=049000s1i0n7t8445289&acode=xxxxx6&ucode=41767890323443210907dddd88679776060099800130&market=1&itemcode=5000&cashcost=8880086160708919982822110190&cash=4448644482164575548488776181>20캐쉬선물(xxxx2 > xxxx3)</a>		<br>
		</td>
		<td>
			mode=xxx							<br>
			gameid=xxxx                     	<br>
			giftid=xxxx							<br>
			password=049000s1i0n7t8445289       <br>
			acode=xxxx (승인코드)               <br>
			ucode=xxxxx <암호화루틴>    		<br>
			market=1					   		<br>
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
			notice.jsp
		</td>
		<td>
			<a href=notice.jsp?market=<%=SKT%>&buytype=0>공지사항[SKT]</a>			<br>
			<a href=notice.jsp?market=<%=GOOGLE%>&buytype=0>공지사항[GOOGLE]</a>	<br>
			<a href=notice.jsp?market=<%=IPHONE%>&buytype=0>공지사항[NHN]</a>		<br>
		</td>
		<td>
			market=마켓						<br>
			buytype=무료(0), 유료(1)
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
			market=마켓						<br>
			buytype=무료(0), 유료(1)
		</td>
	</tr>
	<tr>
		<td>
			changeinfo.jsp
		</td>
		<td>
			<a href=changeinfo.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=1>추천 게시판 작성후 보상</a>	<br>
			<a href=changeinfo.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=11>푸쉬받기/안받기</a>			<br>
			<a href=changeinfo.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=12>카톡 메세지 블럭/해제</a>		<br>
		</td>
		<td>
			gameid=xxxx                     	<br>
			password=049000s1i0n7t8445289       <br>
			mode=xxx							<br>
		</td>
	</tr>
	<tr>
		<td>
			fbwrite.jsp
		</td>
		<td>
			<a href=fbwrite.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&kind=1&message=normalboard>일반 게시판 작성</a>			<br>
			<a href=fbwrite.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&kind=2&message=friendboard>친추 게시판 작성</a>			<br>
			<a href=fbwrite.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&kind=3&message=schoolboard>대항 게시판 작성</a>			<br>
		</td>
		<td>
			gameid=xxxx                     	<br>
			password=049000s1i0n7t8445289       <br>
			kind=xxx							<br>
			kind=message						<br>
		</td>
	</tr>
	<tr>
		<td>
			fbread.jsp
		</td>
		<td>
			<a href=fbread.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&kind=1&page=1>일반 게시판 읽기</a>			<br>
			<a href=fbread.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&kind=2&page=1>친추 게시판 읽기</a>			<br>
			<a href=fbread.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&kind=3&page=1>대항 게시판 읽기</a>			<br>
		</td>
		<td>
			gameid=xxxx                     	<br>
			password=049000s1i0n7t8445289       <br>
			kind=xxx							<br>
			page=1								<br>
		</td>
	</tr>
	<!--
	<tr>
		<td>
			sendsms.jsp
		</td>
		<td>
			<a href=sendsms.jsp?gameid=Superman7&password=049000s1i0n7t8445289&sendkey=3635364745483737474858519149294164505648483431548600235736&recphone=66776767777888886787864618416115>SMS발송</a><br>
		</td>
		<td>
			gameid=Superman7				<br>
			password=049000s1i0n7t8445289	<br>
			sendkey=3635364745483737474858519149294164505648483431548600235736<br>
			recphone=66776767777888886787864618416115
		</td>
	</tr>
	<tr>
		<td>
			pushmsg.jsp
		</td>
		<td>
			<a href=sendpush.jsp?gameid=guest90586&password=5697165c2c6g3u571634&receid=guest90586&kind=1&msgtitle=단순제목&msgmsg=단순내용>단순푸쉬</a><br>
			<a href=sendpush.jsp?gameid=guest90586&password=5697165c2c6g3u571634&receid=guest90586&kind=2&msgtitle=자랑제목&msgmsg=자랑내용>자랑푸쉬</a><br>
			<a href=sendpush.jsp?gameid=guest90586&password=5697165c2c6g3u571634&receid=guest90586&kind=3&msgtitle=URL제목&msgmsg=http://m.naver.com>URL푸쉬</a><br>
		</td>
		<td>
			gameid=guest73801				<br>
			password=7845557f9w2v5m112499	<br>
			receid=guest73801				<br>
			kind=1							<br>
			msgtitle=단순제목				<br>
			msgmsg=단순내용					<br>
			(웹에서 전송하면 문자가 깨짐(클라는 이상없음))
		</td>
	</tr>
	-->
	<tr>
		<td>schoolsearch.jsp</td>
		<td>
			<a href=schoolsearch.jsp?gameid=xxxx&password=049000s1i0n7t8445289&schoolkind=1&schoolname=용봉>검색 > 초등 > 용봉</a>	<br>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
			schoolkind=xxx		<br>
			schoolname=xxx

		</td>
	</tr>
	<tr>
		<td>schooljoin.jsp</td>
		<td>
			<a href=schooljoin.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&schoolidx=1>가입</a><br>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
			schoolidx=xxx		<br>
		</td>
	</tr>
	<tr>
		<td>schooltop.jsp</td>
		<td>
			<a href=schooltop.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>Top10 + 내학교순위(학교들)</a><br>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
		</td>
	</tr>
	<tr>
		<td>schoolusertop.jsp</td>
		<td>
			<a href=schoolusertop.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>Top10 + 내순위(학교내)</a><br>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
		</td>
	</tr>
	<tr>
		<td>certno.jsp</td>
		<td>
			<a href=certno.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&certno=F9E93CE99BEA4A89>쿠폰등록</a><br>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
			certno=				<br>
		</td>
	</tr>
	<tr>
		<td>inquire.jsp</td>
		<td>
			<a href=sysinquire.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&message=usermessage>문의하기</a><br>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
			message=				<br>
		</td>
	</tr>
	<tr>
		<td>pettoday.jsp</td>
		<td>
			<a href=pettoday.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&paramint=100004>[펫]오늘만 이가격 100004</a><br>
			<a href=pettoday.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&paramint=100016>[펫]오늘만 이가격 100016</a><br>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
			paramint=			<br>
		</td>
	</tr>
	<tr>
		<td>petroll.jsp</td>
		<td>
			<a href=petroll.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&paramint=-1>[펫]뽑기</a><br>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
			paramint=			<br>
		</td>
	</tr>
	<tr>
		<td>petupgrade.jsp</td>
		<td>
			<a href=petupgrade.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&paramint=10>[펫]업그레이드</a><br>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
			paramint=			<br>
		</td>
	</tr>
	<tr>
		<td>petwear.jsp</td>
		<td>
			<a href=petwear.jsp?gameid=xxxx3&password=049000s1i0n7t8445289&paramint=10>[펫]장착</a><br>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
			paramint=			<br>
		</td>
	</tr>
	<tr>
		<td>petexp.jsp</td>
		<td>
			<a href=petexp.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>[펫]체험하기</a><br>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
		</td>
	</tr>
	<tr>
		<td>yabauchange.jsp</td>
		<td>
			<a href=yabauchange.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>[행운의 주사위]리스트갱신</a><br>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
		</td>
	</tr>
	<tr>
		<td>yabaureward.jsp</td>
		<td>
			<a href=yabaureward.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>[행운의 주사위]보상받기</a><br>
		</td>
		<td>
			gameid=xxxx			<br>
			password=			<br>
		</td>
	</tr>
	<tr>
		<td>yabau.jsp</td>
		<td>
			<a href=yabau.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=2&randserial=7772>[행운의 주사위]굴리기</a><br>
			<a href=yabau.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=3&randserial=7773>[행운의 주사위]굴리기</a><br>
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
			<a href=ubboxopenopen.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&boxslotidx=1>박스오픈요구</a><br>
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
			<a href=ubboxopencash.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&boxslotidx=1>박스캐쉬오픈</a><br>
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
			<a href=ubboxopencash2.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&boxslotidx=1>박스캐쉬2배오픈</a><br>
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
			<a href=ubboxopengetitem.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&boxslotidx=1>박스시간되어 오픈</a><br>
		</td>
		<td>
			gameid=xxxx            <br>
			password=xxxx          <br>
			boxslotidx=xxxx
		</td>
	</tr>
	<tr>
		<td>
			ubsearch.jsp
		</td>
		<td>
			<a href=ubsearch.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&listset=0:14;>유저 배틀 검색</a><br>
		</td>
		<td>
			gameid=xxxx            <br>
			password=xxxx          <br>
			boxslotidx=xxxx
		</td>
	</tr>
	<tr>
		<td>
			ubresult.jsp
		</td>
		<td>
			<a href=ubresult.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&userbattleidx2=123&result=1&playtime=90>유저 배틀 결과</a><br>
		</td>
		<td>
			gameid=xxxx            	<br>
			password=xxxx          	<br>
			userbattleidx2=xxxx  	<br>
			result=xxxx  			<br>
			playtime=xxxx
		</td>
	</tr>
	<tr>
		<td>
			ranklist.jsp
		</td>
		<td>
			<a href=ranklist.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>유저 랭킹정보</a><br>
		</td>
		<td>
			gameid=xxxx            	<br>
			password=xxxx          	<br>
		</td>
	</tr>
	<tr>
		<td>
			wheel.jsp
		</td>
		<td>
			<a href=wheel.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=20&usedcashcost=0&randserial=7771>일일룰렛</a><br>
			<a href=wheel.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=21&usedcashcost=300&randserial=7772>황금룰렛</a><br>
			<a href=wheel.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=22&usedcashcost=0&randserial=7773>황금룰렛물료</a><br>
		</td>
		<td>
			gameid=xxxx            <br>
			password=xxxx          <br>
			mode=xxxx      		   <br>
			usedcashcost=xxxx      <br>
			randserial=xxxx      <br>
		</td>
	</tr>
	<tr>
		<td>
			rkrank.jsp
		</td>
		<td>
			<a href=rkrank.jsp?gameid=xxxx2&password=049000s1i0n7t8445289>랭킹대전정보</a><br>
		</td>
		<td>
			gameid=xxxx            <br>
			password=xxxx          <br>
		</td>
	</tr>
	<tr>
		<td>
			zcpchance.jsp
		</td>
		<td>
			<a href=zcpchance.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=1&usedcashcost=0&randserial=7771>짜요쿠폰룰렛(무료)</a><br>
			<a href=zcpchance.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&mode=2&usedcashcost=200&randserial=7772>짜요쿠폰룰렛(캐쉬)</a><br>
		</td>
		<td>
			gameid=xxxx            <br>
			password=xxxx          <br>
			mode=xxxx      		   <br>
			usedcashcost=xxxx      <br>
			randserial=xxxx      <br>
		</td>
	</tr>
	<tr>
		<td>
			zcpbuy.jsp
		</td>
		<td>
			<a href=zcpbuy.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&idx=3&randserial=7771>짜요장터구매</a><br>
			<a href=zcpbuy.jsp?gameid=xxxx2&password=049000s1i0n7t8445289&idx=3&randserial=7772>짜요장터구매</a><br>
		</td>
		<td>
			gameid=xxxx            <br>
			password=xxxx          <br>
			idx=xxxx      		   <br>
			randserial=xxxx      <br>
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