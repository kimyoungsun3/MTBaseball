/* 
exec spu_Notice 1, -1
exec spu_Notice 2, -1
exec spu_Notice 3, -1
exec spu_Notice 5, -1
exec spu_Notice 7, -1
*/

IF OBJECT_ID ( 'dbo.spu_Notice', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_Notice;
GO 

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_Notice
	@market_								int,
	@nResult_								int					OUTPUT
	WITH ENCRYPTION -- 프로시져를 암호화함.
as	
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------	
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1			
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1	
	
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @dateid 							varchar(6) 		set @dateid = Convert(varchar(6),Getdate(),112)		-- 201208

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_SUCCESS	
	select @nResult_ rtn, '공지사항 알림'
	
	------------------------------------------------
	--	3-3. 공지사항 체크
	-- 50:50 모바인, 상상디지탈
	------------------------------------------------
	declare @rand int	
	set @rand = Convert(int, ceiling(RAND() * 2))
	
	if(@rand = 1)
		begin
			select top 1 comment, convert(varchar(16), writedate, 20) as writedate, isnull(branchurl, '') branchurl, isnull(facebookurl, '') facebookurl, adurl adurl, adfile adfile from dbo.tNotice 
			where market = @market_
			order by idx desc
		end
	else
		begin
			select top 1 comment, convert(varchar(16), writedate, 20) as writedate, isnull(branchurl, '') branchurl, isnull(facebookurl, '') facebookurl, adurl2 adurl, adfile2 adfile from dbo.tNotice 
			where market = @market_
			order by idx desc
		end

	---------------------------------------
	-- 지역 랭킹보기
	---------------------------------------
	select top 8 rank() over(order by win desc, lose asc) as rank, ccode, win btwin, (lose + win) bttotal
		from dbo.tBattleCountry 
		where dateid = @dateid

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



