/*
exec spu_FVGiftList 'xxxx2'
*/
use Game4FarmVill4
GO

IF OBJECT_ID ( 'dbo.spu_FVGiftList', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVGiftList;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVGiftList
	@gameid_								varchar(60)
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--
	------------------------------------------------
	-- 선물 정의값
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2
	declare @GIFTLIST_GIFT_KIND_MESSAGE_DEL		int					set @GIFTLIST_GIFT_KIND_MESSAGE_DEL			= -1
	declare @GIFTLIST_GIFT_KIND_GIFT_DEL		int					set @GIFTLIST_GIFT_KIND_GIFT_DEL			= -2
	declare @GIFTLIST_GIFT_KIND_GIFT_GET		int					set @GIFTLIST_GIFT_KIND_GIFT_GET			= -3
	declare @GIFTLIST_GIFT_KIND_GIFT_SELL		int					set @GIFTLIST_GIFT_KIND_GIFT_SELL			= -4

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	--declare @gameid_ varchar(60) set @gameid_ = 'xxxx2'
	select top 20 idx, giftkind, message, itemcode, convert(varchar(16), giftdate, 20) as giftdate, giftid, cnt
	from dbo.tFVGiftList
	where gameid = @gameid_ and giftkind in (@GIFTLIST_GIFT_KIND_MESSAGE, @GIFTLIST_GIFT_KIND_GIFT)
	order by idx desc

	set nocount off
End

