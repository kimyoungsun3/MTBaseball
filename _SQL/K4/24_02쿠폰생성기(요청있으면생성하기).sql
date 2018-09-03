/*
use Game4FarmVill4
GO

-----------------------------------------------------
-- 5, 6, 7, 8차안 검색용 공용쿠폰
-- 결정(3015) 500개, 코인(3100) 50만, 무지방(3003)	777   		JAYO-FARM-VILL-FREE
--            500개,           100만, 바나나우유(3004) 777		JAYO-FARM-VILL-FUN2
--            500개,           200만, 크림치즈(3007) 777		JAYO-FARM-VILL-JAM2
--            500개,           400만, 카페라떼(3008) 777		JAYO-FARM-VILL-STRY

-- 4차안 1만원 리워드 100,000개
-- 우유결정(3015)			* 10,000개		-- 1

-- 3차안 1만원 리워드 300개
-- 우유결정(3015)			* 10,000개		-- 1

-- 2차안 테스트용.
-- 100개 코인, 유제품, 우유결정

-- select max(kind) from dbo.tFVEventCertNo
-- 1차안 [시럽에 배포] 1만원 리워드 10만개
-- 우유결정(3015)			* 10,000개		-- 1
-----------------------------------------------------
declare @noloop 	int,				@nomax 		int,
		@newid		uniqueidentifier,	@newid2		varchar(256),	@certno		varchar(16),
		@itemcode1	int,				@itemcode2	int,			@itemcode3	int,
		@cnt1		int,				@cnt2		int,			@cnt3		int,
		@kind		int

set @kind		= 4
set @nomax 		= 100000
set @itemcode1 	= 3015		set @cnt1	= 10000
set @itemcode2 	= -1		set @cnt2	= 0
set @itemcode3 	= -1		set @cnt3	= 0
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
				insert into dbo.tFVEventCertNo(certno,  itemcode1,  cnt1,  itemcode2,  cnt2,  itemcode3,  cnt3, kind)
				values(                       @certno, @itemcode1, @cnt1, @itemcode2, @cnt2, @itemcode3, @cnt3, @kind)

				set @noloop = @noloop + 1
			end
		else
			begin
				select '중복 > pass' + @certno
			end
	end

-- select 'insert into dbo.tFVEventCertNo(certno,  itemcode1,  cnt1,  itemcode2,  cnt2,  itemcode3,  cnt3, kind) values(''' + certno + ''',' + str(itemcode1) + ',  ' + str(cnt1) + ',  ' + str(itemcode2) + ',  ' + str(cnt2) + ',  ' + str(itemcode3) + ',  ' + str(cnt3) + ',  ' + str(kind) + ')' from dbo.tFVEventCertNo where kind = 3
-- select top 10 * from dbo.tFVEventCertNo order by idx desc
-- select * from dbo.tFVEventCertNo where certno = 'E750BFA1E4614653'
-- select count(certno) from dbo.tFVEventCertNo where kind = 3
-- select certno from dbo.tFVEventCertNo where kind = 3
-- select idx, certno, '<br>' from dbo.tFVEventCertNo where kind = 3
*/