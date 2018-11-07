/*
-- 인벤의 종류를 알아보기(구매, 선물)
select dbo.fnu_GetInvenFromSubCategory(1)
select dbo.fnu_GetInvenFromSubCategory(2)
select dbo.fnu_GetInvenFromSubCategory(3)
select dbo.fnu_GetInvenFromSubCategory(4)
select dbo.fnu_GetInvenFromSubCategory(5)
select dbo.fnu_GetInvenFromSubCategory(6)
select dbo.fnu_GetInvenFromSubCategory(7)
select dbo.fnu_GetInvenFromSubCategory(8)
select dbo.fnu_GetInvenFromSubCategory(9)
select dbo.fnu_GetInvenFromSubCategory(10)
select dbo.fnu_GetInvenFromSubCategory(11)
select dbo.fnu_GetInvenFromSubCategory(12)
select dbo.fnu_GetInvenFromSubCategory(13)

select dbo.fnu_GetInvenFromSubCategory(15)
select dbo.fnu_GetInvenFromSubCategory(16)
select dbo.fnu_GetInvenFromSubCategory(17)
select dbo.fnu_GetInvenFromSubCategory(18)
select dbo.fnu_GetInvenFromSubCategory(19)
select dbo.fnu_GetInvenFromSubCategory(20)
select dbo.fnu_GetInvenFromSubCategory(21)
select dbo.fnu_GetInvenFromSubCategory(22)
select dbo.fnu_GetInvenFromSubCategory(23)
select dbo.fnu_GetInvenFromSubCategory(24)
select dbo.fnu_GetInvenFromSubCategory(25)
select dbo.fnu_GetInvenFromSubCategory(26)
select dbo.fnu_GetInvenFromSubCategory(27)

select dbo.fnu_GetInvenFromSubCategory(40)
select dbo.fnu_GetInvenFromSubCategory(41)
select dbo.fnu_GetInvenFromSubCategory(42)
select dbo.fnu_GetInvenFromSubCategory(45)
select dbo.fnu_GetInvenFromSubCategory(46)
select dbo.fnu_GetInvenFromSubCategory(50)
select dbo.fnu_GetInvenFromSubCategory(500)
select dbo.fnu_GetInvenFromSubCategory(900)
*/

use GameMTBaseball
GO

IF OBJECT_ID ( N'dbo.fnu_GetInvenFromSubCategory', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fnu_GetInvenFromSubCategory;
GO

CREATE FUNCTION dbo.fnu_GetInvenFromSubCategory(
	@subcategory_ 			int
)
	RETURNS int
AS
BEGIN
	-- MT 아이템별 인벤분류
	declare @USERITEM_INVENKIND_WEAR			int 				set @USERITEM_INVENKIND_WEAR				= 1
	declare @USERITEM_INVENKIND_PIECE			int 				set @USERITEM_INVENKIND_PIECE				= 2
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_NON				int 				set @USERITEM_INVENKIND_NON					= 0
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40

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
	declare @ITEM_SUBCATEGORY_BOX_PIECE			int					set @ITEM_SUBCATEGORY_BOX_PIECE				= 40 -- 조각 랜덤박스(40)
	declare @ITEM_SUBCATEGORY_BOX_CLOTH			int					set @ITEM_SUBCATEGORY_BOX_CLOTH				= 41 -- 의상 랜덤박스(41)
	declare @ITEM_SUBCATEGORY_BOX_ADVICE		int					set @ITEM_SUBCATEGORY_BOX_ADVICE			= 42 -- 조언 패키지 박스(42)
	declare @ITEM_SUBCATEGORY_SCROLL_EVOLUTION	int					set @ITEM_SUBCATEGORY_SCROLL_EVOLUTION		= 45 -- 합성초월주문서(45)
	declare @ITEM_SUBCATEGORY_SCROLL_COMMISSION	int					set @ITEM_SUBCATEGORY_SCROLL_COMMISSION		= 46 -- 수수료주문서(46)
	declare @ITEM_SUBCATEGORY_NICKCHANGE		int					set @ITEM_SUBCATEGORY_NICKCHANGE			= 47 -- 닉네임변경권(47)
	declare @ITEM_SUBCATEGORY_RANDOM_CASHCOST_BOX	int				set @ITEM_SUBCATEGORY_RANDOM_CASHCOST_BOX	= 48 -- 랜덤다이아(48)
	declare @ITEM_SUBCATEGORY_CASHCOST			int					set @ITEM_SUBCATEGORY_CASHCOST				= 50 -- 다이아(50)
	declare @ITEM_SUBCATEGORY_GAMECOST			int					set @ITEM_SUBCATEGORY_GAMECOST				= 60 -- 볼(60)
	declare @ITEM_SUBCATEGORY_STATICINFO		int					set @ITEM_SUBCATEGORY_STATICINFO			= 500 -- 정보수집(500)
	declare @ITEM_SUBCATEGORY_LEVELUPREWARD		int					set @ITEM_SUBCATEGORY_LEVELUPREWARD			= 900 --레벨업 보상(510)


	declare @rtn int
	if(@subcategory_ in ( @ITEM_SUBCATEGORY_WEAR_HELMET, @ITEM_SUBCATEGORY_WEAR_SHIRT, @ITEM_SUBCATEGORY_WEAR_PANTS, @ITEM_SUBCATEGORY_WEAR_GLOVES, @ITEM_SUBCATEGORY_WEAR_SHOES, @ITEM_SUBCATEGORY_WEAR_BAT, @ITEM_SUBCATEGORY_WEAR_BALL, @ITEM_SUBCATEGORY_WEAR_GOGGLE, @ITEM_SUBCATEGORY_WEAR_WRISTBAND, @ITEM_SUBCATEGORY_WEAR_ELBOWPAD, @ITEM_SUBCATEGORY_WEAR_BELT, @ITEM_SUBCATEGORY_WEAR_KNEEPAD, @ITEM_SUBCATEGORY_WEAR_SOCKS ) )
		begin
			set @rtn = @USERITEM_INVENKIND_WEAR
		end
	else if(@subcategory_ in ( @ITEM_SUBCATEGORY_PIECE_HELMET, @ITEM_SUBCATEGORY_PIECE_SHIRT, @ITEM_SUBCATEGORY_PIECE_PANTS, @ITEM_SUBCATEGORY_PIECE_GLOVES, @ITEM_SUBCATEGORY_PIECE_SHOES, @ITEM_SUBCATEGORY_PIECE_BAT, @ITEM_SUBCATEGORY_PIECE_BALL,@ITEM_SUBCATEGORY_PIECE_GOGGLE, @ITEM_SUBCATEGORY_PIECE_WRISTBAND, @ITEM_SUBCATEGORY_PIECE_ELBOWPAD, @ITEM_SUBCATEGORY_PIECE_BELT, @ITEM_SUBCATEGORY_PIECE_KNEEPAD, @ITEM_SUBCATEGORY_PIECE_SOCKS ) )
		begin
			set @rtn = @USERITEM_INVENKIND_PIECE
		end
	else if(@subcategory_ in ( @ITEM_SUBCATEGORY_BOX_PIECE, @ITEM_SUBCATEGORY_BOX_CLOTH, @ITEM_SUBCATEGORY_BOX_ADVICE, @ITEM_SUBCATEGORY_SCROLL_EVOLUTION, @ITEM_SUBCATEGORY_SCROLL_COMMISSION, @ITEM_SUBCATEGORY_NICKCHANGE, @ITEM_SUBCATEGORY_RANDOM_CASHCOST_BOX ) )
		begin
			set @rtn = @USERITEM_INVENKIND_CONSUME
		end
	else if(@subcategory_ in ( @ITEM_SUBCATEGORY_CASHCOST, @ITEM_SUBCATEGORY_GAMECOST ))
		begin
			set @rtn = @USERITEM_INVENKIND_DIRECT
		end
	else
		begin
			set @rtn = @USERITEM_INVENKIND_INFO
		end

	RETURN @rtn
END