use Game4Farmvill5
Go

/*
delete from dbo.tUserItem where gameid = 'xxxx2' and itemcode in ( 3800, 3801 )
declare @loop int set @loop = 0
while( @loop < 20 )
	begin
		exec spu_SetDirectItemNew 'xxxx2', 3801, 1, 14, -1
		set @loop = @loop + 1
	end


update dbo.tZCPMarket set zcpflag = -1, balancecnt = 0 where idx = 3		-- 상품플래그 꺼짐.
exec spu_ZCPBuy 'xxxx2', '049000s1i0n7t8445289', 3, 7711, -1

update dbo.tZCPMarket set zcpflag =  1, balancecnt = firstcnt where idx = 3	-- 재로량 부족.
exec spu_ZCPBuy 'xxxx2', '049000s1i0n7t8445289', 3, 7712, -1

update dbo.tZCPMarket set zcpflag =  1, balancecnt = 0 where idx = 3
exec spu_ZCPBuy 'xxxx2', '049000s1i0n7t8445289', 3, 7713, -1				-- 쿠폰부족하기.


update dbo.tZCPMarket set zcpflag =  1, balancecnt = 0        where idx = 3
exec spu_ZCPBuy 'xxxx2', '049000s1i0n7t8445289', 1, 7716, -1				-- 정상구매.
exec spu_ZCPBuy 'xxxx2', '049000s1i0n7t8445289', 2, 7715, -1				-- 정상구매.
exec spu_ZCPBuy 'xxxx2', '049000s1i0n7t8445289', 3, 7717, -1				-- 정상구매.


select * from dbo.tZCPOrder order by idx desc

*/

IF OBJECT_ID ( 'dbo.spu_ZCPBuy', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ZCPBuy;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_ZCPBuy
	@gameid_				varchar(20),						-- 게임아이디
	@password_				varchar(20),						-- 암호화해서저장, 유저패스워가 해킹당해도 안전
	@idx_					int,
	@randserial_			varchar(20),
	@nResult_				int					OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1

	--가입 오류.
	declare @RESULT_ERROR_ID_DUPLICATE			int				set @RESULT_ERROR_ID_DUPLICATE			= -2

	-- 세이브 오류.
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13			--해당유저를 찾지 못함
	declare @RESULT_ERROR_ZCP_LACK				int				set @RESULT_ERROR_ZCP_LACK				= -162			-- 짜요쿠폰 부족합니다.
	declare @RESULT_ERROR_ZCP_EXPIRE			int				set @RESULT_ERROR_ZCP_EXPIRE			= -163			-- 짜요쿠폰이 만기 되었습니다.
	declare @RESULT_ERROR_PRODUCT_EXPIRE		int				set @RESULT_ERROR_PRODUCT_EXPIRE		= -165			-- 해당상품이 만기되었습니다.
	declare @RESULT_ERROR_PRODUCT_EXHAUSTED		int				set @RESULT_ERROR_PRODUCT_EXHAUSTED		= -166			-- 해당상품이 모두 판매되었거나 및 조기종영되었습니다.


	--declare @ITEM_ZCP_PIECE_MOTHER			int				set @ITEM_ZCP_PIECE_MOTHER				= 3800	-- 짜요쿠폰조각.
	declare @ITEM_ZCP_TICKET_MOTHER				int				set @ITEM_ZCP_TICKET_MOTHER				= 3801	-- 짜요쿠폰.

	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @comment				varchar(80)
	declare @comment2				varchar(80)
	declare @gameid					varchar(20)				set @gameid				= ''
	declare @market					int						set @market				= 5
	declare @randserial				varchar(20)				set @randserial			= '-1'
	declare @ownercnt				int						set @ownercnt			= 0

	declare @zcpidx					int						set @zcpidx				= -1
	declare @zcpneedcnt				int						set @zcpneedcnt			= 999
	declare @zcpremaincnt			int						set @zcpremaincnt		= 0
	declare @zcptitle				varchar(80)				set @zcptitle			= ''

	declare @listidx				int						set @listidx			= -1
	declare @loop					int						set @loop				= 1
	DECLARE @tTempTable TABLE(
		listidx		int
	);
Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	set @nResult_ = @RESULT_ERROR
	--select 'DEBUG 입력정보', @gameid_ gameid_, @password_ password_, @idx_ idx_, @randserial_ randserial_

	------------------------------------------------
	--	3-2. 연산수행
	------------------------------------------------
	select
		@gameid 		= gameid, 			@market			= market,
		@randserial		= randserial
	from dbo.tUserMaster
	where gameid = @gameid_ and password = @password_
	--select 'DEBUG 유저정보', @gameid gameid, @market market, @randserial randserial

	------------------------------------------------
	--	짜요쿠폰수량 검사.
	------------------------------------------------
	select @ownercnt = count(*) from dbo.tUserItem
	where gameid = @gameid and itemcode = @ITEM_ZCP_TICKET_MOTHER and getdate() <= expiredate
	--select 'DEBUG 짜요쿠폰', @ownercnt ownercnt, * from dbo.tUserItem where gameid = @gameid and itemcode = @ITEM_ZCP_TICKET_MOTHER and getdate() <= expiredate

	------------------------------------------------
	--	상정점보.
	------------------------------------------------
	select
		@zcpidx 		= idx,
		@zcptitle		= title,
		@zcpneedcnt		= needcnt,
		@zcpremaincnt	= firstcnt - balancecnt
	from dbo.tZCPMarket
	where idx = @idx_ and zcpflag = 1 and getdate() <= expiredate
	--select 'DEBUG ', @zcpidx zcpidx, @zcpneedcnt zcpneedcnt, @zcpremaincnt zcpremaincnt

	if( @gameid = '' )
		BEGIN
			-- 아이디가 존재하지않는가??
			set @nResult_ 	= @RESULT_ERROR_NOT_FOUND_GAMEID
			set @comment 	= '아이디가 존재하지 않는다. > 아이디를 확인해라.'
			--select 'DEBUG ', @comment
		END
	else if ( @randserial_ = @randserial )
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 구매요청 했습니다.(동일요청)'
			--select 'DEBUG ' + @comment
		END
	else if ( @zcpidx = -1 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_PRODUCT_EXPIRE
			set @comment = 'ERROR 해당상품이 만기되었습니다.'
			--select 'DEBUG ' + @comment
		END
	else if ( @zcpremaincnt <= 0 )
		BEGIN
			set @nResult_ = @RESULT_ERROR_PRODUCT_EXHAUSTED
			set @comment = 'ERROR 해당상품이 모두 판매되었거나 및 조기종영되었습니다.'
			--select 'DEBUG ' + @comment
		END
	else if ( @ownercnt < @zcpneedcnt )
		BEGIN
			set @nResult_ = @RESULT_ERROR_ZCP_LACK
			set @comment = 'ERROR 짜요쿠폰 부족합니다.'
			--select 'DEBUG ' + @comment
		END
	else
		BEGIN
			set @nResult_ 	= @RESULT_SUCCESS
			set @comment 	= 'SUCCESS 구매요청 했습니다.'

			---------------------------------------------------
			-- 1. 장터템 수량 감소.
			---------------------------------------------------
			--select 'DEBUG 수량감소(전)', balancecnt from dbo.tZCPMarket where idx = @idx_
			update dbo.tZCPMarket
				set
					balancecnt = balancecnt + 1
			where idx = @idx_
			--select 'DEBUG 수량감소(후)', balancecnt from dbo.tZCPMarket where idx = @idx_

			---------------------------------------------------
			-- 2. 장터템 구매 > 관리자에게 알림..
			-- 쪽지로고 기록해두기.
			---------------------------------------------------
			set @comment2 = '짜요쿠폰 ' + ltrim(rtrim(str(@zcpneedcnt)))+ '개를 사용해서 [' + @zcptitle + ']를 구매했습니다.'
			insert into dbo.tZCPOrder( gameid,   zcpidx,      usecnt,  comment  )
			values(                   @gameid_, @zcpidx, @zcpneedcnt, @comment2 )

			exec spu_SubGiftSendNew 1, -1, 0, 'zcpadmin', @gameid_, @comment2

			----select 'DEBUG 주문로고 기록 및 쪽지 알림', @comment2 comment2

			-----------------------------------------
			-- 3. 커서로 하나씩 삭제한다.
			-----------------------------------------
			set @loop = @zcpneedcnt

			-- 1. 선언하기.
			declare curZCPBuy Cursor for
			select listidx from dbo.tUserItem
			where gameid = @gameid and itemcode = @ITEM_ZCP_TICKET_MOTHER and getdate() <= expiredate
			order by idx asc

			-- 2. 커서오픈
			open curZCPBuy

			-- 3. 커서 사용
			Fetch next from curZCPBuy into @listidx
			while @@Fetch_status = 0
				Begin
					if( @loop > 0 )
						begin
							-- 삭제하기.
							exec spu_DeleteUserItemBackup 10, @gameid_, @listidx

							-- 삭제로고 기록하기.
							insert into @tTempTable( listidx )
							values(                 @listidx )
						end
					set @loop = @loop - 1

					Fetch next from curZCPBuy into @listidx
				end

			-- 4. 커서닫기
			close curZCPBuy
			Deallocate curZCPBuy

			-----------------------------------------
			-- 4. 만기삭제.
			-----------------------------------------
			-- 1. 선언하기.
			declare curZCPExpire Cursor for
			select listidx from dbo.tUserItem
			where gameid = @gameid_ and itemcode = @ITEM_ZCP_TICKET_MOTHER and expiredate < getdate()
			order by idx asc

			-- 2. 커서오픈
			open curZCPExpire

			-- 3. 커서 사용
			Fetch next from curZCPExpire into @listidx
			while @@Fetch_status = 0
				Begin
					exec spu_DeleteUserItemBackup 11, @gameid_, @listidx

					insert into @tTempTable( listidx )
					values(                 @listidx )
					Fetch next from curZCPExpire into @listidx
				end

			-- 4. 커서닫기
			close curZCPExpire
			Deallocate curZCPExpire
		END


	-----------------------------------------------
	-- 결과코드처리.
	-----------------------------------------------
	select @nResult_ rtn, @comment comment

	if(@nResult_ = @RESULT_SUCCESS)
		BEGIN
			------------------------------------------------
			-- 유저정보
			------------------------------------------------
			update dbo.tUserMaster
				set
					randserial		= @randserial_
			where gameid = @gameid_


			--------------------------------------------------------------
			-- 유저 보유 아이템 정보
			--------------------------------------------------------------
			select * from @tTempTable

			--------------------------------------------------------------
			-- 선물/쪽지 리스트 정보
			--------------------------------------------------------------
			exec spu_GiftList @gameid_

			---------------------------------------------
			-- 짜요장터.
			---------------------------------------------
			select * from dbo.tZCPMarket
			where zcpflag = 1 and getdate() < expiredate
			order by kind asc, zcporder desc
		END

	------------------------------------------------
	--	3-3. 결과리턴
	------------------------------------------------
	set nocount off
End



