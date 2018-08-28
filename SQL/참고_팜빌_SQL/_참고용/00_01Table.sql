/*
use Farm
GO

-- 잘못해서 테이블을 전체 건드릴수 있어서 주석처리로 막아둔다.(전에 실수한적이 있어서)
-- 입력 < 검색(우선순위)
-- 데이타베이스 대소문자 구분안함(새로 세팅된 서버 확인필요)
---------------------------------------------
--		유저정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserMaster;
GO

create table dbo.tFVUserMaster(
	--(일반정보)
	idx			int 					IDENTITY(1, 1),
	gameid		varchar(60),
	password	varchar(20),									-- 암호화해서저장, 유저패스워가 해킹당해도 안전
	market		int						default(1),				-- (구매처코드) MARKET_SKT
	buytype		int						default(0),				-- (무료/유료코드)
	platform	int						default(1),				-- (플랫폼)
	ukey		varchar(256),									-- UKey
	version		int						default(101),			-- 클라버젼
	pushid		varchar(256)			default(''),
	phone		varchar(20)				default(''),
	country		int						default(1),				-- 한국(1), 영어(2)

	-- Kakao 정보
	kakaotalkid			varchar(20)		default(''),			-- 카카오톡 해쉬 토크아이디(유니크한 값)
	kakaouserid			varchar(20)		default(''),			--          유저id
	kakaonickname		varchar(40)		default(''),			--          닉네임
	kakaoprofile		varchar(512)	default(''),			--          사진
	kakaomsgblocked		int				default(-1),			--          메시지블럭 (-1:false, 1:true)
	kakaostatus			int				default(1),				--          현재상태(1:진행중, -1:새로하기)

	kakaomsginvitecnt		int			default(0), 			-- 			초대.
	kakaomsginvitetodaycnt	int			default(0),				-- 			오늘 초대인원수.
	kakaomsginvitetodaydate	datetime	default(getdate()),		-- 			오늘 날짜.
	--kakaomsgproudcnt	int				default(0), 			-- 			자랑.
	--kakaomsgheartcnt	int				default(0), 			-- 			하트.
	--kakaomsghelpcnt	int				default(0), 			-- 			도와줘.
	kkopushallow		int				default(1),				-- 			카카오푸쉬
	kkhelpalivecnt		int				default(0),				-- 			카카오로 도움요청으로 살아나는 놈이 있는가? 0 없음, 1 이상이면 있음.

	--(유저정보)
	regdate		datetime				default(getdate()),		-- 최초가입일
	condate		datetime				default(getdate()),		-- (로그인시마다 매번업데이트)
	constate	int						default(1),				-- 0:장기푸쉬미발송, 1:발송
	concnt		int						default(1),				-- 접속횟수
	deletestate	int						default(0),				-- 0 : 삭제상태아님, 1 : 삭제상태
	blockstate	int						default(0),				-- 0 : 블럭상태아님, 1 : 블럭상태
	cashcopy	int						default(0),				-- 캐쉬불법카피시 +1추가된다.
	resultcopy	int						default(0),				-- 로그결과카피시 +1추가된다.
	attenddate	datetime				default(getdate() - 1),		-- 출석일
	attendcnt	int						default(0),				-- 출석횟수(연속), 최대 5일까지만 기록됨
	mboardstate	int						default(0),				-- (0) 미작성, (1) 작성후 지급함

	-- 복귀 정보.
	rtngameid	varchar(20)				default(''),			-- 요청아이디.
	rtndate		datetime				default(getdate() - 1),	-- 요청날짜.
	rtnstep		int						default(-1),			-- 복귀스텝. (-1 : 복귀상태아님), (>=1 : 복귀상태로 진행)
	rtnplaycnt	int						default(0),				-- 복귀플레이카운터(x번째에 복귀선물).

	-- (일반정보2)
	nickname	varchar(20)				default(''),			-- 별칭(닉네임)
	tutorial	int						default(0),				-- 진행번호 기록(0, 1, 2...) old모델.
	tutostep	int						default(5500),			-- 튜토리얼 진행번호 5500 -> 5501 -> ... -1.(미사용)
	comreward	int						default(90106),			-- 경쟁모드번호.
	picture		varchar(128)			default('-1'),
	petlistidx		int					default(-1),			-- 펫 장착된 리스트 번호 없음(-1), 존재(>=0).
	petitemcode		int					default(-1),			--    아이템코드 정보.
	petcooltime		int					default(0),				--    장착하고 지나간 시간.
	pettodayitemcode	int				default(100005),		--    오늘만 판매되는 펫.
	pettodayitemcode2	int				default(100005),		--    			 체험 펫.
	anireplistidx	int					default(0),				-- 대표동물 내부인덱스번호(이번호에 해당하는 tFVUserItem > listidx or 없으면 기본)
	anirepitemcode	int					default(1),				-- 대표동물 아이템코드 및 악세사리 정보.
	anirepacc1		int					default(-1),			--
	anirepacc2		int					default(-1),			--
	anirepmsg	varchar(40)				default('내가 최고'),
	gameyear	int						default(2013),			-- 게임시작 2013년 3월부터 시작(봄)
	gamemonth	int						default(3),				--
	frametime	int						default(0),				-- 한달타임
	tradecnt	int						default(0),				-- 연속거래 성공횟수
	tradefailcnt	int					default(0),				--          실패횟수
	prizecnt	int						default(0),				-- 상장횟수
	tradecntold	int						default(0),				--
	prizecntold	int						default(0),				--
	fame		int						default(0),				-- 명성도
	famebg		int						default(0),				-- 명성도임시백엄
	famelv		int						default(1),				-- 명성도레벨
	famelvbest	int						default(1),
	contestcnt	int						default(0),				-- 대회참여횟수
	farmcnt		int						default(1),				-- 보유농장수
	fevergauge	int						default(0),				-- 피버게이지.
	adidx		int						default(0),				-- 광고번호.
	logindate	varchar(8)				default('20100101'),	-- 로그인일자.
	boardwrite	datetime				default(getdate() - 1),		-- 			오늘 날짜.

	-- 필드정보.
	field0		int						default(1),				-- 필드0 ~ 8번. 미사용(-1), 사용(1)
	field1		int						default(1),				--
	field2		int						default(1),				--
	field3		int						default(1),				--
	field4		int						default(1),				--
	field5		int						default(-1),			--
	field6		int						default(-1),			--
	field7		int						default(-1),			--
	field8		int						default(-1),			--

	--(인벤)
	invenanimalmax		int				default(10),			-- 동물인벤개수	(가입, 로그인 부분도 수정해야함.)
	invenanimalstep		int				default(0),				-- 		   단계.
	invencustommax		int				default(8),				-- 소비인벤개수	(가입, 로그인 부분도 수정해야함.)
	invencustomstep		int				default(0),				-- 		   단계
	invenaccmax			int				default(6),				-- 악세인벤개수	(가입, 로그인 부분도 수정해야함.)
	invenaccstep		int				default(0),				-- 		   단계
	tempitemcode		int				default(-1),			-- 임시아이템 (-1 : 존재안함, > 0 : 특정아이템 코드) > 상인거래후 획득 : 확장팝업 > Yes / No
	tempcnt				int				default(0),				-- 임시아이템갯수

	--(SMS)
	smssendcnt	int						default(0), 			-- SMS발송
	smsjoincnt	int						default(0), 			-- SMS추천후 가입유저카운터

	--(사이버머니)
	cashcost	int						default(5),				-- 500캐쉬
	gamecost	int						default(100),			-- 게임머니
	feed		int						default(20),			-- 건초
	feedmax		int						default(20),			-- 건초Max. 직접 구매시에는 초과할 수 있음.
	fpoint		int						default(100),			-- 우정포인트.
	fpointmax	int						default(500),			-- 99개까지만 모음.
	fmonth		int						default(0),				-- 우정포인트 사용한달(중복사용방지).
	cashpoint	int						default(0),				-- 캐쉬 구매내영.

	--(하트)
	heart		int						default(120),			-- 하트(작물 > 수확 100하트, 친구추천 > 5하트)
	heartmax	int						default(500),			-- 하트맥스
	heartget	int						default(0),				-- 하트받은개수(친구전송, 교배)

	-- (뽑기(중복구매방지))
	randserial	varchar(20)				default('-1'),			--패키지, 뽑기, 합성등 유일한 구매의 랜덤씨리얼
	bgroul1		int						default(-1),			-- 마지막 뽑은것 임시저장하는곳.
	bgroul2		int						default(-1),
	bgroul3		int						default(-1),
	bgroul4		int						default(-1),
	bgroul5		int						default(-1),
	bgroulcnt	int						default(0),				-- 교배 횟수.
	pmroulcnt	int						default(0),				-- 교배 횟수.
	pmticketcnt	int						default(0),				-- 프리미엄 티켓 교배 횟수.
	pmgauage	int						default(0),				-- 프리미엄 게이지.

	trade0		tinyint					default(0),
	trade1		tinyint					default(1),
	trade2		tinyint					default(2),
	trade3		tinyint					default(3),
	trade4		tinyint					default(4),
	trade5		tinyint					default(5),
	trade6		tinyint					default(6),
	tradedummy	tinyint					default(0),				-- 더미공간.

	-- 합성.
	bgcomposeic	int						default(-1),			-- 합성의 성공한 아이템코드값
	bgcomposert	int						default(0),				-- 합성 실패(0), 성공(1)
	bgcomposewt	datetime				default(getdate()), 	-- 합성의 남은시간.
	bgcomposecc	int						default(0),				-- 합성 초기화 비용.

	bgacc1listidx	int					default(-1),
	bgacc2listidx	int					default(-1),
	bgacc1listidxdel	int				default(-1),
	bgacc2listidxdel	int				default(-1),

	-- (악세4개)
	acc1		int						default(-1),			--악세1(-1:빈곳, 아이템코드)
	acc2		int						default(-1),			--악세2(-1:빈곳, 아이템코드)
	acc3		int						default(-1),			--악세3(-1:빈곳, 아이템코드)
	acc4		int						default(-1),			--악세4(-1:빈곳, 아이템코드)

	--(소모착용소모4개)
	bulletlistidx	int					default(-1),			-- 총알(-1:빈곳, 아이템코드)
	vaccinelistidx	int					default(-1),			-- 백신(-1:빈곳, 아이템코드)
	boosterlistidx	int					default(-1),			-- 촉진제(부스터)(-1:빈곳, 아이템코드)
	albalistidx		int					default(-1),			-- 알바(-1:빈곳, 아이템코드)
	--bulletcnt		int					default(0),				--     (장착수량)
	--vaccinecnt	int					default(0),				--     (장착수량)
	--boostercnt	int					default(0),				--     (장착수량)
	--albacnt		int					default(0),				--     (장착수량)
	boosteruse		int					default(-1),			-- 촉진제사용여부(-1:미사용, 1:아이템코드번호)
	albause			int					default(-1),			-- 알바제사용여부(-1:미사용, 1:아이템코드번호)
	albausesecond	int					default(-1),			--
	albausethird	int					default(-1),			--
	wolfappear		int					default(-1),			-- 늑대존재여부(-1:미존재, 1존재)

	--(기본정보4)
	bottlelittle	int					default(0),				--[양동이] 보유량 총리터
	bottlefresh		int					default(0),				--         보유 총신선도
	tanklittle		int					default(0),				--[탱크] 보유량 총리터
	tankfresh		int					default(0),				--       보유 총신선도

	--(시설업글)
	housestep		int					default(0),				--집
	housestate		int					default(-1),			--다음단계진행여부(-1:미진행, 완료중, 1:다음단계진행중)
	housetime		datetime			default(getdate()),		--다음단계시간
	tankstep		int					default(0),				--우유탱크
	tankstate		int					default(-1),			--다음단계진행여부(-1:미진행, 완료중, 1:다음단계진행중)
	tanktime		datetime			default(getdate()),		--다음단계시간
	bottlestep		int					default(0),				--양동이
	bottlestate		int					default(-1),			--다음단계진행여부(-1:미진행, 완료중, 1:다음단계진행중)
	bottletime		datetime			default(getdate()),		--다음단계시간
	pumpstep		int					default(0),				--착유기
	pumpstate		int					default(-1),			--다음단계진행여부(-1:미진행, 완료중, 1:다음단계진행중)
	pumptime		datetime			default(getdate()),		--다음단계시간
	transferstep	int					default(0),				--주입기
	transferstate	int					default(-1),			--다음단계진행여부(-1:미진행, 완료중, 1:다음단계진행중)
	transfertime	datetime			default(getdate()),		--다음단계시간
	purestep		int					default(0),				--정화시설
	purestate		int					default(-1),			--다음단계진행여부(-1:미진행, 완료중, 1:다음단계진행중)
	puretime		datetime			default(getdate()),		--다음단계시간
	freshcoolstep	int					default(0),				--저온보관
	freshcoolstate	int					default(-1),			--다음단계진행여부(-1:미진행, 완료중, 1:다음단계진행중)
	freshcooltime	datetime			default(getdate()),		--다음단계시간

	-- 분기별 자료.
	qtsalebarrel	int					default(0),
	qtsalecoin		int					default(0),
	qtfame			int					default(0),
	qtfeeduse		int					default(0),
	qttradecnt		int					default(0),
	qtsalecoinbest	int					default(0),

	--(경쟁모드) > 클라이언트 필요에 의해 삭제됨.
																-- 업그레이드 	> 로그인.
																-- 획득동물		> 도감.
	bktwolfkillcnt	int					default(0),				-- 누적늑대잡이.
	bktsalecoin		int					default(0),				-- 누적판매금액.
	bkheart			int					default(0),				-- 누적하트획득
	bkfeed			int					default(0),				-- 누적건초획득
	bkbarrel		int					default(0),				-- 누적배럴.
	bktsuccesscnt	int					default(0),				-- 연속성공횟수
	bktbestfresh	int					default(0),				-- 최고신선도
	bktbestbarrel	int					default(0),				-- 최고배럴
	bktbestcoin		int					default(0),				-- 최고판매금액
	bkcrossnormal	int					default(0),				-- 누적일반교배
	bkcrosspremium	int					default(0),				-- 누적프리미엄교배

	--(기타정보)
	param0			int					default(0),				--클라이언트정보.
	param1			int					default(0),
	param2			int					default(0),
	param3			int					default(0),
	param4			int					default(0),
	param5			int					default(0),
	param6			int					default(0),
	param7			int					default(0),
	param8			int					default(0),
	param9			int					default(0),

	-- 학교대항전.
	schoolidx			int				default(-1),		-- 가입한 각교번호.
															-- 남은시간은 매주 일요일 오후 11.59분.
	schoolresult		int				default(-1),		--  1: 읽어라   > 보여주삼. ,
															-- -1: 읽어감	> 이젠 안보여줘도됨.

	-- (랭킹산출용 데이타) > 일주일 데몬에 의해서 정리됨.
	ttsalecoin		int					default(0),				-- 누적판매금액.
	ttsalecoinbkup	bigint				default(0),				-- 누적판매금액백엄(스케쥴에 의해서백업).

	lmsalecoin		int					default(0),				-- 지난 내점수.
	lmrank			int					default(1),				-- 지난 나의 순위.
	lmcnt			int					default(1),				-- 지난 나의 친구들.

	l1gameid		varchar(60)			default(''),			-- 지난 1위 친구.
	l1itemcode		int					default(1),				-- 			대표 동물.
	l1acc1			int					default(-1),			-- 			대표 악세.
	l1acc2			int					default(-1),			-- 			대표 악세.
	l1salecoin		int					default(0),				-- 			점수.
	l1kakaonickname	varchar(40)			default(''),			--          닉네임
	l1kakaoprofile	varchar(512)		default(''),			--          사진
	l2gameid		varchar(60)			default(''),			-- 지난 2위 친구.
	l2itemcode		int					default(1),				-- 			대표 동물.
	l2acc1			int					default(-1),			-- 			대표 악세.
	l2acc2			int					default(-1),			-- 			대표 악세.
	l2salecoin		int					default(0),				-- 			점수.
	l2kakaonickname	varchar(40)			default(''),			--          닉네임
	l2kakaoprofile	varchar(512)		default(''),			--          사진
	l3gameid		varchar(60)			default(''),			-- 지난 3위 친구.
	l3itemcode		int					default(1),				-- 			대표 동물.
	l3acc1			int					default(-1),			-- 			대표 악세.
	l3acc2			int					default(-1),			-- 			대표 악세.
	l3salecoin		int					default(0),				-- 			점수.
	l3kakaonickname	varchar(40)			default(''),			--          닉네임
	l3kakaoprofile	varchar(512)		default(''),			--          사진

	-- 엔딩모드.
	etsalecoin		int					default(0),				-- 에피소드 누적판매금액.
	etremain		int					default(-1),			--	        남은시간.

	-- 이벤트.
	eventspot01		int					default(0),				-- 로그인사용(1~5).
	eventspot02		int					default(0),
	eventspot03		int					default(0),
	eventspot04		int					default(0),
	eventspot05		int					default(0),
	eventspot06		int					default(0),				-- 쿠폰에서 사용.
	eventspot07		int					default(0),				-- 미사용
	eventspot08		int					default(0),				-- 미사용
	eventspot09		int					default(0),				-- 미사용
	eventspot10		int					default(0),				-- 미사용

	-- 영구 누적정보.
																-- 일반 교배 횟수(위에것).
																-- 프리미엄 교배 횟수(위에것).
	bgtradecnt		int					default(0),				-- 거래 성고 누적 횟수.
	bgcomposecnt 	int					default(0),				-- 합성 포인수 누적.(n/100)

	-- 행운의집
	yabauidx		int					default(1),				-- 행운의 집 정보.
	yabaustep		int					default(0),				--
	yabaunum		int					default(0),				--
	yabauresult		int					default(0),				-- 주사위 결과. 0실패, 1성공
	yabaucount		int					default(0),				-- 굴린포인트값.

	-- Constraint
	CONSTRAINT pk_tFVUserMaster_gameid	PRIMARY KEY(gameid)
)
GO
-- alter table dbo.tFVUserMaster add randserial			varchar(20)		default('-1')
-- alter table dbo.tFVUserMaster add invenanimalstep		int				default(0)
-- alter table dbo.tFVUserMaster add invencustomstep		int				default(0)
-- alter table dbo.tFVUserMaster add invenaccstep			int				default(0)
-- alter table dbo.tFVUserMaster add feedmax		int						default(10)
-- 데이타 10만건 강제로 넣어서 쿼리해보기(상상ID로 만든 유저를 입력한다.)
-- 가입시 gameid 쿼리 > PRIMARY KEY(gameid) > 인덱싱



-- 폰인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserMaster_phone_deletestate')
    DROP INDEX tFVUserMaster.idx_tFVUserMaster_phone_deletestate
GO
CREATE INDEX idx_tFVUserMaster_phone_deletestate ON tFVUserMaster (phone, deletestate)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserMaster_idx')
   DROP INDEX tFVUserMaster.idx_tFVUserMaster_idx
GO
CREATE INDEX idx_tFVUserMaster_idx ON tFVUserMaster (idx)
GO

--IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserMaster_kakaonickname')
--   DROP INDEX tFVUserMaster.idx_tFVUserMaster_kakaonickname
--GO
--CREATE INDEX idx_tFVUserMaster_kakaonickname ON tFVUserMaster (kakaonickname)
--GO

-- 카카오회원번호 인덱싱.
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserMaster_kakaouserid')
   DROP INDEX tFVUserMaster.idx_tFVUserMaster_kakaouserid
GO
CREATE INDEX idx_tFVUserMaster_kakaouserid ON tFVUserMaster (kakaouserid)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserMaster_kakaotalkid')
   DROP INDEX tFVUserMaster.idx_tFVUserMaster_kakaotalkid
GO
CREATE INDEX idx_tFVUserMaster_kakaotalkid ON tFVUserMaster (kakaotalkid)
GO


--IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserMaster_pushid')
--    DROP INDEX tFVUserMaster.idx_tFVUserMaster_pushid
--GO
--CREATE INDEX idx_tFVUserMaster_pushid ON tFVUserMaster (pushid)
--GO

-- insert into dbo.tFVUserMaster(gameid, password, market, buytype, platform, ukey, version, pushid, phone) values('xxxx', 'pppp', 1, 0, 1, 'uuuu', 101, 'pushidxxxx', '01011112222')
-- select * from dbo.tFVUserMaster where gameid = 'xxxx' and password = 'pppp'
-- update dbo.tFVUserMaster set market = 1 where gameid = 'xxxx'

---------------------------------------------
--		아이템 보유정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserItem', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserItem;
GO

create table dbo.tFVUserItem(
	idx				int					IDENTITY(1,1),

	gameid			varchar(60),									--
	listidx			int,											-- 리스트인덱스(각개인별로 별개)

	invenkind		int					default(1),					--대분류(가축(1), 소모품(3), 액세서리(4))
	itemcode		int,
	cnt				int					default(1),					--보유량

	farmnum			int					default(-1),				-- 농장번호(-1:농장없음, 0~50:농장번호)
	fieldidx		int					default(-1),				-- 필드(-2:병원, -1:창고, 0~8:필드)
	anistep			int					default(5),					-- 현재단계(0 ~ 12단계)
	manger			int					default(25),				-- 여물통(건초:1 > 여물:20)
	diseasestate	int					default(0),					-- 질병상태(0:노질병, 질병 >=0 걸림)
	acc1			int					default(-1),				-- 악세(모자:아이템코드)
	acc2			int					default(-1),				-- 악세(등:아이템코드)
	abilkind		int					default(-1),				--능력치종류1~5 (90001:신선도, 90002:추가 생산 확률, 90003:피버 드랍 확률, 90004:질병 저항력, 90005;코인 드랍 확률)
	abilval			int					default(0),					--능력치값1~5
	abilkind2		int					default(-1),				--
	abilval2		int					default(0),					--
	abilkind3		int					default(-1),				--
	abilval3		int					default(0),					--
	abilkind4		int					default(-1),				--
	abilval4		int					default(0),					--
	abilkind5		int					default(-1),				--
	abilval5		int					default(0),					--

	randserial		varchar(20)			default('-1'),				--랜던씨리얼(클라이언트에서 만들어서옴)
	writedate		datetime			default(getdate()),			--구매일/획득일
	gethow			int					default(0),					--획득방식(0:구매, 1:경작, 2:교배/뽑기, 3:검색)

	diedate			datetime,
	diemode			int					default(-1),				-- -1:아님, 1:눌러,텨저, 2:늑대
	needhelpcnt		int					default(0),					-- 병원에 있을때 자동 부활용으로 사용된다.(부활석 개수만큼)

	petupgrade		int					default(1),					-- 펫업그레이드 하기.

	-- Constraint
	CONSTRAINT	pk_tFVUserItem_gameid_listidx	PRIMARY KEY(gameid, listidx)
)

--alter table dbo.tFVUserItem add diedate			datetime
--alter table dbo.tFVUserItem add diemode			int					default(-1)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItem_idx')
    DROP INDEX tFVUserItem.idx_tFVUserItem_idx
GO
CREATE INDEX idx_tFVUserItem_idx ON tFVUserItem (idx)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItem_gameid_itemcode')
    DROP INDEX tFVUserItem.idx_tFVUserItem_gameid_itemcode
GO
CREATE INDEX idx_tFVUserItem_gameid_itemcode ON tFVUserItem (gameid, itemcode)
GO

-- select isnull(max(listidx), 0) from dbo.tFVUserItem where gameid = 'xxxx'	--트리거 사용하면 원하지 않는 결과가 나오는군(insert:inserted, update:deleted/inserted, delete:deleted)
-- insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum, fieldidx, category, randserial) values('xxxx', 0, 1, 1, 0, 0, 1, 1001) -- 동물
-- insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum, fieldidx, category, randserial) values('xxxx', 1, 1, 1, 0, 1, 1, 1002) -- 동물
-- insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum, fieldidx, category, randserial) values('xxxx', 2, 1, 1, 0, 2, 1, 1003) -- 동물
-- insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum, fieldidx, category, randserial) values('xxxx', 3, 1, 1, 0, 3, 1, 1004) -- 동물
-- insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum, fieldidx, category, randserial) values('xxxx', 4, 1, 1, 0, 4, 1, 1005) -- 동물
-- insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum, fieldidx, category, randserial) values('xxxx', 5, 1, 1, 0, 5, 1, 1006) -- 동물
-- insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum, fieldidx, category, randserial) values('xxxx', 6, 1, 1, 0, 6, 1, 1007) -- 동물
-- insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum, fieldidx, category, randserial) values('xxxx', 10, 700, 5, 0, 0, 3, 1010) -- 소모
-- insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum, fieldidx, category, randserial) values('xxxx', 20, 1400, 1, 0, 0, 4, 1020) -- 악세
-- select top 1 * from dbo.tFVUserItem where gameid = 'xxxx' and randserial = 1010
-- update dbo.tFVUserItem set fieldidx = 0 where gameid = 'xxxx' and listidx = 1
-- select * from dbo.tFVUserItem where gameid = 'xxxx' and category in (1, 3, 4)


---------------------------------------------
--		아이템 보유정보 > 동물 정보만 삭제백업
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserItemDel', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserItemDel;
GO

create table dbo.tFVUserItemDel(
	idx				int					IDENTITY(1,1),

	gameid			varchar(60),									--
	listidx			int,											-- 리스트인덱스(각개인별로 별개)

	invenkind		int					default(1),					--대분류(가축(1), 소모품(3), 액세서리(4))
	itemcode		int,
	cnt				int					default(1),					--보유량

	farmnum			int					default(-1),				-- 농장번호(-1:농장없음, 0~50:농장번호)
	fieldidx		int					default(-1),				-- 필드(-2:병원, -1:창고, 0~8:필드)
	anistep			int					default(5),					-- 현재단계(0 ~ 12단계)
	manger			int					default(25),				-- 여물통(건초:1 > 여물:20)
	diseasestate	int					default(0),					-- 질병상태(0:노질병, 질병 >=0 걸림)
	acc1			int					default(-1),				-- 악세(모자:아이템코드)
	acc2			int					default(-1),				-- 악세(등:아이템코드)
	abilkind		int					default(-1),				--능력치종류1~5 (90001:신선도, 90002:추가 생산 확률, 90003:피버 드랍 확률, 90004:질병 저항력, 90005;코인 드랍 확률)
	abilval			int					default(0),					--능력치값1~5
	abilkind2		int					default(-1),				--
	abilval2		int					default(0),					--
	abilkind3		int					default(-1),				--
	abilval3		int					default(0),					--
	abilkind4		int					default(-1),				--
	abilval4		int					default(0),					--
	abilkind5		int					default(-1),				--
	abilval5		int					default(0),					--

	randserial		varchar(20)			default(-1),				--랜던씨리얼(클라이언트에서 만들어서옴)
	writedate		datetime			default(getdate()),			--구매일/획득일
	gethow			int					default(0),					--획득방식(0:구매, 1:경작, 2:교배/뽑기, 3:검색)

	diedate			datetime,
	diemode			int					default(-1),				-- -1:아님, 1:눌러,텨저, 2:늑대

	idx2			int,
	writedate2		datetime			default(getdate()),			--삭제일.
	state			int					default(0),					-- 0:병원에서, 1:판매, 2:우편함

	-- Constraint
	CONSTRAINT	pk_tFVUserItemDel_idx	PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItemDel_gameid_idx2')
    DROP INDEX tFVUserItemDel.idx_tFVUserItemDel_gameid_idx2
GO
CREATE INDEX idx_tFVUserItemDel_gameid_idx2 ON tFVUserItemDel (gameid, idx2)
GO


---------------------------------------------
--		경작지
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserSeed', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserSeed;
GO

create table dbo.tFVUserSeed(
	idx				int					IDENTITY(1,1),

	gameid			varchar(60),									--
	seedidx			int					default(0),					-- 0 ~ 11필드인덱스

	itemcode 		int					default(-2),				-- 작물아이템코드, (미구매:-2, 빈곳:-1, 파종:0이상)
	seedstartdate	datetime			default(getdate()),			-- 심은날(아이템 코드 테이블 > 무엇을 줄건인가 기록됨)
	seedenddate		datetime			default(getdate()),			-- 수확일.

	-- Constraint
	CONSTRAINT	pk_tFVUserSeed_gameid_listidx	PRIMARY KEY(gameid, seedidx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserSeed_idx')
    DROP INDEX tFVUserSeed.idx_tFVUserSeed_idx
GO
CREATE INDEX idx_tFVUserSeed_idx ON tFVUserSeed (idx)
GO

-- select * from dbo.tFVUserSeed where gameid = 'xxxx' order by seedidx asc
-- insert into dbo.tFVUserSeed(gameid, seedidx, itemcode) values('xxxx', 0, -2)
-- declare @loop int		set @loop = 1
-- while(@loop <= 11)
--	begin
--		insert into dbo.tFVUserSeed(gameid, seedidx, itemcode) values('xxxx', @loop, -2)
--		set @loop = @loop + 1
--	end
-- select getdate(), DATEADD(ss, 10, getdate()) -- 현재시간 + 10초
-- 구매, 빈상태
--update dbo.tFVUserSeed set itemcode = -1 where gameid = 'xxxx' and seedidx = 8
-- 심기
--update dbo.tFVUserSeed
--	set
--		itemcode = 607,
--		seedstartdate = getdate(),
--		seedenddate = DATEADD(ss, 20, getdate())
--where gameid = 'xxxx' and seedidx = 7
-- 리스트 출력
--select a.*, b.itemname, b.param1, b.param2, b.param5, b.param6
--	from dbo.tFVUserSeed a
--	LEFT JOIN
--	(select * from dbo.tFVItemInfo where subcategory = 7) b
--	ON a.itemcode = b.itemcode
--where gameid = 'xxxx' order by seedidx asc


---------------------------------------------
--		전국목장
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserFarm', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserFarm;
GO

create table dbo.tFVUserFarm(
	idx				int					IDENTITY(1,1),

	gameid			varchar(60),									--
	farmidx			int,											-- 농장번호
	itemcode		int,											-- 아이템코드
	incomedate		datetime			default(getdate()),			-- 회수일.
	incomett		int					default(0),
	buycount		int					default(0),

	buystate 		int					default(-1),				-- 비구매(-1), 구매중(1)
	buydate			datetime			default(getdate()),			-- 구매일.
	buywhere		int					default(1),					-- 1 직접구매, 2 에피소드

	-- Constraint
	CONSTRAINT	pk_tFVUserFarm_gameid_farmidx	PRIMARY KEY(gameid, farmidx)
)
--
-- 이미만들어진것은 커서를 돌면서 입력하기.
-- insert into dbo.tFVUserFarm(gameid, farmidx) select 'xxxx2', itemcode from dbo.tFVItemInfo where subcategory = 69 order by itemcode asc
-- select * from dbo.tFVUserFarm where gameid = 'xxxx2' order by farmidx asc
-- update dbo.tFVUserFarm set buystate =  1 where gameid = 'xxxx2' and farmidx = 6900				-- 구매
-- update dbo.tFVUserFarm set buystate = -1 where gameid = 'xxxx2' and farmidx = 6900				-- 판매
-- update dbo.tFVUserFarm set incomedate = getdate(), incomett = incomett + 100 where gameid = 'xxxx2' and farmidx = 6900	-- 수입
--                   DATEDIFF(datepart , @incomedate , getdate() )
-- select getdate(), DATEDIFF(hh, '2013-11-23 12:00', '2013-11-23 11:00') -- -60	> -1
-- select getdate(), DATEDIFF(hh, '2013-11-23 12:00', '2013-11-23 12:59') -- +59	> 0
-- select getdate(), DATEDIFF(hh, '2013-11-23 12:00', '2013-11-23 13:00') -- +60	> 1
-- select getdate(), DATEDIFF(hh, '2013-11-23 12:00', '2013-11-23 13:01') -- +61	> 1
-- select max(idx) from dbo.tFVUserFarm
--select a.*, b.itemname, b.param1 hourcoin, b.param2 maxcoin, b.param3 raiseyear, b.param4 raisepercent
--	from dbo.tFVUserFarm a
--	LEFT JOIN
--	(select * from dbo.tFVItemInfo where subcategory = 69) b
--	ON a.farmidx = b.itemcode
--where gameid = 'xxxx2' order by farmidx asc

---------------------------------------------
--		아이템 구매 (통합로그)
---------------------------------------------

---------------------------------------------
--		통계자료 (통합로그)
---------------------------------------------


---------------------------------------------
--		거래정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserSaleLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserSaleLog;
GO

create table dbo.tFVUserSaleLog(
	--(일반정보)
	idx			int 					IDENTITY(1, 1),
	idx2		int,

	gameid		varchar(60),
	gameyear	int						default(-1),
	gamemonth	int						default(-1),

	feeduse		int						default(-1),
	playcoin	int						default(-1),
	playcoinmax	int						default(-1),
	fame		int						default(-1),
	famelv		int						default(-1),
	tradecnt	int						default(-1),
	prizecnt	int						default(-1),
	prizecoin	int						default(-1),

	saletrader		int					default(-1),
	saledanga		int					default(-1),
	saleplusdanga	int					default(-1),
	salebarrel		int					default(-1),
	salefresh		int					default(-1),
	salecoin		int					default(-1),
	saleitemcode	int					default(-1),
	plusheart		int					default(0),
	orderbarrel		int					default(0),
	orderfresh		int					default(0),
	milkproduct		int					default(0),

	userinfo		varchar(1024)		default(''),
	aniitem			varchar(2048)		default(''),
	cusitem			varchar(1024)		default(''),
	tradeinfo		varchar(1024)		default(''),

	cashcost	int						default(0),
	gamecost	int						default(0),
	feed		int						default(0),
	fpoint		int						default(0),
	heart		int						default(0),

	writedate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT pk_tFVUserSaleLog_idx	PRIMARY KEY(idx)
)
GO

-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserSaleLog_gameid_gameyear_gamemonth')
    DROP INDEX tFVUserSaleLog.idx_tFVUserSaleLog_gameid_gameyear_gamemonth
GO
CREATE INDEX idx_tFVUserSaleLog_gameid_gameyear_gamemonth ON tFVUserSaleLog (gameid, gameyear, gamemonth)
GO

-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserSaleLog_gameid_idx2')
    DROP INDEX tFVUserSaleLog.idx_tFVUserSaleLog_gameid_idx2
GO
CREATE INDEX idx_tFVUserSaleLog_gameid_idx2 ON tFVUserSaleLog (gameid, idx2)
GO

--select top 1 * from dbo.tFVUserSaleLog where gameid = 'xxxx' and gameyear = '2013' and gamemonth = '4'
--insert into dbo.tFVUserSaleLog(gameid, 		gameyear,   	gamemonth,
--							feeduse, 		playcoin,		playcoinmax,		fame,    		famelv,   		tradecnt,  		prizecnt,
--							saletrader, 	saledanga,		saleplusdanga,		salebarrel,		salefresh,		salecost,	saleitemcode)
--values(						'xxxx', 		2013, 			4,
--							1, 				2,				40,					0, 				1, 				1, 				0,
--							1, 				2, 				3, 					4, 				5, 				6, 				7)



---------------------------------------------
--		저장정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserSaveLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserSaveLog;
GO

create table dbo.tFVUserSaveLog(
	--(일반정보)
	idx			int 					IDENTITY(1, 1),
	idx2		int,

	gameid		varchar(60),
	gameyear		int					default(-1),
	gamemonth		int					default(-1),
	frametime		int					default(-1),

	fevergauge		int					default(-1),
	bottlelittle	int					default(-1),
	bottlefresh		int					default(-1),
	tanklittle		int					default(-1),
	tankfresh		int					default(-1),
	feeduse			int					default(-1),
	boosteruse		int					default(-1),
	albause			int					default(-1),
	albausesecond	int					default(-1),
	albausethird	int					default(-1),
	wolfappear		int					default(-1),
	wolfkillcnt		int					default(-1),

	userinfo		varchar(1024)		default(''),
	aniitem			varchar(2048)		default(''),
	cusitem			varchar(1024)		default(''),

	writedate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT pk_tFVUserSaveLog_idx	PRIMARY KEY(idx)
)
GO

-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserSaveLog_gameid_gameyear_gamemonth_frametime')
    DROP INDEX tFVUserSaveLog.idx_tFVUserSaveLog_gameid_gameyear_gamemonth_frametime
GO
CREATE INDEX idx_tFVUserSaveLog_gameid_gameyear_gamemonth_frametime ON tFVUserSaveLog (gameid, gameyear, gamemonth, frametime)
GO

-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserSaveLog_gameid_idx2')
    DROP INDEX tFVUserSaveLog.idx_tFVUserSaveLog_gameid_idx2
GO
CREATE INDEX idx_tFVUserSaveLog_gameid_idx2 ON tFVUserSaveLog (gameid, idx2)
GO

--select top 1 * from dbo.tFVUserSaveLog where gameid = 'xxxx2' and gameyear = 2013 and gamemonth = 4 and frametime = 12
--select top 1 idx2 from dbo.tFVUserSaveLog where gameid = 'xxxx2' order by idx desc
--insert into dbo.tFVUserSaveLog(
--	idx2,
--	gameid, 		gameyear, 			gamemonth, 			frametime,
--	fevergauge, 	bottlelittle, 		bottlefresh, 		tanklittle,		tankfresh,
--	feeduse,		boosteruse,			albause,			wolfappear,		wolfkillcnt,
--	userinfo,		aniitem,			cusitem
--)
--values(
--	1,
--	'xxxx3', 		2013,				3,      			12,
--	4,       		11,       			101,     			21,     		201,
--	16,  			-1,    			 	-1,  				-1,     		1,
--	'0:2013;1:3;2:13;4:4;10:11;11:101;12:21;13:201;30:16;40:-1;41:-1;42:-1;43:1;',
--	'1:5,1,1;3:5,23,0;4:5,25,-1;',
--	'14:1;15:1;16:1;'
--)


---------------------------------------------
--	비정삭적인 행동을 할려고 하는 유저체킹 > 블럭처리
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserUnusualLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserUnusualLog;
GO

create table dbo.tFVUserUnusualLog(
	idx				int				IDENTITY(1,1),
	gameid			varchar(60), 							-- 행동자
	comment			varchar(512), 							-- 비정상내용
	writedate		datetime		default(getdate()), 	-- 비정상작성일

	chkstate		int				default(0),				-- 확인상태(0:체킹안함, 1:체킹함)
	chkdate			datetime,
	chkcomment		varchar(512), 							-- 확인내용

	-- Constraint
	CONSTRAINT pk_tFVUserUnusualLog_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserUnusualLog_gameid_idx')
    DROP INDEX tFVUserUnusualLog.idx_tFVUserUnusualLog_gameid_idx
GO
CREATE INDEX idx_tFVUserUnusualLog_gameid_idx ON tFVUserUnusualLog(gameid, idx)
GO
-- insert into dbo.tFVUserUnusualLog(gameid, comment) values('x1', '캐쉬카피시도')
-- insert into dbo.tFVUserUnusualLog(gameid, comment) values('x1', '환전카피시도')
-- insert into dbo.tFVUserUnusualLog(gameid, comment) values('x2', '결과조작')
-- select top 20 * from dbo.tFVUserUnusualLog order by idx desc
-- select top 20 * from dbo.tFVUserUnusualLog where gameid = 'sususu' order by idx desc


---------------------------------------------
--	비정삭적인2 행동을 할려고 하는 유저체킹 > 블럭처리
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserUnusualLog2', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserUnusualLog2;
GO

create table dbo.tFVUserUnusualLog2(
	idx				int				IDENTITY(1,1),
	gameid			varchar(60), 							-- 행동자
	comment			varchar(512), 							-- 비정상내용
	writedate		datetime		default(getdate()), 	-- 비정상작성일

	chkstate		int				default(0),				-- 확인상태(0:체킹안함, 1:체킹함)
	chkdate			datetime,
	chkcomment		varchar(512), 							-- 확인내용

	-- Constraint
	CONSTRAINT pk_tFVUserUnusualLog2_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserUnusualLog2_gameid_idx')
    DROP INDEX tFVUserUnusualLog2.idx_tFVUserUnusualLog2_gameid_idx
GO
CREATE INDEX idx_tFVUserUnusualLog2_gameid_idx ON tFVUserUnusualLog2(gameid, idx)
GO
-- insert into dbo.tFVUserUnusualLog2(gameid, comment) values('x1', '캐쉬카피시도')
-- insert into dbo.tFVUserUnusualLog2(gameid, comment) values('x1', '환전카피시도')
-- insert into dbo.tFVUserUnusualLog2(gameid, comment) values('x2', '결과조작')
-- select top 20 * from dbo.tFVUserUnusualLog2 order by idx desc
-- select top 20 * from dbo.tFVUserUnusualLog2 where gameid = 'sususu' order by idx desc


---------------------------------------------
--  로그인 > 유료가입자(1회가입만)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPay', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPay;
GO

create table dbo.tFVUserPay(
	idx			int 				IDENTITY(1, 1),

	phone		varchar(20),
	market		int,

	writedate	datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserPay_idx	PRIMARY KEY(idx)
)
-- phone, market
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserPay_phone_market')
    DROP INDEX tFVUserPay.idx_tFVUserPay_phone_market
GO
CREATE INDEX idx_tFVUserPay_phone_market ON tFVUserPay(phone, market)
GO

-- select * from dbo.tFVUserPay where phone = '01022223333' and market = 1
-- insert into dbo.tFVUserPay(phone, market) values('01022223333', 1)
-- select * from dbo.tFVUserPay where phone = '01022223333'
-- delete from dbo.tFVUserPay where idx = 1


---------------------------------------------
-- 	블럭폰번호 > 가입시 블럭처리자
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserBlockPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserBlockPhone;
GO

create table dbo.tFVUserBlockPhone(
	idx			int 					IDENTITY(1, 1),

	phone			varchar(20),
	comment			varchar(1024),
	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserBlockPhone_phone	PRIMARY KEY(phone)
)

-- insert into dbo.tFVUserBlockPhone(phone, comment) values('01022223333', '아이템카피')
-- insert into dbo.tFVUserBlockPhone(phone, comment) values('01092443174', '환전버그카피')
-- select top 100 * from dbo.tFVUserBlockPhone order by writedate desc
-- select top 1   * from dbo.tFVUserBlockPhone where phone = '01022223333'

-- 센드키 충돌검사
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserBlockPhone_idx')
    DROP INDEX tFVUserBlockPhone.idx_tFVUserBlockPhone_idx
GO
CREATE INDEX idx_tFVUserBlockPhone_idx ON tFVUserBlockPhone (idx)
GO

---------------------------------------------
--		유저 블럭킹
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserBlockLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserBlockLog;
GO

create table dbo.tFVUserBlockLog(
	idx				int				IDENTITY(1,1),
	gameid			varchar(60), 							-- 아이디
	comment			varchar(512), 							-- 시스템코멘트
	writedate		datetime		default(getdate()), 	-- 블록일
	blockstate		int				default(1), 			-- 블럭상태 	0 : 블럭상태아님	1 : 블럭상태

	adminid			varchar(20),
	adminip			varchar(40),
	comment2		varchar(512),							-- 코멘트
	releasedate		datetime								-- 해제일

	-- Constraint
	CONSTRAINT pk_tFVUserBlockLog_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserBlockLog_gameid_idx')
    DROP INDEX tFVUserBlockLog.idx_tFVUserBlockLog_gameid_idx
GO
CREATE INDEX idx_tFVUserBlockLog_gameid_idx ON tFVUserBlockLog(gameid, idx)
GO
-- 블럭 당하는 유저가 중복이 발생할 수 있다. 한번 블럭당하고 또 블럭당한다. 즉 중복 블럭을 당한다.
-- insert into dbo.tFVUserBlockLog(gameid, comment) values(@gameid_, '아이템를 '+ltrim(rtrim(str(@cashcopy)))+'회 이상 카피를 해서 로그인시 시스템에서 블럭 처리했습니다.')
-- update dbo.tFVUserMaster set blockstate = '0' where gameid = 'DD0'
-- update dbo.tFVUserBlockLog set blockstate = 0, adminid = 'SangSang', adminip = '172.0.0.1', comment2 = '풀어주었다.', releasedate = getdate() where idx = 17
-- select * from dbo.tFVUserBlockLog order by idx desc
-- select idx, gameid, comment, writedate, blockstate, adminid, comment2, releasedate from dbo.tFVUserBlockLog order by idx desc
-- select top 20 * from dbo.tFVUserBlockLog where gameid = 'DD0' order by idx desc


---------------------------------------------
--		유저가 삭제 요청에 의한 삭제
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserDeleteLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserDeleteLog;
GO

create table dbo.tFVUserDeleteLog(
	idx				int				IDENTITY(1,1),
	gameid			varchar(60), 							-- 아이디
	comment			varchar(512), 							-- 코멘트
	writedate		datetime		default(getdate()), 	-- 삭제요청
	deletestate		int				default(1), 			-- 삭제상태 0 : 삭제상태아님 1 : 삭제상태

	adminid			varchar(20),
	adminip			varchar(40),
	comment2		varchar(512),							-- 코멘트
	releasedate		datetime								-- 해제일

	-- Constraint
	CONSTRAINT pk_tFVUserDeleteLog_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserDeleteLog_gameid_idx')
    DROP INDEX tFVUserDeleteLog.idx_tFVUserDeleteLog_gameid_idx
GO
CREATE INDEX idx_tFVUserDeleteLog_gameid_idx ON tFVUserDeleteLog(gameid, idx)
GO
-- select * from dbo.tFVUserDeleteLog order by idx desc
-- select * from dbo.tFVUserDeleteLog order by idx desc
-- select top 20 * from dbo.tFVUserDeleteLog where gameid = 'DD0' order by idx desc


---------------------------------------------------
--	(회사공지)
---------------------------------------------------
IF OBJECT_ID (N'dbo.tFVNotice', N'U') IS NOT NULL
	DROP TABLE dbo.tFVNotice;
GO

create table dbo.tFVNotice(
	idx				int				IDENTITY(1,1), 			-- 번호
	market			int				default(1),
	buytype			int				default(0),				-- 무료(0), 유료(1)

	comfile			varchar(512)	default(''),			-- 공지이미지
	comurl			varchar(512)	default(''),			-- 공지URL
	comfile2		varchar(512)	default(''),
	comurl2			varchar(512)	default(''),
	comfile3		varchar(512)	default(''),
	comurl3			varchar(512)	default(''),
	comfile4		varchar(512)	default(''),
	comurl4			varchar(512)	default(''),
	comfile5		varchar(512)	default(''),
	comurl5			varchar(512)	default(''),
	comment			varchar(4096)	default(''),

	version			int				default(101),			--클라이언트버전
	patchurl		varchar(512)	default(''),			--패치URL
	recurl			varchar(512)	default(''),			--게시판URL
	smsurl			varchar(512)	default(''),			--SMSURL (사용안함)
	smscom			varchar(512)	default(''),			--(사용안함)

	iteminfover		int				default(100),			-- 사용안함
	iteminfourl		varchar(512)	default(''),			-- 각URL

	writedate		datetime		default(getdate()), 	-- 작성일
	syscheck		int				default(0),				-- 0:서비스중 	1:점검중

	-- Constraint
	CONSTRAINT	pk_tFVNotice_idx	PRIMARY KEY(idx)
)
--alter table dbo.tFVNotice add smsurl			varchar(512)
--alter table dbo.tFVNotice add smscom			varchar(512)
--IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVNotice_writedate')
--    DROP INDEX tFVNotice.idx_tFVNotice_writedate
--GO
--CREATE INDEX idx_tFVNotice_writedate ON tNotice (writedate)
--GO
--select top 1 * from dbo.tFVNotice where market = 1 order by writedate desc
--select * from dbo.tFVNotice where market = 1 order by writedate desc
--delete from dbo.tFVNotice where idx = 7
--insert into dbo.tFVNotice(market, buytype, comfile, comurl, comfile2, comurl2, comfile3, comurl3, version, patchurl, recurl, syscheck) values(1, 0, 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image01.png', 'http://m.naver.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png', 'http://m.daum.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png', 'http://m.hungryapp.co.kr', 101, 'http://www.ubx.co.kr', 'http://clien.career.co.kr', 1)
--insert into dbo.tFVNotice(market, buytype, comfile, comurl, comfile2, comurl2, comfile3, comurl3, version, patchurl, recurl, syscheck) values(1, 1, 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image01.png', 'http://m.naver.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png', 'http://m.daum.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png', 'http://m.hungryapp.co.kr', 101, 'http://www.ubx.co.kr', 'http://clien.career.co.kr', 1)
--insert into dbo.tFVNotice(market, buytype, comfile, comurl, comfile2, comurl2, comfile3, comurl3, version, patchurl, recurl, syscheck) values(2, 0, 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image01.png', 'http://m.naver.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png', 'http://m.daum.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png', 'http://m.hungryapp.co.kr', 101, 'http://www.ubx.co.kr', 'http://clien.career.co.kr', 1)
--insert into dbo.tFVNotice(market, buytype, comfile, comurl, comfile2, comurl2, comfile3, comurl3, version, patchurl, recurl, syscheck) values(3, 0, 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image01.png', 'http://m.naver.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png', 'http://m.daum.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png', 'http://m.hungryapp.co.kr', 101, 'http://www.ubx.co.kr', 'http://clien.career.co.kr', 1)
--insert into dbo.tFVNotice(market, buytype, comfile, comurl, comfile2, comurl2, comfile3, comurl3, version, patchurl, recurl, syscheck) values(5, 0, 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image01.png', 'http://m.naver.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png', 'http://m.daum.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png', 'http://m.hungryapp.co.kr', 101, 'http://www.ubx.co.kr', 'http://clien.career.co.kr', 1)
--insert into dbo.tFVNotice(market, buytype, comfile, comurl, comfile2, comurl2, comfile3, comurl3, version, patchurl, recurl, syscheck) values(7, 0, 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image01.png', 'http://m.naver.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png', 'http://m.daum.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png', 'http://m.hungryapp.co.kr', 101, 'http://www.ubx.co.kr', 'http://clien.career.co.kr', 1)

---------------------------------------------
--  관리자 정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVAdminUser', N'U') IS NOT NULL
	DROP TABLE dbo.tFVAdminUser;
GO

create table dbo.tFVAdminUser(
	idx				int 				IDENTITY(1, 1),
	gameid			varchar(60),
	password		varchar(20),
	writedate		datetime			default(getdate()),
	grade			int					default(0),

	-- Constraint
	CONSTRAINT	pk_tFVAdminUser_idx	PRIMARY KEY(gameid)
)

--select * from dbo.tFVAdminUser
--insert into tAdminUser(gameid, password) values('blackm', 'a1s2d3f4')

---------------------------------------------
-- 	관리자 정보(행동정보)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVMessageAdmin', N'U') IS NOT NULL
	DROP TABLE dbo.tFVMessageAdmin;
GO

create table dbo.tFVMessageAdmin(
	idx			int					IDENTITY(1,1),
	adminid		varchar(20),
	gameid		varchar(60),
	comment		varchar(1024),

	writedate	datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVMessageAdmin_idx	PRIMARY KEY(idx)
)

-- insert into dbo.tFVMessageAdmin(adminid, gameid, comment) values('black4', 'guest', '골드지급')
-- select top 100 * from dbo.tFVMessageAdmin order by idx desc




---------------------------------------------
-- 	매일통계관리
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVDayLogInfoStatic', N'U') IS NOT NULL
	DROP TABLE dbo.tFVDayLogInfoStatic;
GO

create table dbo.tFVDayLogInfoStatic(
	idx				int				IDENTITY(1,1),

	dateid8			varchar(8),
	market			int				default(1),

	smssendcnt		int				default(0),					-- 일 SMS 전송
	smsjoincnt		int				default(0),					-- 일 SMS 가입

	joinplayercnt	int				default(0),					-- 일 일반가입
	joinguestcnt	int				default(0),					-- 일 일반가입
	joinukcnt		int				default(0),					-- 일 유니크 가입
	logincnt		int				default(0),					-- 일 로그인
	logincnt2		int				default(0),					-- (사용안함)
	invitekakao		int				default(0),					-- 일 카카오 초대.
	kakaoheartcnt	int				default(0),					-- 일 카카오 하트.
	kakaohelpcnt	int				default(0),					-- 일 카카오 도와줘친구야.

	heartusecnt		int				default(0),					-- 일 하트사용수
	freeroulettcnt	int				default(0),					-- 일 무료뽑기
	payroulettcnt	int				default(0),					-- 일 유료뽑기
	revivalcnt		int				default(0),					-- 일 부활수(템)
	revivalcntcash	int				default(0),					-- 일 부활수(캐쉬)
	revivalcntfree	int				default(0),					-- 일 부활수(무료)
	fpointcnt		int				default(0),					-- 일 fpoint(무료)
	rtnrequest		int				default(0),					-- 일 복귀요청수
	rtnrejoin		int				default(0),					-- 일 복귀수

	tradecnt		int				default(0),					-- 일 거래수
	prizecnt		int				default(0),					-- 일 상지급수

	pushandroidcnt	int				default(0),					-- 안드로이드통계.
	pushiphonecnt	int				default(0),					-- 아이폰통계.

	contestcnt		int				default(0),					-- 일 대회참여수
	certnocnt		int				default(0),					-- 일 쿠폰등록수.

	-- Constraint
	CONSTRAINT	pk_tFVDayLogInfoStatic_idx	PRIMARY KEY(idx)
)
-- alter table dbo.tFVDayLogInfoStatic add certnocnt		int				default(0)
-- alter table dbo.tFVDayLogInfoStatic add revivalcnt		int				default(0)
-- alter table dbo.tFVDayLogInfoStatic add revivalcntcash	int				default(0)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVDayLogInfoStatic_dateid8_market')
    DROP INDEX tFVDayLogInfoStatic.idx_tFVDayLogInfoStatic_dateid8_market
GO
CREATE INDEX idx_tFVDayLogInfoStatic_dateid8_market ON tFVDayLogInfoStatic(dateid8, market)
GO

-- insert into dbo.tFVDayLogInfoStatic(dateid8) values('20130827')
-- select top 100 * from dbo.tFVDayLogInfoStatic order by idx desc


---------------------------------------------
--		아이템 보유정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVGiftList', N'U') IS NOT NULL
	DROP TABLE dbo.tFVGiftList;
GO

create table dbo.tFVGiftList(
	idx			bigint				IDENTITY(1,1),
	idx2		int,

	gameid		varchar(60),									-- gameid별 itemcode는 중복이 발생한다.
	giftkind	int					default(0),					-- 1:메시지, 2:선물, -1:메시지삭제, -2:선물받아감

	message		varchar(256)		default(''), 				-- 메세지(1)

	itemcode	int					default(-1),				-- 선물(2)
	gainstate	int					default(0),					-- 가져간상태	0:안가져감, 1:가져감
	gaindate	datetime, 										-- 가져간날
	giftid		varchar(60)			default('SangSang'),		-- 선물한 유저
	giftdate	datetime			default(getdate()), 		-- 선물일

	-- Constraint
	CONSTRAINT	pk_tFVGiftList_idx	PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVGiftList_gameid_idx')
    DROP INDEX tFVGiftList.idx_tFVGiftList_gameid_idx
GO
CREATE INDEX idx_tFVGiftList_gameid_idx ON tFVGiftList (gameid, idx)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVGiftList_gameid_idx2')
    DROP INDEX tFVGiftList.idx_tFVGiftList_gameid_idx2
GO
CREATE INDEX idx_tFVGiftList_gameid_idx2 ON tFVGiftList (gameid, idx2)
GO



-- select * from dbo.tFVGiftList where gameid = 'xxxx' order by idx desc
-- insert into dbo.tFVGiftList(gameid, giftkind, message) values('xxxx', 1, 'Shot message');
-- insert into dbo.tFVGiftList(gameid, giftkind, itemcode, giftid) values('xxxx', 2, 1, 'SangSang');


---------------------------------------------
--	유니크 가입현황파악하기
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPhone;
GO

create table dbo.tFVUserPhone(
	idx					int 				IDENTITY(1, 1),

	phone				varchar(20),
	market				int					default(1),
	joincnt				int					default(1),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserPhone_idx	PRIMARY KEY(idx)
)
-- 폰인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserPhone_phone')
    DROP INDEX tFVUserPhone.idx_tFVUserPhone_phone
GO
CREATE INDEX idx_tFVUserPhone_phone ON tFVUserPhone (phone)
GO
-- select top 1 * from dbo.tFVUserPhone



---------------------------------------------
--		구매했던 로그(개인)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserItemBuyLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserItemBuyLog;
GO

create table dbo.tFVUserItemBuyLog(
	idx			int					IDENTITY(1,1), 					-- 번호
	idx2		int,

	gameid		varchar(60), 										-- 유저id
	itemcode	int, 												-- 아이템코드, 중복 구매기록한다.
	buydate2	varchar(8),											-- 구매일20131010
	cnt			int					default(1), 					--

	cashcost	int					default(0), 					-- 구매가격(세일할수있어서)
	gamecost	int					default(0),
	buydate		datetime			default(getdate()), 			-- 구매일

	-- Constraint
	CONSTRAINT	pk_tFVUserItemBuyLog_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tFVUserItemBuyLog
--select top 20 * from dbo.tFVUserItemBuyLog a join dbo.tFVItemInfo b on a.itemcode = b.itemcode where gameid = 'xxxx' order by a.idx desc
--select top 20 a.idx 'idx', gameid, a.itemcode 'itemcode', a.cashcost 'cashcost', a.gamecost 'gamecost', a.buydate, b.itemname, b.gamecost 'coinball2', b.cashcost 'milkball2', b.period, b.explain from dbo.tFVUserItemBuyLog a join dbo.tFVItemInfo b on a.itemcode = b.itemcode where gameid = 'SangSang' order by a.idx desc
--select top 20 * from dbo.tFVUserItemBuyLog where buydate between '2012-08-09 00:00:01' and '2012-08-10 00:00:01' order by idx desc
--insert into dbo.tFVUserItemBuyLog(gameid, itemcode, cashcost, gamecost) values('xxxx', 1, 5,  0)
--insert into dbo.tFVUserItemBuyLog(gameid, itemcode, cashcost, gamecost) values('xxxx', 1, 0, 50)
--통계용 인덱스
--IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItemBuyLog_buydate')
--    DROP INDEX tFVUserItemBuyLog.idx_tFVUserItemBuyLog_buydate
--GO
--CREATE INDEX idx_tFVUserItemBuyLog_buydate ON tFVUserItemBuyLog (buydate)
--GO

--유저 검색용 인덱스
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItemBuyLog_gameid_idx')
    DROP INDEX tFVUserItemBuyLog.idx_tFVUserItemBuyLog_gameid_idx
GO
CREATE INDEX idx_tFVUserItemBuyLog_gameid_idx ON tFVUserItemBuyLog (gameid, idx)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItemBuyLog_gameid_idx2')
    DROP INDEX tFVUserItemBuyLog.idx_tFVUserItemBuyLog_gameid_idx2
GO
CREATE INDEX idx_tFVUserItemBuyLog_gameid_idx2 ON tFVUserItemBuyLog (gameid, idx2)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItemBuyLog_gameid_buydate2_itemcode')
    DROP INDEX tFVUserItemBuyLog.idx_tFVUserItemBuyLog_gameid_buydate2_itemcode
GO
CREATE INDEX idx_tFVUserItemBuyLog_gameid_buydate2_itemcode ON tFVUserItemBuyLog (gameid, buydate2, itemcode)
GO


---------------------------------------------
-- 	구매했던 로그(월별 Master)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserItemBuyLogTotalMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserItemBuyLogTotalMaster;
GO

create table dbo.tFVUserItemBuyLogTotalMaster(
	idx				int				identity(1, 1),
	dateid8			char(8),							-- 20101210

	cashcost		bigint			default(0),
	gamecost		bigint			default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tFVUserItemBuyLogTotalMaster_dateid	PRIMARY KEY(dateid8)
)
-- select         * from dbo.tFVUserItemBuyLogTotalMaster
-- select top 1   * from dbo.tFVUserItemBuyLogTotalMaster where dateid8 = '20120818'
-- insert into dbo.tFVUserItemBuyLogTotalMaster(dateid8, gamecost, cashcost, cnt) values('20120818', 100, 0, 1)
--update dbo.tFVUserItemBuyLogTotalMaster
--	set
--		gamecost = gamecost + 1,
--		cashcost = cashcost + 1,
--		cnt = cnt + 1
--where dateid8 = '20120818'


---------------------------------------------
-- 	구매했던 로그(월별 Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserItemBuyLogTotalSub', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserItemBuyLogTotalSub;
GO

create table dbo.tFVUserItemBuyLogTotalSub(
	idx				int				identity(1, 1),

	dateid8			char(8),							-- 20101210
	itemcode		int,

	cashcost		int				default(0),
	gamecost		int				default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tFVUserItemBuyLogTotalSub_dateid8_itemcode	PRIMARY KEY(dateid8, itemcode)
)
-- select top 100 * from dbo.tFVUserItemBuyLogTotalSub order by dateid8 desc, itemcode desc
-- select         * from dbo.tFVUserItemBuyLogTotalSub where dateid8 = '20120818'
-- select top 1   * from dbo.tFVUserItemBuyLogTotalSub where dateid8 = '20120818' and itemcode = 1
--update dbo.tFVUserItemBuyLogTotalSub
--	set
--		gamecost = gamecost + 1,
--		cashcost = cashcost + 1,
--		cnt = cnt + 1
--where dateid8 = '20120818' and itemcode = 1
-- insert into dbo.tFVUserItemBuyLogTotalSub(dateid8, itemcode, cashcost, gamecost, cnt) values('20120818', 1, 100, 0, 1)


---------------------------------------------
-- 	구매했던 로그(월별 누적)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserItemBuyLogMonth', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserItemBuyLogMonth;
GO

create table dbo.tFVUserItemBuyLogMonth(
	idx				int				identity(1, 1),

	dateid6			char(6),							-- 201012
	itemcode		int,

	cashcost		bigint			default(0),
	gamecost		bigint			default(0),
	cnt				int				default(0),

	-- Constraint
	CONSTRAINT	pk_tFVUserItemBuyLogMonth_dateid6_itemcode	PRIMARY KEY(dateid6, itemcode)
)
-- select top 100 * from dbo.tFVUserItemBuyLogMonth order by dateid6 desc, itemcode desc
-- select         * from dbo.tFVUserItemBuyLogMonth where dateid6 = '201309'
-- select top 1   * from dbo.tFVUserItemBuyLogMonth where dateid6 = '201309' and itemcode = 1
-- insert into dbo.tFVUserItemBuyLogMonth(dateid6, itemcode, gamecost, cashcost, cnt) values('201309', 1, 100, 0, 1)
--update dbo.tFVUserItemBuyLogMonth
--	set
--		gamecost = gamecost + 1,
--		cashcost = cashcost + 1,
--		cnt = cnt + 1
--where dateid6 = '201309' and itemcode = 1



---------------------------------------------
-- 	캐쉬관련(개인로그)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVCashLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVCashLog;
GO

create table dbo.tFVCashLog(
	idx				int				identity(1, 1),
	gameid			varchar(60)		not null, 				-- 구매자
	gameyear		int				default(2013),			-- 게임시작 2013년 3월부터 시작(봄)
	gamemonth		int				default(3),				--
	famelv			int				default(1),

	giftid			varchar(60), 							-- 선물받은사람
	acode			varchar(256), 							-- 승인코드() 사용안함.ㅠㅠ
	ucode			varchar(256), 							-- 승인코드

	ikind			varchar(256),							-- 아이폰, Google 종류(SandBox, Real, GoogleID)
	idata			varchar(4096),							-- 아이폰에서 사용되는 데이타(원본)
	idata2			varchar(4096),							-- 아이폰에서 사용되는 데이타(해석본)

	cashcost		int				default(0), 			-- 충전골든볼
	cash			int				default(0),				-- 구매현금
	writedate		datetime		default(getdate()), 	-- 구매일
	market			int				default(1),				-- (구매처코드) MARKET_SKT

	kakaouserid		varchar(20)		default(''),			--          유저id
	kakaouk			varchar(19)		default(''),			--          유저id

	kakaosend		int				default(-1),			-- 미전송(-1) -> 전송(1)

	-- Constraint
	CONSTRAINT	pk_tFVCashLog_idx	PRIMARY KEY(idx)
)
--직접 clustered를 안한 이유는 쓰기는 idx로 하고 검색을 ucode > idx를 통해서 하도록 설정
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVCashLog_ucode')
    DROP INDEX tFVCashLog.idx_tFVCashLog_ucode
GO
CREATE INDEX idx_tFVCashLog_ucode ON tCashLog (ucode)
GO
--유저로그검색
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVCashLog_gameid')
    DROP INDEX tFVCashLog.idx_tFVCashLog_gameid
GO
CREATE INDEX idx_tFVCashLog_gameid ON tCashLog (gameid)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVCashLog_acode')
    DROP INDEX tFVCashLog.idx_tFVCashLog_acode
GO
CREATE INDEX idx_tFVCashLog_acode ON tCashLog (acode)
GO
--insert into dbo.tFVCashLog(gameid, acode, ucode, cashcost, cash) values('xxxx', 'xxx', '12345778998765442bcde3123192915243184254', 10, 1000)
--select * from dbo.tFVCashLog where ucode = '12345778998765442bcde3123192915243184254'

---------------------------------------------
-- 	캐쉬구매Total
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVCashTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tFVCashTotal;
GO

create table dbo.tFVCashTotal(
	idx				int				identity(1, 1),
	dateid			char(8),								-- 20101210
	cashkind		int,
	market			int				default(1),				-- (구매처코드) MARKET_SKT

	cashcost		int				default(0), 			-- 총판매량
	cash			int				default(0), 			-- 총판매량
	cnt				int				default(1),				--증가회수
	-- Constraint
	CONSTRAINT	pk_tFVCashTotal_dateid_market	PRIMARY KEY(dateid, cashkind, market)
)
-- insert into dbo.tFVCashTotal(dateid, cashkind, market, cashcost, cash) values('20120818', 2000, 1, 21, 2000)
-- insert into dbo.tFVCashTotal(dateid, cashkind, market, cashcost, cash) values('20120818', 5000, 1, 55, 5000)
-- select top 1 * from dbo.tFVCashTotal where dateid = '20120818' and cashkind = 2000 and market = 1
-- update dbo.tFVCashTotal set cashcost = cashcost + 21, cash = cash + 2000, cnt = cnt + 1 where dateid = '20120818' and cashkind = 2000 and market = 1


---------------------------------------------
-- 	캐쉬환전로그
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVCashChangeLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVCashChangeLog;
GO

create table dbo.tFVCashChangeLog(
	idx				int				identity(1, 1),
	gameid			varchar(60)		not null, 				-- 구매자
	cashcost		int, 									-- 환전골드
	gamecost		int, 									-- 환전실버
	writedate		datetime		default(getdate()),		-- 환전일

	-- Constraint
	CONSTRAINT	pk_tFVCashChangeLog_idx	PRIMARY KEY(idx)
)
--캐쉬환전인덱스
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVCashChangeLog_gameid_idx')
    DROP INDEX tFVCashChangeLog.idx_tFVCashChangeLog_gameid_idx
GO
CREATE INDEX idx_tFVCashChangeLog_gameid_idx ON tCashChangeLog (gameid, idx desc)
GO

-- insert into dbo.tFVCashChangeLog(gameid, cashcost, gamecost) values('SangSang', 10, 1000)
-- insert into dbo.tFVCashChangeLog(gameid, cashcost, gamecost) values('SangSang', 20, 2000)
-- insert into dbo.tFVCashChangeLog(gameid, cashcost, gamecost) values('SangSang', 30, 3000)
-- insert into dbo.tFVCashChangeLog(gameid, cashcost, gamecost) values('SangSang', 40, 4000)
-- insert into dbo.tFVCashChangeLog(gameid, cashcost, gamecost) values('DD0', 10, 1000)
-- select * from dbo.tFVCashChangeLog where gameid = 'SangSang' order by idx desc



---------------------------------------------
-- 	캐쉬환전토탈
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVCashChangeLogTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tFVCashChangeLogTotal;
GO

create table dbo.tFVCashChangeLogTotal(
	idx				int				identity(1, 1),
	dateid			char(8),							-- 20101210

	cashcost		int				default(0),
	gamecost		int				default(0),

	changecnt		int				default(1),

	-- Constraint
	CONSTRAINT	pk_tFVCashChangeLogTotal_dateid	PRIMARY KEY(dateid)
)
-- select top 100 * from dbo.tFVCashChangeLogTotal order by dateid desc
-- select top 1 * from dbo.tFVCashChangeLogTotal where dateid = '20120818'
-- insert into dbo.tFVCashChangeLogTotal(dateid, cashcost, gamecost, changecnt) values('20120818', 10, 1000, 1)
--update dbo.tFVCashChangeLogTotal
--	set
--		cashcost = cashcost + 10,
--		gamecost = gamecost + 10000,
--		changecnt = changecnt + 1
--where dateid = '20120818'

-- 192.168.0.11 / game4farm / a1s2d3f4



---------------------------------------------
--		친구
-- 	삭제는 진짜 삭제
--	친구는 100명까지만
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserFriend', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserFriend;
GO

create table dbo.tFVUserFriend(
	idx				int				IDENTITY(1,1),
	gameid			varchar(60)		NOT NULL,

	friendid		varchar(20)		NOT NULL, 				-- 친구아이디
	familiar		int				default(1), 			-- 친밀도(교배+1)
	state			int				default(0),				-- 친구신청(0), 친구대기(1), 친구수락(2)
	senddate		datetime		default(getdate()),		-- 하트보낸날 1일후에 다시 보낸수 있음.
	kakaofriendkind	int				default(1),				-- 게임친구(1), 카카오친구(2)
	helpdate		datetime		default(getdate() - 1),	-- 친구가 도와줘 요청을 할 경우(동물).
	rentdate		datetime		default(getdate() - 1),	-- 친구동물을 빌려서 사용하기.

	writedate		datetime		default(getdate()), 	-- 등록일
	-- Constraint
	CONSTRAINT pk_tFVUserFriend_gameid_friendid	PRIMARY KEY(gameid, friendid)
)

--암기 > 포인트
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserFriend_gameid_familiar')
    DROP INDEX tFVUserFriend.idx_tFVUserFriend_gameid_familiar
GO
CREATE INDEX idx_tFVUserFriend_gameid_familiar ON tFVUserFriend(gameid, familiar desc)
GO

-- xxxx > 친구들
--insert into dbo.tFVUserFriend(gameid, friendid) values('xxxx', 'xxxx2')
--insert into dbo.tFVUserFriend(gameid, friendid) values('xxxx', 'xxxx3')
--insert into dbo.tFVUserFriend(gameid, friendid) values('xxxx', 'xxxx4')
--insert into dbo.tFVUserFriend(gameid, friendid) values('xxxx', 'xxxx5')

--select * from dbo.tFVUserFriend where gameid = 'xxxx'
--select * from dbo.tFVUserFriend where gameid = 'xxxx' order by familiar desc
--update dbo.tFVUserFriend set familiar = familiar + 1 where gameid = @gameid_ and friendid = @friendid_


---------------------------------------------
--		게시판 정보(글쓰기에 우선순위를 올림).
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserBoard', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserBoard;
GO

create table dbo.tFVUserBoard(
	idx			int					IDENTITY(1,1),

	idx2		int,
	kind		int					default(1),					-- 1:일반게시판광고, 2:친추게시판광고, 3:대항게시판광고

	gameid		varchar(60),
	message		varchar(256)		default(''),
	writedate	datetime			default(getdate()), 		-- 선물일

	schoolidx	int					default(-1),

	-- Constraint
	CONSTRAINT	pk_tFVUserBoard_idx2_kind	PRIMARY KEY(idx)
)
-- 폰인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserBoard_idx2_kind')
    DROP INDEX tFVUserBoard.idx_tFVUserBoard_idx2
GO
CREATE INDEX idx_tFVUserBoard_idx2_kind ON tFVUserBoard (idx2, kind)
GO

-- insert into dbo.tFVUserBoard(kind, idx2, gameid, message) values(1, 1, 'xxxx2', '일반게시판광고')
-- insert into dbo.tFVUserBoard(kind, idx2, gameid, message) values(2, 1, 'xxxx2', '친추게시판광고')
-- insert into dbo.tFVUserBoard(kind, idx2, gameid, message) values(3, 1, 'xxxx2', '대항게시판광고')
-- select top 5 * from dbo.tFVUserBoard where kind = 1 order by idx2 desc
-- select top 5 * from dbo.tFVUserBoard where kind = 2 order by idx2 desc
-- select top 5 * from dbo.tFVUserBoard where kind = 3 order by idx2 desc

---------------------------------------------
--		펫도감 : 개인도감
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVDogamListPet', N'U') IS NOT NULL
	DROP TABLE dbo.tFVDogamListPet;
GO

create table dbo.tFVDogamListPet(
	idx				int				IDENTITY(1,1),

	gameid			varchar(60),
	itemcode		int,
	getdate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT pk_tFVDogamListPet_idx	PRIMARY KEY(idx)
)

-- gameid, itemcode
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVDogamListPet_gameid_itemcode')
	DROP INDEX tFVDogamListPet.idx_tFVDogamListPet_gameid_itemcode
GO
CREATE INDEX idx_tFVDogamListPet_gameid_itemcode ON tFVDogamListPet (gameid, itemcode)
GO

--if(not exists(select top 1 * from dbo.tFVDogamListPet where gameid = 'xxxx' and itemcode = 1))
--	begin
--		insert into dbo.tFVDogamListPet(gameid, itemcode) values('xxxx', 1)
--	end
--select * from dbo.tFVDogamListPet where gameid = 'xxxx' order by itemcode asc


---------------------------------------------
--		동물도감 : 개인도감
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVDogamList', N'U') IS NOT NULL
	DROP TABLE dbo.tFVDogamList;
GO

create table dbo.tFVDogamList(
	idx				int				IDENTITY(1,1),

	gameid			varchar(60),
	itemcode		int,
	getdate			datetime		default(getdate()),
	--cnt			int				default(0),

	-- Constraint
	CONSTRAINT pk_tFVDogamList_idx	PRIMARY KEY(idx)
)

-- gameid, itemcode
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVDogamList_gameid_itemcode')
	DROP INDEX tFVDogamList.idx_tFVDogamList_gameid_itemcode
GO
CREATE INDEX idx_tFVDogamList_gameid_itemcode ON tFVDogamList (gameid, itemcode)
GO

--if(not exists(select top 1 * from dbo.tFVDogamList where gameid = 'xxxx' and itemcode = 1))
--	begin
--		insert into dbo.tFVDogamList(gameid, itemcode) values('xxxx', 1)
--	end
--select * from dbo.tFVDogamList where gameid = 'xxxx' order by itemcode asc

---------------------------------------------
--		도감 : 보상정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVDogamReward', N'U') IS NOT NULL
	DROP TABLE dbo.tFVDogamReward;
GO

create table dbo.tFVDogamReward(
	idx				int				IDENTITY(1,1),

	gameid			varchar(60),
	dogamidx		int,
	getdate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT pk_tFVDogamReward_idx	PRIMARY KEY(idx)
)

-- gameid, dogamidx
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVDogamReward_gameid_dogamidx')
	DROP INDEX tFVDogamReward.idx_tFVDogamReward_gameid_dogamidx
GO
CREATE INDEX idx_tFVDogamReward_gameid_dogamidx ON tFVDogamReward (gameid, dogamidx)
GO

--if(not exists(select top 1 * from dbo.tFVDogamReward where gameid = 'xxxx' and dogamidx = 1))
--	begin
--		insert into dbo.tFVDogamReward(gameid, dogamidx) values('xxxx', 1)
--	end
--select * from dbo.tFVDogamReward where gameid = 'xxxx' order by dogamidx asc

---------------------------------------------
--		도감 : 도감 라이브 러리 > [gameinfo테이블 참조]
---------------------------------------------
-- declare @ITEM_MAINCATEGORY_DOGAM			int					set @ITEM_MAINCATEGORY_DOGAM 				= 818 	--도감(818)
--
-- select *  from dbo.tFVItemInfo where subcategory = @ITEM_MAINCATEGORY_DOGAM
-- select param1 dogamidx, itemname dogamname, param2 dogam01, param3 dogam02, param4 dogam03, param5 dogam04, param6 dogam05, param7 dogam06, param8 rewarditemcode, param9 cnt  from dbo.tFVItemInfo where subcategory = @ITEM_MAINCATEGORY_DOGAM


---------------------------------------------
--		경쟁모드 보상(기록된것은 보상 받은것)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVComReward', N'U') IS NOT NULL
	DROP TABLE dbo.tFVComReward;
GO

create table dbo.tFVComReward(
	idx				int				IDENTITY(1,1),

	gameid			varchar(60),
	idx2			int,
	itemcode		int,
	getdate			datetime		default(getdate()),
	ispass			int				default(-1),

	gameyear		int,
	gamemonth		int,
	famelv			int,

	-- Constraint
	CONSTRAINT pk_tFVComReward_idx	PRIMARY KEY(idx)
)

-- gameid, itemcode
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVComReward_gameid_itemcode')
	DROP INDEX tFVComReward.idx_tFVComReward_gameid_itemcode
GO
CREATE INDEX idx_tFVComReward_gameid_itemcode ON tFVComReward (gameid, itemcode)
GO

-- gameid, idx2
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVComReward_gameid_idx2')
	DROP INDEX tFVComReward.idx_tFVComReward_gameid_idx2
GO
CREATE INDEX idx_tFVComReward_gameid_idx2 ON tFVComReward (gameid, idx2)
GO

--if(not exists(select top 1 * from dbo.tFVComReward where gameid = 'xxxx' and itemcode = 1))
--	begin
--		insert into dbo.tFVComReward(gameid, itemcode) values('xxxx', 1)
--	end
--select * from dbo.tFVComReward where gameid = 'xxxx' order by itemcode asc


---------------------------------------------
--		에피소드 보상(기록된것은 보상 받은것)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEpiReward', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEpiReward;
GO

create table dbo.tFVEpiReward(
	idx				int				IDENTITY(1,1),

	gameid			varchar(60),
	itemcode		int,

	etyear			int,
	etsalecoin		int 			default(0),
	etcheckvalue1	int 			default(-1),
	etcheckvalue2	int 			default(-1),
	etcheckvalue3	int 			default(-1),

	etcheckresult1	int				default(0),
	etcheckresult2	int				default(0),
	etcheckresult3	int				default(0),

	etgrade			int				default(0),
	etreward1		int				default(-1),
	etreward2		int				default(-1),
	etreward3		int				default(-1),
	etreward4		int				default(-1),

	getdate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT pk_tFVEpiReward_idx	PRIMARY KEY(idx)
)

-- gameid, itemcode
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEpiReward_gameid_etyear')
	DROP INDEX tFVEpiReward.idx_tFVEpiReward_gameid_etyear
GO
CREATE INDEX idx_tFVEpiReward_gameid_etyear ON tFVEpiReward (gameid, etyear)
GO

--if(not exists(select top 1 * from dbo.tFVEpiReward where gameid = 'xxxx2' and etyear = 2018))
--	begin
--		insert into dbo.tFVEpiReward(gameid, itemcode, etyear, etsalecoin, etgrade, etreward1, etreward2, etreward3, etreward4) values('xxxx2', 91000, 2018, 1000, 0, -1, -1, -1, -1)
--	end
--select * from dbo.tFVEpiReward where gameid = 'xxxx2' order by itemcode asc

---------------------------------------------
--	튜토리얼(중간중간) 모드 보상(기록된것은 보상 받은것)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVTutoStep', N'U') IS NOT NULL
	DROP TABLE dbo.tFVTutoStep;
GO

create table dbo.tFVTutoStep(
	idx				int				IDENTITY(1,1),

	gameid			varchar(60),
	itemcode		int,
	getdate			datetime		default(getdate()),
	ispass			int				default(-1),

	gameyear		int,
	gamemonth		int,
	famelv			int,

	-- Constraint
	CONSTRAINT pk_tFVTutoStep_idx	PRIMARY KEY(idx)
)

-- gameid, itemcode
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVTutoStep_gameid_itemcode')
	DROP INDEX tFVTutoStep.idx_tFVTutoStep_gameid_itemcode
GO
CREATE INDEX idx_tFVTutoStep_gameid_itemcode ON tTutoStep (gameid, itemcode)
GO

--if(not exists(select top 1 * from dbo.tFVTutoStep where gameid = 'xxxx' and itemcode = 1))
--	begin
--		insert into dbo.tFVTutoStep(gameid, itemcode) values('xxxx', 1)
--	end
--select * from dbo.tFVTutoStep where gameid = 'xxxx' order by itemcode asc

---------------------------------------------
--	로그인 현황, 플레이 현황
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVStaticTime', N'U') IS NOT NULL
	DROP TABLE dbo.tFVStaticTime;
GO

create table dbo.tFVStaticTime(
	idx					int 				IDENTITY(1, 1),

	dateid10			varchar(10),
	market				int					default(1),				-- (구매처코드) MARKET_SKT

	logincnt			int					default(0),
	playcnt				int					default(0),

	-- Constraint
	CONSTRAINT	pk_tFVStaticTime_dateid10_market	PRIMARY KEY(dateid10, market)
)
-- select top 1 * from dbo.tFVStaticTime

---------------------------------------------
-- 시스템 업그레이드 정보
-- 시설 업그레이드 맥스 정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSystemInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSystemInfo;
GO

create table dbo.tFVSystemInfo(
	idx					int 				IDENTITY(1, 1),

	-- 업글정보
	housestepmax		int					default(0),
	tankstepmax			int					default(0),
	bottlestepmax		int					default(0),
	pumpstepmax			int					default(0),
	transferstepmax		int					default(0),
	purestepmax			int					default(0),
	freshcoolstepmax	int					default(0),

	-- 인벤정보
	invenstepmax		int					default(0),
	invencountmax		int					default(0),
	seedfieldmax		int					default(0),

	-- 필드오픈정보.
	field5lv			int					default(3),
	field6lv			int					default(6),
	field7lv			int					default(9),
	field8lv			int					default(12),

	-- 캐쉬구매, 환전.
	pluscashcost		int					default(0),	-- 별도 캐쉬구매.
	plusgamecost		int					default(0),	-- 아이템 구매.
	plusheart			int					default(0),	-- 아이템 구매.
	plusfeed			int					default(0), -- 사용안함.

	-- 출석보상 코드값
	attend1				int					default(900),
	attend2				int					default(5111),
	attend3				int					default(5112),
	attend4				int					default(5113),
	attend5				int					default(5007),

	-- 액세사리 가격.
	roulaccprice		int					default(10),	-- 액세사리 수정 가격
	roulaccsale			int					default(10),	-- 액세사리 할인률

	-- 동물합성 할인가격.
	composesale			int					default(0),

	-- iPhone쿠폰 입력참 보이기 안보이기.
	iphonecoupon		int					default(0),		-- 0:안보임, 1:보임

	-- 친구초대 보상템.
	kakaoinvite01		int					default(2000),
	kakaoinvite02		int					default(1005),
	kakaoinvite03		int					default(6),
	kakaoinvite04		int					default(100003),

	-- 장기미접속자 처리상태.
	rtnflag				int					default(0),		-- 0:OFF, 1:ON

	--코멘트.
	comment				varchar(256)		default(''),

	writedate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVSystemInfo_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tFVSystemInfo

--alter table dbo.tFVSystemInfo add urgency			int					default(3)
--alter table dbo.tFVSystemInfo add plusheart			int					default(0)
--alter table dbo.tFVSystemInfo add plusfeed			int					default(0)
--alter table dbo.tFVSystemInfo add pluscashcost		int					default(0)
--alter table dbo.tFVSystemInfo add plusgamecost		int					default(0)
--alter table dbo.tFVSystemInfo add comment			varchar(256)		default('')
--alter table dbo.tFVSystemInfo add 	attend1			int					default(900)
--alter table dbo.tFVSystemInfo add 	attend2			int					default(5111)
--alter table dbo.tFVSystemInfo add 	attend3			int					default(5112)
--alter table dbo.tFVSystemInfo add 	attend4			int					default(5113)
--alter table dbo.tFVSystemInfo add 	attend5			int					default(5007)


---------------------------------------------
-- 뽑기이벤트 관리 내용.
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSystemRouletteMan', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSystemRouletteMan;
GO

create table dbo.tFVSystemRouletteMan(
	idx					int 				IDENTITY(1, 1),

	roulmarket			varchar(40)			default('1,2,3,4,5,6,7'),

	-- 특정동물 보상받기.
	roulflag			int					default(-1),
	roulstart			datetime			default('2014-01-01'),
	roulend				datetime			default('2024-01-01'),
	roulani1			int					default(-1),
	roulani2			int					default(-1),
	roulani3			int					default(-1),
	roulreward1			int					default(-1),
	roulreward2			int					default(-1),
	roulreward3			int					default(-1),
	roulname1			varchar(20)			default(''),
	roulname2			varchar(20)			default(''),
	roulname3			varchar(20)			default(''),

	-- 특정시간에 확률상승.
	roultimeflag		int					default(-1),
	roultimetime1		int					default(-1),
	roultimetime2		int					default(-1),
	roultimetime3		int					default(-1),

	-- 프리미엄 무료뽑기.
	pmgauageflag		int					default(-1),
	pmgauagepoint		int					default(100),
	pmgauagemax			int					default(10),

	--코멘트.
	comment				varchar(256)		default(''),
	writedate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVSystemRouletteMan_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tFVSystemRouletteMan where roulmarket like '%5%' order by idx desc
-- insert into dbo.tFVSystemRouletteMan(roulmarket, roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,     roulname2,       roulname3, roultimeflag, roultimestart,  roultimeend, roultimetime1, roultimetime2, roultimetime3, comment)
-- values                            ('1,2,3,4,5,6,7',   1, '2013-09-01', '2023-09-01',      213,      112,       14,        5017,        5010,        5009, '얼짱 산양보상', '얼짱 양보상', '얼짱 젖소보상',            1,  '2013-09-01', '2023-09-01',            12,            18,            23, '최초내용')
-- update dbo.tFVSystemRouletteMan set roulflag = -1 where idx = 3


---------------------------------------------
--	Android Push Service
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPushAndroid', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPushAndroid;
GO

create table dbo.tFVUserPushAndroid(
	idx				int				identity(1, 1),

	sendid			varchar(20),
	receid			varchar(20),
	recepushid		varchar(256),
	sendkind		int,

	msgpush_id		int				default(99),
	msgtitle		varchar(512),
	msgmsg			varchar(512),
	msgaction		varchar(512)	default('LAUNCH'),

	actionTime		datetime		default(getdate()),
	scheduleTime	datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserPushAndroid_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tFVUserPushAndroid

-- 내폰
--insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
--insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')
-- 진혁폰
--insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
--insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')
--
----------------------------------------------------
---- 푸쉬 읽어오기(데몬처리부분)
----------------------------------------------------
---- select top 100 * from dbo.tFVUserPushAndroid
---- 백업하기
--DECLARE @tTemp TABLE(
--				sendid			varchar(20),
--				receid			varchar(20),
--				recepushid		varchar(256),
--				sendkind		int,
--
--				msgpush_id		int,
--				msgtitle		varchar(512),
--				msgmsg			varchar(512),
--				msgaction		varchar(512)
--			);
----select * from dbo.tFVUserPushAndroid
--delete from dbo.tFVUserPushAndroid
--	OUTPUT DELETED.sendid, DELETED.receid, DELETED.recepushid, DELETED.sendkind, DELETED.sendkind, DELETED.msgpush_id, DELETED.msgtitle, DELETED.msgmsg, DELETED.msgaction into @tTemp
--	where idx in (1)
------select * from @tTemp
----
--insert into dbo.tFVUserPushAndroidLog(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
--	(select sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction from @tTemp)
--
----select * from dbo.tFVUserPushAndroidLog


---------------------------------------------
--	Android Push Service Log
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPushAndroidLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPushAndroidLog;
GO

create table dbo.tFVUserPushAndroidLog(
	idx				int				identity(1, 1),

	sendid			varchar(20),
	receid			varchar(20),
	recepushid		varchar(256),
	sendkind		int,

	msgpush_id		int				default(99),
	msgtitle		varchar(512),
	msgmsg			varchar(512),
	msgaction		varchar(512)	default('LAUNCH'),

	actionTime		datetime		default(getdate()),
	scheduleTime	datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserPushAndroidLog_idx	PRIMARY KEY(idx)
)
--select top 1 * from dbo.tFVUserPushAndroidLog

-----------------------------------------------
---- Android Push > 통계용 > 메인에서 관리.
-----------------------------------------------
-- exec spu_FVDayLogInfoStatic 1, 50, 10				-- 일 push android
-- exec spu_FVDayLogInfoStatic 1, 51, 1				-- 일 push iphone
--
--IF OBJECT_ID (N'dbo.tFVUserPushAndroidTotal', N'U') IS NOT NULL
--	DROP TABLE dbo.tFVUserPushAndroidTotal;
--GO
--
--create table dbo.tFVUserPushAndroidTotal(
--	idx				int				identity(1, 1),
--
--	dateid			char(8),							-- 20101210
--	cnt				int				default(1),
--
--	-- Constraint
--	CONSTRAINT	pk_tFVUserPushAndroidTotal_dateid	PRIMARY KEY(dateid)
--)
---- select top 100 * from dbo.tFVUserPushAndroidTotal order by dateid desc
---- select top 100 * from dbo.tFVUserPushAndroidTotal where dateid = '20121129' order by dateid desc
----update dbo.tFVUserPushAndroidTotal
----	set
----		cnt = cnt + 1
----where dateid = '20120818'
---- insert into dbo.tFVUserPushAndroidTotal(dateid, cnt) values('20120818', 1)

---------------------------------------------
--	iPhone Push Service
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPushiPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPushiPhone;
GO

create table dbo.tFVUserPushiPhone(
	idx				int				identity(1, 1),

	sendid			varchar(20),
	receid			varchar(20),
	recepushid		varchar(256),
	sendkind		int,

	msgpush_id		int				default(99),
	msgtitle		varchar(512),
	msgmsg			varchar(512),
	msgaction		varchar(512)	default('LAUNCH'),

	actionTime		datetime		default(getdate()),
	scheduleTime	datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserPushiPhone_idx	PRIMARY KEY(idx)
)
--select top 1 * from dbo.tFVUserPushAndroidLog
---- Push입력하기
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')

---------------------------------------------
--	iPhone Push Service Log
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPushiPhoneLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPushiPhoneLog;
GO

create table dbo.tFVUserPushiPhoneLog(
	idx				int				identity(1, 1),

	sendid			varchar(20),
	receid			varchar(20),
	recepushid		varchar(256),
	sendkind		int,

	msgpush_id		int				default(99),
	msgtitle		varchar(512),
	msgmsg			varchar(512),
	msgaction		varchar(512)	default('LAUNCH'),

	actionTime		datetime		default(getdate()),
	scheduleTime	datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserPushiPhoneLog_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tFVUserPushiPhoneLog

---------------------------------------------
--	Push Send Info
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPushSendInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPushSendInfo;
GO

create table dbo.tFVUserPushSendInfo(
	idx				int				identity(1, 1),

	adminid			varchar(20),
	sendkind		int,
	market			int,

	msgtitle		varchar(512),
	msgmsg			varchar(512),

	cnt				int				default(0),
	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserPushSendInfo_idx	PRIMARY KEY(idx)
)
-- select top 10 * from dbo.tFVUserPushSendInfo order by idx desc
-- insert into dbo.tFVUserPushSendInfo(adminid,  sendkind, market, msgtitle, msgmsg,  cnt)
-- values(				       	   @adminid,      @p3_,   @p4_,    @ps3_,  @ps4_, @cnt)
-- select max(idx), min(idx) from dbo.tFVUserPushiPhone
-- select max(idx), min(idx) from dbo.tFVUserPushAndroid
-- select distinct msgtitle, msgmsg from dbo.tFVUserPushiPhone
-- select distinct msgtitle, msgmsg from dbo.tFVUserPushAndroid
-- select top 10 * from dbo.tFVUserPushiPhone where msgtitle = '제목 iPhone'
-- select top 10 * from dbo.tFVUserPushAndroid where msgtitle = '제목 Google'
-- 삭제
-- delete from dbo.tFVUserPushiPhone  where msgtitle = '제목 iPhone'
-- delete from dbo.tFVUserPushAndroid where msgtitle = '제목 Google'
-- delete from dbo.tFVUserPushiPhone  where msgtitle = (select msgtitle from dbo.tFVUserPushSendInfo where idx = 1)
-- delete from dbo.tFVUserPushAndroid  where msgtitle = (select msgtitle from dbo.tFVUserPushSendInfo where idx = 1)


---------------------------------------------
-- 	룰렛 로그 > 개인자료
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVRouletteLogPerson', N'U') IS NOT NULL
	DROP TABLE dbo.tFVRouletteLogPerson;
GO

create table dbo.tFVRouletteLogPerson(
	idx				int				identity(1, 1),

	gameid			varchar(60),
	kind			int,
	framelv			int,
	itemcode		int,
	itemcodename	varchar(40),

	cashcost		int				default(0),
	gamecost		int				default(0),
	heart			int				default(0),

	gameyear		int,
	gamemonth		int,
	friendid		varchar(20),
	frienditemcode	int				default(-1),
	frienditemname	varchar(40),

	itemcode0		int				default(-1),
	itemcode1		int				default(-1),
	itemcode2		int				default(-1),
	itemcode3		int				default(-1),
	itemcode4		int				default(-1),
	itemcode0name	varchar(40)		default(''),
	itemcode1name	varchar(40)		default(''),
	itemcode2name	varchar(40)		default(''),
	itemcode3name	varchar(40)		default(''),
	itemcode4name	varchar(40)		default(''),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVRouletteLogPerson_idx PRIMARY KEY(idx)
)
-- gameid, idx
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVRouletteLogPerson_gameid_idx')
	DROP INDEX tFVRouletteLogPerson.idx_tFVRouletteLogPerson_gameid_idx
GO
CREATE INDEX idx_tFVRouletteLogPerson_gameid_idx ON tRouletteLogPerson (gameid, idx)
GO
-- select top 100 * from dbo.tFVRouletteLogPerson where gameid = 'xxxx2' order by idx desc


---------------------------------------------
-- 	교배뽑기했던 로그(월별 Master)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVRouletteLogTotalMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVRouletteLogTotalMaster;
GO

create table dbo.tFVRouletteLogTotalMaster(
	idx				int				identity(1, 1),
	dateid8			char(8),							-- 20101210

	normalcnt		int				default(0),
	premiumcnt		int				default(0),
	acccnt			int				default(0),			-- 악세사리로그.

	-- Constraint
	CONSTRAINT	pk_tFVRouletteLogTotalMaster_dateid	PRIMARY KEY(dateid8)
)
-- select top 1   * from dbo.tFVRouletteLogTotalMaster where dateid8 = '20120818'
-- insert into dbo.tFVRouletteLogTotalMaster(dateid8) values('20120818')
--update dbo.tFVRouletteLogTotalMaster
--	set
--		premiumcnt 	= premiumcnt + 1,
--		normalcnt 	= normalcnt + 1
--where dateid8 = '20120818'


---------------------------------------------
-- 	교배뽑기했던 로그(월별 Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVRouletteLogTotalSub', N'U') IS NOT NULL
	DROP TABLE dbo.tFVRouletteLogTotalSub;
GO

create table dbo.tFVRouletteLogTotalSub(
	idx				int				identity(1, 1),

	dateid8			char(8),							-- 20101210
	itemcode		int,
	itemcodename	varchar(40)		default(''),

	normalcnt		int				default(0),
	premiumcnt		int				default(0),

	-- Constraint
	CONSTRAINT	pk_tFVRouletteLogTotalSub_dateid8_itemcode	PRIMARY KEY(dateid8, itemcode)
)
-- select top 1   * from dbo.tFVRouletteLogTotalSub where dateid8 = '20120818' and itemcode = 1
--update dbo.tFVRouletteLogTotalSub
--	set
--		premiumcnt 	= premiumcnt + 1,
--		normalcnt	= normalcnt + 1
--where dateid8 = '20120818' and itemcode = 1
-- insert into dbo.tFVRouletteLogTotalSub(dateid8, itemcode) values('20120818', 1)


---------------------------------------------
-- 	룰렛 로그 > 광고용 로그.
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserAdLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserAdLog;
GO

create table dbo.tFVUserAdLog(
	idx				int				identity(1, 1),

	gameid			varchar(60),
	nickname		varchar(40),
	itemcode		int,
	comment			varchar(128)	default(''),
	mode			int				default(1),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVUserAdLog_idx PRIMARY KEY(idx)
)
-- insert into dbo.tFVUserAdLog(gameid, itemcode, comment) values('xxxx2', 101, 'xxxx2님이 양을 교배로 얻었습니다.')
-- delete from dbo.tFVUserAdLog where idx = @idx - 100
-- update dbo.tFVUserAdLog set adidx = @idx where gameid = @gameid_
-- select top 100 * from dbo.tFVUserAdLog where gameid = 'xxxx2' order by idx desc

---------------------------------------------
-- 	악세룰렛 로그 > 개인자료
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVAccRoulLogPerson', N'U') IS NOT NULL
	DROP TABLE dbo.tFVAccRoulLogPerson;
GO

create table dbo.tFVAccRoulLogPerson(
	idx				int				identity(1, 1),

	gameid			varchar(60),
	kind			int,
	framelv			int,
	cashcost		int				default(0),
	gamecost		int				default(0),

	itemcode0		int				default(-1),
	itemcode1		int				default(-1),
	itemcode2		int				default(-1),
	itemcode3		int				default(-1),
	itemcode4		int				default(-1),
	itemcode0name	varchar(40)		default(''),
	itemcode1name	varchar(40)		default(''),
	itemcode2name	varchar(40)		default(''),
	itemcode3name	varchar(40)		default(''),
	itemcode4name	varchar(40)		default(''),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVAccRoulLogPerson_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVAccRoulLogPerson_gameid_idx')
	DROP INDEX tFVAccRoulLogPerson.idx_tFVAccRoulLogPerson_gameid_idx
GO
CREATE INDEX idx_tFVAccRoulLogPerson_gameid_idx ON tAccRoulLogPerson (gameid, idx)
GO
-- select top 100 * from dbo.tFVAccRoulLogPerson where gameid = 'xxxx2' order by idx desc



---------------------------------------------
-- 	합성 로그 > 개인자료
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVComposeLogPerson', N'U') IS NOT NULL
	DROP TABLE dbo.tFVComposeLogPerson;
GO

create table dbo.tFVComposeLogPerson(
	idx				int				identity(1, 1),

	kind 			int,
	gameid			varchar(60),
	gameyear		int,
	gamemonth		int,
	famelv			int,
	heart			int				default(0),
	cashcost		int				default(0),
	gamecost		int				default(0),

	itemcode		int				default(-1),
	itemcodename	varchar(40)		default(''),

	itemcode0		int				default(-1),
	itemcode1		int				default(-1),
	itemcode2		int				default(-1),
	itemcode3		int				default(-1),
	itemcode4		int				default(-1),
	itemcode0name	varchar(40)		default(''),

	bgcomposeic		int				default(1),
	bgcomposert		int				default(0),
	bgcomposename	varchar(40)		default(''),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVComposeLogPerson_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVComposeLogPerson_gameid_idx')
	DROP INDEX tFVComposeLogPerson.idx_tFVComposeLogPerson_gameid_idx
GO
CREATE INDEX idx_tFVComposeLogPerson_gameid_idx ON tComposeLogPerson (gameid, idx)
GO
-- select top 100 * from dbo.tFVComposeLogPerson where gameid = 'xxxx2' order by idx desc


---------------------------------------------
--	친구랭킹[백업스케쥴러]
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserMasterSchedule', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserMasterSchedule;
GO

create table dbo.tFVUserMasterSchedule(
	idx				int					identity(1, 1),

	dateid			varchar(8),										-- 20121118
	idxStart		int					default(0),
	writedate		datetime			default(getdate()), 		-- 작성일

	-- Constraint
	CONSTRAINT pk_tFVUserMasterSchedule_dateid	PRIMARY KEY(dateid)
)
GO

-- select * from dbo.tFVUserMasterSchedule
-- if(not exist(select dateid from dbo.tFVUserMasterSchedule where dateid = '20131227'))
-- 		insert into dbo.tFVUserMasterSchedule(dateid, idxStart) values('20131227', 1)
-- update tFVUserMasterSchedule
-- 	set
--		idxStart = idx
-- where dateid = '20121118'

---------------------------------------------
--		학교대항전 결과.
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSchoolResult', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSchoolResult;
GO

create table dbo.tFVSchoolResult(
	idx						int					IDENTITY(1,1),

	schoolresult			int					default(0),
	writedate				datetime			default(getdate()),


	-- Constraint
	CONSTRAINT	pk_tFVSchoolResult_schoolresult	PRIMARY KEY(schoolresult)
)

-- insert into dbo.tFVSchoolResult(schoolresult) values(1)
-- select * from dbo.tFVSchoolResult order by schoolresult desc
-- select top 1 schoolresult from dbo.tFVSchoolResult order by schoolresult desc
-- insert into dbo.tFVSchoolResult(schoolresult)
-- select top 1 (isnull(schoolresult, 0) + 1) from dbo.tFVSchoolResult order by schoolresult desc


---------------------------------------------
--		학교대항[학교]
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSchoolMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSchoolMaster;
GO

create table dbo.tFVSchoolMaster(
	idx						int					IDENTITY(1,1),

	schoolidx				int,
	cnt						int					default(1),
	totalpoint				bigint				default(0),
	joindate				datetime			default(getdate()),
	schoolrank				int					default(-1),

	backcnt					int					default(1),
	backtotalpoint			bigint				default(0),
	backschoolrank			int					default(-1),

	-- Constraint
	CONSTRAINT	pk_tFVSchoolMaster_schoolidx	PRIMARY KEY(schoolidx)
)
-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVSchoolMaster_totalpoint')
    DROP INDEX tFVSchoolMaster.idx_tFVSchoolMaster_totalpoint
GO
CREATE INDEX idx_tFVSchoolMaster_totalpoint ON tFVSchoolMaster (totalpoint desc)
GO

-- insert into dbo.tFVSchoolMaster(schoolidx) values(2)
-- select top 1 * from dbo.tFVSchoolMaster where schoolidx = 2
-- update dbo.tFVSchoolMaster set cnt = cnt + 1 where schoolidx = 2
-- update dbo.tFVSchoolMaster set totalpoint = totalpoint + 10 where schoolidx = 2
-- select top 10 rank() over(order by totalpoint desc) as rank, schoolidx, cnt, totalpoint from dbo.tFVSchoolMaster

---------------------------------------------
--		학교대항[유저]
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSchoolUser', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSchoolUser;
GO

create table dbo.tFVSchoolUser(
	idx						int					IDENTITY(1,1),

	schoolidx				int,
	gameid					varchar(60),
	point					bigint				default(0),
	joindate				datetime			default(getdate()),	--최초가입일, 갱신일

	schoolrank				int					default(-1),
	userrank				int					default(-1),
	itemcode 				int					default(1),
	acc1	 				int					default(-1),
	acc2 					int					default(-1),
	itemcode1 				int					default(-1),
	itemcode2 				int					default(-1),
	itemcode3 				int					default(-1),

	backdateid				varchar(8)			default('20100101'),
	backschoolidx			int					default(-1),
	backschoolrank			int					default(-1),
	backuserrank			int					default(-1),
	backpoint				bigint				default(0),
	backitemcode			int					default(1),
	backacc1				int					default(-1),
	backacc2 				int					default(-1),
	backitemcode1			int					default(-1),
	backitemcode2			int					default(-1),
	backitemcode3			int					default(-1),

	-- Constraint
	CONSTRAINT	pk_tFVSchoolUser_gameid	PRIMARY KEY(gameid)
)

-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVSchoolUser_schoolidx_point')
    DROP INDEX tFVSchoolUser.idx_tFVSchoolUser_schoolidx_point
GO
CREATE INDEX idx_tFVSchoolUser_schoolidx_point ON tFVSchoolUser (schoolidx, point desc)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVSchoolUser_joindate')
    DROP INDEX tFVSchoolUser.idx_tFVSchoolUser_joindate
GO
CREATE INDEX idx_tFVSchoolUser_joindate ON tFVSchoolUser (joindate)
GO

-- select top 1 * from dbo.tFVSchoolUser where gameid = 'xxxx2'
-- delete from dbo.tFVSchoolUser where gameid = 'xxxx2'
-- insert into dbo.tFVSchoolUser(schoolidx, gameid) values(1, 'xxxx2')
-- update dbo.tFVSchoolUser set point = point + 10 where gameid = 'xxxx2'
-- select top 10 rank() over(order by point desc) as rank, schoolidx, gameid, point from dbo.tFVSchoolUser where schoolidx = 1



---------------------------------------------
--	학교대항[백업스케쥴러]
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSchoolSchedule', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSchoolSchedule;
GO

create table dbo.tFVSchoolSchedule(
	idx				int					identity(1, 1),

	dateid			varchar(8),										-- 20121118
	step			int					default(0),
	writedate		datetime			default(getdate()), 		-- 작성일

	-- Constraint
	CONSTRAINT pk_tFVSchoolSchedule_dateid	PRIMARY KEY(dateid)
)
GO

-- select * from dbo.tFVSchoolSchedule
-- if(not exist(select dateid from dbo.tFVSchoolSchedule where dateid = '20131227'))
-- 		insert into dbo.tFVSchoolSchedule(dateid, step) values('20131227', 1)
-- update tFVSchoolSchedule
-- 	set
--		idxStart = idx
-- where dateid = '20121118'


---------------------------------------------
--		학교대항[학교백업]
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSchoolBackMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSchoolBackMaster;
GO

create table dbo.tFVSchoolBackMaster(
	idx						int					IDENTITY(1,1),

	dateid					varchar(8),										-- 20121118
	schoolrank				int,

	schoolidx				int,
	cnt						int 				default(1),
	totalpoint				bigint				default(0),
	joindate				datetime			default(getdate()),
	comment					varchar(128)

	-- Constraint
	CONSTRAINT	pk_tFVSchoolBackMaster_idx		PRIMARY KEY(idx)
)
-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVSchoolBackMaster_dateid_schoolrank')
    DROP INDEX tFVSchoolBackMaster.idx_tFVSchoolBackMaster_dateid_schoolrank
GO
CREATE INDEX idx_tFVSchoolBackMaster_dateid_schoolrank ON tFVSchoolBackMaster (dateid, schoolrank)
GO
-- select top 1 * from dbo.tFVSchoolBackMaster


---------------------------------------------
--		학교대항[유저백업]
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSchoolBackUser', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSchoolBackUser;
GO

create table dbo.tFVSchoolBackUser(
	idx						int					IDENTITY(1,1),

	dateid					varchar(8),										-- 20121118
	schoolrank				int,
	userrank				int,

	schoolidx				int,
	gameid					varchar(60),
	point					bigint				default(0),
	joindate				datetime			default(getdate()),
	comment					varchar(128),

	itemcode 				int					default(1),
	acc1	 				int					default(-1),
	acc2 					int					default(-1),

	itemcode1 				int					default(-1),
	itemcode2 				int					default(-1),
	itemcode3 				int					default(-1)

	-- Constraint
	CONSTRAINT	pk_tFVSchoolBackUser_idx	PRIMARY KEY(idx)
)
-- 인덱싱
--IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVSchoolBackUser_dateid_schoolrank_userrank')
--   DROP INDEX tFVSchoolBackUser.idx_tFVSchoolBackUser_dateid_schoolrank_userrank
--GO
--CREATE INDEX idx_tFVSchoolBackUser_dateid_schoolrank_userrank ON tFVSchoolBackUser (dateid, schoolrank, userrank)
--GO

-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVSchoolBackUser_dateid_gameid')
    DROP INDEX tFVSchoolBackUser.idx_tFVSchoolBackUser_dateid_gameid
GO
CREATE INDEX idx_tFVSchoolBackUser_dateid_gameid ON tFVSchoolBackUser (dateid, gameid)
GO
-- select top 1 * from dbo.tFVSchoolBackUser
-- insert into dbo.tFVSchoolBackUser(dateid, schoolrank, userrank, schoolidx, gameid, point, joindate) values('20131228', 1, 1, 1, 'xxxx2', 800, getdate())
-- insert into dbo.tFVSchoolBackUser(dateid, schoolrank, userrank, schoolidx, gameid, point, joindate) values('20131228', 1, 2, 1, 'xxxx3', 150, getdate())
-- insert into dbo.tFVSchoolBackUser(dateid, schoolrank, userrank, schoolidx, gameid, point, joindate) values('20131228', 1, 3, 1, 'xxxx4',  50, getdate())




---------------------------------------------
-- 이벤트 인증키값
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEventCertNo', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEventCertNo;
GO

create table dbo.tFVEventCertNo(
	idx			int				identity(1, 1),
	certno		varchar(16),

	itemcode1	int				default(-1),
	itemcode2	int				default(-1),
	itemcode3	int				default(-1),
	kind		int				default(0),

	CONSTRAINT	pk_tFVEventCertNo_idx	PRIMARY KEY(idx)
)
-- 인증번호 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventCertNo_certno')
    DROP INDEX tFVEventCertNo.idx_tFVEventCertNo_certno
GO
CREATE INDEX idx_tFVEventCertNo_certno ON tFVEventCertNo (certno)
GO

---------------------------------------------
-- 이벤트 인증키값(백업)
-- 누구에게 무슨아이템을 지급했다.
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEventCertNoBack', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEventCertNoBack;
GO

create table dbo.tFVEventCertNoBack(
	idx			int				identity(1, 1),
	certno		varchar(16),

	gameid		varchar(60),
	itemcode1	int				default(-1),
	itemcode2	int				default(-1),
	itemcode3	int				default(-1),
	usedtime	datetime		default(getdate()),
	kind		int				default(0),

	CONSTRAINT	pk_tFVEventCertNoBack_idx	PRIMARY KEY(idx)
)

-- 인증번호 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventCertNoBack_certno')
    DROP INDEX tFVEventCertNoBack.idx_tFVEventCertNoBack_certno
GO
CREATE INDEX idx_tFVEventCertNoBack_certno ON tFVEventCertNoBack (certno)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventCertNoBack_gameid_kind')
    DROP INDEX tFVEventCertNoBack.idx_tFVEventCertNoBack_gameid_kind
GO
CREATE INDEX idx_tFVEventCertNoBack_gameid_kind ON tFVEventCertNoBack (gameid, kind)
GO


---------------------------------------------
-- 유저문의
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSysInquire', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSysInquire;
GO

create table dbo.tFVSysInquire(
	idx					int 				IDENTITY(1, 1),

	gameid				varchar(60),
	state				int					default(0),				-- 요청대기[0], 체킹중[1], 완료[2]
	comment				varchar(1024)		default(''),
	writedate			datetime			default(getdate()),

	adminid				varchar(20)			default(''),
	comment2			varchar(1024)		default(''),
	dealdate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVSysInquire_idx	PRIMARY KEY(idx)
)
-- select top 10 * from dbo.tFVSysInquire order by idx desc
-- insert into dbo.tFVSysInquire(gameid, comment) values(1, '잘안됩니다.')
-- update dbo.tFVSysInquire set state = 1, dealdate = getdate(), comment2 = '진행중입니다.' where idx = 1
-- update dbo.tFVSysInquire set state = 2, dealdate = getdate(), comment2 = '처리했습니다.' where idx = 1
-- if(2)쪽지로 발송된다.


---------------------------------------------
-- 이벤트 진행 정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSysEventInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSysEventInfo;
GO

create table dbo.tFVSysEventInfo(
	idx					int 				IDENTITY(1, 1),

	adminid				varchar(20),
	state				int					default(0),				-- 대기중[0], 진행중[1], 완료[2]
	startdate			varchar(16),								-- 2014-05-05 10:00
	enddate				varchar(16),
	company				int					default(0),				-- 상상디지탈(0), 픽토소프트(1)
	title				varchar(256)		default(''),
	comment				varchar(4096)		default(''),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVSysEventInfo_idx	PRIMARY KEY(idx)
)
-- insert into dbo.tFVSysEventInfo(adminid, state, startdate, enddate, company, title, comment) values('blackm', 0, '2014-05-12 00:00', '2014-05-12 23:59', 0, '이벤트제목', '이벤트내용')
-- update dbo.tFVSysEventInfo set state = 1, startdate = '2014-05-12 00:00', enddate = '2014-05-12 23:59', company = 0, title = '이벤트제목', comment = '이벤트내용' where idx = 1
-- select top 10 * from dbo.tFVSysEventInfo order by idx desc

---------------------------------------------
--		Kakao Master
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVKakaoMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVKakaoMaster;
GO

create table dbo.tFVKakaoMaster(
	idx				int					IDENTITY(1,1),

	kakaouserid		varchar(20),
	kakaotalkid		varchar(20),
	gameid			varchar(60),
	cnt				int					default(1),					-- 보유량
	cnt2			int					default(0),
	kakaodata		int					default(1),					-- 카톡유저(1), 게스트유저(1)
	writedate		datetime			default(getdate()),
	deldate			datetime			default(getdate() - 1),

	-- Constraint
	CONSTRAINT	pk_tFVKakaoMaster_kakaotalkid	PRIMARY KEY(kakaouserid)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoMaster_kakaotalkid')
    DROP INDEX tFVKakaoMaster.idx_tFVKakaoMaster_kakaotalkid
GO
CREATE INDEX idx_tFVKakaoMaster_kakaotalkid ON tFVKakaoMaster (kakaotalkid)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoMaster_idx')
    DROP INDEX tFVKakaoMaster.idx_tFVKakaoMaster_idx
GO
CREATE INDEX idx_tFVKakaoMaster_idx ON tFVKakaoMaster (idx)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoMaster_gameid')
    DROP INDEX tFVKakaoMaster.idx_tFVKakaoMaster_gameid
GO
CREATE INDEX idx_tFVKakaoMaster_gameid ON tFVKakaoMaster (gameid)
GO

---------------------------------------------
--		Kakao 초대
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVKakaoInvite', N'U') IS NOT NULL
	DROP TABLE dbo.tFVKakaoInvite;
GO

create table dbo.tFVKakaoInvite(
	idx				int					IDENTITY(1,1),

	gameid			varchar(60),
	recetalkid		varchar(20),
	cnt				int					default(1),
	senddate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVKakaoInvite_idx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoInvite_gameid_recetalkid')
    DROP INDEX tFVKakaoInvite.idx_tFVKakaoInvite_gameid_recetalkid
GO
CREATE INDEX idx_tFVKakaoInvite_gameid_recetalkid ON tFVKakaoInvite (gameid, recetalkid)
GO

-- select top 1 * from dbo.tFVKakaoInvite where gameid = 'xxxx2' and recetalkid = 'kakaotalkid13'
-- select datediff(d, '2014-03-01 12:20', '2014-03-06 12:20')	-- 5일차
-- insert into dbo.tFVKakaoInvite(gameid, recetalkid) values('xxxx2', 'kakaotalkid13')
-- update dbo.tFVKakaoInvite
--	set
--		cnt = cnt + 1,
--		senddate = getdate()
--	where gameid = 'xxxx2' and recetalkid = 'kakaotalkid13'

---------------------------------------------
--		Kakao 도와줘 친구야~~~ (Wait) 24H유효
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVKakaoHelpWait', N'U') IS NOT NULL
	DROP TABLE dbo.tFVKakaoHelpWait;
GO

create table dbo.tFVKakaoHelpWait(
	idx				int					IDENTITY(1,1),

	gameid			varchar(60),
	friendid		varchar(20),
	listidx			int,
	helpdate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVKakaoHelpWait_idx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoHelpWait_gameid_friendid')
    DROP INDEX tFVKakaoHelpWait.idx_tFVKakaoHelpWait_gameid_friendid
GO
CREATE INDEX idx_tFVKakaoHelpWait_gameid_friendid ON tFVKakaoHelpWait (gameid, friendid)
GO
-- insert into dbo.tFVKakaoHelpWait(gameid, friendid, listidx) values( 'xxxx3', 'xxxx2', 1)
-- select * from dbo.tFVKakaoHelpOrder where gameid = 'xxxx3'
-- update dbo.tFVUserItem set helpcnt = 신선도에따른 2, 3, 4, 5
-- delete from dbo.tFVKakaoHelpOrder where idx = 1


---------------------------------------------
-- 	캐쉬전송
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVCashLogKakaoSend', N'U') IS NOT NULL
	DROP TABLE dbo.tFVCashLogKakaoSend;
GO

create table dbo.tFVCashLogKakaoSend(
	checkidx		int,

	-- Constraint
	CONSTRAINT	pk_tFVCashLogKakaoSend_checkidx	PRIMARY KEY(checkidx)
)



---------------------------------------------
--	통계마스터[FameLV, Market]
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVStaticMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVStaticMaster;
GO

create table dbo.tFVStaticMaster(
	idx				int					identity(1, 1),

	dateid			varchar(8),									-- 20121118
	step 			int					default(1),				-- famelv(1), tel(2)
	writedate		datetime			default(getdate()), 	-- 작성일

	-- Constraint
	CONSTRAINT pk_tFVStaticMaster_dateid	PRIMARY KEY(dateid)
)
GO

-- select * from dbo.tFVStaticMaster
-- if(not exist(select dateid from dbo.tFVStaticMaster where dateid = '20140404'))
-- 		insert into dbo.tFVStaticMaster(dateid, step) values('20140404', 1)
-- update dbo.tFVStaticMaster set step = 2 where dateid = '20140404'

---------------------------------------------
--	통계[FameLV]
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVStaticSubFameLV', N'U') IS NOT NULL
	DROP TABLE dbo.tFVStaticSubFameLV;
GO

create table dbo.tFVStaticSubFameLV(
	idx						int					IDENTITY(1,1),

	dateid					varchar(8),
	famelv					int,
	cnt						int 				default(0),
	cnt2					int 				default(0),
	writedate				datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVStaticSubFameLV_idx		PRIMARY KEY(idx)
)
-- select * from dbo.tFVStaticSubFameLV where dateid = '20140404'
-- if(not exist(select dateid from dbo.tFVStaticSubFameLV where dateid = '20140404'))
-- 	insert into dbo.tFVStaticSubFameLV(dateid, famelv, cnt) values('20140404', 1, 1)
-- else
--	update dbo.tFVStaticSubFameLV set cnt = 2 where dateid = '20140404' and famelv = 1

---------------------------------------------
--	통계[Market]
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVStaticSubMarket', N'U') IS NOT NULL
	DROP TABLE dbo.tFVStaticSubMarket;
GO

create table dbo.tFVStaticSubMarket(
	idx						int					IDENTITY(1,1),

	dateid					varchar(8),
	market					int,
	cnt						int 				default(0),
	cnt2					int 				default(0),
	writedate				datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVStaticSubMarket_idx		PRIMARY KEY(idx)
)
-- select * from dbo.tFVStaticSubMarket where dateid = '20140404'
-- if(not exist(select dateid from dbo.tFVStaticSubMarket where dateid = '20140404'))
-- 	insert into dbo.tFVStaticSubMarket(dateid, market, cnt) values('20140404', 1, 1)
-- else
--	update dbo.tFVStaticSubMarket set cnt = 2 where dateid = '20140404' and market = 1



---------------------------------------------
--	통계자료(캐쉬 마스터)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVStaticCashMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVStaticCashMaster;
GO

create table dbo.tFVStaticCashMaster(
	idx				int					identity(1, 1),

	dateid			varchar(8),									-- 20121118
	step 			int					default(1),				-- famelv(1), tel(2)
	writedate		datetime			default(getdate()), 	-- 작성일

	-- Constraint
	CONSTRAINT pk_tFVStaticCashMaster_dateid	PRIMARY KEY(dateid)
)
GO

---------------------------------------------
--	통계자료(캐쉬 서브)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVStaticCashUnique', N'U') IS NOT NULL
	DROP TABLE dbo.tFVStaticCashUnique;
GO

create table dbo.tFVStaticCashUnique(
	idx						int					IDENTITY(1,1),

	dateid					varchar(8),
	market					int,
	cash					int,
	cnt						int,
	writedate				datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVStaticCashUnique_idx		PRIMARY KEY(idx)
)


---------------------------------------------
--		아이템 (동물죽음 로그)
--		고속의 입력을 기준
--		(인덱스도 하나만 존재함)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserItemDieLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserItemDieLog;
GO

create table dbo.tFVUserItemDieLog(
	idx				bigint					IDENTITY(1,1),

	gameid			varchar(60),									--
	listidx			int,											-- 리스트인덱스(각개인별로 별개)

	invenkind		int					default(1),					--대분류(가축(1), 소모품(3), 액세서리(4))
	itemcode		int,
	cnt				int					default(1),					--보유량

	farmnum			int					default(-1),				-- 농장번호(-1:농장없음, 0~50:농장번호)
	fieldidx		int					default(-1),				-- 필드(-2:병원, -1:창고, 0~8:필드)
	anistep			int					default(5),					-- 현재단계(0 ~ 12단계)
	manger			int					default(25),				-- 여물통(건초:1 > 여물:20)
	diseasestate	int					default(0),					-- 질병상태(0:노질병, 질병 >=0 걸림)
	acc1			int					default(-1),				-- 악세(모자:아이템코드)
	acc2			int					default(-1),				-- 악세(등:아이템코드)
	abilkind		int					default(-1),				--능력치종류1~5 (90001:신선도, 90002:추가 생산 확률, 90003:피버 드랍 확률, 90004:질병 저항력, 90005;코인 드랍 확률)
	abilval			int					default(0),					--능력치값1~5
	abilkind2		int					default(-1),				--
	abilval2		int					default(0),					--
	abilkind3		int					default(-1),				--
	abilval3		int					default(0),					--
	abilkind4		int					default(-1),				--
	abilval4		int					default(0),					--
	abilkind5		int					default(-1),				--
	abilval5		int					default(0),					--

	randserial		varchar(20)			default('-1'),				--랜던씨리얼(클라이언트에서 만들어서옴)
	writedate		datetime			default(getdate()),			--구매일/획득일
	gethow			int					default(0),					--획득방식(0:구매, 1:경작, 2:교배/뽑기, 3:검색)

	diedate			datetime			default(getdate()),
	diemode			int					default(-1),				-- -1:아님, 1:눌러,텨저, 2:늑대
	needhelpcnt		int					default(0),					-- 병원에 있을때 자동 부활용으로 사용된다.(부활석 개수만큼)

	petupgrade		int					default(1),					-- 펫업그레이드 하기.

	-- Constraint
	CONSTRAINT	pk_tFVUserItemDieLog_idx	PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItemDieLog_idx_gameid')
    DROP INDEX tFVUserItemDieLog.idx_tFVUserItemDieLog_idx_gameid
GO
CREATE INDEX idx_tFVUserItemDieLog_idx_gameid ON tFVUserItemDieLog (idx, gameid)
GO
-- insert into dbo.tFVUserItem(gameid, listidx, invenkind, itemcode, cnt, farmnum, fieldidx, anistep, manger, diseasestate, acc1, acc2, abilkind, abilval, abilkind2, abilval2, abilkind3, abilval3, abilkind4, abilval4, abilkind5, abilval5, randserial, writedate, gethow, diedate, diemode, needhelpcnt, petupgrade) values('xxxx', 0, 1, 1, 0, 0, 1, 1001) -- 동물
-- select top 10 * from dbo.tFVUserItemDieLog order by idx desc
-- select top 10 * from dbo.tFVUserItemDieLog where gameid = 'xxxx2' order by idx desc

---------------------------------------------
--		아이템 (동물죽음 로그)
--		고속의 입력을 기준
--		(인덱스도 하나만 존재함)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserItemAliveLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserItemAliveLog;
GO

create table dbo.tFVUserItemAliveLog(
	idx				bigint					IDENTITY(1,1),

	gameid			varchar(60),									--
	listidx			int,											-- 리스트인덱스(각개인별로 별개)

	invenkind		int					default(1),					--대분류(가축(1), 소모품(3), 액세서리(4))
	itemcode		int,
	cnt				int					default(1),					--보유량

	farmnum			int					default(-1),				-- 농장번호(-1:농장없음, 0~50:농장번호)
	fieldidx		int					default(-1),				-- 필드(-2:병원, -1:창고, 0~8:필드)
	anistep			int					default(5),					-- 현재단계(0 ~ 12단계)
	manger			int					default(25),				-- 여물통(건초:1 > 여물:20)
	diseasestate	int					default(0),					-- 질병상태(0:노질병, 질병 >=0 걸림)
	acc1			int					default(-1),				-- 악세(모자:아이템코드)
	acc2			int					default(-1),				-- 악세(등:아이템코드)
	abilkind		int					default(-1),				--능력치종류1~5 (90001:신선도, 90002:추가 생산 확률, 90003:피버 드랍 확률, 90004:질병 저항력, 90005;코인 드랍 확률)
	abilval			int					default(0),					--능력치값1~5
	abilkind2		int					default(-1),				--
	abilval2		int					default(0),					--
	abilkind3		int					default(-1),				--
	abilval3		int					default(0),					--
	abilkind4		int					default(-1),				--
	abilval4		int					default(0),					--
	abilkind5		int					default(-1),				--
	abilval5		int					default(0),					--

	randserial		varchar(20)			default('-1'),				--랜던씨리얼(클라이언트에서 만들어서옴)
	writedate		datetime			default(getdate()),			--구매일/획득일
	gethow			int					default(0),					--획득방식(0:구매, 1:경작, 2:교배/뽑기, 3:검색)

	diedate			datetime,
	diemode			int					default(-1),				-- -1:아님, 1:눌러,텨저, 2:늑대
	needhelpcnt		int					default(0),					-- 병원에 있을때 자동 부활용으로 사용된다.(부활석 개수만큼)

	petupgrade		int					default(1),					-- 펫업그레이드 하기.

	alivedate		datetime			default(getdate()),
	alivecash		int					default(0),
	alivedoll		int					default(0),

	-- Constraint
	CONSTRAINT	pk_tFVUserItemAliveLog_idx	PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItemAliveLog_idx_gameid')
    DROP INDEX tFVUserItemAliveLog.idx_tFVUserItemAliveLog_idx_gameid
GO
CREATE INDEX idx_tFVUserItemAliveLog_idx_gameid ON tFVUserItemAliveLog (idx, gameid)
GO
-- select top 10 * from dbo.tFVUserItemAliveLog order by idx desc
-- select top 10 * from dbo.tFVUserItemAliveLog where gameid = 'xxxx2' order by idx desc


---------------------------------------------
--		이벤트 마스터
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEventMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEventMaster;
GO

create table dbo.tFVEventMaster(
	idx						int					IDENTITY(1,1),

	eventstatemaster		int					default(0),		-- 0:대기중, 1:진행중, 2:완료중

	-- Constraint
	CONSTRAINT	pk_tFVEventMaster_eventstatemaster	PRIMARY KEY(eventstatemaster)
)
-- 처음 데이타는 넣어줘야한다.
insert into dbo.tFVEventMaster(eventstatemaster) values(0)
-- update dbo.tFVEventMaster set eventstatemaster = case when eventstatemaster = 0 then 1 else 0 end where idx = 1
-- select eventstatemaster from dbo.tFVEventMaster where idx = 1

---------------------------------------------
--		이벤트 서브
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEventSub', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEventSub;
GO

create table dbo.tFVEventSub(
	eventidx		int					IDENTITY(1,1),
	eventstatedaily	int					default(0),					-- 0:EVENT_STATE_NON, 1:ING, 2:_END
	eventitemcode	int					default(-1),
	eventsender		varchar(20)			default('짜요 소녀'),
	eventstart		smalldatetime		default(getdate() - 1),
	eventend		smalldatetime		default(getdate() - 1),

	eventpushtitle	varchar(512)		default(''),				-- 푸쉬 제목, 내용, 상태
	eventpushmsg	varchar(512)		default(''),				--
	eventpushstate	int					default(0),					-- 0:EVENT_PUSH_NON, 1:EVENT_PUSH_SEND

	writedate		datetime			default(getdate()),
	CONSTRAINT	pk_tFVEventSub_eventidx	PRIMARY KEY(eventidx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventSub_eventstart_eventend')
    DROP INDEX tFVEventSub.idx_tFVEventSub_eventstart_eventend
GO
CREATE INDEX idx_tFVEventSub_eventstart_eventend ON tFVEventSub (eventstart, eventend)
GO

--insert into dbo.tFVEventSub(eventitemcode,  eventsender,  eventstart,            eventend,  eventpushtitle, eventpushmsg)
--values(                            1104,  '짜요 소녀', '2014-05-24',       '2014-05-24 18:00', '나른한 토요일 불타는 점심선물', '특수 촉진제와 함께 손가락이 불타는 시간을 보내보세요.')
--insert into dbo.tFVEventSub(eventitemcode,  eventsender,  eventstart,            eventend,  eventpushtitle, eventpushmsg)
--values(                            5007,  '짜요 소녀', '2014-05-24 18:00', '2014-05-24 23:59', '나른한 토요일 수정 받고 가세요!', '수정 선물이 도착했어요! 지금 바로 접속!')
--insert into dbo.tFVEventSub(eventitemcode,  eventsender,  eventstart,            eventend,  eventpushtitle, eventpushmsg)
--values(                            5009,  '짜요 소녀', '2014-05-25',       '2014-05-25 18:00', '즐거운 일요일! 지금 선물 받으세요!', ' 사라져요!지금 접속해서 수정 10개를 받아주세요~')
--insert into dbo.tFVEventSub(eventitemcode,  eventsender,  eventstart,            eventend,  eventpushtitle, eventpushmsg)
--values(                            2201,  '짜요 소녀', '2014-05-25 18:00', '2014-05-25 23:59', '20시까지 교배 티켓 받으세요~', '20시까지 접속하면 교배티켓 2장이 선물로! 빨리 접속하세요~')
--insert into dbo.tFVEventSub(eventitemcode,  eventsender,  eventstart,            eventend,  eventpushtitle, eventpushmsg)
--values(                            1202,  '짜요 소녀', '2014-05-26',       '2014-05-26 18:00', '오늘의 점심 선물은 뭘까요?', '죽은 소도 살려준다는 그것! 지금 바로 접속해서 선물받으세요~')
--insert into dbo.tFVEventSub(eventitemcode,  eventsender,  eventstart,            eventend,  eventpushtitle, eventpushmsg)
--values(                            2013,  '짜요 소녀', '2014-05-26 18:00', '2014-05-26 23:59', '사랑의 선물이 도착했어요~', '선물이 곧 사라져요~ 빨리 접속해서 선물 받으세요!')
--update dbo.tFVEventSub
--	set
--		eventstatedaily	= 1,
--		eventitemcode 	= 1104,
--		eventsender		= '짜요 소녀',
--		eventstart 		= '2014-05-24',
--		eventend		= '2014-05-24 18:00',
--		eventpushtitle	= '나른한 토요일 불타는 점심선물',
--		eventpushmsg	= '특수 촉진제와 함께 손가락이 불타는 시간을 보내보세요.'
--where eventidx = 1
--update dbo.tFVEventSub set eventstatedaily= 1 where eventidx in (1, 2, 3, 4, 5, 6)
--update dbo.tFVEventSub set eventpushstate	= 1 where eventidx = 2
--declare @curdate datetime set @curdate = getdate()
--select * from dbo.tFVEventSub where eventstart <= @curdate and @curdate < eventend and eventstatedaily = 1
--select top 100 * from dbo.tFVEventSub order by eventidx desc


---------------------------------------------
--		이벤트 받아간 유저로그
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEvnetUserGetLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEvnetUserGetLog;
GO

create table dbo.tFVEvnetUserGetLog(
	idx				int					IDENTITY(1,1),

	gameid			varchar(60),
	eventidx		int,
	eventitemcode	int,
	writedate		datetime			default(getdate()),
	CONSTRAINT	pk_tFVEvnetUserGetLog_eventidx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEvnetUserGetLog_gameid_eventidx')
    DROP INDEX tFVEvnetUserGetLog.idx_tFVEvnetUserGetLog_gameid_eventidx
GO
CREATE INDEX idx_tFVEvnetUserGetLog_gameid_eventidx ON tFVEvnetUserGetLog (gameid, eventidx)
GO

-- insert into dbo.tFVEvnetUserGetLog(gameid, eventidx, eventitemcode) values( 'xxxx2', 1, 1104)
-- select * from dbo.tFVEvnetUserGetLog where gameid = 'xxxx2' and eventidx = 1







---------------------------------------------
-- 	주사위 회수 로그 (월별 누적)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserYabauMonth', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserYabauMonth;
GO

create table dbo.tFVUserYabauMonth(
	idx				int				identity(1, 1),

	dateid6			char(6),							-- 201012
	itemcode		int,

	step1			int				default(0),
	step2			int				default(0),
	step3			int				default(0),
	step4			int				default(0),
	step5			int				default(0),
	step6			int				default(0),

	-- Constraint
	CONSTRAINT	pk_tFVUserYabauMonth_dateid6_itemcode	PRIMARY KEY(dateid6, itemcode)
)
-- select         * from dbo.tFVUserYabauMonth where dateid6 = '201407' and itemcode = 70008
-- insert into dbo.tFVUserYabauMonth(dateid6, itemcode) values('201407', 70008)
-- update dbo.tFVUserYabauMonth set step1 = step1 + 1 where dateid6 = '201407' and itemcode = 70008


---------------------------------------------
-- 	주사위 회수 로그 (월별 Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserYabauTotalSub', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserYabauTotalSub;
GO

create table dbo.tFVUserYabauTotalSub(
	idx				int				identity(1, 1),

	dateid8			char(8),							-- 20101210
	itemcode		int,

	step1			int				default(0),
	step2			int				default(0),
	step3			int				default(0),
	step4			int				default(0),
	step5			int				default(0),
	step6			int				default(0),

	-- Constraint
	CONSTRAINT	pk_tFVUserYabauTotalSub_dateid8_itemcode	PRIMARY KEY(dateid8, itemcode)
)
-- select         * from dbo.tFVUserYabauTotalSub where dateid8 = '20140724' and itemcode = 70008
-- insert into dbo.tFVUserYabauTotalSub(dateid8, itemcode) values('20140724', 70008)
-- update dbo.tFVUserYabauTotalSub set step1 = step1 + 1 where dateid8 = '20140724' and itemcode = 70008


---------------------------------------------
-- 	주사위 로그 > 개인자료
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVYabauLogPerson', N'U') IS NOT NULL
	DROP TABLE dbo.tFVYabauLogPerson;
GO

create table dbo.tFVYabauLogPerson(
	idx				int				identity(1, 1),

	gameid			varchar(60),
	itemcode		int				default(-1),
	kind			int				default(1),			-- 주사위의 모드가 들어감.
	framelv			int,

	yabaustep		int				default(-1),
	pack11			int				default(-1),
	pack21			int				default(-1),
	pack31			int				default(-1),
	pack41			int				default(-1),
	pack51			int				default(-1),
	pack61			int				default(-1),
	result			int				default(-1),
	cashcost		int				default(0),
	gamecost		int				default(0),
	yabauchange		int				default(0),
	yabaucount		int				default(0),			-- 시도횟수
	remaingamecost	int				default(0),			-- 남은금액
	remaincashcost	int				default(0),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tFVYabauLogPerson_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVYabauLogPerson_gameid_idx')
	DROP INDEX tFVYabauLogPerson.idx_tFVYabauLogPerson_gameid_idx
GO
CREATE INDEX idx_tFVYabauLogPerson_gameid_idx ON tFVYabauLogPerson (gameid, idx)
GO
-- select top 100 * from dbo.tFVYabauLogPerson where gameid = 'xxxx2' order by idx desc
-- MODE_YABAU_RESET
-- insert into dbo.tFVYabauLogPerson(gameid, itemcode, kind, framelv, gamecost) values('xxxx2', 70002, 1, 20, 1700)
-- MODE_YABAU_REWARD
-- insert into dbo.tFVYabauLogPerson(gameid, itemcode, kind, framelv, pack11, pack21, pack31, pack41, pack51, pack61, yabaustep) values('xxxx2', 70002, 1, 20, 1, 1, 1, -1, -1, -1, 3)
-- MODE_YABAU_NORMAL, MODE_YABAU_PREMINUM
-- insert into dbo.tFVYabauLogPerson(gameid, itemcode, kind, framelv, pack11, pack21, pack31, pack41, pack51, pack61, result, cashcost, gamecost) values('xxxx2', 70002, 1, 20, 1, 1, 1, -1, -1, -1, 1, 1, 0)


-----------------------------------------------------
-- 이동 이력 기록( 경험치, 레벨, 마켓, 시간)
-----------------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserBeforeInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserBeforeInfo;
GO

create table dbo.tFVUserBeforeInfo(
	--(일반정보)
	idx			int 					IDENTITY(1, 1),
	gameid		varchar(60),
	market		int						default(1),				-- (구매처코드) MARKET_SKT
	marketnew	int						default(1),				-- (구매처코드) MARKET_SKT
	version		int						default(101),			-- 클라버젼

	fame		int						default(0),
	famelv		int						default(1),
	famelvbest	int						default(1),
	gameyear	int						default(2013),
	gamemonth	int						default(3),
	changedate	datetime				default(getdate()),
	-- Constraint
	CONSTRAINT pk_tFVUserBeforeInfo_gameid	PRIMARY KEY(idx)
)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserBeforeInfo_gameid_idx')
	DROP INDEX tFVUserBeforeInfo.idx_tFVUserBeforeInfo_gameid_idx
GO
CREATE INDEX idx_tFVUserBeforeInfo_gameid_idx ON tFVUserBeforeInfo (gameid, idx)
GO
-- if(@market != @market_)
--	begin
--		insert into dbo.tFVUserBeforeInfo(gameid,  market,  version,  fame,  famelv,  gameyear,  gamemonth)
--		values(                        @gameid, @market, @version, @fame, @famelv, @gameyear, @gamemonth)
--	end

*/