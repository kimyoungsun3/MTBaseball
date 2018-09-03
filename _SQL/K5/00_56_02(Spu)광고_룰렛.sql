/*
-- 룰렛 전용 광고기록.
exec spu_WheelAdLogNew 'xxxx2', 'xxxx2', 101, 	5000, 3000	-- 루비광고
exec spu_WheelAdLogNew 'xxxx2', 'xxxx2', 101, 	3500,  200	--
exec spu_WheelAdLogNew 'xxxx2', 'xxxx2', 101, 	2300,    6	--
exec spu_WheelAdLogNew 'xxxx2', 'xxxx2', 101, 	5100,12000	--
exec spu_WheelAdLogNew 'xxxx2', 'xxxx2', 101, 	3600,  200	--
*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_WheelAdLogNew', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_WheelAdLogNew;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_WheelAdLogNew
	@gameid_								varchar(20),
	@nickname_								varchar(40),
	@mode_									int,
	@itemcode_								int,
	@cnt_									int
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--
	------------------------------------------------
	-- 아이템 대분류
	declare @ITEM_MAINCATEGORY_GAMECOST			int					set @ITEM_MAINCATEGORY_GAMECOST 			= 51 	--코인선물(51)

	declare @IDX_MAX							int 				set @IDX_MAX								= 100

	declare @MODE_WHEEL							int					set @MODE_WHEEL								= 101

	------------------------------------------------
	--
	------------------------------------------------
	declare @comment				varchar(128)
	declare @itemname				varchar(40)
	declare @idx					int				set @idx			= -1
	declare @category				int

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on

	if( @mode_ = @MODE_WHEEL and @itemcode_ != -1 and @cnt_ > 0 )
		begin
			----------------------------------------
			-- 아이템 이름을 검색 > 입력.
			-- []를 사용을 주의하세요.~ -> NGUI UI_Lablel에서 사이즈 계산이 아상하게 나옴.
			-- 오동작 : [xxxx2]님이 [xxxx]을 프리미엄 교배로 얻었습니다.
			-- 정  상 : {xxxx2}님이 xxxx을 [ff00ff]프리미엄 교배[-]로 얻었습니다.
			----------------------------------------
			select @category = category, @itemname = itemname from dbo.tItemInfo where itemcode = @itemcode_

			if( @category = @ITEM_MAINCATEGORY_GAMECOST )
				begin
					--select 'DEBUG 황금룰렛'
					set @comment = @nickname_ + '님이 [FFE23B]일반룰렛[-]을 돌려 [ff00ff]{'+ @itemname +' x ' + ltrim(str(@cnt_)) +'만}을 획득[-]했습니다.'

				end
			else
				begin
					set @comment = @nickname_ + '님이 [FFE23B]일반룰렛[-]을 돌려 [ff00ff]{'+ @itemname +' x ' + ltrim(str(@cnt_)) +'개}을 획득[-]했습니다.'
				end

			insert into dbo.tUserAdLog( gameid,   nickname,   itemcode,   mode,   comment)
			values(                    @gameid_, @nickname_, @itemcode_, @mode_, @comment)
		end


	-- 일정개수 이상은 삭제시킴
	select @idx = max(idx) from dbo.tUserAdLog
	delete from dbo.tUserAdLog where idx <= @idx - @IDX_MAX

	set nocount off
End