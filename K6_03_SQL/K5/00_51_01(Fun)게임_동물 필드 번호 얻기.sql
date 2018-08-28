
--################################################################
-- 동물 필드 번호 얻기
-- select dbo.fun_getUserItemFieldIdxAni('dd11')
-- select dbo.fun_getUserItemFieldIdxAni('dd12')
-- select dbo.fun_getUserItemFieldIdxAni('dd13')
-- select dbo.fun_getUserItemFieldIdxAni('dd14')
-- select dbo.fun_getUserItemFieldIdxAni('dd15')
--################################################################
use GameMTBaseball
GO

IF OBJECT_ID ( N'dbo.fun_getUserItemFieldIdxAni', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fun_getUserItemFieldIdxAni;
GO

CREATE FUNCTION dbo.fun_getUserItemFieldIdxAni(
	@gameid_ 			varchar(20) = ''
)
	RETURNS int
AS
BEGIN
	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_DIRECT			int 				set @USERITEM_INVENKIND_DIRECT				= 40
	declare @USERITEM_INVENKIND_INFO			int 				set @USERITEM_INVENKIND_INFO				= 60
	declare @USERITEM_INVENKIND_PET				int 				set @USERITEM_INVENKIND_PET					= 1000

	---------------------------------------------------
	-- 빈자리 찾기 커서
	-- 0   2 3 4 5 		 >  1
	-- 0 1 2 3 4 5 		 >  6
	-- 0 1 2 3 4 5 6 7 8 > -1
	---------------------------------------------------
	declare @invenkind		int		set @invenkind	= @USERITEM_INVENKIND_ANI
	declare @rtn 			int		set @rtn 		= -1
	declare @fieldloop		int		set @fieldloop 	= 0
	declare @fieldidx		int
	declare @dummy			int

	-- 1. 커서 생성
	declare curAni Cursor for
	select fieldidx from dbo.tUserItem
	where gameid = @gameid_ and invenkind = @invenkind and fieldidx >= 0 and fieldidx <= 8
	order by fieldidx asc

	-- 2. 커서 오픈
	open curAni

	-- 3. 커서 사용
	Fetch next from curAni into @fieldidx
	while @@Fetch_status = 0
		begin
			if(@fieldidx != @fieldloop)
				begin
					set @rtn = @fieldloop
					break
				end
			else
				begin
					-- 존재 > 다음것 검사
					set @dummy = 0
				end
			set @fieldloop = @fieldloop + 1
			Fetch next from curAni into @fieldidx
		end

	if(@rtn = -1 and @fieldidx < 8)
		begin
			set @rtn = @fieldidx + 1
		end

	-- 4. 커서닫기
	close curAni
	Deallocate curAni

	RETURN @rtn
END
