use Game4FarmVill4
Go
/*
exec spu_FVRankInfo 'xxxx2', '049000s1i0n7t8445289', -1

*/

IF OBJECT_ID ( 'dbo.spu_FVRankInfo', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVRankInfo;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVRankInfo
	@gameid_								varchar(60),					-- 게임아이디
	@password_								varchar(20),
	@nResult_								int					OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= ''
	declare @gameid 				varchar(60)				set @gameid			= ''
	declare @dateid8 				varchar(8) 				set @dateid8 		= Convert(varchar(8), Getdate(),  112)
	declare @dateid8b 				varchar(8) 				set @dateid8b 		= Convert(varchar(8), Getdate()-1,112)

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 	= gameid
	from dbo.tFVUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid

	if(@gameid = '')
		BEGIN
			-- 아이디가 존재하지않는가??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다. > 아이디를 확인해라.'
			--select 'DEBUG ', @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= '랭킹정보를 전송처리'
			--select 'DEBUG ', @comment
		END


	-----------------------------------------------
	-- 결과코드처리.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			------------------------------------------------
			--	랭킹대전기록(전체).
			------------------------------------------------
			if(exists(select * from dbo.tFVRankDaJun where rkdateid8 = @dateid8))
				begin
					select * from dbo.tFVRankDaJun where rkdateid8 = @dateid8
				end
			else
				begin
					select
						@dateid8 rkdateid8,
						0 rkteam1, 		0 rkteam0, 		0 rkreward,
						0 rksalemoney, 	0 rkproductcnt, 0 rkfarmearn, 	0 rkwolfcnt, 	0 rkfriendpoint, 0 rkroulettecnt, 0 rkplaycnt,
						0 rksalemoney2,	0 rkproductcnt2,0 rkfarmearn2,	0 rkwolfcnt2,	0 rkfriendpoint2,0 rkroulettecnt2,0 rkplaycnt2
				end


			if(exists(select * from dbo.tFVRankDaJun where rkdateid8 = @dateid8b))
				begin
					select * from dbo.tFVRankDaJun where rkdateid8 = @dateid8b
				end
			else
				begin
					select top 1 * from dbo.tFVRankDaJun where rkdateid8 < @dateid8b order by rkdateid8 desc
					--select
					--	@dateid8b rkdateid8,
					--	0 rkteam1, 		0 rkteam0, 		0 rkreward,
					--	0 rksalemoney, 	0 rkproductcnt, 0 rkfarmearn, 	0 rkwolfcnt, 	0 rkfriendpoint, 0 rkroulettecnt, 0 rkplaycnt,
					--	0 rksalemoney2,	0 rkproductcnt2,0 rkfarmearn2,	0 rkwolfcnt2,	0 rkfriendpoint2,0 rkroulettecnt2,0 rkplaycnt2
				end

		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



