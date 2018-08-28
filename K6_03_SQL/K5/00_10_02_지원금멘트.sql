---------------------------------------------
-- 지원금멘트.
---------------------------------------------
use GameMTBaseball
GO

IF OBJECT_ID (N'dbo.tSystemSupportMsg', N'U') IS NOT NULL
	DROP TABLE dbo.tSystemSupportMsg;
GO

create table dbo.tSystemSupportMsg(
	idx					int 				IDENTITY(1, 1),

	groupid				int,
	groupline			int,
	msg					varchar(1024)
	-- Constraint
	CONSTRAINT	pk_tSystemSupportMsg_idx	PRIMARY KEY(idx)
)

-- 2013. 4		> 상점, 소모템 열림(튜토리얼).
--				>  코인 300
insert into tSystemSupportMsg(groupid, groupline, msg)	values(0, 0, '안녕하세요? 반갑습니다. 저는 낙농조합 지원센터에서 지원금을 전하러 온 사람입니다.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(0, 1, '목장에 새롭게 정착한 사람이 있으면 낙농조합에서 일정 기간동안 지원금을 지급해주는 시스템이 있습니다.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(0, 2, '지원금 매달 [ffcc00]300만 코인[ffffff]씩 지원해 드립니다. 필요한데 있으면 사용하세요. [ffcc00]직접 넣어[ffffff]드렸습니다. 그럼 다음에 또 뵙겠습니다.')

-- 2013. 5		>
-- 상점 구입	> 코인 300
insert into tSystemSupportMsg(groupid, groupline, msg)	values(1, 0, '안녕하세요. 지원센터에서 나왔습니다.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(1, 1, '이번달 [ffcc00]지원금[ffffff]은 넣어드렸습니다. 목장 운영에 필요한 곳에 사용하시면 됩니다. 그럼 수고하세요.')

--2013. 6		> 교배가 이뤄짐(강제이동).
--				> 코인 300
insert into tSystemSupportMsg(groupid, groupline, msg)	values(2, 0, '안녕하세요? 센터에서 [ffcc00]지원금[ffffff] 전달하러 왔습니다.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(2, 1, '이번달 지원금은 여기 있습니다. 목장을 잘되시는지 모르겠습니다.')

--2013. 7		> 경작지(튜토리얼), 시설업그레이드(강제이동).
--				> 코인 300
insert into tSystemSupportMsg(groupid, groupline, msg)	values(3, 0, '안녕하세요? 이번달 [ffcc00]지원금[ffffff]은 여기 있습니다.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(3, 1, '운영은 잘하고 계시죠? 아이템은 아끼지 마시고 사용하세요.')

--2013. 8		>
-- 치료제.		> 코인 300
insert into tSystemSupportMsg(groupid, groupline, msg)	values(4, 0, '안녕하세요? 목장 운영은 좀 익숙해지셨습니까?')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(4, 1, '이번달 [ffcc00]지원금[ffffff]도 넣어드렸습니다. 수고하세요.')

--2013. 9		> 목장구매(튜토리얼)
--				> 코인 300
insert into tSystemSupportMsg(groupid, groupline, msg)	values(5, 0, '안녕하세요? 이번달 지원금 드리러 왔습니다.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(5, 1, '필요한 것 있으시면 부족하지만 구매해서 사용하세요. 그럼 수고하세요')

--2013. 10		>
-- 세포강화		> 코인 300
insert into tSystemSupportMsg(groupid, groupline, msg)	values(6, 0, '안녕하세요? 낙농 조합 지원금을 전하러 왔습니다.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(6, 1, '꿀팁하나 드리자면 줄기세포로 동물의 신선도를 올릴 수 있습니다. 조합에 몇개 나와서 [ffcc00]우편함[ffffff]에 넣어드렸습니다.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(6, 2, '[ffcc00]우편함 수령후 내집에서 줄기세포 모양을 탭에서 강화[ffffff] 할 수 있습니다.')

--2013. 11		>
-- 일꾼			> 코인 300
insert into tSystemSupportMsg(groupid, groupline, msg)	values(7, 0, '안녕하세요? 센터에서 [ffcc00]지원금[ffffff] 전달하러 왔습니다.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(7, 1, '팁하나 더 드리자면 일꾼을 사용하세요. 수월하게 운영할 수 있습니다. 행운을 빌어요.')

--2013. 12		> 4년 마다 결산 설명. 목장구매.
--				> 코인 300
insert into tSystemSupportMsg(groupid, groupline, msg)	values(8, 0, '안녕하세요? 목장 운영에 상당히 익숙해진 것 갔습니다.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(8, 1, '이번달 [ffcc00]지원금[ffffff]은 넣어 드렸습니다.. 그럼 다음에 또 뵙겠습니다.')

--2014. 1		>
-- 수익창출		> 코인 300
insert into tSystemSupportMsg(groupid, groupline, msg)	values(9, 0, '안녕하세요? 이번달 지원금 드리러 왔습니다.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(9, 1, '팁하나 드리자면 상인들이 선호하는 동물들이 있습니다. 그것을 구해두시면 상인의 단가가 상승합니다.')

--2014. 2		>
-- 보물.		> 코인 300
insert into tSystemSupportMsg(groupid, groupline, msg)	values(10, 0, '이번이 낙농조합의 마지막 [ffcc00]지원금[ffffff]입니다.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(10, 3, '아참, 운이 좋네요. 이번에 동물과 보물 티켓이 지원나와서 [ffcc00]특.별.히.[ffffff] 몇장 드리고 가겠습니다.')
insert into tSystemSupportMsg(groupid, groupline, msg)	values(10, 2, '보물 티켓은 보물 메뉴에서 뽑을 수 있습니다. 강화를 통해서 기능을 더욱 향상 시킬수 있습니다. [ffcc00]행운을 빌겠습니다.')


--2014. 3		> 목장구매(강제이동)
