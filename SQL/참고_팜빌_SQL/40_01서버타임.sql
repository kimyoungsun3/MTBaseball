use Farm
GO
/*


exec spu_FVServerTime 'xxxx2', '049000s1i0n7t8445289', -1			-- 정상유저
*/

IF OBJECT_ID ( 'dbo.spu_FVServerTime', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVServerTime;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_FVServerTime
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

	------------------------------------------------
	--	2-2. 상태값
	------------------------------------------------
	declare @comment				varchar(512)			set @comment		= '서버시간'
	declare @curdate				datetime				set @curdate		= getdate()
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_SUCCESS
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @curdate curdate

	select @nResult_ rtn, @comment comment, @curdate curdate

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



