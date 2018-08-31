use Game4FarmVill4
GO

--공지사항작성(20)
--exec spu_FVFarmD2 20, 0, -1,  1,  0, 101,  0, -1, -1, -1, -1, -1, -1, -1, -1, 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image01.png', 'http://m.naver.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png', 'http://m.daum.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png', 'http://m.hungryapp.co.kr',	'http://www.ubx.co.kr', 'http://clien.career.co.kr', '', '', '', '', '', '', '공지내용'		-- 작성
--exec spu_FVFarmD2 20, 1,  6,  1,  0, 101,  0, -1, -1, -1, -1, -1, -1, -1, -1, '', 'http://m.naver.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png', 'http://m.daum.com', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png', 'http://m.hungryapp.co.kr',	'http://www.ubx.co.kr', 'http://clien.career.co.kr', '', '', '', '', '', '', '공지내용'		-- 수정
--exec spu_FVFarmD2 20, 2, -1, -1, -1,  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''			-- 리스트
--
--exec spu_FVFarmD2 20,10, -1, 5200,100, 1,  1, -1, -1, -1, -1, -1, -1, -1, -1, '1,2,3,4,5,6,7', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png', 'http://m.daum.com', 'com.sangsangdigital.farmvill', '', '', '', '', '', '', '', '', '', '', ''		-- 입력
--exec spu_FVFarmD2 20,11,  1, 5200,200, 1,  1, -1, -1, -1, -1, -1, -1, -1, -1, '1,2,3,4,5,6,7', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png', 'http://m.daum.com', 'com.sangsangdigital.farmvill', '', '',  '', '', '', '', '', '', '', '', ''		-- 수정
--exec spu_FVFarmD2 20,12, -1, -1, -1,  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''			-- 추천게임 리스트
--

IF OBJECT_ID ( 'dbo.spu_FVFarmD2', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVFarmD2;
GO

------------------------------------------------
--	1. 개발일반 프로세서
------------------------------------------------
create procedure dbo.spu_FVFarmD2
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
	@ps15_			varchar(8000)
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1
	declare @RESULT_ERROR_NOT_FOUND_GAMEID		int				set @RESULT_ERROR_NOT_FOUND_GAMEID		= -13	--해당유저를 찾지 못함
	declare @RESULT_ERROR_NOT_FOUND_ITEMCODE	int				set @RESULT_ERROR_NOT_FOUND_ITEMCODE	= -50	-- 아이템코드못찾음

	------------------------------------------------
	--	프로시져 종류
	------------------------------------------------
	declare @KIND_NOTICE_SETTING				int				set @KIND_NOTICE_SETTING				= 20

	-- 상태값.
	declare @BLOCK_STATE_NO						int				set	@BLOCK_STATE_NO						= 0				-- 블럭상태아님
	declare @BLOCK_STATE_YES					int				set	@BLOCK_STATE_YES					= 1				-- 블럭상태
	declare @DELETE_STATE_NO					int				set	@DELETE_STATE_NO					= 0				-- 삭제상태아님
	declare @DELETE_STATE_YES					int				set	@DELETE_STATE_YES					= 1				-- 삭제상태


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
	declare @itemcode		int				set @itemcode		= @p4_
	declare @itemkind		int				set @itemcode		= @p5_
	declare @idx2 			int

	declare @gameid			varchar(60)		set @gameid			= @ps1_
	declare @adminid		varchar(1024)	set @adminid 		= @ps2_
	declare @adminip		varchar(1024)	set @adminip 		= @ps3_
	declare @message		varchar(2048)	set @message		= @ps10_
	declare @phone			varchar(20)

	declare @comment		varchar(2048)
	declare @comment4		varchar(8000)

	declare @syscheck		int
	declare @market			int				set @market = 1
	declare @buytype		int				set @buytype = 0
	declare @version		int
	declare @iteminfover	int
	declare @iteminfourl	varchar(512)
	declare @patchurl		varchar(512)
	declare @recurl			varchar(512)

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
			set @patchurl	= @ps12_
			set @recurl		= @ps13_
			set @iteminfourl= @ps14_
			set @comment4	= @ps15_

			if(@subkind = 0)
				begin
					insert into dbo.tFVNotice(market,  buytype, comfile, comurl, comfile2, comurl2, comfile3, comurl3, comfile4, comurl4, comfile5, comurl5,  version,  patchurl,  recurl,   comment,   syscheck,  iteminfover,  iteminfourl)
					values(                  @market, @buytype, @ps1_,   @ps2_,  @ps3_,    @ps4_,   @ps5_,    @ps6_,   @ps7_,    @ps8_,   @ps9_,    @ps10_,  @version, @patchurl, @recurl,  @comment4, @syscheck, @iteminfover, @iteminfourl)

					-- 종류별 공지사항.
					select * from dbo.tFVNotice
					where idx in (select max(idx) from dbo.tFVNotice where market in (@SKT, @GOOGLE, @NHN, @LGT, @IPHONE) group by market, buytype)
					order by market
				end
			else if(@subkind = 1)
				begin
					update dbo.tFVNotice
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

							version		= @version,

							patchurl	= @patchurl,
							recurl	 	= @recurl,
							comment	 	= @comment4,
							iteminfover = @iteminfover,
							iteminfourl = @iteminfourl,

							syscheck 	= @syscheck
					where idx = @idx


					-- 종류별 공지사항.
					select * from dbo.tFVNotice
					where idx in (select max(idx) from dbo.tFVNotice where market in (@SKT, @GOOGLE, @NHN, @LGT, @IPHONE, @KT) group by market, buytype)
					order by market asc
				end
			else if(@subkind = 2)
				begin
					-- 종류별 공지사항.
					select * from dbo.tFVNotice
					where idx in (select max(idx) from dbo.tFVNotice where market in (@SKT, @GOOGLE, @NHN, @LGT, @IPHONE, @KT) group by market, buytype)
					order by market asc
				end
			else if(@subkind = 10)
				begin
					insert into dbo.tFVSysRecommend2(rewarditemcode, rewardcnt, syscheck, ordering, packmarket, comfile, comurl, compackname)
					values(                                    @p4_,      @p5_,     @p6_,     @p7_,      @ps1_,   @ps2_,   @ps3_,      @ps4_)

					-- 종류별 추천게임.
					select * from dbo.tFVSysRecommend2
					order by syscheck desc, ordering desc
				end
			else if(@subkind = 11)
				begin
					update dbo.tFVSysRecommend2
						set
							packmarket		= @ps1_,
							comfile			= @ps2_,
							comurl			= @ps3_,
							compackname		= @ps4_,
							rewarditemcode	= @p4_,
							rewardcnt		= @p5_,
							syscheck		= @p6_,
							ordering		= @p7_
					where idx = @p3_


					-- 종류별 추천게임
					select * from dbo.tFVSysRecommend2
					order by syscheck desc, ordering desc
				end
			else if(@subkind = 12)
				begin
					-- 종류별 추천게임
					select * from dbo.tFVSysRecommend2
					order by syscheck desc, ordering desc
				end
		end

	------------------------------------------------
	--	완료
	------------------------------------------------
	set nocount off
End
