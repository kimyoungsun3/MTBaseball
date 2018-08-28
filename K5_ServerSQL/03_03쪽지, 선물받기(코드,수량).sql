---------------------------------------------------------------
/*
set @str = @gameid + '%'
select a.idx idx2, gameid, giftkind, message, gaindate, giftid, giftdate, b.*
from (select top 100 * from dbo.tGiftList where giftkind in (1, 2) and gameid = @gameid_ order by idx desc) a
	LEFT JOIN
	dbo.tItemInfo b
	ON a.itemcode = b.itemcode
order by idx2 desc

-- update dbo.tGiftList set giftkind = 2 where idx >= 1870 and gameid = 'xxxx2'
-- update dbo.tGiftList set giftkind = 1 where idx = 1925  and gameid = 'xxxx2'
-- delete from dbo.tUserItem where gameid = 'xxxx2' and listidx = 10
update dbo.tGiftList set giftkind = 2 where idx = 1 where gameid = 'xxxx2'

exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -1, 1925, -1, -1, -1, -1	-- 쪽지받기(삭제)
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1926, -1, -1, -1, -1	-- 소	(인벤)
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1927, -1,  2, -1, -1	-- 양	(필드2)
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1928, -1,  2, -1, -1	-- 산양 (필드2 충돌)
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1929, -1, -1, -1, -1	-- 총알
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1930, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1931, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1932, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1933, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1875, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1870, -1, -1,  1, -1	-- 백신
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1871, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1872, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1873, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1876, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1878, -1, -1,  1, -1	-- 일꾼
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1879, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1880, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1881, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1882, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1883, -1, -1,  1, -1	-- 촉진제
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1884, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1885, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1886, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1887, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1888, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1889, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1892, -1, -1, -1, -1	-- 부활석
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1893, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1894, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1897, -1, -1, -1, -1	-- 합성시간단축
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1898, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1899, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1901, -1, -1, -1, -1	-- 긴급요청티켓
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1902, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1903, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1874, -1, -1,  1, -1	-- 건초
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1877, -1, -1,  1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1910, -1, -1, -1, -1	-- 우정포인트
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1911, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1912, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1913, -1, -1, -1, -1	-- 하트
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1914, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1915, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1916, -1, -1, -1, -1	-- 캐쉬
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1917, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1918, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1919, -1, -1, -1, -1	-- 코인
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1920, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1921, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1904, -1, -1, -1, -1	-- 일반교배티켓
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1905, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1906, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1907, -1, -1, -1, -1	-- 프리미엄교배뽑기
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1908, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1909, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 3463, -1, -1, -1, -1	-- 황금티켓
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 3230, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 3464, -1, -1, -1, -1	-- 싸움티켓
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 3232, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 8866, -1, -1, -1, -1	-- 줄기세포.
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 3360, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 3361, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 3362, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 3363, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 3364, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 3365, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 10752, -1, -1, -1, -1	-- 보물받기.
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 8873, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 6695, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 8097, -1, -1, -1, -1	-- 보물티켓받기.
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 8098, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 8099, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 8100, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 24894, -1, -1, -1, -1	-- 합성의 훈장.
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 24893, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 24895, -1, -1, -1, -1	-- 승급의 꽃.
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 24896, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 28382, -1, -1, -1, -1	-- 유저배틀박스 > 받기까지만....
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 28383, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 28384, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 28385, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 28386, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 28387, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 31568, -1, -1, -1, -1	-- 짜요쿠폰.
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 31569, -1, -1, -1, -1	--
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 40354, -1, -1, -1, -1	-- 캐쉬포인트.
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 263704, -1, -1, -1, -1	--

exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1924, -1, -1, -1, -1	-- 펫선물(6).
exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -3, 1923, -1, -1, -1, -1	-- 펫선물(1).

exec spu_GiftGainNew 'xxxx2', '049000s1i0n7t8445289', -5, -1, -1, -1, -1, -1	-- 리스트갱신
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_GiftGainNew', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_GiftGainNew;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_GiftGainNew
	@gameid_				varchar(20),						-- 게임아이디
	@password_				varchar(20),						-- 암호화해서저장, 유저패스워가 해킹당해도 안전
	@giftkind_				int,								--  1:메시지
																--  2:선물
																-- -1:메시지삭제
																-- -2:선물삭제
																-- -3:선물받아감
	@idx_					bigint,								-- 선물인덱스
	@listidx_				int,								--
	@fieldidx_				int,								--
	@quickkind_				int,								--
	@nResult_				int					OUTPUT
	--WITH ENCRYPTION
as
	------------------------------------------------
	--	2-1. 코드값
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	-- 로그인 오류.
	declare @RESULT_ERROR_BLOCK_USER 			int				set @RESULT_ERROR_BLOCK_USER			= -11			--블럭유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_DELETED_USER 			int				set @RESULT_ERROR_DELETED_USER			= -12			--삭제유저 > 팝업처리후 인트로로 빼버린다.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함

	-- 선물 코드값
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50			-- 아이템코드못찾음
	declare @RESULT_ERROR_GIFTITEM_NOT_FOUND	int				set @RESULT_ERROR_GIFTITEM_NOT_FOUND	= -51			-- 선물아이템을 못찾음
	declare @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	int				set @RESULT_ERROR_GIFTITEM_ALREADY_GAIN	= -52			-- 선물을 이미 가져감
	declare @RESULT_ERROR_NOT_FOUND_GIFTID		int				set @RESULT_ERROR_NOT_FOUND_GIFTID		= -75			-- 캐쉬 > 선물할 아이디를 못찾음

	-- 기타오류
	declare @RESULT_ERROR_NOT_SUPPORT_MODE		int				set @RESULT_ERROR_NOT_SUPPORT_MODE		= -70			-- 지원하지않는모드
	declare @RESULT_ERROR_INVEN_FULL			int				set @RESULT_ERROR_INVEN_FULL			= -101			-- 인벤부족
	declare @RESULT_ERROR_NOT_MATCH				int				set @RESULT_ERROR_NOT_MATCH				= -110			-- 무엇인가 매치가 안되었다.

	------------------------------------------------
	--	2-2. 정의된값
	------------------------------------------------
	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	--declare @USERITEM_INVENKIND_ACC			int 				set @USERITEM_INVENKIND_ACC					= 4
	--declare @USERITEM_INVENKIND_DIRECT		int 				set @USERITEM_INVENKIND_DIRECT				= 40
	--declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000
	declare @USERITEM_INVENKIND_STEMCELL		int 				set @USERITEM_INVENKIND_STEMCELL			= 1040
	declare @USERITEM_INVENKIND_TREASURE		int 				set @USERITEM_INVENKIND_TREASURE			= 1200

	-- 아이템 소종류
	--declare @ITEM_SUBCATEGORY_COW				int					set @ITEM_SUBCATEGORY_COW 					= 1  -- 소		(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_GOAT			int					set @ITEM_SUBCATEGORY_GOAT 					= 2  -- 양		(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_SHEEP			int					set @ITEM_SUBCATEGORY_SHEEP 				= 3  -- 산양	(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_SEED			int					set @ITEM_SUBCATEGORY_SEED 					= 7  -- 씨앗	(판매[X], 선물[X], 직접[O])	0
	declare @ITEM_SUBCATEGORY_BULLET			int					set @ITEM_SUBCATEGORY_BULLET 				= 8  -- 총알	(판매[O], 선물[O])			0
	declare @ITEM_SUBCATEGORY_VACCINE			int					set @ITEM_SUBCATEGORY_VACCINE 				= 9  -- 백신	(판매[O], 선물[O])			0
	declare @ITEM_SUBCATEGORY_FEED				int					set @ITEM_SUBCATEGORY_FEED 					= 44 -- 건초	(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_ALBA				int					set @ITEM_SUBCATEGORY_ALBA 					= 11 -- 일꾼	(판매[O], 선물[O])			0
	declare @ITEM_SUBCATEGORY_BOOSTER			int					set @ITEM_SUBCATEGORY_BOOSTER 				= 12 -- 촉진제	(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_REVIVAL			int					set @ITEM_SUBCATEGORY_REVIVAL 				= 13 -- 부활석	(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_COMPOSE_TIME	int					set @ITEM_SUBCATEGORY_COMPOSE_TIME 			= 16 -- 합성1시간 초기화(판매[X], 선물[O])
	--declare @ITEM_SUBCATEGORY_ACC				int					set @ITEM_SUBCATEGORY_ACC 					= 15 -- 악세	(판매[O], 선물[O])			0
	declare @ITEM_SUBCATEGORY_FPOINT			int					set @ITEM_SUBCATEGORY_FPOINT 				= 19 -- 우정포인트(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_HEART				int					set @ITEM_SUBCATEGORY_HEART 				= 40 -- 하트	(판매[O], 선물[O])
	--declare @ITEM_SUBCATEGORY_HELPER			int					set @ITEM_SUBCATEGORY_HELPER 				= 41 -- 긴급요청(판매[X], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_TRADESAFE		int					set @ITEM_SUBCATEGORY_TRADESAFE				= 42 -- 상인만족(판매[X], 선물[O])			0
	declare @ITEM_SUBCATEGORY_CASHCOST			int					set @ITEM_SUBCATEGORY_CASHCOST 				= 50 -- 캐쉬	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_GAMECOST			int					set @ITEM_SUBCATEGORY_GAMECOST 				= 51 -- 코인	(판매[O], 선물[O])
	--declare @ITEM_SUBCATEGORY_ROULETTE_NOR	int					set @ITEM_SUBCATEGORY_ROULETTE_NOR			= 22 -- 일반 교배 뽑기티켓(판매[X], 선물[O])
	--declare @ITEM_SUBCATEGORY_ROULETTE_PRE	int					set @ITEM_SUBCATEGORY_ROULETTE_PRE			= 23 -- 프리미엄 교배 뽑기티켓(판매[X], 선물[O])
	--declare @ITEM_SUBCATEGORY_TREASURE_NOR	int					set @ITEM_SUBCATEGORY_TREASURE_NOR			= 25 -- 일반 보물 뽑기티켓
	--declare @ITEM_SUBCATEGORY_TREASURE_PRE	int					set @ITEM_SUBCATEGORY_TREASURE_PRE			= 26 -- 프리미엄 보물 뽑기티켓
	--declare @ITEM_SUBCATEGORY_CONTEST			int					set @ITEM_SUBCATEGORY_CONTEST 				= 53 -- 대회	(판매[O], 선물[O])			0
	--declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE	int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 -- 집
	--declare @ITEM_SUBCATEGORY_UPGRADE_TANK	int					set @ITEM_SUBCATEGORY_UPGRADE_TANK 			= 61 -- 탱크
	--declare @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL	int				set @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL 	= 62 -- 저온보관
	--declare @ITEM_SUBCATEGORY_UPGRADE_PURE	int					set @ITEM_SUBCATEGORY_UPGRADE_PURE 			= 63 -- 정화시설
	--declare @ITEM_SUBCATEGORY_UPGRADE_BOTTLE	int					set @ITEM_SUBCATEGORY_UPGRADE_BOTTLE 		= 64 -- 양동이
	--declare @ITEM_SUBCATEGORY_UPGRADE_PUMP	int					set @ITEM_SUBCATEGORY_UPGRADE_PUMP 			= 65 -- 착유기
	--declare @ITEM_SUBCATEGORY_UPGRADE_TRANSFER	int				set @ITEM_SUBCATEGORY_UPGRADE_TRANSFER 		= 66 -- 주입기
	--declare @ITEM_SUBCATEGORY_INVEN			int					set @ITEM_SUBCATEGORY_INVEN 				= 67 -- 인벤확장
	--declare @ITEM_SUBCATEGORY_SEEDFIELD		int					set @ITEM_SUBCATEGORY_SEEDFIELD 			= 68 -- 경작지확장
	--declare @ITEM_SUBCATEGORY_DOGAM			int					set @ITEM_SUBCATEGORY_DOGAM 				= 818 -- 도감
	--declare @ITEM_SUBCATEGORY_SYSINFO			int					set @ITEM_SUBCATEGORY_SYSINFO 				= 500 -- 정보수집
	--declare @ITEM_SUBCATEGORY_ATTENDANCE		int					set @ITEM_SUBCATEGORY_ATTENDANCE 			= 900 	--출석(900)
	--declare @ITEM_SUBCATEGORY_COMPETITION		int					set @ITEM_SUBCATEGORY_COMPETITION 			= 901 	--경쟁모드(901)
	declare @ITEM_SUBCATEGORY_PET				int					set @ITEM_SUBCATEGORY_PET					= 1000 	--펫(1000)
	declare @ITEM_SUBCATEGORY_GOLDTICKET		int					set @ITEM_SUBCATEGORY_GOLDTICKET			= 30	-- 황금티켓.
	declare @ITEM_SUBCATEGORY_BATTLETICKET		int					set @ITEM_SUBCATEGORY_BATTLETICKET			= 31	-- 싸움티켓.
	--declare @ITEM_SUBCATEGORY_STEMCELL		int					set @ITEM_SUBCATEGORY_STEMCELL				= 1040	-- 줄기세포.
	--declare @ITEM_SUBCATEGORY_TREASURE		int					set @ITEM_SUBCATEGORY_TREASURE				= 1200	-- 보물.
	--declare @ITEM_SUBCATEGORY_COMPOSETICKET	int					set @ITEM_SUBCATEGORY_COMPOSETICKET			= 35	-- 합성의 훈장(35)
	--declare @ITEM_SUBCATEGORY_PROMOTETICKET	int					set @ITEM_SUBCATEGORY_PROMOTETICKET	 		= 36	-- 승급의 꽃(36)
	declare @ITEM_SUBCATEGORY_USERBATTLEBOX		int					set @ITEM_SUBCATEGORY_USERBATTLEBOX			= 37	-- 유저배틀박스(37)
	--declare @ITEM_SUBCATEGORY_ZZCOUPON		int					set @ITEM_SUBCATEGORY_ZZCOUPON				= 38	-- 짜요 쿠폰(38)
	declare @ITEM_SUBCATEGORY_CASHPOINT			int					set @ITEM_SUBCATEGORY_CASHPOINT				= 39	-- 낙농포인트(39)

	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4
	declare @GIFTLIST_GIFT_KIND_LIST			int					set @GIFTLIST_GIFT_KIND_LIST				= -5

	-- 아이템 획득방법
	declare @DEFINE_HOW_GET_FIRST				int					set @DEFINE_HOW_GET_FIRST					= 0	--기본
	declare @DEFINE_HOW_GET_BUY					int					set @DEFINE_HOW_GET_BUY						= 1	--구매
	declare @DEFINE_HOW_GET_SEEDFIELD			int					set @DEFINE_HOW_GET_SEEDFIELD				= 2	--경작
	declare @DEFINE_HOW_GET_ROULETTE			int					set @DEFINE_HOW_GET_ROULETTE				= 3	--교배/뽑기
	declare @DEFINE_HOW_GET_SEARCH				int					set @DEFINE_HOW_GET_SEARCH					= 4	--검색
	declare @DEFINE_HOW_GET_GIFT				int					set @DEFINE_HOW_GET_GIFT					= 5	--검색

	-- 동물정보.
	-- 필드동물 0 ~ 8.
	declare @USERITEM_FIELDIDX_INVEN			int					set @USERITEM_FIELDIDX_INVEN				= -1	-- 창고.
	declare @USERITEM_FIELDIDX_HOSPITAL			int					set @USERITEM_FIELDIDX_HOSPITAL				= -2	-- 병원.

	-- 소모템 > 퀵슬롯에 착용위치.
	declare @USERMASTER_QUICKKIND_NON			int					set @USERMASTER_QUICKKIND_NON				= -1 --없음.
	declare @USERMASTER_QUICKKIND_SETTING		int					set @USERMASTER_QUICKKIND_SETTING			=  1 --총알, 백신, 촉진, 알바.

	-- 펫기타 정보
	declare @USERITEM_PET_UPGRADE_MAX			int					set @USERITEM_PET_UPGRADE_MAX				= 6	-- 업그레이드 맥스.
	declare @USERITEM_TREASURE_UPGRADE_MAX		int					set @USERITEM_TREASURE_UPGRADE_MAX			= 7	-- max강화.

	-- 특수템.
	declare @ITEM_ZCP_PIECE_MOTHER				int					set @ITEM_ZCP_PIECE_MOTHER					= 3800	-- 짜요쿠폰조각.
	declare @ITEM_ZCP_TICKET_MOTHER				int					set @ITEM_ZCP_TICKET_MOTHER					= 3801	-- 짜요쿠폰.

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @gameid			varchar(20)		set @gameid		= ''
	declare @itemcode		int
	declare @giftkind		int				set @giftkind 	= -1
	declare @cashcost		int				set @cashcost 	= 0
	declare @gamecost		int				set @gamecost 	= 0
	declare @heart			int				set @heart 		= 0
	declare @feed			int				set @feed 		= 0
	declare @fpoint			int				set @fpoint		= 0
	declare @goldticket		int				set @goldticket	= 0
	declare @battleticket	int				set @battleticket= 0
	declare @cashpoint		int				set @cashpoint 	= 0

	declare @invenanimalmax	int
	declare @invencustommax int
	declare @invenaccmax	int
	declare @invenstemcellmax	int
	declare @inventreasuremax	int

	declare @subcategory 	int,
			@buyamount		int,
			@invenkind		int

	declare @comment		varchar(80)
	declare @plus	 		int 			set @plus			= 0
	declare @plus2	 		int 			set @plus2			= 0
	declare @cashcostplus	int				set @cashcostplus	= 0

	declare @cnt 			int
	declare @cnt2 			int				set @cnt2			=  0
	declare @listidx2		int				set @listidx2		=  -1
	declare @upstepmax		int				set @upstepmax		=  8
	declare @listidxtreasure	int			set @listidxtreasure= -1
	declare @sendcnt 		int				set @sendcnt		=  0
	declare @listidxnew 	int				set @listidxnew		= -1
	declare @listidxcust 	int				set @listidxcust	= -1
	declare @listidxpet 	int				set @listidxpet		= -1
	declare @petupgradeinit	int				set @petupgradeinit	=  1
	declare @listidxrtn 	int				set @listidxrtn		= -1
	declare @fieldidx 		int

	declare @dummy	 		int
	declare @sellcost		int				set @sellcost		= 0

	-- 유저배틀박스
	declare @boxslotidx		int				set @boxslotidx		= -1
	declare @boxslottime	datetime		set @boxslottime	= getdate()
	declare @boxslot1 		int				set @boxslot1		= -1
	declare @boxslot2 		int				set @boxslot2		= -1
	declare @boxslot3 		int				set @boxslot3		= -1
	declare @boxslot4 		int				set @boxslot4		= -1

	-- 필드오픈.
	declare @field0			int				set @field0			= -1
	declare @field1			int				set @field1			= -1
	declare @field2			int				set @field2			= -1
	declare @field3			int				set @field3			= -1
	declare @field4			int				set @field4			= -1
	declare @field5			int				set @field5			= -1
	declare @field6			int				set @field6			= -1
	declare @field7			int				set @field7			= -1
	declare @field8			int				set @field8			= -1

	DECLARE @tTempTable TABLE(
		listidx		int
	);
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	set @comment  = '알수 없는 오류가 발생했습니다.'
	--select 'DEBUG 1-1 입력값', @gameid_ gameid_, @password_ password_, @giftkind_ giftkind_, @idx_ idx_, @listidx_ listidx_, @fieldidx_ fieldidx_, @quickkind_ quickkind_

	if(@fieldidx_ < -1 or @fieldidx_ >= 9)
		begin
			--select 'DEBUG 1-2 인벤번호가 잘못되어서 인벤으로 루비.'
			set @fieldidx_ = @USERITEM_FIELDIDX_INVEN
		end

	------------------------------------------------
	--	3-2. 연산수행(유저정보, 선물정보, 아이템 종류)
	------------------------------------------------
	select
		@gameid 		= gameid,
		@cashcost		= cashcost,			@gamecost		= gamecost,			@heart			= heart,			@cashpoint		= cashpoint,
		@feed			= feed,				@fpoint			= fpoint,			@goldticket 	= goldticket, 		@battleticket	= battleticket,
		@invenanimalmax	= invenanimalmax,
		@invencustommax = invencustommax,
		@invenaccmax 	= invenaccmax,
		@invenstemcellmax= invenstemcellmax,@inventreasuremax = inventreasuremax,
		@boxslotidx		= boxslotidx,		@boxslottime	= boxslottime,
		@boxslot1		= boxslot1,			@boxslot2		= boxslot2,			@boxslot3		= boxslot3,			@boxslot4		= boxslot4,

		@field0			= field0,			@field1			= field1,			@field2			= field2,
		@field3			= field3,			@field4			= field4,			@field5			= field5,
		@field6			= field6,			@field7			= field7,			@field8			= field8
	from dbo.tUserMaster where gameid = @gameid_ and password = @password_
	--select 'DEBUG 1-3 유저정보', @gameid gameid, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @invenanimalmax invenanimalmax, @invencustommax invencustommax, @invenaccmax invenaccmax

	select
		@giftkind 	= giftkind,
		@itemcode 	= itemcode,
		@sendcnt	= cnt
	from dbo.tGiftList where gameid = @gameid_ and idx = @idx_
	--select 'DEBUG 1-4 선물/쪽지', @giftkind giftkind, @itemcode itemcode, @sendcnt sendcnt

	------------------------------------------------
	--	3-3. 각상황별로 코드로 분류
	------------------------------------------------
	if(@gameid = '')
		BEGIN
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= 'ERROR 아이디가 존재하지 않는다.'
			--select 'DEBUG ' + @comment
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_LIST)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 선물 리스트 갱신.'
			--select 'DEBUG ' + @comment

			set @listidxrtn = -1
		END
	else if isnull(@giftkind, -1) = -1
		BEGIN
			set @nResult_ = @RESULT_ERROR_GIFTITEM_NOT_FOUND
			set @comment = 'ERROR 선물, 쪽지 존재자체를 안함'
			--select 'DEBUG ' + @comment
		END
	else if (@giftkind in (@GIFTLIST_GIFT_KIND_MESSAGE_DEL, @GIFTLIST_GIFT_KIND_GIFT_DEL, @GIFTLIST_GIFT_KIND_GIFT_GET, @GIFTLIST_GIFT_KIND_GIFT_SELL, @GIFTLIST_GIFT_KIND_LIST))
		BEGIN
			set @nResult_ = @RESULT_ERROR_GIFTITEM_ALREADY_GAIN
			set @comment = 'ERROR 지급 및 삭제되었습니다.'
			--select 'DEBUG ' + @comment
		END
	else if (@giftkind_ not in (@GIFTLIST_GIFT_KIND_MESSAGE_DEL, @GIFTLIST_GIFT_KIND_GIFT_DEL, @GIFTLIST_GIFT_KIND_GIFT_GET, @GIFTLIST_GIFT_KIND_GIFT_SELL, @GIFTLIST_GIFT_KIND_LIST))
		BEGIN
			set @nResult_ = @RESULT_ERROR_NOT_SUPPORT_MODE
			set @comment = 'ERROR 지원하지 않는 모드값입니다.'
			--select 'DEBUG ' + @comment
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_MESSAGE_DEL)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 메세지 삭제 처리합니다.'
			--select 'DEBUG ' + @comment

			update dbo.tGiftList set giftkind = @giftkind_ where idx = @idx_
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_GIFT_DEL)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 선물 삭제 처리합니다.'
			--select 'DEBUG ' + @comment

			update dbo.tGiftList set giftkind = @giftkind_ where idx = @idx_
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_GIFT_SELL)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 선물함을 물건을 팔아라.'
			--select 'DEBUG ' + @comment

			------------------------------------------
			-- 아이템을 판매하는 형태.
			------------------------------------------
			select
				@buyamount 	= buyamount,
				@sellcost 	= sellcost
			from dbo.tItemInfo where itemcode = @itemcode

			if(@sendcnt > 0)
				begin
					set @gamecost = @gamecost + @sellcost * @sendcnt
				end
			else
				begin
					set @gamecost = @gamecost + @sellcost * @buyamount
				end

			update dbo.tGiftList set giftkind = @giftkind_ where idx = @idx_
			update dbo.tUserMaster
				set
					gamecost = @gamecost
			where gameid = @gameid_
		END
	else if(@giftkind_ = @GIFTLIST_GIFT_KIND_GIFT_GET)
		BEGIN
			set @nResult_ = @RESULT_SUCCESS
			set @comment = 'SUCCESS 정상 지급 처리합니다.'

			select
				@subcategory 	= subcategory,
				@buyamount 		= buyamount,
				@upstepmax		= param30
			from dbo.tItemInfo where itemcode = @itemcode
			--select 'DEBUG 4-0 ', @subcategory subcategory, @buyamount buyamount, @sendcnt sendcnt

			set @buyamount = case when(@sendcnt > 0) then @sendcnt else @buyamount end
			set @invenkind = dbo.fnu_GetInvenFromSubCategory(@subcategory)
			select @listidxnew = isnull(MAX(listidx), 0) + 1 from dbo.tUserItem where gameid = @gameid_

			--select 'DEBUG 4-1 ', @subcategory subcategory, @buyamount buyamount, @sendcnt sendcnt, @invenkind invenkind, @listidxnew listidxnew

			if(@invenkind = @USERITEM_INVENKIND_ANI)
				begin
					--------------------------------------------------------------
					-- 동물 아이템 > 인벤수량파악
					--------------------------------------------------------------
					select @cnt = count(*)
					from dbo.tUserItem
					where gameid = @gameid_
						  and invenkind = @invenkind
						  and fieldidx != @USERITEM_FIELDIDX_HOSPITAL
					--select 'DEBUG 4-2 동물(1)인벤넣기', @cnt cnt, @invenanimalmax invenanimalmax

					--------------------------------------------------------------
					-- 소,양,산양			-> 동물 아이템
					--------------------------------------------------------------
					if(@cnt >= @invenanimalmax)
						begin
							set @nResult_ = @RESULT_ERROR_INVEN_FULL
							set @comment = 'ERROR 동물 인벤이 풀입니다.'
							--select 'DEBUG ' + @comment, @cnt cnt, @invenanimalmax invenanimalmax
						end
					else
						begin
							--select 'DEBUG 4-2-2 선물 > 인벤 or 필드, 이벤 지급 상태로 변경', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @idx_ idx_
							if(@fieldidx_ = -1)
								begin
									set @fieldidx = @fieldidx_
									--select 'DEBUG 4-2-3 선물 > 필드풀이라서 인벤에 넣어두라(클라에서 요청함).', @fieldidx fieldidx
								end
							else if(exists(select top 1 * from dbo.tUserItem where gameid = @gameid_ and fieldidx = @fieldidx_))
								begin
									---------------------------------------------------
									-- 빈자리 찾기 커서
									-- 0   2 3 4 5 		 >  1
									-- 0 1 2 3 4 5 		 >  6
									-- 0 1 2 3 4 5 6 7 8 > -1
									---------------------------------------------------
									set @fieldidx = dbo.fun_getUserItemFieldIdxAni(@gameid_)
									--select 'DEBUG 4-2-3 선물 > 지정(충돌)', @fieldidx fieldidx
								end
							else
								begin
									set @fieldidx = @fieldidx_
									--select 'DEBUG 4-2-3 선물 > 필드가 유효해서 그대로 넣어라.', @fieldidx fieldidx
								end

							-- 필드가 허용하는 범위인가?
							--select 'DEBUG (전)', @fieldidx fieldidx, @field0 field0, @field1 field1, @field2 field2, @field3 field3, @field4 field4, @field5 field5, @field6 field6, @field7 field7, @field8 field8
							set @fieldidx = dbo.fun_getUserItemFieldCheck(@fieldidx,
																		  @field0, @field1, @field2,
																		  @field3, @field4, @field5,
																		  @field6, @field7, @field8)
							--select 'DEBUG (후)', @fieldidx fieldidx, @field0 field0, @field1 field1, @field2 field2, @field3 field3, @field4 field4, @field5 field5, @field6 field6, @field7 field7, @field8 field8

							-- 해당아이템 인벤에 지급
							insert into dbo.tUserItem(gameid,      listidx,  itemcode, cnt, farmnum,  fieldidx,  invenkind,  upstepmax, gethow)		-- 동물.
							values(					 @gameid_, @listidxnew, @itemcode,   1,       0, @fieldidx, @invenkind, @upstepmax, @DEFINE_HOW_GET_GIFT)

							-- 도감기록
							exec spu_DogamListLog @gameid_, @itemcode

							-- 아이템 가져간 상태로 돌려둔다.
							update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_

							-- 변경된 아이템 리스트인덱스
							set @listidxrtn	= @listidxnew

							--select 'DEBUG ', @listidxrtn listidxrtn, @fieldidx fieldidx
						end
				end
			else if(@invenkind = @USERITEM_INVENKIND_CONSUME and @itemcode = @ITEM_ZCP_PIECE_MOTHER )
				begin
					--------------------------------------------------------------
					-- 짜요쿠폰조각 > 인벤수량파악
					--------------------------------------------------------------
					select @cnt = count(*) from dbo.tUserItem
					where gameid = @gameid_
						  and invenkind = @invenkind
						  and cnt > 0

					--------------------------------------------------------------
					-- 보유량 확인.
					--------------------------------------------------------------
					select
						@cnt2			= cnt,
						@listidxcust 	= listidx
					from dbo.tUserItem
					where gameid = @gameid_ and itemcode = @itemcode
					--select 'DEBUG 4-3 짜요쿠폰조각 인벤넣기', @gameid_ gameid_, @subcategory subcategory, @itemcode itemcode, @cnt2 cnt2, @listidxcust listidxcust, @cnt cnt, @invencustommax invencustommax

					-------------------------------------------------
					-- 링크 번호 오류에 대한 방어코드.
					-------------------------------------------------
					if( @listidx_ =  -1 and @listidxcust != -1 )
						begin
							-- 링크 번호가 없다고 하는데 링크 번호가 있네요. > 재세팅.
							set @listidx_ = @listidxcust
						end
					else if( @listidx_ !=  @listidxcust )
						begin
							set @listidx_ = @listidxcust
						end

					-------------------------------------------------
					-- 결과전송.
					-------------------------------------------------
					if(@listidxcust = -1 and (@cnt >= (@invencustommax + 4)))
						begin
							set @nResult_ = @RESULT_ERROR_INVEN_FULL
							set @comment = 'ERROR 소비 인벤이 풀입니다.'
							--select 'DEBUG ' + @comment
						end
					else
						begin
							--select 'DEBUG 4-3-2 선물 > 인벤으로 이동, 이벤 지급 상태로 변경'
							---------------------------------------------------
							-- 빈자리 찾기 커서
							-- 0 [1] 2 3 4 5 	> [1] > update
							-- 0 1 2 3 4 5 6  	> 없음 > insert
							-- @listidxcust = @listidx_ (동일함)
							---------------------------------------------------
							if(@listidxcust = -1)
								begin
									--select 'DEBUG 소비 추가', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @buyamount buyamount

									insert into dbo.tUserItem(gameid,      listidx,  itemcode,        cnt,  invenkind, gethow)
									values(					@gameid_,  @listidxnew, @itemcode, @buyamount, @invenkind, @DEFINE_HOW_GET_GIFT)

									-- 변경된 아이템 리스트인덱스
									set @listidxrtn	= @listidxnew
								end
							else
								begin
									--select 'DEBUG 소비 보유템에 누적', @gameid_ gameid_, @listidxcust listidxcust, @buyamount buyamount

									update dbo.tUserItem
										set
											cnt = cnt + @buyamount
									where gameid = @gameid_ and listidx = @listidxcust

									-- 변경된 아이템 리스트인덱스
									set @listidxrtn	= @listidxcust
								end


							---------------------------------------------------
							-- 아이템 직접지급
							-- 99개를 나누는 방식으로 차감.
							---------------------------------------------------
							select @cnt2 = cnt from dbo.tUserItem where gameid = @gameid_ and listidx = @listidxrtn
							--select 'DEBUG ', @cnt2 cnt2
							while( @cnt2 >= 99 )
								begin
									--select 'DEBUG 짜요쿠폰조각(99개) -> 짜요쿠폰 (1개)'
									exec spu_SetDirectItemNew @gameid_, @ITEM_ZCP_TICKET_MOTHER, 1, @DEFINE_HOW_GET_GIFT, @rtn_ = @listidx2 OUTPUT
									insert into @tTempTable( listidx ) values( @listidx2 )

									-- 수량감소후에 개수 갱신해주기.
									set @cnt2 = @cnt2 - 99

									update dbo.tUserItem
										set
											cnt = @cnt2
									where gameid = @gameid_ and listidx = @listidxrtn
								end


							-- 아이템 가져간 상태로 돌려둔다.
							--select 'DEBUG > ', @idx_ idx_
							update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
						end
				end
			else if(@invenkind = @USERITEM_INVENKIND_CONSUME and @itemcode = @ITEM_ZCP_TICKET_MOTHER )
				begin
					--------------------------------------------------------------
					-- 짜요쿠폰 (60일 만기일).
					--------------------------------------------------------------
					--select 'DEBUG 짜요쿠폰 insert', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @buyamount buyamount
					insert into dbo.tUserItem(gameid,       listidx,  itemcode,        cnt, expirekind,     expiredate,  invenkind,  gethow)
					values(					 @gameid_,  @listidxnew, @itemcode, @buyamount,          1, getdate() + 60, @invenkind, @DEFINE_HOW_GET_GIFT)

					-- 변경된 아이템 리스트인덱스
					set @listidxrtn	= @listidxnew

					-- 아이템 가져간 상태로 돌려둔다.
					--select 'DEBUG > ', @idx_ idx_
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@invenkind = @USERITEM_INVENKIND_CONSUME)
				begin
					--------------------------------------------------------------
					-- 동물 아이템 > 인벤수량파악
					--------------------------------------------------------------
					select @cnt = count(*)
					from dbo.tUserItem
					where gameid = @gameid_
						  and invenkind = @invenkind
						  and cnt > 0

					--------------------------------------------------------------
					-- 총알					-> 소모성 아이템0
					-- 백신					-> 소모성 아이템0
					-- 알바					-> 소모성 아이템0
					-- 촉진제				-> 소모성 아이템0
					-- 부활석				-> 소모성 아이템 (여러코드 > 1개로 통일됨)
					-- 합성시간		 		-> 소모성 아이템
					-- 긴급요청 티켓		-> 소모성 아이템 (여러코드 > 1개로 통일됨)
					-- 일반교배뽑기 티켓	-> 소모성 아이템
					-- 프리미엄교배뽑기 티켓-> 소모성 아이템
					--------------------------------------------------------------
					set @itemcode = dbo.fnu_GetItemcodeFromConsumePackage(@subcategory, @itemcode)

					select
						@listidxcust = listidx
					from dbo.tUserItem
					where gameid = @gameid_ and itemcode = @itemcode
					--select 'DEBUG 4-3 소비(n)인벤넣기', @gameid_ gameid_, @subcategory subcategory, @itemcode itemcode, @listidxcust listidxcust, @cnt cnt, @invencustommax invencustommax

					-------------------------------------------------
					-- 링크 번호 오류에 대한 방어코드.
					-------------------------------------------------
					if(@listidx_ =  -1 and @listidxcust != -1)
						begin
							-- 링크 번호가 없다고 하는데 링크 번호가 있네요. > 재세팅.
							set @listidx_ = @listidxcust
						end

					if(@listidxcust = -1 and (@cnt >= (@invencustommax + 4)))
						begin
							set @nResult_ = @RESULT_ERROR_INVEN_FULL
							set @comment = 'ERROR 소비 인벤이 풀입니다.'
							--select 'DEBUG ' + @comment
						end
					else if(@listidx_ !=  @listidxcust)
						begin
							-- and @subcategory in (@ITEM_SUBCATEGORY_BULLET, @ITEM_SUBCATEGORY_VACCINE, @ITEM_SUBCATEGORY_ALBA, @ITEM_SUBCATEGORY_BOOSTER)
							set @nResult_ = @RESULT_ERROR_NOT_MATCH
							set @comment = 'ERROR 소모템의 지정리스트('+ltrim(rtrim(str(@listidx_)))+') 내부존재번호('+ltrim(rtrim(str(@listidxcust)))+')가 불일치.'
							--select 'DEBUG ' + @comment
						end
					else
						begin
							--select 'DEBUG 4-3-2 선물 > 인벤으로 이동, 이벤 지급 상태로 변경'
							---------------------------------------------------
							-- 빈자리 찾기 커서
							-- 0 [1] 2 3 4 5 	> [1] > update
							-- 0 1 2 3 4 5 6  	> 없음 > insert
							-- @listidxcust = @listidx_ (동일함)
							---------------------------------------------------
							if(@listidxcust = -1)
								begin
									--select 'DEBUG 소비 추가', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @buyamount buyamount

									insert into dbo.tUserItem(gameid,      listidx,  itemcode,        cnt,  invenkind, gethow)
									values(					@gameid_,  @listidxnew, @itemcode, @buyamount, @invenkind, @DEFINE_HOW_GET_GIFT)

									-- 변경된 아이템 리스트인덱스
									set @listidxrtn	= @listidxnew
								end
							else
								begin
									--select 'DEBUG 소비 보유템에 누적', @gameid_ gameid_, @listidxcust listidxcust, @buyamount buyamount

									update dbo.tUserItem
										set
											cnt = cnt + @buyamount
									where gameid = @gameid_ and listidx = @listidxcust

									-- 변경된 아이템 리스트인덱스
									set @listidxrtn	= @listidxcust
								end

							if(@quickkind_ = @USERMASTER_QUICKKIND_SETTING)
								begin
									--select 'DEBUG > 세팅을 추가한다.'
									update dbo.tUserMaster
										set
											bulletlistidx 	= case when (@subcategory = @ITEM_SUBCATEGORY_BULLET) 	then @listidxrtn else bulletlistidx end,
											vaccinelistidx	= case when (@subcategory = @ITEM_SUBCATEGORY_VACCINE) 	then @listidxrtn else vaccinelistidx end,
											boosterlistidx	= case when (@subcategory = @ITEM_SUBCATEGORY_BOOSTER)	then @listidxrtn else boosterlistidx end,
											albalistidx		= case when (@subcategory = @ITEM_SUBCATEGORY_ALBA) 	then @listidxrtn else albalistidx end
									where gameid = @gameid_
								end

							-- 아이템 가져간 상태로 돌려둔다.
							--select 'DEBUG > ', @idx_ idx_
							update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
						end
				end
			else if(@invenkind = @USERITEM_INVENKIND_STEMCELL)
				begin
					--------------------------------------------------------------
					-- 줄기세포					-> 수량파악
					--------------------------------------------------------------
					select @cnt = count(*)
					from dbo.tUserItem
					where gameid = @gameid_
						  and invenkind = @invenkind

					--------------------------------------------------------------
					-- 줄기세포					-> 줄기세포 아이템
					--------------------------------------------------------------
					--select 'DEBUG 4-4 줄기세포 인벤넣기', @cnt cnt, @invenstemcellmax invenstemcellmax
					if(@cnt >= @invenstemcellmax)
						begin
							set @nResult_ = @RESULT_ERROR_INVEN_FULL
							set @comment = 'ERROR 줄기세포 인벤이 풀입니다.'
							--select 'DEBUG ' + @comment, @invenstemcellmax invenstemcellmax
						end
					else
						begin
							--select 'DEBUG 4-4-2 선물 > 인벤으로 이동, 이벤 지급 상태로 변경', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode

							insert into dbo.tUserItem(gameid,      listidx,  itemcode, invenkind,  gethow)		-- 악세
							values(					 @gameid_, @listidxnew, @itemcode, @invenkind, @DEFINE_HOW_GET_GIFT)

							-- 아이템 가져간 상태로 돌려둔다.
							update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_

							-- 변경된 아이템 리스트인덱스
							set @listidxrtn	= @listidxnew
						end
				end
			else if(@invenkind = @USERITEM_INVENKIND_TREASURE)
				begin
					--------------------------------------------------------------
					-- 보물					-> 수량파악
					--------------------------------------------------------------
					select @cnt = count(*)
					from dbo.tUserItem
					where gameid = @gameid_ and invenkind = @invenkind

					--------------------------------------------------------------
					-- 보물					-> 보물 아이템
					--------------------------------------------------------------
					--select 'DEBUG 4-4 보물 인벤넣기', @cnt cnt, @inventreasuremax inventreasuremax, @listidxtreasure listidxtreasure
					if( @cnt >= @inventreasuremax )
						begin
							set @nResult_ = @RESULT_ERROR_INVEN_FULL
							set @comment = 'ERROR 보물 인벤이 풀입니다.'
							--select 'DEBUG ' + @comment, @inventreasuremax inventreasuremax
						end
					else
						begin
							--select 'DEBUG 4-4-1 선물 > 보물지급'

							insert into dbo.tUserItem(gameid,      listidx,  itemcode,  invenkind,                      upstepmax, gethow)
							values(					 @gameid_, @listidxnew, @itemcode, @invenkind, @USERITEM_TREASURE_UPGRADE_MAX, @DEFINE_HOW_GET_GIFT)

							-- 변경된 아이템 리스트인덱스
							set @listidxrtn	= @listidxnew

							---------------------------------
							-- 보물 보유효과 세팅.
							---------------------------------
							exec spu_TSRetentionEffect @gameid_, @itemcode
						end


					-- 아이템 가져간 상태로 돌려둔다.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@invenkind = @USERITEM_INVENKIND_PET)
				begin
					--------------------------------------------------------------
					-- 펫					-> 펫 아이템
					--------------------------------------------------------------
					--select 'DEBUG 4-4-2 선물 > 펫인벤으로 이동, 이벤 지급 상태로 변경', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode

					select
						@listidxpet = listidx
					from dbo.tUserItem
					where gameid = @gameid_ and itemcode = @itemcode
					--select 'DEBUG >', @listidxpet listidxpet, @listidx_ listidx_

					-------------------------------------------------
					-- 링크 번호 오류에 대한 방어코드.
					-------------------------------------------------
					if(@listidx_ =  -1 and @listidxpet != -1)
						begin
							-- 링크 번호가 없다고 하는데 링크 번호가 있네요. > 재세팅.
							set @listidx_ = @listidxpet
						end

					if(@listidx_ !=  @listidxpet)
						begin
							set @nResult_ = @RESULT_ERROR_NOT_MATCH
							set @comment = 'ERROR 펫 지정리스트('+ltrim(rtrim(str(@listidx_)))+') 내부존재번호('+ltrim(rtrim(str(@listidxpet)))+')가 불일치.'
							--select 'DEBUG ' + @comment
						end
					else
						begin
							select
								@petupgradeinit		= param5
							from dbo.tItemInfo where itemcode = @itemcode and subcategory = @ITEM_SUBCATEGORY_PET
							--select 'DEBUG >', @petupgradeinit petupgradeinit

							if(@listidxpet = -1)
								begin
									--select 'DEBUG 펫 추가', @gameid_ gameid_, @listidxnew listidxnew, @itemcode itemcode, @buyamount buyamount
									insert into dbo.tUserItem(gameid,      listidx,  itemcode, invenkind,       petupgrade,      gethow)		-- 펫
									values(					 @gameid_, @listidxnew, @itemcode, @invenkind, @petupgradeinit, @DEFINE_HOW_GET_GIFT)

									-- 펫도감기록.
									exec spu_DogamListPetLog @gameid_, @itemcode

									-- 변경된 아이템 리스트인덱스
									set @listidxrtn	= @listidxnew
								end
							else
								begin
									--select 'DEBUG 펫 업그레이드', @gameid_ gameid_, @listidxpet listidxpet

									update dbo.tUserItem
										set
											petupgrade = case
															when (petupgrade + 1 >= @USERITEM_PET_UPGRADE_MAX) then @USERITEM_PET_UPGRADE_MAX
															else													petupgrade + 1
														end
									where gameid = @gameid_ and listidx = @listidxpet

									-- 변경된 아이템 리스트인덱스
									set @listidxrtn	= @listidxpet
								end

							-- 아이템 가져간 상태로 돌려둔다.
							update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
						end
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_USERBATTLEBOX)
				begin
					---------------------------------------------------------------
					--select 'DEBUG 유저배틀박스'
					---------------------------------------------------------------
					set @dummy = -1
					if( @boxslot1 = -1 )
						begin
							set @boxslot1 		= @itemcode
							set @dummy 			= 1
						end
					else if( @boxslot2 = -1 )
						begin
							set @boxslot2 		= @itemcode
							set @dummy 			= 1
						end
					else if( @boxslot3 = -1 )
						begin
							set @boxslot3 		= @itemcode
							set @dummy 			= 1
						end
					else if( @boxslot4 = -1 )
						begin
							set @boxslot4 		= @itemcode
							set @dummy 			= 1
						end

					if(@dummy = -1)
						begin
							set @nResult_ = @RESULT_ERROR_INVEN_FULL
							set @comment = 'ERROR 인벤이 풀입니다.'
						end
					else
						begin
							-- 아이템을 직접 넣어줌
							update dbo.tUserMaster
								set
									boxslot1	= @boxslot1,
									boxslot2	= @boxslot2,
									boxslot3	= @boxslot3,
									boxslot4	= @boxslot4
							where gameid = @gameid_

							-- 아이템 가져간 상태로 돌려둔다.
							update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
						end
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_CASHCOST)
				begin
					---------------------------------------------------------------
					--select 'DEBUG 4-5-1 cashcost(캐시)	-> 바로적용', @cashcost cashcost, @buyamount buyamount
					---------------------------------------------------------------
					set @plus		= isnull(@buyamount, 0)
					set @cashcost	= @cashcost + @plus

					-- 아이템을 직접 넣어줌
					update dbo.tUserMaster
					set
						cashcost = @cashcost
					where gameid = @gameid_

					-- 아이템 가져간 상태로 돌려둔다.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_GAMECOST)
				begin
					--select 'DEBUG 4-5-2 gamecost(코인)	-> 바로적용', @gamecost gamecost, @buyamount buyamount
					set @plus		= isnull(@buyamount, 0)
					set @gamecost	= @gamecost + @plus

					update dbo.tUserMaster
					set
						gamecost = @gamecost
					where gameid = @gameid_

					-- 아이템 가져간 상태로 돌려둔다.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_FPOINT)
				begin
					--select 'DEBUG 4-5-3 우정포인트 -> 바로적용', @fpoint fpoint, @buyamount buyamount
					set @plus		= isnull(@buyamount, 0)
					set @fpoint		= @fpoint + @plus

					update dbo.tUserMaster
					set
						fpoint = @fpoint
					where gameid = @gameid_

					-- 아이템 가져간 상태로 돌려둔다.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_GOLDTICKET)
				begin
					--select 'DEBUG 4-6 황금티켓  -> 바로적용', @goldticket goldticket, @buyamount buyamount
					set @plus		= isnull(@buyamount, 0)
					set @goldticket	= @goldticket + @plus

					update dbo.tUserMaster
						set
							goldticket = @goldticket
					where gameid = @gameid_

					-- 아이템 가져간 상태로 돌려둔다.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_BATTLETICKET)
				begin
					--select 'DEBUG 4-7 싸움티켓  -> 바로적용', @battleticket battleticket, @buyamount buyamount
					set @plus		= isnull(@buyamount, 0)
					set @battleticket= @battleticket + @plus

					update dbo.tUserMaster
						set
							battleticket = @battleticket
					where gameid = @gameid_

					-- 아이템 가져간 상태로 돌려둔다.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_HEART)
				begin
					--select 'DEBUG 4-5-3 하트 -> 바로적용', @heart heart, @buyamount buyamount
					set @plus		= isnull(@buyamount, 0)
					set @heart		= @heart + @plus

					update dbo.tUserMaster
					set
						heart = @heart
					where gameid = @gameid_

					-- 아이템 가져간 상태로 돌려둔다.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_FEED)
				begin
					-- 맥스 초과되더라더 초과해서 들어간다.
					--select 'DEBUG 4-5-4 건초 -> 바로적용', @feed feed, @buyamount buyamount
					set @plus		= isnull(@buyamount, 0)
					set @feed		= @feed + @plus

					update dbo.tUserMaster
					set
						feed = @feed
					where gameid = @gameid_

					-- 아이템 가져간 상태로 돌려둔다.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else if(@subcategory = @ITEM_SUBCATEGORY_CASHPOINT)
				begin
					--select 'DEBUG 4-5-4 cashpoint -> 바로적용', @cashpoint feed, @buyamount buyamount
					set @plus		= isnull(@buyamount, 0)
					set @cashpoint	= @cashpoint + @plus

					update dbo.tUserMaster
						set
							cashpoint = @cashpoint
					where gameid = @gameid_

					-- 아이템 가져간 상태로 돌려둔다.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end
			else
				begin
					--------------------------------------------------------------
					-- seed(선물없음)	-> 없음
					-- 업그레이드		-> 없음
					--------------------------------------------------------------
					--select 'DEBUG 4-7 정보표시용'

					-- 아이템 가져간 상태로 돌려둔다.
					update dbo.tGiftList set giftkind = @GIFTLIST_GIFT_KIND_GIFT_GET, gaindate = getdate() where idx = @idx_
				end

			-- 받은 아이템 정보를 리스트에 추가해주기.
			if( @listidxrtn != -1)
				begin
					insert into @tTempTable( listidx ) values( @listidxrtn )
				end
		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off

	select @nResult_ rtn, @comment comment, @cashcost cashcost, @gamecost gamecost, @heart heart, @feed feed, @fpoint fpoint, @goldticket goldticket, @battleticket battleticket,
		   @boxslotidx boxslotidx, @boxslottime boxslottime, @cashpoint cashpoint,
		   @boxslot1 boxslot1, @boxslot2 boxslot2, @boxslot3 boxslot3, @boxslot4 boxslot4

	if(@nResult_ = @RESULT_SUCCESS)
		begin
			--------------------------------------------------------------
			-- 유저 보유 아이템 정보 > 새로 획득한 것만 전송(기존것 하고 같이 보내면 클라것의 데이터를 덮씌워서 문제됨)
			--------------------------------------------------------------
			select * from dbo.tUserItem
			where gameid = @gameid_ and listidx in ( select listidx from @tTempTable )

			--------------------------------------------------------------
			-- 선물/쪽지 리스트 정보
			--------------------------------------------------------------
			exec spu_GiftList @gameid_
		end

End

