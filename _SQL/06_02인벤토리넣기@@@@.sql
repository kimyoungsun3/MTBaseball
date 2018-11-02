--################################################################
/*
-- 의상.
declare @listidxrtn		int				set @listidxrtn			= -1
--						gameid_, invenkind_, subcategory_, itemcode_, cnt_, gethow_, randserial, nResult2_
exec dbo.spu_ToUserItem 'mtxxxx3', 		  1,            1,       101,    1,      20,       7771, @nResult2_ = @listidxrtn OUTPUT
select @listidxrtn

-- 조각
declare @listidxrtn		int				set @listidxrtn			= -1
--						gameid_, invenkind_, subcategory_, itemcode_, cnt_, gethow_, randserial, nResult2_
exec dbo.spu_ToUserItem 'mtxxxx3', 		  2,            15,     1500,    1,      20,       7771, @nResult2_ = @listidxrtn OUTPUT
select @listidxrtn

-- 조언주문서.
declare @listidxrtn		int				set @listidxrtn			= -1
--						gameid_, invenkind_, subcategory_, itemcode_, cnt_, gethow_, randserial, nResult2_
exec dbo.spu_ToUserItem 'mtxxxx3', 		  3,           46,      4601,    1,      20,       7771, @nResult2_ = @listidxrtn OUTPUT
select @listidxrtn

*/
use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_ToUserItem', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_ToUserItem;
GO

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_ToUserItem
	@gameid_								varchar(20),						-- 게임아이디
	@invenkind_								int,
	@subcategory_							int,
	@itemcode_								int,
	@cnt_									int,
	@gethow_								int,
	@randserial_							varchar(20),
	@nResult2_								int					OUTPUT
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 코드값자리
	------------------------------------------------
	-- MT 아이템별 인벤분류
	declare @USERITEM_INVENKIND_WEAR			int 				set @USERITEM_INVENKIND_WEAR				= 1
	declare @USERITEM_INVENKIND_PIECE			int 				set @USERITEM_INVENKIND_PIECE				= 2
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_NON				int 				set @USERITEM_INVENKIND_NON					= 0
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40

	------------------------------------------------
	--	2-3. 내부사용 변수
	------------------------------------------------
	declare @listidxrtn		int				set @listidxrtn			= -1
	declare @listidxnew 	int				set @listidxnew 		= -1
	declare @listidxcust 	int				set @listidxcust 		= -1

Begin
	if(@itemcode_ = -1)
		begin
			return;
		end

	select @listidxnew = isnull(MAX(listidx), 0) + 1 from dbo.tUserItem where gameid = @gameid_

	if(@invenkind_ = @USERITEM_INVENKIND_WEAR)
		begin
			-- 해당아이템 인벤에 지급
			insert into dbo.tUserItem(gameid,      listidx,  itemcode, cnt,  invenkind,   gethow,  randserial)				-- 의상
			values(					 @gameid_, @listidxnew, @itemcode_,  1, @invenkind_, @gethow_, @randserial_)

			-- 변경된 아이템 리스트인덱스
			set @listidxrtn	= @listidxnew
		end
	else if(@invenkind_ = @USERITEM_INVENKIND_PIECE )
		begin
			select @listidxcust = listidx from dbo.tUserItem where gameid = @gameid_ and itemcode = @itemcode_

			if(@listidxcust = -1)
				begin
					insert into dbo.tUserItem(gameid,      listidx,  itemcode,   cnt,   invenkind,   gethow,  randserial)
					values(					@gameid_,  @listidxnew, @itemcode_, @cnt_, @invenkind_, @gethow_, @randserial_)

					-- 변경된 아이템 리스트인덱스
					set @listidxrtn	= @listidxnew
				end
			else
				begin
					update dbo.tUserItem
						set
							cnt 		= cnt + @cnt_,
							randserial 	= @randserial_
					where gameid = @gameid_ and listidx = @listidxcust

					-- 변경된 아이템 리스트인덱스
					set @listidxrtn	= @listidxcust
				end
		end
	else if(@invenkind_ = @USERITEM_INVENKIND_CONSUME)
		begin
			--set @itemcode_ = dbo.fnu_GetItemcodeFromConsumePackage(@subcategory_, @itemcode_)

			select @listidxcust = listidx from dbo.tUserItem where gameid = @gameid_ and itemcode = @itemcode_
			--select 'DEBUG 4-3 소비(n)인벤넣기', @gameid_ gameid_, @subcategory_ subcategory_, @itemcode_ itemcode_, @listidxcust listidxcust
			if(@listidxcust = -1)
				begin
					insert into dbo.tUserItem(gameid,      listidx,  itemcode,   cnt,   invenkind,   gethow,  randserial)
					values(					@gameid_,  @listidxnew, @itemcode_, @cnt_, @invenkind_, @gethow_, @randserial_)

					-- 변경된 아이템 리스트인덱스
					set @listidxrtn	= @listidxnew
				end
			else
				begin
					update dbo.tUserItem
						set
							cnt 		= cnt + @cnt_,
							randserial 	= @randserial_
					where gameid = @gameid_ and listidx = @listidxcust

					-- 변경된 아이템 리스트인덱스
					set @listidxrtn	= @listidxcust
				end
		end



	set @nResult2_ = @listidxrtn

END