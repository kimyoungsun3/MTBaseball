/*
use Farm
GO

-----------------------------------------------------
-- select max(kind) from dbo.tFVEventCertNo
-- 7차안 > 쿠팡, 컬쳐랜드, 해피머니, 한게임, 180여 매체에 유료쿠폰
-- 63수정(5001)						* 50000개		-- 7
--
-- 2차안
-- 50수정(5013)						* 5000개		-- 2
-- 60수정(5014), 시크한검은양(111)	* 10000개		-- 3
--
-- 1차안
-- 50수정(5013)						* 5000개		-- 1
-- 60수정(5014), 시크한검은양(111)	* 5000개		-- 1
-----------------------------------------------------
declare @noloop 	int,				@nomax 		int,
		@newid		uniqueidentifier,	@newid2		varchar(256),	@certno		varchar(16),
		@itemcode1	int,				@itemcode2	int,			@itemcode3	int,
		@kind		int

set @kind		= 7
set @nomax 		= 50000
set @itemcode1 	= 5001
set @itemcode2 	= -1
set @itemcode3 	= -1
set @noloop 	= 1



while(@noloop <= @nomax)
	begin
		if(@itemcode1 = -1 and @itemcode2 = -1 and @itemcode3 = -1)
			begin
				select ' > 쿠폰 선물이 없어 전체 패스합니다.'
				return
			end

		-- 인증번호 생성 > [-] 제거 > 16자리로(알아서 짤리네 ㅎㅎㅎ)
		SET @newid = NEWID()
		set @newid2 = replace(@newid, '-', '')
		SET @certno = @newid2
		--select @newid, @newid2, @certno
		--80D9B780-5F99-4AE9-A59C-08301077285F	80D9B7805F994AE9A59C08301077285F	80D9B7805F994AE9

		-- 인증번호 중복인가?
		if(not exists(select top 1 * from dbo.tFVEventCertNo where certno = @certno))
			begin
				insert into dbo.tFVEventCertNo(certno,  itemcode1,  itemcode2,  itemcode3,  kind)
				values(                     @certno, @itemcode1, @itemcode2, @itemcode3, @kind)
				set @noloop = @noloop + 1
			end
		else
			begin
				select '중복 > pass' + @certno
			end
	end

-- select 'insert into dbo.tFVEventCertNo(certno,  itemcode1,  itemcode2,  itemcode3, kind) values(''' + certno + ''',' + str(itemcode1) + ',  ' + str(itemcode2) + ',  ' + str(itemcode3) + ',  ' + str(kind) + ')' from dbo.tFVEventCertNo where kind = 4
-- select 'insert into dbo.tFVEventCertNo(certno,  itemcode1,  itemcode2,  itemcode3, kind) values(''' + certno + ''',' + str(itemcode1) + ',  ' + str(itemcode2) + ',  ' + str(itemcode3) + ',  ' + str(kind) + ')' from dbo.tFVEventCertNo where kind = 2
-- select 'insert into dbo.tFVEventCertNo(certno,  itemcode1,  itemcode2,  itemcode3, kind) values(''' + certno + ''',' + str(itemcode1) + ',  ' + str(itemcode2) + ',  ' + str(itemcode3) + ',  ' + str(kind) + ')' from dbo.tFVEventCertNo where kind = 3
-- select 'insert into dbo.tFVEventCertNo(certno,  itemcode1,  itemcode2,  itemcode3, kind) values(''' + certno + ''',' from dbo.tFVEventCertNo where kind = 2
-- select count(*) from dbo.tFVEventCertNo where itemcode1 = 5013
-- select * from dbo.tFVEventCertNo where itemcode1 = 5013
-- select count(*) from dbo.tFVEventCertNo where itemcode1 = 5014 and itemcode2 = 111
-- select * from dbo.tFVEventCertNo where itemcode1 = 5014 and itemcode2 = 111
-- select count(certno) from dbo.tFVEventCertNo
-- select top 10 * from dbo.tFVEventCertNo order by idx desc
-- select * from dbo.tFVEventCertNo where certno = 'E916FF4651494D75'
-- select certno from dbo.tFVEventCertNo where kind = 2
-- select certno from dbo.tFVEventCertNo where kind = 3
-- select certno from dbo.tFVEventCertNo where kind = 4
-- select certno from dbo.tFVEventCertNo where kind = 7
*/