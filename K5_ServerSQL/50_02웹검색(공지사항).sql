
--공지사항작성(20)
--exec spu_FarmD2 20, 0, -1,  1,  0, 101,  0, -1, -1, -1, -1, -1, -1, -1, -1, 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image01.png', 'http://m.naver.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png', 'http://m.daum.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png', 'http://m.hungryapp.co.kr',	'http://www.ubx.co.kr', 'http://clien.career.co.kr', '', '', '', '', '', '', '', '', '', '', '', '공지내용'		-- 작성
--exec spu_FarmD2 20, 1,  6,  1,  0, 101,  0, -1, -1, -1, -1, -1, -1, -1, -1, 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image01.png', 'http://m.naver.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png', 'http://m.daum.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png', 'http://m.hungryapp.co.kr',	'http://www.ubx.co.kr', 'http://clien.career.co.kr', '', '', '', '', '', '', '', '', '', '', '', '공지내용'		-- 루비
--exec spu_FarmD2 20, 2, -1, -1, -1,  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''			-- 리스트

use GameMTBaseball
GO

IF OBJECT_ID ( 'dbo.spu_FarmD2', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FarmD2;
GO

------------------------------------------------
--	1. 개발일반 프로세서
------------------------------------------------
create procedure dbo.spu_FarmD2
	@p1_			int,
	@p2_			int,
	@p3_			int,
	@p4_			int,
	@p5_			int,
	@p6_			int,
	@p7_			int,
	@p8_			int,
	@p9_			int,
	@p10_			int,
	@p11_			int,
	@p12_			int,
	@p13_			int,
	@p14_			int,
	@p15_			bigint,
	@ps1_			varchar(1024),
	@ps2_			varchar(1024),
	@ps3_			varchar(1024),
	@ps4_			varchar(1024),
	@ps5_			varchar(1024),
	@ps6_			varchar(1024),
	@ps7_			varchar(1024),
	@ps8_			varchar(1024),
	@ps9_			varchar(1024),
	@ps10_			varchar(1024),
	@ps11_			varchar(1024),
	@ps12_			varchar(1024),
	@ps13_			varchar(1024),
	@ps14_			varchar(1024),
	@ps15_			varchar(1024),
	@ps16_			varchar(1024),
	@ps17_			varchar(1024),
	@ps18_			varchar(1024),
	@ps19_			varchar(1024),
	@ps20_			varchar(8000)
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------

	------------------------------------------------
	--	프로시져 종류
	------------------------------------------------
	declare @KIND_NOTICE_SETTING				int				set @KIND_NOTICE_SETTING				= 20


	-- 통신사 구분값
	declare @SKT 							int					set @SKT						= 1
	declare @KT 							int					set @KT							= 2
	declare @LGT 							int					set @LGT						= 3
	declare @GOOGLE 						int					set @GOOGLE						= 5
	declare @NHN	 						int					set @NHN						= 6
	declare @IPHONE							int					set @IPHONE						= 7


	------------------------------------------------
	--	일반변수선언
	------------------------------------------------
	declare @kind			int				set @kind			= @p1_
	declare @subkind		int				set @subkind		= @p2_
	declare @idx 			int				set @idx 			= @p3_
	declare @idx2 			int


	declare @comment4		varchar(8000)
	declare @syscheck		int
	declare @market			int				set @market = 1
	declare @buytype		int
	declare @version		int
	declare @iteminfover	int

Begin
	------------------------------------------------
	--	초기화
	------------------------------------------------
	set nocount on

	------------------------------------------------
	--	각상태분기
	------------------------------------------------
	if(@kind = @KIND_NOTICE_SETTING)
		begin
			set @subkind 	= @p2_
			set @idx		= @p3_
			set @market		= @p4_
			set @buytype	= @p5_
			set @version	= @p6_
			set @syscheck	= @p7_
			set @iteminfover= @p8_
			set @comment4	= @ps20_

			if(@subkind = 0)
				begin
					insert into dbo.tNotice(market,  buytype,  comfile, comurl, comfile2, comurl2, comfile3, comurl3, comfile4, comurl4, comfile5, comurl5,  version,  patchurl,  recurl,   comment,   syscheck,  iteminfover,  iteminfourl, communityurl, serviceurl)
					values(                @market, @buytype,  @ps1_,   @ps2_,  @ps3_,    @ps4_,   @ps5_,    @ps6_,   @ps7_,    @ps8_,   @ps9_,    @ps10_,  @version,    @ps12_,  @ps13_,  @comment4, @syscheck, @iteminfover,       @ps14_,       @ps15_,     @ps16_)

					-- 종류별 공지사항.
					select * from dbo.tNotice
					where idx in (select max(idx) from dbo.tNotice where market in (@SKT, @GOOGLE, @IPHONE) group by market, buytype)
					order by market, buytype asc
				end
			else if(@subkind = 1)
				begin
					update dbo.tNotice
						set
							market		= @market,
							buytype		= @buytype,

							comfile		= @ps1_,
							comurl 		= @ps2_,
							comfile2	= @ps3_,
							comurl2 	= @ps4_,
							comfile3	= @ps5_,
							comurl3		= @ps6_,
							comfile4	= @ps7_,
							comurl4		= @ps8_,
							comfile5	= @ps9_,
							comurl5		= @ps10_,
							communityurl= @ps15_,
							serviceurl	= @ps16_,

							version		= @version,

							patchurl	= @ps12_,
							recurl	 	= @ps13_,
							comment	 	= @comment4,
							iteminfover = @iteminfover,
							iteminfourl = @ps14_,

							syscheck 	= @syscheck
					where idx = @idx


					-- 종류별 공지사항.
					select * from dbo.tNotice
					where idx in (select max(idx) from dbo.tNotice where market in (@SKT, @GOOGLE, @IPHONE, @NHN) group by market, buytype)
					order by market, buytype asc
				end
			else if(@subkind = 2)
				begin
					-- 종류별 공지사항.
					select * from dbo.tNotice
					where idx in (select max(idx) from dbo.tNotice where market in (@SKT, @GOOGLE, @IPHONE, @NHN) group by market, buytype)
					order by market, buytype asc
				end
		end

	------------------------------------------------
	--	완료
	------------------------------------------------
	set nocount off
End
