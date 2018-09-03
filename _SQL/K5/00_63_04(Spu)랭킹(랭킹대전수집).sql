use Game4GameMTBaseballVill5
GO
/*
delete from dbo.tRankDaJun where rkdateid8 = '20160516'
update dbo.tRankDaJun set rkreward = 0 where rkdateid8 = '20160514'
update dbo.tRankDaJun set rksalemoney = 0, rksalebarrel = 0, rkbattlecnt = 0, rkbogicnt = 0, rkfriendpoint = 0, rkroulettecnt	= 0, rkwolfcnt = 0,
                          rksalemoney2 = 0, rksalebarrel2 = 0, rkbattlecnt2 = 0, rkbogicnt2 = 0, rkfriendpoint2 = 0, rkroulettecnt2 = 0, rkwolfcnt2 = 0
                          where rkdateid8 = '20160514'
update dbo.tUserMaster set rksalemoney = 0, rksalebarrel = 0, rkbattlecnt = 0, rkbogicnt = 0, rkfriendpoint	= 0, rkroulettecnt	= 0, rkwolfcnt = 0
						   where gameid in ('xxxx2', 'xxxx3')
update dbo.tUserMaster set rkstartdate	= rkstartdate - 7 where gameid in ('xxxx4')


exec spu_subRankDaJun 'xxxx2', 1, 2, 3, 4, 5, 6, 7		-- 짝
exec spu_subRankDaJun 'xxxx3', 1, 2, 3, 4, 5, 6, 7		-- 홀
exec spu_subRankDaJun 'xxxxz', 1, 2, 3, 4, 5, 6, 7		-- 없음
exec spu_subRankDaJun 'xxxx4', 1, 2, 3, 4, 5, 6, 7		-- 없음

-- select gameid, rkteam, rkstartdate, rksalemoney, rksalebarrel, rkbattlecnt, rkbogicnt, rkfriendpoint, rkroulettecnt, rkwolfcnt from dbo.tUserMaster where gameid in ('xxxx2', 'xxxx3')
-- select * from dbo.tRankDaJun order by idx desc


exec spu_subRankDaJun 'xxxx2', 1, 0, 0, 0, 0, 0, 0		-- 판매수익.
exec spu_subRankDaJun 'xxxx2', 0, 1, 0, 0, 0, 0, 0		-- 생산배럴.
exec spu_subRankDaJun 'xxxx2', 0, 0, 1, 0, 0, 0, 0		-- 배틀 포인트
exec spu_subRankDaJun 'xxxx2', 0, 0, 0, 1, 0, 0, 0		-- 교배,보물포인트
exec spu_subRankDaJun 'xxxx2', 0, 0, 0, 0, 1, 0, 0		-- 친구포인트
exec spu_subRankDaJun 'xxxx2', 0, 0, 0, 0, 0, 1, 0		-- 룰렛포인트
exec spu_subRankDaJun 'xxxx2', 0, 0, 0, 0, 0, 0, 1		-- 늑대포인트
*/

IF OBJECT_ID ( 'dbo.spu_subRankDaJun', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_subRankDaJun;
GO

create procedure dbo.spu_subRankDaJun
	@gameid_								varchar(20),
	@rksalemoney_							bigint,
	@rksalebarrel_							bigint,
	@rkbattlecnt_							bigint,
	@rkbogicnt_								bigint,
	@rkfriendpoint_							bigint,
	@rkroulettecnt_							bigint,
	@rkwolfcnt_								bigint
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as

	------------------------------------------------
	--
	------------------------------------------------

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @rkdateid8 			varchar(8) 				set @rkdateid8 		= Convert(varchar(8), Getdate(),112)
	declare @rkteam				int
	declare @rkteam1			int
	declare @rkteam0			int
	declare @rkstartdate		datetime				set @rkstartdate 	= getdate()		-- 대전일.
	declare @rkstartstate		int						set @rkstartstate	= 0

	declare @rksalemoney		bigint					set @rksalemoney	= 0
	declare @rksalebarrel		bigint					set @rksalebarrel	= 0
	declare @rkbattlecnt		bigint					set @rkbattlecnt	= 0
	declare @rkbogicnt			bigint					set @rkbogicnt		= 0
	declare @rkfriendpoint		bigint					set @rkfriendpoint	= 0
	declare @rkroulettecnt		bigint					set @rkroulettecnt	= 0
	declare @rkwolfcnt			bigint					set @rkwolfcnt		= 0

	declare @rksalemoney2		bigint					set @rksalemoney2	= 0
	declare @rksalebarrel2		bigint					set @rksalebarrel2	= 0
	declare @rkbattlecnt2		bigint					set @rkbattlecnt2	= 0
	declare @rkbogicnt2			bigint					set @rkbogicnt2		= 0
	declare @rkfriendpoint2		bigint					set @rkfriendpoint2	= 0
	declare @rkroulettecnt2		bigint					set @rkroulettecnt2	= 0
	declare @rkwolfcnt2			bigint					set @rkwolfcnt2		= 0

	declare @dw					int						set @dw 			= DATEPART(dw, getdate())
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG 랭킹정보', @gameid_ gameid_, @rksalemoney_ rksalemoney_, @rksalebarrel_ rksalebarrel_, @rkbattlecnt_ rkbattlecnt_, @rkbogicnt_ rkbogicnt_, @rkfriendpoint_ rkfriendpoint_, @rkroulettecnt_ rkroulettecnt_, @rkwolfcnt_ rkwolfcnt_

	------------------------------------------------
	--	유저정보.
	------------------------------------------------
	select
		@rkteam 	= rkteam,
		@rkstartdate= rkstartdate
	from dbo.tUserMaster where gameid = @gameid_
	--select 'DEBUG ', @rkteam rkteam, @rkstartdate rkstartdate
	if( @rkteam is null or @rkteam not in (0, 1) )
		begin
			--select 'DEBUG 팀소속이 없어서 리턴'
			return;
		end



	---------------------------------------------------
	-- 거래정보와 비교.
	-- 일 월 화 수 목 금 토
	--                		> 이번주에 거래시 기록.
	---------------------------------------------------
	set @rkstartstate = dbo.fnu_GetSameWeek( @rkstartdate, GETDATE() )
	--select 'DEBUG ', @rkstartdate rkstartdate, GETDATE() today, @rkstartstate rkstartstate, @dw dw
	if(@rkstartstate != 1)
		begin
			--select 'DEBUG 랭킹 기록시작을 안했음'
			return;
		end


	------------------------------------------------
	-- 금요일만 수집(저장) > 토요일 연산(금 -> 토스케쥴)
	-- 일	월	화	수	목	금	토
	-- (1) 	2  (3) 	4 	5  (6) 	7
	-- 1 	2 	3 	4 	5 	6 	7
	-- 8 	9 	10 	11 	12 	13 	14
	-- 15 	16 	17 	18 	19 	20 	21
	-- 22 	23 	24 	25 	26 	27 	28
	-- C		C 	A	C	C	A	C
	------------------------------------------------
	if(@dw not in (1, 3, 6))
		begin
			--select 'DEBUG 일, 화, 금 아님'
			return;
		end

	------------------------------------------------
	--	랭킹대전기록(전체).
	------------------------------------------------
	if(not exists(select top 1 * from dbo.tRankDaJun where rkdateid8 = @rkdateid8))
		begin
			--select 'DEBUG > 처음 마스터 기록', @rkdateid8 rkdateid8
			insert into dbo.tRankDaJun( rkdateid8 )
			values(                    @rkdateid8 )
		end

	------------------------------------------------
	--  대전전체기록
	------------------------------------------------
	update dbo.tRankDaJun
		set
			-- 홀수팀.
			rksalemoney 	= rksalemoney 	+ case when @rkteam = 1 		then @rksalemoney_ 		else 0 end,
			rksalebarrel	= rksalebarrel  + case when @rkteam = 1 		then @rksalebarrel_ 	else 0 end,
			rkbattlecnt		= rkbattlecnt  	+ case when @rkteam = 1 		then @rkbattlecnt_ 		else 0 end,
			rkbogicnt		= rkbogicnt  	+ case when @rkteam = 1 		then @rkbogicnt_ 		else 0 end,
			rkfriendpoint	= rkfriendpoint + case when @rkteam = 1 		then @rkfriendpoint_ 	else 0 end,
			rkroulettecnt	= rkroulettecnt + case when @rkteam = 1 		then @rkroulettecnt_ 	else 0 end,
			rkwolfcnt		= rkwolfcnt  	+ case when @rkteam = 1 		then @rkwolfcnt_ 		else 0 end,

			--짝수팀.
			rksalemoney2	= rksalemoney2 	+ case when @rkteam = 0 		then @rksalemoney_ 		else 0 end,
			rksalebarrel2	= rksalebarrel2 + case when @rkteam = 0 		then @rksalebarrel_ 	else 0 end,
			rkbattlecnt2	= rkbattlecnt2  + case when @rkteam = 0 		then @rkbattlecnt_ 		else 0 end,
			rkbogicnt2		= rkbogicnt2  	+ case when @rkteam = 0 		then @rkbogicnt_ 		else 0 end,
			rkfriendpoint2	= rkfriendpoint2+ case when @rkteam = 0 		then @rkfriendpoint_ 	else 0 end,
			rkroulettecnt2	= rkroulettecnt2+ case when @rkteam = 0 		then @rkroulettecnt_ 	else 0 end,
			rkwolfcnt2		= rkwolfcnt2  	+ case when @rkteam = 0 		then @rkwolfcnt_ 		else 0 end
	where rkdateid8 = @rkdateid8
	--select 'DEBUG ', * from dbo.tRankDaJun where rkdateid8 = @rkdateid8


	------------------------------------------------
	-- 평가하기
	------------------------------------------------
	--select 'DEBUG (전)', * from dbo.tRankDaJun where rkdateid8 = @rkdateid8
	select
		@rksalemoney 	= rksalemoney,
		@rksalebarrel	= rksalebarrel,
		@rkbattlecnt	= rkbattlecnt,
		@rkbogicnt		= rkbogicnt,
		@rkfriendpoint	= rkfriendpoint,
		@rkroulettecnt	= rkroulettecnt,
		@rkwolfcnt		= rkwolfcnt,

		@rksalemoney2	= rksalemoney2,
		@rksalebarrel2	= rksalebarrel2,
		@rkbattlecnt2	= rkbattlecnt2,
		@rkbogicnt2		= rkbogicnt2,
		@rkfriendpoint2	= rkfriendpoint2,
		@rkroulettecnt2	= rkroulettecnt2,
		@rkwolfcnt2		= rkwolfcnt2
	from dbo.tRankDaJun
	where rkdateid8 = @rkdateid8

	set @rkteam1 	= 0
	set @rkteam0	= 0
	if(@rksalemoney > @rksalemoney2)			set @rkteam1 	= @rkteam1 + 1
	else if(@rksalemoney < @rksalemoney2)		set @rkteam0 	= @rkteam0 + 1

	if(@rksalebarrel > @rksalebarrel2)			set @rkteam1 	= @rkteam1 + 1
	else if(@rksalebarrel < @rksalebarrel2)		set @rkteam0 	= @rkteam0 + 1

	if(@rkbattlecnt > @rkbattlecnt2)			set @rkteam1 	= @rkteam1 + 1
	else if(@rkbattlecnt < @rkbattlecnt2)		set @rkteam0 	= @rkteam0 + 1

	if(@rkbogicnt > @rkbogicnt2)				set @rkteam1 	= @rkteam1 + 1
	else if(@rkbogicnt < @rkbogicnt2)			set @rkteam0 	= @rkteam0 + 1

	if(@rkfriendpoint > @rkfriendpoint2)		set @rkteam1 	= @rkteam1 + 1
	else if(@rkfriendpoint < @rkfriendpoint2)	set @rkteam0 	= @rkteam0 + 1

	if(@rkroulettecnt > @rkroulettecnt2)		set @rkteam1 	= @rkteam1 + 1
	else if(@rkroulettecnt < @rkroulettecnt2)	set @rkteam0 	= @rkteam0 + 1

	if(@rkwolfcnt > @rkwolfcnt2)				set @rkteam1 	= @rkteam1 + 1
	else if(@rkwolfcnt < @rkwolfcnt2)			set @rkteam0 	= @rkteam0 + 1

	--결과를 기록한다.
	update dbo.tRankDaJun
		set
			rkteam1 = @rkteam1,
			rkteam0 = @rkteam0
	where rkdateid8 = @rkdateid8
	--select 'DEBUG (후)', * from dbo.tRankDaJun where rkdateid8 = @rkdateid8

	------------------------------------------------
	--	랭킹개인기록.
	------------------------------------------------
	update dbo.tUserMaster
		set
			rksalemoney		= rksalemoney	+ @rksalemoney_,
			rksalebarrel	= rksalebarrel 	+ @rksalebarrel_,
			rkbattlecnt		= rkbattlecnt 	+ @rkbattlecnt_,
			rkbogicnt		= rkbogicnt		+ @rkbogicnt_,
			rkfriendpoint	= rkfriendpoint + @rkfriendpoint_,
			rkroulettecnt	= rkroulettecnt + @rkroulettecnt_,
			rkwolfcnt		= rkwolfcnt 	+ @rkwolfcnt_
	where gameid = @gameid_
	--select 'DEBUG 개인기록', rksalemoney, rksalebarrel, rkbattlecnt	, rkbogicnt	, rkfriendpoint, rkroulettecnt, rkwolfcnt, * from dbo.tUserMaster where gameid = @gameid_

	------------------------------------------------
	--	4-1. 종류
	------------------------------------------------
	set nocount off
End


