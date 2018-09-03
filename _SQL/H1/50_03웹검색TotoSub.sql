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
--	1. ���ν��� ����
------------------------------------------------
create procedure dbo.spu_TotoCheck
	@totoid_								int
	WITH ENCRYPTION -- ���ν����� ��ȣȭ��.
as	

	declare @totoid			int					set @totoid	= @totoid_
	declare @totodate		varchar(16)
	declare @victcountry	int				
	declare @victpoint		int				
	declare @title			varchar(128)
	
	--------------------------------------------
	-- 1-1. ���� ����
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
	--	3-1. �ʱ�ȭ
	------------------------------------------------
	set nocount on
	--select 'DEBUG 0-0', @totoid_ totoid_
	
	-- 2-1. Ŀ�� ����
	declare curTotoUser Cursor for
	select idx, gameid, chalmode, chalbat, chalsb, chalcountry, chalpoint from dbo.tTotoUser 
	where totoid = @totoid and chalstate = 1
	
	-- �����Ϳ��� �¸���, �¸�����
	select @victcountry = victcountry, @victpoint = victpoint, @title = title, @totodate = totodate
	from dbo.tTotoMaster 
	where totoid = @totoid
	--select 'DEBUG 0-1', @victcountry victcountry, @victpoint victpoint, @title title, @totodate totodate
	if(isnull(@victcountry, -1) = -1 or isnull(@victcountry, -1) = -1)
		begin
			-----------------------------------------------------
			-- tTotoMaster > ���1������(-1), ��������
			-----------------------------------------------------
			--select 'DEBUG 0-2-1 tTotoMaster > ���1������(-1), ��������'
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
			-- tTotoMaster > ���1����(1), ������
			-----------------------------------------------------
			--select 'DEBUG 0-2-2 tTotoMaster > ���1����(1), ������'
			set @bvict = 1
			
			update dbo.tTotoMaster
				set
					chalmode1give 	= 1,
					chalmode2give 	= 1,
					givedate 		= getdate()
			where totoid = @totoid
		end
	
	-- 2-2. Ŀ������
	open curTotoUser
	
	-- 2-3. Ŀ�� ���
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
					-- gameid > tUserMaster > (��õ)�����ݾ� �����ֱ�
					-----------------------------------------------------
					--select 'DEBUG 0-1 gameid > tUserMaster > �����ݾ� �����ֱ�'
					update dbo.tUserMaster 
						set
							silverball = silverball + @chalsb
					where gameid = @gameid
					
					-----------------------------------------------------
					-- tUserMessage > ��õ���� ��� ��ҵǾ����ϴ�.
					-----------------------------------------------------
					set @comment = @title 
									+ ' ' + @totodate 
									+ '(��õ���� ��� ��ҵǾ����ϴ�.)' 
					--select 'DEBUG 0-2 tUserMessage > ����', @comment
					
					insert into tMessage(gameid, comment) 
					values(@gameid, @comment)
					
					-----------------------------------------------------
					-- tTotoUser > ���Ӱ��1(��), ���޻���(2), ������
					-----------------------------------------------------
					--select 'DEBUG 1-3 tTotoUser > ���Ӱ��1(��), ���޻���(2), ������'
					update dbo.tTotoUser
						set
							chalresult1 = 1,
							chalstate	= 2,
							givedate	= getdate()
					where idx = @idx
					
					-----------------------------------------------------
					-- tTotoMaster > ���1����(+1)
					-----------------------------------------------------
					--select 'DEBUG 1-4 tTotoMaster > ���1����(+1)'
					update dbo.tTotoMaster
						set
							chalmode1wincnt = chalmode1wincnt + 1,
							chalmode1winsb = chalmode1winsb + @chalsb		--����� �Ǿ���
					where totoid = @totoid
				end
			else if(@chalmode = 1)
				begin
					if((@victcountry = @chalcountry) or (@victcountry = 777))
						begin
							-----------------------------------------------------
							-- gameid > tUserMaster > �����ݾ� X ��� �ǹ��Ա�
							-----------------------------------------------------
							--select 'DEBUG 1-1 gameid > tUserMaster > �����ݾ� X ��� �ǹ��Ա�'
							set @chalsb = @chalsb * @chalbat
							update dbo.tUserMaster 
								set
									silverball = silverball + @chalsb
							where gameid = @gameid
							
							-----------------------------------------------------
							-- tUserMessage > �������(��)
							-----------------------------------------------------
							set @comment = @title 
											+ ' ' + @totodate 
											+ '(����1:'+ ltrim(rtrim(str(@chalsb))) +')' 
							--select 'DEBUG 1-2 tUserMessage > �������(��)', @comment
							
							insert into tMessage(gameid, comment) 
							values(@gameid, @comment)
							
							-----------------------------------------------------
							-- tTotoUser > ���Ӱ��1(��), ���޻���(2), ������
							-----------------------------------------------------
							--select 'DEBUG 1-3 tTotoUser > ���Ӱ��1(��), ���޻���(2), ������'
							update dbo.tTotoUser
								set
									chalresult1 = 1,
									chalstate	= 2,
									givedate	= getdate()
							where idx = @idx
							
							-----------------------------------------------------
							-- tTotoMaster > ���1����(+1)
							-----------------------------------------------------
							--select 'DEBUG 1-4 tTotoMaster > ���1����(+1)'
							update dbo.tTotoMaster
								set
									chalmode1wincnt = chalmode1wincnt + 1,
									chalmode1winsb = chalmode1winsb + @chalsb		--����� �Ǿ���
							where totoid = @totoid
						end
					else
						begin
							-----------------------------------------------------
							-- tUserMessage > �������(��)
							-----------------------------------------------------
							set @comment = @title 
											+ ' ' + @totodate 
											+ '(����1 ������ȸ��...)' 
							--select 'DEBUG 2-1 tUserMessage > �������(��)', @comment
							
							insert into tMessage(gameid, comment) 
							values(@gameid, @comment)
							
							-----------------------------------------------------
							-- tTotoUser > ���Ӱ��1(��), ���޻���(2), ������
							-----------------------------------------------------
							--select 'DEBUG 2-2 tTotoUser > ���Ӱ��1(��), ���޻���(2), ������'
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
							-- gameid > tUserMaster > �����ݾ� X ��� �ǹ��Ա�
							-----------------------------------------------------
							--select 'DEBUG 3-1 gameid > tUserMaster > �����ݾ� X ��� �ǹ��Ա�'
							set @chalsb = @chalsb * @chalbat
							update dbo.tUserMaster 
								set
									silverball = silverball + @chalsb
							where gameid = @gameid
							
							-----------------------------------------------------
							-- tUserMessage > �������(��)
							-----------------------------------------------------
							set @comment = @title 
											+ ' ' + @totodate 
											+ '(����2:'+ ltrim(rtrim(str(@chalsb))) +')' 
							--select 'DEBUG 3-2 tUserMessage > �������(��) ', @comment
							
							insert into tMessage(gameid, comment) 
							values(@gameid, @comment)
							
							-----------------------------------------------------
							-- tTotoUser > ���Ӱ��2(��), ���޻���(2), ������
							-----------------------------------------------------
							--select 'DEBUG 3-3 tTotoUser > ���Ӱ��2(��), ���޻���(2), ������'
							update dbo.tTotoUser
								set
									chalresult2 = 1,
									chalstate	= 2,
									givedate	= getdate()
							where idx = @idx
							
							-----------------------------------------------------
							-- tTotoMaster > ���1����(+1)
							-----------------------------------------------------
							--select 'DEBUG 3-4 tTotoMaster > ���1����(+1)'
							update dbo.tTotoMaster
								set
									chalmode2wincnt = chalmode2wincnt + 1,
									chalmode2winsb  = chalmode2winsb + @chalsb	--����� �Ǿ���
							where totoid = @totoid
						end
					else
						begin
							-----------------------------------------------------
							-- tUserMessage > �������(��)
							-----------------------------------------------------
							set @comment = @title 
											+ ' ' + @totodate 
											+ '(����2 ������ȸ��...)' 
							--select 'DEBUG 4-1 tUserMessage > �������(��)', @comment
							
							insert into tMessage(gameid, comment) 
							values(@gameid, @comment)
							
							-----------------------------------------------------
							-- tTotoUser > ���Ӱ��2(��), ���޻���(2), ������
							-----------------------------------------------------
							--select 'DEBUG 4-2 tTotoUser > ���Ӱ��2(��), ���޻���(2), ������'
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
	
	-- 2-4. Ŀ���ݱ�
	close curTotoUser
	Deallocate curTotoUser
	
	select 1 rtn
	------------------------------------------------
	--	3-5. ��������
	------------------------------------------------		
	set nocount off
End
