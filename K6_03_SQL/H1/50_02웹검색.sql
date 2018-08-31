/*
--공지사항작성(20)
--select top 100 * from dbo.tNotice order by writedate desc
exec spu_HomerunDS	
	20, 1, 1, 0, 22,	
	-1, -1, -1, -1, -1,		
	'http://210.123.107.7:40002/Game4/sb.jsp', 
	'http://www.facebook.com/homerunleague', 
	'http://m.naver.com', 
	'http://210.123.107.7:40002/Game4/_ad/top_ad_image.png', 
	'http://m.naver.com', 
	'http://210.123.107.7:40002/Game4/_ad/top_ad_image.png', 
	'', 
	'', 
	'', 
	'오픈을 축하 합니다.'


-- toto(27)
--- exec spu_HomerunDS 27, 0,   -1, -1,   -1, -1, -1, -1,   -1, -1,		'', '', '', '', '', 	'', '', '', '', '' 										-- 리스트
--- exec spu_HomerunDS 27, 1,   -1,  1,    2,  3, -1, -1,   -1, -1,		'2013-02-25 13:30', 'B조 호주 : 대만', '', '', '', 	'', '', '', '', '' 			-- 입력
--- exec spu_HomerunDS 27, 1,   -1,  1,    4,  5, -1, -1,   -1, -1,		'2013-02-25 19:00', 'A조 일본 : 브라질', '', '', '', 	'', '', '', '', '' 		-- 입력
--- exec spu_HomerunDS 27, 1,   -1,  1,    6,  7, -1, -1,   -1, -1,		'2013-02-25 20:30', 'B조 대한민국 : 네덜란드', '', '', '', 	'', '', '', '', '' 	-- 입력
--- exec spu_HomerunDS 27, 1,   -1,  1,    8,  9, -1, -1,   -1, -1,		'2013-03-03 12:00', 'A조 쿠바 : 브라질', '', '', '', 	'', '', '', '', ''		-- 입력
					   kind
                           subkind        acountry#					totodate#
								 totoid       bcountry#										title#
									 totoday#     apoint$
													  bpoint$
															active@
--- exec spu_HomerunDS 27, 10,   1,  1,   12, 13, -1, -1,   -1, -1,		'2013-02-25 13:30', 'B조 호주 : 대만1', '', '', '', 	'', '', '', '', '' 		-- 일반정보 수정
--- exec spu_HomerunDS 27, 11,   1, -1,   -1, -1, -1, -1,    1, -1,		'2013-02-25 13:30', 'B조 호주 : 대만1', '', '', '', 	'', '', '', '', '' 		-- 활성화 수정
--- exec spu_HomerunDS 27, 12,   7, -1,   -1, -1,  1, 10,   -1, -1,		'2013-02-25 13:30', 'B조 호주 : 대만', '', '', '', 	'', '', '', '', '' 			-- 1:10으로 승리

--- exec spu_HomerunDS 27, 20,    1, -1,   -1, -1, -1, -1,   -1, -1,	'2013-02-25 13:30', 'B조 호주 : 대만', '', '', '', 	'', '', '', '', '' 			-- 지급 1, 2모드지급
*/
	
IF OBJECT_ID ( 'dbo.spu_HomerunDS', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_HomerunDS;
GO 

------------------------------------------------
--	1. 개발일반 프로세서
------------------------------------------------
create procedure dbo.spu_HomerunDS
	@kind_			int,
	@p2_			int,
	@p3_			int,
	@p4_			int,
	@p5_			int,
	@p6_			int,
	@p7_			int,
	@p8_			int,
	@p9_			int,
	@p10_			bigint,
	@ps1_			varchar(512),
	@ps2_			varchar(512),
	@ps3_			varchar(512),
	@ps4_			varchar(512),
	@ps5_			varchar(512),
	@ps6_			varchar(512),
	@ps7_			varchar(512),
	@ps8_			varchar(512),
	@ps9_			varchar(512),
	@ps10_			varchar(4096)
	WITH ENCRYPTION -- 프로시져를 암호화함.
as	
	------------------------------------------------
	-- 일반값
	declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1			
	declare @RESULT_ERROR						int				set @RESULT_ERROR						= -1	
	
	------------------------------------------------
	--	프로시져 종류
	------------------------------------------------
	declare @KIND_USER_MESSAGE					int				set @KIND_USER_MESSAGE					= 1
	declare @KIND_USER_BLOCK_LOG				int				set @KIND_USER_BLOCK_LOG				= 2
	declare @KIND_USER_BLOCK_RELEASE			int				set @KIND_USER_BLOCK_RELEASE			= 8
	declare @KIND_USER_DELETE_LOG				int				set @KIND_USER_DELETE_LOG				= 10
	declare @KIND_USER_DELETE_RELEASE			int				set @KIND_USER_DELETE_RELEASE			= 11
	declare @KIND_BATTLE_LOG					int				set @KIND_BATTLE_LOG					= 3
	declare @KIND_BATTLE_SEARCHLOG				int				set @KIND_BATTLE_SEARCHLOG				= 15
	declare @KIND_USER_UNUSUAL_LOG				int				set @KIND_USER_UNUSUAL_LOG				= 4
	declare @KIND_SEARCH_ITEMINFO				int				set @KIND_SEARCH_ITEMINFO				= 5
	declare @KIND_ITEM_BUY_LOG					int				set @KIND_ITEM_BUY_LOG					= 6
	declare @KIND_USER_SEARCH					int				set @KIND_USER_SEARCH					= 7
	declare @KIND_USER_ITEM_UPGRADE				int				set @KIND_USER_ITEM_UPGRADE 			= 9
	declare @KIND_USER_CASH_CHANGE				int				set @KIND_USER_CASH_CHANGE				= 12
	declare @KIND_USER_CASH_BUY					int				set @KIND_USER_CASH_BUY					= 13	
	declare @KIND_USER_CASH_PLUS				int				set @KIND_USER_CASH_PLUS				= 16
	declare @KIND_USER_CASH_MINUS				int				set @KIND_USER_CASH_MINUS				= 23
	declare @KIND_USER_CASH_LOG_DELETE			int				set @KIND_USER_CASH_LOG_DELETE			= 17
	declare @KIND_USER_DELETEID					int				set @KIND_USER_DELETEID					= 18
	declare @KIND_USER_SETTING					int				set @KIND_USER_SETTING					= 19
	declare @KIND_NOTICE_SETTING				int				set @KIND_NOTICE_SETTING				= 20
	declare @KIND_STATISTICS_INFO				int				set @KIND_STATISTICS_INFO				= 21
	declare @KIND_OPEN_TEST						int				set @KIND_OPEN_TEST						= 22
	declare @KIND_QUEST_INFO					int				set @KIND_QUEST_INFO					= 24
	declare @KIND_ADMIN_LOGIN					int				set @KIND_ADMIN_LOGIN					= 25
	declare @KIND_NEWINFO_LIST					int				set @KIND_NEWINFO_LIST					= 26
	declare @KIND_TOTO_LIST						int				set @KIND_TOTO_LIST						= 27
	
	
	------------------------------------------------
	--	일반변수선언
	------------------------------------------------
	declare @subkind		int
	declare @market			int
	declare @syscheck		int
	declare @idx			int
	declare @branchurl		varchar(512)
	declare @facebookurl	varchar(512)
	declare @adurl			varchar(512)
	declare @adfile			varchar(512)
	declare @adurl2			varchar(512)
	declare @adfile2		varchar(512)
	declare @comment		varchar(4096)
	
	-- toto
	declare @totoid			int
	declare @totodate		varchar(16)
	declare @totoday		int	
	
	declare @title			varchar(128)
	declare @acountry		int
	declare @bcountry		int
	declare @apoint			int
	declare @bpoint			int
	
	declare @active			int
	declare @victcountry	int
	declare @victpoint		int
	
	declare @chalmode1cnt		int
	declare @chalmode2cnt		int
	declare @chalmode1give		int
	declare @chalmode2give		int
	declare @chalmode1wincnt	int
	declare @chalmode2wincnt	int
	
Begin
	------------------------------------------------
	--	초기화
	------------------------------------------------
	set nocount on

	------------------------------------------------
	--	각상태분기
	------------------------------------------------
	if(@kind_ = @KIND_NOTICE_SETTING)
		begin
			set @subkind 	= @p2_
			set @market		= @p3_
			set @syscheck	= @p4_
			set @idx		= @p5_
			
			set @branchurl 		= @ps1_			
			set @facebookurl	= @ps2_
			set @adurl			= @ps3_
			set @adfile			= @ps4_
			set @adurl2			= @ps5_
			set @adfile2		= @ps6_
			set @comment		= @ps10_
			
			if(@subkind = 0)
				begin
					insert into dbo.tNotice(market, comment, syscheck, branchurl, facebookurl, adurl, adfile, adurl2, adfile2) 
					values(@market, @comment, @syscheck, @branchurl, @facebookurl, @adurl, @adfile, @adurl2, @adfile2)
					
					
					select * from dbo.tNotice
					where idx in (select max(idx) from dbo.tNotice group by market)
					order by market asc
					
				end
			else if(@subkind = 1)
				begin
					update dbo.tNotice
						set
							market		= @market,
							comment 	= @comment, 
							branchurl 	= @branchurl,
							facebookurl = @facebookurl,
							adurl		= @adurl,
							adfile		= @adfile,
							adurl2		= @adurl2,
							adfile2		= @adfile2,
							
							syscheck 	= @syscheck
					where idx = @idx
					
					
					select * from dbo.tNotice
					where idx in (select max(idx) from dbo.tNotice group by market)
					order by market asc
				end
			else if(@subkind = 2)
				begin
					select * from dbo.tNotice
					where idx in (select max(idx) from dbo.tNotice group by market)
					order by market asc
				end
		end
	else if(@kind_ = @KIND_TOTO_LIST)
		begin
			set @subkind 			= @p2_
			
			set @totoid 			= @p3_
			set @totoday 			= @p4_
			
			set @acountry			= @p5_
			set @bcountry			= @p6_
			set @apoint				= @p7_
			set @bpoint				= @p8_
			set @active				= @p9_
			
			set @totodate			= @ps1_
			set @title				= @ps2_	
			
			
			if(@subkind = 0)
				begin
					select top 100 * from dbo.tTotoMaster 
					--order by totoid desc
					order by totodate desc
				end
			else if(@subkind = 1)
				begin
					select @totoid = max(totoid) + 1 from dbo.tTotoMaster
					if(isnull(@totoid, 0) = 0)
						begin
							set @totoid = 1
						end
					
					if(not exists(select top 1 * from dbo.tTotoMaster where totodate = @totodate and acountry = @acountry and bcountry = @bcountry))
						begin
							insert into dbo.tTotoMaster(totoid,  totodate,  totoday,  title,  acountry,  bcountry) 
							values(                    @totoid, @totodate, @totoday, @title, @acountry, @bcountry)
						end
					
					select top 1 * from dbo.tTotoMaster 
					--order by totoid desc
					order by totodate desc
				end
			else if(@subkind = 10)
				begin
					update dbo.tTotoMaster
						set
							totodate	= @totodate,
							totoday 	= @totoday,
							
							title 		= @title,
							acountry 	= @acountry,
							bcountry 	= @bcountry
					where totoid = @totoid
					
					select top 1 * from dbo.tTotoMaster 
					--order by totoid desc
					order by totodate desc
				end
			else if(@subkind = 11)
				begin
				
					update dbo.tTotoMaster
						set
							active 		= @active
					where totoid = @totoid
					
					select top 1 * from dbo.tTotoMaster 
					--order by totoid desc
					order by totodate desc
				end
			else if(@subkind = 12)
				begin
					------------------------------------------------------------------------
					-- -2	: 점수를 돌려준다.
					-- -1 	: 둘다 (-1)이면 초기화를 진행한다.
					-- >= 0 : 승리 팀을 설정한다.
					--        승리점수가 같으면 동점으로 처리해서 동점 처리를 한다.
					------------------------------------------------------------------------
					if(@apoint = -2)
						begin
							set @victcountry 	= 666
							set @victpoint		= -2
						end
					else if(@apoint = -1)
						begin
							set @victcountry 	= -1
							set @victpoint		= -1
						end
					else
						begin
							if(@apoint = @bpoint)
								begin
									set @victcountry 	= 777
									set @victpoint		= @apoint
								end
							else if(@apoint >= @bpoint)
								begin
									set @victcountry 	= @acountry
									set @victpoint		= @apoint
								end
							else
								begin
									set @victcountry 	= @bcountry
									set @victpoint		= @bpoint
								end
						end
				
					update dbo.tTotoMaster
						set
							apoint		= @apoint,
							bpoint		= @bpoint,
							
							victcountry = @victcountry,
							victpoint 	= @victpoint
					where totoid = @totoid
					
					select top 1 * from dbo.tTotoMaster 
					--order by totoid desc
					order by totodate desc
				end
			else if(@subkind = 20)
				begin
					exec spu_TotoCheck @totoid
				end
		end

		
			
	------------------------------------------------
	--	완료
	------------------------------------------------
	set nocount off
End

