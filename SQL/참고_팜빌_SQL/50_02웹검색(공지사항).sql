use Farm
GO

/*
-- 공지사항작성(20)
exec spu_FVFarmD3 20, 0, -1,  1,  0, 101,  0, -1, -1, -1, -1, -1, -1, -1, -1, '1:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image01.png;2:http://m.naver.com;3:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png;4:http://m.daum.com;5:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png;6:http://m.hungryapp.co.kr;', '1:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image01.png;2:http://m.naver.com;3:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png;4:http://m.daum.com;5:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png;6:http://m.hungryapp.co.kr;', '1:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image01.png;2:http://m.naver.com;3:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png;4:http://m.daum.com;5:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png;6:http://m.hungryapp.co.kr;', '', '', '', '', '', '', '', '', 'http://patchurl', 'http://recurl', '', '공지내용'	-- 작성
exec spu_FVFarmD3 20, 1,  6,  1,  0, 101,  0, -1, -1, -1, -1, -1, -1, -1, -1, '1:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image01.png;2:http://m.naver.com;3:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png;4:http://m.daum.com;5:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png;6:http://m.hungryapp.co.kr;', '1:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image01.png;2:http://m.naver.com;3:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png;4:http://m.daum.com;5:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png;6:http://m.hungryapp.co.kr;', '1:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image01.png;2:http://m.naver.com;3:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image02.png;4:http://m.daum.com;5:http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png;6:http://m.hungryapp.co.kr;', '', '', '', '', '', '', '', '', 'http://patchurl', 'http://recurl', '', '공지내용'	-- 수정
exec spu_FVFarmD3 20, 2, -1, -1, -1,  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''			-- 리스트

-- 추천게임
exec spu_FVFarmD3 20,10, -1, 5200,100, 1,  1, -1, -1, -1, -1, -1, -1, -1, -1, '1,2,3,4,5,6,7', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png', 'http://m.daum.com', 'com.sangsangdigital.farmvill', '', '', '', '', '', '', '', '', '', '', ''		-- 입력
exec spu_FVFarmD3 20,11,  1, 5200,200, 1,  1, -1, -1, -1, -1, -1, -1, -1, -1, '1,2,3,4,5,6,7', 'http://203.234.238.249:40009/Game4Farm/etc/_ad/top_ad_image03.png', 'http://m.daum.com', 'com.sangsangdigital.farmvill', '', '',  '', '', '', '', '', '', '', '', ''		-- 수정
exec spu_FVFarmD3 20,12, -1, -1, -1,  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''			-- 추천게임 리스트
*/

IF OBJECT_ID ( 'dbo.spu_FVFarmD3', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVFarmD3;
GO

------------------------------------------------
--	1. 개발일반 프로세서
------------------------------------------------
create procedure dbo.spu_FVFarmD3
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
	@ps15_			varchar(4096)
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
	declare @comment4		varchar(4096)

	declare @syscheck		int
	declare @market			int				set @market = 1
	declare @buytype		int				set @buytype = 0
	declare @version		int
	declare @iteminfover	int
	declare @patchurl		varchar(512)
	declare @recurl			varchar(512)

	declare @comfile		varchar(512)	set @comfile	= ''
	declare @comurl			varchar(512)	set @comurl		= ''
	declare @comfile2		varchar(512)	set @comfile2	= ''
	declare @comurl2		varchar(512)	set @comurl2	= ''
	declare @comfile3		varchar(512)	set @comfile3	= ''
	declare @comurl3		varchar(512)	set @comurl3	= ''
	declare @comfile4		varchar(512)	set @comfile4	= ''
	declare @comurl4		varchar(512)	set @comurl4	= ''
	declare @comfile5		varchar(512)	set @comfile5	= ''
	declare @comurl5		varchar(512)	set @comurl5	= ''
	declare @comfile6		varchar(512)	set @comfile6	= ''
	declare @comurl6		varchar(512)	set @comurl6	= ''
	declare @comfile7		varchar(512)	set @comfile7	= ''
	declare @comurl7		varchar(512)	set @comurl7	= ''
	declare @comfile8		varchar(512)	set @comfile8	= ''
	declare @comurl8		varchar(512)	set @comurl8	= ''
	declare @comfile9		varchar(512)	set @comfile9	= ''
	declare @comurl9		varchar(512)	set @comurl9	= ''

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
			set @comment4	= @ps15_

			if(@subkind in (0, 1))
				begin
					if(LEN(@ps1_) >= 3)
						begin
							select @comfile	= data from dbo.fnu_SplitURL(';', ':', @ps1_) where listidx = 1
							select @comurl	= data from dbo.fnu_SplitURL(';', ':', @ps1_) where listidx = 2
							select @comfile2= data from dbo.fnu_SplitURL(';', ':', @ps1_) where listidx = 3
							select @comurl2	= data from dbo.fnu_SplitURL(';', ':', @ps1_) where listidx = 4
							select @comfile3= data from dbo.fnu_SplitURL(';', ':', @ps1_) where listidx = 5
							select @comurl3	= data from dbo.fnu_SplitURL(';', ':', @ps1_) where listidx = 6
						end

					if(LEN(@ps2_) >= 3)
						begin
							select @comfile4= data from dbo.fnu_SplitURL(';', ':', @ps2_) where listidx = 1
							select @comurl4	= data from dbo.fnu_SplitURL(';', ':', @ps2_) where listidx = 2
							select @comfile5= data from dbo.fnu_SplitURL(';', ':', @ps2_) where listidx = 3
							select @comurl5	= data from dbo.fnu_SplitURL(';', ':', @ps2_) where listidx = 4
							select @comfile6= data from dbo.fnu_SplitURL(';', ':', @ps2_) where listidx = 5
							select @comurl6	= data from dbo.fnu_SplitURL(';', ':', @ps2_) where listidx = 6
						end

					if(LEN(@ps3_) >= 3)
						begin
							select @comfile7= data from dbo.fnu_SplitURL(';', ':', @ps3_) where listidx = 1
							select @comurl7	= data from dbo.fnu_SplitURL(';', ':', @ps3_) where listidx = 2
							select @comfile8= data from dbo.fnu_SplitURL(';', ':', @ps3_) where listidx = 3
							select @comurl8	= data from dbo.fnu_SplitURL(';', ':', @ps3_) where listidx = 4
							select @comfile9= data from dbo.fnu_SplitURL(';', ':', @ps3_) where listidx = 5
							select @comurl9	= data from dbo.fnu_SplitURL(';', ':', @ps3_) where listidx = 6
						end


				end

			if(@subkind = 0)
				begin
					insert into dbo.tFVNotice(market,  buytype,  comfile,  comurl,  comfile2,  comurl2,  comfile3,  comurl3,  comfile4,  comurl4,  comfile5,  comurl5,  comfile6,  comurl6,  comfile7,  comurl7,  comfile8,  comurl8,  comfile9,  comurl9,  version,  patchurl,  recurl,   comment,   syscheck,  iteminfover)
					values(                  @market, @buytype, @comfile, @comurl, @comfile2, @comurl2, @comfile3, @comurl3, @comfile4, @comurl4, @comfile5, @comurl5, @comfile6, @comurl6, @comfile7, @comurl7, @comfile8, @comurl8, @comfile9, @comurl9, @version, @patchurl, @recurl,  @comment4, @syscheck, @iteminfover)

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

							comfile		= @comfile,
							comurl 		= @comurl,
							comfile2	= @comfile2,
							comurl2 	= @comurl2,
							comfile3	= @comfile3,
							comurl3		= @comurl3,
							comfile4	= @comfile4,
							comurl4		= @comurl4,
							comfile5	= @comfile5,
							comurl5		= @comurl5,
							comfile6	= @comfile6,
							comurl6		= @comurl6,
							comfile7	= @comfile7,
							comurl7		= @comurl7,
							comfile8	= @comfile8,
							comurl8		= @comurl8,
							comfile9	= @comfile9,
							comurl9		= @comurl9,

							version		= @version,

							patchurl	= @patchurl,
							recurl	 	= @recurl,
							comment	 	= @comment4,
							iteminfover = @iteminfover,

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
