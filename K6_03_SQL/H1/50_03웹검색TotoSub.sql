/*
exec spu_TotoCheck 1
exec spu_TotoCheck 2
exec spu_TotoCheck 3
exec spu_TotoCheck 4
exec spu_TotoCheck 5
exec spu_TotoCheck 6
*/

IF OBJECT_ID ( 'dbo.spu_TotoCheck', 'P' ) IS NOT NULL 
    DROP PROCEDURE dbo.spu_TotoCheck;
GO 

------------------------------------------------
--	1. 프로시져 생성
------------------------------------------------
create procedure dbo.spu_TotoCheck
	@totoid_								int
	WITH ENCRYPTION -- 프로시져를 암호화함.
as	

	declare @totoid			int					set @totoid	= @totoid_
	declare @totodate		varchar(16)
	declare @victcountry	int				
	declare @victpoint		int				
	declare @title			varchar(128)
	
	--------------------------------------------
	-- 1-1. 변수 선언
	declare @idx				int
	declare @gameid 			varchar(20)
	declare @chalmode			int	
	declare @chalbat			int
	declare @chalsb				int
	declare @chalcountry		int
	declare @chalpoint			int
	declare @comment			varchar(128)
	declare @bvict				int
	
Begin	
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG 0-0', @totoid_ totoid_
	
	-- 2-1. 커서 설정
	declare curTotoUser Cursor for
	select idx, gameid, chalmode, chalbat, chalsb, chalcountry, chalpoint from dbo.tTotoUser 
	where totoid = @totoid and chalstate = 1
	
	-- 마스터에서 승리국, 승리점수
	select @victcountry = victcountry, @victpoint = victpoint, @title = title, @totodate = totodate
	from dbo.tTotoMaster 
	where totoid = @totoid
	--select 'DEBUG 0-1', @victcountry victcountry, @victpoint victpoint, @title title, @totodate totodate
	if(isnull(@victcountry, -1) = -1 or isnull(@victcountry, -1) = -1)
		begin
			-----------------------------------------------------
			-- tTotoMaster > 모드1미지급(-1), 미지급일
			-----------------------------------------------------
			--select 'DEBUG 0-2-1 tTotoMaster > 모드1미지급(-1), 미지급일'
			set @bvict = -1
			
			update dbo.tTotoMaster
				set
					chalmode1give 	= -1,
					chalmode2give 	= -1,
					givedate 		= null
			where totoid = @totoid
		end
	else 
		begin
			-----------------------------------------------------
			-- tTotoMaster > 모드1지급(1), 지급일
			-----------------------------------------------------
			--select 'DEBUG 0-2-2 tTotoMaster > 모드1지급(1), 지급일'
			set @bvict = 1
			
			update dbo.tTotoMaster
				set
					chalmode1give 	= 1,
					chalmode2give 	= 1,
					givedate 		= getdate()
			where totoid = @totoid
		end
	
	-- 2-2. 커서오픈
	open curTotoUser
	
	-- 2-3. 커서 사용
	Fetch next from curTotoUser into @idx, @gameid, @chalmode, @chalbat, @chalsb, @chalcountry, @chalpoint
	while @@Fetch_status = 0
		Begin
			--select 'DEBUG 0-3', @idx idx, @gameid gameid, @chalmode chalmode, @chalbat chalbat, @chalsb chalsb, @chalcountry chalcountry, @chalpoint chalpoint
			if(@bvict = -1)
				begin
					break;
				end
			
			if(@victcountry = 666)
				begin
					-----------------------------------------------------
					-- gameid > tUserMaster > (우천)도전금액 돌려주기
					-----------------------------------------------------
					--select 'DEBUG 0-1 gameid > tUserMaster > 도전금액 돌려주기'
					update dbo.tUserMaster 
						set
							silverball = silverball + @chalsb
					where gameid = @gameid
					
					-----------------------------------------------------
					-- tUserMessage > 우천으로 경기 취소되었습니다.
					-----------------------------------------------------
					set @comment = @title 
									+ ' ' + @totodate 
									+ '(우천으로 경기 취소되었습니다.)' 
					--select 'DEBUG 0-2 tUserMessage > 쪽지', @comment
					
					insert into tMessage(gameid, comment) 
					values(@gameid, @comment)
					
					-----------------------------------------------------
					-- tTotoUser > 게임결과1(승), 지급상태(2), 지급일
					-----------------------------------------------------
					--select 'DEBUG 1-3 tTotoUser > 게임결과1(승), 지급상태(2), 지급일'
					update dbo.tTotoUser
						set
							chalresult1 = 1,
							chalstate	= 2,
							givedate	= getdate()
					where idx = @idx
					
					-----------------------------------------------------
					-- tTotoMaster > 모드1맟춤(+1)
					-----------------------------------------------------
					--select 'DEBUG 1-4 tTotoMaster > 모드1맟춤(+1)'
					update dbo.tTotoMaster
						set
							chalmode1wincnt = chalmode1wincnt + 1,
							chalmode1winsb = chalmode1winsb + @chalsb		--계산이 되어짐
					where totoid = @totoid
				end
			else if(@chalmode = 1)
				begin
					if((@victcountry = @chalcountry) or (@victcountry = 777))
						begin
							-----------------------------------------------------
							-- gameid > tUserMaster > 도전금액 X 배수 실버입금
							-----------------------------------------------------
							--select 'DEBUG 1-1 gameid > tUserMaster > 도전금액 X 배수 실버입금'
							set @chalsb = @chalsb * @chalbat
							update dbo.tUserMaster 
								set
									silverball = silverball + @chalsb
							where gameid = @gameid
							
							-----------------------------------------------------
							-- tUserMessage > 쪽지기록(승)
							-----------------------------------------------------
							set @comment = @title 
											+ ' ' + @totodate 
											+ '(도전1:'+ ltrim(rtrim(str(@chalsb))) +')' 
							--select 'DEBUG 1-2 tUserMessage > 쪽지기록(승)', @comment
							
							insert into tMessage(gameid, comment) 
							values(@gameid, @comment)
							
							-----------------------------------------------------
							-- tTotoUser > 게임결과1(승), 지급상태(2), 지급일
							-----------------------------------------------------
							--select 'DEBUG 1-3 tTotoUser > 게임결과1(승), 지급상태(2), 지급일'
							update dbo.tTotoUser
								set
									chalresult1 = 1,
									chalstate	= 2,
									givedate	= getdate()
							where idx = @idx
							
							-----------------------------------------------------
							-- tTotoMaster > 모드1맟춤(+1)
							-----------------------------------------------------
							--select 'DEBUG 1-4 tTotoMaster > 모드1맟춤(+1)'
							update dbo.tTotoMaster
								set
									chalmode1wincnt = chalmode1wincnt + 1,
									chalmode1winsb = chalmode1winsb + @chalsb		--계산이 되어짐
							where totoid = @totoid
						end
					else
						begin
							-----------------------------------------------------
							-- tUserMessage > 쪽지기록(패)
							-----------------------------------------------------
							set @comment = @title 
											+ ' ' + @totodate 
											+ '(도전1 다음기회에...)' 
							--select 'DEBUG 2-1 tUserMessage > 쪽지기록(패)', @comment
							
							insert into tMessage(gameid, comment) 
							values(@gameid, @comment)
							
							-----------------------------------------------------
							-- tTotoUser > 게임결과1(승), 지급상태(2), 지급일
							-----------------------------------------------------
							--select 'DEBUG 2-2 tTotoUser > 게임결과1(패), 지급상태(2), 지급일'
							update dbo.tTotoUser
								set
									chalresult1 = 0,
									chalstate	= 2,
									givedate	= getdate()
							where idx = @idx
						end
				end
			else if(@chalmode = 2)
				begin
					if((@victcountry = @chalcountry and (@victpoint >= @chalpoint and @victpoint <= @chalpoint + 3)) or (@victcountry = 777))
						begin
							-----------------------------------------------------
							-- gameid > tUserMaster > 도전금액 X 배수 실버입금
							-----------------------------------------------------
							--select 'DEBUG 3-1 gameid > tUserMaster > 도전금액 X 배수 실버입금'
							set @chalsb = @chalsb * @chalbat
							update dbo.tUserMaster 
								set
									silverball = silverball + @chalsb
							where gameid = @gameid
							
							-----------------------------------------------------
							-- tUserMessage > 쪽지기록(승)
							-----------------------------------------------------
							set @comment = @title 
											+ ' ' + @totodate 
											+ '(도전2:'+ ltrim(rtrim(str(@chalsb))) +')' 
							--select 'DEBUG 3-2 tUserMessage > 쪽지기록(승) ', @comment
							
							insert into tMessage(gameid, comment) 
							values(@gameid, @comment)
							
							-----------------------------------------------------
							-- tTotoUser > 게임결과2(승), 지급상태(2), 지급일
							-----------------------------------------------------
							--select 'DEBUG 3-3 tTotoUser > 게임결과2(승), 지급상태(2), 지급일'
							update dbo.tTotoUser
								set
									chalresult2 = 1,
									chalstate	= 2,
									givedate	= getdate()
							where idx = @idx
							
							-----------------------------------------------------
							-- tTotoMaster > 모드1맟춤(+1)
							-----------------------------------------------------
							--select 'DEBUG 3-4 tTotoMaster > 모드1맟춤(+1)'
							update dbo.tTotoMaster
								set
									chalmode2wincnt = chalmode2wincnt + 1,
									chalmode2winsb  = chalmode2winsb + @chalsb	--계산이 되어짐
							where totoid = @totoid
						end
					else
						begin
							-----------------------------------------------------
							-- tUserMessage > 쪽지기록(패)
							-----------------------------------------------------
							set @comment = @title 
											+ ' ' + @totodate 
											+ '(도전2 다음기회에...)' 
							--select 'DEBUG 4-1 tUserMessage > 쪽지기록(패)', @comment
							
							insert into tMessage(gameid, comment) 
							values(@gameid, @comment)
							
							-----------------------------------------------------
							-- tTotoUser > 게임결과2(패), 지급상태(2), 지급일
							-----------------------------------------------------
							--select 'DEBUG 4-2 tTotoUser > 게임결과2(패), 지급상태(2), 지급일'
							update dbo.tTotoUser
								set
									chalresult2 = 0,
									chalstate	= 2,
									givedate	= getdate()
							where idx = @idx
						end
				end
			
			Fetch next from curTotoUser into @idx, @gameid, @chalmode, @chalbat, @chalsb, @chalcountry, @chalpoint
		end
	
	-- 2-4. 커서닫기
	close curTotoUser
	Deallocate curTotoUser
	
	select 1 rtn
	------------------------------------------------
	--	3-5. 유저정보
	------------------------------------------------		
	set nocount off
End
