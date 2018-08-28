
--################################################################
-- 도감 정보 기록하기.
-- exec spu_FVDogamListLog 'xxxx', 1
-- exec spu_FVDogamListLog 'xxxx', 2
-- exec spu_FVDogamListLog 'xxxx', 3
-- select * from dbo.tFVDogamList where gameid = 'xxxx' order by itemcode asc
--################################################################
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVDogamListLog', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVDogamListLog;
GO

create procedure dbo.spu_FVDogamListLog
	@gameid_								varchar(60),		-- 게임아이디
	@itemcode_								int
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG 도감', @gameid_ gameid_, @itemcode_ itemcode_

	------------------------------------------------
	--	3-2. 로그기록
	------------------------------------------------
	if(@itemcode_ >= 1 and @itemcode_ <= 299)
		begin
			if(not exists(select top 1 * from dbo.tFVDogamList where gameid = @gameid_ and itemcode = @itemcode_))
				begin
					insert into dbo.tFVDogamList(gameid, itemcode) values(@gameid_, @itemcode_)
				end
		end


	------------------------------------------------
	--	4-1. 종류
	------------------------------------------------
	set nocount off
End


