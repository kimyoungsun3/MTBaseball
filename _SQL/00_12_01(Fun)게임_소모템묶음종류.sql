/*
-- 소모템 묶음 종류
select dbo.fnu_GetItemcodeFromConsumePackage(16, 1600)
select dbo.fnu_GetItemcodeFromConsumePackage(16, 1601)
*/
use GameMTBaseball
GO

IF OBJECT_ID ( N'dbo.fnu_GetItemcodeFromConsumePackage', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetItemcodeFromConsumePackage;
GO

CREATE FUNCTION dbo.fnu_GetItemcodeFromConsumePackage(
	@subcategory_		int,
	@itemcode_ 			int
)
	RETURNS int
AS
BEGIN

	-- MT 아이템 소분류
	declare @ITEM_SUBCATEGORY_WEAR_HELMET		int					set @ITEM_SUBCATEGORY_WEAR_HELMET			= 1  -- 헬멧(1)
	declare @ITEM_SUBCATEGORY_WEAR_SHIRT		int					set @ITEM_SUBCATEGORY_WEAR_SHIRT			= 2  -- 상의(2)
	declare @ITEM_SUBCATEGORY_WEAR_PANTS		int					set @ITEM_SUBCATEGORY_WEAR_PANTS			= 3  -- 하의(3)
	declare @ITEM_SUBCATEGORY_WEAR_GLOVES		int					set @ITEM_SUBCATEGORY_WEAR_GLOVES			= 4  -- 장갑(4)
	declare @ITEM_SUBCATEGORY_WEAR_SHOES		int					set @ITEM_SUBCATEGORY_WEAR_SHOES			= 5  -- 신발(5)
	declare @ITEM_SUBCATEGORY_WEAR_BAT			int					set @ITEM_SUBCATEGORY_WEAR_BAT				= 6  -- 방망이(6)
	declare @ITEM_SUBCATEGORY_WEAR_BALL			int					set @ITEM_SUBCATEGORY_WEAR_BALL				= 7  -- 색깔공(7)
	declare @ITEM_SUBCATEGORY_WEAR_GOGGLE		int					set @ITEM_SUBCATEGORY_WEAR_GOGGLE			= 8  -- 고글(8)
	declare @ITEM_SUBCATEGORY_WEAR_WRISTBAND	int					set @ITEM_SUBCATEGORY_WEAR_WRISTBAND		= 9  -- 손목 아대(9)
	declare @ITEM_SUBCATEGORY_WEAR_ELBOWPAD		int					set @ITEM_SUBCATEGORY_WEAR_ELBOWPAD			= 10 -- 팔꿈치 보호대(10)
	declare @ITEM_SUBCATEGORY_WEAR_BELT			int					set @ITEM_SUBCATEGORY_WEAR_BELT				= 11 -- 벨트(11)
	declare @ITEM_SUBCATEGORY_WEAR_KNEEPAD		int					set @ITEM_SUBCATEGORY_WEAR_KNEEPAD			= 12 -- 무릎 보호대(12)
	declare @ITEM_SUBCATEGORY_WEAR_SOCKS		int					set @ITEM_SUBCATEGORY_WEAR_SOCKS			= 13 -- 양말(13)
	declare @ITEM_SUBCATEGORY_PIECE_HELMET		int					set @ITEM_SUBCATEGORY_PIECE_HELMET	    	= 15 -- 헬멧 조각(15)
	declare @ITEM_SUBCATEGORY_PIECE_SHIRT		int					set @ITEM_SUBCATEGORY_PIECE_SHIRT	    	= 16 -- 상의 조각(16)
	declare @ITEM_SUBCATEGORY_PIECE_PANTS		int					set @ITEM_SUBCATEGORY_PIECE_PANTS	    	= 17 -- 하의 조각(17)
	declare @ITEM_SUBCATEGORY_PIECE_GLOVES		int					set @ITEM_SUBCATEGORY_PIECE_GLOVES	    	= 18 -- 장갑 조각(18)
	declare @ITEM_SUBCATEGORY_PIECE_SHOES		int					set @ITEM_SUBCATEGORY_PIECE_SHOES	    	= 19 -- 신발 조각(19)
	declare @ITEM_SUBCATEGORY_PIECE_BAT			int					set @ITEM_SUBCATEGORY_PIECE_BAT		    	= 20 -- 방망이 조각(20)
	declare @ITEM_SUBCATEGORY_PIECE_BALL		int					set @ITEM_SUBCATEGORY_PIECE_BALL			= 21 -- 색깔공 조각(21)
	declare @ITEM_SUBCATEGORY_PIECE_GOGGLE		int					set @ITEM_SUBCATEGORY_PIECE_GOGGLE	    	= 22 -- 고글 조각(22)
	declare @ITEM_SUBCATEGORY_PIECE_WRISTBAND	int					set @ITEM_SUBCATEGORY_PIECE_WRISTBAND   	= 23 -- 손목 아대 조각(23)
	declare @ITEM_SUBCATEGORY_PIECE_ELBOWPAD	int					set @ITEM_SUBCATEGORY_PIECE_ELBOWPAD		= 24 -- 팔꿈치 보호대 조각(24)
	declare @ITEM_SUBCATEGORY_PIECE_BELT		int					set @ITEM_SUBCATEGORY_PIECE_BELT			= 25 -- 벨트 조각(25)
	declare @ITEM_SUBCATEGORY_PIECE_KNEEPAD		int					set @ITEM_SUBCATEGORY_PIECE_KNEEPAD	    	= 26 -- 무릎 보호대 조각(26)
	declare @ITEM_SUBCATEGORY_PIECE_SOCKS		int					set @ITEM_SUBCATEGORY_PIECE_SOCKS	    	= 27 -- 양말 조각(27)
	declare @ITEM_SUBCATEGORY_BOX_WEAR			int					set @ITEM_SUBCATEGORY_BOX_WEAR				= 40 -- 조각 랜덤박스(40)
	declare @ITEM_SUBCATEGORY_BOX_PIECE			int					set @ITEM_SUBCATEGORY_BOX_PIECE				= 41 -- 의상 랜덤박스(41)
	declare @ITEM_SUBCATEGORY_BOX_ADVICE		int					set @ITEM_SUBCATEGORY_BOX_ADVICE			= 42 -- 조언 패키지 박스(42)
	declare @ITEM_SUBCATEGORY_SCROLL_EVOLUTION	int					set @ITEM_SUBCATEGORY_SCROLL_EVOLUTION		= 45 -- 합성초월주문서(45)
	declare @ITEM_SUBCATEGORY_SCROLL_COMMISSION	int					set @ITEM_SUBCATEGORY_SCROLL_COMMISSION		= 46 -- 수수료주문서(46)
	declare @ITEM_SUBCATEGORY_CASHCOST			int					set @ITEM_SUBCATEGORY_CASHCOST				= 50 -- 다이아(50)
	declare @ITEM_SUBCATEGORY_GAMECOST			int					set @ITEM_SUBCATEGORY_GAMECOST				= 60 -- 볼(60)
	declare @ITEM_SUBCATEGORY_STATICINFO		int					set @ITEM_SUBCATEGORY_STATICINFO			= 500 -- 정보수집(500)
	declare @ITEM_SUBCATEGORY_LEVELUPREWARD		int					set @ITEM_SUBCATEGORY_LEVELUPREWARD			= 900 --레벨업 보상(510

	-- 그룹.
	--declare @ITEM_CASHCOST_MOTHER				int					set @ITEM_CASHCOST_MOTHER					= 5000
	--declare @ITEM_GAMECOST_MOTHER				int 				set @ITEM_GAMECOST_MOTHER					= 6000
	--declare @ITEM_BULLET_SUN1					int					set @ITEM_BULLET_SUN1						= 701
	--declare @ITEM_BULLET_SUN2					int					set @ITEM_BULLET_SUN2						= 709

	declare @rtn int
	set @rtn = @itemcode_

	--------------------------------------------------------------
	-- 다이아는 직접 넣어줘서 코드가 존재안함....
	-- 총알			-> 총알1, 총알2, .... 총알n
	--------------------------------------------------------------
	--if(@subcategory_ = @ITEM_SUBCATEGORY_BOX_WEAR and (@itemcode_  >= @ITEM_BULLET_SUN1 and @itemcode_  <= @ITEM_BULLET_SUN2))
	--	begin
	--		set @rtn = @ITEM_BULLET_MOTHER
	--	end
	--else if(@subcategory_ = @ITEM_SUBCATEGORY_CASHCOST)
	--	begin
	--		set @rtn = @ITEM_CASHCOST_MOTHER
	--	end

	RETURN @rtn
END