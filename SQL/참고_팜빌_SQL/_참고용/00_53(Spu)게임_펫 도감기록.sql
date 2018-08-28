
--################################################################
-- 펫도감 정보 기록하기.
-- exec spu_FVDogamListPetLog 'xxxx2', 100000
-- exec spu_FVDogamListPetLog 'xxxx2', 100001
-- select * from dbo.tFVDogamListPet where gameid = 'xxxx3' order by itemcode asc
--################################################################
use Farm
GO

IF OBJECT_ID ( 'dbo.spu_FVDogamListPetLog', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVDogamListPetLog;
GO

create procedure dbo.spu_FVDogamListPetLog
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
	if(not exists(select top 1 * from dbo.tFVDogamListPet where gameid = @gameid_ and itemcode = @itemcode_))
		begin
			insert into dbo.tFVDogamListPet(gameid, itemcode) values(@gameid_, @itemcode_)
		end


	------------------------------------------------
	--	4-1. 종류
	------------------------------------------------
	set nocount off
End


