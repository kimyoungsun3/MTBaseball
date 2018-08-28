/*
use Farm
GO

declare @gameid 			varchar(60)
declare @framelv 			int
declare @gamecost 			int
declare @plusgamecost		int
declare @orggamecost		int
declare @comment 			varchar(256)		set @comment	= ''

-- 1. 선언하기.
declare curRouletteRecover Cursor for
select gameid, framelv, gamecost
	from dbo.tFVRouletteLogPerson
where
	framelv >= 51
	and kind = 1
	and gamecost > 0
	and writedate >= '2014-09-19' and writedate <= '2014-09-22 10:37'

-- 2. 커서오픈
open curRouletteRecover

-- 3. 커서 사용
Fetch next from curRouletteRecover into @gameid, @framelv, @gamecost
while @@Fetch_status = 0
	Begin
		if(@gamecost = 4500)
			begin
				set @plusgamecost = 2000

				update dbo.tFVUserMaster
					set
						@orggamecost = gamecost,
						gamecost = gamecost + @plusgamecost
				where gameid = @gameid


				set @comment = '교배 오류 코인 복구 안내\n\n[기존 보유금액 ' + ltrim(str(@orggamecost)) + '만 코인\n + 교배 비용 보상 ' + ltrim(str(@plusgamecost)) + '만 코인 \n = 현재 보유 ' + ltrim(str(@orggamecost + @plusgamecost)) + '만 코인]\n *확인용 메세지입니다.'
				Exec Spu_Subgiftsend 1, -1, '코인복구', @gameid, @comment
				--select 'DEBUG ', @comment comment
			end
		else if(@gamecost = 7500)
			begin
				set @plusgamecost = 3500

				update dbo.tFVUserMaster
					set
						@orggamecost = gamecost,
						gamecost = gamecost + @plusgamecost
				where gameid = @gameid

				set @comment = '교배 오류 코인 복구 안내\n\n[기존 보유금액 ' + ltrim(str(@orggamecost)) + '만 코인\n + 교배 비용 보상 ' + ltrim(str(@plusgamecost)) + '만 코인 \n = 현재 보유 ' + ltrim(str(@orggamecost + @plusgamecost)) + '만 코인]\n *확인용 메세지입니다.'
				Exec Spu_Subgiftsend 1, -1, '코인복구', @gameid, @comment
				--select 'DEBUG ', @comment comment
			end
		else if(@gamecost = 10000)
			begin
				set @plusgamecost = 3500

				update dbo.tFVUserMaster
					set
						@orggamecost = gamecost,
						gamecost = gamecost + @plusgamecost
				where gameid = @gameid

				set @comment = '교배 오류 코인 복구 안내\n\n[기존 보유금액 ' + ltrim(str(@orggamecost)) + '만 코인\n + 교배 비용 보상 ' + ltrim(str(@plusgamecost)) + '만 코인 \n = 현재 보유 ' + ltrim(str(@orggamecost + @plusgamecost)) + '만 코인]\n *확인용 메세지입니다.'
				--select 'DEBUG ', @comment comment
				Exec Spu_Subgiftsend 1, -1, '코인복구', @gameid, @comment
			end
		else if(@gamecost = 13000)
			begin
				set @plusgamecost = 5000

				update dbo.tFVUserMaster
					set
						@orggamecost = gamecost,
						gamecost = gamecost + @plusgamecost
				where gameid = @gameid

				set @comment = '교배 오류 코인 복구 안내\n\n[기존 보유금액 ' + ltrim(str(@orggamecost)) + '만 코인\n + 교배 비용 보상 ' + ltrim(str(@plusgamecost)) + '만 코인 \n = 현재 보유 ' + ltrim(str(@orggamecost + @plusgamecost)) + '만 코인]\n *확인용 메세지입니다.'
				--select 'DEBUG ', @comment comment
				Exec Spu_Subgiftsend 1, -1, '코인복구', @gameid, @comment
			end
		else if(@gamecost = 16000)
			begin
				set @plusgamecost = 6000

				update dbo.tFVUserMaster
					set
						@orggamecost = gamecost,
						gamecost = gamecost + @plusgamecost
				where gameid = @gameid

				set @comment = '교배 오류 코인 복구 안내\n\n[기존 보유금액 ' + ltrim(str(@orggamecost)) + '만 코인\n + 교배 비용 보상 ' + ltrim(str(@plusgamecost)) + '만 코인 \n = 현재 보유 ' + ltrim(str(@orggamecost + @plusgamecost)) + '만 코인]\n *확인용 메세지입니다.'
				--select 'DEBUG ', @comment comment
				Exec Spu_Subgiftsend 1, -1, '코인복구', @gameid, @comment
			end

		Fetch next from curRouletteRecover into @gameid, @framelv, @gamecost
	end

-- 4. 커서닫기
close curRouletteRecover
Deallocate curRouletteRecover
*/


/*
-- 교배 테이블 정보 검사.
-- 51이상 일반교배
select idx, gameid, gamecost, *
	from dbo.tFVRouletteLogPerson
where
	framelv >= 51
	and kind = 1
	and gamecost > 0
	and writedate >= '2014-09-19' and writedate <= '2014-09-22 10:37'

-- 51 레벨 교배 	: 4500  -> 2500		-- 2000
-- 52~54 레벨 교배 	: 7500  -> 4000		-- 3500
-- 55~57 레벨 교배 	: 10000 -> 6500		-- 3500
-- 58~59 레벨 교배 	: 13000 -> 8000		-- 5000
-- 60 레벨 교배 	: 16000 -> 10000	-- 6000
*/



/*
declare @itemcode1 			int 			set @itemcode1 	= 5027
declare @itemcode2 			int 			set @itemcode2 	= 5026
declare @itemcode3 			int 			set @itemcode3 	= 5025
declare @gameid 			varchar(60)
declare @backschoolrank 	int
declare @backuserrank	 	int
declare @comment 			varchar(80)		set @comment	= '긴급패치보상'

-- 1. 선언하기.
declare curSchoolRand4Over Cursor for
select gameid, backschoolrank, backuserrank
	from dbo.tFVSchoolUser
where (backschoolrank >= 4 and backschoolrank <= 500)
	  and backuserrank <= 3
	  and backschoolidx != -1
	  and backuserrank != -1
	  and backdateid = '20140921'
order by backschoolrank asc, backuserrank asc

-- 2. 커서오픈
open curSchoolRand4Over

-- 3. 커서 사용
Fetch next from curSchoolRand4Over into @gameid, @backschoolrank, @backuserrank
while @@Fetch_status = 0
	Begin
		if(@backuserrank = 1)
			begin
				set @comment = '학교 ' + ltrim(str(@backschoolrank)) + '등 1위'
				--select 'DEBUG 1위', @comment comment
				exec spu_FVSubGiftSend 2,   @itemcode1, @comment, @gameid, ''
			end
		else if(@backuserrank = 2)
			begin
				set @comment = '학교 ' + ltrim(str(@backschoolrank)) + '등 2위'
				--select 'DEBUG 2위', @comment comment
				exec spu_FVSubGiftSend 2,   @itemcode2, @comment, @gameid, ''
			end
		else if(@backuserrank = 3)
			begin
				set @comment = '학교 ' + ltrim(str(@backschoolrank)) + '등 3위'
				--select 'DEBUG 3위', @comment comment
				exec spu_FVSubGiftSend 2,   @itemcode3, @comment, @gameid, ''
			end

		Fetch next from curSchoolRand4Over into @gameid, @backschoolrank, @backuserrank
	end

-- 4. 커서닫기
close curSchoolRand4Over
Deallocate curSchoolRand4Over
*/

/*
select max(idx) from dbo.tFVSchoolUser where

select top 10
	-- backdateid,
	-- backschoolidx,
	backschoolrank,
	backuserrank,
	-- , backpoint
	*
	from dbo.tFVSchoolUser
where (backschoolrank >= 4 and backschoolrank <= 500)
	  and backuserrank <= 3
	  and backschoolidx != -1
	  and backuserrank != -1
	  and backdateid = '20140921'
--order by backschoolrank asc, backuserrank asc
*/

--exec spu_FVUserCreate 'farm',   '1052234j7g4k0l225439', 5, 0, 1, 'ukukukuk', 120, '01026403070', '', 'COk87e086Qg', '91386767984635713', 'oCBksPCjIXxc1BMNzZhMAw==', '', -1, '', -1


/*
		select u.backschoolrank, rank() over (partition by u.backschoolrank order by u.backpoint desc) as userrank2, gameid, m.cnt, m.totalpoint
		from dbo.tFVSchoolUser u
			 JOIN
			 dbo.tFVSchoolMaster m
			 ON u.schoolidx = m.schoolidx
		where u.backschoolrank > 0 and u.backpoint > 0 order by u.backschoolrank asc

*/


/*

-- SKT 버젼별 경험치 확인.
update dbo.tFVUserMaster set fame = 49395 where gameid = 'xxxx2'
select fame from dbo.tFVUserMaster where gameid = 'xxxx2'
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 5, 113, '', '', -1, -1			-- 정상유저
select fame from dbo.tFVUserMaster where gameid = 'xxxx2'

update dbo.tFVUserMaster set fame = 49395 where gameid = 'xxxx2'
select fame from dbo.tFVUserMaster where gameid = 'xxxx2'
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 5, 114, '', '', -1, -1			-- 정상유저
select fame from dbo.tFVUserMaster where gameid = 'xxxx2'

-- GG 버젼별 경험치 확인.
update dbo.tFVUserMaster set fame = 49395 where gameid = 'xxxx2'
select fame from dbo.tFVUserMaster where gameid = 'xxxx2'
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 5, 119, '', '', -1, -1			-- 정상유저
select fame from dbo.tFVUserMaster where gameid = 'xxxx2'

update dbo.tFVUserMaster set fame = 49395 where gameid = 'xxxx2'
select fame from dbo.tFVUserMaster where gameid = 'xxxx2'
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 5, 120, '', '', -1, -1			-- 정상유저
select fame from dbo.tFVUserMaster where gameid = 'xxxx2'


-- NHN 버젼별 경험치 확인.
update dbo.tFVUserMaster set fame = 49395 where gameid = 'xxxx2'
select fame from dbo.tFVUserMaster where gameid = 'xxxx2'
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 6, 107, '', '', -1, -1			-- 정상유저
select fame from dbo.tFVUserMaster where gameid = 'xxxx2'

update dbo.tFVUserMaster set fame = 49395 where gameid = 'xxxx2'
select fame from dbo.tFVUserMaster where gameid = 'xxxx2'
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 6, 108, '', '', -1, -1			-- 정상유저
select fame from dbo.tFVUserMaster where gameid = 'xxxx2'



-- iPhone 버젼별 경험치 확인.
update dbo.tFVUserMaster set fame = 49395 where gameid = 'xxxx2'
select fame from dbo.tFVUserMaster where gameid = 'xxxx2'
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 7, 116, '', '', -1, -1			-- 정상유저
select fame from dbo.tFVUserMaster where gameid = 'xxxx2'

update dbo.tFVUserMaster set fame = 49395 where gameid = 'xxxx2'
select fame from dbo.tFVUserMaster where gameid = 'xxxx2'
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 7, 117, '', '', -1, -1			-- 정상유저
select fame from dbo.tFVUserMaster where gameid = 'xxxx2'


*/
/*
declare @farmidx		int,
		@gameid_		varchar(60)
set @gameid_ = 'farm939124667'	-- test pc

--delete from dbo.tFVUserFarm where gameid = @gameid_ and itemcode >= 6944
select @farmidx = max(farmidx) from dbo.tFVUserFarm where gameid = @gameid_
--select @farmidx farmidx

--insert into dbo.tFVUserFarm(farmidx, gameid, itemcode)
select (rank() over(order by itemcode asc) + @farmidx) as farmidx, @gameid_, itemcode from dbo.tFVItemInfo
where subcategory = 69
	and itemcode not in (select itemcode from dbo.tFVUserFarm where gameid = @gameid_)
order by itemcode asc
*/

/*
delete from dbo.tFVGiftList where gameid in ('xxxx2')
delete from dbo.tFVUserItem where gameid = 'xxxx2' and listidx >= 28
 update dbo.tFVUserMaster set cashcost = 900000000, gamecost = 9900000, heart = 9000000, randserial = -1, bgcomposewt = getdate() - 10 where gameid = 'xxxx2'
 insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 28, 23, 1, 0, -1, 1, 5)
 insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 29, 23, 1, 0, -1, 1, 5)
 insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 30, 23, 1, 0, -1, 1, 5)
 insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 31, 23, 1, 0, -1, 1, 5)
 insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 32, 23, 1, 0, -1, 1, 5)

 insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 128, 121, 1, 0, -1, 1, 5)
 insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 129, 121, 1, 0, -1, 1, 5)
 insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 130, 121, 1, 0, -1, 1, 5)
 insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 131, 121, 1, 0, -1, 1, 5)
 insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 132, 121, 1, 0, -1, 1, 5)

 insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 228, 221, 1, 0, -1, 1, 5)
 insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 229, 221, 1, 0, -1, 1, 5)
 insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 230, 221, 1, 0, -1, 1, 5)
 insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 231, 221, 1, 0, -1, 1, 5)
 insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 232, 221, 1, 0, -1, 1, 5)


exec spu_FVAniCompose 'xxxx2', '049000s1i0n7t8445289', 2, 101224, 28, 29, 30, 31, 32, 999992, -1
exec spu_FVAniCompose 'xxxx2', '049000s1i0n7t8445289', 2, 101225, 128, 129, 130, 131, 132, 999993, -1
exec spu_FVAniCompose 'xxxx2', '049000s1i0n7t8445289', 2, 101226, 228, 229, 230, 231, 232, 999994, -1


exec spu_FVAniCompose 'xxxx2', '049000s1i0n7t8445289', 2, 101227, 28, 29, 30, 31, 32, 999992, -1
exec spu_FVAniCompose 'xxxx2', '049000s1i0n7t8445289', 2, 101233, 128, 129, 130, 131, 132, 999993, -1
exec spu_FVAniCompose 'xxxx2', '049000s1i0n7t8445289', 2, 101239, 228, 229, 230, 231, 232, 999994, -1
*/

/*
---------------------------------------------
-- 뽑기이벤트 관리 내용.
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSystemRouletteMan', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSystemRouletteMan;
GO

create table dbo.tFVSystemRouletteMan(
	idx					int 				IDENTITY(1, 1),

	roulmarket			varchar(40)			default('1,2,3,4,5,6,7'),

	-- 특정동물 보상받기.
	roulflag			int					default(-1),
	roulstart			datetime			default('2014-01-01'),
	roulend				datetime			default('2024-01-01'),
	roulani1			int					default(-1),
	roulani2			int					default(-1),
	roulani3			int					default(-1),
	roulreward1			int					default(-1),
	roulreward2			int					default(-1),
	roulreward3			int					default(-1),
	roulname1			varchar(20)			default(''),
	roulname2			varchar(20)			default(''),
	roulname3			varchar(20)			default(''),

	-- 특정시간에 확률상승.
	roultimeflag		int					default(-1),
	roultimetime1		int					default(-1),
	roultimetime2		int					default(-1),
	roultimetime3		int					default(-1),

	-- 프리미엄 무료뽑기.
	pmgauageflag		int					default(-1),
	pmgauagepoint		int					default(100),
	pmgauagemax			int					default(10),

	--코멘트.
	comment				varchar(256)		default(''),
	writedate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSystemRouletteMan_idx	PRIMARY KEY(idx)
)
-- select top 1 * from dbo.tFVSystemRouletteMan where roulmarket like '%5%' order by idx desc
-- insert into dbo.tFVSystemRouletteMan(roulmarket, roulflag,    roulstart,      roulend, roulani1, roulani2, roulani3, roulreward1, roulreward2, roulreward3,       roulname1,     roulname2,       roulname3, roultimeflag, roultimestart,  roultimeend, roultimetime1, roultimetime2, roultimetime3, comment)
-- values                            ('1,2,3,4,5,6,7',   1, '2013-09-01', '2023-09-01',      213,      112,       14,        5017,        5010,        5009, '얼짱 산양보상', '얼짱 양보상', '얼짱 젖소보상',            1,  '2013-09-01', '2023-09-01',            12,            18,            23, '최초내용')
-- update dbo.tFVSystemRouletteMan set roulflag = -1 where idx = 3
*/


--alter table dbo.tFVUserMaster add 	pmgauage				int					default(0)
-- update dbo.tFVUserMaster set pmgauage = null where gameid = 'xxxx2'
-- select pmgauage, * from dbo.tFVUserMaster where gameid = 'xxxx2'

/*
declare @pmgauage int set @pmgauage = 1
if(isnull(@pmgauage, -999) = -999)
	begin
		select 'null'
	end
else
	begin
		select 'not null'
	end
*/

-- update dbo.tFVUserMaster set pmgauage	= 0

-- 폰을 바뀌니까 kakao userid 가 바뀜
-- insert into dbo.tFVKakaoMaster(kakaotalkid,   kakaouserid,                 gameid,   kakaodata, writedate)
-- values(						'AA9CtbVCDwA', '88197127983242480', 'farm144865577',   1,         '2014-05-10 21:53')
-- insert into dbo.tFVKakaoMaster(kakaotalkid,   kakaouserid,                 gameid,   kakaodata, writedate)
-- values(						'AA9CtbVCDwA', '88812274351815488', 'farm647401333',   1,         '2014-05-10 21:53')
-- update dbo.tFVKakaoMaster set  kakaotalkid = 'AA9CtbVCDwA', gameid = 'farm144865577' where kakaouserid = '88812274351815488'
-- select kakaouserid from dbo.tFVUserMaster where gameid = 'farm144865577'
-- update dbo.tFVUserMaster set kakaouserid = '88812274351815488' where gameid = 'farm144865577'



--alter table dbo.tFVUserSaleLog add milkproduct		int					default(0)


/*
update dbo.tFVItemInfo set param9 = 500 where subcategory = 60
--update dbo.tFVItemInfo set param9 = 600 where subcategory = 60 and itemcode >= 6007
--update dbo.tFVItemInfo set param9 = 700 where subcategory = 60 and itemcode >= 6008

select * from dbo.tFVItemInfo where subcategory = 60
*/
--insert into dbo.tFVKakaoMaster(kakaotalkid,   kakaouserid,                 gameid,   kakaodata, writedate)
--values(						'BqBAg4NAoAY', '89825532910935601', 'farm642535466', 1, '2014-07-18 22:52')

/*

------------------------------------------
-- 복귀 처음
-- xxxx2(나)
-- xxxxx(친구들)
------------------------------------------
delete from dbo.tFVGiftList where gameid in ('xxxx2', 'xxxx3', 'xxxx4', 'xxxx5', 'xxxx6')
-- 친구상태를 세팅
-- update dbo.tFVSystemInfo set rtnflag = 1
update dbo.tFVUserMaster set condate = getdate(),      rtndate = getdate(),       rtngameid = ''      where gameid = 'xxxx3'	-- 활동중.
update dbo.tFVUserMaster set condate = getdate() - 30, rtndate = getdate(),       rtngameid = ''      where gameid = 'xxxx4'	-- 이미요청.
update dbo.tFVUserMaster set condate = getdate() - 30, rtndate = getdate() - 0.5, rtngameid = 'xxxx2' where gameid = 'xxxx5'	-- 장기 > 만기.
update dbo.tFVUserMaster set condate = getdate() - 30, rtndate = getdate() - 2,   rtngameid = 'xxxx2' where gameid = 'xxxx6'	-- 장기 > 스스로.

--exec spu_FVLoginTest 'xxxx2', '049000s1i0n7t8445289', 1, 110, '', '', -1, -1			-- 정상유저
--exec spu_FVLoginTest 'xxxx3', '049000s1i0n7t8445289', 1, 110, '', '', -1, -1			-- 정상유저
--exec spu_FVLoginTest 'xxxx4', '049000s1i0n7t8445289', 1, 110, '', '', -1, -1			-- 정상유저
--exec spu_FVLoginTest 'xxxx5', '049000s1i0n7t8445289', 1, 110, '', '', -1, -1			-- 정상유저
--exec spu_FVLoginTest 'xxxx6', '049000s1i0n7t8445289', 1, 110, '', '', -1, -1			-- 정상유저


------------------------------------------
-- 진행중
------------------------------------------
update dbo.tFVUserMaster set attenddate = getdate() - 1, rtnstep = 1, rtnplaycnt = 1 where gameid = 'xxxx5'
exec spu_FVLoginTest 'xxxx5', '049000s1i0n7t8445289', 1, 110, '', '', -1, -1			-- 정상유저

update dbo.tFVUserMaster set attenddate = getdate() - 1, rtnstep = 1, rtnplaycnt = 5 where gameid = 'xxxx5'
exec spu_FVLoginTest 'xxxx5', '049000s1i0n7t8445289', 1, 110, '', '', -1, -1			-- 정상유저

update dbo.tFVUserMaster set attenddate = getdate() - 1, rtnstep = 14, rtnplaycnt = 4 where gameid = 'xxxx5'
exec spu_FVLoginTest 'xxxx5', '049000s1i0n7t8445289', 1, 110, '', '', -1, -1			-- 정상유저

update dbo.tFVUserMaster set attenddate = getdate() - 1, rtnstep = 14, rtnplaycnt = 5 where gameid = 'xxxx5'
exec spu_FVLoginTest 'xxxx5', '049000s1i0n7t8445289', 1, 110, '', '', -1, -1			-- 정상유저



*/


/*
alter table dbo.tFVDayLogInfoStatic add rtnrequest	int				default(0)
alter table dbo.tFVDayLogInfoStatic add rtnrejoin		int				default(0)

update dbo.tFVDayLogInfoStatic set rtnrequest	= 0, rtnrejoin = 0
*/

/*
alter table dbo.tFVSystemInfo add 	rtnflag				int					default(0)

update dbo.tFVSystemInfo set rtnflag	= 0
*/

/*
alter table dbo.tFVUserMaster add 	rtngameid	varchar(20)				default('')
alter table dbo.tFVUserMaster add 	rtndate		datetime				default(getdate() - 1)
alter table dbo.tFVUserMaster add 	rtnstep		int						default(-1)
alter table dbo.tFVUserMaster add 	rtnplaycnt	int						default(0)


declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tFVUserMaster
while(@idx > -1000)
	begin
		update dbo.tFVUserMaster
			set
				rtngameid	= '',
				rtndate		= getdate() - 1,
				rtnstep		= -1,
				rtnplaycnt	= 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/


-- 삭제된 유저 삭제하기.


/*
-- 푸쉬 로고 삭제하는 부분
	declare @idx 			int
	declare @idx2 			int


					set @idx = 0
					select @idx  = max(idx) from dbo.tFVUserPushiPhoneLog
					select @idx2 = min(idx) from dbo.tFVUserPushiPhoneLog
					while(@idx > @idx2)
						begin
							delete from dbo.tFVUserPushiPhoneLog
							where idx >= @idx - 1000 and idx <= @idx
							set @idx =  @idx - 1000
						end


					set @idx = 0
					select @idx  = max(idx) from dbo.tFVUserPushAndroidLog
					select @idx2 = min(idx) from dbo.tFVUserPushAndroidLog
					while(@idx > @idx2)
						begin
							delete from dbo.tFVUserPushAndroidLog
							where idx >= @idx - 1000 and idx <= @idx
							set @idx =  @idx - 1000
						end

select MAX(idx) - MIN(idx) from dbo.tFVUserPushiPhoneLog
select MAX(idx) - MIN(idx) from dbo.tFVUserPushAndroidLog
*/

/*
alter table dbo.tFVUserMaster add 	cashpoint	int						default(0)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tFVUserMaster
while(@idx > -1000)
	begin
		update dbo.tFVUserMaster
			set
				cashpoint	= 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/

/*
declare @cashpoint 	int
declare @gameid 	varchar(20)

-- 1. 선언하기.
declare curCashPoint Cursor for
-- update dbo.tFVUserMaster set cashpoint	= 0 where gameid = 'farm642687765'
-- select gameid, cash from dbo.tFVCashLog where gameid = 'farm642687765'
select gameid, cash from dbo.tFVCashLog

-- 2. 커서오픈
open curCashPoint

-- 3. 커서 사용
Fetch next from curCashPoint into @gameid, @cashpoint
while @@Fetch_status = 0
	Begin
		update dbo.tFVUserMaster
			set
				cashpoint = isnull(cashpoint, 0) + @cashpoint
		where gameid = @gameid

		Fetch next from curCashPoint into @gameid, @cashpoint
	end

-- 4. 커서닫기
close curCashPoint
Deallocate curCashPoint
*/


/*
alter table dbo.tFVSystemInfo add 	kakaoinvite01		int					default(2000)
alter table dbo.tFVSystemInfo add 	kakaoinvite02		int					default(1005)
alter table dbo.tFVSystemInfo add 	kakaoinvite03		int					default(6)
alter table dbo.tFVSystemInfo add 	kakaoinvite04		int					default(100003)


update dbo.tFVSystemInfo set kakaoinvite01 = 2000, kakaoinvite02 = 1005, kakaoinvite03 = 6, kakaoinvite04 = 100003
*/
/*
alter table dbo.tFVUserMaster add 	constate	int						default(0)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tFVUserMaster
while(@idx > -1000)
	begin
		update dbo.tFVUserMaster
			set
				constate	= 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/





/*
exec spu_FVFarmD 27, 12, -1, -1, -1, -1, -1, -1, -1, -1, '사과쪽지', '', 'Naver패치가 구글로 연결되었습니다. 다시 네이버에서 받아주세요.', '', '', '', '', '', '', ''	-- 메세지보내기
exec spu_FVFarmD 27, 12, -1, -1, -1, -1, -1, -1, -1, -1, '이용에 불편을 드려 죄송합니다.', 'farm635061189', 'Naver패치가 구글로 연결되었습니다. 다시 네이버에서 받아주세요.', '', '', '', '', '', '', ''	-- 메세지보내기
*/

/*
alter table dbo.tFVUserBeforeInfo add 	marketnew	int						default(1)

update dbo.tFVUserBeforeInfo set marketnew	= 5


exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 1, 110, '', '', -1, -1			-- 정상유저
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 5, 116, '', '', -1, -1			-- 정상유저
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 6, 102, '', '', -1, -1			-- 정상유저
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 7, 112, '', '', -1, -1			-- 정상유저


select * from dbo.tFVUserBeforeInfo
*/

/*
-- 이동 이력 기록( 경험치, 레벨, 마켓, 시간)

IF OBJECT_ID (N'dbo.tFVUserBeforeInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserBeforeInfo;
GO

create table dbo.tFVUserBeforeInfo(
	--(일반정보)
	idx			int 					IDENTITY(1, 1),
	gameid		varchar(20),
	market		int						default(1),				-- (구매처코드) MARKET_SKT
	version		int						default(101),			-- 클라버젼

	fame		int						default(0),
	famelv		int						default(1),
	famelvbest	int						default(1),
	gameyear	int						default(2013),
	gamemonth	int						default(3),
	changedate	datetime				default(getdate()),
	-- Constraint
	CONSTRAINT pk_tUserBeforeInfo_gameid	PRIMARY KEY(idx)
)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserBeforeInfo_gameid_idx')
	DROP INDEX tFVUserBeforeInfo.idx_tFVUserBeforeInfo_gameid_idx
GO
CREATE INDEX idx_tFVUserBeforeInfo_gameid_idx ON tUserBeforeInfo (gameid, idx)
GO
-- if(@market != @market_)
--	begin
--		insert into dbo.tFVUserBeforeInfo(gameid,  market,  version,  fame,  famelv,  gameyear,  gamemonth)
--		values(                        @gameid, @market, @version, @fame, @famelv, @gameyear, @gamemonth)
--	end
*/

/*
alter table dbo.tFVYabauLogPerson add 	remaingamecost		int					default(0)
alter table dbo.tFVYabauLogPerson add 	remaincashcost		int					default(0)

update dbo.tFVYabauLogPerson set remaingamecost	= 0, remaincashcost = 0
*/

/*
alter table dbo.tFVYabauLogPerson add 	yabaucount		int					default(0)

update dbo.tFVYabauLogPerson set yabaucount	= 0
*/



/*
---------------------------------------------
-- 	주사위 로그 > 개인자료
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVYabauLogPerson', N'U') IS NOT NULL
	DROP TABLE dbo.tFVYabauLogPerson;
GO

create table dbo.tFVYabauLogPerson(
	idx				int				identity(1, 1),

	gameid			varchar(20),
	itemcode		int				default(-1),
	kind			int				default(1),			-- 주사위의 모드가 들어감.
	framelv			int,

	yabaustep		int				default(-1),
	pack11			int				default(-1),
	pack21			int				default(-1),
	pack31			int				default(-1),
	pack41			int				default(-1),
	pack51			int				default(-1),
	pack61			int				default(-1),
	result			int				default(-1),
	cashcost		int				default(0),
	gamecost		int				default(0),
	yabauchange		int				default(0),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tYabauLogPerson_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVYabauLogPerson_gameid_idx')
	DROP INDEX tFVYabauLogPerson.idx_tFVYabauLogPerson_gameid_idx
GO
CREATE INDEX idx_tFVYabauLogPerson_gameid_idx ON tYabauLogPerson (gameid, idx)
GO
-- select top 100 * from dbo.tFVYabauLogPerson where gameid = 'xxxx2' order by idx desc
-- MODE_YABAU_RESET
-- insert into dbo.tFVYabauLogPerson(gameid, itemcode, kind, framelv, gamecost) values('xxxx2', 70002, 1, 20, 1700)
-- MODE_YABAU_REWARD
-- insert into dbo.tFVYabauLogPerson(gameid, itemcode, kind, framelv, pack11, pack21, pack31, pack41, pack51, pack61, yabaustep) values('xxxx2', 70002, 1, 20, 1, 1, 1, -1, -1, -1, 3)
-- MODE_YABAU_NORMAL, MODE_YABAU_PREMINUM
-- insert into dbo.tFVYabauLogPerson(gameid, itemcode, kind, framelv, pack11, pack21, pack31, pack41, pack51, pack61, result, cashcost, gamecost) values('xxxx2', 70002, 1, 20, 1, 1, 1, -1, -1, -1, 1, 1, 0)
*/





--select gameid, COUNT(*) from dbo.tFVGiftList where giftdate > '2014-07-26 16:00' and itemcode = 5108 group by gameid

/*
declare @itemcode int 			set @itemcode 	= 5108				-- 14000코인 x 3박스
declare @eventname varchar(20)	set @eventname	= '긴급패치보상'
declare @gameid varchar(60)

-- 1. 선언하기.
declare curENCheck Cursor for
--select gameid from dbo.tFVUserMaster where gameid = 'farm269756530'
select gameid from dbo.tFVUserMaster where famelv >= 50 and market in (5, 6) and condate >= '2014-07-26 16:00'

-- 2. 커서오픈
open curENCheck

-- 3. 커서 사용
Fetch next from curENCheck into @gameid
while @@Fetch_status = 0
	Begin
		if(exists(select top 1 * from dbo.tFVGiftList where gameid = @gameid and itemcode = @itemcode))
			begin
				select 'DEBUG 받아감'
			end
		else
			begin
				exec spu_FVSubGiftSend 2,   @itemcode, @eventname, @gameid, ''
				exec spu_FVSubGiftSend 2,   @itemcode, @eventname, @gameid, ''
				exec spu_FVSubGiftSend 2,   @itemcode, @eventname, @gameid, ''
			end

		Fetch next from curENCheck into @gameid
	end

-- 4. 커서닫기
close curENCheck
Deallocate curENCheck
*/

/*
declare @itemcode int 			set @itemcode 	= 5108				-- 14000코인 x 3박스
declare @eventname varchar(20)	set @eventname	= '긴급패치보상'
declare @gameid varchar(60)

-- 1. 선언하기.
declare curENCheck Cursor for
--select gameid from dbo.tFVUserMaster where gameid = 'xxxx2' and  famelv >= 50 and market in (5, 6) and condate >= '2014-07-25 18:50' -- and condate <= '2014-07-26 16:00'
select gameid from dbo.tFVUserMaster where famelv >= 50 and market in (5, 6) and condate >= '2014-07-25 18:50' -- and condate <= '2014-07-26 16:00'

-- 2. 커서오픈
open curENCheck

-- 3. 커서 사용
Fetch next from curENCheck into @gameid
while @@Fetch_status = 0
	Begin
		exec spu_FVSubGiftSend 2,   @itemcode, @eventname, @gameid, ''
		exec spu_FVSubGiftSend 2,   @itemcode, @eventname, @gameid, ''
		exec spu_FVSubGiftSend 2,   @itemcode, @eventname, @gameid, ''

		Fetch next from curENCheck into @gameid
	end

-- 4. 커서닫기
close curENCheck
Deallocate curENCheck
*/



/*
-- PTC_LOGIN > 구버젼 > 경험치 누적(51:3795)를 초과하면 3794로 세팅하기.
-- Google, Naver 신버젼
-- SKT, iPhone
-- 50렙 SKT, iPhone
select famelv, fame, * from dbo.tFVUserMaster where fame > 3795 and market in (1, 7)
-- update dbo.tFVUserMaster set fame = 3795 - 1 where fame > 3795 and market in (1, 7)
*/


/*
select famelv, fame, * from dbo.tFVUserMaster where gameid = 'farm599057333'
select famelv, fame, * from dbo.tFVUserMaster where fame > 5195 order by 2 desc
--update dbo.tFVUserMaster set famelv = 5120 where fame > 5195 and famelv >= 50
--50 3395	~ 3794
--51 3795	~ 4394
--52 4395	~ 5194
--53 5195	~ 6194
--54 6195	~ 7394
-- update dbo.tFVUserMaster set famelv = 51 where fame >= 3795 and fame <= 4394
-- update dbo.tFVUserMaster set famelv = 52 where fame >= 4395 and fame <= 5194
-- update dbo.tFVUserMaster set famelv = 53 where fame >= 5195 and fame <= 6194


select famelv, fame, * from dbo.tFVUserMaster where fame > 3795


-- 50렙
select famelv, fame, * from dbo.tFVUserMaster where fame > 3795
-- update dbo.tFVUserMaster set fame = 3795 - 1, famelv = 50 where fame > 3795


-- 50렙 SKT, iPhone
select famelv, fame, * from dbo.tFVUserMaster where fame > 3795 and market in (1, 7)
-- update dbo.tFVUserMaster set fame = 3795 - 1, famelv = 50 where fame > 3795 and market in (1, 7)

-- 52렙
select famelv, fame, * from dbo.tFVUserMaster where fame > 5195
select famelv, fame, * from dbo.tFVUserMaster where fame > 5195 and condate < '2014-07-26 1:00'
-- update dbo.tFVUserMaster set fame = 5195 - 1 where fame > 5195 and condate < '2014-07-26 09:00'
-- update dbo.tFVUserMaster set fame = 5195 - 1 where fame > 5195



-- 55렙
select famelv, fame, * from dbo.tFVUserMaster where fame > 7395
-- update dbo.tFVUserMaster set fame = 7395 - 1 where fame > 7395

select itemcode, gameid from dbo.tFVUserFarm where itemcode >= 6930 and buystate = 1 order by 1 desc
select distinct gameid from dbo.tFVUserFarm where itemcode >= 6930 and buystate = 1
select distinct gameid from dbo.tFVUserFarm where itemcode >= 6931 and buystate = 1
select distinct gameid from dbo.tFVUserFarm where itemcode >= 6932 and buystate = 1

--6933~6935까지 산 애들은 52로 강제 수정해도 무방합니다
select * from dbo.tFVUserFarm where itemcode >= 6933 and buystate = 1
select * from dbo.tFVUserFarm where itemcode = 6934 and buystate = 1
select * from dbo.tFVUserFarm where itemcode = 6935 and buystate = 1

-- 6939 이상의 목장 구매한 애들은 다시 봐야하구요
select * from dbo.tFVUserFarm where itemcode >= 6939 and buystate = 1

-- 6936~6938까지 산 애들이 있으면 걔네들은 55로 수정해 주시면 될거구요
select * from dbo.tFVUserFarm where itemcode >= 6936 and itemcode <= 6938 and buystate = 1


-- 50렙 미접속자 and '2014-07-25 18:50'
-- select famelv, fame, * from dbo.tFVUserMaster where famelv >= 61
select famelv, fame, * from dbo.tFVUserMaster where fame >= 3794 and condate < '2014-07-25 18:50'
-- update dbo.tFVUserMaster set fame = 3794 where fame >= 3794 and condate < '2014-07-25 18:50'


-- alter table dbo.tFVUserMaster add famebg			int					default(0)
--declare @loop int set @loop = 1000
--declare @loopmax int set @loopmax = 0
--select @loopmax = max(idx) from dbo.tFVUserMaster
--
--while(@loop < @loopmax)
--	begin
--		update dbo.tFVUserMaster set famebg = fame where idx >= @loop - 1000 and idx <= @loop
--		set @loop = @loop + 1000
--	end
*/


/*
update dbo.tFVUserMaster set famelvbest = 50 where famelvbest > 50
select count(*) from dbo.tFVUserMaster where famelvbest > 50
*/

/*
exec spu_FVSchoolRank  2, -1, ''


	declare @schoolname		varchar(128)
	declare @schoolidx		int						set @schoolidx		= -1
			select @schoolname = schoolname from dbo.tFVSchoolBank where schoolidx = @schoolidx

			select rank() over(order by point desc) userrank, @schoolname schoolname, * from dbo.tFVSchoolUser
			where schoolidx = @schoolidx and schoolidx != -1
			order by point desc
*/


/*
select 'exec spu_FVSubGiftSend 2,     ' + rtrim(str(itemcode)) + ', ''프리미엄'', @gameid, ''''' from dbo.tFVRouletteLogTotalSub
where dateid8 = '20140725'
order by premiumcnt desc, normalcnt desc

select 'exec spu_FVSubGiftSend 2,     ' + rtrim(str(itemcode)) + ', ''일반교배'', @gameid, ''''' from dbo.tFVRouletteLogTotalSub
where dateid8 = '20140725'
order by premiumcnt desc, normalcnt desc

declare @gameid varchar(60) set @gameid = 'farm621981767'
exec spu_FVSubGiftSend 2,              4, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            101, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,              5, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,              3, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            100, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,              2, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            102, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            200, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,              8, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            104, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            202, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            201, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,              7, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,              6, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            103, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            105, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            203, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,              9, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            106, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,              1, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            204, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,             10, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            107, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            205, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,             11, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            108, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            206, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            207, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,             12, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            109, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            208, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,             13, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            110, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,             14, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            111, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            209, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,             15, '일반교배', @gameid, ''

exec spu_FVSubGiftSend 2,             16, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            108, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            206, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,             11, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,             14, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            110, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            208, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            209, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            111, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,             13, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,             12, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,             15, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            109, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            207, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            113, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            112, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            115, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            211, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,             20, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            210, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,             21, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            212, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            114, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            119, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            215, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            120, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            213, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,             23, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            121, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            220, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            219, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            214, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            221, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            117, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,             17, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            217, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            107, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            104, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            100, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,              7, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,              8, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,              3, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,              6, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            101, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            103, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            200, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            201, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            202, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            203, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,            102, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,              4, '프리미엄', @gameid, ''

*/

/*
select         * from dbo.tFVUserYabauMonth
select         * from dbo.tFVUserYabauTotalSub

---------------------------------------------
-- 	구매했던 로그(월별 누적)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserYabauMonth', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserYabauMonth;
GO

create table dbo.tFVUserYabauMonth(
	idx				int				identity(1, 1),

	dateid6			char(6),							-- 201012
	itemcode		int,

	step1			int				default(0),
	step2			int				default(0),
	step3			int				default(0),
	step4			int				default(0),
	step5			int				default(0),
	step6			int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserYabauMonth_dateid6_itemcode	PRIMARY KEY(dateid6, itemcode)
)
-- select         * from dbo.tFVUserYabauMonth where dateid6 = '201407' and itemcode = 70008
-- insert into dbo.tFVUserYabauMonth(dateid6, itemcode) values('201407', 70008)
-- update dbo.tFVUserYabauMonth set step1 = step1 + 1 where dateid6 = '201407' and itemcode = 70008


---------------------------------------------
-- 	구매했던 로그(월별 Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserYabauTotalSub', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserYabauTotalSub;
GO

create table dbo.tFVUserYabauTotalSub(
	idx				int				identity(1, 1),

	dateid8			char(8),							-- 20101210
	itemcode		int,

	step1			int				default(0),
	step2			int				default(0),
	step3			int				default(0),
	step4			int				default(0),
	step5			int				default(0),
	step6			int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserYabauTotalSub_dateid8_itemcode	PRIMARY KEY(dateid8, itemcode)
)
-- select         * from dbo.tFVUserYabauTotalSub where dateid8 = '20140724' and itemcode = 70008
-- insert into dbo.tFVUserYabauTotalSub(dateid8, itemcode) values('20140724', 70008)
-- update dbo.tFVUserYabauTotalSub set step1 = step1 + 1 where dateid8 = '20140724' and itemcode = 70008
*/

/*
select 'exec spu_FVSubGiftSend 2,     ' + rtrim(str(itemcode)) + ', ''프리미엄'', @gameid, ''''' from dbo.tFVRouletteLogTotalSub
where dateid8 = '20140724'
order by premiumcnt desc, normalcnt desc

select 'exec spu_FVSubGiftSend 2,     ' + rtrim(str(itemcode)) + ', ''일반교배'', @gameid, ''''' from dbo.tFVRouletteLogTotalSub
where dateid8 = '20140724'
order by premiumcnt desc, normalcnt desc

declare @gameid varchar(60) set @gameid = 'farm939112937'
exec spu_FVSubGiftSend 2,              4, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            101, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,              5, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,              3, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            100, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,              2, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            102, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            200, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,              8, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            104, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            202, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            201, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,              7, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,              6, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            103, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            105, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            203, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,              9, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            106, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,              1, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            204, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,             10, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            107, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            205, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,             11, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            108, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            206, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            207, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,             12, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            109, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            208, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,             13, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            110, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,             14, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            111, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,            209, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,             15, '일반교배', @gameid, ''


*/

/*
select top 500 a.idx 'idx',
	dateid8,
	a.itemcode 'itemcode', b.itemname,
	a.gamecost 'gamecost', a.cashcost 'cashcost',
	a.cnt, y.pack11, y.pack21, y.pack31, y.pack41, y.pack51, y.pack61
from
		dbo.tFVUserItemBuyLogTotalSub a
	JOIN
		dbo.tFVItemInfo b
		ON a.itemcode = b.itemcode
	JOIN
		tSystemYabau y
		ON a.itemcode = y.itemcode
where subcategory = 700
and dateid8 in ('20140722', '20140723')
order by a.gamecost desc, a.cashcost desc


select * from dbo.tFVItemInfo where subcategory = 700
*/
/*
-- 이름변경
update dbo.tFVItemInfo set itemname = '얼음 냉기 젖소' where itemcode = 17
update dbo.tFVItemInfo set itemname = '분홍 젖소무늬 캡' where itemcode = 1429
update dbo.tFVItemInfo set itemname = '주사위교체' where itemcode = 80000
update dbo.tFVItemInfo set itemname = '합성하늘색 젖소' where itemcode = 101002
update dbo.tFVItemInfo set itemname = '합성노랑 젖소' where itemcode = 101003
update dbo.tFVItemInfo set itemname = '합성검은 소' where itemcode =101004
update dbo.tFVItemInfo set itemname = '합성분홍점박이 젖소' where itemcode =101005
update dbo.tFVItemInfo set itemname = '합성노랑점박이 젖소' where itemcode =101006
update dbo.tFVItemInfo set itemname = '합성파란꽃무늬 젖소' where itemcode =101007
update dbo.tFVItemInfo set itemname = '합성분홍꽃무늬 젖소' where itemcode =101008
update dbo.tFVItemInfo set itemname = '합성연보라 꽃무늬 젖소' where itemcode =101009
update dbo.tFVItemInfo set itemname = '합성빗살무늬 젖소' where itemcode =101010
update dbo.tFVItemInfo set itemname = '합성터프한 젖소' where itemcode =101011
update dbo.tFVItemInfo set itemname = '합성봉제 인형 소' where itemcode =101012
update dbo.tFVItemInfo set itemname = '합성세일러 젖소' where itemcode =101013
update dbo.tFVItemInfo set itemname = '합성얼짱 젖소' where itemcode =101014
update dbo.tFVItemInfo set itemname = '합성무법자 젖소' where itemcode =101015
update dbo.tFVItemInfo set itemname = '합성갈색 양' where itemcode =101101
update dbo.tFVItemInfo set itemname = '합성분홍 양' where itemcode =101102
update dbo.tFVItemInfo set itemname = '합성검은양' where itemcode =101103
update dbo.tFVItemInfo set itemname = '합성노란별무늬 양' where itemcode =101104
update dbo.tFVItemInfo set itemname = '합성파란별무늬 양' where itemcode =101105
update dbo.tFVItemInfo set itemname = '합성노랑 체크무늬 양' where itemcode =101106
update dbo.tFVItemInfo set itemname = '합성분홍 체크무늬 양' where itemcode =101107
update dbo.tFVItemInfo set itemname = '합성하늘색 체크무늬 양' where itemcode =101108
update dbo.tFVItemInfo set itemname = '합성봉제 인형 양' where itemcode =101109
update dbo.tFVItemInfo set itemname = '합성늑대가죽 양' where itemcode =101110
update dbo.tFVItemInfo set itemname = '합성시크한 검은 양' where itemcode =101111
update dbo.tFVItemInfo set itemname = '합성얼짱 양' where itemcode =101112
update dbo.tFVItemInfo set itemname = '합성뭉게뭉게 구름 양' where itemcode =101113
update dbo.tFVItemInfo set itemname = '합성황금뿔 양' where itemcode =101114
update dbo.tFVItemInfo set itemname = '합성갈색 산양' where itemcode =101201
update dbo.tFVItemInfo set itemname = '합성분홍 산양' where itemcode =101202
update dbo.tFVItemInfo set itemname = '합성검은 산양' where itemcode =101203
update dbo.tFVItemInfo set itemname = '합성하얀 점박이 산양' where itemcode =101204
update dbo.tFVItemInfo set itemname = '합성노랑 점박이 산양' where itemcode =101205
update dbo.tFVItemInfo set itemname = '합성하늘색 러블리 산양' where itemcode =101206
update dbo.tFVItemInfo set itemname = '합성분홍 러블리 산양' where itemcode =101207
update dbo.tFVItemInfo set itemname = '합성보라 러블리 산양' where itemcode =101208
update dbo.tFVItemInfo set itemname = '합성봉제 인형 산양' where itemcode =101209
update dbo.tFVItemInfo set itemname = '합성빵봉투 산양' where itemcode =101210
update dbo.tFVItemInfo set itemname = '합성팔랑팔랑 산양' where itemcode =101211
update dbo.tFVItemInfo set itemname = '합성루돌프 산양' where itemcode =101212
update dbo.tFVItemInfo set itemname = '합성얼짱 산양' where itemcode =101213
update dbo.tFVItemInfo set itemname = '합성조로 산양' where itemcode =101214

*/





/*
declare @gameid varchar(60) set @gameid = 'farm939102895'
exec spu_FVSubGiftSend 2,     4, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     101, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     5, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     2, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     100, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     3, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     102, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     200, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     104, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     202, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     8, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     7, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     201, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     6, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     203, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     103, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     105, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     9, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     106, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     1, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     204, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     10, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     107, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     205, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     108, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     11, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     206, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     207, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     109, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     12, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     208, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     13, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     14, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     110, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     15, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     111, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     209, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     210, '일반교배', @gameid, ''
exec spu_FVSubGiftSend 2,     112, '일반교배', @gameid, ''



exec spu_FVSubGiftSend 2,     115, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     211, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     113, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     20, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     14, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     108, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     209, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     16, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     15, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     11, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     206, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     111, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     110, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     12, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     208, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     13, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     109, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     207, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     114, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     21, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     212, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     112, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     210, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     215, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     119, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     23, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     213, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     120, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     219, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     121, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     220, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     221, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     214, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     217, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     17, '프리미엄', @gameid, ''
exec spu_FVSubGiftSend 2,     117, '프리미엄', @gameid, ''
*/


/*
exec spu_FVSubGiftSend 2,   712, 'SysLogin', 'xxxx2', ''
exec spu_FVSubGiftSend 2,   713, 'SysLogin', 'xxxx2', ''
exec spu_FVSubGiftSend 2,   714, 'SysLogin', 'xxxx2', ''
exec spu_FVSubGiftSend 2,   715, 'SysLogin', 'xxxx2', ''
exec spu_FVSubGiftSend 2,   716, 'SysLogin', 'xxxx2', ''


exec spu_FVSubGiftSend 2,   812, 'SysLogin', 'xxxx2', ''
exec spu_FVSubGiftSend 2,   813, 'SysLogin', 'xxxx2', ''
exec spu_FVSubGiftSend 2,   814, 'SysLogin', 'xxxx2', ''
exec spu_FVSubGiftSend 2,   815, 'SysLogin', 'xxxx2', ''
exec spu_FVSubGiftSend 2,   816, 'SysLogin', 'xxxx2', ''

exec spu_FVSubGiftSend 2,   1026, 'SysLogin', 'xxxx2', ''
exec spu_FVSubGiftSend 2,   1027, 'SysLogin', 'xxxx2', ''
exec spu_FVSubGiftSend 2,   1028, 'SysLogin', 'xxxx2', ''
exec spu_FVSubGiftSend 2,   1029, 'SysLogin', 'xxxx2', ''
exec spu_FVSubGiftSend 2,   1030, 'SysLogin', 'xxxx2', ''

exec spu_FVSubGiftSend 2,   1113, 'SysLogin', 'xxxx2', ''
exec spu_FVSubGiftSend 2,   1114, 'SysLogin', 'xxxx2', ''
exec spu_FVSubGiftSend 2,   1115, 'SysLogin', 'xxxx2', ''
exec spu_FVSubGiftSend 2,   1116, 'SysLogin', 'xxxx2', ''
exec spu_FVSubGiftSend 2,   1117, 'SysLogin', 'xxxx2', ''

declare @loop int set @loop = 57817038
declare @loopmax int set @loopmax = 57817042
while(@loop <= @loopmax)
	begin
		exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, @loop, -1, -1, -1, -1
		set @loop = @loop + 1
	end


-- 늑대용 공포탄 	: 701 < 712 ~ 716
-- 일반 치료제 		: 801 < 812 ~ 816
-- 농부				: 1001 < 1026 ~ 1030
-- 일반 촉진제		: 1102 < 1113 ~ 1117
*/


/*
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVSchoolUser_joindate')
    DROP INDEX tFVSchoolUser.idx_tFVSchoolUser_joindate
GO
CREATE INDEX idx_tFVSchoolUser_joindate ON tSchoolUser (joindate)
GO
*/
/*
-- 2주간 활동안한 유저는 학교 강제탈퇴.
declare @gameid 			varchar(60),
		@schoolidx			int,
		@joindate			datetime,
		@idx				int

set @joindate	= getdate() - 14

-- 1. 선언하기.
declare curSchoolNonActive Cursor for
select gameid, schoolidx from dbo.tFVSchoolUser where joindate < @joindate and schoolidx != -1 and point = 0

-- 2. 커서오픈
open curSchoolNonActive

-- 3. 커서 사용
Fetch next from curSchoolNonActive into @gameid, @schoolidx
while @@Fetch_status = 0
	Begin
		-- 학교 개인정보
		update dbo.tFVSchoolUser set schoolidx = -1 where gameid = @gameid

		-- 학교 마스터
		update dbo.tFVSchoolMaster set cnt = cnt - 1 where schoolidx = @schoolidx

		-- 유저 정보갱신
		update dbo.tFVUserMaster set schoolidx = -1 where gameid = @gameid

		Fetch next from curSchoolNonActive into @gameid, @schoolidx
	end

-- 4. 커서닫기
close curSchoolNonActive
Deallocate curSchoolNonActive
*/

/*
update dbo.tFVItemInfo set itemname = '공주병 젖소' where itemcode = 20
update dbo.tFVItemInfo set itemname = '주황색 공주병 젖소' where itemcode = 21
update dbo.tFVItemInfo set itemname = '보라색 공주병 젖소' where itemcode = 23
update dbo.tFVItemInfo set itemname = '쑥대머리 젖소' where itemcode = 24
update dbo.tFVItemInfo set itemname = '썬글라스 젖소' where itemcode = 25

update dbo.tFVItemInfo set itemname = '뭉게뭉게 구름 양' where itemcode = 113
update dbo.tFVItemInfo set itemname = '황금뿔 양' where itemcode = 114
update dbo.tFVItemInfo set itemname = '황금털 양' where itemcode = 115
update dbo.tFVItemInfo set itemname = '흑인 양' where itemcode = 116
update dbo.tFVItemInfo set itemname = '별빛털 양' where itemcode = 117
update dbo.tFVItemInfo set itemname = '솜사탕 양' where itemcode = 119
update dbo.tFVItemInfo set itemname = '분홍 솜사탕 양' where itemcode = 120
update dbo.tFVItemInfo set itemname = '보라 솜사탕 양' where itemcode = 121
update dbo.tFVItemInfo set itemname = '노란 머리띠 양' where itemcode = 122
update dbo.tFVItemInfo set itemname = '사탕 양' where itemcode = 123

update dbo.tFVItemInfo set itemname = '얼음뿔 산양' where itemcode = 215
update dbo.tFVItemInfo set itemname = '머플러핏산양' where itemcode = 216
update dbo.tFVItemInfo set itemname = '방울방울 산양' where itemcode = 217
update dbo.tFVItemInfo set itemname = '후드 산양' where itemcode = 219
update dbo.tFVItemInfo set itemname = '노란 후드 산양' where itemcode = 220
update dbo.tFVItemInfo set itemname = '파란 후드 산양' where itemcode = 221
update dbo.tFVItemInfo set itemname = '회색 갈기 산양' where itemcode = 222
update dbo.tFVItemInfo set itemname = '황금 산양' where itemcode = 223

update dbo.tFVItemInfo set param10 = '공주병 젖소 모음' where itemcode = 81820
update dbo.tFVItemInfo set param10 = '솜사탕 양 모음' where itemcode = 81821
update dbo.tFVItemInfo set param10 = '후드 산양 모음' where itemcode = 81822

update dbo.tFVItemInfo set itemname = '합성공주병 젖소' where itemcode = 101215
update dbo.tFVItemInfo set itemname = '합성주황색공주병 젖소' where itemcode = 101216
update dbo.tFVItemInfo set itemname = '합성보라색공주병 젖소' where itemcode = 101217
update dbo.tFVItemInfo set itemname = '합성솜사탕 양' where itemcode = 101218
update dbo.tFVItemInfo set itemname = '합성분홍솜사탕 양' where itemcode = 101219
update dbo.tFVItemInfo set itemname = '합성보라솜사탕 양' where itemcode = 101220
update dbo.tFVItemInfo set itemname = '합성후드 산양' where itemcode = 101221
update dbo.tFVItemInfo set itemname = '합성노란후드 산양' where itemcode = 101222
update dbo.tFVItemInfo set itemname = '합성파란후드 산양' where itemcode = 101223
*/


/*
alter table dbo.tFVUserMaster add 	yabaucount		int					default(0)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tFVUserMaster
while(@idx > -1000)
	begin
		update dbo.tFVUserMaster
			set
				yabaucount	= 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/

/*
declare @rand			int				set @rand			= 0
declare @needyabaunum	int				set @needyabaunum	= 5

select Convert(int, ceiling(RAND() * (12 - @needyabaunum + 1 )))
set @rand = Convert(int, ceiling(RAND() * (12 - @needyabaunum + 1 ))) + @needyabaunum -1

select @rand
*/

/*
48	3235	80
49	3315	80
50	3395	400
51	3795	600
52	4395	800
53	5195	1000
54	6195	1200
55	7395	1400
56	8795	1600
57	10395	1800
58	12195	2000
59	14195	2200
60	16395	2400
*/
/*
-- exec spu_FVFarmD 19, 65,  4,  1, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4,  9, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, 10, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, 11, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, 24, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, 25, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, 45, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, 1074, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, 1075, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, 1076, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, 1874, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, 1875, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, 1876, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도

-- exec spu_FVFarmD 19, 65,  4, 3394, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, 3395, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, 3396, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도

-- exec spu_FVFarmD 19, 65,  4, 3794, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, 3795, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, 3796, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, 8794, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, 8795, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, 8796, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, 16394, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, 16395, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, 16396, -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, , -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, , -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, , -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, , -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
-- exec spu_FVFarmD 19, 65,  4, , -1, -1, -1, -1, -1, -1, 'xxxx2', 'admin', '', '', '', '', '', '', '', ''			--      명성도
select fame, famelv from dbo.tFVUserMaster where gameid = 'xxxx2'

*/







/*
alter table dbo.tFVUserMaster add 	yabauresult		int					default(0)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tFVUserMaster
while(@idx > -1000)
	begin
		update dbo.tFVUserMaster
			set
				yabauresult	= 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/

/*
declare @loop int set @loop = 0
while(@loop < 100)
	begin
		select Convert(int, ceiling(RAND() * 11)) + 1
		set @loop = @loop + 1
	end
*/

/*
alter table dbo.tFVUserMaster add 	yabaunum		int					default(0)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tFVUserMaster
while(@idx > -1000)
	begin
		update dbo.tFVUserMaster
			set
				yabaunum	= 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/

/*
alter table dbo.tFVUserMaster add 	yabauidx		int					default(1)
alter table dbo.tFVUserMaster add 	yabaustep		int					default(0)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tFVUserMaster
while(@idx > -1000)
	begin
		update dbo.tFVUserMaster
			set
				yabauidx 	= 1,
				yabaustep	= 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/

/*
			select top 1 * from dbo.tFVSystemYabau
			where famelvmin <= @famelv
				and @famelv <= famelvmax
				and packstate = 1
				and packmarket like @strmarket
				order by newid()
*/

/*
--delete from dbo.tFVItemInfo where subcategory = 700 and itemcode >= 70001
--delete from dbo.tFVSystemYabau
--exec spu_FVFarmD 30, 45, -1    , '1', '10', '-1', '10', '1', '-1', '-1', '주사위1', '주사위1', '1:1:2:2:200;1:2:4:4:400;1:3:6:8:800;1:4:9:16:1600;1:5:10:32:3200;1:6:11:64:6400;1:7:11:128:12800;1:8:11:256:25600;', '', '', '', '', '', '', ''
--GO
--select * FROM dbo.fnu_SplitTwoStr(';', ':', '1:1:2:2:200;2:2:4:4:400;3:3:6:8:800;4:4:9:16:1600;5:5:10:32:3200;6:6:11:64:6400;7:7:11:128:12800;8:8:11:256:25600;')
--SELECT * FROM dbo.fnu_SplitOne(':', '2:4:4:400') where idx = 0
--SELECT * FROM dbo.fnu_SplitOne(':', '2:4:4:400')
declare @RESULT_SUCCESS						int				set @RESULT_SUCCESS						=  1
declare @p1_			int, @p2_		int, @p3_			int, @p4_			int, @p5_			int, @p6_			int, @p7_			int, @p8_			int, @p9_			int, @p10_			bigint,
		@ps1_			varchar(1024), @ps2_			varchar(1024), @ps3_			varchar(1024), @ps4_			varchar(1024), @ps5_			varchar(1024), @ps6_			varchar(1024), @ps7_			varchar(1024), @ps8_			varchar(1024), @ps9_			varchar(1024), @ps10_			varchar(4096)
	set @p2_ =45
	set @p4_ = 1
	set @p5_ = 10
	set @p7_ = 10
	set @p8_ = 1
	set @ps1_ = '주사위1'
	set @ps2_ = '주사위1'
	set @ps3_ = '1:1:2:2:200;1:2:4:4:400;1:3:6:8:800;1:4:9:16:1600;1:5:10:32:3200;1:6:11:64:6400;1:7:11:128:12800;1:8:11:256:25600;'
declare @packkind 		int
declare @itemcode 		int
declare @pack1			int,@pack2			int,@pack3			int,@pack4			int,@pack5			int,@pack6			int,@pack7			int,@pack8			int,@pack9			int,@pack10			int,@pack11			int,@pack12			int,@pack13			int,@pack14			int,@pack15			int,@pack16			int,@pack17			int,@pack18			int,@pack19			int,@pack20			int,@pack21			int,@pack22			int,@pack23			int,@pack24			int,@pack25			int,@pack26			int,@pack27			int,@pack28			int,@pack29			int,@pack30			int,@pack31			int,@pack32			int,@pack33			int,@pack34			int,@pack35			int,@pack36			int,@pack37			int,@pack38			int,@pack39			int,@pack40			int

declare @yabau			varchar(256)
declare @pack41			int, @pack42			int, @pack43			int, @pack44			int,
		@pack51			int, @pack52			int, @pack53			int, @pack54			int,
		@pack61			int, @pack62			int, @pack63			int, @pack64			int,
		@pack71			int, @pack72			int, @pack73			int, @pack74			int,
		@pack81			int, @pack82			int, @pack83			int, @pack84			int

			if(@p2_ = 45)
				begin
					-- 1. 커서 생성
					declare curYabauInsert Cursor for
					select * FROM dbo.fnu_SplitTwoStr(';', ':', @ps3_)

					-- 2. 커서오픈.
					open curYabauInsert

					-- 3. 커서 사용
					Fetch next from curYabauInsert into @packkind, @yabau
					while @@Fetch_status = 0
						Begin
							select 'DEBUG ', @packkind packkind, @yabau yabau
							if(@packkind = 1)
								begin
									select @pack11 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 0
									select @pack12 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 1
									select @pack13 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 2
									select @pack14 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 3
								end
							else if(@packkind = 2)
								begin
									select @pack21 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 0
									select @pack22 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 1
									select @pack23 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 2
									select @pack24 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 3
								end
							else if(@packkind = 3)
								begin
									select @pack31 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 0
									select @pack32 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 1
									select @pack33 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 2
									select @pack34 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 3
								end
							else if(@packkind = 4)
								begin
									select @pack41 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 0
									select @pack42 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 1
									select @pack43 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 2
									select @pack44 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 3
								end
							else if(@packkind = 5)
								begin
									select @pack51 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 0
									select @pack52 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 1
									select @pack53 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 2
									select @pack54 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 3
								end
							else if(@packkind = 6)
								begin
									select @pack61 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 0
									select @pack62 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 1
									select @pack63 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 2
									select @pack64 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 3
								end
							else if(@packkind = 7)
								begin
									select @pack71 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 0
									select @pack72 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 1
									select @pack73 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 2
									select @pack74 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 3
								end
							else if(@packkind = 8)
								begin
									select @pack81 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 0
									select @pack82 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 1
									select @pack83 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 2
									select @pack84 = listidx from dbo.fnu_SplitOne(':', @yabau) where idx = 3
								end
							Fetch next from curYabauInsert into @packkind, @yabau
						end

					-- 4. 커서닫기
					close curYabauInsert
					Deallocate curYabauInsert

					if(not exists(select top 1 * from dbo.tFVSystemYabau where packstr = @ps3_))
						begin
							select 'DEBUG 시스템 야바위추가.'
							-- 정보수집용 추가 > 아이템 테이블 추가하기.
							set @itemcode = 70000
							select @itemcode = max(itemcode) + 1 from dbo.tFVItemInfo where subcategory = 700

							if(not exists(select top 1 * from dbo.tFVItemInfo where itemcode = @itemcode))
								begin
									select 'DEBUG > 실제입력'

									insert into dbo.tFVItemInfo(labelname,     itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
									                   values('staticinfo', @itemcode, '700',    '700',       '0',      @ps1_,    '0',      '0',     '0',   '0',      '16', '0',      '0',     '0',      '0',      '0',       '0',      @ps2_)

									insert into dbo.tFVSystemYabau(itemcode, famelvmin, famelvmax, saleper, packstate, packname,  comment, packstr, pack11, pack12, pack13, pack14, pack21, pack22, pack23, pack24, pack31, pack32, pack33, pack34, pack41, pack42, pack43, pack44, pack51, pack52, pack53, pack54, pack61, pack62, pack63, pack64, pack71, pack72, pack73, pack74, pack81, pack82, pack83, pack84)
									values(                     @itemcode, @p4_,      @p5_,      @p7_,    @p8_,      @ps1_,     @ps2_,   @ps3_,  @pack11,@pack12,@pack13,@pack14,@pack21,@pack22,@pack23,@pack24,@pack31,@pack32,@pack33,@pack34,@pack41,@pack42,@pack43,@pack44,@pack51,@pack52,@pack53,@pack54,@pack61,@pack62,@pack63,@pack64,@pack71,@pack72,@pack73,@pack74,@pack81,@pack82,@pack83,@pack84)

								end
						end

					select @RESULT_SUCCESS 'rtn'
				end

*/



/*
-- guest가입 (강제로 5만건 입력하기 )
declare @var 			int
declare @loop			int				set @loop	= 1
declare @gameid 		varchar(60)		set @gameid = 'farm'	-- guest, farm, iuest
declare @phone 			varchar(20)
select @var = max(idx) + 1 from dbo.tFVUserMaster
set @loop = @var + @loop
while @var < @loop
	begin
		set @phone			= '010' + ltrim(@var)
		exec dbo.spu_FVUserCreate
							@gameid,					-- gameid
							'5828478z2e6t0p422634',		-- password
							5,							-- market
							0,							-- buytype
							1,							-- platform
							'xxxxx',					-- ukey
							111,						-- version
							'01054794759',				-- phone
							'9171fcef9af92fc38f4bd19d79275b73970ffc44112e239260846201b7197c1e',							-- pushid
							'ACfWUFDWJwA',				-- kakaotalkid (없으면 임으로 생성해줌)
							'88282212134918145',		-- kakaouserid (없으면 임으로 생성해줌)
							'VXVB9u3kws6y2l1nF9qDIg==',	-- kakaonickname
							'X1O+2tQVVBqen7Rw61tqzjRMS7Ck1OLSozeclo8Z5i7YABa1SpCELWm9lS6HZCChOEeLU3yp9qtTtVLoazcars/uy1zyJFQI/oLWmSdIt6M2pKKyBtqIFxQrqlJWNJLb',	-- kakaoprofile
							-1,							-- kakaomsgblocked
							'',							-- kakaofriendlist(kakaouserid)
							-1
		set @var = @var + 1
	end


select * from dbo.tFVKakaoMaster where gameid = 'farm325033748'
select * from dbo.tFVUserMaster where gameid = 'farm325033748'
--select top 1 * from dbo.tFVKakaoMaster where kakaouserid = '88282212134918145'
--insert into dbo.tFVUserPhone(phone, market, joincnt) values('01054794759', 6, 1)
--update dbo.tFVUserMaster set phone = '01054794759' where gameid = 'farm325033748'
*/

/*
--select '시', DATEpart(Hour, GETDATE())

declare @date datetime
set @date = '2014-07-10 00:12'
select @date, DATEpart(Hour, @date)
set @date = '2014-07-10 09:12'
select @date, DATEpart(Hour, @date)
set @date = '2014-07-10 10:12'
select @date, DATEpart(Hour, @date)
set @date = '2014-07-10 12:12'
select @date, DATEpart(Hour, @date)
set @date = '2014-07-10 19:12'
select @date, DATEpart(Hour, @date)
set @date = '2014-07-10 23:12'
select @date, DATEpart(Hour, @date)
set @date = '2014-07-10 24:12'
select @date, DATEpart(Hour, @date)
*/

/*
declare @gameid varchar(60) set @gameid = 'farm939085910'
exec spu_FVSubGiftSend 2,     17, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,     20, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,     21, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,     23, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,     117, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,     119, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,     120, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,     121, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,     217, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,     219, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,     220, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,     221, 'SysLogin', @gameid, ''



declare @gameid varchar(60) set @gameid = 'farm939087130'
exec spu_FVSubGiftSend 2,     17, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,     20, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,     21, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,     23, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,     117, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,     119, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,     120, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,     121, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,     217, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,     219, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,     220, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,     221, 'SysLogin', @gameid, ''
*/

/*
alter table dbo.tFVUserSaleLog add 	cashcost	int						default(0)
alter table dbo.tFVUserSaleLog add 	gamecost	int						default(0)
alter table dbo.tFVUserSaleLog add 	feed		int						default(0)
alter table dbo.tFVUserSaleLog add 	fpoint		int						default(0)
alter table dbo.tFVUserSaleLog add 	heart		int						default(0)
*/

/*
alter table dbo.tFVUserMaster add 	trade0		tinyint					default(0)
alter table dbo.tFVUserMaster add 	trade1		tinyint					default(1)
alter table dbo.tFVUserMaster add 	trade2		tinyint					default(2)
alter table dbo.tFVUserMaster add 	trade3		tinyint					default(3)
alter table dbo.tFVUserMaster add 	trade4		tinyint					default(4)
alter table dbo.tFVUserMaster add 	trade5		tinyint					default(5)
alter table dbo.tFVUserMaster add 	trade6		tinyint					default(6)
alter table dbo.tFVUserMaster add 	tradedummy	tinyint					default(0)



-- select max(idx) from dbo.tFVUserMaster
declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tFVUserMaster
while(@idx > -1000)
	begin
		update dbo.tFVUserMaster
			set
				trade0 	= 0,	--7
				trade1 	= 1,	--8
				trade2 	= 2,	--9
				trade3 	= 3,	--10
				trade4 	= 4,	--11
				trade5 	= 5,	--12
				trade6 	= 6,	--13
				tradedummy = 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/



--select * from dbo.tFVItemInfo where subcategory = 69 and itemcode >= 6930
--update dbo.tFVItemInfo set param3 = 5000 where subcategory = 69 and itemcode >= 6930

/*
-- delete from dbo.tFVUserFarm where gameid = 'xxxx3' and itemcode >= 6930
declare @ITEM_SUBCATEGORY_USERFARM			int					set @ITEM_SUBCATEGORY_USERFARM	 			= 69	-- 전국목장
declare @gameid_ 				varchar(20)	set @gameid_ = 'xxxx3'
declare @farmidx				int				set @farmidx					= 0

--select * from dbo.tFVUserFarm where gameid = @gameid_

if(not exists(select top 1 * from dbo.tFVUserFarm where gameid = @gameid_ and itemcode = 6952))
	begin
		select @farmidx = max(farmidx) from dbo.tFVUserFarm where gameid = @gameid_

		insert into dbo.tFVUserFarm(farmidx, gameid, itemcode)
		select (rank() over(order by itemcode asc) + @farmidx) as farmidx, @gameid_, itemcode from dbo.tFVItemInfo
		where subcategory = @ITEM_SUBCATEGORY_USERFARM
			and itemcode not in (select itemcode from dbo.tFVUserFarm where gameid = @gameid_)
		order by itemcode asc
	end
--select * from dbo.tFVUserFarm where gameid = @gameid_
*/
--select * from dbo.tFVUserMaster where gamemonth > 12
--select top 10  bgcomposecnt, bgroulcnt, pmroulcnt, bgtradecnt  from dbo.tFVUserMaster
/*
select gameid, housestep, tankstep, bottlestep, pumpstep, transferstep, purestep, freshcoolstep from dbo.tFVUserMaster
where condate >= '2014-07-04 15:00' --and condate <= '2014-07-04 15:00'
and (
housestep <= 3
or tankstep < 6
or bottlestep < 6
or pumpstep < 6
or transferstep < 6
or purestep < 6
or freshcoolstep < 6
)
*/

/*
alter table dbo.tFVDogamList add 	cnt				int				default(0)

-- select max(idx) from dbo.tFVDogamList
declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tFVDogamList
while(@idx > -1000)
	begin
		update dbo.tFVDogamList
			set
				cnt 	= 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/


/*
-- bgroulcnt 	일반 교배 횟수(위에것).
-- pmroulcnt 	프리미엄 교배 횟수(위에것).
alter table dbo.tFVUserMaster add 	bgtradecnt		int					default(0)
alter table dbo.tFVUserMaster add 	bgcomposecnt 	int					default(0)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tFVUserMaster
while(@idx > -1000)
	begin
		update dbo.tFVUserMaster
			set
				bgtradecnt 		= 0,
				bgcomposecnt 	= 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/

/*
select param15, * from dbo.tFVItemInfo where subcategory = 1010
update dbo.tFVItemInfo set param15 = 0 where subcategory = 1010
update dbo.tFVItemInfo set param15 = 1 where subcategory = 1010 and itemcode >= 101005
*/

/*
insert into dbo.tFVNotice(market, buytype, comfile, comurl, comfile2, comurl2, comfile3, comurl3, comment, version, patchurl, recurl, smsurl, smscom, writedate, syscheck, iteminfover, iteminfourl, comfile4, comurl4, comfile5, comurl5)
select 6, buytype, comfile, comurl, comfile2, comurl2, comfile3, comurl3, comment, version, patchurl, recurl, smsurl, smscom, writedate, syscheck, iteminfover, iteminfourl, comfile4, comurl4, comfile5, comurl5 from dbo.tFVNotice where market = 5
*/

/*
select * from dbo.tFVDayLogInfoStatic
group by dateid8
order by dateid8 desc, market asc, idx desc

select dateid8, SUM(joinguestcnt) from dbo.tFVDayLogInfoStatic
group by dateid8
order by 2 desc

select dateid8, SUM(joinguestcnt) from dbo.tFVDayLogInfoStatic
where dateid8
order by 2 desc


select SUM(joinguestcnt)/COUNT(*) from dbo.tFVDayLogInfoStatic
where dateid8 like '201405%' or dateid8 like '201406%'


declare @attenddate datetime set @attenddate = getdate()
select COUNT(*) from dbo.tFVUserMaster where attenddate >= (@attenddate - 2)
select COUNT(*) from dbo.tFVUserMaster where attenddate >= (@attenddate - 7)
*/

/*
update dbo.tFVUserMaster set gamecost = 100000, cashcost = 100000 where gameid = 'xxxx7'

select gamecost, cashcost from dbo.tFVUserMaster where gameid = 'xxxx7'
exec spu_FVItemBuy 'xxxx7', '049000s1i0n7t8445289', 1600, 1, -1, -1, -1, 7780, -1	-- 시간초기화템
select gamecost, cashcost from dbo.tFVUserMaster where gameid = 'xxxx7'
exec spu_FVItemBuy 'xxxx7', '049000s1i0n7t8445289', 1601, 1, -1, -1, -1, 7781, -1	-- 시간초기화템
select gamecost, cashcost from dbo.tFVUserMaster where gameid = 'xxxx7'
*/

/*
--insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 40, 2301, 2, 0, -1, 3, 5)
--insert into dbo.tFVUserItem(gameid, listidx, itemcode, cnt, farmnum,  fieldidx,  invenkind, gethow) values('xxxx2', 41, 2307, 99, 0, -1, 3, 5)

declare @DEFINE_HOW_GET_GIFT				int					set @DEFINE_HOW_GET_GIFT					= 5	--검색
declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
declare @gameid			varchar(60)
declare @cnt			int
declare @listidx		int
declare @listidxnew		int
declare @itemcodemaster	int				set @itemcodemaster		= 2300
declare @itemcodemin	int				set @itemcodemin		= 2301
declare @itemcodemax	int				set @itemcodemax		= 2307

-- 1. 커서 생성
declare curTicket Cursor for
select gameid, listidx, cnt from dbo.tFVUserItem where itemcode >= @itemcodemin and itemcode <= @itemcodemax and cnt > 0 and invenkind = @USERITEM_INVENKIND_CONSUME
--and gameid = 'xxxx2'

-- 2. 커서오픈
open curTicket

-- 3. 커서 사용
Fetch next from curTicket into @gameid, @listidx, @cnt
while @@Fetch_status = 0
	Begin
		--select 'DEBUG ', @gameid gameid, @listidx listidx, @cnt cnt
		if(exists(select top 1 * from dbo.tFVUserItem where gameid = @gameid and itemcode = @itemcodemaster))
			begin
				--select 'DEBUG ', '존재 > +cnt, 기존것 0'
				update dbo.tFVUserItem
					set
						cnt = cnt + @cnt
				where gameid = @gameid and itemcode = @itemcodemaster
			end
		else
			begin
				--select 'DEBUG ', '새것 입력, 기존것 0'
				select @listidxnew = isnull(MAX(listidx), 0) + 1 from dbo.tFVUserItem where gameid = @gameid
				insert into dbo.tFVUserItem(gameid,      listidx,  itemcode,        cnt,  invenkind, gethow)
				values(					 @gameid,  @listidxnew, @itemcodemaster,       @cnt,  @USERITEM_INVENKIND_CONSUME, @DEFINE_HOW_GET_GIFT)
			end

		update dbo.tFVUserItem
			set
				cnt = 0
		where gameid = @gameid and listidx = @listidx

		Fetch next from curTicket into @gameid, @listidx, @cnt
	end

-- 4. 커서닫기
close curTicket
Deallocate curTicket
*/


/*
- SKT 이벤트 아이템 일괄지급
6/22 부토 T스토어 단독 이벤트가 종료되었습니다.
- 기준일 : 6/9 ~ 6/22 23:59
- 지급일 : 6/23 ~6/24 * 늦어도 6/24 오전까지 지급처리를 완료 부탁드리겠습니다.
1) 이벤트 기간동안 짜요 목장 이야기 for Kakao를 다운받은 신규 T스토어 유저
	-> 수정 100개 + 부활석 20개 + 긴급요청 티켓 20개 지급
2) 이벤트 기간동안 발생된 누적 결제금액에 대해 보너스 수정 지급
	-> 5000원 이상 	: 보너스 수정 3개
	-> 10000원 이상 	: 보너스 수정 5개
	-> 30000원 이상 	: 보너스 수정 25개
	-> 100000원 이상 	: 보너스 수정 110개
	-> 300000원 이상 	: 보너스 수정 490개
	-> 500000원 이상 	: 보너스 수정 1,090개
	-> 1000000원 이상 	: 보너스 수정 2,720개
*/
/*
declare @MARKET_SKT		int				set @MARKET_SKT		= 1
declare @startdate		varchar(20)		set @startdate		= '2014-06-09 00:00'
declare @enddate		varchar(20)		set @enddate		= '2014-06-22 23:59'
declare @gameid			varchar(60)
declare @phone			varchar(20)
declare @cash			int
-- select * from dbo.tFVUserPhone where phone in (select phone from dbo.tFVUserMaster where market = @MARKET_SKT and regdate >= @startdate and regdate <= @enddate)
--									  and market = @MARKET_SKT and writedate >= @startdate and writedate <= @enddate

-- 1. 커서 생성
declare curSKTJoin Cursor for
select gameid, phone from dbo.tFVUserMaster where market = @MARKET_SKT and regdate >= @startdate and regdate <= @enddate

-- 2. 커서오픈
open curSKTJoin

-- 3. 커서 사용
Fetch next from curSKTJoin into @gameid, @phone
while @@Fetch_status = 0
	Begin
		if(exists(select top 1 * from dbo.tFVUserPhone where phone = @phone and market = @MARKET_SKT and writedate >= @startdate and writedate <= @enddate))
			begin
				-----------------------------------------------------------------------------
				-- 이벤트 기간동안 짜요 목장 이야기 for Kakao를 다운받은 신규 T스토어 유저
				--> 수정 100개(5018) + 부활석 20개(1206) + 긴급요청 티켓 20개(2106) 지급
				--exec spu_FVSubGiftSend 2, 5018, 'SKT신규보상', 'xxxx2', ''
				--exec spu_FVSubGiftSend 2, 1206, 'SKT신규보상', 'xxxx2', ''
				--exec spu_FVSubGiftSend 2, 2106, 'SKT신규보상', 'xxxx2', ''
				-----------------------------------------------------------------------------
				exec spu_FVSubGiftSend 2, 5018, 'SKT신규보상', @gameid, ''
				exec spu_FVSubGiftSend 2, 1206, 'SKT신규보상', @gameid, ''
				exec spu_FVSubGiftSend 2, 2106, 'SKT신규보상', @gameid, ''
			end
		Fetch next from curSKTJoin into @gameid, @phone
	end

-- 4. 커서닫기
close curSKTJoin
Deallocate curSKTJoin
*/
/*
declare @MARKET_SKT		int				set @MARKET_SKT		= 1
declare @startdate		varchar(20)		set @startdate		= '2014-06-09 00:00'
declare @enddate		varchar(20)		set @enddate		= '2014-06-22 23:59'
declare @gameid			varchar(60)
declare @phone			varchar(20)
declare @comment		varchar(256)
declare @cash			int
declare @cashcost		int
declare @cashcostorg	int
declare @plus			int
--select gameid, SUM(cash) from dbo.tFVCashLog where market = @MARKET_SKT and writedate >= @startdate and writedate <= @enddate group by gameid having SUM(cash) >= 5000 order by 2 desc

-- 1. 커서 생성
declare curSKTCash Cursor for
select gameid, SUM(cash) from dbo.tFVCashLog where market = @MARKET_SKT and writedate >= @startdate and writedate <= @enddate group by gameid having SUM(cash) >= 5000 order by 2 desc
--select gameid, 500000 cash from dbo.tFVUserMaster where gameid = 'xxxx2'

-- 2. 커서오픈
open curSKTCash

-- 3. 커서 사용
Fetch next from curSKTCash into @gameid, @cash
while @@Fetch_status = 0
	Begin
		-----------------------------------------------------------------------------
		-- 이벤트 기간동안 발생된 누적 결제금액에 대해 보너스 수정 지급
		-- Exec Spu_Subgiftsend 1, -1, 'SKT결제보너스', 'xxxx2', '1000원 이상 결제로 추가 수정 10개를 지급합니다.(직접반영)'
		-----------------------------------------------------------------------------
		-- 수정 추가, 쪽지기록.
		select @cashcostorg = cashcost from dbo.tFVUserMaster where gameid = @gameid
		if(@cash >= 1000000)
			begin
				set @plus 		= 2720
				set @cashcost	= @cashcostorg + @plus
				set @comment	= '1,000,000원 이상 결제로 추가 수정 '+ltrim(rtrim(str(@plus)))+'개를 지급합니다.('+ltrim(rtrim(str(@cashcostorg)))+'수정에서 '+ltrim(rtrim(str(@cashcost)))+'으로 증가)'
				update dbo.tFVUserMaster set cashcost = cashcost + @plus where gameid = @gameid
				Exec Spu_Subgiftsend 1, -1, 'SKT결제보너스', @gameid, @comment
			end
		else if(@cash >= 500000)
			begin
				set @plus		= 1090
				set @cashcost	= @cashcostorg + @plus
				set @comment	= '500,000원 이상 결제로 추가 수정 '+ltrim(rtrim(str(@plus)))+'개를 지급합니다.('+ltrim(rtrim(str(@cashcostorg)))+'수정에서 '+ltrim(rtrim(str(@cashcost)))+'으로 증가)'
				update dbo.tFVUserMaster set cashcost = cashcost + @plus where gameid = @gameid
				Exec Spu_Subgiftsend 1, -1, 'SKT결제보너스', @gameid, @comment
			end
		else if(@cash >= 300000)
			begin
				set @plus		= 490
				set @cashcost	= @cashcostorg + @plus
				set @comment	= '300,000원 이상 결제로 추가 수정 '+ltrim(rtrim(str(@plus)))+'개를 지급합니다.('+ltrim(rtrim(str(@cashcostorg)))+'수정에서 '+ltrim(rtrim(str(@cashcost)))+'으로 증가)'
				update dbo.tFVUserMaster set cashcost = cashcost + @plus where gameid = @gameid
				Exec Spu_Subgiftsend 1, -1, 'SKT결제보너스', @gameid, @comment
			end
		else if(@cash >= 100000)
			begin
				set @plus		= 110
				set @cashcost	= @cashcostorg + @plus
				set @comment	= '100,000원 이상 결제로 추가 수정 '+ltrim(rtrim(str(@plus)))+'개를 지급합니다.('+ltrim(rtrim(str(@cashcostorg)))+'수정에서 '+ltrim(rtrim(str(@cashcost)))+'으로 증가)'
				update dbo.tFVUserMaster set cashcost = cashcost + @plus where gameid = @gameid
				Exec Spu_Subgiftsend 1, -1, 'SKT결제보너스', @gameid, @comment
			end
		else if(@cash >= 30000)
			begin
				set @plus		= 25
				set @cashcost	= @cashcostorg + @plus
				set @comment	= '30,000원 이상 결제로 추가 수정 '+ltrim(rtrim(str(@plus)))+'개를 지급합니다.('+ltrim(rtrim(str(@cashcostorg)))+'수정에서 '+ltrim(rtrim(str(@cashcost)))+'으로 증가)'
				update dbo.tFVUserMaster set cashcost = cashcost + @plus where gameid = @gameid
				Exec Spu_Subgiftsend 1, -1, 'SKT결제보너스', @gameid, @comment
			end
		else if(@cash >= 10000)
			begin
				set @plus		= 5
				set @cashcost	= @cashcostorg + @plus
				set @comment	= '10,000원 이상 결제로 추가 수정 '+ltrim(rtrim(str(@plus)))+'개를 지급합니다.('+ltrim(rtrim(str(@cashcostorg)))+'수정에서 '+ltrim(rtrim(str(@cashcost)))+'으로 증가)'
				update dbo.tFVUserMaster set cashcost = cashcost + @plus where gameid = @gameid
				Exec Spu_Subgiftsend 1, -1, 'SKT결제보너스', @gameid, @comment
			end
		else if(@cash >= 5000)
			begin
				set @plus		= 3
				set @cashcost	= @cashcostorg + @plus
				set @comment	= '5,000원 이상 결제로 추가 수정 '+ltrim(rtrim(str(@plus)))+'개를 지급합니다.('+ltrim(rtrim(str(@cashcostorg)))+'수정에서 '+ltrim(rtrim(str(@cashcost)))+'으로 증가)'
				update dbo.tFVUserMaster set cashcost = cashcost + @plus where gameid = @gameid
				Exec Spu_Subgiftsend 1, -1, 'SKT결제보너스', @gameid, @comment
			end

		Fetch next from curSKTCash into @gameid, @cash
	end

-- 4. 커서닫기
close curSKTCash
Deallocate curSKTCash
*/



/*
alter table dbo.tFVUserMaster add 	bgacc1listidxdel	int				default(-1)
alter table dbo.tFVUserMaster add 	bgacc2listidxdel	int				default(-1)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tFVUserMaster
while(@idx > -1000)
	begin
		update dbo.tFVUserMaster
			set
				bgacc1listidxdel = -1,
				bgacc2listidxdel = -1
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/

--update dbo.tFVUserMaster set comreward = 90372 where gameid = 'farm378'
--update dbo.tFVUserMaster set comreward = -1 where gameid = 'farm378'
--select * from dbo.tFVUserMaster where comreward = -1
--update dbo.tFVUserMaster set comreward = 90154 where comreward = -1

/*
declare @gameid_	varchar(20) set @gameid_ = 'xxxx2'
declare @idx2		int			set @idx2 		= 0
declare @USER_LIST_MAX					int					set @USER_LIST_MAX 						= 50
select * from dbo.tFVComReward where gameid = @gameid_ order by idx2 desc
select * from dbo.tFVComReward order by idx2 desc

select @idx2 = isnull(max(idx2), 1) from dbo.tFVComReward where gameid = @gameid_
set @idx2 = @idx2 + 1
select @idx2
*/

-- select * from dbo.tFVItemInfo where category = 901 and itemcode = 90372
-- update dbo.tFVItemInfo set param8 = 90152 where category = 901 and itemcode = 90372

--select top 10 * from dbo.tFVComReward order by idx desc
--select top 10 * from dbo.tFVComReward where gameid = 'farm423406560' order by idx2 desc

/*
--alter table dbo.tFVComReward add 	idx2			int

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tFVComReward
while(@idx > -1000)
	begin
		update dbo.tFVComReward
			set
				idx2 = itemcode - 90000
		where idx >= @idx - 1000 and idx <= @idx and idx2 is null
		set @idx =  @idx - 1000
	end
*/

/*
-- gameid, idx2
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVComReward_gameid_idx2')
	DROP INDEX tFVComReward.idx_tFVComReward_gameid_idx2
GO
CREATE INDEX idx_tFVComReward_gameid_idx2 ON tComReward (gameid, idx2)
GO
*/


/*alter table dbo.tFVUserAdLog add 	mode	int					default(1)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tFVUserAdLog
while(@idx > -1000)
	begin
		update dbo.tFVUserAdLog
			set
				mode = 1
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/

/*
update dbo.tFVUserItem set acc1 = 1401, acc2 = 1462 where gameid = 'xxxx2' and listidx = 19

-- select * from dbo.tFVUsermaster where gameid = 'xxxx2'
alter table dbo.tFVUserMaster add 	bgacc1listidx	int					default(-1)
alter table dbo.tFVUserMaster add 	bgacc2listidx	int					default(-1)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tFVUserMaster
while(@idx > -1000)
	begin
		update dbo.tFVUserMaster
			set
				bgacc1listidx = -1,
				bgacc2listidx = -1
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/

/*
-- select * from dbo.tFVUsermaster where gameid = 'xxxx2'
alter table dbo.tFVUserMaster add 	pettodayitemcode2	int				default(100005)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tFVUserMaster
while(@idx > -1000)
	begin
		update dbo.tFVUserMaster
			set
				pettodayitemcode2 = 100005
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/


/*
select * from dbo.tFVKakaoMaster where kakaouserid = '88258263875124913'
select * from dbo.tFVKakaoMaster where kakaouserid = '88452235362617025'

insert into dbo.tFVKakaoMaster(kakaotalkid,   kakaouserid,                 gameid,   kakaodata, writedate)
values(						'A1QZxsYZVAM', '88452235362617025', 'farm161006288', 1, '2014-05-12 12:14')
*/

/*
alter table dbo.tFVSystemPack add packmarket			varchar(40)			default('1,2,3,4,5,6,7')

update dbo.tFVSystemPack set packmarket = '1,2,3,4,5,6,7'
*/
/*

declare @market_			int					set @market_					= 7
declare @strmarket			varchar(40)

set @strmarket = '%' + ltrim(rtrim(str(@market_))) + '%'

select top 1 * from dbo.tFVSystemPack
where famelvmin <= 5
	and 5 <= famelvmax
	and packstate = 1
	and packmarket like @strmarket
	order by newid()

*/
--update dbo.tFVSystemInfo set iphonecoupon = 0 where idx = 10
/*
declare @gameid		varchar(60)		set @gameid = 'farm49'
declare @friend		varchar(20)
declare @password	varchar(20)
declare @idx		int				set @idx	= 46

select @password = password from dbo.tFVUserMaster where gameid = @gameid
update dbo.tFVUserFriend set helpdate = getdate() - 10 where gameid = @gameid
-- 1. 커서 생성
declare curHelpFriend Cursor for
select friendid from dbo.tFVUserFriend where gameid = @gameid

-- 2. 커서오픈
open curHelpFriend

-- 3. 커서 사용
Fetch next from curHelpFriend into @gameid
while @@Fetch_status = 0
	Begin
		-- 3-1. 도움요청(나0
		exec spu_FVKakaoFriendHelp @gameid, @password, @friend, @idx, -1

		-- 3-2. 도움처리(친구)
		exec spu_FVsubKakaoHelpWait @friend

		Fetch next from curHelpFriend into @gameid
	end

-- 4. 커서닫기
close curHelpFriend
Deallocate curHelpFriend
*/







/*
-- 펫 오늘만 이가격 추천구매.
-- exec spu_FVItemPet 'farm49', '0423641e9n4j3z454287', 1, 100000, -1	-- 펫구매(이미구매된것)
-- exec spu_FVItemPet 'farm49', '0423641e9n4j3z454287', 4,     45, -1
-- 도움요청
--
-- select * from dbo.tFVKakaoHelpWait where gameid = 'farm49'
-- farm49 -> farm45, farm939030595, farm939033459, farm939034201 요청
-- exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 3429809, -1, -1, -1, -1	-- 소선물받기.
-- exec spu_FVAniDie 'xxxx2', '049000s1i0n7t8445289', 1, 1, -1						-- 눌러죽음.
update dbo.tFVUserFriend set helpdate = getdate() - 10 where gameid in ('farm49', 'farm939030595', 'farm939033459')
exec spu_FVKakaoFriendHelp 'farm49', '0423641e9n4j3z454287', 'farm939030595',  46, -1
exec spu_FVKakaoFriendHelp 'farm49', '0423641e9n4j3z454287', 'farm939033459', 46, -1

-- 도움처리
exec spu_FVsubKakaoHelpWait 'farm939030595'
exec spu_FVsubKakaoHelpWait 'farm939033459'
*/







/*
delete from dbo.tFVItemInfo where itemcode in (19, 118, 218, 81819)

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14, param15, param16, param17, param18, param19)
values('animal', '19', '1', '1', '1', '이겼 소!', '1', '0', '3', '0', '25', '28', '0', '0', '50', '1', '340', '이겼소~ 이겼소~ 우리나라가 이겼소!', '2', '4', '2', '111', '2500', '55', '4', '3', '100', '89', '214', '-1', '1', '2', '30', '51', '2', '-1', '0')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14, param15, param16, param17, param18, param19)
values('animal', '118', '1', '2', '1', '승리한거 양!', '1', '0', '3', '0', '26', '19', '0', '0', '81', '1', '450', '우리나라가 또 이긴거양? 그런거양?', '6', '4', '2', '201', '2163', '80', '6', '4', '110', '78', '608', '-1', '1', '3', '34', '67', '2', '-1', '0')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14, param15, param16, param17, param18, param19)
values('animal', '218', '1', '3', '1', '또 이겼 산양~', '0', '0', '3', '0', '26', '0', '0', '0', '118', '1', '540', '또~ 또~ 우리나라가 이겼 산양~', '9', '4', '2', '212', '2016', '100', '8', '4', '120', '73', '314', '-1', '1', '3', '36', '81', '3', '-1', '0')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10)
values('dogam', '81819', '818', '818', '0', '도감17', '1', '0', '0', '0', '16', '0', '0', '0', '0', '1', '1', '도감17', '20', '19', '118', '218', '-1', '-1', '-1', '1207', '1', '월드컵 동물 모음')
GO



*/


/*
-- 일반교배
-- 하트 추가: 27,315(합성) +   103,320(교배)
-- 코인 추가:416,600(합성) + 1,136,800(교배) 150(구매)
-- 캐쉬 추가:    270(합성)
-- 교배 	: 1036	(2014-06-10 11:37:38 ~ 2014-06-10 18:56)
-- 합성		: 676
-- 209	1 봉제 인형 산양 90
-- 110	1 늑대가죽 양 70
-- 12	5 봉제 인형 소 65
select sum(gamecost) from dbo.tFVUserItemBuyLog where gameid = 'farm939022644' and itemcode < 100 and buydate >= '2014-06-10' and buydate <= '2014-06-10 19:00'
select kind, count(*), sum(heart), sum(gamecost), sum(cashcost) from dbo.tFVRouletteLogPerson where gameid = 'farm939022644' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00' group by kind
select * from dbo.tFVRouletteLogPerson where gameid = 'farm939022644' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00'
select * from dbo.tFVComposeLogPerson where gameid = 'farm939022644' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00'
select sum(heart), sum(cashcost), sum(gamecost) from dbo.tFVComposeLogPerson where gameid = 'farm939022644' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00'
select bgcomposeic, count(*) from dbo.tFVComposeLogPerson where gameid = 'farm939022644' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00' group by bgcomposeic order by 1 desc


-- 일반교배 + 프림교배
-- 하트 추가:    8060(합성) +  43,500(교배)
-- 코인 추가: 125,420(합성) + 478,500(교배) + 900(상점구매)
-- 캐쉬 추가:     699(합성) +     440(프교배)
-- 교배 	: 457 (일반교배 435, 프림 22)
-- 합성		: 175
-- 209	1 봉제 인형 산양(90)
-- 111	1 시크한 검은양(75)
-- 15	1 무법자 젖소 (90)
select sum(gamecost) from dbo.tFVUserItemBuyLog where gameid = 'farm939021205' and itemcode < 100 and buydate >= '2014-06-10' and buydate <= '2014-06-10 19:00'
select kind, count(*), sum(heart), sum(gamecost), sum(cashcost) from dbo.tFVRouletteLogPerson where gameid = 'farm939021205' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00' group by kind
select * from dbo.tFVRouletteLogPerson where gameid = 'farm939021205' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00'
select * from dbo.tFVComposeLogPerson where gameid = 'farm939021205' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00'
select sum(heart), sum(cashcost), sum(gamecost) from dbo.tFVComposeLogPerson where gameid = 'farm939021205' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00'
select bgcomposeic, count(*) from dbo.tFVComposeLogPerson where gameid = 'farm939021205' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00' group by bgcomposeic order by 1 desc


-- 상점구매
-- 하트 추가:  68,575(합성)
-- 코인 추가: 837,600(합성) + 11,947,850(상점구매)
-- 캐쉬 추가:
-- 교배 	: 0
-- 합성		: 2014	> 최대 얼장젖소(14) 신선도75
select sum(gamecost) from dbo.tFVUserItemBuyLog where gameid = 'farm939023759' and itemcode < 100 and buydate >= '2014-06-10' and buydate <= '2014-06-10 19:00'
select * from dbo.tFVRouletteLogPerson where gameid = 'farm939023759' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00'
select * from dbo.tFVComposeLogPerson where gameid = 'farm939023759' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00'
select sum(heart), sum(cashcost), sum(gamecost) from dbo.tFVComposeLogPerson where gameid = 'farm939023759' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00'
select bgcomposeic, count(*) from dbo.tFVComposeLogPerson where gameid = 'farm939023759' and writedate >= '2014-06-10' and writedate <= '2014-06-10 19:00' group by bgcomposeic order by 1 desc

*/

/*
-- 짜요 목장 이야기 출시일부터 5/31 23:59까지 초대한 친구 인원수에 따라
-- 추첨을 통해 경품 지급처리를 할 예정입니다.
-- - 추출 기간 : 출시일 ~ 5/31 23:59
-- * 친구 보유 10명 유저 : 100명 추출
-- * 친구 보유 20명 유저 : 25명 추출
-- * 친구 보유 30명 유저 : 10명 추출
-- * 친구 보유 40명 유저 : 5명 추출
select top 100 gameid, kakaomsginvitecnt from dbo.tFVUserMaster where regdate < '2014-06-01' and kakaomsginvitecnt >= 10 and kakaomsginvitecnt < 20 order by newid()
select top 25  gameid, kakaomsginvitecnt from dbo.tFVUserMaster where regdate < '2014-06-01' and kakaomsginvitecnt >= 20 and kakaomsginvitecnt < 30 order by newid()
select top 10  gameid, kakaomsginvitecnt from dbo.tFVUserMaster where regdate < '2014-06-01' and kakaomsginvitecnt >= 30 and kakaomsginvitecnt < 40 order by newid()
select top 5   gameid, kakaomsginvitecnt from dbo.tFVUserMaster where regdate < '2014-06-01' and kakaomsginvitecnt >= 40 order by newid()
*/


/*
select COUNT(*) from dbo.tFVItemInfo where category = 1010
delete from dbo.tFVItemInfo where subcategory = 1010


insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101002', '1010', '1010', '1', '합성하늘색 젖소', '0', '0', '0', '1', '17', '0', '0', '0', '0', '0', '0', '합성하늘색 젖소', '20', '100', '5', '50 ', '3', '1', '1', '1', '-1', '-1', '1', '2', '30', '2')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101003', '1010', '1010', '1', '합성노랑 젖소', '0', '0', '0', '2', '18', '0', '0', '0', '0', '0', '0', '합성노랑 젖소', '25', '230', '10', '50 ', '3', '2', '2', '2', '-1', '-1', '2', '3', '180', '2')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101004', '1010', '1010', '1', '합성검은소', '0', '0', '1', '3', '19', '0', '0', '0', '0', '0', '0', '합성검은소', '30', '330', '15', '50 ', '3', '3', '3', '3', '-1', '-1', '3', '4', '360', '3')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101005', '1010', '1010', '1', '합성분홍 점박이 젖소', '0', '0', '1', '4', '20', '0', '0', '0', '0', '0', '0', '합성분홍 점박이 젖소', '35', '580', '20', '50 ', '3', '4', '4', '4', '-1', '-1', '4', '5', '720', '3')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101006', '1010', '1010', '1', '합성노랑 점박이 젖소', '0', '0', '1', '5', '21', '0', '0', '0', '0', '0', '0', '합성노랑 점박이 젖소', '40', '880', '25', '50 ', '3', '5', '5', '5', '-1', '-1', '5', '6', '1508', '3')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101007', '1010', '1010', '1', '합성파란 꽃무늬 젖소', '0', '0', '2', '6', '22', '0', '0', '0', '0', '0', '0', '합성파란 꽃무늬 젖소', '45', '1300', '30', '50 ', '3', '6', '6', '6', '-1', '-1', '6', '7', '2185', '4')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101008', '1010', '1010', '1', '합성분홍 꽃무늬 젖소', '0', '0', '2', '7', '23', '0', '0', '0', '0', '0', '0', '합성분홍 꽃무늬 젖소', '50', '1700', '35', '33 ', '4', '7', '7', '7', '7', '-1', '7', '8', '3025', '4')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101009', '1010', '1010', '1', '합성연보라 꽃무늬 젖소', '0', '0', '2', '8', '24', '0', '0', '0', '0', '0', '0', '합성연보라 꽃무늬 젖소', '55', '2100', '40', '33 ', '4', '8', '8', '8', '8', '-1', '8', '9', '4040', '5')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101010', '1010', '1010', '1', '합성빗살무늬 젖소', '0', '0', '3', '9', '25', '0', '0', '0', '0', '0', '0', '합성빗살무늬 젖소', '60', '3500', '45', '33 ', '4', '9', '9', '9', '9', '-1', '9', '10', '5240', '5')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101011', '1010', '1010', '1', '합성터프한 젖소', '0', '0', '3', '10', '26', '0', '0', '0', '0', '0', '0', '합성터프한 젖소', '65', '5000', '50', '33 ', '4', '10', '10', '10', '10', '-1', '10', '11', '6636', '6')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101012', '1010', '1010', '1', '합성봉제 인형 소', '0', '0', '3', '11', '27', '0', '0', '0', '0', '0', '0', '합성봉제 인형 소', '80', '8000', '55', '25 ', '5', '11', '11', '11', '11', '11', '11', '12', '10059', '6')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101013', '1010', '1010', '1', '합성세일러 젖소', '0', '0', '4', '12', '28', '0', '0', '0', '0', '0', '0', '합성세일러 젖소', '100', '12000', '60', '33 ', '4', '12', '12', '12', '12', '-1', '12', '13', '12107', '7')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101014', '1010', '1010', '1', '합성얼짱 젖소', '0', '0', '4', '13', '29', '0', '0', '0', '0', '0', '0', '합성얼짱 젖소', '125', '18000', '65', '33 ', '4', '13', '13', '13', '13', '-1', '13', '14', '14393', '7')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101015', '1010', '1010', '1', '합성무법자 젖소', '0', '0', '4', '14', '30', '0', '0', '0', '0', '0', '0', '합성무법자 젖소', '155', '27000', '70', '25 ', '5', '14', '14', '14', '14', '14', '14', '15', '16928', '7')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101101', '1010', '1010', '1', '합성갈색 양', '0', '0', '0', '30', '2', '0', '0', '0', '0', '0', '0', '합성갈색 양', '25', '250', '15', '50 ', '3', '100', '100', '100', '-1', '-1', '100', '101', '180', '2')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101102', '1010', '1010', '1', '합성분홍 양', '0', '0', '0', '31', '3', '0', '0', '0', '0', '0', '0', '합성분홍 양', '30', '440', '20', '50 ', '3', '101', '101', '101', '-1', '-1', '101', '102', '360', '2')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101103', '1010', '1010', '1', '합성검은양', '0', '0', '2', '32', '22', '0', '0', '0', '0', '0', '0', '합성검은양', '35', '590', '25', '50 ', '3', '102', '102', '102', '-1', '-1', '102', '103', '720', '3')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101104', '1010', '1010', '1', '합성노란별무늬 양', '0', '0', '2', '33', '22', '0', '0', '0', '0', '0', '0', '합성노란별무늬 양', '40', '970', '30', '50 ', '3', '103', '103', '103', '-1', '-1', '103', '104', '1374', '4')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101105', '1010', '1010', '1', '합성파란별무늬 양', '0', '0', '1', '34', '6', '0', '0', '0', '0', '0', '0', '합성파란별무늬 양', '45', '1500', '35', '33 ', '4', '104', '104', '104', '104', '-1', '104', '105', '2100', '4')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101106', '1010', '1010', '1', '합성노랑 체크무늬 양', '0', '0', '2', '35', '7', '0', '0', '0', '0', '0', '0', '합성노랑 체크무늬 양', '50', '2000', '40', '33 ', '4', '105', '105', '105', '105', '-1', '105', '106', '3069', '5')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101107', '1010', '1010', '1', '합성분홍 체크무늬 양', '0', '0', '2', '36', '8', '0', '0', '0', '0', '0', '0', '합성분홍 체크무늬 양', '55', '2600', '45', '33 ', '4', '106', '106', '106', '106', '-1', '106', '107', '4309', '5')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101108', '1010', '1010', '1', '합성하늘색 체크무늬 양', '0', '0', '3', '37', '26', '0', '0', '0', '0', '0', '0', '합성하늘색 체크무늬 양', '60', '3300', '50', '33 ', '4', '107', '107', '107', '107', '-1', '107', '108', '5847', '6')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101109', '1010', '1010', '1', '합성봉제 인형 양', '0', '0', '3', '38', '10', '0', '0', '0', '0', '0', '0', '합성봉제 인형 양', '80', '5000', '55', '25 ', '5', '108', '108', '108', '108', '108', '108', '109', '9923', '7')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101110', '1010', '1010', '1', '합성늑대가죽 양', '0', '0', '3', '39', '11', '0', '0', '0', '0', '0', '0', '합성늑대가죽 양', '110', '8000', '60', '33 ', '4', '109', '109', '109', '109', '-1', '109', '110', '12513', '7')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101111', '1010', '1010', '1', '합성시크한 검은 양', '0', '0', '3', '40', '26', '0', '0', '0', '0', '0', '0', '합성시크한 검은 양', '150', '12000', '65', '33 ', '4', '110', '110', '110', '110', '-1', '110', '111', '15505', '8')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101112', '1010', '1010', '1', '합성얼짱 양', '0', '0', '4', '41', '13', '0', '0', '0', '0', '0', '0', '합성얼짱 양', '200', '18000', '70', '33 ', '4', '111', '111', '111', '111', '-1', '111', '112', '18926', '8')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101113', '1010', '1010', '1', '합성뭉게뭉게 구름 양', '0', '0', '4', '42', '14', '0', '0', '0', '0', '0', '0', '합성뭉게뭉게 구름 양', '260', '27000', '75', '25 ', '5', '112', '112', '112', '112', '112', '112', '113', '22802', '9')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101114', '1010', '1010', '1', '합성황금뿔 양', '0', '0', '4', '43', '15', '0', '0', '0', '0', '0', '0', '합성황금뿔 양', '330', '41000', '80', '25 ', '5', '113', '113', '113', '113', '113', '113', '114', '27159', '10')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101201', '1010', '1010', '1', '합성갈색 산양', '0', '0', '0', '58', '32', '0', '0', '0', '0', '0', '0', '합성갈색 산양', '35', '400', '25', '50 ', '3', '200', '200', '200', '-1', '-1', '200', '201', '270', '2')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101202', '1010', '1010', '1', '합성분홍 산양', '0', '0', '2', '59', '22', '0', '0', '0', '0', '0', '0', '합성분홍 산양', '40', '780', '30', '50 ', '3', '201', '201', '201', '-1', '-1', '201', '202', '540', '3')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101203', '1010', '1010', '1', '합성검은 산양', '0', '0', '1', '60', '34', '0', '0', '0', '0', '0', '0', '합성검은 산양', '45', '1100', '35', '33 ', '4', '202', '202', '202', '202', '-1', '202', '203', '1080', '4')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101204', '1010', '1010', '1', '합성하얀 점박이 산양', '0', '0', '1', '61', '35', '0', '0', '0', '0', '0', '0', '합성하얀 점박이 산양', '50', '1900', '40', '33 ', '4', '203', '203', '203', '203', '-1', '203', '204', '2003', '5')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101205', '1010', '1010', '1', '합성노랑 점박이 산양', '0', '0', '3', '62', '26', '0', '0', '0', '0', '0', '0', '합성노랑 점박이 산양', '55', '2800', '45', '33 ', '4', '204', '204', '204', '204', '-1', '204', '205', '3005', '6')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101206', '1010', '1010', '1', '합성하늘색 러블리 산양', '0', '0', '2', '63', '37', '0', '0', '0', '0', '0', '0', '합성하늘색 러블리 산양', '60', '3800', '50', '33 ', '4', '205', '205', '205', '205', '-1', '205', '206', '4393', '7')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101207', '1010', '1010', '1', '합성분홍 러블리 산양', '0', '0', '2', '64', '38', '0', '0', '0', '0', '0', '0', '합성분홍 러블리 산양', '90', '6000', '55', '25 ', '5', '206', '206', '206', '206', '206', '206', '207', '8556', '8')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101208', '1010', '1010', '1', '합성보라 러블리 산양', '0', '0', '2', '65', '39', '0', '0', '0', '0', '0', '0', '합성보라 러블리 산양', '125', '9000', '60', '33 ', '4', '207', '207', '207', '207', '-1', '207', '208', '11447', '9')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101209', '1010', '1010', '1', '합성봉제 인형 산양', '0', '0', '3', '66', '40', '0', '0', '0', '0', '0', '0', '합성봉제 인형 산양', '165', '14000', '65', '33 ', '4', '208', '208', '208', '208', '-1', '208', '209', '14955', '9')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101210', '1010', '1010', '1', '합성빵봉투 산양', '0', '0', '3', '67', '26', '0', '0', '0', '0', '0', '0', '합성빵봉투 산양', '210', '21000', '70', '33 ', '4', '209', '209', '209', '209', '-1', '209', '210', '19139', '10')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101211', '1010', '1010', '1', '합성팔랑팔랑 산양', '0', '0', '3', '68', '42', '0', '0', '0', '0', '0', '0', '합성팔랑팔랑 산양', '260', '32000', '75', '25 ', '5', '210', '210', '210', '210', '210', '210', '211', '24058', '11')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101212', '1010', '1010', '1', '합성루돌프 산양', '0', '0', '4', '69', '43', '0', '0', '0', '0', '0', '0', '합성루돌프 산양', '315', '48000', '80', '25 ', '5', '211', '211', '211', '211', '211', '211', '212', '29773', '12')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101213', '1010', '1010', '1', '합성얼짱 산양', '0', '0', '4', '70', '44', '0', '0', '0', '0', '0', '0', '합성얼짱 산양', '375', '72000', '85', '25 ', '5', '212', '212', '212', '212', '212', '212', '213', '36344', '13')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
values('compose', '101214', '1010', '1010', '1', '합성조로 산양', '0', '0', '4', '71', '45', '0', '0', '0', '0', '0', '0', '합성조로 산양', '440', '110000', '90', '25 ', '5', '213', '213', '213', '213', '213', '213', '214', '43832', '14')
GO



*/



/*
alter table dbo.tFVUserMaster add 	bgcomposecc	int						default(0)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tFVUserMaster
while(@idx > -1000)
	begin
		update dbo.tFVUserMaster
			set
				bgcomposecc = 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/

--update dbo.tFVItemInfo set itemname = '합성시간초기화' where itemcode = 50002



/*
-----------------------------------------
--기존에 합성한 최종값을 전달한다.
-----------------------------------------
-- select top 1 * from dbo.tFVUserMaster
alter table dbo.tFVUserMaster add 	bgcomposewt	datetime				default(getdate())

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tFVUserMaster
while(@idx > -1000)
	begin
		update dbo.tFVUserMaster
			set
				bgcomposewt = getdate()
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/

/*
alter table dbo.tFVSystemInfo add iphonecoupon		int					default(0)		-- 0:안보임, 1:보임

update dbo.tFVSystemInfo set iphonecoupon = 0
*/


/*
select * from dbo.tFVUserMaster where market = 7 and regdate >= '2014-06-05 09:00'

--insert into dbo.tFVEventCertNo(certno,  itemcode1,  itemcode2,  itemcode3, kind) values('1111111111111111',      5001,          -1,          -1,           7)
--insert into dbo.tFVEventCertNo(certno,  itemcode1,  itemcode2,  itemcode3, kind) values('2222222222222222',      5001,          -1,          -1,           7)

-- 쿠팡에서 구매취소 하고 재구매를 반복하면 수정을 여러번 받을수 있습니다.  구매제한은 1개로 제한되어있는데 구매취소하게 되면 제한이 풀려 재구매가 가능하네요.
*/

/*
alter table dbo.tFVEventCertNoBack add 	kind		int				default(0)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tFVEventCertNoBack
while(@idx > -1000)
	begin
		update dbo.tFVEventCertNoBack
			set
				kind	= 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/
/*
select MAX(idx) from dbo.tFVEventCertNo
select MAX(idx) from dbo.tFVEventCertNoBack

select * from dbo.tFVEventCertNo where certno = '0123456789123456'
select * from dbo.tFVEventCertNoBack where certno = '0123456789123456'

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventCertNoBack_gameid_kind')
    DROP INDEX tFVEventCertNoBack.idx_tFVEventCertNoBack_gameid_kind
GO
CREATE INDEX idx_tFVEventCertNoBack_gameid_kind ON tEventCertNoBack (gameid, kind)
GO
*/

/*
-----------------------------------------
--기존에 합성한 최종값을 전달한다.
-----------------------------------------
-- bgcompose - > bgcomposeic
alter table dbo.tFVUserMaster add 	bgcomposeic	int						default(-1)
alter table dbo.tFVUserMaster add 	bgcomposert	int						default(0)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tFVUserMaster
while(@idx > -1000)
	begin
		update dbo.tFVUserMaster
			set
				bgcomposeic = -1,
				bgcomposert	= 0
		where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end
*/
/*
---------------------------------------------
-- 	합성 로그 > 개인자료
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVComposeLogPerson', N'U') IS NOT NULL
	DROP TABLE dbo.tFVComposeLogPerson;
GO

create table dbo.tFVComposeLogPerson(
	idx				int				identity(1, 1),

	kind 			int,
	gameid			varchar(20),
	gameyear		int,
	gamemonth		int,
	famelv			int,
	heart			int				default(0),
	cashcost		int				default(0),
	gamecost		int				default(0),

	itemcode		int				default(-1),
	itemcodename	varchar(40)		default(''),

	itemcode0		int				default(-1),
	itemcode1		int				default(-1),
	itemcode2		int				default(-1),
	itemcode3		int				default(-1),
	itemcode4		int				default(-1),
	itemcode0name	varchar(40)		default(''),

	bgcomposeic		int				default(1),
	bgcomposert		int				default(0),
	bgcomposename	varchar(40)		default(''),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tComposeLogPerson_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVComposeLogPerson_gameid_idx')
	DROP INDEX tFVComposeLogPerson.idx_tFVComposeLogPerson_gameid_idx
GO
CREATE INDEX idx_tFVComposeLogPerson_gameid_idx ON tComposeLogPerson (gameid, idx)
GO
-- select top 100 * from dbo.tFVComposeLogPerson where gameid = 'xxxx2' order by idx desc
*/
/*
alter table dbo.tFVSystemInfo add 		composesale			int					default(0)

update dbo.tFVSystemInfo set composesale = 0
*/

/*


alter table dbo.tFVNotice add 		comfile4		varchar(512)	default('')
alter table dbo.tFVNotice add 		comurl4			varchar(512)	default('')
alter table dbo.tFVNotice add 		comfile5		varchar(512)	default('')
alter table dbo.tFVNotice add 		comurl5			varchar(512)	default('')

update dbo.tFVNotice set comfile4 = '', comurl4 = '', comfile5 = '', comurl5 = ''
select * from dbo.tFVNotice
-- delete from dbo.tFVNotice where idx = 5


*/

/*
-- 010-2944-7960	1565341819
select * from dbo.tFVUserMaster where phone = '1565341819' order by idx desc

select * from dbo.tFVKakaoMaster where kakaouserid = '88452235362617025'
-- update dbo.tFVKakaoMaster set gameid = 'farm161006288' where kakaouserid = '88452235362617025'
select * from dbo.tFVUserMaster where gameid = 'farm161006288'
-- update dbo.tFVUserMaster set kakaouserid = '88452235362617025' where gameid = 'farm161006288'



select top 10 * from dbo.tFVUserMaster where gameid like 'iuest%' and famelv = 50 and kakaouserid = '88452235362617025'
select * from dbo.tFVUserMaster where gameid like 'iuest%' and famelv = 50 and regdate >= '2014-05-23' and regdate <= '2014-05-25'
-- 418780	iuest418780631	9050198t6g6i2y327658	7	0	2	xxxxx	108	7346d39a861a8c58ee34b4dcc9bfb209da08ae4f30585eaad1440003c2c70ca8	2054960143	1	ACvSVFTSKwA	88301122415609184	/lNC1D2DAsuqhNQQbdJK8g==	X1O+2tQVVBqen7Rw61tqzjRMS7Ck1OLSozeclo8Z5i7YABa1SpCELbNS7APCOsN2NF3NzUNjaZ8MLTBktLQj/AAo3ma/SxjcOA3VE8Iqzj5Hv/aw5HPCYC8RZMNnBms+	-1	1	0	0	2014-06-02 02:40:51.327	1	2014-05-23 21:21:25.697	2014-06-02 02:40:51.370	37	0	0	0	0	2014-06-02 02:40:51.327	1	0		1	5500	90150	-1	6	100000	0	100003	95	208	1403	1450	내가 최고	2076	2	0	391	0	65	390	65	4458	50	50	0	1	2	2027653	1	1	1	1	1	1	1	1	1	15	1	13	1	6	0	-1	0	0	0	19	28614	109	120	54	500	6	104	500	10	N3I3727I2M7V74371V	9	-1	-1	-1	-1	63	1	-1	-1	-1	-1	20	19	84	97	-1	-1	-1	-1	-1	1	66	487	30240	5	-1	2014-05-27 14:01:27.637	19	-1	2014-05-30 10:36:38.450	17	-1	2014-05-29 16:53:05.423	18	-1	2014-05-31 10:49:13.017	18	-1	2014-06-01 00:22:38.160	15	-1	2014-05-30 06:26:58.177	12	-1	2014-05-31 19:11:33.997	10	563	5	15	391	563	2120	155848	1610	13102	2013	172	82	17	2352	16	1	90150	17	0	0	207109	0	0	0	0	0	3699	5	10833	539354	498988	1	2	iuest418780631	208	1402	1450	498988	/lNC1D2DAsuqhNQQbdJK8g==	X1O+2tQVVBqen7Rw61tqzjRMS7Ck1OLSozeclo8Z5i7YABa1SpCELbNS7APCOsN2NF3NzUNjaZ8MLTBktLQj/AAo3ma/SxjcOA3VE8Iqzj5Hv/aw5HPCYC8RZMNnBms+	farm562453478	1	-1	-1	278178	EMmalyarA3eSnVpFu3ouFA==	X1O+2tQVVBqen7Rw61tqzjRMS7Ck1OLSozeclo8Z5i7YABa1SpCELW4aLQeGnaQowLGNhnVQMFwG0ibETNbqEtpEexxU4jByLI7mbTpxdoxHv/aw5HPCYC8RZMNnBms+	farm389217985	205	-1	-1	1306345			29385	-1	1	20140602	2014-05-22 21:21:25.697	0	0	0	0	0	0	0	0	0	0	1
-- 454391	iuest454391993	7621547k7o8j3w372415	7	0	2	xxxxx	109	dc4a0297f5e041210651c634089777834ab12687929d41a098d8760b2fa6b2a3	4381259941	1	CAIVU1MVAgg	91569090120178385	NN1NyQPNfbw=	X1O+2tQVVBqen7Rw61tqzjRMS7Ck1OLSozeclo8Z5i7YABa1SpCELVuY1vfLGn+MdcCjHvgQCW7ceZIUG5PSmx+FZeS53uIuNNRViy8oDF9Hv/aw5HPCYC8RZMNnBms+	-1	1	0	0	2014-06-02 00:01:01.963	1	2014-05-24 19:16:25.163	2014-06-02 16:46:25.430	552	0	0	0	0	2014-06-02 00:01:01.963	2	0		1	5500	90191	-1	6	100000	0	100006	97	206	-1	-1	내가 최고	2053	12	0	490	0	81	489	81	3707	50	50	0	1	0	2060107	1	1	1	1	1	1	1	1	1	15	1	13	1	11	1	-1	0	0	0	43	375937	32	160	104	500	0	336	500	0	6LRL7L2L9LSSLL222S	7	-1	-1	-1	-1	146	0	-1	-1	-1	-1	102	107	104	9	-1	-1	-1	-1	-1	15	1072	7	462	6	-1	2014-05-28 17:56:20.290	20	-1	2014-06-02 06:52:24.553	15	-1	2014-06-02 14:53:39.000	17	1	2014-06-02 18:28:36.970	10	-1	2014-06-02 12:03:31.857	17	1	2014-06-02 18:28:32.780	16	1	2014-06-02 23:46:08.843	35	3153	10	81	490	1828	32	397689	8030	0	5179	181	87	30	4170	119	0	90191	0	0	0	203906	0	0	0	0	0	3381	5	267261	516181	380408	1	1	iuest454391993	206	-1	-1	380408	lU4aiKfZN44xmnbID3jd5A==		farm493709117	107	-1	-1	15160			farm315414728	205	1404	-1	14799			0	-1	0	20140602	2014-05-23 19:16:25.163	0	0	0	0	0	0	0	0	0	0	0
*/


/*
alter table dbo.tFVUserMaster add 	kkhelpalivecnt			int				default(0)

declare @idx int set @idx = 0
select @idx = max(idx) from dbo.tFVUserMaster
while(@idx > -1000)
	begin
		update dbo.tFVUserMaster set kkhelpalivecnt = 0 where idx >= @idx - 1000 and idx <= @idx
		set @idx =  @idx - 1000
	end


-- 친구 추가 및 살려주기
-- 친구맺기
exec spu_FVKakaoFriendAdd 'xxxx2',  '049000s1i0n7t8445289', '0:kakaouseridxxxx;1:kakaouseridxxxx3;', -1

-- 동물 죽여서 > 도움 요청
exec spu_FVAniDie 'xxxx2', '049000s1i0n7t8445289', 1, 1, -1						-- 눌러죽음.
update dbo.tFVUserFriend set helpdate = getdate() - 10 where gameid in ('xxxx2', 'xxxx', 'xxxx3')
exec spu_FVKakaoFriendHelp 'xxxx2', '049000s1i0n7t8445289', 'xxxx',  0, -1
exec spu_FVKakaoFriendHelp 'xxxx2', '049000s1i0n7t8445289', 'xxxx3', 1, -1

-- 도와주기 처리.
exec spu_FVsubKakaoHelpWait 'xxxx'
exec spu_FVsubKakaoHelpWait 'xxxx3'

-- 로그인하면 도움 요청 확인 가능.
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 1, 103, '', '', -1, -1			-- 정상유저

*/

/*
delete from dbo.tFVUserFriend where gameid = @gameid_
delete from dbo.tFVUserFriend where friendid = @gameid_
select * from dbo.tFVUserFriend where gameid = 'xxxx2'
select * from dbo.tFVUserFriend where friendid = 'xxxx2'
*/


/*
-- 돈, 수정, 교배
--select top 10 cashcost, * from dbo.tFVUserMaster order by 1 desc
select top 10 gamecost, * from dbo.tFVUserMaster order by 1 desc
--select top 10 tradecnt, * from dbo.tFVUserMaster order by 1 desc
--select top 10 bktsalecoin, * from dbo.tFVUserMaster order by 1 desc
--select top 10 bkcrossnormal, * from dbo.tFVUserMaster order by 1 desc
--select top 10 bkcrosspremium, * from dbo.tFVUserMaster order by 1 desc
--select top 10 ttsalecoinbkup, * from dbo.tFVUserMaster order by 1 desc
--select top 10 pmroulcnt, * from dbo.tFVUserMaster order by 1 desc
--select top 10 bgroulcnt, * from dbo.tFVUserMaster order by 1 desc
*/
/*
select * from dbo.tFVUserMaster where phone = '01095759505' order by idx desc

select * from dbo.tFVKakaoMaster where kakaouserid = '91831715733767296'
-- update dbo.tFVKakaoMaster set gameid = 'farm452374348' where kakaouserid = '91831715733767296'
select * from dbo.tFVUserMaster where gameid = 'farm452374348'
-- update dbo.tFVUserMaster set kakaouserid = '91831715733767296' where gameid = 'farm452374348'
*/

/*
-- 뽑기 인덱스가 변경이 안됨.
declare @idx_ int set @idx_ = 1

	declare @famelvmin 				int 			set @famelvmin 			= 1
	declare @famelvmax 				int 			set @famelvmax 			= 10

select @famelvmin = famelvmin, @famelvmax = famelvmax from dbo.tFVSystemRoulette where idx = @idx_


			select top 1 @idx_ = idx from dbo.tFVSystemRoulette
			where famelvmin = @famelvmin
				and famelvmax = @famelvmax
				and packstate = 1
				order by newid()
*/

/*
-- 4. 악세사리 가격 50%할인
-- 관리자 페이지에서 정의
*/

/*
--delete from dbo.tFVItemInfo where subcategory = 600 and itemcode >= 60094
select * from dbo.tFVItemInfo where subcategory = 600 and itemname like '%(2차버젼)'
select * from dbo.tFVItemInfo where subcategory = 600 and itemname not like '%(2차버젼)'
select * from dbo.tFVSystemRoulette where packname like '%(2차버젼)'
select * from dbo.tFVSystemRoulette where packname not like '%(2차버젼)'
update dbo.tFVSystemRoulette set packstate = -1 where packname not like '%(2차버젼)'
*/

/*

update dbo.tFVItemInfo set gamecost = 0, cashcost = 100 where itemcode = 16
update dbo.tFVItemInfo set gamecost = 0, cashcost = 120 where itemcode = 17
update dbo.tFVItemInfo set gamecost = 0, cashcost = 140 where itemcode = 18

update dbo.tFVItemInfo set gamecost = 0, cashcost = 160 where itemcode = 115
update dbo.tFVItemInfo set gamecost = 0, cashcost = 180 where itemcode = 116
update dbo.tFVItemInfo set gamecost = 0, cashcost = 200 where itemcode = 117

update dbo.tFVItemInfo set gamecost = 0, cashcost = 260 where itemcode = 215
update dbo.tFVItemInfo set gamecost = 0, cashcost = 280 where itemcode = 216
update dbo.tFVItemInfo set gamecost = 0, cashcost = 300 where itemcode = 217

update dbo.tFVItemInfo set itemname = '황금털 양' where itemcode = 115
update dbo.tFVItemInfo set itemname = '얼음뿔 산양' where itemcode = 215
*/


/*
DECLARE @tTempUserRank TABLE(
	idx		int
);
declare @idx2 	int

select @idx2 = max(idx) from dbo.tFVUserMaster

-- 분산변경
while(@idx2 > -1000)
	begin
		--select 'DEBUG', @idx idx
		insert into @tTempUserRank(idx) values(@idx2)
		update dbo.tFVUserMaster set fpointmax = 500 where idx >= @idx2 - 1000 and idx < @idx2
		set @idx2 = @idx2 - 1000
	end
select top 10 * from @tTempUserRank order by idx desc
select top 10 * from @tTempUserRank order by idx asc
select top 10 fpointmax from dbo.tFVUserMaster order by idx desc
select top 10 fpointmax from dbo.tFVUserMaster order by idx asc

-- 1번 직접변경.
-- 한번에 업데이트 하니까 11:23초 걸림 ㅠㅠ
-- 유저 정보가 전체 락걸림 ㅠㅠ
-- update dbo.tFVUserMaster set fpointmax = 500


/*
select top 2 * from dbo.tFVSchoolSchedule order by idx desc
select top 2 * from dbo.tFVUserMasterSchedule order by idx desc
*/


/*
declare @cnt int, @cnt2 int, @RESULT_SUCCESS int
set @cnt 	= 0
set @cnt2 	= 0
set @RESULT_SUCCESS = 1
select @cnt = isnull(max(idx)+1 - min(idx), 0) from dbo.tFVUserPushAndroid
select @cnt2 = isnull(max(idx)+1 - min(idx), 0) from dbo.tFVUserPushiPhone
select @RESULT_SUCCESS 'rtn', @cnt cnt, @cnt2 cnt2

-- 2014-05-26 15:45:51.043
-- 2014-05-26 15:45:52.000
-- select getdate()
select top 100 * from dbo.tFVUserPushAndroid
select top 100 * from dbo.tFVUserPushAndroid where scheduleTime < getdate()
select top 100 * from dbo.tFVUserPushiPhone
select top 100 * from dbo.tFVUserPushiPhone where scheduleTime < getdate()
*/
/*
	declare @EVENT_STATE_NON					int					set @EVENT_STATE_NON				= 0
	declare @EVENT_STATE_YES					int					set @EVENT_STATE_YES				= 1
	declare @GIFTLIST_GIFT_KIND_MESSAGE			int					set @GIFTLIST_GIFT_KIND_MESSAGE				= 1
	declare @GIFTLIST_GIFT_KIND_GIFT			int					set @GIFTLIST_GIFT_KIND_GIFT				= 2

	declare @gameid_				varchar(20)		set @gameid_		= 'xxxx2'
	declare @curdate				datetime		set @curdate		= getdate()
	declare @eventidx				int				set @eventidx					= -1
	declare @eventitemcode			int				set @eventitemcode				= -1
	declare @eventsender 			varchar(20)		set @eventsender				= '짜요 소녀'
	declare @eventstatemaster		int				set @eventstatemaster			= @EVENT_STATE_NON

			select @eventstatemaster = eventstatemaster from dbo.tFVEventMaster where idx = 1
			select 'DEBUG 지정이벤트1-1', @eventstatemaster eventstatemaster
			if(@eventstatemaster = @EVENT_STATE_YES)
				begin
					select top 1
						@eventidx 		= eventidx,
						@eventitemcode 	= eventitemcode,
						@eventsender 	= eventsender
					from dbo.tFVEventSub
					where eventstart <= @curdate and @curdate < eventend and eventstatedaily = @EVENT_STATE_YES
					order by eventidx desc
					select 'DEBUG 지정이벤트1-2', @eventidx eventidx, @eventitemcode eventitemcode, @eventsender eventsender

					if(@eventidx != -1 and @eventitemcode != -1)
						begin
							select 'DEBUG 지정이벤트1-3'
							if(not exists(select top 1 * from dbo.tFVEvnetUserGetLog where gameid = @gameid_ and eventidx = @eventidx))
								begin

									select 'DEBUG 지정이벤트1-4 선물, 로그기록'
									--exec spu_FVSubGiftSend @GIFTLIST_GIFT_KIND_GIFT,  @eventitemcode, @eventsender, @gameid_, '지정된 시간'

									--insert into dbo.tFVEvnetUserGetLog(gameid,   eventidx,  eventitemcode)
									--values(                         @gameid_, @eventidx, @eventitemcode)
								end
						end
				end
select top 10 * from tEvnetUserGetLog order by idx desc
*/


/*
---------------------------------------------
--		이벤트 마스터
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEventMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEventMaster;
GO

create table dbo.tFVEventMaster(
	idx						int					IDENTITY(1,1),

	eventstatemaster		int					default(0),		-- 0:대기중, 1:진행중, 2:완료중

	-- Constraint
	CONSTRAINT	pk_tEventMaster_eventstatemaster	PRIMARY KEY(eventstatemaster)
)

-- insert into dbo.tFVEventMaster(eventstatemaster) values(0)
-- update dbo.tFVEventMaster set eventstatemaster = case when eventstatemaster = 0 then 1 else 0 end where idx = 1
-- select eventstatemaster from dbo.tFVEventMaster where idx = 1

---------------------------------------------
--		이벤트 서브
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEventSub', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEventSub;
GO

create table dbo.tFVEventSub(
	eventidx		int					IDENTITY(1,1),
	eventstatedaily	int					default(0),					-- 0:EVENT_STATE_NON, 1:ING, 2:_END
	eventitemcode	int					default(-1),
	eventsender		varchar(20)			default('짜요 소녀'),
	eventstart		smalldatetime		default(getdate() - 1),
	eventend		smalldatetime		default(getdate() - 1),

	eventpushtitle	varchar(512)		default(''),				-- 푸쉬 제목, 내용, 상태
	eventpushmsg	varchar(512)		default(''),				--
	eventpushstate	int					default(0),					-- 0:EVENT_PUSH_NON, 1:EVENT_PUSH_SEND

	writedate		datetime			default(getdate()),
	CONSTRAINT	pk_tEventSub_eventidx	PRIMARY KEY(eventidx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventSub_eventstart_eventend')
    DROP INDEX tFVEventSub.idx_tFVEventSub_eventstart_eventend
GO
CREATE INDEX idx_tFVEventSub_eventstart_eventend ON tEventSub (eventstart, eventend)
GO

--insert into dbo.tFVEventSub(eventitemcode,  eventsender,  eventstart,            eventend,  eventpushtitle, eventpushmsg)
--values(                            1104,  '짜요 소녀', '2014-05-24',       '2014-05-24 18:00', '나른한 토요일 불타는 점심선물', '특수 촉진제와 함께 손가락이 불타는 시간을 보내보세요.')
--insert into dbo.tFVEventSub(eventitemcode,  eventsender,  eventstart,            eventend,  eventpushtitle, eventpushmsg)
--values(                            5007,  '짜요 소녀', '2014-05-24 18:00', '2014-05-24 23:59', '나른한 토요일 수정 받고 가세요!', '수정 선물이 도착했어요! 지금 바로 접속!')
--insert into dbo.tFVEventSub(eventitemcode,  eventsender,  eventstart,            eventend,  eventpushtitle, eventpushmsg)
--values(                            5009,  '짜요 소녀', '2014-05-25',       '2014-05-25 18:00', '즐거운 일요일! 지금 선물 받으세요!', ' 사라져요!지금 접속해서 수정 10개를 받아주세요~')
--insert into dbo.tFVEventSub(eventitemcode,  eventsender,  eventstart,            eventend,  eventpushtitle, eventpushmsg)
--values(                            2201,  '짜요 소녀', '2014-05-25 18:00', '2014-05-25 23:59', '20시까지 교배 티켓 받으세요~', '20시까지 접속하면 교배티켓 2장이 선물로! 빨리 접속하세요~')
--insert into dbo.tFVEventSub(eventitemcode,  eventsender,  eventstart,            eventend,  eventpushtitle, eventpushmsg)
--values(                            1202,  '짜요 소녀', '2014-05-26',       '2014-05-26 18:00', '오늘의 점심 선물은 뭘까요?', '죽은 소도 살려준다는 그것! 지금 바로 접속해서 선물받으세요~')
--insert into dbo.tFVEventSub(eventitemcode,  eventsender,  eventstart,            eventend,  eventpushtitle, eventpushmsg)
--values(                            2013,  '짜요 소녀', '2014-05-26 18:00', '2014-05-26 23:59', '사랑의 선물이 도착했어요~', '선물이 곧 사라져요~ 빨리 접속해서 선물 받으세요!')
--update dbo.tFVEventSub
--	set
--		eventstatedaily	= 1,
--		eventitemcode 	= 1104,
--		eventsender		= '짜요 소녀',
--		eventstart 		= '2014-05-24',
--		eventend		= '2014-05-24 18:00',
--		eventpushtitle	= '나른한 토요일 불타는 점심선물',
--		eventpushmsg	= '특수 촉진제와 함께 손가락이 불타는 시간을 보내보세요.'
--where eventidx = 1
--update dbo.tFVEventSub set eventstatedaily= 1 where eventidx in (1, 2, 3, 4, 5, 6)
--update dbo.tFVEventSub set eventpushstate	= 1 where eventidx = 2
--declare @curdate datetime set @curdate = getdate()
--select * from dbo.tFVEventSub where eventstart <= @curdate and @curdate < eventend and eventstatedaily = 1
--select top 100 * from dbo.tFVEventSub order by eventidx desc


---------------------------------------------
--		이벤트 받아간 유저로그
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEvnetUserGetLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEvnetUserGetLog;
GO

create table dbo.tFVEvnetUserGetLog(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),
	eventidx		int,
	eventitemcode	int,
	writedate		datetime			default(getdate()),
	CONSTRAINT	pk_tEvnetUserGetLog_eventidx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEvnetUserGetLog_gameid_eventidx')
    DROP INDEX tFVEvnetUserGetLog.idx_tFVEvnetUserGetLog_gameid_eventidx
GO
CREATE INDEX idx_tFVEvnetUserGetLog_gameid_eventidx ON tEvnetUserGetLog (gameid, eventidx)
GO

-- insert into dbo.tFVEvnetUserGetLog(gameid, eventidx, eventitemcode) values( 'xxxx2', 1, 1104)
-- select * from dbo.tFVEvnetUserGetLog where gameid = 'xxxx2' and eventidx = 1
*/

/*
---------------------------------------------
--		학교대항전 결과.
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSchoolResult', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSchoolResult;
GO

create table dbo.tFVSchoolResult(
	idx						int					IDENTITY(1,1),

	schoolresult			int					default(0),
	writedate				datetime			default(getdate()),


	-- Constraint
	CONSTRAINT	pk_tSchoolResult_schoolresult	PRIMARY KEY(schoolresult)
)

-- insert into dbo.tFVSchoolResult(schoolresult) values(1)
-- select * from dbo.tFVSchoolResult order by schoolresult desc
-- select top 1 schoolresult from dbo.tFVSchoolResult order by schoolresult desc
-- insert into dbo.tFVSchoolResult(schoolresult) select top 1 (isnull(schoolresult, 0) + 1) from dbo.tFVSchoolResult order by schoolresult desc
*/



/*
alter table dbo.tFVSchoolMaster add 	backcnt					int					default(1)
alter table dbo.tFVSchoolMaster add 	backtotalpoint			bigint				default(0)
alter table dbo.tFVSchoolMaster add 	backschoolrank			int					default(-1)
update dbo.tFVSchoolMaster set backcnt = cnt, backtotalpoint = totalpoint, backschoolrank = -1	-- 12,222 0초
--select top 10 * from dbo.tFVSchoolMaster where backcnt is null


alter table dbo.tFVSchoolUser add 	backdateid				varchar(8)			default('20100101')
alter table dbo.tFVSchoolUser add 	backschoolidx			int					default(-1)
alter table dbo.tFVSchoolUser add 	backschoolrank			int					default(-1)
alter table dbo.tFVSchoolUser add 	backuserrank			int					default(-1)
alter table dbo.tFVSchoolUser add 	backpoint				bigint				default(0)
alter table dbo.tFVSchoolUser add 	backitemcode			int					default(1)
alter table dbo.tFVSchoolUser add 	backacc1				int					default(-1)
alter table dbo.tFVSchoolUser add 	backacc2 				int					default(-1)
alter table dbo.tFVSchoolUser add 	backitemcode1			int					default(-1)
alter table dbo.tFVSchoolUser add 	backitemcode2			int					default(-1)
alter table dbo.tFVSchoolUser add 	backitemcode3			int					default(-1)
--select top 10 * from dbo.tFVSchoolUser where backdateid is null
--> **** 지난 정보를 읽어서 > cursor > 한개씩 찾아서 넣어주기.
-- update dbo.tFVSchoolUser set backdateid = '20100101', backschoolidx =schoolidx, backschoolrank =schoolrank, backuserrank =userrank, backpoint =point, backitemcode =itemcode, backacc1 =acc1, backacc2 =acc2, backitemcode1 =itemcode1,backitemcode2 =itemcode2, backitemcode3   =itemcode3
-- 447,907(0초)
-- update dbo.tFVSchoolUser set backdateid = '20100101', backschoolidx =-1, backschoolrank =-1, backuserrank =-1, backpoint =0, backitemcode =1, backacc1 =-1, backacc2 =-1, backitemcode1 =-1,backitemcode2 =-1, backitemcode3   =-1
--select MAX(idx) from dbo.tFVSchoolBackMaster 		-- 320		113
--select MAX(idx) from dbo.tFVSchoolBackUser 			-- 77916	447933
--select MAX(schoolidx) from dbo.tFVSchoolBank 		-- 77916	12231
--select MAX(idx) from dbo.tFVSchoolMaster 			-- 12233	12225
--select MAX(idx) from dbo.tFVSchoolUser 				-- 68793	447935
--select top 10 * from dbo.tFVSchoolUser
*/
/*
-----------------------------------------
-- 유저 대표 동물 랭킹에 참조하게 세팅
-- > 시간이 많이 걸림 ㅎㅎㅎ 프로세서를 잡아먹는듯함.
-- Test server : 6분 17초
-- Real Server : 10분 44초 (정말 오래 걸린다. ㅠㅠ)
-----------------------------------------
declare @gameid				varchar(60),
		@anireplistidx		int,
		@anirepitemcode		int,
		@anirepacc1			int,
		@anirepacc2			int

declare curSchoolUserAir Cursor for
select gameid, anireplistidx from dbo.tFVUserMaster where gameid in (select gameid from dbo.tFVSchoolUser)

-- 2. 커서오픈
open curSchoolUserAir

-- 3. 커서 사용
Fetch next from curSchoolUserAir into @gameid, @anireplistidx
while @@Fetch_status = 0
	Begin
		select
			@anirepitemcode	= itemcode,
			@anirepacc1		= acc1,
			@anirepacc2		= acc2
		from dbo.tFVUserItem
		where gameid = @gameid and listidx = @anireplistidx

		update dbo.tFVSchoolUser
			set
				itemcode= @anirepitemcode,
				acc1	= @anirepacc1,
				acc2	= @anirepacc2
		where gameid = @gameid

		--select 'DEBUG ', @gameid gameid, @anireplistidx anireplistidx, @anirepitemcode anirepitemcode, @anirepacc1 anirepacc1, @anirepacc2 anirepacc2
		Fetch next from curSchoolUserAir into @gameid, @anireplistidx
	end

-- 4. 커서닫기
close curSchoolUserAir
Deallocate curSchoolUserAir
*/

/*
------------------------------------------------------
-- select top 10 * from dbo.tFVSchoolBackUser order by idx desc
-- select top 10 * from dbo.tFVSchoolUser order by idx desc
-- select count(*) from dbo.tFVSchoolBackUser where dateid = '20140518'
-- > 시간이 많이 걸림 ㅎㅎㅎ 프로세서를 잡아먹는듯함.
-- 지난것 -> 학교 랭킹 정리데이타
-- Test server : 3분 35초
-- Real Server : 2분 2초
------------------------------------------------------
declare @gameid					varchar(20),
		@backdateid				varchar(8),
		@backschoolidx			int,
		@backschoolrank			int,
		@backuserrank			int,
		@backpoint				bigint,
		@backitemcode			int,
		@backacc1				int,
		@backacc2 				int,
		@backitemcode1			int,
		@backitemcode2			int,
		@backitemcode3			int

declare curSchoolBackUser Cursor for
select gameid, dateid, schoolidx, schoolrank, userrank, point, itemcode, acc1, acc2, itemcode1, itemcode2, itemcode3 from dbo.tFVSchoolBackUser where dateid = '20140518'

-- 2. 커서오픈
open curSchoolBackUser

-- 3. 커서 사용
Fetch next from curSchoolBackUser into @gameid, @backdateid, @backschoolidx, @backschoolrank, @backuserrank, @backpoint, @backitemcode, @backacc1, @backacc2, @backitemcode1, @backitemcode2, @backitemcode3
while @@Fetch_status = 0
	Begin
		update dbo.tFVSchoolUser
			set
				backdateid		= @backdateid,
				backschoolidx	= @backschoolidx,
				backschoolrank	= @backschoolrank,
				backuserrank	= @backuserrank,
				backpoint		= @backpoint,
				backitemcode	= @backitemcode,
				backacc1		= @backacc1,
				backacc2		= @backacc2,
				backitemcode1	= @backitemcode1,
				backitemcode2	= @backitemcode2,
				backitemcode3	= @backitemcode3
		where gameid = @gameid
		Fetch next from curSchoolBackUser into @gameid, @backdateid, @backschoolidx, @backschoolrank, @backuserrank, @backpoint, @backitemcode, @backacc1, @backacc2, @backitemcode1, @backitemcode2, @backitemcode3
	end

-- 4. 커서닫기
close curSchoolBackUser
Deallocate curSchoolBackUser
*/


/*
select max(idx) from dbo.tFVSchoolUser
alter table dbo.tFVUserMaster add 	eventspot06		int					default(0)
alter table dbo.tFVUserMaster add 	eventspot07		int					default(0)
alter table dbo.tFVUserMaster add 	eventspot08		int					default(0)
alter table dbo.tFVUserMaster add 	eventspot09		int					default(0)
alter table dbo.tFVUserMaster add 	eventspot10		int					default(0)

update dbo.tFVUserMaster set eventspot06 = 0, eventspot07 = 0, eventspot08 = 0, eventspot09 = 0, eventspot10 = 0
*/

/*
---------------------------------------------
-- 2. 학교 정보 강제로 가입시키기
---------------------------------------------
-- 학교 랭킹 정리데이타
declare @schoolidx		int,
		@gameid			varchar(20),
		@password		varchar(20),
		@loop 			int,
		@idx			int

declare curSchoolJoin Cursor for
select idx, gameid, password from dbo.tFVUserMaster where schoolidx = -1
set @loop 		= 0
set @schoolidx 	= 100

-- 2. 커서오픈
open curSchoolJoin

-- 3. 커서 사용
Fetch next from curSchoolJoin into @idx, @gameid, @password
while @@Fetch_status = 0
	Begin
		select @idx idx, @loop loop, @gameid gameid, @password password, @schoolidx schoolidx
		--if(@loop > 5)break;
		if(@loop % 100 = 0)
			begin
				select @schoolidx = schoolidx from dbo.tFVSchoolMaster order by newid()
			end
		exec spu_FVSchoolInfo @gameid, @password, 2, @schoolidx, '', -1			-- 가입모드

		set @loop = @loop + 1
		Fetch next from curSchoolJoin into @idx, @gameid, @password
	end

-- 4. 커서닫기
close curSchoolJoin
Deallocate curSchoolJoin
*/

/*
-- 카운터 통계
insert into dbo.tFVtt(dateid, cnt)
select regdate, count(*) from
(select CONVERT(CHAR(19), regdate, 20) regdate from dbo.tFVUserMaster) t
group by regdate
order by regdate desc

select * from ttt order by dateid desc
select * from ttt order by cnt desc
*/

/*
-- 일반결과
update dbo.tFVUserMaster set tradecnt = 100, tradecntold = 99 where gameid = 'xxxx2'
--update dbo.tFVUserMaster set tradecnt = 0, tradecntold = 100 where gameid = 'xxxx2'
--update dbo.tFVUserMaster set tradecnt = 100, tradecntold = 0 where gameid = 'xxxx2'

update dbo.tFVUserMaster set gameyear = 2013, gamemonth = 3, frametime = 0, etsalecoin = 1000, fame = 5, famelv = 2, etremain = -1 , gamecost = 0, cashcost = 0, feed = 0, heart = 0 where gameid = 'xxxx2'
update dbo.tFVSchoolMaster set totalpoint = 0 where schoolidx = (select schoolidx from dbo.tFVUserMaster where gameid = 'xxxx2')
update dbo.tFVSchoolUser set point = 0 where gameid = 'xxxx2'		delete from dbo.tFVUserSaleLog where gameid = 'xxxx2'		delete from dbo.tFVGiftList where gameid = 'xxxx2'			delete from dbo.tFVEpiReward where gameid = 'xxxx2' delete from dbo.tFVUserSaveLog where gameid = 'xxxx2'
exec spu_FVGameTrade 'xxxx2', '049000s1i0n7t8445289', '0:2013;  1:4;      2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:16;    43:1;', '',	'',
	'0:5; 1:1;   10:103;    11:1;    12:75;    20:10;    30:1;      31:10;    32:1;         33:7;     34:20;    35:77;  40:-1;',
	'', -1										-- 필드없음.
select tradecnt, tradecntold from dbo.tFVUserMaster where gameid = 'xxxx2'
*/

/*
select gameid, comment, writedate from dbo.tFVUserUnusualLog2
select distinct gameid, comment from dbo.tFVUserUnusualLog2
*/
/*
-------------------------------------------
-- 아이템 지급
-------------------------------------------
exec spu_FVSubGiftSend 2,   700, 'SysLogin', 'xxxx2', ''				-- 총알
exec spu_FVSubGiftSend 2,   800, 'SysLogin', 'xxxx2', ''				-- 치료제
exec spu_FVSubGiftSend 2,  1000, 'SysLogin', 'xxxx2', ''				-- 일꾼
exec spu_FVSubGiftSend 2,  1100, 'SysLogin', 'xxxx2', ''				-- 촉진제
exec spu_FVSubGiftSend 2,  1200, 'SysLogin', 'xxxx2', ''				-- 부활석
exec spu_FVSubGiftSend 2,  5200, 'SysLogin', 'xxxx2', ''				-- 뽑기
exec spu_FVSubGiftSend 2,  2100, 'SysLogin', 'xxxx2', ''				-- 긴급요청티켓
exec spu_FVSubGiftSend 2,  2207, 'SysLogin', 'xxxx2', ''				-- 일반교배뽑기
exec spu_FVSubGiftSend 2,  2300, 'SysLogin', 'xxxx2', ''				-- 프리미엄교배뽑기

-------------------------------------------
-- 테스트 서버
-------------------------------------------
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 4195, -1, -1, -1, -1	-- 프리미엄교배뽑기
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 4187, -1, -1, -1, -1	--
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 4188, -1, -1, -1, -1	--
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 4189, -1, -1, -1, -1	--
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 4190, -1, -1, -1, -1	--
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 4191, -1, -1, -1, -1	--
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 4192, -1, -1, -1, -1	--
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 4193, -1, -1, -1, -1	--
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 4194, -1, -1, -1, -1	--


-------------------------------------------
-- 테스트 서버 저장
-------------------------------------------
-- delete from dbo.tFVUserUnusualLog2 where gameid = 'xxxx2'
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 7		-- 낡은 공포탄(700)	 4	소모품(3)	기본(0)	2014-03-27 17:02	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 16	-- 아주 작은 치료제(800)	 1	소모품(3)	선물(5)	2014-05-14 11:10	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 9		-- 알바의 귀재(1002)	 3	소모품(3)	기본(0)	2014-03-27 17:02	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 10	-- 아주 작은 촉진제(1100)	 4	소모품(3)	기본(0)	2014-03-27 17:02	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 11	-- 부활석(1200)	 6	소모품(3)	기본(0)	2014-03-27 17:02	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 18	-- 긴급요청 티켓(2100)	 1	소모품(3)	선물(5)	2014-05-14 11:10	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 19	-- 일반 교배 티켓(2200)	 99	소모품(3)	선물(5)	2014-05-14 11:10	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 15	-- 프리미엄 교배 티켓(2300)	 1	소모품(3)	선물(5)	2014
update dbo.tFVUserMaster set gameyear = 2013, gamemonth = 3, frametime = 0 where gameid = 'xxxx2'
update dbo.tFVUserMaster set gamecost = 1000, cashcost = 1000, feed = 1000, heart = 1000 where gameid = 'xxxx2'
exec spu_FVGameSave 'xxxx2', '049000s1i0n7t8445289', '0:2013;  1:3;      2:13;     4:4;       10:11;       11:101;     12:21;     13:201;   30:16;  40:-1;     41:-1;  42:-1;     43:1;     44:-1;        45:-1;',
													'1:5,1,1;3:5,23,0;4:5,25,-1;',
													--'7:1;16:1;9:1;10:1;11:1;18:1;19:1;15:1;',	-- 보유 1개 > 1개 정상사용
													'7:2;16:2;9:2;10:2;11:2;18:2;19:2;15:2;',	-- 보유 1개 > 2개 오류필터
													'0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;',
													-1										-- 필드없음.

-------------------------------------------
-- 테스트 서버 거래
-------------------------------------------
-- delete from dbo.tFVUserUnusualLog2
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 7		-- 낡은 공포탄(700)	 4	소모품(3)	기본(0)	2014-03-27 17:02	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 16	-- 아주 작은 치료제(800)	 1	소모품(3)	선물(5)	2014-05-14 11:10	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 9		-- 알바의 귀재(1002)	 3	소모품(3)	기본(0)	2014-03-27 17:02	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 10	-- 아주 작은 촉진제(1100)	 4	소모품(3)	기본(0)	2014-03-27 17:02	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 11	-- 부활석(1200)	 6	소모품(3)	기본(0)	2014-03-27 17:02	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 18	-- 긴급요청 티켓(2100)	 1	소모품(3)	선물(5)	2014-05-14 11:10	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 19	-- 일반 교배 티켓(2200)	 99	소모품(3)	선물(5)	2014-05-14 11:10	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 15	-- 프리미엄 교배 티켓(2300)	 1	소모품(3)	선물(5)	2014
update dbo.tFVUserMaster set gameyear = 2013, gamemonth = 3, frametime = 0, etsalecoin = 1000, fame = 5, famelv = 2, tradecnt = 1, prizecnt = 1, etremain = -1 where gameid = 'xxxx2'
update dbo.tFVUserMaster set gamecost = 0, cashcost = 0, feed = 0, heart = 0 where gameid = 'xxxx2'
update dbo.tFVSchoolMaster set totalpoint = 0 where schoolidx = (select schoolidx from dbo.tFVUserMaster where gameid = 'xxxx2')
update dbo.tFVSchoolUser set point = 0 where gameid = 'xxxx2'
delete from dbo.tFVUserSaleLog where gameid = 'xxxx2'
delete from dbo.tFVGiftList where gameid = 'xxxx2'
delete from dbo.tFVEpiReward where gameid = 'xxxx2'
exec spu_FVGameTrade 'xxxx2', '049000s1i0n7t8445289', '0:2013;  1:4;      2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:16;    43:1;',
													'1:5,1,1;3:5,23,0;4:5,25,-1;',
													--'7:1;16:1;9:1;10:1;11:1;18:1;19:1;15:1;',	-- 보유 1개 > 1개 정상사용
													'7:2;16:2;9:2;10:2;11:2;18:2;19:2;15:2;',	-- 보유 1개 > 2개 오류필터
													'0:5; 1:2;   10:2;    11:1;    12:75;    20:10;    30:1;      31:10;    32:1;         33:7;     34:20;    35:77;  40:-1;',
													'0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;',
													-1										-- 필드없음.

-------------------------------------------
-- 실서버 받기
-------------------------------------------
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 10803211, -1, -1, -1, -1	-- 프리미엄교배뽑기
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 10803209, -1, -1, -1, -1	--
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 10803210, -1, -1, -1, -1	--
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 10803208, -1, -1, -1, -1	--
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 10803207, -1, -1, -1, -1	--
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 10803205, -1, -1, -1, -1	--
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 10803204, -1, -1, -1, -1	--
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 10803203, -1, -1, -1, -1	--
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 10803202, -1, -1, -1, -1	--


-------------------------------------------
-- 테스트 서버 저장
-------------------------------------------
-- delete from dbo.tFVUserUnusualLog2 where gameid = 'xxxx2'
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 7		-- 낡은 공포탄(700)	 4	소모품(3)	기본(0)	2014-03-27 17:02	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 8		-- 아주 작은 치료제(800)	 1	소모품(3)	선물(5)	2014-05-14 11:10	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 9		-- 알바의 귀재(1002)	 3	소모품(3)	기본(0)	2014-03-27 17:02	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 10	-- 아주 작은 촉진제(1100)	 4	소모품(3)	기본(0)	2014-03-27 17:02	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 11	-- 부활석(1200)	 6	소모품(3)	기본(0)	2014-03-27 17:02	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 15	-- 긴급요청 티켓(2100)	 1	소모품(3)	선물(5)	2014-05-14 11:10	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 16	-- 일반 교배 티켓(2200)	 99	소모품(3)	선물(5)	2014-05-14 11:10	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 14	-- 프리미엄 교배 티켓(2300)	 1	소모품(3)	선물(5)	2014
update dbo.tFVUserMaster set gameyear = 2013, gamemonth = 3, frametime = 0 where gameid = 'xxxx2'
update dbo.tFVUserMaster set gamecost = 1000, cashcost = 1000, feed = 1000, heart = 1000 where gameid = 'xxxx2'
exec spu_FVGameSave 'xxxx2', '049000s1i0n7t8445289', '0:2013;  1:3;      2:13;     4:4;       10:11;       11:101;     12:21;     13:201;   30:16;  40:-1;     41:-1;  42:-1;     43:1;     44:-1;        45:-1;',
													'1:5,1,1;3:5,23,0;4:5,25,-1;',
													--'7:1;16:1;9:1;10:1;11:1;18:1;19:1;15:1;',	-- 보유 1개 > 1개 정상사용
													'7:2;8:2;9:2;10:2;11:2;15:2;16:2;14:2;',	-- 보유 1개 > 2개 오류필터
													'0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;',
													-1										-- 필드없음.

-------------------------------------------
-- 테스트 서버 거래
-------------------------------------------
-- delete from dbo.tFVUserUnusualLog2
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 7		-- 낡은 공포탄(700)	 4	소모품(3)	기본(0)	2014-03-27 17:02	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 8		-- 아주 작은 치료제(800)	 1	소모품(3)	선물(5)	2014-05-14 11:10	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 9		-- 알바의 귀재(1002)	 3	소모품(3)	기본(0)	2014-03-27 17:02	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 10	-- 아주 작은 촉진제(1100)	 4	소모품(3)	기본(0)	2014-03-27 17:02	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 11	-- 부활석(1200)	 6	소모품(3)	기본(0)	2014-03-27 17:02	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 15	-- 긴급요청 티켓(2100)	 1	소모품(3)	선물(5)	2014-05-14 11:10	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 16	-- 일반 교배 티켓(2200)	 99	소모품(3)	선물(5)	2014-05-14 11:10	-1	인벤토리(-1)	5	25	 노질병(0)	생존(-1)		 null	-1	-1		개발삭제
update dbo.tFVUserItem set cnt = 1 where gameid = 'xxxx2' and listidx = 14	-- 프리미엄 교배 티켓(2300)	 1	소모품(3)	선물(5)	2014
update dbo.tFVUserMaster set gameyear = 2013, gamemonth = 3, frametime = 0, etsalecoin = 1000, fame = 5, famelv = 2, tradecnt = 1, prizecnt = 1, etremain = -1 where gameid = 'xxxx2'
update dbo.tFVUserMaster set gamecost = 0, cashcost = 0, feed = 0, heart = 0 where gameid = 'xxxx2'
update dbo.tFVSchoolMaster set totalpoint = 0 where schoolidx = (select schoolidx from dbo.tFVUserMaster where gameid = 'xxxx2')
update dbo.tFVSchoolUser set point = 0 where gameid = 'xxxx2'
delete from dbo.tFVUserSaleLog where gameid = 'xxxx2'
delete from dbo.tFVGiftList where gameid = 'xxxx2'
delete from dbo.tFVEpiReward where gameid = 'xxxx2'
exec spu_FVGameTrade 'xxxx2', '049000s1i0n7t8445289', '0:2013;  1:4;      2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:16;    43:1;',
													'1:5,1,1;3:5,23,0;4:5,25,-1;',
													--'7:1;16:1;9:1;10:1;11:1;18:1;19:1;15:1;',	-- 보유 1개 > 1개 정상사용
													'7:2;8:2;9:2;10:2;11:2;15:2;16:2;14:2;',	-- 보유 1개 > 2개 오류필터
													'0:5; 1:2;   10:2;    11:1;    12:75;    20:10;    30:1;      31:10;    32:1;         33:7;     34:20;    35:77;  40:-1;',
													'0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;',
													-1										-- 필드없음.
*/

/*
insert into dbo.tFVUserUnusualLog(gameid, comment, writedate, chkstate, chkdate, chkcomment)
select gameid, comment, writedate, chkstate, chkdate, chkcomment from dbo.tFVUserUnusualLog2 where idx >= 36 and idx <= 37
delete from dbo.tFVUserUnusualLog2 where idx >= 36 and idx <= 37

insert into dbo.tFVUserUnusualLog2(gameid, comment, writedate, chkstate, chkdate, chkcomment)
select gameid, comment, writedate, chkstate, chkdate, chkcomment from dbo.tFVUserUnusualLog where idx = 142
delete from dbo.tFVUserUnusualLog where idx = 142
*/

/*
---------------------------------------------
--	비정삭적인2 행동을 할려고 하는 유저체킹 > 블럭처리
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserUnusualLog2', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserUnusualLog2;
GO

create table dbo.tFVUserUnusualLog2(
	idx				int				IDENTITY(1,1),
	gameid			varchar(20), 							-- 행동자
	comment			varchar(512), 							-- 비정상내용
	writedate		datetime		default(getdate()), 	-- 비정상작성일

	chkstate		int				default(0),				-- 확인상태(0:체킹안함, 1:체킹함)
	chkdate			datetime,
	chkcomment		varchar(512), 							-- 확인내용

	-- Constraint
	CONSTRAINT pk_tUserUnusualLog2_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserUnusualLog2_gameid_idx')
    DROP INDEX tFVUserUnusualLog2.idx_tFVUserUnusualLog2_gameid_idx
GO
CREATE INDEX idx_tFVUserUnusualLog2_gameid_idx ON tUserUnusualLog2(gameid, idx)
GO
-- insert into dbo.tFVUserUnusualLog2(gameid, comment) values('x1', '캐쉬카피시도')
-- insert into dbo.tFVUserUnusualLog2(gameid, comment) values('x1', '환전카피시도')
-- insert into dbo.tFVUserUnusualLog2(gameid, comment) values('x2', '결과조작')
-- select top 20 * from dbo.tFVUserUnusualLog2 order by idx desc
-- select top 20 * from dbo.tFVUserUnusualLog2 where gameid = 'sususu' order by idx desc
*/


-- 거래 시간
--  거래 단시간 치트방지.
--	tradecnt		int					default(0),				--거래 게임시간과 실시간.
--	tradetime		datetime			default(getdate()),


/*
alter table dbo.tFVDayLogInfoStatic add kakaoheartcnt	int				default(0)
alter table dbo.tFVDayLogInfoStatic add kakaohelpcnt	int				default(0)

update dbo.tFVDayLogInfoStatic set kakaoheartcnt = 0, kakaohelpcnt = 0
*/


/*

---------------------------------------------
-- 이벤트 진행 정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSysEventInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSysEventInfo;
GO

create table dbo.tFVSysEventInfo(
	idx					int 				IDENTITY(1, 1),

	adminid				varchar(20),
	state				int					default(0),				-- 대기중[0], 진행중[1], 완료[2]
	startdate			varchar(16),								-- 2014-05-05 10:00
	enddate				varchar(16),
	company				int					default(0),				-- 상상디지탈(0), 픽토소프트(1)
	title				varchar(256)		default(''),
	comment				varchar(4096)		default(''),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSysEventInfo_idx	PRIMARY KEY(idx)
)
-- insert into dbo.tFVSysEventInfo(adminid, state, startdate, enddate, company, title, comment) values('blackm', 0, '2014-05-12 00:00', '2014-05-12 23:59', 0, '이벤트제목', '이벤트내용')
-- update dbo.tFVSysEventInfo set state = 1, startdate = '2014-05-12 00:00', enddate = '2014-05-12 23:59', company = 0, title = '이벤트제목', comment = '이벤트내용' where idx = 1
-- select top 10 * from dbo.tFVSysEventInfo order by idx desc
*/


/*
declare @TRADEINFO_TANKLITTLE_GAP			int					set @TRADEINFO_TANKLITTLE_GAP				= 29
declare @tanklittle2		int,	@tanklittlemax		int
set @tanklittle2	= 394
set @tanklittlemax	= 390

if(@tanklittle2 > @tanklittlemax + @TRADEINFO_TANKLITTLE_GAP)
	BEGIN
		select 'DEBUG *** 초과', @tanklittle2 tanklittle2, @tanklittlemax tanklittlemax
	END
else
	BEGIN
		select 'DEBUG    유효', @tanklittle2 tanklittle2, @tanklittlemax tanklittlemax
	END
*/


/*
select top 10 * from dbo.tFVUserItemDieLog order by idx desc
select top 10 * from dbo.tFVUserItemAliveLog order by idx desc
-- exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 4020, -1, -1, -1, -1	-- 소	(인벤)

exec spu_FVAniDie 'xxxx2', '049000s1i0n7t8445289', 1, 1, -1		-- 눌러 죽음.
exec spu_FVAniDie 'xxxx2', '049000s1i0n7t8445289', 2, 2, -1		-- 늑대 죽음.
exec spu_FVAniDie 'xxxx2', '049000s1i0n7t8445289', 3, 14, -1		-- 터져 죽음.
select top 10 * from dbo.tFVUserItemDieLog order by idx desc
select top 10 * from dbo.tFVUserItemAliveLog order by idx desc

exec spu_FVAniRevival 'xxxx2', '049000s1i0n7t8445289', 1, 1, 1, -1		-- 2013년 무료부활
exec spu_FVAniRevival 'xxxx2', '049000s1i0n7t8445289', 1, 2, 2, -1		-- 2013년 무료부활
exec spu_FVAniRevival 'xxxx2', '049000s1i0n7t8445289', 2, 14, 4, -1		-- 2013년 무료부활
select top 10 * from dbo.tFVUserItemDieLog order by idx desc
select top 10 * from dbo.tFVUserItemAliveLog order by idx desc

select top 10 * from dbo.tFVUserItemDieLog where gameid = 'farm83837225'
select top 10 * from dbo.tFVUserItemAliveLog where gameid = 'farm83837225'
*/

/*
---------------------------------------------
--		아이템 (동물죽음 로그)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserItemDieLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserItemDieLog;
GO

create table dbo.tFVUserItemDieLog(
	idx				bigint					IDENTITY(1,1),

	gameid			varchar(20),									--
	listidx			int,											-- 리스트인덱스(각개인별로 별개)

	invenkind		int					default(1),					--대분류(가축(1), 소모품(3), 액세서리(4))
	itemcode		int,
	cnt				int					default(1),					--보유량

	farmnum			int					default(-1),				-- 농장번호(-1:농장없음, 0~50:농장번호)
	fieldidx		int					default(-1),				-- 필드(-2:병원, -1:창고, 0~8:필드)
	anistep			int					default(5),					-- 현재단계(0 ~ 12단계)
	manger			int					default(25),				-- 여물통(건초:1 > 여물:20)
	diseasestate	int					default(0),					-- 질병상태(0:노질병, 질병 >=0 걸림)
	acc1			int					default(-1),				-- 악세(모자:아이템코드)
	acc2			int					default(-1),				-- 악세(등:아이템코드)
	abilkind		int					default(-1),				--능력치종류1~5 (90001:신선도, 90002:추가 생산 확률, 90003:피버 드랍 확률, 90004:질병 저항력, 90005;코인 드랍 확률)
	abilval			int					default(0),					--능력치값1~5
	abilkind2		int					default(-1),				--
	abilval2		int					default(0),					--
	abilkind3		int					default(-1),				--
	abilval3		int					default(0),					--
	abilkind4		int					default(-1),				--
	abilval4		int					default(0),					--
	abilkind5		int					default(-1),				--
	abilval5		int					default(0),					--

	randserial		varchar(20)			default('-1'),				--랜던씨리얼(클라이언트에서 만들어서옴)
	writedate		datetime			default(getdate()),			--구매일/획득일
	gethow			int					default(0),					--획득방식(0:구매, 1:경작, 2:교배/뽑기, 3:검색)

	diedate			datetime			default(getdate()),
	diemode			int					default(-1),				-- -1:아님, 1:눌러,텨저, 2:늑대
	needhelpcnt		int					default(0),					-- 병원에 있을때 자동 부활용으로 사용된다.(부활석 개수만큼)

	petupgrade		int					default(1),					-- 펫업그레이드 하기.

	-- Constraint
	CONSTRAINT	pk_tUserItemDieLog_idx	PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItemDieLog_idx_gameid')
    DROP INDEX tFVUserItemDieLog.idx_tFVUserItemDieLog_idx_gameid
GO
CREATE INDEX idx_tFVUserItemDieLog_idx_gameid ON tUserItemDieLog (idx, gameid)
GO
-- insert into dbo.tFVUserItem(gameid, listidx, invenkind, itemcode, cnt, farmnum, fieldidx, anistep, manger, diseasestate, acc1, acc2, abilkind, abilval, abilkind2, abilval2, abilkind3, abilval3, abilkind4, abilval4, abilkind5, abilval5, randserial, writedate, gethow, diedate, diemode, needhelpcnt, petupgrade) values('xxxx', 0, 1, 1, 0, 0, 1, 1001) -- 동물
-- select top 10 * from dbo.tFVUserItemDieLog order by idx desc
-- select top 10 * from dbo.tFVUserItemDieLog where gameid = 'xxxx2' order by idx desc

---------------------------------------------
--		아이템 (동물죽음 로그)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserItemAliveLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserItemAliveLog;
GO

create table dbo.tFVUserItemAliveLog(
	idx				bigint					IDENTITY(1,1),

	gameid			varchar(20),									--
	listidx			int,											-- 리스트인덱스(각개인별로 별개)

	invenkind		int					default(1),					--대분류(가축(1), 소모품(3), 액세서리(4))
	itemcode		int,
	cnt				int					default(1),					--보유량

	farmnum			int					default(-1),				-- 농장번호(-1:농장없음, 0~50:농장번호)
	fieldidx		int					default(-1),				-- 필드(-2:병원, -1:창고, 0~8:필드)
	anistep			int					default(5),					-- 현재단계(0 ~ 12단계)
	manger			int					default(25),				-- 여물통(건초:1 > 여물:20)
	diseasestate	int					default(0),					-- 질병상태(0:노질병, 질병 >=0 걸림)
	acc1			int					default(-1),				-- 악세(모자:아이템코드)
	acc2			int					default(-1),				-- 악세(등:아이템코드)
	abilkind		int					default(-1),				--능력치종류1~5 (90001:신선도, 90002:추가 생산 확률, 90003:피버 드랍 확률, 90004:질병 저항력, 90005;코인 드랍 확률)
	abilval			int					default(0),					--능력치값1~5
	abilkind2		int					default(-1),				--
	abilval2		int					default(0),					--
	abilkind3		int					default(-1),				--
	abilval3		int					default(0),					--
	abilkind4		int					default(-1),				--
	abilval4		int					default(0),					--
	abilkind5		int					default(-1),				--
	abilval5		int					default(0),					--

	randserial		varchar(20)			default('-1'),				--랜던씨리얼(클라이언트에서 만들어서옴)
	writedate		datetime			default(getdate()),			--구매일/획득일
	gethow			int					default(0),					--획득방식(0:구매, 1:경작, 2:교배/뽑기, 3:검색)

	diedate			datetime,
	diemode			int					default(-1),				-- -1:아님, 1:눌러,텨저, 2:늑대
	needhelpcnt		int					default(0),					-- 병원에 있을때 자동 부활용으로 사용된다.(부활석 개수만큼)

	petupgrade		int					default(1),					-- 펫업그레이드 하기.

	alivedate		datetime			default(getdate()),
	alivecash		int					default(0),
	alivedoll		int					default(0),

	-- Constraint
	CONSTRAINT	pk_tUserItemAliveLog_idx	PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItemAliveLog_idx_gameid')
    DROP INDEX tFVUserItemAliveLog.idx_tFVUserItemAliveLog_idx_gameid
GO
CREATE INDEX idx_tFVUserItemAliveLog_idx_gameid ON tUserItemAliveLog (idx, gameid)
GO
-- select top 10 * from dbo.tFVUserItemAliveLog order by idx desc
-- select top 10 * from dbo.tFVUserItemAliveLog where gameid = 'xxxx2' order by idx desc
*/

/*
---------------------------------------------
--	Push Send Info
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPushSendInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPushSendInfo;
GO

create table dbo.tFVUserPushSendInfo(
	idx				int				identity(1, 1),

	adminid			varchar(20),
	sendkind		int,
	market			int,

	msgtitle		varchar(512),
	msgmsg			varchar(512),

	cnt				int				default(0),
	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserPushSendInfo_idx	PRIMARY KEY(idx)
)
-- select top 10 * from dbo.tFVUserPushSendInfo order by idx desc
-- insert into dbo.tFVUserPushSendInfo(adminid,  sendkind, market, msgtitle, msgmsg,  cnt)
-- values(				       	   @adminid,      @p3_,   @p4_,    @ps3_,  @ps4_, @cnt)
-- select max(idx), min(idx) from dbo.tFVUserPushiPhone
-- select max(idx), min(idx) from dbo.tFVUserPushAndroid
-- select distinct msgtitle, msgmsg from dbo.tFVUserPushiPhone
-- select distinct msgtitle, msgmsg from dbo.tFVUserPushAndroid
-- select top 10 * from dbo.tFVUserPushiPhone where msgtitle = '제목 iPhone'
-- select top 10 * from dbo.tFVUserPushAndroid where msgtitle = '제목 Google'
-- 삭제
-- delete from dbo.tFVUserPushiPhone  where msgtitle = '제목 iPhone'
-- delete from dbo.tFVUserPushAndroid where msgtitle = '제목 Google'
-- delete from dbo.tFVUserPushiPhone  where msgtitle = (select msgtitle from dbo.tFVUserPushSendInfo where idx = 1)
-- delete from dbo.tFVUserPushAndroid  where msgtitle = (select msgtitle from dbo.tFVUserPushSendInfo where idx = 1)
*/

/*
select * from dbo.tFVDayLogInfoStatic where dateid8 = '20140508'

-- update dbo.tFVDayLogInfoStatic set invitekakao = 12946 where dateid8 = '20140508' and market = 1
-- update dbo.tFVDayLogInfoStatic set invitekakao = 640207 where dateid8 = '20140508' and market = 5
-- update dbo.tFVDayLogInfoStatic set invitekakao = 96225 where dateid8 = '20140508' and market = 7
-- select market, SUM(kakaomsginvitecnt) from dbo.tFVUserMaster group by market
--	1	12946
--	2	0
--	3	0
--	5	640207
--	7	96225

select top 10 gameid, kakaomsginvitecnt, kakaomsginvitetodaycnt from dbo.tFVUserMaster where kakaomsginvitecnt >= 40
select count(*) from dbo.tFVUserMaster where kakaomsginvitecnt >= 40	7824
select count(*) from dbo.tFVUserMaster where kakaomsginvitecnt >= 50	1459
select count(*) from dbo.tFVUserMaster where kakaomsginvitecnt >= 60	1016
select count(*) from dbo.tFVUserMaster where kakaomsginvitecnt >= 70	440
select count(*) from dbo.tFVUserMaster where kakaomsginvitecnt >= 80	303
select count(*) from dbo.tFVUserMaster where kakaomsginvitecnt >= 90	251
select count(*) from dbo.tFVUserMaster where kakaomsginvitecnt >= 100	127
*/

/*
update dbo.tFVUserMaster set eventspot02 = 0, eventspot03 = 0, eventspot04 = 0
*/

/*
alter table dbo.tFVDayLogInfoStatic add invitekakao		int				default(0)

update dbo.tFVDayLogInfoStatic set invitekakao = 0
*/

/*
--select gameid, fame, famelv, gameyear, gamemonth from dbo.tFVUserMaster where famelv >= 50 and blockstate = 0 order by gameyear asc
*/
/*

--update dbo.tFVUserMaster set resultcopy= 0, cashcopy = 0, blockstate = 0 where gameid = 'xxxx2'


--userinfo=gameyear;gamemonth;frametime;fevergauge;bottlelittle;bottlefresh;tanklittle;tankfresh;feeduse;wolfkillcnt;
--         0:2013;  1:4;      2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:3;   43:1;
--aniitem=listidx:anistep,manger,diseasestate; (인벤[O], 필드[O], 병원[X])
--		1:5,24,1;		--> 자체분리 	> 4 : 5, 25, 0
--		4:5,25,0;		--> 동물병원 	> 자체필터.
--cusitem=listidx:usecnt;
--		14:1;
--		16:1;			--> 악세사리(자동필터)
--paraminfo=param0:value0
----		2:0;			--> 파라미터데이타
--tradeinfo=fame:famelv:tradecnt:prizecnt:prizecoin:playcoin:saletrader:saledanga:saleplusdanga:salebarrel:salefresh:salecoin:saleitemcode;plusheart;orderbarrel;orderfresh;
--		  0:5; 1:2;   10:1;    11:1;    12:75;    20:1;    30:1;      31:10;    32:1;         33:10;     34:20;    35:110;  40:-1;		 50:0;     51:10;      52:40;

update dbo.tFVUserMaster set gameyear = 2013, gamemonth = 3, frametime = 0, etsalecoin = 1000, fame = 5, famelv = 2, tradecnt = 1, prizecnt = 1, etremain = -1 where gameid = 'xxxx2'
update dbo.tFVUserMaster set gamecost = 0, cashcost = 0, feed = 0, heart = 0 where gameid = 'xxxx2'
update dbo.tFVSchoolMaster set totalpoint = 0 where schoolidx = (select schoolidx from dbo.tFVUserMaster where gameid = 'xxxx2')
update dbo.tFVSchoolUser set point = 0 where gameid = 'xxxx2'
delete from dbo.tFVUserSaleLog where gameid = 'xxxx2'
delete from dbo.tFVGiftList where gameid = 'xxxx2'
delete from dbo.tFVEpiReward where gameid = 'xxxx2'
exec spu_FVGameTrade 'xxxx2', '049000s1i0n7t8445289', '0:2013;  1:4;      2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:16;    43:1;',
													'1:5,1,1;3:5,23,0;4:5,25,-1;',
													'14:1;15:1;16:1;',
													'0:5; 1:2;   10:2;    11:1;    12:75;    20:10;    30:1;      31:10;    32:1;         33:7;     34:20;    35:77;  40:-1;',
													'0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;',
													-1										-- 필드없음.

*/


/*

select gameid, condate from dbo.tFVUserMaster
where gameid in (select distinct top 300 gameid from dbo.tFVUserUnusualLog where idx > 560 )
order by condate desc

*/

--select top 300 * from dbo.tFVUserUnusualLog order by idx desc

-- 레벨검사 / 경험치

/*
-- 치트 유저 영정 보내기
select gamecost, cashcost, * from dbo.tFVUserMaster where gamecost > 900000 and regdate > '2014-04-28' and gameid not in ('farm7609306', 'farm31007408', 'farm106969975', 'farm6213872') and blockstate = 0
select gamecost, cashcost, * from dbo.tFVUserMaster where cashcost > 3000 and regdate > '2014-04-28' and gameid not in ('farm7609306', 'farm31007408', 'farm106969975', 'farm6213872') and blockstate = 0
select top 10 * from dbo.tFVSchoolUser where (point > 2000000 or point < 0) and gameid not in ('farm7609306')

-- 코인 : farm83837225, farm83837225
-- 캐쉬 : farm630, farm640, farm19953431, farm85330788, farm429
-- 많은 수정이 보유하고 계십니다. 이유를 알려주세요. (고객센터에 미제출시에는 블럭 처리됩니다.)
*/


/*
--select * from dbo.tFVStaticCashMaster
--select * from dbo.tFVStaticCashUnique
-- delete from dbo.tFVStaticCashUnique where dateid = '20140506'

--------------------------------------------
-- SQL Server 에이전트(먼저 켜져있어야한다.)
-- 유저 정보를 1일 단위로 백업을 진행한다.
-- 매일 시작 04시 00분 00초에 시작
---------------------------------------------
declare @dateid			varchar(8),
		@dateid8		varchar(8),
		@dateid19		varchar(19),
		@market 		int,
		@cash 			int,
		@step 			int

set @dateid		= Convert(varchar(8), Getdate() - 1, 112)
--set @dateid = '20140508'
--set @dateid = '20140408'
--set @dateid = '20140327'
-------------------------------------------
-- 1. 마스터 데이타 검사.
-------------------------------------------
set @step = 0
select @step = step from dbo.tFVStaticCashMaster where dateid = @dateid
--select 'DEBUG ', @dateid dateid, @step step

if(@step = 0)
	begin
		--select 'DEBUG 마스터 입력', @dateid dateid, @step step
		set @step = 1
		insert into dbo.tFVStaticCashMaster(dateid,  step)
		values(                          @dateid, @step)
	end

if(@step = 1)
	begin
		--select 'DEBUG 서브 입력', @dateid dateid, @step step
		set @step = 2
		update dbo.tFVStaticCashMaster set step = @step where @dateid = dateid

		set @dateid8 = @dateid
		set @dateid19= @dateid + ' 23:59:59'
		--select 'DEBUG ', @dateid8 dateid8, @dateid19 dateid19

		insert into dbo.tFVStaticCashUnique(dateid, market, cash, cnt)
		select @dateid8 dateid, market, cash, COUNT(*) cnt from
		(select distinct Convert(varchar(8),writedate,112) as dateid, market, gameid, cash from dbo.tFVCashLog where writedate >= @dateid8 and writedate <= @dateid19) d
		group by market, cash order by market asc, cash asc
	end

*/


/*

declare @gameid_		varchar(20),	@password_		varchar(20),	@userinfo_		varchar(1024),	@aniitem_		varchar(2048),	@cusitem_		varchar(1024),		@tradeinfo_		varchar(1024),
		@paraminfo_		varchar(1024),	@gameyear		int,			@gamemonth		int

set @gameid_		= 'xxxx2'		set @password_	= '049000s1i0n7t8445289'
set @userinfo_		= '0:2045;1:7;2:0;4:2;10:11;11:520;12:0;13:0;30:20;40:-1;41:-1;44:-1;45:-1;42:-1;43:3;'
set @aniitem_		= '66:5,25,0;71:5,25,0;63:6,10,0;62:2,22,0;18:5,18,0;61:6,15,0;60:7,22,0;51:4,8,0;54:9,23,0;65:9,9,0;69:7,2,0;'
set @cusitem_		= ''
set @tradeinfo_		= '0:2040;1:33;10:6;11:1;12:50;20:19;30:1;31:45;32:9;33:11;34:55;35:594;40:1450;50:8;51:11;52:26;'
set @paraminfo_		= '0:90147;1:1304;2:0;3:0;4:203605;5:0;'

exec spu_FVGameTradeTestView @gameid_, @password_, @userinfo_,	@aniitem_,	@cusitem_,	@tradeinfo_,	@paraminfo_,	-1

*/

/*

declare @gameid_		varchar(20),	@password_		varchar(20),	@userinfo_		varchar(1024),	@aniitem_		varchar(2048),	@cusitem_		varchar(1024),		@tradeinfo_		varchar(1024),
		@paraminfo_		varchar(1024),	@gameyear		int,			@gamemonth		int

set @gameid_		= 'xxxx2'		set @password_	= '049000s1i0n7t8445289'
--set @gameyear		= 2036
--set @gamemonth		= 6
set @userinfo_		= '0:2045;1:7;2:0;4:2;10:11;11:520;12:0;13:0;30:20;40:-1;41:-1;44:-1;45:-1;42:-1;43:3;'
set @aniitem_		= '66:5,25,0;71:5,25,0;63:6,10,0;62:2,22,0;18:5,18,0;61:6,15,0;60:7,22,0;51:4,8,0;54:9,23,0;65:9,9,0;69:7,2,0;'
set @cusitem_		= ''
set @tradeinfo_		= '0:2040;1:33;10:6;11:1;12:50;20:19;30:1;31:45;32:9;33:11;34:55;35:594;40:1450;50:8;51:11;52:26;'
set @paraminfo_		= '0:90147;1:1304;2:0;3:0;4:203605;5:0;'

-- 일반결과
--update dbo.tFVUserMaster set gameyear = @gameyear, gamemonth = @gamemonth, frametime = 0, etsalecoin = 1000, fame = 5, famelv = 2, tradecnt = 1, prizecnt = 1, etremain = -1 where gameid = @gameid_
--update dbo.tFVUserMaster set gamecost = 0, cashcost = 0, feed = 0, heart = 0 where gameid = @gameid_
--update dbo.tFVSchoolMaster set totalpoint = 0 where schoolidx = (select schoolidx from dbo.tFVUserMaster where gameid = @gameid_)
--update dbo.tFVSchoolUser set point = 0 where gameid = @gameid_
--delete from dbo.tFVUserSaleLog where gameid = @gameid_
--delete from dbo.tFVGiftList where gameid = @gameid_
--delete from dbo.tFVEpiReward where gameid = @gameid_
exec spu_FVGameTradeTestView @gameid_, @password_, @userinfo_,	@aniitem_,	@cusitem_,	@tradeinfo_,	@paraminfo_,	-1

*/

/*
declare @userinfo_		varchar(1024),	@aniitem_		varchar(2048),	@cusitem_		varchar(1024),		@tradeinfo_		varchar(1024),
		@paraminfo_		varchar(1024),	@gameyear		int,			@gamemonth		int

set @gameyear		= 2013
set @gamemonth		= 9
set @userinfo_		= '0:2014;1:8;2:0;4:3;10:19;11:442;12:11;13:242;30:3;40:-1;41:-1;44:-1;45:-1;42:-1;43:1;'
set @aniitem_		= '0:6,24,0;1:6,24,0;2:5,24,0;3:4,1,0;20:8,12,0;16:6,17,0;18:5,23,0;19:2,26,0;'
set @cusitem_		= '7:1;8:2;10:1;'
set @tradeinfo_		= '0:158;1:7;10:17;11:2;12:0;20:7;30:0;31:25;32:5;33:7;34:22;35:210;40:5101;50:0;51:4;52:16;'
set @paraminfo_		= '0:90115;1:1;2:0;3:0;4:201408;5:0;'

 -- 일반결과
update dbo.tFVUserMaster set gameyear = @gameyear, gamemonth = @gamemonth, frametime = 0, etsalecoin = 1000, fame = 5, famelv = 2, tradecnt = 1, prizecnt = 1, etremain = -1 where gameid = 'xxxx2'
update dbo.tFVUserMaster set gamecost = 0, cashcost = 0, feed = 0, heart = 0 where gameid = 'xxxx2'
update dbo.tFVSchoolMaster set totalpoint = 0 where schoolidx = (select schoolidx from dbo.tFVUserMaster where gameid = 'xxxx2')
update dbo.tFVSchoolUser set point = 0 where gameid = 'xxxx2'
delete from dbo.tFVUserSaleLog where gameid = 'xxxx2'
delete from dbo.tFVGiftList where gameid = 'xxxx2'
delete from dbo.tFVEpiReward where gameid = 'xxxx2'
exec spu_FVGameTrade 'xxxx2', '049000s1i0n7t8445289', @userinfo_,	@aniitem_,	@cusitem_,	@tradeinfo_,	@paraminfo_,	-1
*/

--select top 10 * from dbo.tFVEventCertNoBack
/*
---------------------------------------------
--	통계자료(캐쉬 마스터)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVStaticCashMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVStaticCashMaster;
GO

create table dbo.tFVStaticCashMaster(
	idx				int					identity(1, 1),

	dateid			varchar(8),									-- 20121118
	step 			int					default(1),				-- famelv(1), tel(2)
	writedate		datetime			default(getdate()), 	-- 작성일

	-- Constraint
	CONSTRAINT pk_tStaticCashMaster_dateid	PRIMARY KEY(dateid)
)
GO

---------------------------------------------
--	통계자료(캐쉬 서브)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVStaticCashUnique', N'U') IS NOT NULL
	DROP TABLE dbo.tFVStaticCashUnique;
GO

create table dbo.tFVStaticCashUnique(
	idx						int					IDENTITY(1,1),

	dateid					varchar(8),
	market					int,
	cash					int,
	cnt						int,
	writedate				datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tStaticCashUnique_idx		PRIMARY KEY(idx)
)
*/

/*
-- select * from dbo.tFVStaticCashMaster
-- select * from dbo.tFVStaticCashUnique
-- delete from dbo.tFVStaticCashUnique where dateid = '20140506'

--------------------------------------------
-- SQL Server 에이전트(먼저 켜져있어야한다.)
-- 유저 정보를 1일 단위로 백업을 진행한다.
-- 매일 시작 04시 00분 00초에 시작
---------------------------------------------
declare @dateid			varchar(8),
		@dateid8		varchar(8),
		@dateid19		varchar(19),
		@market 		int,
		@cash 			int,
		@step 			int

set @dateid		= Convert(varchar(8), Getdate() - 1, 112)
--set @dateid = '20140430'
-------------------------------------------
-- 1. 마스터 데이타 검사.
-------------------------------------------
set @step = 0
select @step = step from dbo.tFVStaticCashMaster where dateid = @dateid
--select 'DEBUG ', @dateid dateid, @step step

if(@step = 0)
	begin
		--select 'DEBUG 마스터 입력', @dateid dateid, @step step
		set @step = 1
		insert into dbo.tFVStaticCashMaster(dateid,  step)
		values(                          @dateid, @step)
	end

if(@step = 1)
	begin
		--select 'DEBUG 서브 입력', @dateid dateid, @step step
		set @step = 2
		update dbo.tFVStaticCashMaster set step = @step where @dateid = dateid

		set @dateid8 = @dateid
		set @dateid19= @dateid + ' 23:59:59'
		--select 'DEBUG ', @dateid8 dateid8, @dateid19 dateid19

		insert into dbo.tFVStaticCashUnique(dateid, market, cash, cnt)
		select @dateid8 dateid, market, cash, COUNT(*) cnt from
		(select distinct Convert(varchar(8),writedate,112) as dateid, market, gameid, cash from dbo.tFVCashLog where writedate >= @dateid8 and writedate <= @dateid19) d
		group by market, cash order by market asc, cash asc
	end
*/



/*

					--if(@ps2_ = '')
					--	begin
					--		set @ps2_ = Convert(varchar(8),Getdate(),112)
					--	end
					--set @dateid8 = @ps2_
					--set @dateid19= @ps2_ + ' 23:59:59'
					----select distinct Convert(varchar(8),writedate,112), gameid, cash  from dbo.tFVCashLog where writedate >= @dateid8 and writedate <= @dateid8 order by gameid, cash
					--select @dateid8 dateid, market, cash, COUNT(*) cnt from
					--(select distinct Convert(varchar(8),writedate,112) as dateid, market, gameid, cash from dbo.tFVCashLog where writedate >= @dateid8 and writedate <= @dateid19) d
					--group by market, cash order by market asc, cash asc

					-- 실시간 검색
					if(@ps2_ = '')
						begin
							select Convert(varchar(8),Getdate(),112) dateid, 0 market, 0 cash, 0 cnt
						end
					else
						begin
							set @dateid8 = @ps2_
							set @dateid19= @ps2_ + ' 23:59:59'
							select @dateid8 dateid, market, cash, COUNT(*) cnt from
							(select distinct Convert(varchar(8),writedate,112) as dateid, market, gameid, cash from dbo.tFVCashLog where writedate >= @dateid8 and writedate <= @dateid19) d
							group by market, cash order by market asc, cash asc
						end


*/



/*

--select top 10 * from dbo.tFVCashLog where acode = '12999763169054705758.1305267024288393'
*/

/*
declare @dateid varchar(20),
		@dateid2 varchar(20)
set @dateid = '20140408'
set @dateid2= @dateid + ' 23:59:59'
--select distinct Convert(varchar(8),writedate,112), gameid, cash  from dbo.tFVCashLog where writedate >= @dateid and writedate <= @dateid2 order by gameid, cash

select @dateid, cash, COUNT(*) cnt from
(select distinct Convert(varchar(8),writedate,112) as dateid, gameid, cash  from dbo.tFVCashLog where writedate >= @dateid and writedate <= @dateid2) d
group by cash order by cash asc
*/


/*
-- 학교 랭킹 정리데이타
declare @loop		int,
		@loopmax	int

set @loop = 1
set @loopmax = 74
while(@loop <= @loopmax)
	begin
		exec spu_FVSysInquire 'xxxx2', '049000s1i0n7t8445289', '문의합니다2.', -1
		exec spu_FVSysInquire 'xxxx3', '049000s1i0n7t8445289', '문의합니다3.', -1
		exec spu_FVSysInquire 'xxxx4', '049000s1i0n7t8445289', '문의합니다4.', -1
		exec spu_FVSysInquire 'xxxx5', '049000s1i0n7t8445289', '문의합니다5.', -1
		exec spu_FVSysInquire 'xxxx6', '049000s1i0n7t8445289', '문의합니다6.', -1
		exec spu_FVSysInquire 'xxxx7', '049000s1i0n7t8445289', '문의합니다7.', -1
		set @loop = @loop + 1
	end
*/

/*

---------------------------------------------
-- 유저문의
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSysInquire', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSysInquire;
GO

create table dbo.tFVSysInquire(
	idx					int 				IDENTITY(1, 1),

	gameid				varchar(20),
	state				int					default(0),				-- 요청대기[0], 체킹중[1], 완료[2]
	comment				varchar(1024)		default(''),
	writedate			datetime			default(getdate()),

	adminid				varchar(20)			default(''),
	comment2			varchar(1024)		default(''),
	dealdate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSysInquire_idx	PRIMARY KEY(idx)
)
-- select top 10 * from dbo.tFVSysInquire order by idx desc
-- insert into dbo.tFVSysInquire(gameid, comment) values(1, '잘안됩니다.')
-- update dbo.tFVSysInquire set state = 1, dealdate = getdate(), comment2 = '진행중입니다.' where idx = 1
-- update dbo.tFVSysInquire set state = 2, dealdate = getdate(), comment2 = '처리했습니다.' where idx = 1
-- if(2)쪽지로 발송된다.


*/


/*
-- 필터걸어줄것 :
-- saledanga	: farm68564410 > 600000013
-- saleplusdanga: farm68564410 > 1223
-- salecoin		: farm68564410 > 1800000039 (젤 많이 이상 증상이 나옴)
-- tradecnt		: farm31467803 >
-- salefresh	: farm52338927 > 19000
-- select top 10 * from dbo.tFVUserSaleLog order by playcoin desc
-- select top 10 * from dbo.tFVUserSaleLog where gameid not in ('farm48', 'farm125') order by prizecoin desc
-- select top 10 * from dbo.tFVUserSaleLog order by saledanga desc
-- select top 10 * from dbo.tFVUserSaleLog order by saleplusdanga desc
*/


/*
select top 20 * from dbo.tFVUserSaleLog order by salecoin desc
select top 10 * from dbo.tFVUserSaleLog order by gameyear desc
select top 10 * from dbo.tFVUserSaleLog order by gamemonth desc
select top 10 * from dbo.tFVUserSaleLog order by feeduse desc
select top 10 * from dbo.tFVUserSaleLog order by playcoin desc
select top 10 * from dbo.tFVUserSaleLog order by playcoinmax desc
select top 10 * from dbo.tFVUserSaleLog order by fame desc
select top 10 * from dbo.tFVUserSaleLog order by famelv desc
select top 10 * from dbo.tFVUserSaleLog order by tradecnt desc	-- 체킹
select top 10 * from dbo.tFVUserSaleLog order by prizecnt desc
select top 10 * from dbo.tFVUserSaleLog order by prizecoin desc
select top 10 * from dbo.tFVUserSaleLog order by saletrader desc
select top 10 * from dbo.tFVUserSaleLog order by saledanga desc		-- 핵심 > salecoin
select top 10 * from dbo.tFVUserSaleLog order by saleplusdanga desc	-- 핵심
select top 10 * from dbo.tFVUserSaleLog order by salebarrel desc
select top 10 * from dbo.tFVUserSaleLog order by salefresh desc
select top 10 * from dbo.tFVUserSaleLog order by saleitemcode desc
select top 10 * from dbo.tFVUserSaleLog order by plusheart desc
select top 10 * from dbo.tFVUserSaleLog order by orderbarrel desc
select top 10 * from dbo.tFVUserSaleLog order by orderfresh desc
*/

/*
select top 100 * from dbo.tFVUserSaleLog order by salecoin asc	-- 체킹
select top 10 * from dbo.tFVUserSaleLog order by gameyear asc		--
select top 10 * from dbo.tFVUserSaleLog order by gamemonth asc	--
select top 10 * from dbo.tFVUserSaleLog order by feeduse asc		--
select top 10 * from dbo.tFVUserSaleLog order by playcoin asc		--
select top 10 * from dbo.tFVUserSaleLog order by playcoinmax asc	--
select top 10 * from dbo.tFVUserSaleLog order by fame asc			--
select top 10 * from dbo.tFVUserSaleLog order by famelv asc		--
select top 10 * from dbo.tFVUserSaleLog order by tradecnt asc		--
select top 10 * from dbo.tFVUserSaleLog order by prizecnt asc		--
select top 10 * from dbo.tFVUserSaleLog order by prizecoin asc	--
select top 10 * from dbo.tFVUserSaleLog order by saletrader asc	--
select top 10 * from dbo.tFVUserSaleLog order by saledanga asc	--
select top 10 * from dbo.tFVUserSaleLog order by saleplusdanga asc--
select top 20 * from dbo.tFVUserSaleLog order by salebarrel asc	-- 체킹
select top 10 * from dbo.tFVUserSaleLog order by salefresh asc	-- 체킹
select top 10 * from dbo.tFVUserSaleLog order by saleitemcode asc	--
select top 10 * from dbo.tFVUserSaleLog order by plusheart asc	--
select top 10 * from dbo.tFVUserSaleLog order by orderbarrel asc	--
select top 10 * from dbo.tFVUserSaleLog order by orderfresh asc	--
*/




/*
-- 학교 랭킹 정리데이타
declare @schoolidx		int,
		@point			int,
		@cnt			int,
		@totalpoint		int,
		@totalcnt		int,
		@eee1			int,
		@eee2			int
set @eee1 = 0
set @eee2 = 0

declare curSchoolData Cursor for
select top 50000 schoolidx, sum(point), count(idx) from dbo.tFVSchoolUser group by schoolidx

-- 2. 커서오픈
open curSchoolData

-- 3. 커서 사용
Fetch next from curSchoolData into @schoolidx, @point, @cnt
while @@Fetch_status = 0
	Begin
		set @totalpoint = -9999
		select @totalpoint = totalpoint, @totalcnt = cnt from dbo.tFVSchoolMaster where schoolidx = @schoolidx
		--select 'DEBUG ===>', @schoolidx schoolidx, @point point, @totalpoint totalpoint
		if(@totalpoint = -9999)
			begin
				insert into tSchoolMaster(schoolidx,  cnt, totalpoint)
				values(                  @schoolidx, @cnt,     @point)
			end

		if(@totalpoint = @point and @totalcnt = @cnt)
			begin
				--select 'DEBUG [O]', @schoolidx schoolidx, @point point, @totalpoint totalpoint
				set @eee1 = @eee1 + 1
			end
		else
			begin
				set @eee2 = @eee2 + 1
				select 'DEBUG [X]', @schoolidx schoolidx, @point point, @totalpoint totalpoint, @cnt cnt, @totalcnt totalcnt
				update dbo.tFVSchoolMaster set totalpoint = @point, cnt = @cnt where schoolidx = @schoolidx
				select 'DEBUG [X]', @schoolidx schoolidx, @point point, @totalpoint totalpoint, @cnt cnt, * from dbo.tFVSchoolMaster where schoolidx = @schoolidx
			end

		Fetch next from curSchoolData into @schoolidx, @point, @cnt
	end

-- 4. 커서닫기
close curSchoolData
Deallocate curSchoolData

select @eee1 eee1, @eee2 eee2
*/

/*
select schoolidx, sum(point) totalpoint from dbo.tFVSchoolUser group by schoolidx order by 2 desc
select top 100 * from dbo.tFVSchoolMaster order by totalpoint desc
select top 100 * from dbo.tFVSchoolUser order by point desc
*/
/*
-- 전체데이타 검사.
-- select top 100 * from dbo.tFVSchoolMaster order by totalpoint desc
-- select top 100 * from dbo.tFVSchoolUser order by point desc
--
-- 상세데이타.
-- select * from dbo.tFVSchoolBank where schoolidx = 11037
-- select * from dbo.tFVSchoolMaster where schoolidx = 11037
-- select * from dbo.tFVSchoolUser where schoolidx = 11037
--
-- update dbo.tFVSchoolMaster set totalpoint = 2223166 where schoolidx = @schoolidx
-- select * from dbo.tFVSchoolBank where schoolidx in (1452, 11960, 12001, 12055, 12000, 11951)
-- select * from dbo.tFVSchoolMaster where cnt >= 100 order by cnt desc
-- select schoolidx, count(*) from dbo.tFVSchoolUser group by schoolidx order by 2 desc
-- select schoolidx, sum(point) from dbo.tFVSchoolUser group by schoolidx order by 2 desc
-- 1452		424		광주용봉초등학교
--11960		249		서울대학교
--12001		143		계명대학교
--12055		140		고려대학교
--12000		135		성균관대학교
--11951		116		성균관대학교
*/





/*
	select top 1 *
	from dbo.tFVKakaoMaster
	where kakaouserid = '88056836307544817'
	order by idx desc
*/

/*

-- select top 10 * from dbo.tFVCashLog where acode = '12999763169054705758.1349977648147598'
--	exec spu_FVCashBuy 1, 'farm18542166',      '', '4012386l4t0e6m361842', '12999763169054705758.1349977648147598', '12999763169054705758.1349977648147598', 5, 1, 5002, 121,   9900, 121,   9900, '', '', '', '', -1	--
--	exec spu_FVCashBuy 1, 'farm25169575',      '', '0558592v6z9a2u129942', '12999763169054705758.1345081427085269', '12999763169054705758.1345081427085269', 5, 1, 5002, 121,   9900, 121,   9900, '', '', '', '', -1	--
--	exec spu_FVCashBuy 1, 'farm1142',          '', '0075827w4t6e1t419228', '12999763169054705758.1398616492731459', '12999763169054705758.1398616492731459', 5, 1, 5002, 121,   9900, 121,   9900, '', '', '', '', -1	--
-- 로그만 기록되도록 하자.
-- farm1450	7142680f2w1h2f468796	12999763169054705758.1369251754531367
-- farm959		8053445i2t4a3r699464	12999763169054705758.1363888685079135
--
-- select top 10 * from dbo.tFVCashLog where acode = '12999763169054705758.1344112594975205' -- 처리됨
-- select top 10 * from dbo.tFVCashLog where acode = '12999763169054705758.1391128253387005'
-- exec spu_FVCashBuy 1, 'farm1142',          '', '0075827w4t6e1t419228', '12999763169054705758.1391128253387005', '12999763169054705758.1391128253387005', 5, 1, 5002, 121,   9900, 121,   9900, '', '', '', '', -1	--
-- exec spu_FVCashBuy 1, 'farm42669732',      '', '3713878x7k5g1r217937', '????', '12999763169054705758.1391128253387004', 5, 1, 5002, 121,   9900, 121,   9900, '', '', '', '', -1	--
-- exec spu_FVCashBuy 1, 'farm24014232',      '', '6465279y4z4v5n414444', '12999763169054705758.1360986697836051', '12999763169054705758.1360986697836051', 5, 1, 5002, 121,   9900, 121,   9900, '', '', '', '', -1	--


이성은 구매금액 9.000원 영수증 번호 12999 76 3169 054 705758 1313 833 651566 748 날짜 2014 05월 04일 09:00 등록번호 2208666274
이성은 구매금액 9.000원 영수증 번호 12999 76 3169 054 705758 1313 833 651566 748 날짜 2014 05월 04일 09:00 등록번호 2208666274


-- Google
-- exec spu_FVCashBuy 1, 'farm42207588',      '', '0003865s1v4t7d252447', '12999763169054705758.1313833651566748', '12999763169054705758.1313833651566748', 5, 1, 5002, 121,   9900, 121,   9900, '', '', '', '', -1	--
12999763169054705758.1360986697836051
12999763169054705758.1313833651566748

-- iPhone
-- exec spu_FVCashBuy 1, 'farm51767927',      '', '3216740f7w4m8m347491', 'mhng5dl6s0', 'mhng5dl6s0', 7, 1, 5002, 121,   9900, 121,   9900, '', '', '', '', -1	--
*/


/*
--
declare @schoolidx		int,
		@schoolname		varchar(20),
		@point			int
set @schoolname = '국민대학교'
select @schoolidx = schoolidx from dbo.tFVSchoolBank where schoolname = @schoolname
select * from dbo.tFVSchoolMaster where schoolidx = @schoolidx
select @point = sum(point) from dbo.tFVSchoolUser where schoolidx = @schoolidx
select @point point
select * from dbo.tFVSchoolUser where schoolidx = @schoolidx
select * from dbo.tFVUserMaster where schoolidx = @schoolidx

-- update dbo.tFVSchoolMaster set totalpoint = 2223166 where schoolidx = @schoolidx
--select * from dbo.tFVSchoolBank where schoolidx in (1452, 11960, 12001, 12055, 12000, 11951)
--select * from dbo.tFVSchoolMaster where cnt >= 100 order by cnt desc
-- select schoolidx, count(*) from dbo.tFVSchoolUser group by schoolidx order by 2 desc
-- 1452		424		광주용봉초등학교
--11960		249		서울대학교
--12001		143		계명대학교
--12055		140		고려대학교
--12000		135		성균관대학교
--11951		116		성균관대학교
*/




/*
declare @schoolidx	int,
		@cnt		int

declare curCashLog Cursor for
select schoolidx, count(*) from dbo.tFVUserMaster where schoolidx != -1 and blockstate = 0 and deletestate = 0 and kakaostatus = 1 group by schoolidx order by 2 desc

-- 2. 커서오픈
open curCashLog

-- 3. 커서 사용
Fetch next from curCashLog into @schoolidx, @cnt
while @@Fetch_status = 0
	Begin
		select 'DEBUG ', @schoolidx schoolidx, @cnt cnt
		-- update dbo.tFVSchoolMaster set cnt = @cnt where schoolidx = @schoolidx

		Fetch next from curCashLog into @schoolidx, @cnt
	end

-- 4. 커서닫기
close curCashLog
Deallocate curCashLog
*/

/*
랭킹	학교	인원	점수
1	광주용봉초등학교(1452)[광주동부 , 초등학교(1)]	265	13,191,119
2	강남대학교(11985)[경기 , 대학교(4)]	100	6,879,921
3	서울대학교(11960)[서울 , 대학교(4)]	126	5,844,765
4	경북대학교(11951)[경북 , 대학교(4)]	97	5,338,878
5	한국복지대학교(11784)[경기 , 대학교(4)]	98	5,331,726
6	성남방송고등학교(11501)[경기성남시 , 고등학교(3)]	100	4,441,724
7	성균관대학교(12055)[서울 , 대학교(4)]	101	4,225,527
8	강원대학교(11949)[강원 , 대학교(4)]	99	3,711,468
9	호서대학교(12124)[충남 , 대학교(4)]	99	3,367,353
10	백석대학교(12094)[충남 , 대학교(4)]	101	3,294,918
*/
/*
-- 푸쉬 필터
--select distinct pushid from dbo.tFVUserMaster where pushid is not null and len(pushid) > 20 and deletestate = 0 and blockstate = 0 and kkopushallow = 1
*/


/*
-- 11501(성남방송고 )
-- update dbo.tFVSchoolMaster set cnt = xx where schoolidx = 11501
declare @schoolidx int set @schoolidx = 11501
select * from dbo.tFVSchoolMaster where schoolidx = @schoolidx
select * from dbo.tFVUserMaster where schoolidx = @schoolidx
--select * from dbo.tFVSchoolMaster where cnt >= 100 order by cnt desc
-- 1452(용봉 초등), 11960(서울대)
-- 7089(광주동신 여자중학교)
-----------------------------------------
-- 해당 인원들에게 쪽지 발송.
declare @comment	varchar(256),
        @gameid		varchar(20),
        @schoolidx int

set @comment     = '짜요 관리자입니다. 해당 학교가 형평성 문제로 월요일(5일 09:00) 서비스 점검 이후 초기화 됩니다. 월요일에는 학교 이전이 가능하니, 가급적 점검전 원하시는 학교로 이동하시기 바랍니다.'
set @gameid      = ''
set @schoolidx   = 7089

-- 1. 선언하기.
declare curMessage Cursor for
select gameid from dbo.tFVUserMaster where schoolidx =  @schoolidx

-- 2. 커서오픈
open curMessage

-- 3. 커서 사용
Fetch next from curMessage into @gameid
while @@Fetch_status = 0
	Begin
		--select 'DEBUG ', @gameid gameid
		-- exec spu_FVFarmD 19, 94,  1, -1, -1, -1, -1, -1, -1, -1, 'xxxx2', '', '', '', '', '', '', '', '', ''				-- 학교대항삭제
		-- exec spu_FVFarmD 27, 12, -1, -1, -1, -1, -1, -1, -1, -1, 'blackm', @gameid, @comment, '', '', '', '', '', '', ''	-- 쪽지발송

		Fetch next from curMessage into @gameid
	end

-- 4. 커서닫기
close curMessage
Deallocate curMessage
*/


/*

-- select * from dbo.tFVSchoolMaster where cnt >= 100 order by cnt desc
-- select * from dbo.tFVUserMaster where schoolidx = 1452
-- select * from dbo.tFVUserMaster where schoolidx = 11960
-- select * from dbo.tFVUserMaster where schoolidx = 7089
-- 1452(용봉 초등),
-- 11960(서울대)
-- 7089(광주동신 여자중학교)
-----------------------------------------
-- 해당 인원들에게 쪽지 발송.
-- 학교 대항전 인력 강제 탈퇴처리.
declare @comment	varchar(256),
        @gameid		varchar(20),
        @schoolidx int

--set @comment     = '짜요 관리자입니다. 해당 학교가 형평성 문제로 월요일(5일 09:00) 서비스 점검 이후 초기화 됩니다. 월요일에는 학교 이전이 가능하니, 가급적 점검전 원하시는 학교로 이동하시기 바랍니다.'
set @comment     = '[05.05]짜요 관리자입니다. 지금(월요일) 학교 이전이 가능하니, 가급적 점검전 원하시는 학교로 이동하시기 바랍니다. 해당 학교가 형평성 문제로 월요일(5일 09:00) 서비스 점검 이후 초기화 됩니다. .'
set @gameid      = ''
set @schoolidx   = 7089
if(GETDATE() < '2014-05-05 00:01')
	begin
		select 'DEBUG 시간이 안되어서 작동안함'
		return
	end

-- 1. 선언하기.
declare curMessage Cursor for
select gameid from dbo.tFVUserMaster where schoolidx =  @schoolidx


-- 2. 커서오픈
open curMessage

-- 3. 커서 사용
Fetch next from curMessage into @gameid
while @@Fetch_status = 0
	Begin
		--select 'DEBUG ', @gameid gameid

		exec spu_FVFarmD 27, 12, -1, -1, -1, -1, -1, -1, -1, -1, 'blackm', @gameid, @comment, '', '', '', '', '', '', ''	-- 쪽지발송

		Fetch next from curMessage into @gameid
	end

-- 4. 커서닫기
close curMessage
Deallocate curMessage
*/




/*
alter table dbo.tFVRouletteLogTotalMaster add acccnt			int				default(0)
update dbo.tFVRouletteLogTotalMaster set acccnt = 0


---------------------------------------------
-- 	악세룰렛 로그 > 개인자료
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVAccRoulLogPerson', N'U') IS NOT NULL
	DROP TABLE dbo.tFVAccRoulLogPerson;
GO

create table dbo.tFVAccRoulLogPerson(
	idx				int				identity(1, 1),

	gameid			varchar(20),
	kind			int,
	framelv			int,
	cashcost		int				default(0),
	gamecost		int				default(0),

	itemcode0		int				default(-1),
	itemcode1		int				default(-1),
	itemcode2		int				default(-1),
	itemcode3		int				default(-1),
	itemcode4		int				default(-1),
	itemcode0name	varchar(40)		default(''),
	itemcode1name	varchar(40)		default(''),
	itemcode2name	varchar(40)		default(''),
	itemcode3name	varchar(40)		default(''),
	itemcode4name	varchar(40)		default(''),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tAccRoulLogPerson_idx PRIMARY KEY(idx)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVAccRoulLogPerson_gameid_idx')
	DROP INDEX tFVAccRoulLogPerson.idx_tFVAccRoulLogPerson_gameid_idx
GO
CREATE INDEX idx_tFVAccRoulLogPerson_gameid_idx ON tAccRoulLogPerson (gameid, idx)
GO
-- select top 100 * from dbo.tFVAccRoulLogPerson where gameid = 'xxxx2' order by idx desc

*/




/*
alter table dbo.tFVUserMaster add eventspot01			int					default(0)
alter table dbo.tFVUserMaster add eventspot02			int					default(0)
alter table dbo.tFVUserMaster add eventspot03			int					default(0)
alter table dbo.tFVUserMaster add eventspot04			int					default(0)
alter table dbo.tFVUserMaster add eventspot05			int					default(0)

update dbo.tFVUserMaster set eventspot01 = 0, eventspot02 = 0, eventspot03 = 0, eventspot04 = 0, eventspot05 = 0
*/

/*
alter table dbo.tFVUserMaster add boardwrite	datetime				default(getdate() - 1)
update dbo.tFVUserMaster set boardwrite = getdate() - 1

declare @gaphour		int
declare @boardwrite		datetime				set @boardwrite		= '2014-05-02 13:19'
set @gaphour 		= dbo.fnu_GetFVDatePart('hh', @boardwrite, getdate())
select @gaphour gaphour
*/

/*
select * from dbo.tFVUserSaleLog where gameid = 'farm1086'
select * from dbo.tFVUserSaleLog where gameid = 'farm3495679'
*/

/*
-- guest가입 (강제로 5만건 입력하기 )
declare @var 			int
declare @loop			int				set @loop	= 10
declare @gameid 		varchar(60)		set @gameid = 'farm'	-- guest, farm, iuest
declare @phone 			varchar(20)
select @var = max(idx) + 1 from dbo.tFVUserMaster
set @loop = @var + @loop
while @var < @loop
	begin
		set @phone			= '010' + ltrim(@var)
		exec dbo.spu_FVUserCreate
							@gameid,					-- gameid
							'049000s1i0n7t8445289',		-- password
							1,							-- market
							0,							-- buytype
							1,							-- platform
							'ukukukuk',					-- ukey
							101,						-- version
							@phone,						-- phone
							'',							-- pushid

							'',							-- kakaotalkid (없으면 임으로 생성해줌)
							'',							-- kakaouserid (없으면 임으로 생성해줌)
							@gameid, 					-- kakaonickname
							'',							-- kakaoprofile
							-1,							-- kakaomsgblocked
							'0:000000000031;1:000000000033;',-- kakaofriendlist(kakaouserid)
							-1
		set @var = @var + 1
	end

*/

/*
declare @gameid_				varchar(20)
set @gameid_ = 'farm'


declare @rand int
declare @maxIdx int
select @maxIdx = max(idx)+1 from dbo.tFVUserMaster
set @rand 	= 100 + Convert(int, ceiling(RAND() * 899))	-- 100 ~ 999
set @gameid_ = @gameid_ + rtrim(ltrim(str(@maxIdx))) + rtrim(ltrim(str(@rand)))
select 'DEBUG ', @gameid_ gameid_
*/
/*
select gameid from (
	select gameid from dbo.tFVUserMaster where gameid not like 'farm%'
	) b where gameid not like 'iuest%'

*/

/*
alter table dbo.tFVCashLog add gameyear		int				default(2013)
alter table dbo.tFVCashLog add gamemonth		int				default(3)
alter table dbo.tFVCashLog add famelv			int				default(1)
*/
/*
-- 1. 아이템 보유 정보를 읽어오기
declare @gameid 	varchar(20),
		@gameyear	int,
		@gamemonth	int,
		@famelv		int

declare curCashLog Cursor for
select gameid, gameyear, gamemonth, famelv from dbo.tFVUserMaster where gameid in (select gameid from dbo.tFVCashLog)

-- 2. 커서오픈
open curCashLog

-- 3. 커서 사용
Fetch next from curCashLog into @gameid, @gameyear, @gamemonth, @famelv
while @@Fetch_status = 0
	Begin
		select 'DEBUG ', @gameid gameid, @gameyear gameyear, @gamemonth gamemonth, @famelv famelv

		update dbo.tFVCashLog
			set
				gameyear 	= @gameyear,
				gamemonth 	= @gamemonth,
				famelv 		= @famelv
		where gameid = @gameid

		Fetch next from curCashLog into @gameid, @gameyear, @gamemonth, @famelv
	end

-- 4. 커서닫기
close curCashLog
Deallocate curCashLog
*/
/*
--사전코드 검사
-- 2B22C38D02A14B8E
select top 10 * from dbo.tFVEventCertNoBack where certno = 'c50559c51aod467b'
select top 10 * from dbo.tFVEventCertNo where     certno = 'c50559c51aod467b'

*/

/*

update dbo.tFVUserMaster set kakaomsginvitecnt = 39, kakaomsginvitetodaycnt = 0, kakaomsginvitetodaydate = kakaomsginvitetodaydate - 1 	where gameid = 'farm2274'
update dbo.tFVUserMaster set kakaomsginvitetodaydate = kakaomsginvitetodaydate - 1 	where gameid = 'farm2274'
update dbo.tFVKakaoInvite set senddate = senddate - 31 where gameid = 'farm2274'
delete from dbo.tFVKakaoInvite where gameid = 'farm2274'
delete from dbo.tFVGiftList where gameid = 'farm2274'
exec spu_FVKakaoFriendInvite 'farm2274',  '6963637t0v3h7b494946', 'kakaouseridxxxx', -1
*/

/*
alter table dbo.tFVDayLogInfoStatic add logincnt2		int				default(0)

update dbo.tFVDayLogInfoStatic set logincnt2 = 0

alter table dbo.tFVUserMaster add logindate	varchar(8)				default('20100101')

update dbo.tFVUserMaster set logindate = '20100101'




*/


/*
declare @ps3_ varchar(40)
set @ps3_ = '201404'

set @ps3_ = @ps3_ + '%'
--select * from dbo.tFVStaticSubFameLV where dateid like @ps3_ order by dateid desc, famelv asc
exec spu_FVFarmD 19, 98,  3, -1, -1, -1, -1, -1, -1, -1, '', '', '201404', '', '', '', '', '', '', ''				--         레벨분포.

--select * from dbo.tFVStaticSubMarket where dateid like @ps3_ order by dateid desc, market asc
exec spu_FVFarmD 19, 98,  4, -1, -1, -1, -1, -1, -1, -1, '', '', '201404', '', '', '', '', '', '', ''				--         레벨통신사.

*/
/*
---------------------------------------------
-- 유저문의
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSysInquire', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSysInquire;
GO

create table dbo.tFVSysInquire(
	idx					int 				IDENTITY(1, 1),

	gameid				varchar(20),
	state				int					default(0),				-- 요청대기[0], 체킹중[1], 완료[2]
	comment				varchar(1024)		default(''),
	writedate			datetime			default(getdate()),

	adminid				varchar(20)			default(''),
	comment2			varchar(1024)		default(''),
	dealdate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSysInquire_idx	PRIMARY KEY(idx)
)
-- select top 10 * from dbo.tFVSysInquire order by idx desc
-- insert into dbo.tFVSysInquire(gameid, comment) values(1, '잘안됩니다.')
-- update dbo.tFVSysInquire set state = 1, dealdate = getdate(), comment2 = '진행중입니다.' where idx = 1
-- update dbo.tFVSysInquire set state = 2, dealdate = getdate(), comment2 = '처리했습니다.' where idx = 1
-- if(2)쪽지로 발송된다.
*/

/*

---------------------------------------------
-- 	캐쉬관련(개인로그)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVCashLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVCashLog;
GO

create table dbo.tFVCashLog(
	idx				int				identity(1, 1),
	gameid			varchar(20)		not null, 				-- 구매자
	giftid			varchar(20), 							-- 선물받은사람
	acode			varchar(256), 							-- 승인코드() 사용안함.ㅠㅠ
	ucode			varchar(256), 							-- 승인코드

	ikind			varchar(256),							-- 아이폰, Google 종류(SandBox, Real, GoogleID)
	idata			varchar(4096),							-- 아이폰에서 사용되는 데이타(원본)
	idata2			varchar(4096),							-- 아이폰에서 사용되는 데이타(해석본)

	cashcost		int				default(0), 			-- 충전골든볼
	cash			int				default(0),				-- 구매현금
	writedate		datetime		default(getdate()), 	-- 구매일
	market			int				default(1),				-- (구매처코드) MARKET_SKT

	kakaouserid		varchar(20)		default(''),			--          유저id
	kakaouk			varchar(19)		default(''),			--          유저id

	kakaosend		int				default(-1),			-- 미전송(-1) -> 전송(1)

	-- Constraint
	CONSTRAINT	pk_tCashLog_idx	PRIMARY KEY(idx)
)
--직접 clustered를 안한 이유는 쓰기는 idx로 하고 검색을 ucode > idx를 통해서 하도록 설정
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVCashLog_ucode')
    DROP INDEX tFVCashLog.idx_tFVCashLog_ucode
GO
CREATE INDEX idx_tFVCashLog_ucode ON tCashLog (ucode)
GO
--유저로그검색
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVCashLog_gameid')
    DROP INDEX tFVCashLog.idx_tFVCashLog_gameid
GO
CREATE INDEX idx_tFVCashLog_gameid ON tCashLog (gameid)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVCashLog_acode')
    DROP INDEX tFVCashLog.idx_tFVCashLog_acode
GO
CREATE INDEX idx_tFVCashLog_acode ON tCashLog (acode)
GO
--insert into dbo.tFVCashLog(gameid, acode, ucode, cashcost, cash) values('xxxx', 'xxx', '12345778998765442bcde3123192915243184254', 10, 1000)
--select * from dbo.tFVCashLog where ucode = '12345778998765442bcde3123192915243184254'

---------------------------------------------
-- 	캐쉬구매Total
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVCashTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tFVCashTotal;
GO

create table dbo.tFVCashTotal(
	idx				int				identity(1, 1),
	dateid			char(8),								-- 20101210
	cashkind		int,
	market			int				default(1),				-- (구매처코드) MARKET_SKT

	cashcost		int				default(0), 			-- 총판매량
	cash			int				default(0), 			-- 총판매량
	cnt				int				default(1),				--증가회수
	-- Constraint
	CONSTRAINT	pk_tCashTotal_dateid_market	PRIMARY KEY(dateid, cashkind, market)
)
-- insert into dbo.tFVCashTotal(dateid, cashkind, market, cashcost, cash) values('20140818', 2000, 1, 21, 2000)
-- insert into dbo.tFVCashTotal(dateid, cashkind, market, cashcost, cash) values('20140818', 5000, 1, 55, 5000)
-- select top 1 * from dbo.tFVCashTotal where dateid = '20120818' and cashkind = 2000 and market = 1
-- update dbo.tFVCashTotal set cashcost = cashcost + 21, cash = cash + 2000, cnt = cnt + 1 where dateid = '20120818' and cashkind = 2000 and market = 1

---------------------------------------------
-- 	캐쉬환전로그
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVCashChangeLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVCashChangeLog;
GO

create table dbo.tFVCashChangeLog(
	idx				int				identity(1, 1),
	gameid			varchar(20)		not null, 				-- 구매자
	cashcost		int, 									-- 환전골드
	gamecost		int, 									-- 환전실버
	writedate		datetime		default(getdate()),		-- 환전일

	-- Constraint
	CONSTRAINT	pk_tCashChangeLog_idx	PRIMARY KEY(idx)
)
--캐쉬환전인덱스
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVCashChangeLog_gameid_idx')
    DROP INDEX tFVCashChangeLog.idx_tFVCashChangeLog_gameid_idx
GO
CREATE INDEX idx_tFVCashChangeLog_gameid_idx ON tCashChangeLog (gameid, idx desc)
GO

-- insert into dbo.tFVCashChangeLog(gameid, cashcost, gamecost) values('SangSang', 10, 1000)
-- insert into dbo.tFVCashChangeLog(gameid, cashcost, gamecost) values('SangSang', 20, 2000)
-- insert into dbo.tFVCashChangeLog(gameid, cashcost, gamecost) values('SangSang', 30, 3000)
-- insert into dbo.tFVCashChangeLog(gameid, cashcost, gamecost) values('SangSang', 40, 4000)
-- insert into dbo.tFVCashChangeLog(gameid, cashcost, gamecost) values('DD0', 10, 1000)
-- select * from dbo.tFVCashChangeLog where gameid = 'SangSang' order by idx desc

---------------------------------------------
-- 	캐쉬환전토탈
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVCashChangeLogTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tFVCashChangeLogTotal;
GO

create table dbo.tFVCashChangeLogTotal(
	idx				int				identity(1, 1),
	dateid			char(8),							-- 20101210

	cashcost		int				default(0),
	gamecost		int				default(0),

	changecnt		int				default(1),

	-- Constraint
	CONSTRAINT	pk_tCashChangeLogTotal_dateid	PRIMARY KEY(dateid)
)
-- select top 100 * from dbo.tFVCashChangeLogTotal order by dateid desc
-- select top 1 * from dbo.tFVCashChangeLogTotal where dateid = '20120818'
-- insert into dbo.tFVCashChangeLogTotal(dateid, cashcost, gamecost, changecnt) values('20120818', 10, 1000, 1)
--update dbo.tFVCashChangeLogTotal
--	set
--		cashcost = cashcost + 10,
--		gamecost = gamecost + 10000,
--		changecnt = changecnt + 1
--where dateid = '20120818'

-- 192.168.0.11 / game4farm / a1s2d3f4



---------------------------------------------
--		게시판 정보(글쓰기에 우선순위를 올림).
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserBoard', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserBoard;
GO

create table dbo.tFVUserBoard(
	idx			int					IDENTITY(1,1),

	idx2		int,
	kind		int					default(1),					-- 1:일반게시판광고, 2:친추게시판광고, 3:대항게시판광고

	gameid		varchar(20),
	message		varchar(256)		default(''),
	writedate	datetime			default(getdate()), 		-- 선물일

	schoolidx	int					default(-1),

	-- Constraint
	CONSTRAINT	pk_tUserBoard_idx2_kind	PRIMARY KEY(idx)
)
-- 폰인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserBoard_idx2_kind')
    DROP INDEX tFVUserBoard.idx_tFVUserBoard_idx2
GO
CREATE INDEX idx_tFVUserBoard_idx2_kind ON tUserBoard (idx2, kind)
GO

-- insert into dbo.tFVUserBoard(kind, idx2, gameid, message) values(1, 1, 'xxxx2', '일반게시판광고')
-- insert into dbo.tFVUserBoard(kind, idx2, gameid, message) values(2, 1, 'xxxx2', '친추게시판광고')
-- insert into dbo.tFVUserBoard(kind, idx2, gameid, message) values(3, 1, 'xxxx2', '대항게시판광고')
-- select top 5 * from dbo.tFVUserBoard where kind = 1 order by idx2 desc
-- select top 5 * from dbo.tFVUserBoard where kind = 2 order by idx2 desc
-- select top 5 * from dbo.tFVUserBoard where kind = 3 order by idx2 desc

*/



/*
update dbo.tFVUserMaster set gameyear = 2015, gamemonth = 1, frametime = 0, bottlelittle = 1, bottlefresh = 2, tanklittle = 3, tankfresh = 4 where gameid = 'xxxx2'
delete from dbo.tFVUserSaleLog where gameid = 'xxxx2'
exec spu_FVGameSave 'xxxx2', '049000s1i0n7t8445289',
	'0:2015;1:1;2:69;4:4;10:35;11:4285;12:420;13:42330;30:46;40:1103;41:1002;44:1002;45:-1;42:-1;43:1;',
	--'0:2015;1:1;2:65;4:2;10:0;11:0;12:390;13:38150;30:54;40:1103;41:1002;44:1002;45:-1;42:-1;43:2;',
													'1:5,1,1;3:5,23,0;4:5,25,-1;',
													'14:1;15:1;16:1;',
													'0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;',
													-1										-- 필드없음.
*/


/*
userinfo=gameyear;gamemonth;frametime;fevergauge;bottlelittle;bottlefresh;tanklittle;tankfresh;feeduse;boosteruse;albause;wolfappear;wolfkillcnt;albausesecond;albausethird;petcooltime
         0:2015;  1:1;      2:65;     4:2;       10:0;        11:0;       12:390;    13:38150; 30:54;  40:1103;   41:1002;42:-1;     43:2;       44:1002;      45:-1;

userinfo : 0:2015;1:1;2:65;4:2;10:0;11:0;12:390;13:38150;30:54;40:1103;41:1002;44:1002;45:-1;42:-1;43:2;
aniitem	 : 45:5,25,0;22:5,25,0;23:5,20,0;24:5,25,0;31:4,26,0;32:4,22,0;33:5,25,0;34:5,24,0;35:4,21,0;36:5,26,0;37:5,25,0;41:5,25,0;44:5,25,0;
cusitem	 : 9:2;25:3;26:1;

*/


/*
alter table dbo.tFVNotice add iteminfover		int				default(100)
alter table dbo.tFVNotice add iteminfourl		varchar(512)	default('')

update dbo.tFVNotice set iteminfover = 100, iteminfourl = ''

*/

/*
select max(idx) from dbo.tFVCashTotal
select * from dbo.tFVCashTotal order by idx desc

exec spu_FVFarmD 21, 12,-1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 캐쉬판매통계
exec spu_FVFarmD 21, 12,2, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''						-- 캐쉬판매통계
*/


/*
alter table dbo.tFVEventCertNo add kind		int				default(0)

update dbo.tFVEventCertNo set kind = 0
*/

/*

select DATEADD(dd, DATEDIFF(dd,0,getdate()), 0)
--현재날의 자정주의 구하기
select datename(dd,getdate())
declare @a int
select @a = datepart(dd,getdate()) %3
select @a, @a%3, 0%3, 1%3, 2%3, 3%3, 4%3


*/
/*
select * from dbo.tFVCashTotal

select dateid, market, sum(cashcost) cashcost, sum(cash) cash from dbo.tFVCashTotal where dateid like '201403%' group by dateid, market order by dateid desc
select dateid, market, sum(cashcost) cashcost, sum(cash) cash from dbo.tFVCashTotal where dateid like '201404%' group by dateid, market order by dateid desc
*/


/*
			else if(@p2_ = 13)
				begin
					if(isnull(@ps2_, '') != '')
						begin
							set @dateid6 = @ps2_
						end
					set @ps2_ = @ps2_ + '%'
					select dateid, market, sum(cashcost) cashcost, sum(cash) from dbo.tFVCashTotal where dateid like @ps2_ group by dateid, market order by dateid desc
				end
*/


/*
alter table dbo.tFVUserMaster add pmticketcnt	int						default(0)

update dbo.tFVUserMaster set pmticketcnt = 0
*/

/*

select i.*  from
		dbo.tFVUserSaleRewardItemCode s
	JOIN
		dbo.tFVItemInfo i
	ON s.itemcode = i.itemcode

*/

/*
alter table dbo.tFVSystemInfo add roulaccprice		int					default(10)
alter table dbo.tFVSystemInfo add roulaccsale		int					default(10)

update dbo.tFVSystemInfo set roulaccprice = 10, roulaccsale = 10
*/


/*
select * from dbo.tFVKakaoMaster where kakaouserid = '91386767984635713'
select * from dbo.tFVUserMaster where kakaouserid = '91386767984635713'

delete from dbo.tFVKakaoMaster where kakaouserid = '91386767984635713'
*/

/*
alter table dbo.tFVKakaoMaster add deldate			datetime			default(getdate() - 1)

update dbo.tFVKakaoMaster set deldate = getdate() - 1
*/

/*

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoMaster_gameid')
    DROP INDEX tFVKakaoMaster.idx_tFVKakaoMaster_gameid
GO
CREATE INDEX idx_tFVKakaoMaster_gameid ON tKakaoMaster (gameid)
GO
*/
/*
declare @gameid_ varchar(60)
set @gameid_ = 'iuest123'
if(PATINDEX('%iuest%', @gameid_) = 1)
	begin
		select 'iuest'
	end
else
	begin
		select 'different id'
	end

*/


/*
insert into dbo.tFVStaticMaster(dateid, step) values('20140404', 1)

insert into dbo.tFVStaticSubFameLV(dateid, famelv, cnt) values('20140404', 1, 1)
select famelv, count(*) cnt from dbo.tFVUserMaster where kakaostatus = 1 group by famelv

insert into dbo.tFVStaticSubMarket(dateid, market, cnt) values('20140404', 1, 1)
select market, count(*) cnt from dbo.tFVUserMaster where kakaostatus = 1 group by market
*/
--select top 50 * from dbo.tFVStaticMaster order by dateid desc
--select * from dbo.tFVStaticSubFameLV where dateid = '20140404' order by famelv asc
--select * from dbo.tFVStaticSubMarket where dateid = '20140404' order by market asc

/*
---------------------------------------------
--	통계마스터[FameLV, Market]
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVStaticMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVStaticMaster;
GO

create table dbo.tFVStaticMaster(
	idx				int					identity(1, 1),

	dateid			varchar(8),									-- 20121118
	step 			int					default(1),				-- famelv(1), tel(2)
	writedate		datetime			default(getdate()), 	-- 작성일

	-- Constraint
	CONSTRAINT pk_tStaticMaster_dateid	PRIMARY KEY(dateid)
)
GO

-- select * from dbo.tFVStaticMaster
-- if(not exist(select dateid from dbo.tFVStaticMaster where dateid = '20140404'))
-- 		insert into dbo.tFVStaticMaster(dateid, step) values('20140404', 1)
-- update dbo.tFVStaticMaster set step = 2 where dateid = '20140404'

---------------------------------------------
--	통계[FameLV]
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVStaticSubFameLV', N'U') IS NOT NULL
	DROP TABLE dbo.tFVStaticSubFameLV;
GO

create table dbo.tFVStaticSubFameLV(
	idx						int					IDENTITY(1,1),

	dateid					varchar(8),
	famelv					int,
	cnt						int 				default(0),
	cnt2					int 				default(0),
	writedate				datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tStaticSubFameLV_idx		PRIMARY KEY(idx)
)
-- select * from dbo.tFVStaticSubFameLV where dateid = '20140404'
-- if(not exist(select dateid from dbo.tFVStaticSubFameLV where dateid = '20140404'))
-- 	insert into dbo.tFVStaticSubFameLV(dateid, famelv, cnt) values('20140404', 1, 1)
-- else
--	update dbo.tFVStaticSubFameLV set cnt = 2 where dateid = '20140404' and famelv = 1

---------------------------------------------
--	통계[Market]
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVStaticSubMarket', N'U') IS NOT NULL
	DROP TABLE dbo.tFVStaticSubMarket;
GO

create table dbo.tFVStaticSubMarket(
	idx						int					IDENTITY(1,1),

	dateid					varchar(8),
	market					int,
	cnt						int 				default(0),
	cnt2					int 				default(0),
	writedate				datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tStaticSubMarket_idx		PRIMARY KEY(idx)
)
-- select * from dbo.tFVStaticSubMarket where dateid = '20140404'
-- if(not exist(select dateid from dbo.tFVStaticSubMarket where dateid = '20140404'))
-- 	insert into dbo.tFVStaticSubMarket(dateid, market, cnt) values('20140404', 1, 1)
-- else
--	update dbo.tFVStaticSubMarket set cnt = 2 where dateid = '20140404' and market = 1
*/

/*
declare @gameid_ varchar(60) set @gameid_ = 'xxxx2'
declare @USERFARM_BUYSTATE_BUY				int					set @USERFARM_BUYSTATE_BUY					=  1
declare @ITEM_SUBCATEGORY_USERFARM			int					set @ITEM_SUBCATEGORY_USERFARM	 			= 69 -- 전국목장

	declare @gameid			varchar(60)				set @gameid			= ''
	declare @comment		varchar(128)
	declare @cashcost		int						set @cashcost		= 0
	declare @gamecost		int						set @gamecost		= 0
	declare @feed			int						set @feed			= 0
	declare @fpoint			int						set @fpoint			= 0
	declare @heart			int						set @heart			= 0
	declare @gameyear		int						set @gameyear		= 2013

	declare @buystate		int						set @buystate		= -444
	declare @incomedate		datetime				set @incomedate		= getdate()
	declare @incomegamecost	int						set @incomegamecost	= 0
	declare @buycount		int						set @buycount	= 0

	declare @gamecostorg	int						set @gamecostorg	= -444
	declare @gamecostcur	int						set @gamecostcur	= 0
	declare @hourcoin		int						set @hourcoin		= 0
	declare @maxcoin		int						set @maxcoin		= 0
	declare @raiseyear		int						set @raiseyear		= 0
	declare @raisepercent	int						set @raisepercent	= 0

	declare @gapyear		int
	declare @tmp			int
	declare @gaphour		int


	declare @farmidx		int


--select itemcode, buystate, incomedate, buycount from dbo.tFVUserFarm where gameid = @gameid_ and buystate = @USERFARM_BUYSTATE_BUY
--select itemcode, gamecost, param1, param2, param3, param4 from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_USERFARM


			-- 1. 아이템 보유 정보를 읽어오기
			declare curFarmList Cursor for
			select farmidx, incomedate, buycount, gamecostorg, hourcoin, maxcoin, raiseyear, raisepercent
			from
					(select itemcode, farmidx, incomedate, buycount from dbo.tFVUserFarm where gameid = @gameid_ and buystate = @USERFARM_BUYSTATE_BUY) f
				JOIN
					(select itemcode, gamecost gamecostorg, param1 hourcoin, param2 maxcoin, param3 raiseyear, param4 raisepercent from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_USERFARM) i
				ON f.itemcode = i.itemcode

			-- 2. 커서오픈
			open curFarmList


			-- 3. 커서 사용
			Fetch next from curFarmList into @farmidx, @incomedate, @buycount, @gamecostorg, @hourcoin, @maxcoin, @raiseyear, @raisepercent
			while @@Fetch_status = 0
				Begin
					select 'DEBUG ', @farmidx farmidx, @incomedate incomedate, @buycount buycount, @gamecostorg gamecostorg, @hourcoin hourcoin, @maxcoin maxcoin, @raiseyear raiseyear, @raisepercent raisepercent

					set @gaphour 		= dbo.fnu_GetFVDatePart('hh', @incomedate, getdate())
					set @incomegamecost	= @gaphour * @hourcoin

					if(@incomegamecost >= @maxcoin)
						begin
							set @incomegamecost	= @maxcoin
							set @incomedate		= getdate()
							select 'DEBUG 수입', @incomegamecost incomegamecost, @incomedate incomedate

							-- 수익금추가.
							set @gamecost 	= @gamecost + @incomegamecost

							-- 수익 걷어간 상태로체킹.
							update dbo.tFVUserFarm
								set
									incomedate 	= @incomedate,
									incomett	= incomett + @incomegamecost
							where gameid = @gameid_ and farmidx = @farmidx
						end

					Fetch next from curFarmList into @farmidx, @incomedate, @buycount, @gamecostorg, @hourcoin, @maxcoin, @raiseyear, @raisepercent
				end

			-- 4. 커서닫기
			close curFarmList
			Deallocate curFarmList

*/


/*
-- 악세뽑기 테스트 테이블
IF OBJECT_ID (N'dbo.tFVtt', N'U') IS NOT NULL
	DROP TABLE dbo.tFVtt;
GO

create table dbo.tFVtt(
	idx			int 					IDENTITY(1, 1),
	itemcode	int,
	accpercent	int,
	cnt			int						default(1)
)
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVtt_itemcode')
    DROP INDEX tFVtt.idx_tFVtt_itemcode
GO
CREATE INDEX idx_tFVtt_itemcode ON ttt (itemcode)
GO

-- 악세뽑기 테스트 데이타.
declare @accpercent		int
declare @loop int		set @loop = 0
declare @accmax		int
declare @accmin		int
declare @accrand	int
declare @rand	int
declare @cnt	int
declare @famelv			int				set @famelv 		= 1
declare @itemcode		int,
		@itemcode1		int,
		@itemcode2		int,
		@itemcode3		int,
		@itemcode4		int,
		@itemcode5		int

DECLARE @tTempTable TABLE(
	itemcode		int,
	accper			int,
	accmin			int,
	accmax			int
);

insert into @tTempTable select itemcode, CAST(param7 as int), CAST(param8 as int), CAST(param9 as int) from dbo.tFVItemInfo where subcategory = 15 and playerlv <= @famelv order by playerlv asc
select @accmin	= max(accmin), @accmax = max(accmax) from @tTempTable
--select 'DEBUG ', * from @tTempTable
while(@loop < 100)
	begin
		set @rand 	= Convert(int, ceiling(RAND() * 1000))
		set @cnt	= case
							when @rand < 500 then 1
							when @rand < 900 then 2
							when @rand < 960 then 3
							when @rand < 990 then 4
							else				  5
					  end


		set @accrand 	= Convert(int, ceiling(RAND() * (@accmax )))
--set @accmin 	= 2530
--set @accmax 	= 2760
--set @accrand 	= 2743
--select 'DEBUG 뽑기개수', @rand rand, @cnt cnt, @accmin accmin, @accmax accmax, @accrand accrand
--select 'min', * from @tTempTable where accmin <= @accrand
--select 'max', * from @tTempTable where @accrand < accmax

		select @itemcode1 = itemcode, @accpercent = accper from @tTempTable
		where accmin <= @accrand and @accrand < accmax

--select 'DEBUG 1차 랜덤잡기', @itemcode1 itemcode1, @accrand accrand

		if(not exists(select top 1 * from dbo.tFVtt where itemcode = @itemcode1))
			begin
				insert into dbo.tFVtt(itemcode, cnt, accpercent) values(@itemcode1, 1, @accpercent)
			end
		else
			begin
				update dbo.tFVtt set cnt = cnt + 1 where itemcode = @itemcode1
			end
		set @loop = @loop + 1
	end

select * from dbo.tFVtt order by itemcode asc

*/

/*
-- 1. 아이템 테이블의 순서 데이타를 정리
declare @itemcode			int		set @itemcode	= -1
declare @accper				int		set @accper		= 0
declare @accsum				int		set @accsum		= 0
declare curItemInfoAccSum Cursor for
select itemcode, CAST(param7 as int) accper from dbo.tFVItemInfo where subcategory = 15 order by playerlv asc

-- 2. 커서오픈
open curItemInfoAccSum

-- 3. 커서 사용
Fetch next from curItemInfoAccSum into @itemcode, @accper
while @@Fetch_status = 0
	Begin
		set @accsum = @accsum + @accper

		update dbo.tFVItemInfo
			set
				param8 = ltrim(rtrim(str(@accsum)))
		where itemcode = @itemcode

		Fetch next from curItemInfoAccSum into @itemcode, @accper
	end

-- 4. 커서닫기
close curItemInfoAccSum
Deallocate curItemInfoAccSum
*/

/*
-- guest가입 (강제로 5만건 입력하기 )
declare @var 			int
declare @loop			int				set @loop	= 1
declare @gameid 		varchar(60)		set @gameid = 'farm'	-- guest, farm, iuest
declare @phone 			varchar(20)
select @var = max(idx) + 1 from dbo.tFVUserMaster
set @loop = @var + @loop
while @var < @loop
	begin
		set @phone			= '010' + ltrim(@var)
		exec dbo.spu_FVUserCreate
							@gameid,					-- gameid
							'0787007g6t1h5v816142',		-- password
							5,							-- market
							0,							-- buytype
							1,							-- platform
							'xxxxx',					-- ukey
							101,						-- version
							'01026403070',						-- phone
							'APA91bGI_m45N21r5BmXIu5IUdabQzOExwnZqRjpXynbdHngv4RXmTmMdjM7Qu1ivaki4geHQK0uocJvfr-b58NjwGAdTOIRu_hCxEM8AmOLXwQQidC80OR5t8AE3pkqODDLV6jsNLEVFG2KDkiF4evgblg5RiJZFQ',							-- pushid

							'COk87e086Qg',							-- kakaotalkid (없으면 임으로 생성해줌)
							'91386767984635713',							-- kakaouserid (없으면 임으로 생성해줌)
							'sanggg', 					-- kakaonickname
							'',							-- kakaoprofile
							-1,							-- kakaomsgblocked
							'',
							-1
		set @var = @var + 1
	end
*/



/*
alter table dbo.tFVKakaoMaster add cnt2			int					default(0)

update dbo.tFVKakaoMaster set cnt2 = 0

*/
--select * from dbo.tFVKakaoMaster where gameid like 'xxxx%'
--exec spu_FVUserCreate 'xxxx2',  '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', 'kakaotalkidxxxx2', '000000000032', '', '', -1, '', -1

/*
declare @gameid varchar(60)
set @gameid = 'xxxx10'

delete from dbo.tFVUserSeed where gameid = @gameid
delete from dbo.tFVUserFriend where gameid = @gameid
delete from dbo.tFVUserBlockLog where gameid = @gameid
delete from dbo.tFVUserItem where gameid = @gameid
delete from dbo.tFVDogamList where gameid = @gameid
delete from dbo.tFVDogamListPet where gameid = @gameid
delete from dbo.tFVKakaoMaster where gameid = @gameid
delete from dbo.tFVUserMaster where gameid = @gameid
delete from dbo.tFVUserFarm where gameid = @gameid

--exec spu_FVUserCreate 'xxxx10',   '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112221', '', 'kakaotalkidxxxx10', '000000000099', '', '', -1, '', -1
*/

/*


select * from dbo.tFVKakaoMaster where gameid like 'xxxx%'

select * from dbo.tFVKakaoMaster where kakaouserid = '' and gameid like 'i%'

delete from dbo.tFVKakaoMaster where gameid = ''
delete from dbo.tFVKakaoMaster where kakaotalkid is null
delete from dbo.tFVKakaoMaster where kakaotalkid = '' and gameid like 'i%'
delete from dbo.tFVKakaoMaster where kakaouserid = '' and gameid like 'i%'
update dbo.tFVKakaoMaster set kakaouserid = 'kakaouseridfarmgirl' where idx = 7
*/

/*
alter table dbo.tFVKakaoMaster add kakaodata		int					default(1)

update dbo.tFVKakaoMaster set kakaodata = 1
*/


/*
select

'"nickname":' + '"' + kakaonickname + '"'
+ ',"profile_image_url":"' + kakaoprofile + '"'
+ ',"user_id":"' + kakaouserid + '"'
+ ',"message_blocked":false,"friend_nickname":"","hashed_talk_user_id":"' + kakaotalkid + '"},'
, *
from dbo.tFVUserMaster where gameid in (select gameid from dbo.tFVKakaoMaster) and kakaonickname != ''
*/


/*
alter table dbo.tFVUserFriend add rentdate		datetime		default(getdate() - 1)

update dbo.tFVUserFriend set rentdate = (getdate() - 1)

--update dbo.tFVUserMaster set kakaonickname = '짜요팜걸' where gameid = 'farmgirl'
*/

/*
alter table dbo.tFVUserMaster add l1kakaonickname	varchar(20)			default('')
alter table dbo.tFVUserMaster add l1kakaoprofile	varchar(512)		default('')
alter table dbo.tFVUserMaster add l2kakaonickname	varchar(20)			default('')
alter table dbo.tFVUserMaster add l2kakaoprofile	varchar(512)		default('')
alter table dbo.tFVUserMaster add l3kakaonickname	varchar(20)			default('')
alter table dbo.tFVUserMaster add l3kakaoprofile	varchar(512)		default('')

update dbo.tFVUserMaster set l1kakaonickname = '', l1kakaoprofile = '', l2kakaonickname  = '', l2kakaoprofile = '', l3kakaonickname = '', l3kakaoprofile = ''
*/


/*
-- select gameid, l1gameid, l1kakaonickname, l1kakaoprofile, l2gameid, l2kakaonickname, l2kakaoprofile, l3gameid, l3kakaonickname, l3kakaoprofile from dbo.tFVUserMaster where gameid in (select gameid from dbo.tFVKakaoMaster)
-- select * from dbo.tFVUserMaster where gameid = 'guest115853'
declare @gameid varchar(60),
		@l1gameid varchar(20), 		@l1kakaonickname	varchar(20),	 @l1kakaoprofile varchar(512),
		@l2gameid varchar(20), 		@l2kakaonickname	varchar(20),	 @l2kakaoprofile varchar(512),
		@l3gameid varchar(20), 		@l3kakaonickname	varchar(20),	 @l3kakaoprofile varchar(512)
declare curKakaoInfo Cursor for
select gameid, l1gameid, l2gameid, l3gameid from dbo.tFVUserMaster where gameid in (select gameid from dbo.tFVKakaoMaster)

-- 2. 커서오픈
open curKakaoInfo

-- 3. 커서 사용
Fetch next from curKakaoInfo into @gameid, @l1gameid, @l2gameid, @l3gameid
while @@Fetch_status = 0
	Begin
		set @l1kakaonickname = ''
		set @l1kakaoprofile = ''
		set @l2kakaonickname = ''
		set @l2kakaoprofile = ''
		set @l3kakaonickname = ''
		set @l3kakaoprofile = ''
		select @l1kakaonickname = kakaonickname, @l1kakaoprofile = kakaoprofile from dbo.tFVUserMaster where gameid = @l1gameid
		select @l2kakaonickname = kakaonickname, @l2kakaoprofile = kakaoprofile from dbo.tFVUserMaster where gameid = @l2gameid
		select @l3kakaonickname = kakaonickname, @l3kakaoprofile = kakaoprofile from dbo.tFVUserMaster where gameid = @l3gameid

		select
			@gameid gameid,
			@l1gameid l1gameid, @l1kakaonickname l1kakaonickname, @l1kakaoprofile l1kakaoprofile,
			@l2gameid l2gameid, @l2kakaonickname l2kakaonickname, @l2kakaoprofile l2kakaoprofile,
			@l3gameid l3gameid, @l3kakaonickname l3kakaonickname, @l3kakaoprofile l3kakaoprofile

		update dbo.tFVUserMaster
			set
				l1kakaonickname = @l1kakaonickname, l1kakaoprofile = @l1kakaoprofile,
				l2kakaonickname = @l2kakaonickname, l2kakaoprofile = @l2kakaoprofile,
				l3kakaonickname = @l3kakaonickname, l3kakaoprofile = @l3kakaoprofile
		where gameid = @gameid
		Fetch next from curKakaoInfo into @gameid, @l1gameid, @l2gameid, @l3gameid
	end

-- 4. 커서닫기
close curKakaoInfo
Deallocate curKakaoInfo
*/


/*
select kakaomsgblocked from dbo.tFVUserMaster where gameid = 'xxxx2'
exec spu_FVLogin 'xxxx2', '049000s1i0n7t8445289', 1, 101, '', '', 0, -1			-- 정상유저
select kakaomsgblocked from dbo.tFVUserMaster where gameid = 'xxxx2'
*/

/*
select * from dbo.tFVUserMaster where kakaouserid = '91322361118666017' and etsalecoin > 0
select * from dbo.tFVKakaoMaster where gameid = 'guest178' order by idx desc

select * from dbo.tFVUserMaster where kakaonickname = 'a최정기'
update dbo.tFVUserMaster set kakaostatus = -1 where gameid = 'guest206'

select , cashcost, * from dbo.tFVUserMaster order by gamecost desc

--
--alter table dbo.tFVKakaoMaster add writedate		datetime			default(getdate())
--update dbo.tFVKakaoMaster set writedate = getdate()
update dbo.tFVKakaoMaster set gameid = 'guest178' where kakaouserid = '88812599272546640'
update dbo.tFVUserMaster set kakaouserid = '88812599272546640', kakaotalkid = 'ABQgJSUgFAA' where gameid = 'guest178'
*/

/*
--select itemcode, param8, param11, * from dbo.tFVItemInfo where category = 901
declare @itemcode	int, @checknext int, @checkpre int, @activate int,
		@param1 int, @param2 int, @param3 int, @param4 int, @param5 int,
		@param6 int, @param7 int, @param8 int, @param9 int, @param10 int, @param11 int, @param9b int
declare curQuest Cursor for
select itemcode, param8, param11, activate, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11 from dbo.tFVItemInfo where category = 901

-- 2. 커서오픈
open curQuest

-- 3. 커서 사용
Fetch next from curQuest into @itemcode, @checknext, @checkpre, @activate, @param1, @param2, @param3, @param4, @param5, @param6, @param7, @param8, @param9, @param10, @param11
while @@Fetch_status = 0
	Begin
		if(@activate = 1)
			begin
				if(@itemcode + 1 != @checknext)select '다음체킹 error', @itemcode itemcode, @checknext checknext
				if(@itemcode - 1 != @checkpre)select '이전체킹 error', @itemcode itemcode, @checkpre checkpre
				if(@param1 not in (0, 1, 2, 3, 5)) select '보상 error', @itemcode itemcode
				if(@param3 != @param9b) select '조건 error', @itemcode itemcode, @param3 param3, @param9b param9b
			end
		set @param9b = @param9
		Fetch next from curQuest into @itemcode, @checknext, @checkpre, @activate, @param1, @param2, @param3, @param4, @param5, @param6, @param7, @param8, @param9, @param10, @param11
	end

-- 4. 커서닫기
close curQuest
Deallocate curQuest
*/

--select (10* 7) / 10

--alter table dbo.tFVUserMaster add tradefailcnt	int					default(0)
--update dbo.tFVUserMaster set tradefailcnt = 0

--select famelvbest, * from dbo.tFVUserMaster where gameid = 'guest186'


/*
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserMaster_kakaouserid')
   DROP INDEX tFVUserMaster.idx_tFVUserMaster_kakaouserid
GO
CREATE INDEX idx_tFVUserMaster_kakaouserid ON tUserMaster (kakaouserid)
GO
*/

--select '닉네임' + ltrim(rtrim(str(idx))), * from dbo.tFVUserMaster where kakaonickname = ''
--update dbo.tFVUserMaster set kakaonickname = '닉네임' + ltrim(rtrim(str(idx))) where kakaonickname = ''
--select * from dbo.tFVUserMaster where kakaoprofile = ''


/*
-- 계정 복구방법
update dbo.tFVKakaoMaster set gameid = 'guest188' where kakaouserid = '88258263875124913'
update dbo.tFVUserMaster set kakaostatus = 1 where gameid = 'guest188'
select * from dbo.tFVKakaoMaster where kakaouserid = '88258263875124913'
*/

/*
alter table dbo.tFVKakaoMaster add kakaouserid		varchar(20) default('')
update dbo.tFVKakaoMaster set kakaouserid = ''


IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoMaster_kakaouserid')
    DROP INDEX tFVKakaoMaster.idx_tFVKakaoMaster_kakaouserid
GO
CREATE INDEX idx_tFVKakaoMaster_kakaouserid ON tKakaoMaster (kakaouserid)
GO
*/

/*
--select top 1 kakaotalkid, gameid from dbo.tFVKakaoMaster where kakaotalkid = @kakaotalkid_
select * from dbo.tFVKakaoMaster order by idx desc
*/
/*
declare @kakaotalkid	varchar(20)
declare @kakaouserid	varchar(20)
declare @gameid			varchar(60)
declare curKakaoMaster Cursor for
select kakaotalkid, gameid from dbo.tFVKakaoMaster

-- 2. 커서오픈
open curKakaoMaster

-- 3. 커서 사용
Fetch next from curKakaoMaster into @kakaotalkid, @gameid
while @@Fetch_status = 0
	Begin
		select top 1 @kakaouserid = kakaouserid from dbo.tFVUserMaster where gameid = @gameid

		update dbo.tFVKakaoMaster
			set
				kakaouserid = @kakaouserid
		where kakaotalkid = @kakaotalkid

		Fetch next from curKakaoMaster into @kakaotalkid, @gameid
	end

-- 4. 커서닫기
close curKakaoMaster
Deallocate curKakaoMaster
*/

/*
-- 1-1. 데이타 읽어오기.
select top 5 * from dbo.tFVCashLog
where idx > isnull((select top 1 checkidx from dbo.tFVCashLogKakaoSend order by checkidx desc), 0)
and kakaosend = -1
order by idx asc

-- 2-1. 마킹하기.
if(not exists(select top 1 * from dbo.tFVCashLogKakaoSend))
	begin
		insert into dbo.tFVCashLogKakaoSend(checkidx) values(89)
	end
else
	begin
		update dbo.tFVCashLogKakaoSend set checkidx = 89
	end

-- 2-2.
update dbo.tFVCashLog set kakaosend = 1 where idx in (85, 86, 87, 88, 89)
update dbo.tFVCashLog set kakaosend = 1 where idx in (select '85, 86, 87, 88, 89')
*/

/*
-- 숫자열 리스트를 적용해서 숫자 리스트로 사용하기.
declare @intArray varchar(200)
set @intArray = '1, 2, 3, 4'
SELECT * FROM tbl_Employee WHERE employeeID IN ( @intArray )


EXECUTE('SELECT * FROM tbl_Employee WHERE employeeID IN ('+@intArray+')')
*/


/*
alter table dbo.tFVUserAdLog add nickname		varchar(20)
update dbo.tFVUserAdLog set nickname = gameid

alter table dbo.tFVCashLog add kakaosend		int				default(-1)
update dbo.tFVCashLog set kakaosend = -1

---------------------------------------------
-- 	캐쉬전송
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVCashLogKakaoSend', N'U') IS NOT NULL
	DROP TABLE dbo.tFVCashLogKakaoSend;
GO

create table dbo.tFVCashLogKakaoSend(
	checkidx		int,

	-- Constraint
	CONSTRAINT	pk_tCashLogKakaoSend_checkidx	PRIMARY KEY(checkidx)
)
*/



--update dbo.tFVUserMaster set kakaoprofile = 'http://th-p.talk.kakao.co.kr/th/talkp/wkfjowqYrv/dpGpFdOL1r2k99gQVspP20/4haroa_110x110_c.jpg' where gameid = 'farmgirl'

/*
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVCashLog_acode')
    DROP INDEX tFVCashLog.idx_tFVCashLog_acode
GO
CREATE INDEX idx_tFVCashLog_acode ON tCashLog (acode)
GO
*/

/*
alter table dbo.tFVCashLog add kakaouserid		varchar(20)		default('')
alter table dbo.tFVCashLog add kakaouk			varchar(19)		default('')
update dbo.tFVCashLog set kakaouserid = '', kakaouk = ''
*/

/*
--select cast(replace(NEWID(), '-', '') as int)
--select checksum(newid())
--Select Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(12),Getdate(),114),':','') + Convert(varchar(2), Convert(int, ceiling(RAND() * 89))+10)
--select substring(Convert(varchar(10),Getdate(),112), 3, 8)
--Select substring(Convert(varchar(10),Getdate(),112), 3, 8) + Replace(Convert(varchar(12),Getdate(),114),':','') + Convert(varchar(4), Convert(int, ceiling(RAND() * 9980))+10)


declare @loop int set @loop = 1
while @loop < 100
	begin
		--select Convert(varchar(2), Convert(int, ceiling(RAND() * 89))+10)
		Select Convert(varchar(10),Getdate(),112) + Replace(Convert(varchar(12),Getdate(),114),':','') + Convert(varchar(2), Convert(int, ceiling(RAND() * 89))+10)
		set @loop = @loop + 1
	end
*/



/*
alter table dbo.tFVUserMaster add kakaomsginvitetodaycnt	int			default(0)
alter table dbo.tFVUserMaster add kakaomsginvitetodaydate	datetime	default(getdate())
update dbo.tFVUserMaster set kakaomsginvitetodaycnt = 0, kakaomsginvitetodaydate = getdate()
*/

--select top 1 * from dbo.tFVUserItem

--alter table dbo.tFVUserFriend add helpdate		datetime			default(getdate()-1)
--update dbo.tFVUserFriend set helpdate = getdate() - 1

/*
---------------------------------------------
--		Kakao 도와줘 친구야~~~ (Wait) 24H유효
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVKakaoHelpWait', N'U') IS NOT NULL
	DROP TABLE dbo.tFVKakaoHelpWait;
GO

create table dbo.tFVKakaoHelpWait(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),
	friendid		varchar(20),
	listidx			int,
	helpdate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tKakaoHelpWait_idx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoHelpWait_gameid_friendid')
    DROP INDEX tFVKakaoHelpWait.idx_tFVKakaoHelpWait_gameid_friendid
GO
CREATE INDEX idx_tFVKakaoHelpWait_gameid_friendid ON tKakaoHelpWait (gameid, friendid)
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoHelpWait_gameid_helpdate')
    DROP INDEX tFVKakaoHelpWait.idx_tFVKakaoHelpWait_gameid_helpdate
GO
CREATE INDEX idx_tFVKakaoHelpWait_gameid_helpdate ON tKakaoHelpWait (gameid, helpdate)
GO
-- insert into dbo.tFVKakaoHelpWait(gameid, friendid, listidx) values( 'xxxx3', 'xxxx2', 1)
-- select * from dbo.tFVKakaoHelpOrder where gameid = 'xxxx3'
-- update dbo.tFVUserItem set helpcnt = 신선도에따른 2, 3, 4, 5
-- delete from dbo.tFVKakaoHelpOrder where idx = 1
*/

/*
---------------------------------------------
--		Kakao 초대
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVKakaoInvite', N'U') IS NOT NULL
	DROP TABLE dbo.tFVKakaoInvite;
GO

create table dbo.tFVKakaoInvite(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),
	recetalkid		varchar(20),
	cnt				int					default(1),
	senddate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tKakaoInvite_idx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoInvite_gameid_recetalkid')
    DROP INDEX tFVKakaoInvite.idx_tFVKakaoInvite_gameid_recetalkid
GO
CREATE INDEX idx_tFVKakaoInvite_gameid_recetalkid ON tKakaoInvite (gameid, recetalkid)
GO

-- select top 1 * from dbo.tFVKakaoInvite where gameid = 'xxxx2' and recetalkid = 'kakaotalkid13'
-- select datediff(d, '2014-03-01 12:20', '2014-03-06 12:20')	-- 5일차
-- insert into dbo.tFVKakaoInvite(gameid, recetalkid) values('xxxx2', 'kakaotalkid13')
-- update dbo.tFVKakaoInvite
--	set
--		cnt = cnt + 1,
--		senddate = getdate()
--	where gameid = 'xxxx2' and recetalkid = 'kakaotalkid13'

-- select * from dbo.tFVKakaoInvite
-- select datediff(d, senddate, getdate()) from dbo.tFVKakaoInvite
*/


/*
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserMaster_kakaonickname')
   DROP INDEX tFVUserMaster.idx_tFVUserMaster_kakaonickname
GO
CREATE INDEX idx_tFVUserMaster_kakaonickname ON tUserMaster (kakaonickname)
GO

*/
--alter table dbo.tFVUserMaster add kakaomsgblocked		int				default(-1)
--update dbo.tFVUserMaster set kakaomsgblocked = -1

/*
alter table dbo.tFVUserMaster add kakaotalkid			varchar(20)		default('')
alter table dbo.tFVUserMaster add kakaouserid			varchar(20)		default('')
alter table dbo.tFVUserMaster add kakaonickname		varchar(20)		default('')
alter table dbo.tFVUserMaster add kakaoprofile		varchar(512)	default('')
alter table dbo.tFVUserMaster add kakaomsgblocked		int				default(-1)
alter table dbo.tFVUserMaster add kakaostatus			int				default(1)
alter table dbo.tFVUserMaster add kakaomsginvitecnt	int				default(0)

update dbo.tFVUserMaster set kakaotalkid = '', kakaouserid = '',  kakaonickname= '', kakaoprofile = '', kakaomsgblocked = -1, kakaostatus = 1, kakaomsginvitecnt = 0


alter table dbo.tFVUserItem add helpcnt			int					default(0)

update dbo.tFVUserItem set helpcnt = 0


alter table dbo.tFVUserFriend add kakaofriendkind			int					default(1)

update dbo.tFVUserFriend set kakaofriendkind = 1


---------------------------------------------
--		Kakao Master
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVKakaoMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVKakaoMaster;
GO

create table dbo.tFVKakaoMaster(
	idx				int					IDENTITY(1,1),

	kakaotalkid		varchar(20),
	gameid			varchar(20),
	cnt				int					default(1),					--보유량

	-- Constraint
	CONSTRAINT	pk_tKakaoMaster_kakaotalkid	PRIMARY KEY(kakaotalkid)
)

--IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoMaster_idx')
--    DROP INDEX tFVKakaoMaster.idx_tFVKakaoMaster_idx
--GO
--CREATE INDEX idx_tFVKakaoMaster_idx ON tKakaoMaster (idx)
--GO

---------------------------------------------
--		Kakao 초대
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVKakaoInvite', N'U') IS NOT NULL
	DROP TABLE dbo.tFVKakaoInvite;
GO

create table dbo.tFVKakaoInvite(
	idx				int					IDENTITY(1,1),

	sendtalkid		varchar(20),
	recetalkid		varchar(20),
	senddate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tKakaoInvite_idx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoInvite_sendtalkid_recetalkid')
    DROP INDEX tFVKakaoInvite.idx_tFVKakaoInvite_sendtalkid_recetalkid
GO
CREATE INDEX idx_tFVKakaoInvite_sendtalkid_recetalkid ON tKakaoInvite (sendtalkid, recetalkid)
GO

---------------------------------------------
--		Kakao 도와줘 친구야~~~ (Order) 24H유효
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVKakaoHelpOrder', N'U') IS NOT NULL
	DROP TABLE dbo.tFVKakaoHelpOrder;
GO

create table dbo.tFVKakaoHelpOrder(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),
	friendid		varchar(20),
	listidx			int,
	helpdate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tKakaoHelpOrder_idx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoHelpOrder_gameid_friendid')
    DROP INDEX tFVKakaoHelpOrder.idx_tFVKakaoHelpOrder_gameid_friendid
GO
CREATE INDEX idx_tFVKakaoHelpOrder_gameid_friendid ON tKakaoHelpOrder (gameid, friendid)
GO
-- insert into dbo.tFVKakaoHelpOrder(gameid, friendid, listidx) values( 'xxxx2', 'xxxx3', 1)
-- select * from dbo.tFVKakaoHelpOrder where gameid = 'xxxx2'
-- delete from dbo.tFVKakaoHelpOrder where gameid = 'xxxx2' and helpdate < getdate() - 1

---------------------------------------------
--		Kakao 도와줘 친구야~~~ (Wait) 24H유효
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVKakaoHelpWait', N'U') IS NOT NULL
	DROP TABLE dbo.tFVKakaoHelpWait;
GO

create table dbo.tFVKakaoHelpWait(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),
	friendid		varchar(20),
	listidx			int,
	helpdate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tKakaoHelpWait_idx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVKakaoHelpWait_gameid_friendid')
    DROP INDEX tFVKakaoHelpWait.idx_tFVKakaoHelpWait_gameid_friendid
GO
CREATE INDEX idx_tFVKakaoHelpWait_gameid_friendid ON tKakaoHelpWait (gameid, friendid)
GO
-- insert into dbo.tFVKakaoHelpWait(gameid, friendid, listidx) values( 'xxxx3', 'xxxx2', 1)
-- select * from dbo.tFVKakaoHelpOrder where gameid = 'xxxx3'
-- update dbo.tFVUserItem set helpcnt = 신선도에따른 2, 3, 4, 5
-- delete from dbo.tFVKakaoHelpOrder where idx = 1
*/

/*

alter table dbo.tFVUserMaster add pmroulcnt	int						default(0)
update dbo.tFVUserMaster set pmroulcnt = 0

delete from dbo.tFVGiftList where gameid in ('xxxx2', 'xxxx6')
update dbo.tFVUserMaster set cashcost = 10000, gamecost = 10000, heart = 10000, heartget = 0, randserial = -1, bgroulcnt = 0, pmroulcnt = 0 where gameid = 'xxxx6'
exec spu_FVRoulBuy 'xxxx6', '049000s1i0n7t8445289', 1, 7776, 1, 'xxxx2', -1			-- 일반교배
exec spu_FVRoulBuy 'xxxx6', '049000s1i0n7t8445289', 1, 7777, 1, 'xxxx2', -1			-- 일반교배
exec spu_FVRoulBuy 'xxxx6', '049000s1i0n7t8445289', 1, 7778, 1, 'xxxx2', -1			-- 일반교배
exec spu_FVRoulBuy 'xxxx6', '049000s1i0n7t8445289', 1, 7779, 1, 'xxxx2', -1			-- 일반교배
exec spu_FVRoulBuy 'xxxx6', '049000s1i0n7t8445289', 1, 7770, 1, 'xxxx2', -1			-- 일반교배

exec spu_FVRoulBuy 'xxxx6', '049000s1i0n7t8445289', 1, 7771, 2, 'xxxx2', -1			-- 프리미엄교배
exec spu_FVRoulBuy 'xxxx6', '049000s1i0n7t8445289', 1, 7772, 2, 'xxxx2', -1			-- 프리미엄교배
exec spu_FVRoulBuy 'xxxx6', '049000s1i0n7t8445289', 1, 7773, 2, 'xxxx2', -1			-- 프리미엄교배
exec spu_FVRoulBuy 'xxxx6', '049000s1i0n7t8445289', 1, 7774, 2, 'xxxx2', -1			-- 프리미엄교배
exec spu_FVRoulBuy 'xxxx6', '049000s1i0n7t8445289', 1, 7775, 2, 'xxxx2', -1			-- 프리미엄교배
*/

/*
--select cast(replace(NEWID(), '-', '') as varchar(20))
insert into dbo.tFVKakaoMaster(gameid, kakaotalkid) values('xxxx',   'kakaotalkidxxxx')
insert into dbo.tFVKakaoMaster(gameid, kakaotalkid) values('xxxx2',  'kakaotalkidxxxx2')
insert into dbo.tFVKakaoMaster(gameid, kakaotalkid) values('xxxx3',  'kakaotalkidxxxx3')
insert into dbo.tFVKakaoMaster(gameid, kakaotalkid) values('xxxx4',  'kakaotalkidxxxx4')
insert into dbo.tFVKakaoMaster(gameid, kakaotalkid) values('xxxx5',  'kakaotalkidxxxx5')
insert into dbo.tFVKakaoMaster(gameid, kakaotalkid) values('xxxx6',  'kakaotalkidxxxx6')
insert into dbo.tFVKakaoMaster(gameid, kakaotalkid) values('xxxx7',  'kakaotalkidxxxx7')
insert into dbo.tFVKakaoMaster(gameid, kakaotalkid) values('xxxx8',  'kakaotalkidxxxx8')
insert into dbo.tFVKakaoMaster(gameid, kakaotalkid) values('xxxx9',  'kakaotalkidxxxx9')
insert into dbo.tFVKakaoMaster(gameid, kakaotalkid) values('superman',  'kakaotalkidsuperman')
insert into dbo.tFVKakaoMaster(gameid, kakaotalkid) values('superman2', 'kakaotalkidsuperman2')
insert into dbo.tFVKakaoMaster(gameid, kakaotalkid) values('superman3', 'kakaotalkidsuperman3')
insert into dbo.tFVKakaoMaster(gameid, kakaotalkid) values('superman5', 'kakaotalkidsuperman5')
insert into dbo.tFVKakaoMaster(gameid, kakaotalkid) values('supermani', 'kakaotalkidiphone')
insert into dbo.tFVKakaoMaster(gameid, kakaotalkid) values('superman12',  'kakaotalkidsuperma12')

-- update dbo.tFVUserMaster set kakaonickname = 'nn' + gameid

declare @loop			int				set @loop = 1
declare @gameid			varchar(60)
declare @kakaotalkid	varchar(20)
declare curKakaoMaster Cursor for
select kakaotalkid, gameid from dbo.tFVKakaoMaster

-- 2. 커서오픈
open curKakaoMaster

-- 3. 커서 사용
Fetch next from curKakaoMaster into @kakaotalkid, @gameid
while @@Fetch_status = 0
	Begin
		update dbo.tFVUserMaster
			set
				kakaotalkid = @kakaotalkid,
				kakaouserid = '0000000000' + ltrim(rtrim(str(@loop))),
				kakaoprofile = 'http://th-p7.talk.kakao.co.kr/th/talkp/wkdQ2VXalN/F3JjweZ1uXE8j0tClfGMVK/qxpezo_110x110_c.jpg'
		where gameid = @gameid

		set @loop = @loop + 1
		Fetch next from curKakaoMaster into @kakaotalkid, @gameid
	end

-- 4. 커서닫기
close curKakaoMaster
Deallocate curKakaoMaster


*/

/*
exec spu_FVSubGiftSend 2,     1, 'SysCash', 'guest91930', ''
exec spu_FVSubGiftSend 2,     1, 'SysCert', 'guest91930', ''
exec spu_FVSubGiftSend 2,     1, 'SysRoul', 'guest91930', ''
exec spu_FVSubGiftSend 2,     1, 'SysCom', 'guest91930', ''
exec spu_FVSubGiftSend 2,     1, 'SysRank', 'guest91930', ''
exec spu_FVSubGiftSend 2,     1, 'SysLogin', 'guest91930', ''
exec spu_FVSubGiftSend 2,     1, 'DailyReward', 'guest91930', ''
exec spu_FVSubGiftSend 2,     1, 'roulhear', 'guest91930', ''
exec spu_FVSubGiftSend 2,     1, 'SysDogam', 'guest91930', ''
exec spu_FVSubGiftSend 2,     1, 'SysTut', 'guest91930', ''
exec spu_FVSubGiftSend 2,     1, 'SysHarvest', 'guest91930', ''
exec spu_FVSubGiftSend 2,     1, 'SysEpi', 'guest91930', ''
exec spu_FVSubGiftSend 2,     1, 'SysTrade', 'guest91930', ''
exec spu_FVSubGiftSend 2,     1, 'SysPack', 'guest91930', ''
*/


/*
alter table dbo.tFVUserMaster add country		int						default(1)
update dbo.tFVUserMaster set country =  1
*/


/*
--촉진제 심기
exec spu_FVSeedPlant 'xxxx2', '049000s1i0n7t8445289',  8, 607, 0, -1	-- 촉진 > 소모(선물함).

exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  8, 2, 0, -1	-- 촉진 > 소모(선물함).

exec spu_FVSeedHarvest 'xxxx2', '049000s1i0n7t8445289',  8, 1, 0, -1	-- 촉진 > 소모(선물함).


exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 3417597, -1, -1,  1, -1	-- 촉진제

*/


/*
-- 촉진제 선물, 받기
exec spu_FVSubGiftSend 2,  1100, 'SysLogin', 'xxxx6', ''				-- 촉진제
exec spu_FVSubGiftSend 2,  1101, 'SysLogin', 'xxxx6', ''				-- 촉진제
exec spu_FVSubGiftSend 2,  1102, 'SysLogin', 'xxxx6', ''				-- 촉진제
exec spu_FVSubGiftSend 2,  1103, 'SysLogin', 'xxxx6', ''				-- 촉진제
exec spu_FVSubGiftSend 2,  1104, 'SysLogin', 'xxxx6', ''				-- 촉진제
exec spu_FVSubGiftSend 2,  1105, 'SysLogin', 'xxxx6', ''				-- 촉진제
exec spu_FVSubGiftSend 2,  1106, 'SysLogin', 'xxxx6', ''				-- 촉진제
exec spu_FVSubGiftSend 2,  1107, 'SysLogin', 'xxxx6', ''				-- 촉진제
exec spu_FVSubGiftSend 2,  1108, 'SysLogin', 'xxxx6', ''				-- 촉진제
exec spu_FVSubGiftSend 2,  1109, 'SysLogin', 'xxxx6', ''				-- 촉진제
exec spu_FVSubGiftSend 2,  1110, 'SysLogin', 'xxxx6', ''				-- 촉진제
exec spu_FVSubGiftSend 2,  1111, 'SysLogin', 'xxxx6', ''				-- 촉진제

exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 3417583, -1, -1,  1, -1	-- 촉진제
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 3417584, -1, -1,  1, -1
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 3417585, -1, -1,  1, -1
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 3417586, -1, -1,  1, -1
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 3417587, -1, -1,  1, -1
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 3417588, -1, -1,  1, -1
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 3417589, -1, -1,  1, -1
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 3417590, -1, -1,  1, -1
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 3417591, -1, -1,  1, -1
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 3417592, -1, -1,  1, -1
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 3417593, -1, -1,  1, -1
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -3, 3417594, -1, -1,  1, -1
*/

/*
--촉진제 묶음 구매, 판매 > OK
update dbo.tFVUserMaster set gamecost = 10000 where gameid = 'xxxx7'
exec spu_FVItemBuy 'xxxx7', '049000s1i0n7t8445289', 1100, 1, -1, -1,  1, 7781, -1	-- 촉진제
exec spu_FVItemBuy 'xxxx7', '049000s1i0n7t8445289', 1100, 1,  1, -1,  1, 7783, -1	-- 촉진제(새것 > 세팅변경)
exec spu_FVItemBuy 'xxxx7', '049000s1i0n7t8445289', 1100,10,  1, -1,  1, 7784, -1	-- 촉진제(새것 > 세팅변경)

exec spu_FVItemSell 'xxxx7', '049000s1i0n7t8445289', 1, 1, -1	-- 촉진제

update dbo.tFVUserMaster set gamecost = 10000 where gameid = 'xxxx7'
exec spu_FVItemBuy 'xxxx7', '049000s1i0n7t8445289', 1101, 1, -1, -1,  1, 7781, -1	-- 촉진제
exec spu_FVItemBuy 'xxxx7', '049000s1i0n7t8445289', 1101, 1,  2, -1,  1, 7783, -1	-- 촉진제(새것 > 세팅변경)
exec spu_FVItemBuy 'xxxx7', '049000s1i0n7t8445289', 1101, 10,  2, -1,  1, 7784, -1	-- 촉진제(새것 > 세팅변경)

exec spu_FVItemSell 'xxxx7', '049000s1i0n7t8445289', 2, 1, -1	-- 촉진제

update dbo.tFVUserMaster set gamecost = 10000 where gameid = 'xxxx7'
exec spu_FVItemBuy 'xxxx7', '049000s1i0n7t8445289', 1102, 10, -1, -1,  1, 7781, -1	-- 촉진제
exec spu_FVItemBuy 'xxxx7', '049000s1i0n7t8445289', 1102, 10,  3, -1,  1, 7783, -1	-- 촉진제(새것 > 세팅변경)
exec spu_FVItemBuy 'xxxx7', '049000s1i0n7t8445289', 1102, 10,  3, -1,  1, 7784, -1	-- 촉진제(새것 > 세팅변경)

exec spu_FVItemSell 'xxxx7', '049000s1i0n7t8445289', 3, 1, -1	-- 촉진제

update dbo.tFVUserMaster set gamecost = 10000 where gameid = 'xxxx7'
exec spu_FVItemBuy 'xxxx7', '049000s1i0n7t8445289', 1103, 10, -1, -1,  1, 7781, -1	-- 촉진제
exec spu_FVItemBuy 'xxxx7', '049000s1i0n7t8445289', 1103, 10,  4, -1,  1, 7783, -1	-- 촉진제(새것 > 세팅변경)
exec spu_FVItemBuy 'xxxx7', '049000s1i0n7t8445289', 1103, 10,  4, -1,  1, 7784, -1	-- 촉진제(새것 > 세팅변경)

exec spu_FVItemSell 'xxxx7', '049000s1i0n7t8445289', 4, 1, -1	-- 촉진제
*/


/*
-- 랜덤.
declare @loop int set @loop = 1
while @loop < 2000
	begin
		SELECT top 1 * FROM dbo.tFVItemInfo
		order by ABS(CAST( (BINARY_CHECKSUM(*) * RAND()) as int))
		set @loop = @loop + 1
	end


declare @loop int set @loop = 1
while @loop < 2000
	begin
		SELECT top 1 * FROM dbo.tFVItemInfo
		order by newid()
		set @loop = @loop + 1
	end
*/
/*
declare @petmax		int,
		@petrand	int
select @petmax	= max(CAST(param10 as int)) from dbo.tFVItemInfo where subcategory = 1000
set @petrand 	= Convert(int, ceiling(RAND() * @petmax))
select @petmax, @petrand

select * from
	(
		select
			(ABS(CAST( (BINARY_CHECKSUM(*) * RAND()) as int)) % @petmax) as petrand,
			itemcode,
			cashcost,
			param5
		from dbo.tFVItemInfo
		where subcategory = 1000
			  and itemcode not in ((select itemcode from dbo.tFVUserItem
	  							   where gameid = 'xxxx2'
	  									 and invenkind = 1000
	  									 and petupgrade >= 6))
	) b
where petrand < @petrand
order by 1 desc
*/
/*
-- 부활석 차등부활
exec spu_FVSubGiftSend 2,  1200, 'SysLogin', 'xxxx2', ''				-- 1
exec spu_FVSubGiftSend 2,     1, 'SysLogin', 'xxxx2', ''				-- 1
exec spu_FVSubGiftSend 2,     9, 'SysLogin', 'xxxx2', ''				-- 2
exec spu_FVSubGiftSend 2,    112, 'SysLogin', 'xxxx2', ''				-- 3
exec spu_FVSubGiftSend 2,    212, 'SysLogin', 'xxxx2', ''				-- 4
exec spu_FVSubGiftSend 2,    214, 'SysLogin', 'xxxx2', ''				-- 5


exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 7226, -1, -1, -1, -1	--
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 7227, -1, -1, -1, -1	--
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 7228, -1, -1, -1, -1	--
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 7229, -1, -1, -1, -1	--
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 7230, -1, -1, -1, -1	--
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', -3, 7231, -1, -1, -1, -1	--


exec spu_FVAniDie 'xxxx2', '049000s1i0n7t8445289', 2, 1, -1		-- 1
exec spu_FVAniDie 'xxxx2', '049000s1i0n7t8445289', 2, 2, -1		-- 2
exec spu_FVAniDie 'xxxx2', '049000s1i0n7t8445289', 2, 3, -1		-- 3
exec spu_FVAniDie 'xxxx2', '049000s1i0n7t8445289', 2, 4, -1		-- 4
exec spu_FVAniDie 'xxxx2', '049000s1i0n7t8445289', 2, 5, -1		-- 5

update dbo.tFVUserMaster set cashcost = 100 where gameid = 'xxxx2'
update dbo.tFVUserItem set cnt = 5 where gameid = 'xxxx2' and listidx = 6
exec spu_FVAniRevival 'xxxx2', '049000s1i0n7t8445289', 2, 1, -1, -1		--
exec spu_FVAniRevival 'xxxx2', '049000s1i0n7t8445289', 2, 2, -1, -1		--
exec spu_FVAniRevival 'xxxx2', '049000s1i0n7t8445289', 2, 3, -1, -1		--
exec spu_FVAniRevival 'xxxx2', '049000s1i0n7t8445289', 2, 4, -1, -1		--
exec spu_FVAniRevival 'xxxx2', '049000s1i0n7t8445289', 2, 5, -1, -1		--
*/



/*
alter table dbo.tFVSystemInfo add field5lv	int						default(3)
alter table dbo.tFVSystemInfo add field6lv	int						default(6)
alter table dbo.tFVSystemInfo add field7lv	int						default(9)
alter table dbo.tFVSystemInfo add field8lv	int						default(12)
update dbo.tFVSystemInfo set field5lv = 3, field6lv = 6, field7lv = 9,  field8lv = 12

alter table dbo.tFVUserMaster add field0		int						default(1)
alter table dbo.tFVUserMaster add field1		int						default(1)
alter table dbo.tFVUserMaster add field2		int						default(1)
alter table dbo.tFVUserMaster add field3		int						default(1)
alter table dbo.tFVUserMaster add field4		int						default(1)
alter table dbo.tFVUserMaster add field5		int						default(-1)
alter table dbo.tFVUserMaster add field6		int						default(-1)
alter table dbo.tFVUserMaster add field7		int						default(-1)
alter table dbo.tFVUserMaster add field8		int						default(-1)

update dbo.tFVUserMaster set field0 =  1, field1 =  1, field2 =  1,
						   field3 =  1, field4 =  1, field5 = -1,
						   field6 = -1, field7 = -1, field8 = -1
*/


/*
alter table dbo.tFVUserMaster add heartget	int						default(0)
update dbo.tFVUserMaster set heartget = 0
*/

/*
-- 인증번호 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventCertNoBack_certno')
    DROP INDEX tFVEventCertNoBack.idx_tFVEventCertNoBack_certno
GO
CREATE INDEX idx_tFVEventCertNoBack_certno ON tEventCertNoBack (certno)
GO
*/



/*
alter table dbo.tFVUserMaster add albausesecond	int					default(-1)
alter table dbo.tFVUserMaster add albausethird	int					default(-1)
update dbo.tFVUserMaster set albausesecond = -1, albausethird = -1

alter table dbo.tFVUserSaveLog add albausesecond	int					default(-1)
alter table dbo.tFVUserSaveLog add albausethird	int					default(-1)
update dbo.tFVUserSaveLog set albausesecond = -1, albausethird = -1
*/

/*
---------------------------------------------
--		펫도감 : 개인도감
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVDogamListPet', N'U') IS NOT NULL
	DROP TABLE dbo.tFVDogamListPet;
GO

create table dbo.tFVDogamListPet(
	idx				int				IDENTITY(1,1),

	gameid			varchar(20),
	itemcode		int,
	getdate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT pk_tDogamListPet_idx	PRIMARY KEY(idx)
)

-- gameid, itemcode
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVDogamListPet_gameid_itemcode')
	DROP INDEX tFVDogamListPet.idx_tFVDogamListPet_gameid_itemcode
GO
CREATE INDEX idx_tFVDogamListPet_gameid_itemcode ON tDogamListPet (gameid, itemcode)
GO

--if(not exists(select top 1 * from dbo.tFVDogamListPet where gameid = 'xxxx' and itemcode = 1))
--	begin
--		insert into dbo.tFVDogamListPet(gameid, itemcode) values('xxxx', 1)
--	end
--select * from dbo.tFVDogamListPet where gameid = 'xxxx' order by itemcode asc
*/


/*
-- 로그인 보유하지 않는 동물 찾기
select top 1 itemcode from dbo.tFVItemInfo
where subcategory = 1000 and itemcode not in (select itemcode from dbo.tFVUserItem where gameid = 'xxxx2' and invenkind = 1000)

-- 구매


-- 뽑기
-- 교환
-- 업그레이드

select * from dbo.tFVItemInfo where subcategory = 1000
*/



/*
-- 유저 테이블.
alter table dbo.tFVUserMaster add petlistidx			int					default(-1)
alter table dbo.tFVUserMaster add petitemcode			int					default(-1)
alter table dbo.tFVUserMaster add petcooltime			int					default(0)
alter table dbo.tFVUserMaster add pettodayitemcode	int					default(-1)
update dbo.tFVUserMaster set petlistidx = -1, petitemcode = -1, petcooltime = 0, pettodayitemcode = -1
-- select top 10 petlistidx, petitemcode, petcooltime, pettodayitemcode from dbo.tFVUserMaster where gameid = 'xxxx2'

-- 아이템 테이블 추가
alter table dbo.tFVUserItem add petupgrade	int					default(1)
update dbo.tFVUserItem set petupgrade = 1
-- select top 10 petupgrade from dbo.tFVUserItem
*/
/*
alter table dbo.tFVUserMaster add etremain		int					default(-1)

update dbo.tFVUserMaster set etremain = -1
*/

/*
alter table dbo.tFVEpiReward add etcheckvalue1	int 			default(-1)
alter table dbo.tFVEpiReward add etcheckvalue2	int 			default(-1)
alter table dbo.tFVEpiReward add etcheckvalue3	int 			default(-1)

alter table dbo.tFVEpiReward add etcheckresult1	int				default(0)
alter table dbo.tFVEpiReward add etcheckresult2	int				default(0)
alter table dbo.tFVEpiReward add etcheckresult3	int				default(0)

update dbo.tFVEpiReward set etcheckvalue1 = -1, etcheckvalue2 = -1, etcheckvalue3 = -1, etcheckresult1 = 0, etcheckresult2 = 0, etcheckresult3 = 0
*/

/*
---------------------------------------------
-- 유저문의
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSysInquire', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSysInquire;
GO

create table dbo.tFVSysInquire(
	idx					int 				IDENTITY(1, 1),

	gameid				varchar(20),
	state				int					default(0),				-- 요청대기[0], 체킹중[1], 완료[2]
	comment				varchar(1024)		default(''),
	writedate			datetime			default(getdate()),

	adminid				varchar(20)			default(''),
	comment2			varchar(1024)		default(''),
	dealdate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSysInquire_idx	PRIMARY KEY(idx)
)
-- select top 10 * from dbo.tFVSysInquire order by idx desc
-- insert into dbo.tFVSysInquire(gameid, comment) values(1, '잘안됩니다.')
-- update dbo.tFVSysInquire set state = 1, dealdate = getdate(), comment2 = '진행중입니다.' where idx = 1
-- update dbo.tFVSysInquire set state = 2, dealdate = getdate(), comment2 = '처리했습니다.' where idx = 1
-- if(2)쪽지로 발송된다.
*/
/*
declare @pageList		int						set @pageList		= 3

declare @PAGE_LINE		int						set @PAGE_LINE		= 5
declare @pagemax		int						set @pagemax		= 1
declare @page			int						set @page			= 1
declare @idx			int						set @idx			= 1

select @idx = (isnull(max(idx), 1)) from dbo.tFVSysInquire

set @pagemax	= @idx / @PAGE_LINE
set @pagemax 	= @pagemax + case when (@idx % @PAGE_LINE != 0) then 1 else 0 end
set @page		= case
					when (@pageList <= 0)			then 1
					when (@pageList >  @pagemax)	then @pagemax
					else @pageList
				end
set @idx		= @idx - (@page - 1) * @PAGE_LINE

select top 5 @pagemax pagemax, @page page, * from dbo.tFVSysInquire
where idx <= @idx order by idx desc
*/

/*
-- 카카오톡 정보입력
alter table dbo.tFVUserMaster add kkopushallow	int					default(1)
alter table dbo.tFVUserMaster add kkomembernum	varchar(20)			default('')
alter table dbo.tFVUserMaster add kkopicture		varchar(80)			default('')

update dbo.tFVUserMaster set kkopushallow = 1, kkomembernum = '', kkopicture = ''

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserMaster_kkomembernum')
    DROP INDEX tFVUserMaster.idx_tFVUserMaster_kkomembernum
GO
CREATE INDEX idx_tFVUserMaster_kkomembernum ON tUserMaster (kkomembernum)
GO
*/

/*
--로그마스터 테이블 입력
alter table dbo.tFVDayLogInfoStatic add certnocnt		int				default(0)
update dbo.tFVDayLogInfoStatic set certnocnt = 0


---------------------------------------------
-- 이벤트 인증키값
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEventCertNo', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEventCertNo;
GO

create table dbo.tFVEventCertNo(
	idx			int				identity(1, 1),
	certno		varchar(16),
	itemcode1	int				default(-1),
	itemcode2	int				default(-1),
	itemcode3	int				default(-1),
	CONSTRAINT	pk_tEventCertNo_idx	PRIMARY KEY(idx)
)
-- 인증번호 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventCertNo_certno')
    DROP INDEX tFVEventCertNo.idx_tFVEventCertNo_certno
GO
CREATE INDEX idx_tFVEventCertNo_certno ON tEventCertNo (certno)
GO

---------------------------------------------
-- 이벤트 인증키값(백업)
-- 누구에게 무슨아이템을 지급했다.
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEventCertNoBack', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEventCertNoBack;
GO

create table dbo.tFVEventCertNoBack(
	idx			int				identity(1, 1),
	certno		varchar(16),

	gameid		varchar(20),
	itemcode1	int				default(-1),
	itemcode2	int				default(-1),
	itemcode3	int				default(-1),
	usedtime	datetime		default(getdate()),

	CONSTRAINT	pk_tEventCertNoBack_idx	PRIMARY KEY(idx)
)
*/


/*
select * from dbo.tFVEpiReward
where gameid = 'xxxx2'
order by etyear asc


select * from dbo.tFVEpiReward
where gameid = 'xxxx2'
order by idx asc


select * from dbo.tFVEpiReward
where gameid = 'xxxx2'
order by idx asc
*/

/*
-- select * from dbo.tFVUserMaster where regdate > '2014-01-11 12:00' and regdate < '2014-01-11 15:00'

-- 테스트 중 코인지급
-- update dbo.tFVUserMaster set cashcost = 9999, fpoint = 1000 where regdate > '2014-01-11 12:00' and regdate < '2014-01-11 15:00'
*/

/*
-- 만렙 만들기.
---------------------------------
-- 빠진 농장 입력해주시.
---------------------------------
declare @gameid			varchar(60)
declare curUserMaster Cursor for
select gameid from dbo.tFVUserMaster where regdate > '2014-01-11 12:00' and regdate < '2014-01-11 15:00'
--select gameid from dbo.tFVUserMaster where gameid = 'xxxx2'

-- 2. 커서오픈
open curUserMaster

-- 3. 커서 사용
Fetch next from curUserMaster into @gameid
while @@Fetch_status = 0
	Begin
		exec spu_FVFarmD 19, 65,  4, 9999, -1, -1, -1, -1, -1, -1, @gameid, 'admin', '', '', '', '', '', '', '', ''			--      명성도
		Fetch next from curUserMaster into @gameid
	end

-- 4. 커서닫기
close curUserMaster
Deallocate curUserMaster


-- 테스트 완료후 클리어
-- update dbo.tFVUserMaster set cashcost = 100, fpoint = 100, heart = 120 where gameid in (select gameid from dbo.tFVUserMaster where regdate > '2014-01-11 12:00' and regdate < '2014-01-11 15:00')
*/


/*
alter table dbo.tFVUserPushAndroid add scheduleTime	datetime		default(getdate())
update dbo.tFVUserPushAndroid set scheduleTime = getdate()

alter table dbo.tFVUserPushAndroidLog add scheduleTime	datetime	default(getdate())
update dbo.tFVUserPushAndroidLog set scheduleTime = getdate()


alter table dbo.tFVUserPushiPhone add scheduleTime	datetime		default(getdate())
update dbo.tFVUserPushiPhone set scheduleTime = getdate()

alter table dbo.tFVUserPushiPhoneLog add scheduleTime	datetime		default(getdate())
update dbo.tFVUserPushiPhoneLog set scheduleTime = getdate()


--update dbo.tFVUserPushAndroid set scheduleTime = dateadd(ss, 20, getdate())
--select * from dbo.tFVUserPushAndroid
--select * from dbo.tFVUserPushAndroid where scheduleTime < getdate()
--select * from dbo.tFVUserPushiPhone where scheduleTime < getdate()
*/

/*
select * from dbo.tFVEpiReward
where gameid = 'xxxx2'
order by itemcode asc
*/


/*
update dbo.tFVUserMaster set gameyear = 2017, gamemonth = 11, frametime = 0, etsalecoin = 1000, fame = 5, famelv = 2, tradecnt = 1, prizecnt = 1 where gameid = 'xxxx2'
update dbo.tFVUserMaster set gamecost = 0, cashcost = 0, feed = 0, heart = 0, adidx = 0 where gameid = 'xxxx2'
update dbo.tFVSchoolMaster set totalpoint = 0 where schoolidx = (select schoolidx from dbo.tFVUserMaster where gameid = 'xxxx2')
update dbo.tFVSchoolUser set point = 0 where gameid = 'xxxx2'
delete from dbo.tFVUserSaleLog where gameid = 'xxxx2'
delete from dbo.tFVGiftList where gameid = 'xxxx2'
delete from dbo.tFVEpiReward where gameid = 'xxxx2'
exec spu_FVGameTrade2 'xxxx2', '049000s1i0n7t8445289', '0:2018;  1:12;      2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:16;    43:1;',
													'1:5,1,1;3:5,23,0;4:5,25,-1;',
													'14:1;15:1;16:1;',
													'0:5; 1:2;   10:2;    11:1;    12:75;    20:10;    30:1;      31:10;    32:1;         33:7;     34:20;    35:77;  40:-1;',
													'0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;',
													-1										-- 필드없음.


-- 다음달.
exec spu_FVGameTrade 'xxxx2', '049000s1i0n7t8445289', '0:2019;  1:1;      2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:16;    43:1;',
													'1:5,1,1;3:5,23,0;4:5,25,-1;',
													'14:1;15:1;16:1;',
													'0:5; 1:2;   10:2;    11:1;    12:75;    20:10;    30:1;      31:10;    32:1;         33:7;     34:20;    35:77;  40:-1;',
													'0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;',
													-1										-- 필드없음.


-- 에피소드 대회.
update dbo.tFVUserMaster set gameyear = 2021, gamemonth = 11, etsalecoin = 1000, gamecost = 0, cashcost = 0, feed = 0, heart = 0, adidx = 0 where gameid = 'xxxx2'
delete from dbo.tFVUserSaleLog where gameid = 'xxxx2'
delete from dbo.tFVGiftList where gameid = 'xxxx2'
delete from dbo.tFVEpiReward where gameid = 'xxxx2'
exec spu_FVGameTrade2 'xxxx2', '049000s1i0n7t8445289', '0:2021;  1:12;      2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:16;    43:1;',
													'1:5,1,1;3:5,23,0;4:5,25,-1;',
													'14:1;15:1;16:1;',
													'0:5; 1:2;   10:2;    11:1;    12:75;    20:10;    30:1;      31:10;    32:1;         33:7;     34:20;    35:77;  40:-1;',
													'0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;',
													-1										-- 필드없음.


*/

/*
select * from dbo.tFVUserItem where gameid = 'test01'
select * from dbo.tFVUserItem where gameid = 'farmgirl' and fieldidx >= 0 order by fieldidx asc

update dbo.tFVUserItem set anistep = 5, manger = 25 where gameid = 'farmgirl'
*/


/*
select * from dbo.tFVUsermaster where gameid = 'test01'
exec spu_FVChangePW 'farmgirl',   '7575970askeie1595312', '01000000000', -1
update dbo.tFVUserItem set acc1 = 1425, acc2 = -1 where gameid = 'farmgirl' and listidx = 20
*/

/*
exec spu_FVUserFarmList 'xxxx2', 1
exec spu_FVUserFarmList '', 1

alter table dbo.tFVUserFarm add buywhere		int					default(1)
update dbo.tFVUserFarm set buywhere = 1
*/

/*
declare @gameid varchar(60)			set @gameid = 'xxxx2'
declare @password varchar(20)		set @password = '049000s1i0n7t8445289'
update dbo.tFVUserMaster set gameyear = 2017, gamemonth = 12, frametime = 0 where gameid = @gameid
update dbo.tFVUserMaster set fame = 5, famelv = 2, tradecnt = 1, prizecnt = 1 where gameid = @gameid
update dbo.tFVUserMaster set gamecost = 0, cashcost = 0, feed = 0, heart = 0, adidx = 0 where gameid = @gameid
update dbo.tFVSchoolMaster set totalpoint = 0 where schoolidx = (select schoolidx from dbo.tFVUserMaster where gameid = @gameid)
update dbo.tFVSchoolUser set point = 0 where gameid = @gameid
delete from dbo.tFVUserSaleLog where gameid = @gameid
delete from dbo.tFVGiftList where gameid = @gameid
delete from dbo.tFVEpiReward where gameid = @gameid				-- 전국목장선물.
update dbo.tFVUserFarm set buystate = -1 where gameid = @gameid
exec spu_FVGameTrade @gameid, @password, '0:2018;  1:1;      2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:16;    43:1;',
										'1:5,1,1;3:5,23,0;4:5,25,-1;',
										'14:1;15:1;16:1;',
										'0:5; 1:2;   10:2;    11:1;    12:75;    20:10;    30:1;      31:10;    32:1;         33:7;     34:20;    35:77;  40:-1;',
										'0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;',
										-1										-- 필드없음.
*/


/*
---------------------------------
-- 빠진 농장 입력해주시.
---------------------------------
declare @gameid			varchar(60)
declare curUserFarm Cursor for
select gameid from dbo.tFVUserMaster where gameid like 'xxxx%'


-- 2. 커서오픈
open curUserFarm

-- 3. 커서 사용
Fetch next from curUserFarm into @gameid
while @@Fetch_status = 0
	Begin

		insert into dbo.tFVUserFarm(farmidx, gameid, itemcode)
		select 25 + rank() over(order by itemcode asc) as farmidx, @gameid, itemcode
		from dbo.tFVItemInfo
		where subcategory = 69 and itemcode not in (select itemcode from dbo.tFVUserFarm where gameid = @gameid)
		order by itemcode asc

		Fetch next from curUserFarm into @gameid
	end

-- 4. 커서닫기
close curUserFarm
Deallocate curUserFarm
*/

/*
declare @gameyear			int, @gamemonth			int
	-- 에피소드 누정.
	declare @etsalecoin			int			set @etsalecoin		= 0
	declare @etgrade			int			set @etgrade		= 0
	declare @etreward1			int			set @etreward1		= -1
	declare @etreward2			int			set @etreward2		= -1
	declare @etreward3			int			set @etreward3		= -1
	declare @etreward4			int			set @etreward4		= -1
	declare @subcategory		int			set @subcategory	= -1

	declare @etitemcode			int			set @etitemcode		= 91000
	declare @etcheckvalue1		int			set @etcheckvalue1	= 9999
	declare @etcheckvalue2		int			set @etcheckvalue2	= 99999
	declare @etcheckvalue3		int			set @etcheckvalue3	= 999999
	declare @etrewardbad1		int			set @etrewardbad1	= -1
	declare @etrewardnor1		int			set @etrewardnor1	= -1
	declare @etrewardnor2		int			set @etrewardnor2	= -1
	declare @etrewardgood1		int			set @etrewardgood1	= -1
	declare @etrewardgood2		int			set @etrewardgood2	= -1
	declare @etrewardgood3		int			set @etrewardgood3	= -1
	declare @etrewardex1		int			set @etrewardex1	= -1
	declare @etrewardex2		int			set @etrewardex2	= -1
	declare @etrewardex3		int			set @etrewardex3	= -1
	declare @etrewardex4		int			set @etrewardex4	= -1
	declare @ITEM_SUBCATEGORY_EPISODE			int					set @ITEM_SUBCATEGORY_EPISODE				= 910 	--에피소드(910)


set @gameyear = 2013+5
set @gamemonth = 1
					select
							@etitemcode		= itemcode,
							@etcheckvalue1	= param2,		@etcheckvalue2	= param3,	@etcheckvalue3	= param4,
							@etrewardbad1	= param5,
							@etrewardnor1	= param6,		@etrewardnor2	= param7,
							@etrewardgood1	= param8,		@etrewardgood2	= param9,	@etrewardgood3	= param10,
							@etrewardex1	= param11,		@etrewardex2	= param12,	@etrewardex3	= param13,		@etrewardex4	= param14
					from dbo.tFVItemInfo
					where subcategory = @ITEM_SUBCATEGORY_EPISODE and param1 = @gameyear
					select 'DEBUG 에피소드 결과지급 ', @gameyear gameyear, @gamemonth gamemonth, @etitemcode etitemcode, @etcheckvalue1 etcheckvalue1, @etcheckvalue2 etcheckvalue2, @etcheckvalue3 etcheckvalue3, @etrewardbad1 etrewardbad1, @etrewardnor1 etrewardnor1, @etrewardnor2 etrewardnor2, @etrewardgood1 etrewardgood1, @etrewardgood2 etrewardgood2, @etrewardgood3 etrewardgood3,@etrewardex1 etrewardex1, @etrewardex2 etrewardex2,	@etrewardex3 etrewardex3, @etrewardex4 etrewardex4
*/

/*
select invencustommax from dbo.tFVUserMaster where invencustommax < 8
update dbo.tFVUserMaster set invencustommax = 8 where invencustommax < 8


alter table dbo.tFVUserMaster add etsalecoin		int					default(0)
update dbo.tFVUserMaster set etsalecoin = 0

---------------------------------------------
--		에피소드 보상(기록된것은 보상 받은것)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEpiReward', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEpiReward;
GO

create table dbo.tFVEpiReward(
	idx				int				IDENTITY(1,1),

	gameid			varchar(20),
	itemcode		int,

	etyear			int,
	etsalecoin		int,
	etgrade			int				default(0),
	etreward1		int				default(-1),
	etreward2		int				default(-1),
	etreward3		int				default(-1),
	etreward4		int				default(-1),

	getdate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT pk_tEpiReward_idx	PRIMARY KEY(idx)
)

-- gameid, itemcode
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEpiReward_gameid_etyear')
	DROP INDEX tFVEpiReward.idx_tFVEpiReward_gameid_etyear
GO
CREATE INDEX idx_tFVEpiReward_gameid_etyear ON tEpiReward (gameid, etyear)
GO

--if(not exists(select top 1 * from dbo.tFVEpiReward where gameid = 'xxxx2' and etyear = 2018))
--	begin
--		insert into dbo.tFVEpiReward(gameid, itemcode, etyear, etsalecoin, etgrade, etreward1, etreward2, etreward3, etreward4) values('xxxx2', 91000, 2018, 1000, 0, -1, -1, -1, -1)
--	end
--select * from dbo.tFVEpiReward where gameid = 'xxxx2' order by itemcode asc
*/


/*

--update dbo.tFVUserMaster set invencustommax = 8 where invencustommax = 6
select gameid, sum(salecoin + prizecoin + playcoin), gameyear from dbo.tFVUserSaleLog
--where gameid in (select gameid from dbo.tFVUserMaster where regdate > '2013-12-20')
group by gameid, gameyear
having sum(salecoin + prizecoin + playcoin) > 100
order by gameid, gameyear asc


select gameid, gameyear, sum(salecoin + prizecoin + playcoin) from dbo.tFVUserSaleLog
where gameid in (select gameid from dbo.tFVUserMaster where regdate > '2013-12-20')
group by gameid, gameyear
having sum(salecoin + prizecoin + playcoin) > 100
order by gameid, gameyear asc

select gameid, gameyear, sum(salecoin + prizecoin + playcoin) from dbo.tFVUserSaleLog
where gameid in (select gameid from dbo.tFVUserMaster where regdate <= '2013-12-20')
group by gameid, gameyear
having sum(salecoin + prizecoin + playcoin) > 100
order by gameid, gameyear asc
*/

/*
update dbo.tFVUserMaster set gameyear = 2013, gamemonth = 3, frametime = 0 where gameid = 'guest91741'
update dbo.tFVUserMaster set fame = 5, famelv = 2, tradecnt = 1, prizecnt = 1 where gameid = 'guest91741'
update dbo.tFVUserMaster set gamecost = 1000, cashcost = 1000, feed = 1000, heart = 1000, adidx = 0 where gameid = 'guest91741'
update dbo.tFVSchoolMaster set totalpoint = 0 where schoolidx = (select schoolidx from dbo.tFVUserMaster where gameid = 'guest91741')
update dbo.tFVSchoolUser set point = 0 where gameid = 'guest91741'
delete from dbo.tFVUserSaleLog where gameid = 'guest91741'
delete from dbo.tFVGiftList where gameid = 'guest91741'
exec spu_FVGameTrade 'guest91741', '049000s1i0n7t8445289', '0:2013;  1:4;      2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:16;    43:1;',
													'1:5,1,1;3:5,23,0;4:5,25,-1;',
													'14:1;15:1;16:1;',
													'0:5; 1:2;   10:2;    11:1;    12:75;    20:10;    30:1;      31:10;    32:1;         33:7;     34:20;    35:77;  40:-1;',
													'0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;',
													-1										-- 필드없음.


declare @gameid_ varchar(60) set @gameid_ = 'guest91741'
exec spu_FVSchoolRank  4, -1, @gameid_		-- 학교랭킹.
exec spu_FVSchoolRank  7, @schoolidx, ''		-- 학교내 개인랭킹.
exec spu_FVSchoolRank  6, -1, @gameid_		-- 더미 학교랭킹.

declare @gameid_ varchar(60) set @gameid_ = 'xxxx2'
exec spu_FVSchoolRank  4, -1, @gameid_		-- 학교랭킹.
exec spu_FVSchoolRank  6, -1, @gameid_		-- 더미 학교랭킹.
*/

/*
-- default(lmcnt = 1)

update dbo.tFVUserMaster set lmcnt = 1 where lmcnt = 0
*/

/*
-- 카카오 검수.
update dbo.tFVUserMaster set tutorial	= 0, param0 = 0, param1 = 0, param2 = 0, param3 = 0, param4 = 0, param5 = 0, param6 = 0, param7 = 0, param8 = 0, param9 = 0 where gameid in ('picto1', 'picto2', 'picto3', 'kakao1', 'kakao2', 'kakao3', 'kakao9')
--select * from dbo.tFVUserMaster where gameid in ('picto1', 'picto2', 'picto3', 'kakao1', 'kakao2', 'kakao3', 'kakao9')
*/


/*
declare @gameid varchar(60)
set @gameid = 'kakao9'
exec spu_FVSubGiftSend 2,  2104, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,  2203, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,  2303, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,  1004, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,  1205, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,  2001, 'SysLogin', @gameid, ''
exec spu_FVSubGiftSend 2,  2001, 'SysLogin', @gameid, ''
*/

/*
select * from dbo.tFVUserMaster where gameid in ('picto1', 'picto2', 'picto3', 'kakao1', 'kakao2', 'kakao3', 'kakao9')

update dbo.tFVUserMaster
	set
		cashcost	= 9999,
		gamecost	= 999999,
		feed		= 20,
		fpoint		= 9900,
		heart		= heartmax
where gameid in ('picto1', 'picto2', 'picto3', 'kakao1', 'kakao2', 'kakao3', 'kakao9')
*/

/*
132	kakao1	7133578ueicea9915138	5	0	1	xxxxx	101	editxxxxxx	-1	2014-01-06 17:05:05.897	2014-01-06 17:05:05.897	1	0	0	0	0	2014-01-06 17:05:05.897	1	0		0	5500	90106	-1	0	내가 최고	2013	3	0	0	0	0	0	0	1	1	0	1	0	0	10	0	6	0	4	0	-1	0	0	0	6	400	20	20	0	9900	0	120	500	-1	-1	-1	-1	-1	-1	0	-1	-1	-1	-1	7	8	10	9	-1	-1	-1	0	0	0	0	0	-1	2014-01-06 17:05:05.897	0	-1	2014-01-06 17:05:05.897	0	-1	2014-01-06 17:05:05.897	0	-1	2014-01-06 17:05:05.897	0	-1	2014-01-06 17:05:05.897	0	-1	2014-01-06 17:05:05.897	0	-1	2014-01-06 17:05:05.897	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-1	-1	0	1	0		1	-1	-1	0		1	-1	-1	0		1	-1	-1	0	1	-1	-1
133	kakao2	7133578ueicea9915138	5	0	1	xxxxx	101	editxxxxxx	-1	2014-01-06 17:05:12.330	2014-01-06 17:05:12.330	1	0	0	0	0	2014-01-06 17:05:12.330	1	0		0	5500	90106	-1	0	내가 최고	2013	3	0	0	0	0	0	0	1	1	0	1	0	0	10	0	6	0	4	0	-1	0	0	0	6	400	20	20	0	9900	0	120	500	-1	-1	-1	-1	-1	-1	0	-1	-1	-1	-1	7	8	10	9	-1	-1	-1	0	0	0	0	0	-1	2014-01-06 17:05:12.330	0	-1	2014-01-06 17:05:12.330	0	-1	2014-01-06 17:05:12.330	0	-1	2014-01-06 17:05:12.330	0	-1	2014-01-06 17:05:12.330	0	-1	2014-01-06 17:05:12.330	0	-1	2014-01-06 17:05:12.330	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-1	-1	0	1	0		1	-1	-1	0		1	-1	-1	0		1	-1	-1	0	1	-1	-1
134	kakao3	7133578ueicea9915138	5	0	1	xxxxx	101	editxxxxxx	-1	2014-01-06 17:05:22.837	2014-01-06 17:05:22.837	1	0	0	0	0	2014-01-06 17:05:22.837	1	0		0	5500	90106	-1	0	내가 최고	2013	3	0	0	0	0	0	0	1	1	0	1	0	0	10	0	6	0	4	0	-1	0	0	0	6	400	20	20	0	9900	0	120	500	-1	-1	-1	-1	-1	-1	0	-1	-1	-1	-1	7	8	10	9	-1	-1	-1	0	0	0	0	0	-1	2014-01-06 17:05:22.837	0	-1	2014-01-06 17:05:22.837	0	-1	2014-01-06 17:05:22.837	0	-1	2014-01-06 17:05:22.837	0	-1	2014-01-06 17:05:22.837	0	-1	2014-01-06 17:05:22.837	0	-1	2014-01-06 17:05:22.837	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-1	-1	0	1	0		1	-1	-1	0		1	-1	-1	0		1	-1	-1	0	1	-1	-1
129	picto1	7133578ueicea9915138	5	0	1	xxxxx	101	editxxxxxx	-1	2014-01-06 17:02:31.327	2014-01-06 17:02:31.327	1	0	0	0	0	2014-01-06 17:02:31.327	1	0		0	5500	90106	-1	0	내가 최고	2013	3	0	0	0	0	0	0	1	1	0	1	0	0	10	0	6	0	4	0	-1	0	0	0	6	400	20	20	0	9900	0	120	500	-1	-1	-1	-1	-1	-1	0	-1	-1	-1	-1	7	8	10	9	-1	-1	-1	0	0	0	0	0	-1	2014-01-06 17:02:31.327	0	-1	2014-01-06 17:02:31.327	0	-1	2014-01-06 17:02:31.327	0	-1	2014-01-06 17:02:31.327	0	-1	2014-01-06 17:02:31.327	0	-1	2014-01-06 17:02:31.327	0	-1	2014-01-06 17:02:31.327	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-1	-1	0	1	0		1	-1	-1	0		1	-1	-1	0		1	-1	-1	0	1	-1	-1
130	picto2	7133578ueicea9915138	5	0	1	xxxxx	101	editxxxxxx	-1	2014-01-06 17:04:44.043	2014-01-06 17:04:44.043	1	0	0	0	0	2014-01-06 17:04:44.043	1	0		0	5500	90106	-1	0	내가 최고	2013	3	0	0	0	0	0	0	1	1	0	1	0	0	10	0	6	0	4	0	-1	0	0	0	6	400	20	20	0	9900	0	120	500	-1	-1	-1	-1	-1	-1	0	-1	-1	-1	-1	7	8	10	9	-1	-1	-1	0	0	0	0	0	-1	2014-01-06 17:04:44.043	0	-1	2014-01-06 17:04:44.043	0	-1	2014-01-06 17:04:44.043	0	-1	2014-01-06 17:04:44.043	0	-1	2014-01-06 17:04:44.043	0	-1	2014-01-06 17:04:44.043	0	-1	2014-01-06 17:04:44.043	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-1	-1	0	1	0		1	-1	-1	0		1	-1	-1	0		1	-1	-1	0	1	-1	-1
131	picto3	7133578ueicea9915138	5	0	1	xxxxx	101	editxxxxxx	-1	2014-01-06 17:04:50.970	2014-01-06 17:04:50.970	1	0	0	0	0	2014-01-06 17:04:50.970	1	0		0	5500	90106	-1	0	내가 최고	2013	3	0	0	0	0	0	0	1	1	0	1	0	0	10	0	6	0	4	0	-1	0	0	0	6	400	20	20	0	9900	0	120	500	-1	-1	-1	-1	-1	-1	0	-1	-1	-1	-1	7	8	10	9	-1	-1	-1	0	0	0	0	0	-1	2014-01-06 17:04:50.970	0	-1	2014-01-06 17:04:50.970	0	-1	2014-01-06 17:04:50.970	0	-1	2014-01-06 17:04:50.970	0	-1	2014-01-06 17:04:50.970	0	-1	2014-01-06 17:04:50.970	0	-1	2014-01-06 17:04:50.970	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	-1	-1	0	1	0		1	-1	-1	0		1	-1	-1	0		1	-1	-1	0	1	-1	-1
*/

/*
select top 1 * from dbo.tFVUserFriend where gameid = 'xxxx2' and friendid != 'farmgirl' and state = 2 and senddate <= getdate() - 1
select * from dbo.tFVUserFriend where gameid = 'xxxx2'
select top 1 * from dbo.tFVUserFriend where gameid = 'xxxx2' and state = 2 and senddate <= getdate() - 1
update dbo.tFVUserFriend set senddate = getdate() where gameid = 'xxxx2' and friendid != 'farmgirl'
*/


/*
select * from dbo.tFVItemInfo where itemcode = 2200
select * from dbo.tFVItemInfo where subcategory = 22

select * from dbo.tFVItemInfo where itemcode = 2300
select * from dbo.tFVItemInfo where subcategory = 23
*/

/*
declare @USERFRIEND_STATE_FRIEND			int					set	@USERFRIEND_STATE_FRIEND					= 2;		-- 2 : 상호친구
declare @gameid_	varchar(20)	set @gameid_ = 'xxxx2'


select * from dbo.tFVUserFriend where gameid = @gameid_ and state = @USERFRIEND_STATE_FRIEND and senddate <= getdate() - 1
select * from dbo.tFVUserFriend where gameid = @gameid_ and state = @USERFRIEND_STATE_FRIEND and senddate > getdate() - 1
*/

/*
declare @USERFRIEND_STATE_APPROVE_WAIT		int					set	@USERFRIEND_STATE_APPROVE_WAIT				= 1;		-- 1 : 친구수락대기
declare @gameid_	varchar(20)	set @gameid_ = 'xxxx2'


select * from dbo.tFVUserFriend where gameid = @gameid_ and state = @USERFRIEND_STATE_APPROVE_WAIT
*/

/*
declare @ITEM_SUBCATEGORY_USERFARM			int					set @ITEM_SUBCATEGORY_USERFARM	 			= 69 -- 전국목장
declare @gameid_	varchar(20)	set @gameid_ = 'xxxx2'
declare @gameid	varchar(20)	set @gameid = @gameid_
declare @gameyear	int

select DATEDIFF(hh, incomedate, getdate()) * param1 as hourcoin2, b.param2 maxcoin from
	(select * from dbo.tFVUserFarm where gameid = @gameid and buystate = 1) a
LEFT JOIN
	(select * from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_USERFARM) b
ON a.itemcode = b.itemcode

-- 전국 목장 정보 > 수확물 정보가 있는가? > 맥스로 있는가?
select top 1 * from
	(select DATEDIFF(hh, incomedate, getdate()) * param1 as hourcoin2, b.param2 maxcoin from
		(select * from dbo.tFVUserFarm where gameid = @gameid and buystate = 1) a
	LEFT JOIN
		(select * from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_USERFARM) b
	ON a.itemcode = b.itemcode) as f
where hourcoin2 >= maxcoin

--update dbo.tFVUserFarm set incomedate = getdate() where gameid = 'xxxx2'
*/



/*
--------------------------------------------
-- 1. 개인 정보 랜덤입력.
--------------------------------------------
declare @ttsalecoin		int,
		@gameid			varchar(20)
select 'DEBUG 1. 개인 정보 랜덤입력.'

declare curUserMaster Cursor for
select gameid from dbo.tFVUserMaster


-- 2. 커서오픈
open curUserMaster

-- 3. 커서 사용
Fetch next from curUserMaster into @gameid
while @@Fetch_status = 0
	Begin
		set @ttsalecoin = Convert(int, ceiling(RAND() * 99999))
		update dbo.tFVUserMaster set ttsalecoin = @ttsalecoin where gameid = @gameid
		Fetch next from curUserMaster into @gameid
	end

-- 4. 커서닫기
close curUserMaster
Deallocate curUserMaster

--------------------------------------------
--2. 학교 마스터 정보 랜덤입력.
--------------------------------------------
declare @schoolidx		int,
		@totalpoint		bigint
select 'DEBUG 2. 학교 마스터 정보 랜덤입력.'

declare curSchoolMaster Cursor for
select schoolidx from dbo.tFVSchoolMaster

-- 2. 커서오픈
open curSchoolMaster

-- 3. 커서 사용
Fetch next from curSchoolMaster into @schoolidx
while @@Fetch_status = 0
	Begin
		set @totalpoint = Convert(int, ceiling(RAND() * 99))*10
		update dbo.tFVSchoolMaster set totalpoint = @totalpoint where schoolidx = @schoolidx
		Fetch next from curSchoolMaster into @schoolidx
	end

-- 4. 커서닫기
close curSchoolMaster
Deallocate curSchoolMaster
-- select * from dbo.tFVSchoolMaster


--------------------------------------------
-- 3. 학교마스터 > 학교 인원정보(강제 입력)
--------------------------------------------
--declare @totalpoint		bigint,
--		@schoolidx		int,
--		@gameid			varchar(20)
select 'DEBUG 3. 학교마스터 > 학교 인원정보(강제 입력)'

declare curSchoolMasterSubUser Cursor for
select schoolidx, totalpoint from dbo.tFVSchoolMaster
update dbo.tFVSchoolUser set point = 0

-- 2. 커서오픈
open curSchoolMasterSubUser

-- 3. 커서 사용
Fetch next from curSchoolMasterSubUser into @schoolidx, @totalpoint
while @@Fetch_status = 0
	Begin
		while(@totalpoint > 0)
			begin
				select top 1 @gameid = gameid from dbo.tFVSchoolUser where schoolidx = @schoolidx order by newid()
				--select @gameid gameid

				update dbo.tFVSchoolUser set point = point + 10 where gameid = @gameid
				set @totalpoint = @totalpoint - 10
			end
		Fetch next from curSchoolMasterSubUser into @schoolidx, @totalpoint
	end

-- 4. 커서닫기
close curSchoolMasterSubUser
Deallocate curSchoolMasterSubUser
-- select * from dbo.tFVSchoolUser
*/



/*
--------------------------------------------
-- 1. 개인, 친구랭킹, 학교 점수 랜덤입력.
--------------------------------------------
declare @ttsalecoin		int,
		@schoolidx		int,
		@gameid			varchar(20)
select 'DEBUG 1. 개인 정보 랜덤입력.'

declare curUserMaster Cursor for
select gameid, schoolidx from dbo.tFVUserMaster


-- 2. 커서오픈
open curUserMaster

-- 3. 커서 사용
Fetch next from curUserMaster into @gameid, @schoolidx
while @@Fetch_status = 0
	Begin
		set @ttsalecoin = Convert(int, ceiling(RAND() * 20000))
		update dbo.tFVUserMaster		set ttsalecoin	= @ttsalecoin				where gameid = @gameid
		update dbo.tFVSchoolUser		set point		= @ttsalecoin				where gameid = @gameid
		if(@schoolidx != -1)
			begin
				update dbo.tFVSchoolMaster	set totalpoint	= totalpoint + @ttsalecoin	where schoolidx = @schoolidx
			end

		Fetch next from curUserMaster into @gameid, @schoolidx
	end
*/


/*
---------------------------------------------
--	친구랭킹[백업스케쥴러]
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserMasterSchedule', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserMasterSchedule;
GO

create table dbo.tFVUserMasterSchedule(
	idx				int					identity(1, 1),

	dateid			varchar(8),										-- 20121118
	idxStart		int					default(0),
	writedate		datetime			default(getdate()), 		-- 작성일

	-- Constraint
	CONSTRAINT pk_tUserMasterSchedule_dateid	PRIMARY KEY(dateid)
)
GO

-- select * from dbo.tFVUserMasterSchedule
-- if(not exist(select dateid from dbo.tFVUserMasterSchedule where dateid = '20131227'))
-- 		insert into dbo.tFVUserMasterSchedule(dateid, idxStart) values('20131227', 1)
-- update tUserMasterSchedule
-- 	set
--		idxStart = idx
-- where dateid = '20121118'
*/


/*
-- 데이타 검사.
select
	gameid, ttsalecoin,
	lmsalecoin , 	lmrank,		lmcnt,
	l1gameid, 		l1itemcode, 	l1acc1, 		l1acc2, 	l1salecoin,
	l2gameid, 		l2itemcode, 	l2acc1, 		l2acc2, 	l2salecoin,
	l3gameid, 		l3itemcode, 	l3acc1, 		l3acc2, 	l3salecoin
from dbo.tFVUserMaster
*/


/*
alter table dbo.tFVUserMaster add anirepitemcode	int					default(1)
alter table dbo.tFVUserMaster add anirepacc1		int					default(-1)
alter table dbo.tFVUserMaster add anirepacc2		int					default(-1)

update dbo.tFVUserMaster
	set
		anirepitemcode = 1, anirepacc1 = -1, anirepacc2 = -1
*/


/*
alter table dbo.tFVUserMaster add lmsalecoin		int					default(0)
alter table dbo.tFVUserMaster add lmrank			int					default(1)
alter table dbo.tFVUserMaster add lmcnt			int					default(0)
alter table dbo.tFVUserMaster add l1gameid		varchar(20)			default('')
alter table dbo.tFVUserMaster add l1itemcode		int					default(1)
alter table dbo.tFVUserMaster add l1acc1			int					default(-1)
alter table dbo.tFVUserMaster add l1acc2			int					default(-1)
alter table dbo.tFVUserMaster add l1salecoin		int					default(0)
alter table dbo.tFVUserMaster add l2gameid		varchar(20)			default('')
alter table dbo.tFVUserMaster add l2itemcode		int					default(1)
alter table dbo.tFVUserMaster add l2acc1			int					default(-1)
alter table dbo.tFVUserMaster add l2acc2			int					default(-1)
alter table dbo.tFVUserMaster add l2salecoin		int					default(0)
alter table dbo.tFVUserMaster add l3gameid		varchar(20)			default('')
alter table dbo.tFVUserMaster add l3itemcode		int					default(1)
alter table dbo.tFVUserMaster add l3acc1			int					default(-1)
alter table dbo.tFVUserMaster add l3acc2			int					default(-1)
alter table dbo.tFVUserMaster add l3salecoin		int					default(0)

update dbo.tFVUserMaster
	set
		lmsalecoin = 0, lmrank = 1, lmcnt = 0,
		l1gameid = '', l1itemcode = 1, l1acc1 = -1, l1acc2 = -1, l1salecoin = 0,
		l2gameid = '', l2itemcode = 1, l2acc1 = -1, l2acc2 = -1, l2salecoin = 0,
		l3gameid = '', l3itemcode = 1, l3acc1 = -1, l3acc2 = -1, l3salecoin = 0
*/

/*
-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVSchoolBackUser_dateid_schoolrank_userrank')
    DROP INDEX tFVSchoolBackUser.idx_tFVSchoolBackUser_dateid_schoolrank_userrank
GO

-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVSchoolBackUser_dateid_gameid')
    DROP INDEX tFVSchoolBackUser.idx_tFVSchoolBackUser_dateid_gameid
GO
CREATE INDEX idx_tFVSchoolBackUser_dateid_gameid ON tSchoolBackUser (dateid, gameid)
GO
*/




/*
--delete from dbo.tFVGiftList where giftdate > '2014-01-01' and gameid in ('xxxx12', 'xxxx13', 'xxxx14', 'xxxx15', 'xxxx16', 'xxxx17', 'xxxx18', 'xxxx19', 'xxxx2','xxxx3','xxxx4', 'xxxx5', 'xxxx6', 'xxxx7', 'xxxx8', 'xxxx9')
--delete from dbo.tFVSchoolBackMaster where dateid = '20140102'
--delete from dbo.tFVSchoolBackUser where dateid = '20140102'
--exec spu_FVSchoolScheduleRecord '20140102', 0
select * from dbo.tFVSchoolMaster order by schoolrank asc
select * from dbo.tFVSchoolUser order by schoolrank asc, userrank asc
select * from dbo.tFVSchoolSchedule order by dateid desc
select * from dbo.tFVSchoolBackMaster where dateid = '20140102'
select * from dbo.tFVSchoolBackUser where dateid = '20140102'
select * from dbo.tFVGiftList where giftdate > '2014-01-01' and gameid in ('xxxx12', 'xxxx13', 'xxxx14', 'xxxx15', 'xxxx16', 'xxxx17', 'xxxx18', 'xxxx19', 'xxxx2','xxxx3','xxxx4', 'xxxx5', 'xxxx6', 'xxxx7', 'xxxx8', 'xxxx9')
*/

/*
insert into dbo.tFVSchoolMaster(schoolidx, cnt, totalpoint) values(437, 1, 0)
delete from dbo.tFVSchoolMaster where idx = 32
select * from dbo.tFVUserBoard order by idx desc
delete from dbo.tFVUserBoard where idx in (65, 64, 63)
*/

/*
alter table dbo.tFVSchoolBackUser add itemcode 				int					default(1)
alter table dbo.tFVSchoolBackUser add acc1	 				int					default(-1)
alter table dbo.tFVSchoolBackUser add acc2 					int					default(-1)
update dbo.tFVSchoolBackUser set itemcode = 1, acc1 = -1, acc2 = -1
*/


/*
alter table dbo.tFVSchoolUser add itemcode 				int					default(1)
alter table dbo.tFVSchoolUser add acc1	 				int					default(-1)
alter table dbo.tFVSchoolUser add acc2 					int					default(-1)
update dbo.tFVSchoolUser set itemcode = 1, acc1 = -1, acc2 = -1
*/

/*
select top 10 rank() over(order by totalpoint desc) as schoolrank, * from dbo.tFVSchoolMaster
select top 10 rank() over(order by point desc) userrank, * from dbo.tFVSchoolUser where point > 0
select *  from dbo.tFVSchoolUser order by schoolrank asc, userrank asc

select schoolrank schoolrank2, rank() over (partition by schoolrank order by point desc) as userrank2, schoolidx, point, gameid, joindate from dbo.tFVSchoolUser where point > 0 order by schoolrank2 asc
select rank() over (partition by schoolrank order by point desc) as userrank2, gameid from dbo.tFVSchoolUser where point > 0 order by schoolrank asc
*/
/*
select * from dbo.tFVSchoolMaster order by schoolrank asc
select * from dbo.tFVSchoolUser order by schoolrank asc, userrank asc

select * from dbo.tFVSchoolBackMaster where dateid = '20131231' order by schoolrank asc
select * from dbo.tFVSchoolBackUser where dateid = '20131231' order by schoolrank asc, userrank asc
*/



/*
select * from dbo.tFVSchoolMaster
select * from dbo.tFVSchoolUser order by schoolidx, point desc

select * from dbo.tFVSchoolSchedule where dateid = '20131231'

select * from dbo.tFVSchoolBackMaster where dateid = '20131231'
select * from dbo.tFVSchoolBackUser where dateid = '20131231'
*/

/*
update dbo.tFVSchoolMaster set totalpoint = 1000 where schoolidx = 1
update dbo.tFVSchoolMaster set totalpoint = 2000 where schoolidx = 2
update dbo.tFVSchoolMaster set totalpoint = 4000 where schoolidx = 4

update dbo.tFVSchoolUser set point = 955 where gameid = 'xxxx12'
update dbo.tFVSchoolUser set point = 9 where gameid = 'xxxx13'
update dbo.tFVSchoolUser set point = 8 where gameid = 'xxxx14'
update dbo.tFVSchoolUser set point = 7 where gameid = 'xxxx15'
update dbo.tFVSchoolUser set point = 6 where gameid = 'xxxx16'
update dbo.tFVSchoolUser set point = 5 where gameid = 'xxxx17'
update dbo.tFVSchoolUser set point = 4 where gameid = 'xxxx18'
update dbo.tFVSchoolUser set point = 3 where gameid = 'xxxx19'
update dbo.tFVSchoolUser set point = 2 where gameid = 'xxxx2'
update dbo.tFVSchoolUser set point = 1 where gameid = 'xxxx7'
update dbo.tFVSchoolUser set point = 0 where gameid = 'xxxx9'
update dbo.tFVSchoolUser set point = 1000 where gameid = 'xxxx3'
update dbo.tFVSchoolUser set point = 600 where gameid = 'xxxx4'
update dbo.tFVSchoolUser set point = 400 where gameid = 'xxxx5'
update dbo.tFVSchoolUser set point = 3000 where gameid = 'xxxx6'
update dbo.tFVSchoolUser set point = 1000 where gameid = 'xxxx8'
*/
/*
alter table dbo.tFVSchoolMaster add schoolrank				int					default(-1)
update dbo.tFVSchoolMaster set schoolrank = -1

alter table dbo.tFVSchoolUser add schoolrank				int					default(-1)
alter table dbo.tFVSchoolUser add userrank				int					default(-1)
update dbo.tFVSchoolUser set schoolrank = -1, userrank = -1

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVSchoolUser_schoolidx_point')
    DROP INDEX tFVSchoolUser.idx_tFVSchoolUser_schoolidx_point
GO
CREATE INDEX idx_tFVSchoolUser_schoolidx_point ON tSchoolUser (schoolidx, point desc)
GO

alter table dbo.tFVSchoolSchedule add step			int					default(0)
update dbo.tFVSchoolSchedule set step = 0

alter table dbo.tFVSchoolBackUser add itemcode1 				int					default(-1)
alter table dbo.tFVSchoolBackUser add itemcode2 				int					default(-1)
alter table dbo.tFVSchoolBackUser add itemcode3 				int					default(-1)
update dbo.tFVSchoolBackUser set itemcode1 = -1, itemcode2 = -1, itemcode3 = -1

alter table dbo.tFVSchoolUser add itemcode1 				int					default(-1)
alter table dbo.tFVSchoolUser add itemcode2 				int					default(-1)
alter table dbo.tFVSchoolUser add itemcode3 				int					default(-1)
update dbo.tFVSchoolUser set itemcode1 = -1, itemcode2 = -1, itemcode3 = -1
*/

/*
	select top 1
		cashcost,
		itemcode
	from
	(select itemcode, cashcost, param1, param2 from dbo.tFVItemInfo where subcategory = 54) t
	where t.param1 <= 1 and 1 < t.param2



select itemcode, cashcost, param1, param2 from dbo.tFVItemInfo where subcategory = 54

update dbo.tFVItemInfo set param1 = 0, param3 = 0 where itemcode = 5400
*/

/*
alter table dbo.tFVUserBoard add schoolidx	int					default(-1)

update dbo.tFVUserBoard set schoolidx = -1

select * from dbo.tFVUserBoard where kind = 3
update dbo.tFVUserBoard set schoolidx = 1443 where idx = 8
*/


/*
--insert into dbo.tFVSchoolBackUser(dateid, schoolrank, userrank, schoolidx, gameid, point, joindate) values('20131227', 1, 1, 1, 'xxxx2', 800, getdate())
--insert into dbo.tFVSchoolBackUser(dateid, schoolrank, userrank, schoolidx, gameid, point, joindate) values('20131227', 1, 2, 1, 'xxxx3', 150, getdate())
--insert into dbo.tFVSchoolBackUser(dateid, schoolrank, userrank, schoolidx, gameid, point, joindate) values('20131227', 1, 3, 1, 'xxxx4',  50, getdate())
--insert into dbo.tFVSchoolBackUser(dateid, schoolrank, userrank, schoolidx, gameid, point, joindate) values('20131227', 2, 1, 2, 'xxxx5', 800, getdate())
--insert into dbo.tFVSchoolBackUser(dateid, schoolrank, userrank, schoolidx, gameid, point, joindate) values('20131227', 2, 2, 2, 'xxxx6', 150, getdate())
--insert into dbo.tFVSchoolBackUser(dateid, schoolrank, userrank, schoolidx, gameid, point, joindate) values('20131227', 3, 1, 3, 'xxxx7',  50, getdate())


select top 10 * from dbo.[tSchoolSchedule] order by dateid desc
select top 10 * from dbo.tFVSchoolBackMaster order by dateid desc
select top 10 * from dbo.tFVSchoolBackUser order by dateid desc, point desc
--insert into dbo.tFVSchoolSchedule(dateid, idxStart) values('20131227', 1000)
--insert into dbo.tFVSchoolSchedule(dateid, idxStart) values('20131222', 1000)
--insert into dbo.tFVSchoolSchedule(dateid, idxStart) values('20131215', 1000)
--insert into dbo.tFVSchoolSchedule(dateid, idxStart) values('20131208', 1000)
--insert into dbo.tFVSchoolSchedule(dateid, idxStart) values('20131201', 1000)
*/




/*
declare @schoolidx		int			set @schoolidx 		= -1
declare @point			int			set @point 			= 0
declare @cnt			int			set @cnt	 		= 0
declare @gameid			varchar(40)	set @gameid			= 'xxxx2'

select @schoolidx = schoolidx from dbo.tFVUserMaster where gameid = @gameid

if(@schoolidx != -1)
	begin
		-- 학교 개인정보
		select @point = point from dbo.tFVSchoolUser where gameid = @gameid and schoolidx = @schoolidx
		delete from dbo.tFVSchoolUser where gameid = @gameid and schoolidx = @schoolidx

		-- 학교 마스터
		select @cnt = cnt from dbo.tFVSchoolMaster where schoolidx = @schoolidx
		if(@cnt <= 1)
			begin
				delete from dbo.tFVSchoolMaster where schoolidx = @schoolidx
			end
		else
			begin
				update dbo.tFVSchoolMaster
					set
						cnt			= cnt - 1,
						totalpoint	= totalpoint - @point
				where schoolidx = @schoolidx
			end

		-- 유저 정보
		update dbo.tFVUserMaster
			set
				schoolidx = -1
		where gameid = @gameid
	end
*/
/*
			DECLARE @tTempTableMaster TABLE(
				rank			int,
				schoolidx		int,
				cnt				int,
				totalpoint		int
			);
			insert into @tTempTableMaster
			select top 100 rank() over(order by totalpoint desc) rank, schoolidx, cnt, totalpoint
			from dbo.tFVSchoolMaster order by totalpoint desc

			select * from
				@tTempTableMaster m
			JOIN
				(select * from dbo.tFVSchoolBank where schoolidx in (select schoolidx from @tTempTableMaster)) b
			ON
				m.schoolidx = b.schoolidx

select top 100 rank() over(order by point desc) rank, * from dbo.tFVSchoolUser
where schoolidx = @schoolidx
order by point desc

*/

/*
declare @schoolidx		int	set @schoolidx 		= -1
declare @gameid			varchar(40)	set @gameid			= 'xxxx3'

select @schoolidx = schoolidx from dbo.tFVUserMaster where gameid = @gameid
select b.*, m.cnt, m.totalpoint, u.gameid, u.point point2 from
	(select * from dbo.tFVSchoolBank where schoolidx = @schoolidx)	b
JOIN
	(select * from dbo.tFVSchoolMaster where schoolidx = @schoolidx) m
ON
	b.schoolidx = m.schoolidx
JOIN
	(select * from dbo.tFVSchoolUser where schoolidx = @schoolidx) u
ON
	b.schoolidx = u.schoolidx
order by u.point desc
*/

/*
alter table dbo.tFVUserMaster add schoolidx			int					default(-1)
alter table dbo.tFVUserMaster add schoolresult		int					default(-1)

update dbo.tFVUserMaster set schoolidx = -1, schoolresult = -1
*/


/*
---------------------------------------------
--		학교대항[학교]
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSchoolMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSchoolMaster;
GO

create table dbo.tFVSchoolMaster(
	idx						int					IDENTITY(1,1),

	schoolidx				int,
	cnt						int					default(1),
	totalpoint				bigint				default(0),
	joindate				datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSchoolMaster_schoolidx	PRIMARY KEY(schoolidx)
)
-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVSchoolMaster_totalpoint')
    DROP INDEX tFVSchoolMaster.idx_tFVSchoolMaster_totalpoint
GO
CREATE INDEX idx_tFVSchoolMaster_totalpoint ON tSchoolMaster (totalpoint desc)
GO

-- insert into dbo.tFVSchoolMaster(schoolidx) values(2)
-- select top 1 * from dbo.tFVSchoolMaster where schoolidx = 2
-- update dbo.tFVSchoolMaster set cnt = cnt + 1 where schoolidx = 2
-- update dbo.tFVSchoolMaster set totalpoint = totalpoint + 10 where schoolidx = 2
-- select top 10 rank() over(order by totalpoint desc) as rank, schoolidx, cnt, totalpoint from dbo.tFVSchoolMaster

---------------------------------------------
--		학교대항[유저]
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSchoolUser', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSchoolUser;
GO

create table dbo.tFVSchoolUser(
	idx						int					IDENTITY(1,1),

	schoolidx				int,
	gameid					varchar(20),
	point					bigint				default(0),
	joindate				datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSchoolUser_gameid	PRIMARY KEY(gameid)
)

-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVSchoolUser_point_schoolidx')
    DROP INDEX tFVSchoolUser.idx_tFVSchoolUser_point_schoolidx
GO
CREATE INDEX idx_tFVSchoolUser_point_schoolidx ON tSchoolUser (point desc, schoolidx)
GO

-- select top 1 * from dbo.tFVSchoolUser where gameid = 'xxxx2'
-- delete from dbo.tFVSchoolUser where gameid = 'xxxx2'
-- insert into dbo.tFVSchoolUser(schoolidx, gameid) values(1, 'xxxx2')
-- update dbo.tFVSchoolUser set point = point + 10 where gameid = 'xxxx2'
-- select top 10 rank() over(order by point desc) as rank, schoolidx, gameid, point from dbo.tFVSchoolUser where schoolidx = 1



---------------------------------------------
--	학교대항[백업스케쥴러]
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSchoolSchedule', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSchoolSchedule;
GO

create table dbo.tFVSchoolSchedule(
	idx				int					identity(1, 1),

	dateid			varchar(8),										-- 20121118
	idxStart		int					default(0),
	writedate		datetime			default(getdate()), 		-- 작성일

	-- Constraint
	CONSTRAINT pk_tSchoolSchedule_dateid	PRIMARY KEY(dateid)
)
GO

-- select * from dbo.tFVSchoolSchedule
-- if(not exist(select dateid from dbo.tFVSchoolSchedule where dateid = '20131227'))
-- 		insert into dbo.tFVSchoolSchedule(dateid) values('20131227', 1000)
-- update tSchoolSchedule
-- 	set
--		idxStart = idx
-- where dateid = '20121118'


---------------------------------------------
--		학교대항[학교백업]
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSchoolBackMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSchoolBackMaster;
GO

create table dbo.tFVSchoolBackMaster(
	idx						int					IDENTITY(1,1),

	dateid					varchar(8),										-- 20121118
	schoolrank				int,

	schoolidx				int,
	cnt						int 				default(1),
	totalpoint				bigint				default(0),
	joindate				datetime			default(getdate()),
	comment					varchar(128)

	-- Constraint
	CONSTRAINT	pk_tSchoolBackMaster_idx		PRIMARY KEY(idx)
)
-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVSchoolBackMaster_dateid_schoolrank')
    DROP INDEX tFVSchoolBackMaster.idx_tFVSchoolBackMaster_dateid_schoolrank
GO
CREATE INDEX idx_tFVSchoolBackMaster_dateid_schoolrank ON tSchoolBackMaster (dateid, schoolrank)
GO

--insert into dbo.tFVSchoolBackMaster (dateid, schoolrank, schoolidx, cnt, totalpoint) values('20131227', 1, 1, 10, 1000)
--insert into dbo.tFVSchoolBackMaster (dateid, schoolrank, schoolidx, cnt, totalpoint) values('20131227', 2, 2,  9,  900)
--insert into dbo.tFVSchoolBackMaster (dateid, schoolrank, schoolidx, cnt, totalpoint) values('20131227', 3, 3,  8,  800)



---------------------------------------------
--		학교대항[유저백업]
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSchoolBackUser', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSchoolBackUser;
GO

create table dbo.tFVSchoolBackUser(
	idx						int					IDENTITY(1,1),

	dateid					varchar(8),										-- 20121118
	schoolrank				int,
	userrank				int,

	schoolidx				int,
	gameid					varchar(20),
	point					bigint				default(0),
	joindate				datetime			default(getdate()),
	comment					varchar(128)

	-- Constraint
	CONSTRAINT	pk_tSchoolBackUser_idx	PRIMARY KEY(idx)
)

-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVSchoolBackUser_dateid_schoolrank_userrank')
    DROP INDEX tFVSchoolBackUser.idx_tFVSchoolBackUser_dateid_schoolrank_userrank
GO
CREATE INDEX idx_tFVSchoolBackUser_dateid_schoolrank_userrank ON tSchoolBackUser (dateid, schoolrank, userrank)
GO
*/


/*
--SELECT   DATEPART(dw, GETDATE())
--DATEPART 함수는 조금 더 공부해야겠지만... 앞에 dw를 넣고 뒤에 날짜를 넣으면
--그 날이 무슨 요일인지 알 수 있다.  1이면 일요일, 2이면 월요일... 이런식
--
--SELECT    GETDATE() - DATEPART(dw, GETDATE()) + 2
--이건  그래서 오늘 날짜에서 요일 수를 뺀 다음 1을(일요일이 1이니까) 더해주면 그 주 일요일의 날짜가 된다.
--위에서 2를 더한 이유는 월요일부터 생각할려고.
--
--SELECT    (GETDATE() - DATEPART(dw, GETDATE()) + 2) + 6
--같은방법으로 위에서 구한거에다가 6을 더하면 그 주의 마지막날...(일요일)
--
-- 이번주 일요일
--select datepart(dw, '20131222')	-- 일(1)
--select datepart(dw, '20131223')	-- 월(2)
--select datepart(dw, '20131224')	-- 화(3)
--select datepart(dw, '20131225')	-- 수(4)
--select datepart(dw, '20131226')	-- 목(5)
--select datepart(dw, '20131227')	-- 금(6)
--select datepart(dw, '20131228')	-- 토(7)

--declare @curdate	datetime
--SELECT GETDATE(), (GETDATE() - DATEPART(dw, GETDATE()) + 2) + 6
--set @curdate = '2013-12-20'
--SELECT @curdate, (@curdate - DATEPART(dw, @curdate) + 2) + 6
--set @curdate = '2013-12-21'
--SELECT @curdate, (@curdate - DATEPART(dw, @curdate) + 2) + 6
--set @curdate = '2013-12-22'
--SELECT @curdate, (@curdate - DATEPART(dw, @curdate) + 2) + 6


declare @curdate	datetime,
		@schoolinitdate	varchar(19),
		@dw			int
set @curdate = GETDATE()

select @dw = DATEPART(dw, @curdate)
set @curdate = case
					when @dw = 1 then  @curdate
					else			  (@curdate - DATEPART(dw, @curdate) + 2) + 6
			   end
set @schoolinitdate = CONVERT(char(10), @curdate, 25) + ' 23:59:00'
select @schoolinitdate schoolinitdate
*/

/*
exec spu_FVGameSave 'Kimdaehan14', '82828222222222222222', '0:2014;1:1;2:0;4:2;10:26;11:359;12:15;13:180;30:0;40:-1;41:-1;42:-1;43:1;',
													'0:5,5,0;1:4,8,0;2:4,6,0;3:3,18,0;15:3,10,0;16:4,7,0;17:4,10,0;18:4,17,0;19:6,13,0;',
													'',
													'0:90113;1:1;2:0;3:0;4:201402;5:0;',
													-1										-- 필드없음.



*/
/*
declare @pagemax		int						set @pagemax		= 1
declare @page			int						set @page			= 1
declare @kind_			int						set @kind_			= 1


	DECLARE @tTempTableList TABLE(
		pagemax			int,
		page			int,

		idx				int,
		idx2			int,
		kind			int,
		gameid			varchar(20),
		message			varchar(256),
		writedate		datetime
	);

insert into @tTempTableList
select top 10 @pagemax pagemax, @page page, idx, idx2, kind, gameid, message, writedate from dbo.tFVUserBoard
where kind = @kind_ order by idx2 desc

select * from @tTempTableList


select b.*, i.itemcode, acc1, acc2 from
	(select gameid, anireplistidx from dbo.tFVUserMaster where gameid in (select gameid from @tTempTableList)) as m
LEFT JOIN
	(select gameid, listidx, itemcode, acc1, acc2 from dbo.tFVUserItem where gameid in (select gameid from @tTempTableList)) as i
ON
	m.gameid = i.gameid and m.anireplistidx = i.listidx
JOIN
	@tTempTableList b
ON
	m.gameid = b.gameid

*/


/*
alter table dbo.tFVUserSaleLog add orderbarrel		int					default(0)
alter table dbo.tFVUserSaleLog add orderfresh		int					default(0)

update dbo.tFVUserSaleLog set orderbarrel = 0, orderfresh = 0
*/

--alter table dbo.tFVUserMaster add tutostep	int						default(5500)
--update dbo.tFVUserMaster set tutostep = 5500

/*
---------------------------------------------
--	튜토리얼 모드 보상(기록된것은 보상 받은것)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVTutoStep', N'U') IS NOT NULL
	DROP TABLE dbo.tFVTutoStep;
GO

create table dbo.tFVTutoStep(
	idx				int				IDENTITY(1,1),

	gameid			varchar(20),
	itemcode		int,
	getdate			datetime		default(getdate()),
	ispass			int				default(-1),

	gameyear		int,
	gamemonth		int,
	famelv			int,

	-- Constraint
	CONSTRAINT pk_tTutoStep_idx	PRIMARY KEY(idx)
)

-- gameid, itemcode
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVTutoStep_gameid_itemcode')
	DROP INDEX tFVTutoStep.idx_tFVTutoStep_gameid_itemcode
GO
CREATE INDEX idx_tFVTutoStep_gameid_itemcode ON tTutoStep (gameid, itemcode)
GO

--if(not exists(select top 1 * from dbo.tFVTutoStep where gameid = 'xxxx' and itemcode = 1))
--	begin
--		insert into dbo.tFVTutoStep(gameid, itemcode) values('xxxx', 1)
--	end
--select * from dbo.tFVTutoStep where gameid = 'xxxx' order by itemcode asc

*/

/*
alter table dbo.tFVUserMaster add tradecntold	int						default(0)
alter table dbo.tFVUserMaster add prizecntold	int						default(0)
update dbo.tFVUserMaster set tradecntold = 0, prizecntold = 0




select * from
	(select itemcode, cashcost, param1, param2 from dbo.tFVItemInfo where subcategory = 54) t
where t.param1 <= 29 and t.param2 < 29

select top 1 * from
	(select itemcode, cashcost, param1, param2 from dbo.tFVItemInfo where subcategory = 54) t
where t.param1 <= 30 and 30 < t.param2

select * from
	(select itemcode, cashcost, param1, param2 from dbo.tFVItemInfo where subcategory = 54) t
where t.param1 <= 60 and 60 < t.param2

select * from
	(select itemcode, cashcost, param1, param2 from dbo.tFVItemInfo where subcategory = 54) t
where t.param1 <= 9999 and 9999 < t.param2

*/

/*

declare curRoulInfo Cursor for
select u.itemcode itemcode,
	   case when normalcnt != 0 then normalcnt else premiumcnt end cnt,
	   i.param6 fresh from dbo.tFVRouletteLogTotalSub u join
	(select * from dbo.tFVItemInfo) i
		on u.itemcode = i.itemcode
where dateid8 = @ps2_

-- 2. 커서오픈
open curRoulInfo

set @cnt2 	= 0
set @val	= 0
-- 3. 커서 사용
Fetch next from curRoulInfo into @itemcode, @cnt, @fresh
while @@Fetch_status = 0
	Begin
		if(@itemcode < 300)
			begin
				set @cnt2 	= @cnt2 + @cnt
				set @val 	= @val + @fresh * @cnt
			end
		Fetch next from curRoulInfo into @itemcode, @cnt, @fresh
	end

-- 4. 커서닫기
close curRoulInfo
Deallocate curRoulInfo

select @cnt2 cnt, @val / @cnt2 avg
*/


/*
---------------------------------------------
--		게시판 정보(글쓰기에 우선순위를 올림).
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserBoard', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserBoard;
GO

create table dbo.tFVUserBoard(
	idx			int					IDENTITY(1,1),

	idx2		int,
	kind		int					default(1),					-- 1:일반게시판광고, 2:친추게시판광고, 3:대항게시판광고

	gameid		varchar(20),
	message		varchar(256)		default(''),
	writedate	datetime			default(getdate()), 		-- 선물일

	-- Constraint
	CONSTRAINT	pk_tUserBoard_idx2_kind	PRIMARY KEY(idx)
)
-- 폰인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserBoard_idx2_kind')
    DROP INDEX tFVUserBoard.idx_tFVUserBoard_idx2
GO
CREATE INDEX idx_tFVUserBoard_idx2_kind ON tUserBoard (idx2, kind)
GO

-- insert into dbo.tFVUserBoard(kind, idx2, gameid, message) values(1, 1, 'xxxx2', '일반게시판광고')
-- insert into dbo.tFVUserBoard(kind, idx2, gameid, message) values(2, 1, 'xxxx2', '친추게시판광고')
-- insert into dbo.tFVUserBoard(kind, idx2, gameid, message) values(3, 1, 'xxxx2', '대항게시판광고')
-- select top 5 * from dbo.tFVUserBoard where kind = 1 order by idx2 desc
-- select top 5 * from dbo.tFVUserBoard where kind = 2 order by idx2 desc
-- select top 5 * from dbo.tFVUserBoard where kind = 3 order by idx2 desc
*/

/*
declare @loop int				set @loop = 0
declare @loopmax int			set @loopmax = 100
declare @str varchar(256)		set @str = ''
declare @idx2 int
while(@loop < @loopmax)
	begin
		select @idx2 = max(idx2) + 1 from dbo.tFVUserBoard where kind = 1
		set @loop = @loop + 1
		set @str = ltrim(rtrim(str(@loop)))
		insert into dbo.tFVUserBoard(kind, idx2, gameid, message) values(1, @idx2, 'xxxx2', '일반게시판광고' + @str)

		select @idx2 = max(idx2) + 1 from dbo.tFVUserBoard where kind = 2
		set @loop = @loop + 1
		set @str = ltrim(rtrim(str(@loop)))
		insert into dbo.tFVUserBoard(kind, idx2, gameid, message) values(2, @idx2, 'xxxx2', '친추게시판광고' + @str)

		if(@loop % 100 in (0, 1, 2))
			begin
				select @idx2 = max(idx2) + 1 from dbo.tFVUserBoard where kind = 3
				set @loop = @loop + 1
				set @str = ltrim(rtrim(str(@loop)))
				insert into dbo.tFVUserBoard(kind, idx2, gameid, message) values(3, @idx2, 'xxxx2', '대항게시판광고' + @str)
			end
	end
*/


/*
--경쟁모드 검사하기
update dbo.tFVUserMaster set comreward = 90106 where gameid = 'xxxx2'
declare @comreward	int			set @comreward	= 90106
declare @gameid		varchar(60)	set @gameid		= 'xxxx2'
declare @nextcomreward			int					set @nextcomreward		= -1
declare @nextinitpart1			int					set @nextinitpart1		= 0
declare @nextinitpart2			int					set @nextinitpart2		= 0
exec spu_FVFarmD 19, 95, @comreward, -1, -1, -1, -1, -1, -1, -1, @gameid, '', '', '', '', '', '', '', '', ''

while(@comreward != -1)
	begin
		-- 1. 초기화.
		update dbo.tFVUserMaster
			set
				cashcost = 0, gamecost = 0, heart = 0,
				bktwolfkillcnt	= 1,	bktsalecoin		= 2,	bkheart			= 3,	bkfeed			= 4,	bktsuccesscnt	= 5,	bktbestfresh	= 6,
				bktbestbarrel	= 7,	bktbestcoin		= 8,	bkbarrel		= 9,	bkcrossnormal	= 10,	bkcrosspremium	= 11
		where gameid = @gameid

		-- 2. 퀘보상.
		exec spu_FVComRewardTest @gameid, '049000s1i0n7t8445289', @comreward, '',  1, -1

		-- 3. 현재퀘 상태정보.
		select @nextcomreward = param8, @nextinitpart1 = param9, @nextinitpart2	= param10 from dbo.tFVItemInfo
		where itemcode = @comreward

		select
			@comreward comreward, @nextinitpart1 initpart1, @nextinitpart2 initpart2,
			gameid, cashcost, gamecost, heart, feed, fpoint, comreward,
			bktwolfkillcnt, bktsalecoin, bkheart, bkfeed, bktsuccesscnt, bktbestfresh,
			bktbestbarrel, bktbestcoin, bkbarrel, bkcrossnormal, bkcrosspremium
		from dbo.tFVUserMaster
		where gameid = @gameid

		set @comreward	= @nextcomreward
	end
*/



/*

DECLARE @tItemExpire TABLE(
	itemcode	int,
	itemname	varchar(128),
	fresh		int
);


insert into @tItemExpire
select itemcode, itemname, param6 fresh from dbo.tFVItemInfo
where category = 1


select * from @tItemExpire order by fresh asc

*/

/*
alter table dbo.tFVNotice add comment			varchar(4096)
update dbo.tFVNotice set comment = ''
*/

/*
select * from dbo.tFVItemInfo where subcategory = 600 and itemcode >= 60004 order by itemcode desc
*/
/*
select top 1 itemname, param6 from dbo.tFVItemInfo where category = 1 and (param6  >= 11 and param6 <= 12) order by newid()
select top 1 itemname, param6 from dbo.tFVItemInfo where category = 1 and (param6  >= 11 and param6 <= 13) order by newid()
select top 1 itemname, param6 from dbo.tFVItemInfo where category = 1 and (param6  >= 15 and param6 <= 20) order by newid()
select top 1 itemname, param6 from dbo.tFVItemInfo where category = 1 and (param6  >= 20 and param6 <= 30) order by newid()
*/




/*
alter table dbo.tFVComReward add gameyear		int
alter table dbo.tFVComReward add gamemonth	int
alter table dbo.tFVComReward add famelv		int

update dbo.tFVComReward set gameyear = -1, gamemonth = -1, famelv = -1
*/




/*
alter table dbo.tFVComReward add ispass			int				default(-1)
update dbo.tFVComReward set ispass = -1
*/



/*
---------------------------------------------
-- 	룰렛 로그 > 광고용 로그.
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserAdLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserAdLog;
GO

create table dbo.tFVUserAdLog(
	idx				int				identity(1, 1),

	gameid			varchar(20),
	itemcode		int,
	comment			varchar(128)	default(''),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserAdLog_idx PRIMARY KEY(idx)
)
-- select top 100 * from dbo.tFVUserAdLog order by idx desc
-- insert into dbo.tFVUserAdLog(gameid, itemcode, comment) values('xxxx2', 101, 'xxxx2님이 [양]을 교배로 얻었습니다.')
-- delete from dbo.tFVUserAdLog where idx = @idx - 100
-- update dbo.tFVUserAdLog set adidx = @idx where gameid = @gameid_
-- select top 1 * from dbo.tFVUserAdLog where idx = 1 order by idx desc

*/





/*
-- joinooo
declare @incomedate		datetime
declare @cnt			int

set @incomedate =  '2013-11-28 14:12'
select dbo.fnu_GetFVDatePart('hh', @incomedate, getdate()), dbo.fnu_GetFVDatePart('hh', getdate(), @incomedate)

set @incomedate =  '2013-11-29 14:28'
select dbo.fnu_GetFVDatePart('hh', @incomedate, getdate()), dbo.fnu_GetFVDatePart('hh', getdate(), @incomedate)
*/





/*
alter table dbo.tFVUserMaster add adidx		int						default(0)
update dbo.tFVUserMaster set adidx = 0
*/


/*
select getdate(), dateadd(mi, -115, getdate()), dateadd(mi, -9, getdate()), dateadd(mi, -10, getdate())

update dbo.tFVUserFarm set incomedate = dateadd(mi, -116, getdate()), buystate = 1 where gameid = 'guest91050' and itemcode = 6900
exec spu_FVUserFarm 'guest91050', '9564023o4g7n4b282174',  2, 6900, -1		-- 수입


update dbo.tFVUserFarm
	set
		incomedate = DATEADD(mi, dbo.fnu_GetFVDatePart('hh', 	incomedate, getdate()) * 60, incomedate)
where gameid = 'guest91050' and itemcode = 6900
*/

/*

declare @d1		datetime,
		@d2		datetime,
		@d21	datetime,
		@d22	datetime,
		@d23	datetime
set @d1 = getdate()
set @d2 = dateadd(mi, -60, getdate())
set @d21 = dateadd(mi, -59, getdate())
set @d22 = dateadd(mi, -60, getdate())
set @d23 = dateadd(mi, -61, getdate())

SELECT datepart(hour, @d1 - @d2), DATEDIFF(ss, @d1, @d2) ss, DATEDIFF(mm, @d1, @d2) mm, DATEDIFF(hh, @d1, @d2) hh, DATEDIFF(dd, @d1, @d2) dd
select datepart(hour, @d1 - @d21), datepart(hour, @d1 - @d22), datepart(hour, @d1 - @d23)

select
        *,
        Days          = datediff(dd, 0, DateDif),
        Hours         = datepart(hour, DateDif),
        Minutes       = datepart(minute, DateDif),
        Seconds       = datepart(second,DateDif),
        MS            = datepart(ms,DateDif)
from
        (
        select
                DateDif = EndDate-StartDate,
                aa.*
        from
                (  -- Test Data
                Select
                        --StartDate = convert(datetime, '2009-07-15 13:24:37.923'),
                        --EndDate   = convert(datetime, '2009-07-15 14:23:45.837')
                        StartDate = @d2,
                        EndDate   = @d1
                ) aa
        ) a


*/

/*
alter table dbo.tFVUserFarm add buycount		int					default(0)
update dbo.tFVUserFarm set buycount = 0

*/


/*
alter table dbo.tFVUserMaster add bgroulcnt	int						default(0)
update dbo.tFVUserMaster set bgroulcnt = 0

*/

/*
						//경쟁모드 파트위치.
						BKT_WOLF_KILL_CNT					= 1,	//누적늑대잡이(1).
						BKT_SALE_COIN						= 11,	//누적판매금액(11).
						BKT_HEART 							= 12,	//누적하트획득(12).
						BKT_FEED 							= 13,	//누적건초획득(13).
						BKT_SUCCESS_CNT 					= 14,	//최고거래성공횟수(14).
						BKT_BEST_FRESH 						= 15,	//최고신선도(15).
						BKT_BEST_BARREL 					= 16,	//최고배럴(16).
						BKT_BEST 							= 17,	//최고판매금액(17).
						BKT_BARREL							= 18,	//누적배럴(18).
						BKT_CROSS_NORMAL 					= 21,	//누적일반교배(21).
						BKT_CROSS_PREMIUM 					= 22,	//누적프리미엄교배(22).

						BKT_FIELD_ANI_COUNT					= 30,	//필드동물수량(30)(사용순간)
						BKT_USER_FAME_LV 					= 31,	//명성레벨(31)
						BKT_USER_FRIEND_ADD 				= 32,	//친구추가(32)
						BKT_USER_FRIEND_HEART				= 33,	//친구하트선물(33)

						BKT_USER_EXTEND_SEED 				= 40,	//경작지확장(40)(인벤정보참조)
						BKT_USER_EXTEND_ANI 				= 41,	//동물인벤확장(41)
						BKT_USER_EXTEND_CONSUME 			= 42,	//소비인벤확장(42)
						BKT_USER_EXTEND_ACC					= 43,	//악세인벤확장(43)

						BKT_UPGRADE_HOUSE 					= 50,	//집(50)(업그레이드 정보참조)
						BKT_UPGRADE_MILKTANK 				= 51,	//탱크(51)
						BKT_UPGRADE_BASKET 					= 52,	//양동이(52)
						BKT_UPGRADE_PUMP 					= 53,	//착유기(53)
						BKT_UPGRADE_TRANSFER				= 54,	//주입기(54)
						BKT_UPGRADE_PURE 					= 55,	//정화시설(55)
						BKT_UPGRADE_FRESHCOOl				= 56,	//저온보관(56)

						BKT_USED_BOOSTER 					= 61,	//소모템일반 촉진제(61)(소모템 사용순간.)
						BKT_USED_VACCINE 					= 62,	//소모템일반 치료제(62)
						BKT_USED_ALBA 						= 63,	//소모템농부(63)
						BKT_USED_BULLET 					= 64,	//소모템늑대용 공포탄(64)
						BKT_USED_HELPER						= 65,	//소모템긴급지원(65)
*/

/*
	declare @gameid			varchar(60)
	declare @gameyear 		int
	declare @cy		 		int
	set @gameid = 'xxxx2'
	set @cy		= 2047

update dbo.tFVUserMaster set gameyear = @cy where gameid = @gameid
--update dbo.tFVUserFarm set incomedate = getdate() where gameid = @gameid

					select @gameyear = gameyear from dbo.tFVUserMaster where gameid = @gameid
					select b.gamecost,
						DATEDIFF(hh, incomedate, getdate()),
						DATEDIFF(hh, incomedate, getdate()) * param1 hourcoin2,
						(gamecost + gamecost * param4 * (case when (@gameyear - param3 <= 0) then 0 else (@gameyear - param3) end) / 100) as gamecost2,
						b.itemname, b.param1 hourcoin, b.param2 maxcoin, b.param3 raiseyear, b.param4 raisepercent
						from dbo.tFVUserFarm a
						LEFT JOIN
						(select * from dbo.tFVItemInfo where subcategory = 69) b
						ON a.farmidx = b.itemcode
					where gameid = @gameid order by farmidx asc
*/


/*
---------------------------------------------
--		전국목장
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserFarm', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserFarm;
GO

create table dbo.tFVUserFarm(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),									--
	farmidx			int,											-- 농장번호
	itemcode		int,											-- 아이템코드
	incomedate		datetime			default(getdate()),			-- 회수일.
	incomett		int					default(0),

	buystate 		int					default(-1),				-- 비구매(-1), 구매중(1)
	buydate			datetime			default(getdate()),			-- 구매일.

	-- Constraint
	CONSTRAINT	pk_tUserFarm_gameid_farmidx	PRIMARY KEY(gameid, farmidx)
)
-- alter table dbo.tFVUserFarm add incomett		int					default(0)
-- update dbo.tFVUserFarm set incomett = 0
--IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserFarm_idx')
--    DROP INDEX tFVUserFarm.idx_tFVUserFarm_idx
--GO
--CREATE INDEX idx_tFVUserFarm_idx ON tUserFarm (idx)
--GO
--
-- 이미만들어진것은 커서를 돌면서 입력하기.
-- insert into dbo.tFVUserFarm(gameid, farmidx) select 'xxxx2', itemcode from dbo.tFVItemInfo where subcategory = 69 order by itemcode asc
-- select * from dbo.tFVUserFarm where gameid = 'xxxx2' order by farmidx asc
-- update dbo.tFVUserFarm set buystate =  1 where gameid = 'xxxx2' and farmidx = 6900				-- 구매
-- update dbo.tFVUserFarm set buystate = -1 where gameid = 'xxxx2' and farmidx = 6900				-- 판매
-- update dbo.tFVUserFarm set incomedate = getdate(), incomett = incomett + 100 where gameid = 'xxxx2' and farmidx = 6900	-- 수입
--                   DATEDIFF(datepart , @incomedate , getdate() )
-- select getdate(), DATEDIFF(hh, '2013-11-23 12:00', '2013-11-23 11:00') -- -60	> -1
-- select getdate(), DATEDIFF(hh, '2013-11-23 12:00', '2013-11-23 12:59') -- +59	> 0
-- select getdate(), DATEDIFF(hh, '2013-11-23 12:00', '2013-11-23 13:00') -- +60	> 1
-- select getdate(), DATEDIFF(hh, '2013-11-23 12:00', '2013-11-23 13:01') -- +61	> 1
-- select max(idx) from dbo.tFVUserFarm
--select a.*, b.itemname, b.param1 hourcoin, b.param2 maxcoin, b.param3 raiseyear, b.param4 raisepercent
--	from dbo.tFVUserFarm a
--	LEFT JOIN
--	(select * from dbo.tFVItemInfo where subcategory = 69) b
--	ON a.farmidx = b.itemcode
--where gameid = 'xxxx2' order by farmidx asc
*/

/*
-- 1. 커서 생성
declare @gameid 	varchar(20)

declare curUserFarm Cursor for
select gameid FROM dbo.tFVUserMaster

-- 2. 커서오픈
open curUserFarm

-- 3. 커서 사용

Fetch next from curUserFarm into @gameid
while @@Fetch_status = 0
	Begin

		insert into dbo.tFVUserFarm(farmidx, gameid, itemcode)
		select rank() over(order by itemcode asc) as farmidx, @gameid, itemcode from dbo.tFVItemInfo where subcategory = 69 order by itemcode asc

		Fetch next from curUserFarm into @gameid
	end

-- 4. 커서닫기
close curUserFarm
Deallocate curUserFarm

*/




/*
alter table dbo.tFVDayLogInfoStatic add fpointcnt		int				default(0)
update dbo.tFVDayLogInfoStatic set fpointcnt = 0

alter table dbo.tFVUserMaster add fmonth		int						default(0)
update dbo.tFVUserMaster set fmonth = 0
*/

/*
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItemDel_gameid_idx2')
    DROP INDEX tFVUserItemDel.idx_tFVUserItemDel_gameid_idx2
GO
CREATE INDEX idx_tFVUserItemDel_gameid_idx2 ON tUserItemDel (gameid, idx2)
GO

*/

/*
-- alter table dbo.tFVUserItemDel add state			int					default(0)
-- update dbo.tFVUserItemDel set state = 0
-- alter table dbo.tFVUserItemDel add idx2			int
-- alter table dbo.tFVUserItemDel add writedate2		datetime			default(getdate())
-- select gameid gameid2 , idx2, * FROM dbo.tFVUserItemDel order by gameid, idx asc

-- 1. 커서 생성
declare @gameid 	varchar(20),
		@gameid2 	varchar(20),
		@idx		int,
		@idx2		int

set @gameid2 	= ''
set @idx2	 	= 1

declare curUserItemDel Cursor for
select idx, gameid FROM dbo.tFVUserItemDel order by gameid, idx asc

-- 2. 커서오픈
open curUserItemDel

-- 3. 커서 사용


Fetch next from curUserItemDel into @idx, @gameid
while @@Fetch_status = 0
	Begin
		select 'DEBUG > ', @idx idx, @gameid gameid, @idx2 idx2

		if(@gameid != @gameid2)
			begin
				select 'DEBUG > 다음'
				set @gameid2	= @gameid
				set @idx2 		= 1
			end

			update dbo.tFVUserItemDel
				set
					idx2		= @idx2,
					writedate2	= writedate
			from dbo.tFVUserItemDel
			where idx = @idx

			set @idx2 = @idx2 + 1

		Fetch next from curUserItemDel into @idx, @gameid
	end

-- 4. 커서닫기
close curUserItemDel
Deallocate curUserItemDel

*/



/*

update dbo.tFVUserMaster set tutorial = 0 where gameid = 'xxxx2'
delete from dbo.tFVGiftList where  gameid = 'xxxx2'
select tutorial, * from dbo.tFVUserMaster where gameid = 'xxxx2'
exec spu_FVTutorial 'xxxx2', '049000s1i0n7t8445289', 1, -1		-- 정독.
exec spu_FVTutorial 'xxxx2', '049000s1i0n7t8445289', 2, -1		-- 재튜토리얼.

update dbo.tFVUserMaster set tutorial = 0 where gameid = 'xxxx2'
delete from dbo.tFVGiftList where  gameid = 'xxxx2'
select tutorial, * from dbo.tFVUserMaster where gameid = 'xxxx2'
exec spu_FVTutorial 'xxxx2', '049000s1i0n7t8445289', 2, -1		-- 재튜토리얼.
exec spu_FVTutorial 'xxxx2', '049000s1i0n7t8445289', 2, -1		-- 재튜토리얼.


update dbo.tFVUserMaster set tutorial = 0 where gameid = 'xxxx2'
delete from dbo.tFVGiftList where  gameid = 'xxxx2'
select tutorial, * from dbo.tFVUserMaster where gameid = 'xxxx2'
exec spu_FVTutorial 'xxxx2', '049000s1i0n7t8445289', 3, -1		-- Skip.
exec spu_FVTutorial 'xxxx2', '049000s1i0n7t8445289', 2, -1		-- 재튜토리얼.


*/

/*
alter table dbo.tFVUserItem add freerevdate		datetime			default(getdate() - 1)
update dbo.tFVUserItem set freerevdate		=			getdate() - 1

select gameid, count(*) from dbo.tFVUserItem group by gameid having count(*) > 12 order by 2 desc
*/

/*
delete from dbo.tFVUserSaleLog where gameid = 'guest90937'
delete from dbo.tFVGiftList where gameid = 'guest90937'
update dbo.tFVUserMaster set gameyear = 2013, gamemonth = 3, frametime = 0 where gameid = 'guest90937'
update dbo.tFVUserMaster set fame = 5, famelv = 2, tradecnt = 1, prizecnt = 1 where gameid = 'guest90937'
update dbo.tFVUserMaster set gamecost = 0, cashcost = 0, feed = 0, heart = 0 where gameid = 'guest90937'
exec spu_FVGameTrade 'guest90937', '9031206u6e0q7v417458',
									'0:2013;1:4;2:0;4:0;10:0;11:0;12:180;13:20160;30:14;',
									'14:6,18,0;25:5,25,0;0:5,16,0;24:5,20,0;2:5,14,0;3:5,13,0;21:5,9,0;20:5,8,0;22:5,10,0;23:5,10,0;',
									'',
									'0:53;1:5;10:8;11:1;12:0;20:0;30:0;31:19;32:0;33:3;34:112;35:57;40:-1;50:1;',
									-1										-- 필드없음.

exec spu_FVGameTrade 'guest90937', '9031206u6e0q7v417458',
									'0:2013;1:5;2:0;4:0;10:0;11:0;12:90;13:7650;30:14;',
									'14:6,18,0;25:5,25,0;0:2,18,0;24:2,19,0;2:2,16,0;3:2,14,0;21:2,7,0;20:2,7,0;22:2,8,0;23:2,8,0;',
									'',
									'0:58;1:5;10:9;11:1;12:0;20:0;30:4;31:23;32:0;33:6;34:85;35:138;40:-1;50:0;',
									-1										-- 필드없음.

exec spu_FVGameTrade 'guest90937', '9031206u6e0q7v417458',
									'0:2013;1:6;2:0;4:0;10:0;11:0;12:90;13:4410;30:14;',
									'14:6,18,0;25:5,25,0;0:3,18,0;24:3,17,0;2:3,16,0;3:4,14,0;21:4,3,0;20:5,1,0;22:4,4,0;23:4,4,0;',
									'7:1;10:1;',
									'0:63;1:5;10:10;11:1;12:0;20:0;30:4;31:23;32:0;33:6;34:49;35:138;40:-1;50:0;',
									-1										-- 필드없음.

exec spu_FVGameTrade 'guest90937', '9031206u6e0q7v417458',
									'0:2013;1:7;2:0;4:0;10:0;11:0;12:120;13:4200;30:11;',
									'14:6,18,0;25:5,25,0;0:4,20,0;24:6,17,0;2:5,18,0;3:5,15,0;21:5,2,0;20:5,26,0;22:5,2,0;23:5,3,0;26:5,10,0;',
									'7:1;',
									'0:68;1:5;10:11;11:1;12:0;20:0;30:4;31:23;32:0;33:6;34:35;35:138;40:-1;50:2;',
									-1										-- 필드없음.

exec spu_FVGameTrade 'guest90937', '9031206u6e0q7v417458',
									'0:2013;1:8;2:0;4:0;10:0;11:0;12:0;13:0;30:17;',
									'14:6,18,0;25:5,25,0;0:8,21,0;24:8,17,0;2:9,19,0;3:9,15,0;21:9,24,0;20:9,23,0;22:9,25,0;23:9,0,0;26:9,12,0;',
									'10:1;',
									'0:78;1:6;10:12;11:2;12:150;20:0;30:3;31:22;32:2;33:10;34:31;35:240;40:2005;50:0;',
									-1										-- 필드없음.

exec spu_FVGameTrade 'guest90937', '9031206u6e0q7v417458',
									'0:2013;1:9;2:0;4:0;10:0;11:0;12:11;13:330;30:16;',
									'14:6,18,0;25:5,25,0;0:6,23,0;24:6,17,0;2:6,21,0;3:6,16,0;21:6,23,0;20:6,21,0;22:7,23,0;23:7,24,0;26:8,13,0;',
									'',
									'0:88;1:6;10:13;11:2;12:0;20:0;30:1;31:20;32:2;33:8;34:30;35:176;40:1000;50:0;',
									-1										-- 필드없음.

exec spu_FVGameTrade 'guest90937', '9031206u6e0q7v417458',
									'0:2013;1:10;2:0;4:2;10:28;11:887;12:20;13:640;30:15;',
									'14:6,18,0;25:5,25,0;0:2,21,0;24:2,12,0;2:3,21,0;3:2,14,0;21:2,16,0;20:2,12,0;22:2,17,0;23:3,17,0;26:2,12,0;',
									'7:1;8:2;10:1;',
									'0:98;1:6;10:14;11:2;12:0;20:1;30:0;31:19;32:2;33:9;34:32;35:189;40:900;50:1;',
									-1										-- 필드없음.

exec spu_FVGameTrade 'guest90937', '9031206u6e0q7v417458',
									'0:2013;1:11;2:0;4:2;10:28;11:1244;12:95;13:2755;30:15;',
									'14:6,18,0;25:5,25,0;0:2,21,0;24:2,10,0;2:1,21,0;3:2,12,0;21:2,11,0;20:2,7,0;22:3,12,0;23:3,12,0;26:3,11,0;',
									'8:2;',
									'0:103;1:6;10:15;11:2;12:0;20:1;30:5;31:25;32:0;33:6;34:29;35:150;40:-1;50:0;',
									-1										-- 필드없음.

exec spu_FVGameTrade 'guest90937', '9031206u6e0q7v417458',
									'0:2013;1:12;2:0;4:2;10:5;11:236;12:0;13:0;30:15;',
									'14:6,18,0;25:5,25,0;0:2,20,0;24:2,7,0;2:3,20,0;3:2,11,0;21:3,8,0;20:3,1,0;22:3,7,0;23:3,7,0;26:7,11,0;',
									'8:2;',
									'0:113;1:7;10:16;11:2;12:0;20:1;30:1;31:20;32:2;33:11;34:31;35:242;40:900;50:0;',
									-1										-- 필드없음.

exec spu_FVGameTrade 'guest90937', '9031206u6e0q7v417458',
									'0:2014;1:1;2:0;4:3;10:0;11:0;12:24;13:744;30:18;',
									'14:6,18,0;25:5,25,0;0:2,22,0;24:2,7,0;2:3,22,0;3:3,14,0;21:4,6,0;20:3,25,0;22:3,5,0;23:4,5,0;26:4,14,0;',
									'10:1;',
									'0:120;1:7;10:17;11:2;12:0;20:0;30:3;31:22;32:1;33:7;34:31;35:161;40:-1;50:2;',
									-1										-- 필드없음.


*/


/*
--select * FROM dbo.tFVUserItemBuyLog order by gameid desc, buydate2 desc, itemcode desc

-- 1. 커서 생성
declare @gameid 	varchar(20),
		@gameid2 	varchar(20),
		@buydate	varchar(8),
		@buydate2	varchar(8),
		@idx		int,
		@idx2		int,
		@itemcode	int,
		@itemcode2	int,
		@cnt		int,
		@cnt2		int,
		@cashcost	int,
		@gamecost	int

set @gameid2 	= ''
set @buydate2	= ''
set @idx2	 	= 1
set @itemcode2	= -1
set @cnt2		= -1

declare curUserItemBuyLog Cursor for
select idx, gameid, buydate2, itemcode, cnt, cashcost, gamecost FROM dbo.tFVUserItemBuyLog order by gameid desc, buydate2 desc, itemcode desc

-- 2. 커서오픈
open curUserItemBuyLog

-- 3. 커서 사용


Fetch next from curUserItemBuyLog into @idx, @gameid, @buydate, @itemcode, @cnt, @cashcost, @gamecost
while @@Fetch_status = 0
	Begin
		--select 'DEBUG > ', @idx idx, @gameid gameid, @buydate buydate, @itemcode itemcode, @cnt cnt, @cashcost cashcost, @gamecost gamecost, @gameid2 gameid2, @buydate2 buydate2, @itemcode2 itemcode2, @idx2 idx2

		if(@gameid = @gameid2 and @buydate = @buydate2 and @itemcode = @itemcode2)
			begin
				--select 'DEBUG > 통합', @idx2 idx2
				update dbo.tFVUserItemBuyLog
					set
						cashcost	= cashcost	+ @cashcost,
						gamecost	= gamecost	+ @gamecost,
						cnt			= cnt		+ @cnt
				from dbo.tFVUserItemBuyLog
				where idx = @idx2

				delete from dbo.tFVUserItemBuyLog  where idx = @idx
			end
		else
			begin
				--select 'DEBUG > 다음'
				set @gameid2	= @gameid
				set @buydate2	= @buydate
				set @itemcode2	= @itemcode
				set @idx2 		= @idx
			end
		Fetch next from curUserItemBuyLog into @idx, @gameid, @buydate, @itemcode, @cnt, @cashcost, @gamecost
	end

-- 4. 커서닫기
close curUserItemBuyLog
Deallocate curUserItemBuyLog
*/





/*
--유저 검색용 인덱스
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItemBuyLog_gameid_idx2')
    DROP INDEX tFVUserItemBuyLog.idx_tFVUserItemBuyLog_gameid_idx2
GO
CREATE INDEX idx_tFVUserItemBuyLog_gameid_idx2 ON tUserItemBuyLog (gameid, idx2)
GO


IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItemBuyLog_gameid_buydate2_itemcode')
    DROP INDEX tFVUserItemBuyLog.idx_tFVUserItemBuyLog_gameid_buydate2_itemcode
GO
CREATE INDEX idx_tFVUserItemBuyLog_gameid_buydate2_itemcode ON tUserItemBuyLog (gameid, buydate2, itemcode)
GO


IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItemBuyLog_gameid_itemcode')
    DROP INDEX tFVUserItemBuyLog.idx_tFVUserItemBuyLog_gameid_itemcode
GO
CREATE INDEX idx_tFVUserItemBuyLog_gameid_itemcode ON tUserItemBuyLog (gameid, itemcode)
GO

*/

/*
----------------------------------------------
-- exec spu_FVUserItemBuyLog 'guest90909', 600, 5, 0
-- select * from dbo.tFVUserItemBuyLog where gameid = 'guest90909' order by idx desc
-- update dbo.tFVUserItemBuyLog set cnt		= 1
-- alter table dbo.tFVUserItemBuyLog add cnt			int					default(1)
-- alter table dbo.tFVUserItemBuyLog add idx2		int
-- alter table dbo.tFVUserItemBuyLog add buydate2	varchar(8)
-- select * FROM dbo.tFVUserItemBuyLog where gameid = 'guest90909' order by gameid, idx desc
-- select * FROM dbo.tFVUserItemBuyLog order by gameid, idx asc
----------------------------------------------
-- 1. 커서 생성
declare @gameid 	varchar(20),
		@gameid2 	varchar(20),
		@buydate	datetime,
		@idx		int,
		@idx2		int
set @gameid2 	= ''
set @idx2	 	= 1

declare curUserItemBuyLog Cursor for
select gameid, idx, buydate FROM dbo.tFVUserItemBuyLog order by gameid, idx asc

-- 2. 커서오픈
open curUserItemBuyLog

-- 3. 커서 사용


Fetch next from curUserItemBuyLog into @gameid, @idx, @buydate
while @@Fetch_status = 0
	Begin
		--select 'DEBUG ', @gameid, @gameid2, @idx, @idx2
		if(@gameid != @gameid2)
			begin
				set @gameid2	= @gameid
				set @idx2	 	= 1
			end

		update dbo.tFVUserItemBuyLog
			set
				idx2 		= @idx2,
				buydate2	= Convert(varchar(8), @buydate,112),
				cnt			= 1
		from dbo.tFVUserItemBuyLog
		where idx = @idx

		set @idx2 = @idx2 + 1
		Fetch next from curUserItemBuyLog into @gameid, @idx, @buydate
	end

-- 4. 커서닫기
close curUserItemBuyLog
Deallocate curUserItemBuyLog
*/



/*
----------------------------------------------
-- 내부번호를 보고 필드번호세팅
-- select * FROM dbo.tFVGiftList order by gameid, idx asc
----------------------------------------------
-- 1. 커서 생성
declare @gameid 	varchar(20),
		@gameid2 	varchar(20),
		@idx		int,
		@idx2		int
set @gameid2 	= ''
set @idx2	 	= 1

declare curGiftList Cursor for
select gameid, idx FROM dbo.tFVGiftList order by gameid, idx asc

-- 2. 커서오픈
open curGiftList

-- 3. 커서 사용


Fetch next from curGiftList into @gameid, @idx
while @@Fetch_status = 0
	Begin
		select 'DEBUG ', @gameid, @gameid2, @idx, @idx2
		if(@gameid != @gameid2)
			begin
				set @gameid2	= @gameid
				set @idx2	 	= 1
			end

		update dbo.tFVGiftList
			set
				idx2 		= @idx2
		from dbo.tFVGiftList
		where idx = @idx

		set @idx2 = @idx2 + 1
		Fetch next from curGiftList into @gameid, @idx
	end

-- 4. 커서닫기
close curGiftList
Deallocate curGiftList
*/

/*
select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -4, 60, -1, -1, -1, -1	-- 소	(인벤)
select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'

select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -4, 61, -1, -1, -1, -1	-- 양	(필드6)
select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'

select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -4, 62, -1, -1, -1, -1	-- 산양 (필드6 충돌)
select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'

select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -4, 63, -1, -1, -1, -1	-- 총알(번호불일치)
select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'

select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -4, 64, -1, -1, -1, -1	-- 치료제
select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'

select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -4, 66, -1, -1, -1, -1	-- 일꾼
select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'

select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -4, 67, -1, -1, -1, -1	-- 촉진제
select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'

select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -4, 68, -1, -1, -1, -1	-- 부활석
select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'

select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -4, 69, -1, -1, -1, -1	-- 악세
select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'

select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -4, 73, -1, -1, -1, -1	-- 일반교배티켓
select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'

select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -4, 74, -1, -1, -1, -1	-- 대회티켓B
select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'

select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -4, 76, -1, -1, -1, -1	-- 상인100프로만족
select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'

select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -4, 77, -1, -1, -1, -1	-- 긴급요청티켓
select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'

select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -4, 65, -1, -1,  1, -1	-- 건초
select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'

select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -4, 70, -1, -1, -1, -1	-- 하트
select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'

select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -4, 71, -1, -1, -1, -1	-- 캐쉬
select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'

select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', -4, 72, -1, -1, -1, -1	-- 코인
select gamecost from dbo.tFVUserMaster where gameid = 'xxxx6'
*/

/*
---------------------------------------------
--		저장정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserSaveLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserSaveLog;
GO

create table dbo.tFVUserSaveLog(
	--(일반정보)
	idx			int 					IDENTITY(1, 1),
	idx2		int,

	gameid		varchar(20),
	gameyear		int					default(-1),
	gamemonth		int					default(-1),
	frametime		int					default(-1),

	fevergauge		int					default(-1),
	bottlelittle	int					default(-1),
	bottlefresh		int					default(-1),
	tanklittle		int					default(-1),
	tankfresh		int					default(-1),
	feeduse			int					default(-1),
	boosteruse		int					default(-1),
	albause			int					default(-1),
	wolfappear		int					default(-1),
	wolfkillcnt		int					default(-1),

	userinfo		varchar(1024)		default(''),
	aniitem			varchar(2048)		default(''),
	cusitem			varchar(1024)		default(''),

	writedate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT pk_tUserSaveLog_idx	PRIMARY KEY(idx)
)
GO

-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserSaveLog_gameid_gameyear_gamemonth_frametime')
    DROP INDEX tFVUserSaveLog.idx_tFVUserSaveLog_gameid_gameyear_gamemonth_frametime
GO
CREATE INDEX idx_tFVUserSaveLog_gameid_gameyear_gamemonth_frametime ON tUserSaveLog (gameid, gameyear, gamemonth, frametime)
GO

-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserSaveLog_gameid_idx2')
    DROP INDEX tFVUserSaveLog.idx_tFVUserSaveLog_gameid_idx2
GO
CREATE INDEX idx_tFVUserSaveLog_gameid_idx2 ON tUserSaveLog (gameid, idx2)
GO

--select top 1 * from dbo.tFVUserSaveLog where gameid = 'xxxx2' and gameyear = 2013 and gamemonth = 4 and frametime = 12
--select top 1 idx2 from dbo.tFVUserSaveLog where gameid = 'xxxx2' order by idx desc
--insert into dbo.tFVUserSaveLog(
--	idx2,
--	gameid, 		gameyear, 			gamemonth, 			frametime,
--	fevergauge, 	bottlelittle, 		bottlefresh, 		tanklittle,		tankfresh,
--	feeduse,		boosteruse,			albause,			wolfappear,		wolfkillcnt,
--	userinfo,		aniitem,			cusitem
--)
--values(
--	1,
--	'xxxx3', 		2013,				3,      			12,
--	4,       		11,       			101,     			21,     		201,
--	16,  			-1,    			 	-1,  				-1,     		1,
--	'0:2013;1:3;2:13;4:4;10:11;11:101;12:21;13:201;30:16;40:-1;41:-1;42:-1;43:1;',
--	'1:5,1,1;3:5,23,0;4:5,25,-1;',
--	'14:1;15:1;16:1;'
--)
*/



/*



---------------------------------------------
--	백업스케쥴러 포인트
--	(덤프 단위로 할경우)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSchoolSchedule', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSchoolSchedule;
GO

create table dbo.tFVSchoolSchedule(
	--(가입)
	idx				int					identity(1, 1),
	dateid			varchar(8),										-- 20121118
	idxStart		int					default(0),
	writedate		datetime			default(getdate()), 		-- 작성일

	-- Constraint
	CONSTRAINT pk_tSchoolSchedule_dateid	PRIMARY KEY(dateid)
)
GO

-- select * from tSchoolSchedule
-- if(not exist(select dateid from dbo.tFVSchoolSchedule where dateid = '20121118'))
-- insert into dbo.tFVSchoolSchedule(dateid) values('20121118', 1000)
-- update tSchoolSchedule
-- 	set
--		idxStart = idx
-- where dateid = '20121118'

*/


/*
alter table dbo.tFVUserMaster add ttsalecoinbkup	int					default(0)
update dbo.tFVUserMaster
	set ttsalecoinbkup = 0
*/



/*
alter table dbo.tFVUserMaster add comreward	int						default(-1)
update dbo.tFVUserMaster
	set comreward = -1
*/
/*

alter table dbo.tFVUserMaster add ttsalecoin		int					default(0)
update dbo.tFVUserMaster
	set ttsalecoin = 0
*/


/*
alter table dbo.tFVRouletteLogPerson add gameyear			int
alter table dbo.tFVRouletteLogPerson add gamemonth		int
alter table dbo.tFVRouletteLogPerson add friendid			varchar(20)
alter table dbo.tFVRouletteLogPerson add frienditemcode	int				default(-1)
alter table dbo.tFVRouletteLogPerson add frienditemname	varchar(40)

update tRouletteLogPerson
	set
		gameyear		= 2013,
		gamemonth		= 3,
		friendid		= 'Empty',
		frienditemcode	= 1,
		frienditemname	= '젖소'
*/


/*
-- 플레이 수
select gameid, count(*) from dbo.tFVUserSaleLog
group by gameid
order by 2 desc
*/

/*

alter table dbo.tFVUserMaster add fpoint		int						default(0)
alter table dbo.tFVUserMaster add fpointmax	int						default(9900)
update dbo.tFVUserMaster	set fpoint = 0, fpointmax = 9900
*/

/*
--select * from tZGameName
--select * from tZGameNameIP
--delete from  tZGameNameIP
--update dbo.tFVZGameName set cnt = 5 where idx = 65

delete from dbo.tFVUserFriend where gameid in ('xxxx2', 'xxxx3') and friendid in ('xxxx2', 'xxxx3')
exec spu_FVFriend 'xxxx2','049000s1i0n7t8445289', 2, 'xxxx3', -1		-- 친구 추가(계속추가가능)
select * from dbo.tFVUserFriend where gameid in ('xxxx2', 'xxxx3') and friendid in ('xxxx2', 'xxxx3')
*/


/*
declare @gameid_ varchar(60) set @gameid_ = 'xxxx2'
select m.gameid friendid, isnull(itemcode, 1) itemcode, isnull(acc1, -1) acc1, isnull(acc2, -1) acc2 from
	(select gameid, anireplistidx from dbo.tFVUserMaster where gameid in (select friendid from dbo.tFVUserFriend where gameid = @gameid_)) as m
LEFT JOIN
	(select gameid, listidx, itemcode, acc1, acc2 from dbo.tFVUserItem where gameid in (select friendid from dbo.tFVUserFriend where gameid = @gameid_)) as i
ON
	m.gameid = i.gameid and m.anireplistidx = i.listidx
order by itemcode desc


--declare @gameid_ varchar(60) set @gameid_ = 'xxxx'
select m.gameid friendid, isnull(itemcode, 1) itemcode, isnull(acc1, -1) acc1, isnull(acc2, -1) acc2, state, senddate from
	(select gameid, anireplistidx from dbo.tFVUserMaster where gameid in (select friendid from dbo.tFVUserFriend where gameid = @gameid_)) as m
LEFT JOIN
	(select gameid, listidx, itemcode, acc1, acc2 from dbo.tFVUserItem where gameid in (select friendid from dbo.tFVUserFriend where gameid = @gameid_)) as i
ON
	m.gameid = i.gameid and m.anireplistidx = i.listidx
JOIN
	(select friendid, state, senddate from dbo.tFVUserFriend where gameid = @gameid_) as f
ON
	m.gameid = f.friendid
order by itemcode desc

--select * from dbo.tFVUserFriend where gameid = 'xxxx2'
--update dbo.tFVUserFriend	set state = 2
*/

/*

---------------------------------------------
-- 	룰렛 로그 > 개인자료
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVRouletteLogPerson', N'U') IS NOT NULL
	DROP TABLE dbo.tFVRouletteLogPerson;
GO

create table dbo.tFVRouletteLogPerson(
	idx				int				identity(1, 1),

	gameid			varchar(20),
	kind			int,
	framelv			int,
	itemcode		int,
	itemcodename	varchar(40),

	cashcost		int				default(0),
	gamecost		int				default(0),
	heart			int				default(0),

	itemcode0		int				default(-1),
	itemcode1		int				default(-1),
	itemcode2		int				default(-1),
	itemcode3		int				default(-1),
	itemcode4		int				default(-1),
	itemcode0name	varchar(40)		default(''),
	itemcode1name	varchar(40)		default(''),
	itemcode2name	varchar(40)		default(''),
	itemcode3name	varchar(40)		default(''),
	itemcode4name	varchar(40)		default(''),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tRouletteLogPerson_idx PRIMARY KEY(idx)
)
-- gameid, idx
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVRouletteLogPerson_gameid_idx')
	DROP INDEX tFVRouletteLogPerson.idx_tFVRouletteLogPerson_gameid_idx
GO
CREATE INDEX idx_tFVRouletteLogPerson_gameid_idx ON tRouletteLogPerson (gameid, idx)
GO
-- select top 100 * from dbo.tFVRouletteLogPerson where gameid = 'xxxx2' order by idx desc


---------------------------------------------
-- 	교배뽑기했던 로그(월별 Master)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVRouletteLogTotalMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVRouletteLogTotalMaster;
GO

create table dbo.tFVRouletteLogTotalMaster(
	idx				int				identity(1, 1),
	dateid8			char(8),							-- 20101210

	normalcnt		int				default(0),
	premiumcnt		int				default(0),

	-- Constraint
	CONSTRAINT	pk_tRouletteLogTotalMaster_dateid	PRIMARY KEY(dateid8)
)
-- select top 1   * from dbo.tFVRouletteLogTotalMaster where dateid8 = '20120818'
-- insert into dbo.tFVRouletteLogTotalMaster(dateid8) values('20120818')
--update dbo.tFVRouletteLogTotalMaster
--	set
--		premiumcnt 	= premiumcnt + 1,
--		normalcnt 	= normalcnt + 1
--where dateid8 = '20120818'


---------------------------------------------
-- 	교배뽑기했던 로그(월별 Sub)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVRouletteLogTotalSub', N'U') IS NOT NULL
	DROP TABLE dbo.tFVRouletteLogTotalSub;
GO

create table dbo.tFVRouletteLogTotalSub(
	idx				int				identity(1, 1),

	dateid8			char(8),							-- 20101210
	itemcode		int,
	itemcodename	varchar(40)		default(''),

	normalcnt		int				default(0),
	premiumcnt		int				default(0),

	-- Constraint
	CONSTRAINT	pk_tRouletteLogTotalSub_dateid8_itemcode	PRIMARY KEY(dateid8, itemcode)
)
-- select top 1   * from dbo.tFVRouletteLogTotalSub where dateid8 = '20120818' and itemcode = 1
--update dbo.tFVRouletteLogTotalSub
--	set
--		premiumcnt 	= premiumcnt + 1,
--		normalcnt	= normalcnt + 1
--where dateid8 = '20120818' and itemcode = 1
-- insert into dbo.tFVRouletteLogTotalSub(dateid8, itemcode) values('20120818', 1)

*/















/*
alter table dbo.tFVUserMaster 	add fpoint		int						default(0)				--우정포인트.

update dbo.tFVUserMaster
	set
		fpoint			= 0

*/
/*
alter table dbo.tFVUserMaster 	add bkcoin			int					default(0)				-- 획득한코인.
alter table dbo.tFVUserMaster 	add bkheart			int					default(0)				--       하트.
alter table dbo.tFVUserMaster 	add bkfeed			int					default(0)				--       건초.
alter table dbo.tFVUserMaster 	add bktsuccesscnt	int					default(0)				-- 거래성공횟수.
alter table dbo.tFVUserMaster 	add bktbestfresh	int					default(0)				--       최고신선도.
alter table dbo.tFVUserMaster 	add bktbestbarrel	int					default(0)				--       최고배럴.
alter table dbo.tFVUserMaster 	add bktbestcoin		int					default(0)				--       최고판매금액.
alter table dbo.tFVUserMaster 	add bktwolfkillcnt	int					default(0)				-- 늑대잡은횟수.
alter table dbo.tFVUserMaster 	add bktsalecoin		int					default(0)				--       판매금액.
alter table dbo.tFVUserMaster 	add bkcrossnormal	int					default(0)				-- 일반교배.
alter table dbo.tFVUserMaster 	add bkcrosspremium	int					default(0)				-- 프리미엄교배.


update dbo.tFVUserMaster
	set
		bkcoin			= 0,
		bkheart 		= 0,
		bkfeed			 = 0,
		bktsuccesscnt	 = 0,
		bktbestfresh	 = 0,
		bktbestbarrel	 = 0,
		bktbestcoin		 = 0,
		bktwolfkillcnt	 = 0,
		bktsalecoin		 = 0,
		bkcrossnormal	 = 0,
		bkcrosspremium 	= 0
*/

/*
--delete from tUserPushAndroid
select * from tUserPushAndroid order by idx desc
select * from tUserPushAndroidLog order by idx desc
*/


/*
---------------------------------------------
--	Android Push Service
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPushAndroid', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPushAndroid;
GO

create table dbo.tFVUserPushAndroid(
	idx				int				identity(1, 1),

	sendid			varchar(20),
	receid			varchar(20),
	recepushid		varchar(256),
	sendkind		int,

	msgpush_id		int				default(99),
	msgtitle		varchar(512),
	msgmsg			varchar(512),
	msgaction		varchar(512)	default('LAUNCH'),

	actionTime		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserPushAndroid_idx	PRIMARY KEY(idx)
)

-- 내폰
--insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
--insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')
-- 진혁폰
--insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
--insert into dbo.tFVUserPushAndroid(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')
--
----------------------------------------------------
---- 푸쉬 읽어오기(데몬처리부분)
----------------------------------------------------
---- select top 100 * from dbo.tFVUserPushAndroid
---- 백업하기
--DECLARE @tTemp TABLE(
--				sendid			varchar(20),
--				receid			varchar(20),
--				recepushid		varchar(256),
--				sendkind		int,
--
--				msgpush_id		int,
--				msgtitle		varchar(512),
--				msgmsg			varchar(512),
--				msgaction		varchar(512)
--			);
----select * from dbo.tFVUserPushAndroid
--delete from dbo.tFVUserPushAndroid
--	OUTPUT DELETED.sendid, DELETED.receid, DELETED.recepushid, DELETED.sendkind, DELETED.msgpush_id, DELETED.msgtitle, DELETED.msgmsg, DELETED.msgaction into @tTemp
--	where idx in (1)
------select * from @tTemp
----
--insert into dbo.tFVUserPushAndroidLog(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
--	(select sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction from @tTemp)
--
----select * from dbo.tFVUserPushAndroidLog


---------------------------------------------
--	Android Push Service Log
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPushAndroidLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPushAndroidLog;
GO

create table dbo.tFVUserPushAndroidLog(
	idx				int				identity(1, 1),

	sendid			varchar(20),
	receid			varchar(20),
	recepushid		varchar(256),
	sendkind		int,

	msgpush_id		int				default(99),
	msgtitle		varchar(512),
	msgmsg			varchar(512),
	msgaction		varchar(512)	default('LAUNCH'),

	actionTime		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserPushAndroidLog_idx	PRIMARY KEY(idx)
)


-----------------------------------------------
---- Android Push > 통계용 > 메인에서 관리.
-----------------------------------------------
-- exec spu_FVDayLogInfoStatic 1, 50, 10				-- 일 push android
-- exec spu_FVDayLogInfoStatic 1, 51, 1				-- 일 push iphone
--
--IF OBJECT_ID (N'dbo.tFVUserPushAndroidTotal', N'U') IS NOT NULL
--	DROP TABLE dbo.tFVUserPushAndroidTotal;
--GO
--
--create table dbo.tFVUserPushAndroidTotal(
--	idx				int				identity(1, 1),
--
--	dateid			char(8),							-- 20101210
--	cnt				int				default(1),
--
--	-- Constraint
--	CONSTRAINT	pk_tUserPushAndroidTotal_dateid	PRIMARY KEY(dateid)
--)
---- select top 100 * from dbo.tFVUserPushAndroidTotal order by dateid desc
---- select top 100 * from dbo.tFVUserPushAndroidTotal where dateid = '20121129' order by dateid desc
----update dbo.tFVUserPushAndroidTotal
----	set
----		cnt = cnt + 1
----where dateid = '20120818'
---- insert into dbo.tFVUserPushAndroidTotal(dateid, cnt) values('20120818', 1)

---------------------------------------------
--	iPhone Push Service
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPushiPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPushiPhone;
GO

create table dbo.tFVUserPushiPhone(
	idx				int				identity(1, 1),

	sendid			varchar(20),
	receid			varchar(20),
	recepushid		varchar(256),
	sendkind		int,

	msgpush_id		int				default(99),
	msgtitle		varchar(512),
	msgmsg			varchar(512),
	msgaction		varchar(512)	default('LAUNCH'),

	actionTime		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserPushiPhone_idx	PRIMARY KEY(idx)
)

---- Push입력하기
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')

---------------------------------------------
--	iPhone Push Service Log
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPushiPhoneLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPushiPhoneLog;
GO

create table dbo.tFVUserPushiPhoneLog(
	idx				int				identity(1, 1),

	sendid			varchar(20),
	receid			varchar(20),
	recepushid		varchar(256),
	sendkind		int,

	msgpush_id		int				default(99),
	msgtitle		varchar(512),
	msgmsg			varchar(512),
	msgaction		varchar(512)	default('LAUNCH'),

	actionTime		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserPushiPhoneLog_idx	PRIMARY KEY(idx)
)
*/


/*
declare @friendid_ varchar(20)
-- 아이템별 인벤분류
declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
declare @grade		int		set @grade = 0

-- 있음(0).
set @friendid_ = 'xxxx2'
set @grade = 0
select @grade = param1 from dbo.tFVItemInfo
where itemcode = (select top 1 itemcode from dbo.tFVUserItem
				  where gameid = @friendid_ and invenkind = @USERITEM_INVENKIND_ANI
					    and listidx = (select top 1 anireplistidx from dbo.tFVUserMaster where gameid = @friendid_))
select @friendid_ friendid_, @grade grade

-- 있음(2).
set @friendid_ = 'xxxx4'
set @grade = 0
select @grade = param1 from dbo.tFVItemInfo
where itemcode = (select top 1 itemcode from dbo.tFVUserItem
				  where gameid = @friendid_ and invenkind = @USERITEM_INVENKIND_ANI
					    and listidx = (select top 1 anireplistidx from dbo.tFVUserMaster where gameid = @friendid_))
select @friendid_ friendid_, @grade grade

-- 있음(10).
set @friendid_ = 'xxxx5'
set @grade = 0
select @grade = param1 from dbo.tFVItemInfo
where itemcode = (select top 1 itemcode from dbo.tFVUserItem
				  where gameid = @friendid_ and invenkind = @USERITEM_INVENKIND_ANI
					    and listidx = (select top 1 anireplistidx from dbo.tFVUserMaster where gameid = @friendid_))
select @friendid_ friendid_, @grade grade

-- 없음.
set @friendid_ = 'xxxx3'
set @grade = 0
select @grade = param1 from dbo.tFVItemInfo
where itemcode = (select top 1 itemcode from dbo.tFVUserItem
				  where gameid = @friendid_ and invenkind = @USERITEM_INVENKIND_ANI
					    and listidx = (select top 1 anireplistidx from dbo.tFVUserMaster where gameid = @friendid_))
select @friendid_ friendid_, @grade grade
*/

/*
declare @friendid_ varchar(20)
set @friendid_ = 'xxxx5'
update dbo.tFVUserItem set
	 itemcode = 214
				  where gameid = @friendid_
					    and listidx = (select anireplistidx from dbo.tFVUserMaster where gameid = @friendid_)


*/
/*
update dbo.tFVUserMaster set bottlelittle = 0, bottlefresh = 0, tanklittle = 0, tankfresh = 0, gameyear = 2013, gamemonth = 3, tradecnt = 0, purestep = 0, prizecnt = 0, fame = 1, famelv = 1, cashcost = 10000, gamecost = 10000, heart = 500, randserial = -1 where gameid = 'guest90556'
delete from dbo.tFVUserSaleLog where gameid = 'guest90556'
update dbo.tFVUserItem set acc1 = 1400, acc2 = -1   where gameid = 'guest90556' and invenkind = 1

update dbo.tFVUserMaster set bottlelittle = 0, bottlefresh = 0, tanklittle = 0, tankfresh = 0, gameyear = 2013, gamemonth = 3, tradecnt = 0, purestep = 0, prizecnt = 0, fame = 1, famelv = 1, cashcost = 10000, gamecost = 10000, heart = 500, randserial = -1 where gameid = 'guest90556'
delete from dbo.tFVUserSaleLog where gameid = 'guest90556'
update dbo.tFVUserItem set acc1 = -1  , acc2 = 1419 where gameid = 'guest90556' and invenkind = 1



update dbo.tFVUserMaster set gameyear = 2013, gamemonth = 8, tradecnt = 0, purestep = 0, prizecnt = 0, fame = 1, famelv = 1, cashcost = 10000, gamecost = 10000, heart = 500, randserial = -1 where gameid = 'guest90556'
update dbo.tFVUserMaster set gameyear = 2013, gamemonth = 8, tradecnt = 0, purestep = 0, prizecnt = 0, fame = 20, famelv = 2, cashcost = 10000, gamecost = 10000, heart = 500, randserial = -1 where gameid = 'guest90556'
delete from dbo.tFVUserSaleLog where gameid = 'guest90556'
delete from dbo.tFVUserItem where gameid = 'guest90556' and randserial in('7770', '7771', '7772', '7773', '7774', '7775')


update dbo.tFVUserMaster set gameyear = 2013, gamemonth = 9, tradecnt = 0, purestep = 0, prizecnt = 0, fame = 31, famelv = 4, cashcost = 10000, gamecost = 10000, heart = 500, randserial = -1 where gameid = 'guest90556'
delete from dbo.tFVUserSaleLog where gameid = 'guest90556'


update dbo.tFVUserMaster set gameyear = 2013, gamemonth = 3, tradecnt = 0, purestep = 0, prizecnt = 0, fame = 1, famelv = 1, cashcost = 10000, gamecost = 10000, heart = 500, randserial = -1 where gameid = 'guest90556'
delete from dbo.tFVUserSaleLog where gameid = 'guest90556'
update dbo.tFVUserItem set acc1 = -1, acc2 = 1423, manger = 25 where gameid = 'guest90556' and invenkind = 1

update dbo.tFVUserMaster set gameyear = 2013, gamemonth = 3, tradecnt = 0, purestep = 0, prizecnt = 0, fame = 1, famelv = 1, cashcost = 10000, gamecost = 10000, heart = 500, randserial = -1 where gameid = 'guest90556'
delete from dbo.tFVUserSaleLog where gameid = 'guest90556'
update dbo.tFVUserItem set acc1 = 1405, acc2 = 1424, manger = 25 where gameid = 'guest90556'   and invenkind = 1

update dbo.tFVUserMaster set gameyear = 2013, gamemonth = 3, tradecnt = 0, purestep = 0, prizecnt = 0, fame = 1, famelv = 1, cashcost = 10000, gamecost = 10000, heart = 500, randserial = -1 where gameid = 'guest90556'
delete from dbo.tFVUserSaleLog where gameid = 'guest90556'
update dbo.tFVUserItem set acc1 = -1, acc2 = 1424, manger = 25 where gameid = 'guest90556'   and invenkind = 1

update dbo.tFVUserMaster set gameyear = 2013, gamemonth = 3, tradecnt = 0, purestep = 0, prizecnt = 0, fame = 1, famelv = 1, cashcost = 10000, gamecost = 10000, heart = 500, randserial = -1 where gameid = 'guest90556'
delete from dbo.tFVUserSaleLog where gameid = 'guest90556'
update dbo.tFVUserItem set acc1 = -1,	  acc2 = -1,   manger = 25 where gameid = 'guest90556' and invenkind = 1

*/


/*

90005	2
90001	3
90001	4
90001	5
90002	2
90002	3
90002	4
90002	5
90003	2
90003	3
90003	4
90003	5
90004	2
90004	3
90004	4
90004	5
90005	1
90005	3
90005	5
90001	5
90001	6
90002	5
90002	6
90003	5
90003	6
90004	5
90004	6
90005	5
90005	6



*/


/*
alter table dbo.tFVUserMaster add 	qtsalebarrel	int					default(0)
alter table dbo.tFVUserMaster add 	qtgetgamecost	int					default(0)
alter table dbo.tFVUserMaster add 	qtgetfame		int					default(0)
alter table dbo.tFVUserMaster add 	qtusefeed		int					default(0)
alter table dbo.tFVUserMaster add 	qttradesucces	int					default(0)
alter table dbo.tFVUserMaster add 	qtbestgamecost	int					default(0)
update dbo.tFVUserMaster
	set
		qtsalebarrel = 0,
		qtgetgamecost = 0,
		qtgetfame = 0,
		qtusefeed = 0,
		qttradesucces = 0,
		qtbestgamecost = 0
*/

/*
select dbo.fnu_GetFVCrossRandomValue(50,        1,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(50,        2,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(50,        3,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(50,        4,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(50,        5,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)

select dbo.fnu_GetFVCrossRandomValue(51,        1,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(51,        2,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(51,        3,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(51,        4,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(51,        5,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)


select dbo.fnu_GetFVCrossRandomValue(850,        1,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(850,        2,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(850,        3,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(850,        4,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(850,        5,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)

select dbo.fnu_GetFVCrossRandomValue(851,        1,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(851,        2,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(851,        3,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(851,        4,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(851,        5,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)


select dbo.fnu_GetFVCrossRandomValue(950,        1,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(950,        2,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(950,        3,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(950,        4,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(950,        5,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)


select dbo.fnu_GetFVCrossRandomValue(951,        1,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(951,        2,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(951,        3,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(951,        4,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(951,        5,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)


select dbo.fnu_GetFVCrossRandomValue(1951,        11,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(1951,        12,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(1951,        13,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(1951,        14,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
select dbo.fnu_GetFVCrossRandomValue(1951,        15,		50, 800, 100, 50,     1, 2, 3, 4, 5,  6, 7, 8, 9, 10, 11, 12, 13, 14, 15,  16, 17, 18, 19, 20)
*/


/*
declare @group4 int set @group4 = 2
declare @loop int set @loop = 0
while @loop < 5
	begin
		-- 1 <= x <= n
		-- Convert(int, ceiling(RAND() * n))

		select Convert(int, ceiling(RAND() * 2)), Convert(int, ceiling(RAND() * @group4))
		set @loop = @loop + 1
	end
*/


/*
 exec spu_FVFarmD 30, 22, -1,     1,        50,       69,     10,     1,         1000,   50, '소 1등급 교배뽑기', '내용', '1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10;11:11;12:12;13:13;14:14;15:15;16:101;17:102;18:103;19:104;20:105', '', '', '', '', '', '', ''
 exec spu_FVFarmD 30, 22, -1,    10,        50,       69,     10,     1,         1000,  100, '소 2등급 교배뽑기', '내용', '1:2;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10;11:11;12:12;13:13;14:14;15:15;16:101;17:102;18:103;19:104;20:105', '', '', '', '', '', '', ''
 exec spu_FVFarmD 30, 22, -1,    20,        50,       69,     10,     1,         1000,  150, '소 3등급 교배뽑기', '내용', '1:3;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10;11:11;12:12;13:13;14:14;15:15;16:101;17:102;18:103;19:104;20:105', '', '', '', '', '', '', ''
 exec spu_FVFarmD 30, 22, -1,    30,        50,       69,     10,     1,         1000,  200, '소 4등급 교배뽑기', '내용', '1:4;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10;11:11;12:12;13:13;14:14;15:15;16:101;17:102;18:103;19:104;20:105', '', '', '', '', '', '', ''
 exec spu_FVFarmD 30, 22, -1,    40,        50,       69,     10,     1,         1000,  200, '소 5등급 교배뽑기', '내용', '1:5;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10;11:11;12:12;13:13;14:14;15:15;16:101;17:102;18:103;19:104;20:105', '', '', '', '', '', '', ''
--select * from dbo.tFVUserMaster where gameid = 'xxxx2'
declare @famelv int
set @famelv = 1
while @famelv <= 50
	begin
		select top 1 famelvmin, @famelv famelv, famelvmax, * from dbo.tFVSystemRoulette where famelvmin <= @famelv and @famelv <= famelvmax and packstate = 1
		order by newid()
		set @famelv = @famelv + 1
	end
*/



/*
 exec spu_FVFarmD 30, 12, -1,     1,        50,       69,     10,     1,          -1,  -1, '소 1등급 패키지', '내용', '1:1;2:2;3:3;4:904;5:1200;', '', '', '', '', '', '', ''
 exec spu_FVFarmD 30, 12, -1,    10,        50,       69,     10,     1,          -1,  -1, '소 2등급 패키지', '내용', '1:2;2:2;3:3;4:904;5:1200;', '', '', '', '', '', '', ''
 exec spu_FVFarmD 30, 12, -1,    20,        50,       69,     10,     1,          -1,  -1, '소 3등급 패키지', '내용', '1:3;2:2;3:3;4:904;5:1200;', '', '', '', '', '', '', ''
 exec spu_FVFarmD 30, 12, -1,    30,        50,       69,     10,     1,          -1,  -1, '소 4등급 패키지', '내용', '1:4;2:2;3:3;4:904;5:1200;', '', '', '', '', '', '', ''
 exec spu_FVFarmD 30, 12, -1,    40,        50,       69,     10,     1,          -1,  -1, '소 5등급 패키지', '내용', '1:5;2:2;3:3;4:904;5:1200;', '', '', '', '', '', '', ''
--select * from dbo.tFVUserMaster where gameid = 'xxxx2'
declare @famelv int
set @famelv = 1
while @famelv <= 50
	begin
		select top 1 famelvmin, @famelv famelv, famelvmax, * from dbo.tFVSystemPack where famelvmin <= @famelv and @famelv <= famelvmax and packstate = 1
		order by newid()
		set @famelv = @famelv + 1
	end
*/

/*
exec spu_FVFarmD 30, 12, -1,  1, 50, 69, 10, -1, -1, -1, '소A등급 패키지','내용', '1:1;2:2;3:3;4:904;5:1200;6:-1;7:-1;8:-1;9:-1;10:-1;11:-1;12:-1;13:-1;14:-1;15:-1;16:-1;17:-1;18:-1;19:-1;20:-1', '', '', '', '', '', '', ''
exec spu_FVFarmD 30, 11, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''								-- 패키지상품(아이템리스트, 템리스트).


exec spu_FVFarmD 30, 13,  1,  1, 50, 69, 10, -1, -1, -1, '소A등급 패키지','내용', '1:1;2:2;3:3;4:904;5:1201;', '', '', '', '', '', '', ''
exec spu_FVFarmD 30, 11, -1, -1, -1, -1, -1, -1, -1, -1, '', '', '', '', '', '', '', '', '', ''								-- 패키지상품(아이템리스트, 템리스트).
*/

/*
declare @ps3_ varchar(1024)
declare @kind int, @value int

set @ps3_ = '1:1;2:2;3:3;4:904;5:1200;6:-1;7:-1;8:-1;9:-1;10:-1;11:-1;12:-1;13:-1;14:-1;15:-1;16:-1;17:-1;18:-1;19:-1;20:-1'


			-- 1. 커서 생성
			declare curTemp Cursor for
			select * FROM dbo.fnu_SplitTwo(';', ':', @ps3_)

			-- 2. 커서오픈
			open curTemp

			-- 3. 커서 사용
			Fetch next from curTemp into @kind, @value
			while @@Fetch_status = 0
				Begin
					select 'DEBUG ', @kind kind, @value value
					Fetch next from curTemp into @kind, @value
				end

			-- 4. 커서닫기
			close curTemp
			Deallocate curTemp
*/


/*

declare @itemcode int
set @itemcode = 50000
select @itemcode = max(itemcode) + 1 from dbo.tFVItemInfo where subcategory = 500
select @itemcode
*/
/*
--select * from dbo.tFVUserMaster where gameid = 'xxxx2'

declare @famelv int
declare @loop  int
set @loop = 1
while @loop <= 10
	begin
		set @famelv = 1
		select top 1 famelvmin, @famelv famelv, famelvmax, * from dbo.tFVSystemPack where famelvmin <= @famelv and @famelv < famelvmax and packstate = 1
		order by newid()

		set @famelv = 5
		select top 1 famelvmin, @famelv famelv, famelvmax, * from dbo.tFVSystemPack where famelvmin <= @famelv and @famelv < famelvmax and packstate = 1
		order by newid()

		set @famelv = 10
		select top 1 famelvmin, @famelv famelv, famelvmax, * from dbo.tFVSystemPack where famelvmin <= @famelv and @famelv < famelvmax  and packstate = 1
		order by newid()

		set @famelv = 15
		select top 1 famelvmin, @famelv famelv, famelvmax, * from dbo.tFVSystemPack where famelvmin <= @famelv and @famelv < famelvmax  and packstate = 1
		order by newid()

		set @loop = @loop + 1
	end
*/


/*
---------------------------------------------
-- 패키지 정보.
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSystemPack', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSystemPack;
GO

create table dbo.tFVSystemPack(
	idx					int 				IDENTITY(1, 1),

	famelvmin			int					default(1),		-- 최소렙.
	famelvmax			int					default(50),	-- 최대렙.
	packname			varchar(256)		default(''),

	-- 패키지정보.
	pack1				int					default(-1),
	pack2				int					default(-1),
	pack3				int					default(-1),
	pack4				int					default(-1),
	pack5				int					default(-1),

	packcashcostcost	int					default(100),	-- 패키지 원가.
	packsalepercent		int					default(10),	--        할인율.
	packcashcostsale	int					default(90),	--        할인가.

	packstate			int					default(-1),	-- 1:활성, -1:비활성.

	--코멘트.
	comment				varchar(256)		default(''),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSystemPack_idx	PRIMARY KEY(idx)
)

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVSystemPack_famelvmin_famelvmax')
	DROP INDEX tFVSystemPack.idx_tFVSystemPack_famelvmin_famelvmax
GO
CREATE INDEX idx_tFVSystemPack_famelvmin_famelvmax ON tSystemPack (famelvmin, famelvmax)
GO

-- insert into dbo.tFVSystemPack(famelvmin, famelvmax, packname, pack1, pack2, pack3, pack4, pack5, packcashcostcost, packsalepercent, packcashcostsale, comment, packstate) values(1, 10, '소 A등급 패키지', 1, 2, 3, 904, 1200, 69, 10, 62, '내용', -1)
-- update dbo.tFVSystemPack
--		set
--			famelvmin	= 1,
--			famelvmax	= 10,
--			packname	= '소 A등급 패키지',
--			pack1	= 1,
--			pack2	= 2,
--			pack3	= 3,
--			pack4	= 904,
--			pack5	= 1200,
--			packcashcostcost 	= 69,
--			packsalepercent		= 10,
--			packcashcostsale	= 62,
--			comment				= '내용',
--			packstate			= 1
--where idx = 1
-- select * from dbo.tFVSystemPack order by famelvmin asc, famelvmax asc
*/






/*
delete from dbo.tFVUserSaleLog where gameid = 'xxxx2'
delete from dbo.tFVGiftList where gameid = 'xxxx2'
update dbo.tFVUserMaster
	set
		gameyear = 2013,	gamemonth = 3,		frametime = 0,
		fame = 5,			famelv = 2,			tradecnt = 1,			prizecnt = 1,
		gamecost = 1000,	cashcost = 1000,	feed = 1000,			heart = 1000
where gameid = 'xxxx2'
exec spu_FVGameTrade 'xxxx2', '049000s1i0n7t8445289', '0:2013;  1:4;      2:0;      4:2;       10:10;       11:100;     12:20;     13:200;   30:16;',
													'1:5,1,1;3:5,23,0;4:5,25,-1;',
													'14:1;15:1;16:1;',
													'0:5; 1:2;   10:2;    11:1;    12:75;    20:20;    30:1;      31:10;    32:1;         33:10;     34:20;    35:110;  40:-1;',
													-1										-- 필드없음.



delete from dbo.tFVUserSaleLog where gameid = 'xxxx2'
delete from dbo.tFVGiftList where gameid = 'xxxx2'
update dbo.tFVUserMaster
	set
		housestep = 0,		housestate = 1, 	housetime = getdate(),
		bottlestep = 0,		bottlestate = 1, 	bottletime = getdate(),
		tankstep = 0, 		tankstate = 1, 		tanktime = getdate(),
		gameyear = 2013,	gamemonth = 3,		frametime = 0,
		fame = 5,			famelv = 2,			tradecnt = 1,			prizecnt = 1,
		gamecost = 1000,	cashcost = 1000,	feed = 1000,			heart = 1000
where gameid = 'xxxx2'
exec spu_FVGameTrade 'xxxx2', '049000s1i0n7t8445289', '0:2013;  1:4;      2:0;      4:2;       10:31;       11:100;     12:560;     13:200;   30:16;',
													'1:5,1,1;3:5,23,0;4:5,25,-1;',
													'14:1;15:1;16:1;',
													'0:5; 1:2;   10:2;    11:1;    12:75;    20:22;    30:1;      31:10;    32:1;         33:10;     34:20;    35:110;  40:-1;',
													-1										-- 필드없음.
*/









/*
			----------------------------------------------
			-- 동물정보.
			----------------------------------------------
			if(LEN(@aniitem_) >= 7)
				begin
				----------------------------------------------
				-- 내부번호를 보고 필드번호세팅
				----------------------------------------------
				-- 1. 커서 생성
				declare curAniItem Cursor for
				select * FROM dbo.fnu_SplitTwoStr(';', ':', @aniitem_)

				-- 2. 커서오픈
				open curAniItem

				-- 3. 커서 사용
				Fetch next from curAniItem into @listidx2, @data2
				while @@Fetch_status = 0
					Begin
						select 'DEBUG 동물정보', @listidx2 listidx2, @data2 data2

						-- 창고, 필드 	> 갱신
						-- 병원			> 패스
						--update dbo.tFVUserItem
						--	set
						--		anistep 		= @anistep2,
						--		manger			= @manger2,
						--		diseasestate	= @diseasestate2
						--from dbo.tFVUserItem
						--where gameid = @gameid_ and listidx = @listidx2 and invenkind = @USERITEM_INVENKIND_ANI and fieldidx != @USERITEM_FIELDIDX_HOSPITAL

						Fetch next from curAniItem into @listidx2, @data2
					end

				-- 4. 커서닫기
				close curAniItem
				Deallocate curAniItem
			end
*/

/*
-- 동물.
--SELECT * FROM dbo.fnu_SplitTwoStr(';', ':', '4:5,25,0;1:5,24,1;3:5,23,0;')
-- 1. 커서 생성
declare @aniitem_		varchar(2048)
declare @listidx2		int,
		@data2			varchar(40)

set @aniitem_	= '4:5,25,0;1:5,24,1;3:5,23,0;'

declare curAniItem Cursor for
select listidx, data FROM dbo.fnu_SplitTwoStr(';', ':', @aniitem_)

-- 2. 커서오픈
open curAniItem

-- 3. 커서 사용
Fetch next from curAniItem into @listidx2, @data2
while @@Fetch_status = 0
	Begin
		select @listidx2, @data2
		Fetch next from curAniItem into @listidx2, @data2
	end

-- 4. 커서닫기
close curAniItem
Deallocate curAniItem
*/



/*
-- 소모템

				----------------------------------------------
				-- 최소 한쌍이상일 경우만 작동되도록 한다.[1:2]
				-- 내부번호를 보고 보유정보 읽어오기.
				----------------------------------------------
				-- 1. 커서 생성
				declare curCusItem Cursor for
				-- fieldidx	-> @listidx2
				-- listidx	-> @usecnt2
				select * FROM dbo.fnu_SplitTwo(';', ':', @listset_)

				-- 2. 커서오픈
				open curCusItem

				-- 3. 커서 사용
				Fetch next from curCusItem into @listidx2, @usecnt2
				while @@Fetch_status = 0
					Begin
						--select 'DEBUG ', @listidx2 listidx2, @usecnt2 usecnt2

						----------------------------------------------
						-- 음수대역은 양수로 바꾼다.(조작자방지)
						----------------------------------------------
						set @usecnt2 = case when @usecnt2 < 0 then (-@usecnt2) else @usecnt2 end

						if(@usecnt2 > 0)
							begin
								----------------------------------------------
								-- 음수로 내려가는 것은 그대로 두자 (차후에 분석용으로 허용해둔다.)
								-- update >     find > @updatecnt	= @updatecnt + 1
								-- update > not find >
								-- 이방법을 응용한다.
								----------------------------------------------
								update dbo.tFVUserItem
									set
										cnt 		= case when ((cnt - @usecnt2) < 0) then 0 else (cnt - @usecnt2) end
								from dbo.tFVUserItem
								where gameid = @gameid_ and listidx = @listidx2 and invenkind = @USERITEM_INVENKIND_CONSUME
							end

						Fetch next from curCusItem into @listidx2, @usecnt2
					end

				-- 4. 커서닫기
				close curCusItem
				Deallocate curCusItem
*/




/*
---------------------------------------------
--		거래정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserSaleLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserSaleLog;
GO

create table dbo.tFVUserSaleLog(
	--(일반정보)
	idx			int 					IDENTITY(1, 1),

	gameid		varchar(20),
	gameyear	int						default(-1),
	gamemonth	int						default(-1),

	feeduse		int						default(-1),
	playcoin	int						default(-1),
	playcoinmax	int						default(-1),
	fame		int						default(-1),
	famelv		int						default(-1),
	tradecnt	int						default(-1),
	prizecnt	int						default(-1),

	saletrader		int					default(-1),
	saledanga		int					default(-1),
	saleplusdanga	int					default(-1),
	salebarrel		int					default(-1),
	salefresh		int					default(-1),
	salecost		int					default(-1),
	saleitemcode	int					default(-1),

	writedate		datetime			default(getdate()),

	-- Constraint
	CONSTRAINT pk_tUserSaleLog_idx	PRIMARY KEY(idx)
)
GO

-- 인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserSaleLog_gameid_gameyear_gamemonth')
    DROP INDEX tFVUserSaleLog.idx_tFVUserSaleLog_gameid_gameyear_gamemonth
GO
CREATE INDEX idx_tFVUserSaleLog_gameid_gameyear_gamemonth ON tUserSaleLog (gameid, gameyear, gamemonth)
GO
--select top 1 * from dbo.tFVUserSaleLog where gameid = 'xxxx' and gameyear = '2013' and gamemonth = '4'
--insert into dbo.tFVUserSaleLog(gameid, 		gameyear,   	gamemonth,
--							feeduse, 		playcoin,		playcoinmax,		fame,    		famelv,   		tradecnt,  		prizecnt,
--							saletrader, 	saledanga,		saleplusdanga,		salebarrel,		salefresh,		salecost,	saleitemcode)
--values(						'xxxx', 		2013, 			4,
--							1, 				2,				40,					0, 				1, 				1, 				0,
--							1, 				2, 				3, 					4, 				5, 				6, 				7)

select top 20 * from dbo.tFVUserSaleLog
where gameid = 'xxxx2'
order by idx desc

*/

/*
-- 1. 커서 생성
declare @SAVE_TRADEINFO_FAME				int					set @SAVE_TRADEINFO_FAME					= 0
declare @SAVE_TRADEINFO_FAMELV				int					set @SAVE_TRADEINFO_FAMELV					= 1
declare @SAVE_TRADEINFO_TRADECNT			int					set @SAVE_TRADEINFO_TRADECNT				= 10
declare @SAVE_TRADEINFO_PRIZECNT			int					set @SAVE_TRADEINFO_PRIZECNT				= 11
declare @SAVE_TRADEINFO_PLAYCOIN			int					set @SAVE_TRADEINFO_PLAYCOIN				= 20
declare @SAVE_TRADEINFO_SALETRADER			int					set @SAVE_TRADEINFO_SALETRADER				= 30
declare @SAVE_TRADEINFO_SALEDANGA			int					set @SAVE_TRADEINFO_SALEDANGA				= 31
declare @SAVE_TRADEINFO_SALEPLUSDANGA		int					set @SAVE_TRADEINFO_SALEPLUSDANGA			= 32
declare @SAVE_TRADEINFO_SALEBARREL			int					set @SAVE_TRADEINFO_SALEBARREL				= 33
declare @SAVE_TRADEINFO_SALEFRESH			int					set @SAVE_TRADEINFO_SALEFRESH				= 34
declare @SAVE_TRADEINFO_SALECOST			int					set @SAVE_TRADEINFO_SALECOST				= 35
declare @SAVE_TRADEINFO_SALEITEMCODE		int					set @SAVE_TRADEINFO_SALEITEMCODE			= 40

declare @kind		int,
		@info		int,
			@fame				int,		@fame2				int,
			@famelv				int,		@famelv2			int,
			@tradecnt			int,		@tradecnt2			int,
			@prizecnt			int,		@prizecnt2			int

	declare @anistep			int,
			@manger				int,
			@diseasestate		int

	declare @usecnt				int

	declare @saletrader			int,		@saletrader2		int,
			@saledanga			int,		@saledanga2			int,
			@saleplusdanga		int,		@saleplusdanga2		int,
			@salebarrel			int,		@salebarrel2		int,
			@salefresh			int,		@salefresh2			int,
			@salecost			int,		@salecost2			int,
			@saleitemcode		int,		@saleitemcode2		int
	declare @gamecost			int,		@playcoin2			int,	@playcoinmax		int,
			@feed				int,		@feeduse2			int

declare @tradeinfo_	varchar(512)
set @tradeinfo_ = '0:10;1:20;  10:3;    11:4;    20:5;    30:6;      31:7;     32:8;         33:10;     34:20;    35:60;   40:-1;'
	------------------------------------------------
	-- 입력정보(tradeinfo).
	--	tradeinfo=fame:famelv:tradecnt:prizecnt:playcoin:saletrader:saledanga:saleplusdanga:salebarrel:salefresh:salecost:saleitemcode
	--			  0:10;1:20;  10:0;    11:0;    20:1;    30:1;      31:5;     32:1;         33:10;     34:20;    35:60;   40:-1;
	-- SELECT * FROM dbo.fnu_SplitTwo(';', ':', '0:10;1:20;  10:0;    11:0;    20:1;    30:1;      31:5;     32:1;         33:10;     34:20;    35:60;   40:-1;')
	------------------------------------------------
	-- 1. 커서 생성
	declare curTradeInfo Cursor for
	select fieldidx, listidx FROM dbo.fnu_SplitTwo(';', ':', @tradeinfo_)

	-- 2. 커서오픈
	open curTradeInfo

	-- 3. 커서 사용
	Fetch next from curTradeInfo into @kind, @info
	while @@Fetch_status = 0
		Begin
			select @kind, @info
			if(@kind = @SAVE_TRADEINFO_FAME)
				begin
					set @fame2 		= @info
				end
			else if(@kind = @SAVE_TRADEINFO_FAMELV)
				begin
					set @famelv2 	= @info
				end
			else if(@kind = @SAVE_TRADEINFO_TRADECNT)
				begin
					set @tradecnt2 	= @info
				end
			else if(@kind = @SAVE_TRADEINFO_PRIZECNT)
				begin
					set @prizecnt2 	= @info
				end
			else if(@kind = @SAVE_TRADEINFO_PLAYCOIN)
				begin
					set @playcoin2 	= @info
				end
			else if(@kind = @SAVE_TRADEINFO_SALETRADER)
				begin
					set @saletrader2 	= @info
				end
			else if(@kind = @SAVE_TRADEINFO_SALEDANGA)
				begin
					set @saledanga2 	= @info
				end
			else if(@kind = @SAVE_TRADEINFO_SALEPLUSDANGA)
				begin
					set @saleplusdanga2 	= @info
				end
			else if(@kind = @SAVE_TRADEINFO_SALEBARREL)
				begin
					set @salebarrel2 	= @info
				end
			else if(@kind = @SAVE_TRADEINFO_SALEFRESH)
				begin
					set @salefresh2 	= @info
				end
			else if(@kind = @SAVE_TRADEINFO_SALECOST)
				begin
					set @salecost2 	= @info
				end
			else if(@kind = @SAVE_TRADEINFO_SALEITEMCODE)
				begin
					set @saleitemcode2 	= @info
				end
			Fetch next from curTradeInfo into @kind, @info
		end
	-- 4. 커서닫기
	close curTradeInfo
	Deallocate curTradeInfo
	select 'DEBUG 입력정보(tradeinfo)', @fame2 fame2, @famelv2 famelv2, @tradecnt2 tradecnt2, @prizecnt2 prizecnt2, @playcoin2 playcoin2, @saletrader2 saletrader2, @saledanga2 saledanga2, @saleplusdanga2 saleplusdanga2, @salebarrel2 salebarrel2, @salefresh2 salefresh2, @salecost2 salecost2, @saleitemcode2 saleitemcode2
*/




/*
-- 1. 커서 생성
declare @kind		int,
		@info		int

declare curUserInfo Cursor for
select fieldidx, listidx FROM dbo.fnu_SplitTwo(';', ':', '0:2013;1:3;2:0;4:1;10:10;11:100;12:10;13:100;30:0;')

-- 2. 커서오픈
open curUserInfo

-- 3. 커서 사용
Fetch next from curUserInfo into @kind, @info
while @@Fetch_status = 0
	Begin
		select @kind, @info
		--if(@kind = )
		--	begin
		--	end
		Fetch next from curUserInfo into @kind, @info
	end

-- 4. 커서닫기
close curUserInfo
Deallocate curUserInfo

*/



/*
declare @feed int, @feedused2 int
set @feed = 100
set @feedused2 = -10
set @feed = @feed - case when (@feedused2 < 0) then (-@feedused2) else @feedused2 end
select @feed, @feedused2
*/

/*
SELECT * FROM dbo.fnu_SplitTwo(';', ':', '0:2013;1:3;2:0;4:1;10:10;11:100;12:10;13:100;20:-1;21:-1;22:-1;23:-1;30:0;')
SELECT * FROM dbo.fnu_SplitTwoStr(';', ':', '4:5,25,0;1:5,25,0;3:5,25,0;')
	SELECT * FROM dbo.fnu_SplitOne(',', '5,25,0')
	SELECT * FROM dbo.fnu_SplitOne(',', '5,25,0')
	SELECT * FROM dbo.fnu_SplitOne(',', '5,25,0')
SELECT * FROM dbo.fnu_SplitTwo(';', ':', '14:1;15:1;')
SELECT * FROM dbo.fnu_SplitTwo(';', ':', '0:10;1:20;  10:0;    11:0;    20:1;    30:1;   31:5;     32:1;         33:10;     34:20;    35:60;   40:-1;')
*/

/*
-- 아이템 가격 단가표 구매 -> 판매
select (gamecost/buyamount), sellcost, * from dbo.tFVItemInfo
where subcategory < 50 and gamecost > 0 and (gamecost/buyamount) < sellcost
*/


/*
	declare @discount		int				set @discount		= 10
	declare @gamecostsell	int				set @gamecostsell 	= 10
	declare @cashcostsell	int				set @cashcostsell 	= 5
	declare @dummy	 		int

	if(@discount > 0 and @discount <= 100)
		begin
			select 'DEBUG 할인율적용(전)', @discount discount, @gamecostsell gamecostsell, @cashcostsell cashcostsell

			set @gamecostsell = @gamecostsell - (@gamecostsell * @discount)/100
			set @cashcostsell = @cashcostsell - (@cashcostsell * @discount)/100

			select 'DEBUG 할인율적용(후)', @discount discount, @gamecostsell gamecostsell, @cashcostsell cashcostsell
		end
*/


/*
-- 도감정보입력
declare @gameid 		varchar(60)

declare curTemp Cursor for
select gameid from dbo.tFVUserMaster

-- 2. 커서오픈
open curTemp

-- 3. 커서 사용
Fetch next from curTemp into @gameid
while @@Fetch_status = 0
	Begin
		exec spu_FVDogamListLog @gameid, 1
		exec spu_FVDogamListLog @gameid, 2
		exec spu_FVDogamListLog @gameid, 3
		Fetch next from curTemp into @gameid
	end

-- 4. 커서닫기
close curTemp
Deallocate curTemp

*/



/*
-- update dbo.tFVUserMaster set anireplistidx =  0 where gameid = 'xxxx3'
-- update dbo.tFVUserMaster set anireplistidx = -1 where gameid = 'xxxx3'
-- update dbo.tFVUserMaster set anireplistidx =  0 where gameid = 'xxxx4'
-- update dbo.tFVUserMaster set anireplistidx = -1 where gameid = 'xxxx4'
-- update dbo.tFVUserMaster set anireplistidx =  0 where gameid = 'xxxx5'
-- update dbo.tFVUserMaster set anireplistidx = -1 where gameid = 'xxxx5'
declare @gameid_ varchar(60) set @gameid_ = 'xxxx'

			-- 카피 & 사라지면 대처동물로.(없으면 기초동물로 교체)
			select m.gameid friendid, isnull(itemcode, 1) itemcode, isnull(acc1, -1) acc1, isnull(acc2, -1) acc2 from
				(select gameid, anireplistidx from dbo.tFVUserMaster where gameid in (select friendid from dbo.tFVUserFriend where gameid = @gameid_)) as m
			left join
				(select gameid, listidx, itemcode, acc1, acc2 from dbo.tFVUserItem where gameid in (select friendid from dbo.tFVUserFriend where gameid = @gameid_)) as i
			on
				m.gameid = i.gameid and m.anireplistidx = i.listidx
			order by itemcode desc

			-- 전체 구체(빵구가 난다.)
			select m.gameid friendid, itemcode, acc1, acc2 from
				(select gameid, anireplistidx from dbo.tFVUserMaster where gameid in (select friendid from dbo.tFVUserFriend where gameid = @gameid_)) as m
			join
				(select gameid, listidx, itemcode, acc1, acc2 from dbo.tFVUserItem where gameid in (select friendid from dbo.tFVUserFriend where gameid = @gameid_)) as i
			on
				m.gameid = i.gameid and m.anireplistidx = i.listidx
			order by itemcode desc

*/

/*
declare @gameid_ 				varchar(20)
set @gameid_ = 'xxxx'
select * from dbo.tFVUserItem
where gameid = @gameid_ and invenkind in (1, 2, 4)
order by diedate desc, invenkind, fieldidx, itemcode

*/
/*
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserItemDel_gameid_listidx')
    DROP INDEX tFVUserItemDel.idx_tFVUserItemDel_gameid_listidx
GO
CREATE INDEX idx_tFVUserItemDel_gameid_listidx ON tUserItemDel (gameid, listidx)
GO
*/


/*
	OUTPUT
	DELETED.gameid, 	DELETED.listidx, 	DELETED.invenkind, 	DELETED.itemcode, 	DELETED.cnt,
	DELETED.farmnum, 	DELETED.fieldidx,	DELETED.anistep,	DELETED.manger,		DELETED.diseasestate,
	DELETED.acc1,		DELETED.acc2,
	DELETED.abilkind,	DELETED.abilval,	DELETED.abilkind2,	DELETED.abilval2,
	DELETED.abilkind3,	DELETED.abilval3,	DELETED.abilkind4,	DELETED.abilval4,	DELETED.abilkind5,	DELETED.abilval5,

	DELETED.randserial,	DELETED.writedate,	DELETED.gethow,
	DELETED.diedate,	DELETED.diemode
	into dbo.tFVUserItemDel(	gameid, 	listidx, 	invenkind, 	itemcode, 	cnt,
							farmnum, 	fieldidx,	anistep,	manger,		diseasestate,
							acc1,		acc2,
							abilkind,	abilval,	abilkind2,	abilval2,
							abilkind3,	abilval3,	abilkind4,	abilval4,	abilkind5,	abilval5,

							randserial,	writedate,	gethow,
							diedate,	diemode)

*/


/*

---------------------------------------------
--		아이템 보유정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserItemDel', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserItemDel;
GO

create table dbo.tFVUserItemDel(
	idx				int					IDENTITY(1,1),

	gameid			varchar(20),									--
	listidx			int,											-- 리스트인덱스(각개인별로 별개)

	invenkind		int					default(1),					--대분류(가축(1), 소모품(3), 액세서리(4))
	itemcode		int,
	cnt				int					default(1),					--보유량

	farmnum			int					default(-1),				-- 농장번호(-1:농장없음, 0~50:농장번호)
	fieldidx		int					default(-1),				-- 필드(-2:병원, -1:창고, 0~8:필드)
	anistep			int					default(5),					-- 현재단계(0 ~ 12단계)
	manger			int					default(25),				-- 여물통(건초:1 > 여물:20)
	diseasestate	int					default(0),					-- 질병상태(0:노질병, 질병 >=0 걸림)
	acc1			int					default(-1),				-- 악세(모자:아이템코드)
	acc2			int					default(-1),				-- 악세(등:아이템코드)
	abilkind		int					default(-1),				--능력치종류1~5 (90001:신선도, 90002:추가 생산 확률, 90003:피버 드랍 확률, 90004:질병 저항력, 90005;코인 드랍 확률)
	abilval			int					default(0),					--능력치값1~5
	abilkind2		int					default(-1),				--
	abilval2		int					default(0),					--
	abilkind3		int					default(-1),				--
	abilval3		int					default(0),					--
	abilkind4		int					default(-1),				--
	abilval4		int					default(0),					--
	abilkind5		int					default(-1),				--
	abilval5		int					default(0),					--

	randserial		int					default(-1),				--랜던씨리얼(클라이언트에서 만들어서옴)
	writedate		datetime			default(getdate()),			--구매일/획득일
	gethow			int					default(0),					--획득방식(0:구매, 1:경작, 2:교배/뽑기, 3:검색)

	diedate			datetime,
	diemode			int					default(-1),				-- -1:아님, 1:눌러,텨저, 2:늑대

	-- Constraint
	CONSTRAINT	pk_tUserItemDel_idx	PRIMARY KEY(idx)
)
*/


/*

-- 계급 랜덤
declare @gameid 		varchar(60)
declare @sysfriendid	varchar(60)		set @sysfriendid = 'farmgirl'

declare curTemp Cursor for
select gameid from dbo.tFVUserMaster where gameid not in (select gameid from dbo.tFVUserFriend)

-- 2. 커서오픈
open curTemp

-- 3. 커서 사용
Fetch next from curTemp into @gameid
while @@Fetch_status = 0
	Begin
		insert into dbo.tFVUserFriend(gameid, friendid) values(@gameid, @sysfriendid)
		Fetch next from curTemp into @gameid
	end

-- 4. 커서닫기
close curTemp
Deallocate curTemp

*/

/*
update dbo.tFVUserItem set anistep = 5
*/
/*
alter table dbo.tFVUserMaster add invenanimalstep		int				default(0)
 alter table dbo.tFVUserMaster add invencustomstep		int				default(0)
 alter table dbo.tFVUserMaster add invenaccstep			int				default(0)

update tUserMaster
	set
		invenanimalstep = 0,
		invencustomstep	= 0,
		invenaccstep = 0

*/

/*
-- 느린 랜덤검색
declare @gameid_								varchar(20) set @gameid_ = 'xxxx'
select top 10 * from dbo.tFVUserMaster where gameid != @gameid_
order by newid()
*/

/*
-- 빠른 랜덤 검색
declare @gameid_								varchar(20) set @gameid_ = 'xxxx'
declare @usermax		int
select @usermax = max(idx) from dbo.tFVUserMaster

select * from dbo.tFVUserMaster
where gameid != @gameid_ and
idx in (Convert(int, ceiling(RAND() * @usermax - 0)),
		Convert(int, ceiling(RAND() * @usermax - 1)),
		Convert(int, ceiling(RAND() * @usermax - 2)),
		Convert(int, ceiling(RAND() * @usermax - 3)),
		Convert(int, ceiling(RAND() * @usermax - 4)),
		Convert(int, ceiling(RAND() * @usermax - 5)),
		Convert(int, ceiling(RAND() * @usermax - 6)),
		Convert(int, ceiling(RAND() * @usermax - 7)),
		Convert(int, ceiling(RAND() * @usermax - 8)),
		Convert(int, ceiling(RAND() * @usermax - 9)))
*/

/*

select Convert(int, ceiling(RAND() * 90179)),
			Convert(int, ceiling(RAND() * 90179)),
			Convert(int, ceiling(RAND() * 90179)),
			Convert(int, ceiling(RAND() * 90179)),
			Convert(int, ceiling(RAND() * 90179)),
			Convert(int, ceiling(RAND() * 90179)),
			Convert(int, ceiling(RAND() * 90179)),
			Convert(int, ceiling(RAND() * 90179)),
			Convert(int, ceiling(RAND() * 90179)),
			Convert(int, ceiling(RAND() * 90179))

*/

/*
---------------------------------------------
--		튜토리얼 보상(기록된것은 보상 받은것)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVComReward', N'U') IS NOT NULL
	DROP TABLE dbo.tFVComReward;
GO

create table dbo.tFVComReward(
	idx				int				IDENTITY(1,1),

	gameid			varchar(20),
	itemcode		int,
	getdate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT pk_tComReward_idx	PRIMARY KEY(idx)
)

-- gameid, itemcode
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVComReward_gameid_itemcode')
	DROP INDEX tFVComReward.idx_tFVComReward_gameid_itemcode
GO
CREATE INDEX idx_tFVComReward_gameid_itemcode ON tComReward (gameid, itemcode)
GO

--if(not exists(select top 1 * from dbo.tFVComReward where gameid = 'xxxx' and itemcode = 1))
--	begin
--		insert into dbo.tFVComReward(gameid, itemcode) values('xxxx', 1)
--	end
--select * from dbo.tFVComReward where gameid = 'xxxx' order by itemcode asc

*/




/*
---------------------------------------------
--		도감 : 보상정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVDogamReward', N'U') IS NOT NULL
	DROP TABLE dbo.tFVDogamReward;
GO

create table dbo.tFVDogamReward(
	idx				int				IDENTITY(1,1),

	gameid			varchar(20),
	dogamidx		int,
	getdate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT pk_tDogamReward_idx	PRIMARY KEY(idx)
)

-- gameid, dogamidx
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVDogamReward_gameid_dogamidx')
	DROP INDEX tFVDogamReward.idx_tFVDogamReward_gameid_dogamidx
GO
CREATE INDEX idx_tFVDogamReward_gameid_dogamidx ON tDogamReward (gameid, dogamidx)
GO

--if(not exists(select top 1 * from dbo.tFVDogamReward where gameid = 'xxxx' and dogamidx = 1))
--	begin
--		insert into dbo.tFVDogamReward(gameid, dogamidx) values('xxxx', 1)
--	end
--select * from dbo.tFVDogamReward where gameid = 'xxxx' order by dogamidx asc



-- 아이템 대분류
declare @ITEM_MAINCATEGORY_DOGAM			int					set @ITEM_MAINCATEGORY_DOGAM 				= 818 	--도감(818)

select *  from dbo.tFVItemInfo where subcategory = @ITEM_MAINCATEGORY_DOGAM
select param1 dogamidx, itemname dogamname, param2 dogam01, param3 dogam02, param4 dogam03, param5 dogam04, param6 dogam05, param7 dogam06, param8 rewarditemcode, param9 cnt  from dbo.tFVItemInfo where subcategory = @ITEM_MAINCATEGORY_DOGAM
*/

/*
select * from dbo.tFVUserItem where gameid = 'xxxx'

select * from dbo.tFVUserSeed where gameid = 'xxxx' order by fieldidx asc

update dbo.tFVUserSeed set seedstartdate = getdate() where seedstartdate is null
update dbo.tFVUserSeed set seedenddate = getdate() where seedenddate is null

select a.*, b.itemname, b.param1, b.param2, b.param5, b.param6
						from dbo.tFVUserSeed a
						LEFT JOIN
						(select * from dbo.tFVItemInfo where subcategory = 7) b
						ON a.itemcode = b.itemcode
					where gameid = @gameid order by seedidx asc



*/


/*
---------------------------------------------
--		개인도감
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVDogamList', N'U') IS NOT NULL
	DROP TABLE dbo.tFVDogamList;
GO

create table dbo.tFVDogamList(
	idx				int				IDENTITY(1,1),

	gameid			varchar(20),
	itemcode		int,
	getdate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT pk_tDogamList_idx	PRIMARY KEY(idx)
)

-- gameid, itemcode
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVDogamList_gameid_itemcode')
	DROP INDEX tFVDogamList.idx_tFVDogamList_gameid_itemcode
GO
CREATE INDEX idx_tFVDogamList_gameid_itemcode ON tDogamList (gameid, itemcode)
GO

--if(not exists(select top 1 * from dbo.tFVDogamList where gameid = 'xxxx' and itemcode = 1))
--	begin
--		insert into dbo.tFVDogamList(gameid, itemcode) values('xxxx', 1)
--	end
--select * from dbo.tFVDogamList where gameid = 'xxxx' order by itemcode asc


*/



/*
select top 1 * from dbo.tFVSystemInfo order by idx desc
alter table dbo.tFVSystemInfo add plusheart			int					default(0)
alter table dbo.tFVSystemInfo add plusfeed			int					default(0)
update dbo.tFVSystemInfo set plusheart = 0, plusfeed = 0
*/

/*
-- 1단계
declare @gameid_ varchar(60) set @gameid_ = 'xxxx'
select friendid from dbo.tFVUserFriend where gameid = @gameid_

-- 2단계
declare @gameid_ varchar(60) set @gameid_ = 'xxxx'
select gameid, anireplistidx from dbo.tFVUserMaster where gameid in (select friendid from dbo.tFVUserFriend where gameid = @gameid_)
select gameid, listidx, itemcode, acc1, acc2 from dbo.tFVUserItem where gameid in (select friendid from dbo.tFVUserFriend where gameid = @gameid_)

-- 3단계
declare @gameid_ varchar(60) set @gameid_ = 'xxxx'
select m.gameid, itemcode, acc1, acc2 from
	(select gameid, anireplistidx from dbo.tFVUserMaster where gameid in (select friendid from dbo.tFVUserFriend where gameid = @gameid_)) as m
join
	(select gameid, listidx, itemcode, acc1, acc2 from dbo.tFVUserItem where gameid in (select friendid from dbo.tFVUserFriend where gameid = @gameid_)) as i
on
	m.gameid = i.gameid and m.anireplistidx = i.listidx
order by itemcode desc
*/

/*
--
select top 10 * from dbo.tFVUserItem where gameid = 'xxxx2' and listidx = 0
update dbo.tFVUserItem set itemcode = 10, acc1 = -1, acc2 = -1 where gameid = 'xxxx2' and listidx = 0
update dbo.tFVUserItem set itemcode = 11, acc1 = 1401, acc2 = -1 where gameid = 'xxxx3' and listidx = 0
update dbo.tFVUserItem set itemcode = 12, acc1 = -1, acc2 = 1423 where gameid = 'xxxx4' and listidx = 0
update dbo.tFVUserItem set itemcode = 13, acc1 = 1400, acc2 = 1424 where gameid = 'xxxx5' and listidx = 0
*/
/*


-- 계급 랜덤
declare @gameid 		varchar(60)

declare curTemp Cursor for
select gameid from dbo.tFVUserMaster

-- 2. 커서오픈
open curTemp

-- 3. 커서 사용
Fetch next from curTemp into @gameid
while @@Fetch_status = 0
	Begin
		insert into dbo.tFVUserFriend(gameid, friendid) values(@gameid, 'xxxx2')
		insert into dbo.tFVUserFriend(gameid, friendid) values(@gameid, 'xxxx3')
		insert into dbo.tFVUserFriend(gameid, friendid) values(@gameid, 'xxxx4')
		insert into dbo.tFVUserFriend(gameid, friendid) values(@gameid, 'xxxx5')

		Fetch next from curTemp into @gameid
	end

-- 4. 커서닫기
close curTemp
Deallocate curTemp

*/

/*
IF OBJECT_ID (N'dbo.tFVUserFriend', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserFriend;
GO

create table dbo.tFVUserFriend(
	idx				int				IDENTITY(1,1),
	gameid			varchar(20)		NOT NULL,

	friendid		varchar(20)		NOT NULL, 				-- 친구아이디
	familiar		int				default(1), 			-- 친밀도(교배+1)
	writedate		datetime		default(getdate()), 	-- 등록일

	-- Constraint
	CONSTRAINT pk_tUserFriend_gameid_friendid	PRIMARY KEY(gameid, friendid)
)

--암기 > 포인트
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserFriend_gameid_familiar')
    DROP INDEX tFVUserFriend.idx_tFVUserFriend_gameid_familiar
GO
CREATE INDEX idx_tFVUserFriend_gameid_familiar ON tUserFriend(gameid, familiar desc)
GO

-- xxxx > 친구들
insert into dbo.tFVUserFriend(gameid, friendid) values('xxxx', 'xxxx2')
insert into dbo.tFVUserFriend(gameid, friendid) values('xxxx', 'xxxx3')
insert into dbo.tFVUserFriend(gameid, friendid) values('xxxx', 'xxxx4')
insert into dbo.tFVUserFriend(gameid, friendid) values('xxxx', 'xxxx5')

*/

/*
exec spu_FVSubGiftSend 2,     1, 'SysLogin', 'xxxx6', ''				-- 젖소
exec spu_FVSubGiftSend 2,   100, 'SysLogin', 'xxxx6', ''				-- 양
exec spu_FVSubGiftSend 2,   200, 'SysLogin', 'xxxx6', ''				-- 산양
exec spu_FVSubGiftSend 2,   700, 'SysLogin', 'xxxx6', ''				-- 총알
exec spu_FVSubGiftSend 2,   800, 'SysLogin', 'xxxx6', ''				-- 치료제
exec spu_FVSubGiftSend 2,   900, 'SysLogin', 'xxxx6', ''				-- 건초
exec spu_FVSubGiftSend 2,  1000, 'SysLogin', 'xxxx6', ''				-- 일꾼
exec spu_FVSubGiftSend 2,  1100, 'SysLogin', 'xxxx6', ''				-- 촉진제
exec spu_FVSubGiftSend 2,  1200, 'SysLogin', 'xxxx6', ''				-- 부활석
exec spu_FVSubGiftSend 2,  1400, 'SysLogin', 'xxxx6', ''				-- 가축 악세사리
exec spu_FVSubGiftSend 2,  2000, 'SysLogin', 'xxxx6', ''				-- 하트
exec spu_FVSubGiftSend 2,  5000, 'SysLogin', 'xxxx6', ''				-- 캐쉬선물
exec spu_FVSubGiftSend 2,  5100, 'SysLogin', 'xxxx6', ''				-- 코인선물
exec spu_FVSubGiftSend 2,  5200, 'SysLogin', 'xxxx6', ''				-- 뽑기
exec spu_FVSubGiftSend 2,  5300, 'SysLogin', 'xxxx6', ''				-- 대회
exec spu_FVSubGiftSend 1,    -1, 'SysLogin', 'xxxx6', 'message'		-- 메세지.
exec spu_FVSubGiftSend 2,  2200, 'SysLogin', 'xxxx6', ''				-- 상인100프로만족
exec spu_FVSubGiftSend 2,  2100, 'SysLogin', 'xxxx6', ''				-- 긴급요청티켓


exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', 60, -1		-- 소
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', 61, -1		-- 양
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', 62, -1		-- 산양
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', 63, -1		-- 총알
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', 64, -1		-- 치료제
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', 65, -1		-- 건초
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', 66, -1		-- 일꾼
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', 67, -1		-- 촉진제
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', 68, -1		-- 부활석
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', 69, -1	-- 악세
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', 70, -1	-- 하트
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', 71, -1	-- 캐쉬
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', 72, -1	-- 코인
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', 73, -1	-- 일반교배티켓
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', 74, -1	-- 대회티켓B
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', 75, -1	-- 쪽지
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', 76, -1	-- 상인100프로만족
exec spu_FVGiftGain 'xxxx6', '049000s1i0n7t8445289', 77, -1	-- 긴급요청티켓
*/



/*
declare @gameid_ varchar(60) set @gameid_ = 'xxxx2'
select * from dbo.tFVUserItem
where gameid = @gameid_
order by invenkind, fieldidx, itemcode
*/


/*
alter table dbo.tFVUserMaster add feedmax		int						default(10)
update dbo.tFVUserMaster set feedmax = 10

35	2	5일보상	5007	2013-09-16 12:30	DailyReward
34	2	4일보상	5113	2013-09-16 12:30	DailyReward
33	2	3일보상	5112	2013-09-16 12:30	DailyReward
32	2	2일보상	5111	2013-09-16 12:29	DailyReward
31	2	1일보상	900	2013-09-16 12:29	DailyReward


exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', 31, -1
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', 32, -1
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', 33, -1
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', 34, -1
exec spu_FVGiftGain 'xxxx2', '049000s1i0n7t8445289', 35, -1

 declare @gameid_ varchar(60) set @gameid_ = 'xxxx2'
			select top 20 idx, giftkind, message, itemcode, convert(varchar(16), giftdate, 20) as giftdate, giftid
			from dbo.tFVGiftList
			where gameid = @gameid_ and giftkind in (1, 2)
			order by idx desc

delete from dbo.tFVGiftList where idx <= 30 or idx >= 36
*/

/*
declare @attenddate	datetime,
		@tmpcnt int,
		@attendcnt int
set @attenddate = '2013-09-11 18:30:03.307'

			set @tmpcnt = datediff(d, @attenddate, getdate())
			if(@tmpcnt < 1)
				begin
					select 'DEBUG (출석일 < 1일) 미반영'
					set @tmpcnt = 0
				end
			else if(@tmpcnt = 1)
				begin
					select 'DEBUG (출석일 = 1일) 출석일 갱신, 출석카운터 +=1'
					set @attenddate = getdate()
					set @attendcnt = @attendcnt + 1
					if(@attendcnt > 5)
						begin
							set @attendcnt = 5
						end
				end
			else
				begin
					select 'DEBUG 출석일 갱신, 출석카운터 = 1(초기화)'
					set @attenddate = getdate()
					set @attendcnt = 1
				end
*/

/*
IF OBJECT_ID (N'dbo.tFVSystemInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSystemInfo;
GO

create table dbo.tFVSystemInfo(
	idx					int 				IDENTITY(1, 1),

	-- 업글정보
	housestepmax		int					default(0),
	pumpstepmax			int					default(0),
	bottlestepmax		int					default(0),
	transferstepmax		int					default(0),
	tankstepmax			int					default(0),
	purestepmax			int					default(0),
	freshcoolstepmax	int					default(0),

	-- 인벤정보
	invenstepmax		int					default(0),
	invencountmax		int					default(0),
	seedfieldmax		int					default(0),

	-- 캐쉬구매, 환전.
	pluscashcost		int					default(0),
	plusgamecost		int					default(0),

	--코멘트.
	comment				varchar(256)		default(''),

	writedate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSystemInfo_idx	PRIMARY KEY(idx)
)



*/



/*
---------------------------------------------
-- 시스템 업그레이드 정보
-- 시설 업그레이드 맥스 정보
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVSystemInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tFVSystemInfo;
GO

create table dbo.tFVSystemInfo(
	idx					int 				IDENTITY(1, 1),

	-- 업글정보
	housestepmax		int					default(0),
	pumpstepmax			int					default(0),
	bottlestepmax		int					default(0),
	transferstepmax		int					default(0),
	tankstepmax			int					default(0),
	purestepmax			int					default(0),
	freshcoolstepmax	int					default(0),

	-- 인벤정보
	invenstepmax		int					default(0),
	invencountmax		int					default(0),
	seedfieldmax		int					default(0),

	writedate			datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tSystemInfo_idx	PRIMARY KEY(idx)
)
*/

/*
	-- 아이템
	declare @ITEM_SUBCATEGORY_COW				int					set @ITEM_SUBCATEGORY_COW 					= 1  -- 소		(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_GOAT				int					set @ITEM_SUBCATEGORY_GOAT 					= 2  -- 양		(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_SHEEP				int					set @ITEM_SUBCATEGORY_SHEEP 				= 3  -- 산양	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_SEED				int					set @ITEM_SUBCATEGORY_SEED 					= 7  -- 씨앗	(판매[X], 선물[X], 직접[O])
	declare @ITEM_SUBCATEGORY_BULLET			int					set @ITEM_SUBCATEGORY_BULLET 				= 8  -- 총알	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_VACCINE			int					set @ITEM_SUBCATEGORY_VACCINE 				= 9  -- 치료제	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_FEED				int					set @ITEM_SUBCATEGORY_FEED 					= 44 -- 건초	(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_ALBA				int					set @ITEM_SUBCATEGORY_ALBA 					= 11 -- 일꾼	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_BOOSTER			int					set @ITEM_SUBCATEGORY_BOOSTER 				= 12 -- 촉진제	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_REVIVAL			int					set @ITEM_SUBCATEGORY_REVIVAL 				= 13 -- 부활석	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_ACC				int					set @ITEM_SUBCATEGORY_ACC 					= 15 -- 악세	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_HEART				int					set @ITEM_SUBCATEGORY_HEART 				= 40 -- 하트	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_HELPER			int					set @ITEM_SUBCATEGORY_HELPER 				= 41 -- 긴급요청(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_TRADESAFE			int					set @ITEM_SUBCATEGORY_TRADESAFE				= 42 -- 상인만족(판매[X], 선물[O])
	declare @ITEM_SUBCATEGORY_CASHCOST			int					set @ITEM_SUBCATEGORY_CASHCOST 				= 50 -- 캐쉬	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_GAMECOST			int					set @ITEM_SUBCATEGORY_GAMECOST 				= 51 -- 코인	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_CONTEST			int					set @ITEM_SUBCATEGORY_CONTEST 				= 53 -- 대회	(판매[O], 선물[O])
	declare @ITEM_SUBCATEGORY_UPGRADE_HOUSE		int					set @ITEM_SUBCATEGORY_UPGRADE_HOUSE 		= 60 -- 집
	declare @ITEM_SUBCATEGORY_UPGRADE_TANK		int					set @ITEM_SUBCATEGORY_UPGRADE_TANK 			= 61 -- 탱크
	declare @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL	int					set @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL 	= 62 -- 저온보관
	declare @ITEM_SUBCATEGORY_UPGRADE_PURE		int					set @ITEM_SUBCATEGORY_UPGRADE_PURE 			= 63 -- 정화시설
	declare @ITEM_SUBCATEGORY_UPGRADE_BOTTLE	int					set @ITEM_SUBCATEGORY_UPGRADE_BOTTLE 		= 64 -- 양동이
	declare @ITEM_SUBCATEGORY_UPGRADE_PUMP		int					set @ITEM_SUBCATEGORY_UPGRADE_PUMP 			= 65 -- 착유기
	declare @ITEM_SUBCATEGORY_UPGRADE_TRANSFER	int					set @ITEM_SUBCATEGORY_UPGRADE_TRANSFER 		= 66 -- 주입기
	declare @ITEM_SUBCATEGORY_INVEN				int					set @ITEM_SUBCATEGORY_INVEN 				= 67 -- 인벤확장
	declare @ITEM_SUBCATEGORY_SEEDFIELD			int					set @ITEM_SUBCATEGORY_SEEDFIELD 			= 68 -- 경작지확장
	declare @ITEM_SUBCATEGORY_DOGAM				int					set @ITEM_SUBCATEGORY_DOGAM 				= 818 -- 도감
	declare @ITEM_SUBCATEGORY_SYSINFO			int					set @ITEM_SUBCATEGORY_SYSINFO 				= 500 -- 정보수집
	declare @idx				int

	declare @housestepmax		int,
			@tankstepmax		int,
			@freshcoolstepmax	int,
			@purestepmax		int,
			@bottlestepmax		int,
			@pumpstepmax		int,
			@transferstepmax	int,

			@invenstepmax		int,
			@invencountmax		int,
			@seedfieldmax		int


select * from dbo.tFVSystemInfo order by idx desc
-- 시스템 테이블의 데이타를 검사
set @idx = -1
select top 1 @idx = idx from dbo.tFVSystemInfo order by idx desc
select @idx
if(@idx = -1)
	begin
		--select 'insert'
		insert into dbo.tFVSystemInfo(writedate) values(getdate())
		select top 1 @idx = idx from dbo.tFVSystemInfo order by idx desc
	end
else
	begin
		--select 'update'
	end

-- 아이템 테이블에서 시스템 테이블로 데이타 이동
select @housestepmax	= max(param1) from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_UPGRADE_HOUSE
select @tankstepmax		= max(param1) from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_UPGRADE_TANK
select @freshcoolstepmax= max(param1) from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL
select @purestepmax		= max(param1) from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_UPGRADE_PURE
select @bottlestepmax	= max(param1) from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_UPGRADE_BOTTLE
select @pumpstepmax		= max(param1) from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_UPGRADE_PUMP
select @transferstepmax = max(param1) from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_UPGRADE_TRANSFER
select @invenstepmax	= max(param1), @invencountmax = max(param2) from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_INVEN
select @seedfieldmax	= max(param1) from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_SEEDFIELD

select @housestepmax, @tankstepmax, @freshcoolstepmax, @purestepmax, @bottlestepmax, @pumpstepmax, @transferstepmax, @invenstepmax, @invencountmax, @seedfieldmax, @idx

update dbo.tFVSystemInfo
	set
		housestepmax		= @housestepmax,
		tankstepmax			= @tankstepmax,
		freshcoolstepmax	= @freshcoolstepmax,
		purestepmax			= @purestepmax,
		bottlestepmax		= @bottlestepmax,
		pumpstepmax			= @pumpstepmax,
		transferstepmax		= @transferstepmax,
		invenstepmax		= @invenstepmax,
		invencountmax		= @invencountmax,
		seedfieldmax		= @seedfieldmax
where idx = @idx

select top 1 * from dbo.tFVSystemInfo order by idx desc

--select labelname, param1 from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_UPGRADE_HOUSE order by param1 desc
--select labelname, param1 from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_UPGRADE_TANK order by param1 desc
--select labelname, param1 from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_UPGRADE_FRESHCOOL order by param1 desc
--select labelname, param1 from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_UPGRADE_PURE order by param1 desc
--select labelname, param1 from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_UPGRADE_BOTTLE order by param1 desc
--select labelname, param1 from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_UPGRADE_PUMP order by param1 desc
--select labelname, param1 from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_UPGRADE_TRANSFER order by param1 desc
--select labelname, param1 from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_INVEN order by param1 desc
--select labelname, param1 from dbo.tFVItemInfo where subcategory = @ITEM_SUBCATEGORY_SEEDFIELD order by param1 desc

*/



/*
---------------------------------------------
--	로그인 현황, 플레이 현황
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVStaticTime', N'U') IS NOT NULL
	DROP TABLE dbo.tFVStaticTime;
GO

create table dbo.tFVStaticTime(
	idx					int 				IDENTITY(1, 1),

	dateid10			varchar(10),
	market				int					default(1),				-- (구매처코드) MARKET_SKT

	logincnt			int					default(0),
	playcnt				int					default(0),

	-- Constraint
	CONSTRAINT	pk_tStaticTime_dateid10_market	PRIMARY KEY(dateid10, market)
)


declare @dateid10 			varchar(10) 	set @dateid10 		= Convert(varchar(8), Getdate(),112) + Convert(varchar(2), Getdate(), 108)
declare @market_			int				set @market_		= 5

if(not exists(select top 1 * from dbo.tFVStaticTime where dateid10 = @dateid10 and market = @market_))
	begin
		insert into dbo.tFVStaticTime(dateid10, market, logincnt, playcnt) values(@dateid10, @market_, 1, 0)
	end
else
	begin
		update dbo.tFVStaticTime
			set
				logincnt = logincnt + 1
		where dateid10 = @dateid10 and market = @market_
	end


select * from dbo.tFVStaticTime order by dateid10 desc
*/
/*
insert into dbo.tFVUserSMSLog(gameid, sendkey, recphone) values('xxxx', 'xxxxxxxxxxx1', '01011112222')
-- select top 10 * from dbo.tFVUserSMSLog
-- select top 1  * from dbo.tFVUserSMSLog where sendkey = 'xxxxxxxxxxx1'
-- select top 10 * from dbo.tFVUserSMSLog where gameid = 'xxxx'

---------------------------------------------
-- 	SMS 로그 > 통계용
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserSMSLogTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserSMSLogTotal;
GO

create table dbo.tFVUserSMSLogTotal(
	idx				int				identity(1, 1),

	dateid			char(8),							-- 20101210
	cnt				int				default(1),
	cnt2			int				default(0),
	joincnt			int				default(0),

	-- Constraint
	CONSTRAINT	pk_tUserSMSLogTotal_dateid	PRIMARY KEY(dateid)
)
-- insert into dbo.tFVUserSMSLogTotal(dateid, cnt) values('20130910', 1)
-- update dbo.tFVUserSMSLogTotal
--	set
--		cnt = cnt + 1
-- where dateid = '20130910'
-- select top 100 * from dbo.tFVUserSMSLogTotal order by dateid desc
-- select top 100 * from dbo.tFVUserSMSLogTotal where dateid = '20130910' order by dateid desc

-- insert into dbo.tFVUserSMSReward(recphone, gameid) values('01011112222', 'xxxx')
-- select top 1  * from dbo.tFVUserSMSReward where recphone = '01011112222'
*/


/*
---------------------------------------------
-- 	룰렛 로그 > 개인자료
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVRouletteLogPerson', N'U') IS NOT NULL
	DROP TABLE dbo.tFVRouletteLogPerson;
GO

create table dbo.tFVRouletteLogPerson(
	idx				int				identity(1, 1),

	gameid			varchar(20),
	cashcost		int				default(0),
	gamecost		int				default(0),
	itemcode		int				default(-1),
	comment			varchar(128),

	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tRouletteLogPerson_idx PRIMARY KEY(idx)
)
-- gameid, idx
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVRouletteLogPerson_gameid_idx')
	DROP INDEX tFVRouletteLogPerson.idx_tFVRouletteLogPerson_gameid_idx
GO
CREATE INDEX idx_tFVRouletteLogPerson_gameid_idx ON tRouletteLogPerson (gameid, idx)
GO
-- insert into dbo.tFVRouletteLogPerson(gameid, cashcost, gamecost, itemcode, comment)  values('xxxx', 0, 400, 1, '코인 뽑기')
-- insert into dbo.tFVRouletteLogPerson(gameid, cashcost, gamecost, itemcode, comment)  values('xxxx', 2,   0, 2, '캐쉬 뽑기')
-- select top 100 * from dbo.tFVRouletteLogPerson
-- select top 100 * from dbo.tFVRouletteLogPerson where gameid = 'xxxx' order by idx desc
*/




/*
---------------------------------------------
--		친구
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserFriend', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserFriend;
GO

create table dbo.tFVUserFriend(
	idx				int				IDENTITY(1,1),
	gameid			varchar(20)		NOT NULL,
	friendid		varchar(20)		NOT NULL, 				-- 친구아이디
	writedate		datetime		default(getdate()), 	-- 등록일
	familiar		int				default(1), 			-- 친밀도(방문마다+1)

	-- Constraint
	CONSTRAINT pk_tUserFriend_gameid_friendid	PRIMARY KEY(gameid, friendid)
)

--암기 > 포인트
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserFriend_gameid_familiar')
    DROP INDEX tFVUserFriend.idx_tFVUserFriend_gameid_familiar
GO
CREATE INDEX idx_tFVUserFriend_gameid_familiar ON tUserFriend(gameid, familiar desc)
GO

-- xxxx > 친구들
--insert into dbo.tFVUserFriend(gameid, friendid) values('xxxx', 'DD10000')
--insert into dbo.tFVUserFriend(gameid, friendid) values('xxxx', 'DD10001')
--insert into dbo.tFVUserFriend(gameid, friendid) values('xxxx', 'DD10002')
--insert into dbo.tFVUserFriend(gameid, friendid) values('xxxx', 'DD10003')
--insert into dbo.tFVUserFriend(gameid, friendid) values('xxxx', 'DD10004')
--insert into dbo.tFVUserFriend(gameid, friendid) values('xxxx', 'DD10005')
--insert into dbo.tFVUserFriend(gameid, friendid) values('xxxx', 'DD10006')
--insert into dbo.tFVUserFriend(gameid, friendid) values('xxxx', 'DD10007')

--select * from dbo.tFVUserFriend where gameid = 'xxxx'
--select * from dbo.tFVUserFriend where gameid = 'xxxx' order by familiar desc
--update dbo.tFVUserFriend set familiar = familiar + 1 where gameid = @gameid_ and friendid = @friendid_
*/



/*
insert into dbo.tFVUserUnusualLog(gameid, comment) values('xxxx', '캐쉬카피시도')
insert into dbo.tFVUserBlockLog(gameid, comment) values('xxxx', '아이템를 1회 이상 카피를 해서 로그인시 시스템에서 블럭 처리했습니다.')

exec spu_FVFarmD 7, -1, -1, -1, -1, -1, -1, -1, -1, -1, 'xxxx', '', '', '', '', '', '', '', '', ''				-- 유저 검색
*/

/*
insert into dbo.tFVCashLog(gameid, acode, ucode, cashcost, cash) values('xxxx2', 'xxx', '12345778998765442bcde3123192915243184255', 10, 1000)
insert into dbo.tFVCashTotal(dateid, cashkind, market, cashcost, cash) values('20130910', 2000, 1, 21, 2000)
insert into dbo.tFVCashTotal(dateid, cashkind, market, cashcost, cash) values('20130910', 1000, 1, 10, 1000)
insert into dbo.tFVCashChangeLog(gameid, cashcost, gamecost) values('xxxx2', 10, 1000)
insert into dbo.tFVCashChangeLogTotal(dateid, cashcost, gamecost, changecnt) values('20130910', 10, 1000, 1)

select * from dbo.tFVCashLog where idx = 6 and gameid = 'xxxx2'
select * from dbo.tFVCashTotal where dateid = '20130910' and cashkind = 1000 and market = 1
*/



/*


---------------------------------------------
-- 	캐쉬환전토탈
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVCashChangeLogTotal', N'U') IS NOT NULL
	DROP TABLE dbo.tFVCashChangeLogTotal;
GO

create table dbo.tFVCashChangeLogTotal(
	idx				int				identity(1, 1),
	dateid			char(8),							-- 20101210

	cashcost		int				default(0),
	gamecost		int				default(0),

	changecnt		int				default(1),

	-- Constraint
	CONSTRAINT	pk_tCashChangeLogTotal_dateid	PRIMARY KEY(dateid)
)
-- select top 100 * from dbo.tFVCashChangeLogTotal order by dateid desc
-- select top 1 * from dbo.tFVCashChangeLogTotal where dateid = '20120818'
-- insert into dbo.tFVCashChangeLogTotal(dateid, cashcost, gamecost, changecnt) values('20130910', 10, 1000, 1)
--update dbo.tFVCashChangeLogTotal
--	set
--		cashcost = cashcost + 10,
--		gamecost = gamecost + 10000,
--		changecnt = changecnt + 1
--where dateid = '20120818'

-- 192.168.0.11 / game4farm / a1s2d3f4

*/

/*

exec spu_FVDayLogInfoStatic 1, 1, 1				-- 일 SMS 전송
 exec spu_FVDayLogInfoStatic 1, 2, 2				-- 일 SMS 가입

 exec spu_FVDayLogInfoStatic 1, 10, 1				-- 일 일반가입
 exec spu_FVDayLogInfoStatic 1, 13, 2               -- 일 게스트가입
 exec spu_FVDayLogInfoStatic 1, 11, 3               -- 일 유니크 가입

 exec spu_FVDayLogInfoStatic 1, 12, 3               -- 일 로그인

 exec spu_FVDayLogInfoStatic 1, 20, 1				-- 일 하트사용수
 exec spu_FVDayLogInfoStatic 1, 21, 2				-- 일 무료뽑기
 exec spu_FVDayLogInfoStatic 1, 22, 3				-- 일 유료뽑기

 exec spu_FVDayLogInfoStatic 1, 30, 1				-- 일 거래수
 exec spu_FVDayLogInfoStatic 1, 31, 2				-- 일 상지급수

 exec spu_FVDayLogInfoStatic 1, 40, 1				-- 일 대회참여수
*/

/*
alter table dbo.tFVUserItem add diedate			datetime
*/
/*
select a.*, b.itemname, b.param1, b.param2, b.param5, b.param6
	from dbo.tFVUserSeed a
	LEFT JOIN
	(select * from dbo.tFVItemInfo where subcategory = 7) b
	ON a.itemcode = b.itemcode
where gameid = 'xxxx' order by seedidx asc

-- 구매, 빈상태
update dbo.tFVUserSeed set itemcode = -1 where gameid = 'xxxx' and seedidx = 8
-- 심기
update dbo.tFVUserSeed set itemcode = 601, seedstartdate = getdate(), seedenddate = DATEADD(ss, 20, getdate()) where gameid = 'xxxx' and seedidx = 1
update dbo.tFVUserSeed set itemcode = 602, seedstartdate = getdate(), seedenddate = DATEADD(ss, 20, getdate()) where gameid = 'xxxx' and seedidx = 2
update dbo.tFVUserSeed set itemcode = 603, seedstartdate = getdate(), seedenddate = DATEADD(ss, 20, getdate()) where gameid = 'xxxx' and seedidx = 3
update dbo.tFVUserSeed set itemcode = 604, seedstartdate = getdate(), seedenddate = DATEADD(ss, 20, getdate()) where gameid = 'xxxx' and seedidx = 4
update dbo.tFVUserSeed set itemcode = 605, seedstartdate = getdate(), seedenddate = DATEADD(ss, 20, getdate()) where gameid = 'xxxx' and seedidx = 5
update dbo.tFVUserSeed set itemcode = 606, seedstartdate = getdate(), seedenddate = DATEADD(ss, 20, getdate()) where gameid = 'xxxx' and seedidx = 6
update dbo.tFVUserSeed set itemcode = 607, seedstartdate = getdate(), seedenddate = DATEADD(ss, 20, getdate()) where gameid = 'xxxx' and seedidx = 7

select getdate(), DATEADD(ss, 20, getdate())
*/

/*
--################################################################
-- 구매로그 기록(할인 될 수도 있어 직접 입력하는 형태로 한다. 30 -> 25)
-- exec spu_FVUserItemBuyLog 'xxxx', 1, 30, 0
-- exec spu_FVUserItemBuyLog 'xxxx', 3,  0, 3
--select top  20 * from dbo.tFVUserItemBuyLog where gameid = 'xxxx' order by idx desc
--select top 100 * from dbo.tFVUserItemBuyLogTotalMaster order by dateid8
--select top 100 * from dbo.tFVUserItemBuyLogTotalSub order by dateid8 desc, itemcode desc
--select top 100 * from dbo.tFVUserItemBuyLogMonth order by dateid6 desc, itemcode desc
--################################################################
IF OBJECT_ID ( 'dbo.spu_FVUserItemBuyLog', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.spu_FVUserItemBuyLog;
GO

create procedure dbo.spu_FVUserItemBuyLog
	@gameid_								varchar(20),		-- 게임아이디
	@itemcode_								int,
	@gamecost_								int,
	@cashcost_								int
	--WITH ENCRYPTION -- 프로시져를 암호화함.
as
	------------------------------------------------
	--	2-1. 내부사용 변수
	------------------------------------------------
	declare @dateid8 	varchar(8)		set @dateid8 			= Convert(varchar(8),Getdate(),112)
	declare @dateid6 	varchar(6)		set @dateid6 			= Convert(varchar(6),Getdate(),112)

Begin
	------------------------------------------------
	--	3-1. 초기화
	------------------------------------------------
	set nocount on
	--select 'DEBUG 구매', @gameid_ gameid_, @itemcode_ itemcode_, @gamecost_ gamecost_, @cashcost_ cashcost_

	------------------------------------------------
	--	3-2-1. 구매했던 로그(개인)
	------------------------------------------------
	--select 'DEBUG 구매했던 로그(개인)', @gameid_ gameid_, @itemcode_ itemcode_, @gamecost_ gamecost_, @cashcost_ cashcost_
	insert into dbo.tFVUserItemBuyLog(gameid, itemcode, gamecost, cashcost)
	values(@gameid_, @itemcode_, @gamecost_, @cashcost_)


	------------------------------------------------
	--	3-2-2. 구매했던 로그(월별 Master)
	------------------------------------------------
	--select 'DEBUG 구매했던 로그(월별 Master) ', @dateid8 dateid8, @gamecost_ gamecost_, @cashcost_ cashcost_
	if(not exists(select top 1 * from dbo.tFVUserItemBuyLogTotalMaster where dateid8 = @dateid8))
		begin
			--select 'DEBUG > insert'

			insert into dbo.tFVUserItemBuyLogTotalMaster(dateid8, gamecost, cashcost, cnt)
			values(@dateid8, @gamecost_, @cashcost_, 1)
		end
	else
		begin
			--select 'DEBUG > update'

			update dbo.tFVUserItemBuyLogTotalMaster
				set
					gamecost = gamecost + @gamecost_,
					cashcost = cashcost + @cashcost_,
					cnt = cnt + 1
			where dateid8 = @dateid8
		end


	------------------------------------------------
	--	3-2-3. 일별로그 > 세부기록
	------------------------------------------------
	--select 'DEBUG 일별로그 > 세부기록', @dateid8 dateid8, @itemcode_ itemcode_, @gamecost_ gamecost_, @cashcost_ cashcost_
	if(not exists(select top 1 * from dbo.tFVUserItemBuyLogTotalSub where dateid8 = @dateid8 and itemcode = @itemcode_))
		begin
			--select 'DEBUG > insert'

			insert into dbo.tFVUserItemBuyLogTotalSub(dateid8, itemcode, gamecost, cashcost, cnt)
			values(@dateid8, @itemcode_, @gamecost_, @cashcost_, 1)
		end
	else
		begin
			--select 'DEBUG > update'

			update dbo.tFVUserItemBuyLogTotalSub
				set
					gamecost = gamecost + @gamecost_,
					cashcost = cashcost + @cashcost_,
					cnt = cnt + 1
			where dateid8 = @dateid8 and itemcode = @itemcode_
		end


	------------------------------------------------
	--	3-2-4. 월별(아이템)
	------------------------------------------------
	--select 'DEBUG 월별(아이템)', @dateid6 dateid6, @itemcode_ itemcode_, @gamecost_ gamecost_, @cashcost_ cashcost_
	if(not exists(select top 1 * from dbo.tFVUserItemBuyLogMonth where dateid6 = @dateid6 and itemcode = @itemcode_))
		begin
			--select 'DEBUG 월별(아이템) insert'

			insert into dbo.tFVUserItemBuyLogMonth(dateid6, itemcode, gamecost, cashcost, cnt)
			values(@dateid6, @itemcode_, @gamecost_, @cashcost_, 1)
		end
	else
		begin
			--select 'DEBUG 월별(아이템) update'

			update dbo.tFVUserItemBuyLogMonth
				set
					gamecost = gamecost + @gamecost_,
					cashcost = cashcost + @cashcost_,
					cnt = cnt + 1
			where dateid6 = @dateid6 and itemcode = @itemcode_
		end


	------------------------------------------------
	--	4-1. 종류
	------------------------------------------------
	set nocount off
End
*/


/*
--################################################################
-- 동물 필드 번호 자리 업기
-- select dbo.fun_getFVUserItemListIdxConsume('dd11', 800)	-- 있는것
-- select dbo.fun_getFVUserItemListIdxConsume('dd11', 801)		-- 없는것
--################################################################
IF OBJECT_ID ( N'dbo.fun_getFVUserItemListIdxConsume', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fun_getFVUserItemListIdxConsume;
GO

CREATE FUNCTION dbo.fun_getFVUserItemListIdxConsume(
	@gameid_ 			varchar(20) = '',
	@itemcode_			int
)
	RETURNS int
AS
BEGIN
	---------------------------------------------------
	-- 빈자리 찾기 커서
	-- 0 [1] 2 3 4 5 	> [1] > update
	-- 0 1 2 3 4 5 6  	> 없음 > insert
	---------------------------------------------------
	declare @listidx		int		set @listidx	= -1

	select @listidx = listidx from dbo.tFVUserItem
	where gameid = @gameid_ and itemcode = @itemcode_


	RETURN @rtn
END
*/




/*
delete from dbo.tFVUserItem where idx in (251, 262, 273, 287)
select * from dbo.tFVUserItem where gameid = 'dd11' and invenkind = 1 order by fieldidx asc
select * from dbo.tFVUserItem where gameid = 'dd12' and invenkind = 1 order by fieldidx asc
select * from dbo.tFVUserItem where gameid = 'dd13' and invenkind = 1 order by fieldidx asc
select * from dbo.tFVUserItem where gameid = 'dd14' and invenkind = 1 order by fieldidx asc
select * from dbo.tFVUserItem where gameid = 'dd15' and invenkind = 1 order by fieldidx asc

insert into dbo.tFVUserItem(gameid,   listidx,      itemcode, cnt, farmnum, fieldidx, invenkind,            randserial)
values(					  'dd15',        30,			 1,   1,       0,        6,         1,                    -1)
insert into dbo.tFVUserItem(gameid,   listidx,      itemcode, cnt, farmnum, fieldidx, invenkind,            randserial)
values(					  'dd15',        31,			 1,   1,       0,        7,         1,                    -1)
insert into dbo.tFVUserItem(gameid,   listidx,      itemcode, cnt, farmnum, fieldidx, invenkind,            randserial)
values(					  'dd15',        32,			 1,   1,       0,        8,         1,                    -1)
insert into dbo.tFVUserItem(gameid,   listidx,      itemcode, cnt, farmnum, fieldidx, invenkind,            randserial)
values(					  'dd15',        30,			 1,   1,       0,        9,         1,                    -1)

*/
/*
--################################################################
-- 동물 필드 번호 자리 업기
-- select dbo.fun_getFVFieldIdxAni('dd11')
-- select dbo.fun_getFVFieldIdxAni('dd12')
-- select dbo.fun_getFVFieldIdxAni('dd13')
-- select dbo.fun_getFVFieldIdxAni('dd14')
-- select dbo.fun_getFVFieldIdxAni('dd15')
--################################################################
IF OBJECT_ID ( N'dbo.fun_getFVFieldIdxAni', N'FN' ) IS NOT NULL
	DROP FUNCTION dbo.fun_getFVFieldIdxAni;
GO

CREATE FUNCTION dbo.fun_getFVFieldIdxAni(
	@gameid_ 			varchar(20) = ''
)
	RETURNS int
AS
BEGIN
	-- 아이템별 인벤분류
	declare @USERITEM_INVENKIND_ANI				int 				set @USERITEM_INVENKIND_ANI					= 1
	declare @USERITEM_INVENKIND_CONSUME			int 				set @USERITEM_INVENKIND_CONSUME				= 3
	declare @USERITEM_INVENKIND_ACC				int 				set @USERITEM_INVENKIND_ACC					= 4
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
	select fieldidx from dbo.tFVUserItem
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

*/

/*
declare @cnt int
declare @cnt2 int
declare @cnt3 int
declare @listidx int
select * from dbo.tFVUserItem where gameid = 'dd1'
select @cnt = count(*) from dbo.tFVUserItem where gameid = 'dd1' and invenkind = 1
select @cnt2 = count(*) from dbo.tFVUserItem where gameid = 'dd1' and invenkind = 3
select @cnt3 = count(*) from dbo.tFVUserItem where gameid = 'dd1' and invenkind = 4
select @listidx = MAX(listidx) + 1 from dbo.tFVUserItem where gameid = 'dd1'
select @cnt, @cnt2, @cnt3, @listidx
--update dbo.tFVUserSeed set itemcode = -1 where fieldidx = 0
*/
/*

declare @gameid varchar(60)	set @gameid = 'sangsnag'
delete from dbo.tFVUserPay where phone in (select phone from dbo.tFVUserMaster where gameid = @gameid)
delete from from dbo.tFVUserBlockLog where  gameid = @gameid
delete from from dbo.tFVUserMaster where  gameid = @gameid
delete from from dbo.tFVUserItem where  gameid = @gameid
delete from from dbo.tFVUserSeed where  gameid = @gameid


*/


/*
	-- 경작지 상수
	declare @USERSEED_NEED_BUY			int					set @USERSEED_NEED_BUY				= -2
	declare @USERSEED_NEED_EMPTY				int					set @USERSEED_NEED_EMPTY					= -1
	-- >= 0 이상이면 특정 식물이 심어져있음.

-- delete from dbo.tFVUserPay
-- delete from dbo.tFVUserBlockLog
-- delete from dbo.tFVUserSMSReward
-- delete from dbo.tFVUserMaster
-- delete from dbo.tFVUserItem
-- delete from dbo.tFVUserSeed

*/

/*
select top 1 * from dbo.tFVUserBlockPhone where phone = @phone_
select count(*) from tUserMaster where phone = '01011112222' and deletestate = 0
update tUserMaster set deletestate = 1 where gameid = 'xxxx2'

insert into dbo.tFVUserMaster(gameid, password, market, buytype, platform, ukey, version, pushid, phone) values('xxxx', 'pppp', 1, 0, 1, 'uuuu', 101, 'pushidxxxx', '01011112222')
insert into dbo.tFVUserMaster(gameid, password, market, buytype, platform, ukey, version, pushid, phone) values('xxxx2', 'pppp', 1, 0, 1, 'uuuu', 101, 'pushidxxxx', '01011112222')
insert into dbo.tFVUserMaster(gameid, password, market, buytype, platform, ukey, version, pushid, phone) values('xxxx3', 'pppp', 1, 0, 1, 'uuuu', 101, 'pushidxxxx', '01011112222')
insert into dbo.tFVUserMaster(gameid, password, market, buytype, platform, ukey, version, pushid, phone) values('xxxx4', 'pppp', 1, 0, 1, 'uuuu', 101, 'pushidxxxx', '01011112222')
insert into dbo.tFVUserMaster(gameid, password, market, buytype, platform, ukey, version, pushid, phone) values('xxxx5', 'pppp', 1, 0, 1, 'uuuu', 101, 'pushidxxxx', '01011112222')

exec spu_FVUserCreate 'superman', '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', -1
exec spu_FVUserCreate 'xxxx6', '049000s1i0n7t8445289', 1, 0, 1, 'ukukukuk', 101, '01011112222', '', -1


insert into dbo.tFVUserSMSLog(gameid, sendkey, recphone) values('superman7', 'xxxxxxxxxxx1', '01011112222')




declare @dateid 		varchar(8)
declare @dateid6 		varchar(6)
declare @dateid8 		varchar(8)	set @dateid8 		= Convert(varchar(8), Getdate(),112)
declare @dateid10 		varchar(10) set @dateid10 		= Convert(varchar(8), Getdate(),112) + Convert(varchar(2), Getdate(), 108)
*/
/*
아이템 받는 상태로 변경 > 아이템 테이블 참조해서 선물 입력
DECLARE @tGainGift TABLE(
	gameid varchar(20),
	itemcode int
);
update dbo.tFVGiftList
	set
		gaindate = getdate(),
		gainstate = 1
		OUTPUT gameid, itemcode INTO @tGainGift
where idx = 1
select * from @tGainGift
select * from dbo.tFVGiftList
*/

/*
declare	@inText 		varchar(8000),
		@inDelim 		varchar(1),
		@inDelim2 		varchar(1)
set @inText		= '1/2/3'
--set @inText		= '1/ 2/3'
--set @inText		= '1/ 2/3456'
--set @inText		= '1/ 2/3,4,5,6'
--set @inText		= '1/ 2/3,4,5 ;6/7/8,9,10,11,12'
--set @inText		= '1/2/3;4/5/6,7;8/9/10,11,12;'
--set @inText		= '1/2/3;4/5/6,7;8/9/10,11,12;1/2/3'
--set @inText		= '1/2/3'
--set @inText		= '1/2/3;4/5/;7/8/9'
set @inDelim	=  ';'
set @inDelim2	=  '/'

declare @retArray table (
			idx 		smallint 		Primary Key,
			kind		int,
			listidx		int,
			value 		varchar(8000)
		);

DECLARE @idx 			smallint,
		@pos			smallint,
		@pos2			smallint,
		@end			smallint,
		@kind			varchar(20),
		@listidx		varchar(20),
		@value 			varchar(8000),
		@iStrike 		smallint

	SET @idx 			= 0
	SET @inText 		= LTrim(RTrim(@inText))

	WHILE (LEN(@inText) > 0)
		BEGIN
			SET @idx 		= @idx + 1
			SET @pos		= CHARINDEX(@inDelim, @inText)
			if(@pos != 0)
				begin
					set @end = 1
					set @pos = @pos - @end
					set @pos2 = @pos + @end
				end
			else
				begin
					set @end = 0
					set @pos = LEN(@inText)
					set @pos2 = @pos + @end
				end

			SET @value 		= SUBSTRING(@inText, 1, @pos)
			SET @value		= LTRIM(RTRIM(@value))
			SET @inText		= LTRIM(Right(@inText, DATALENGTH(@inText) - @pos2))

			-- 비정상 데이타는 점프
			if(@pos < 5)
				begin
					continue;
				end
--select @value, @inText

			set @pos 		= CHARINDEX(@inDelim2, @value)
			SET @kind 		= SUBSTRING(@value, 1, @pos - 1)
			SET @value		= LTRIM(Right(@value, DATALENGTH(@value) - @pos))
--select @value

			set @pos 		= CHARINDEX(@inDelim2, @value)
			SET @listidx	= SUBSTRING(@value, 1, @pos - 1)
			SET @value		= LTRIM(Right(@value, DATALENGTH(@value) - @pos))
--select @value
select @kind, @listidx, @value

			INSERT @retArray (idx, kind, listidx, value)
			VALUES (@idx, @kind, @listidx, @value)

		END
*/

/*
-- alter table dbo.tFVSMSRecommend add gamekind			int				default(1)
-- update dbo.tFVSMSRecommend set gamekind = 1 where gamekind is null
-- select top 1 * from dbo.tFVSMSRecommend order by idx desc
*/


/*
A0CC56794DA74C4A
0ED0422B7C1141D1
271FE60A65A3424C
143CD873198B441E
6B3285DE317E4EBF
9B06B6E50E924A13
5380B3523F9B4561
24B41389B8004F55



select top 50 * from dbo.tFVEventCertNo order by idx desc
declare @noloop 	int
declare @nomax 		int
declare @newid		uniqueidentifier
declare @newid2		varchar(256)
declare @certno		varchar(16)

set @noloop 	= 1
set @nomax 		= 10

while(@noloop < @nomax)
	begin
		-- 인증번호 생성 > [-] 제거 > 16자리로(알아서 짤리네 ㅎㅎㅎ)
		SET @newid = NEWID()
		set @newid2 = replace(@newid, '-', '')
		SET @certno = @newid2
		--select @newid, @newid2, @certno
		--80D9B780-5F99-4AE9-A59C-08301077285F	80D9B7805F994AE9A59C08301077285F	80D9B7805F994AE9

		-- 인증번호 중복인가?
		if(not exists(select top 1 * from dbo.tFVEventCertNo where certno = @certno))
			begin
				insert into dbo.tFVEventCertNo(certno) values(@certno)
			end
		else
			begin
				select '중복:' + @certno
			end

		set @noloop = @noloop + 1
	end
*/

/*
declare @loop int set @loop = 1
while @loop < 7
	begin
		exec spu_FVBattleSearch 'superman7', '', 5, 0, -1			--연속검색 없으면 > 다른것으로 변경
		--exec spu_FVBattleSearch 'superman7', '', 5, 1, -1			--연속검색 없으면 > 처음부터
		--exec spu_FVBattleSearch 'superman7', 'superman', 5, 0, -1	--연속검색 없으면 다른것으로 변경		-- 검색 > 없으면 다른유저검색(짤라먹은 것이 있어 확장함)
		--exec spu_FVBattleSearch 'superman7', 'superman', 5, 1, -1	--연속검색 없으면 > 처음부터			-- 검색 > 없으면 처음부터(짤라먹은 것이 있어 확장함)

		--exec spu_FVBattleSearch 'superman7', 'mogly', 5, 0, -1		-- 정상처리
		--exec spu_FVBattleSearch 'superman7', 'mogly', 5, 1, -1
		set @loop = @loop + 1
	end
*/


/*
-- 진혁이 아이폰 유저 가입
exec spu_FVUserCreate 'supermani', '049000s1i0n7t8445289', 'supermani@naver.com', 7, 0, 2, 1, 'ukukukuk', 100, '01011112217', '089c5cfc3ff57d1aca53be9df1d8d47c02601fb2820caef4b5a0db92909f292c', -1

exec spu_FVUserPushMsgAndroid 'supermani', '049000s1i0n7t8445289', 'supermani', 1, '단순제목', '단순내용 http://m.naver.com', -1, -1
exec spu_FVUserPushMsgAndroid 'supermani', '049000s1i0n7t8445289', 'supermani', 2, '자랑제목', '자랑내용', 5, -1
exec spu_FVUserPushMsgAndroid 'supermani', '049000s1i0n7t8445289', 'supermani', 3, 'URL제목', 'http://m.naver.com', -1, -1

select * from dbo.tFVUserPushiPhone
select * from dbo.tFVUserPushiPhoneLog
*/
/*
---------------------------------------------
--	iPhone Push Service
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPushiPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPushiPhone;
GO

create table dbo.tFVUserPushiPhone(
	idx				int				identity(1, 1),

	sendid			varchar(20),
	receid			varchar(20),
	recepushid		varchar(256),
	sendkind		int,

	msgpush_id		int				default(99),
	msgtitle		varchar(512),
	msgmsg			varchar(512),
	msgaction		varchar(512)	default('LAUNCH'),

	actionTime		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserPushiPhone_idx	PRIMARY KEY(idx)
)

---- Push입력하기
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73801', 'guest73801', 'APA91bF6Y96_WIvc3jQH83B2QoTUkcDcX2KAp6A5AGQfMQ_V4LZOjzKe7Wr-IVgXz-a2XS1A8hUIUZ6-0NmWkfkkQLqUMSYikMGA_P1Ejj42Z4e_VxRth84WJkMuhGjbvWUuwAVUdn90R5wlYe6P2W4hLMsyU8FeWjEXcHzFbRe2Fj8lH4CoOL0', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목', '홈런리그 내용푸쉬로 날려요.', 'LAUNCH')
--insert into dbo.tFVUserPushiPhone(sendid, receid, recepushid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction) values('guest73799', 'guest73799', 'APA91bE5TtZI1T81gIpHN1o1IZuasNwm0PoaiG2xYDzOJ6AkW2H148vKqUdy7Oh1in0F-OZUo1VxUbwnNt-Jg1blX7c6sJ7wf92vzIsDy9sRBCtJK4GhauekcatxyM7rS_pvEla4A5Tj3GWQEH3JFOZFZSIrK4UDa7FZxUwLiWZpNrceCqaRct4', 1, 99, '홈런리그제목url', '홈런리그 내용푸쉬로 날려요.url', 'http://m.naver.com')

---------------------------------------------
--	iPhone Push Service Log
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPushiPhoneLog', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPushiPhoneLog;
GO

create table dbo.tFVUserPushiPhoneLog(
	idx				int				identity(1, 1),

	sendid			varchar(20),
	receid			varchar(20),
	recepushid		varchar(256),
	sendkind		int,

	msgpush_id		int				default(99),
	msgtitle		varchar(512),
	msgmsg			varchar(512),
	msgaction		varchar(512)	default('LAUNCH'),

	actionTime		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserPushiPhoneLog_idx	PRIMARY KEY(idx)
)


*/


/*

----------------------------------------------------
-- 모바인 이벤트(전체)
-- 이벤트 제목 : 발렌타인데이 이벤트
-- 이벤트 기간 : 2013년 2월 13일 ~ 18일 까지(아이템은 19일 까지 지급)
-- 이벤트 내용 : 게임 접속하면 아이템 100% 지급
-- 지원 요청사항 : 게임 접속자게에 소모형 아이템 5개 지급(매일 종류별로 1개씩 또는 매일 다르게 특정 아이템 5개씩)
----------------------------------------------------

---------------------------------------------
--  로그인 이벤트
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVEventMaster', N'U') IS NOT NULL
	DROP TABLE dbo.tFVEventMaster;
GO

create table dbo.tFVEventMaster(
	idx			int 				IDENTITY(1, 1),

	gameid		varchar(20),
	dateid		varchar(8),
	eventcode	int,
	comment		varchar(128),

	writedate	datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tEventMaster_idx	PRIMARY KEY(idx)
)
-- gameid, grade
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVEventMaster_gameid_dateid_eventcode')
    DROP INDEX tFVEventMaster.idx_tFVEventMaster_gameid_dateid_eventcode
GO
CREATE INDEX idx_tFVEventMaster_gameid_dateid_eventcode ON tEventMaster(gameid, dateid, eventcode)
GO

-- select * from dbo.tFVEventMaster where gameid = 'superman' and dateid = '20130213' and eventcode = 1
-- insert into dbo.tFVEventMaster(gameid, dateid, eventcode, comment) values('Superman', '20130213', 1, '발렌타인데이 이벤트')
-- insert into dbo.tFVEventMaster(gameid, dateid, eventcode, comment) values('Superman2', '20130213', 1, '발렌타인데이 이벤트')
-- insert into dbo.tFVEventMaster(gameid, dateid, eventcode, comment) values('Superman', '20130214', 1, '발렌타인데이 이벤트')
-- declare @dateid 	varchar(8) set @dateid = Convert(varchar(8),Getdate(),112)	-- 20120809
-- set @rand = Convert(int, ceiling(RAND() *  100))
--
--declare @loop int set @loop = 1
--declare @rand int
--
--while @loop < 100
--	begin
--		set @rand = 6000 + Convert(int, ceiling(RAND() *  5)) - 1
--		select @rand
--		set @loop = @loop + 1
--	end
-- update dbo.tFVEventMaster set dateid = '20130212' where idx = 1

*/


/*
-- 5일 이내에 유저 정보 읽어서 처리하기
insert into tActionScheduleData(gameid)
select gameid from dbo.tFVUserMaster where condate > GETDATE() - 10
select top 10 gameid, * from dbo.tFVUserMaster where condate > GETDATE() - 5
*/


/*

-- 계급 랜덤
declare @gameid 		varchar(60)

declare curTemp Cursor for
select gameid from dbo.tFVUserMaster where idx <= 130

-- 2. 커서오픈
open curTemp

-- 3. 커서 사용
Fetch next from curTemp into @gameid
while @@Fetch_status = 0
	Begin
		update dbo.tFVUserMaster
			set
				grade = Convert(int, ceiling(RAND() * 5)) + 45
		where gameid = @gameid
		--select Convert(int, ceiling(RAND() * 5)) + 45

		Fetch next from curTemp into @gameid
	end

-- 4. 커서닫기
close curTemp
Deallocate curTemp
*/




/*
--------------------------------------------
-- 핸드폰별 > 커서로 작업하기
-- tUserMaster > ~ 2013-01-23 23:30
--------------------------------------------
-- 커스터마이징 정보를 입력하기
-- 1. 커서선언
declare @phone 		varchar(20)
declare @market		int
declare @regdate	datetime

declare curUserMaster Cursor for
select phone, market, regdate from dbo.tFVUserMaster
where phone != '' and regdate < '2013-01-23 23:30'
order by idx asc

-- 2. 커서오픈
open curUserMaster

-- 3. 커서 사용
Fetch next from curUserMaster into @phone, @market, @regdate
while @@Fetch_status = 0
	Begin
		if(not exists(select top 1 * from dbo.tFVUserPhone where phone = @phone))
			begin
				insert into dbo.tFVUserPhone(phone, market, joincnt, writedate) values(@phone, @market, 1, @regdate)
			end
		else
			begin
				update dbo.tFVUserPhone
					set
						joincnt = joincnt + 1
				where phone = @phone
			end
		Fetch next from curUserMaster into @phone, @market, @regdate
	end

-- 4. 커서닫기
close curUserMaster
Deallocate curUserMaster
*/

/*
---------------------------------------------
--	유니크 가입현황파악하기
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserPhone;
GO

create table dbo.tFVUserPhone(
	idx					int 				IDENTITY(1, 1),

	phone				varchar(20),
	market				int					default(1),
	joincnt				int					default(1),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserPhone_idx	PRIMARY KEY(idx)
)
-- 폰인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserPhone_phone')
    DROP INDEX tFVUserPhone.idx_tFVUserPhone_phone
GO
CREATE INDEX idx_tFVUserPhone_phone ON tUserPhone (phone)
GO

--------------------------------------------
-- 핸드폰별 가입 카운터
--------------------------------------------
declare @phone 	varchar(20) 		set @phone 	= '01122223335'
if(not exists(select top 1 * from dbo.tFVUserPhone where phone = @phone))
	begin
		insert into dbo.tFVUserPhone(phone, market, joincnt) values(@phone, 1, 1)
	end
else
	begin
		update dbo.tFVUserPhone
			set
				joincnt = joincnt + 1
		where phone = @phone
	end
select * from dbo.tFVUserPhone
select * from dbo.tFVUserPhone where phone = '0112'
select * from dbo.tFVUserPhone where phone like '0112%'

*/
/*
---------------------------------------------
--	로그인 현황, 플레이 현황
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVStaticTime', N'U') IS NOT NULL
	DROP TABLE dbo.tFVStaticTime;
GO

create table dbo.tFVStaticTime(
	idx					int 				IDENTITY(1, 1),

	dateid10			varchar(10),
	market				int					default(1),				-- (구매처코드) MARKET_SKT

	logincnt			int					default(0),
	playcnt				int					default(0),


	-- Constraint
	CONSTRAINT	pk_tStaticTime_dateid10_market	PRIMARY KEY(dateid10, market)
)



-- 로그인 카운터
declare @dateid10 	varchar(10) 		set @dateid10 	= Convert(varchar(8), Getdate(),112) + Convert(varchar(2), Getdate(), 108)
declare @market 	int					set @market 	= 1
if(not exists(select top 1 * from dbo.tFVStaticTime where dateid10 = @dateid10 and market = @market))
	begin
		insert into dbo.tFVStaticTime(dateid10, market, logincnt, playcnt) values(@dateid10, @market, 1, 0)
	end
else
	begin
		update dbo.tFVStaticTime
			set
				logincnt = logincnt + 1
		where dateid10 = @dateid10 and market = @market
	end
select * from dbo.tFVStaticTime order by dateid10 desc, market desc

-- 플레이 카운드
declare @dateid10 	varchar(10) 		set @dateid10 	= Convert(varchar(8), Getdate(),112) + Convert(varchar(2), Getdate(), 108)
declare @market 	int					set @market 	= 1
if(not exists(select top 1 * from dbo.tFVStaticTime where dateid10 = @dateid10 and market = @market))
	begin
		insert into dbo.tFVStaticTime(dateid10, market, logincnt, playcnt) values(@dateid10, @market, 0, 1)
	end
else
	begin
		update dbo.tFVStaticTime
			set
				playcnt = playcnt + 1
		where dateid10 = @dateid10 and market = @market
	end
select * from dbo.tFVStaticTime order by dateid10 desc, market desc

*/
/*
---------------------------------------------
--  역전배틀/미션 세팅값들
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVRevModeInfo', N'U') IS NOT NULL
	DROP TABLE dbo.tFVRevModeInfo;
GO

create table dbo.tFVRevModeInfo(
	idx					int 				IDENTITY(1, 1),

	btrevitemcode		int					default(7020),
	btrevprice			int					default(5),
	msrevitemcode4		int					default(7021),
	msrevprice4			int					default(5),
	msrevitemcode7		int					default(7022),
	msrevprice7			int					default(7),
	msrevitemcode8		int					default(7023),
	msrevprice8			int					default(20),
	msrevitemcode9		int					default(7024),
	msrevprice9			int					default(50),

	flag				int					default(1),			--(1):활성화, (0)비활성화
	comment				varchar(1024),
	writedate			datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tRevModeInfo_idx	PRIMARY KEY(idx)
)
-- insert into dbo.tFVRevModeInfo(btrevitemcode, btrevprice, msrevitemcode4, msrevprice4, msrevitemcode7, msrevprice7, msrevitemcode8, msrevprice8, msrevitemcode9, msrevprice9, comment) values(7020, 5, 7021, 5, 7022, 7, 7023, 20, 7024, 50, '내용')
-- select top 1 * from dbo.tFVRevModeInfo where flag = 1 order by idx desc


			else if(@subkind = 60)
				begin
					insert into dbo.tFVRevModeInfo(btrevitemcode, btrevprice, msrevitemcode4, msrevprice4, msrevitemcode7, msrevprice7, msrevitemcode8, msrevprice8, msrevitemcode9, msrevprice9, comment)
					values(@p5_, @p6_, @p7_, @p8_, @p9_, @p10_, @ps1, @ps2_, @ps3_, @ps4_, @message_)
					select * from dbo.tFVRevModeInfo order by idx desc
				end
			else if(@subkind = 61)
				begin
					update dbo.tFVRevModeInfo
						set
							btrevitemcode	= @p5_,
							btrevprice		= @p6_,
							msrevitemcode4	= @p7_,
							msrevprice4		= @p8_,
							msrevitemcode7	= @p9_,
							msrevprice7		= @p10_,
							msrevitemcode8	= @ps1,
							msrevprice8		= @ps2_,
							msrevitemcode9	= @ps3_,
							msrevprice9		= @ps4_,
							comment 		= @message_
					where idx = @idx

					select * from dbo.tFVRevModeInfo order by idx desc
				end
			else if(@subkind = 62)
				begin
					select * from dbo.tFVRevModeInfo order by idx desc
				end

*/
/*
declare @idx	bigint
declare @loop 	int
set @loop = 1
while(@loop < 10)
	begin
		update dbo.tFVUserMaster set trainflag = 1, machineflag = 1, memorialflag	= 1, soulflag = 1, btflag = 1, btflag2 = 1, blockstate = 0, cashcopy = 0, resultcopy = 0 where gameid = 'superman6'
		exec spu_FVGameEnd 'superman6', 6, 1000,		-- gameid, gmode, point																-- 스프린트
			21, 8,				-- lvexp, lv
			10,					-- get silver
			2, 1, 2, 1,			-- gradeexp, grade, gradestar, btresult(win/lose)
			'DD1',				-- btgameid
			10000, 9, 1000,		-- bttotalpower_, bttotalcount_, btavg_
			1,					-- btsearchidx_
			20, 3, 4, 1, 2, 3,	-- bestdist_, homerun_, homeruncombo_, pollhit_, ceilhit_, boardhit_
			-1
		set @loop = @loop + 1
	end


*/

/*
-- 1일 1회
-- delete from dbo.tFVUserSMSLog where recphone = '0162682109'
declare @recphone2_	 varchar(20)
set @recphone2_	= '0162682109'
select * from dbo.tFVUserSMSLog where recphone = @recphone2_ and senddate > (getdate() - 0.2)
if(exists(select * from dbo.tFVUserSMSLog where recphone = @recphone2_ and senddate > (getdate() - 1)))
	begin
		select 'DEBUG 존재'
	end



	else if(exists(select * from dbo.tFVUserSMSLog where recphone = @recphone2_ and senddate > (getdate() - 1)))
		begin
			set @nResult_ = @RESULT_ERROR_SMS_KEY_DUPLICATE
			set @comment = 'ERROR 문자추천 시리얼키가 중복된다.'
		end
*/

/*

declare @loop int set @loop = 1
declare @rand int
declare @sprintupgradestate2 int

while @loop < 100
	begin
		set @rand = Convert(int, ceiling(RAND() *  100))
		if(@rand < 70)
			begin
				set @sprintupgradestate2 = ( 5 + Convert(int, ceiling(RAND() *  5)) - 1)
			end
		else if(@rand < 95)
			begin
				set @sprintupgradestate2 = (10 + Convert(int, ceiling(RAND() *  5)) - 1)
			end
		else
			begin
				set @sprintupgradestate2 = (15 + Convert(int, ceiling(RAND() *  5)) - 1)
			end

		select @sprintupgradestate2 sprintupgradestate2
		set @loop = @loop + 1
	end

*/

/*
---------------------------------------------
-- 	룰렛 로그 > 통계용2 Master
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVRouletteLogTotalMaster2', N'U') IS NOT NULL
	DROP TABLE dbo.tFVRouletteLogTotalMaster2;
GO

create table dbo.tFVRouletteLogTotalMaster2(
	idx				int				identity(1, 1),
	dateid			char(8),							-- 20101210
	milkballkind	int				default(2),

	cashcost		int				default(0),			-- 누적 골든볼 (-)
	gamecost		int				default(0),			-- 누적 실버볼 (+)
	itemcodecnt		int				default(0),			-- 누적 아이템 (+)
	cnt				int				default(1),			-- 누적 	   (+)

	-- Constraint
	CONSTRAINT	pk_tRouletteLogTotalMaster2_dateid_milkballkind	PRIMARY KEY(dateid, milkballkind)
)
insert into tRouletteLogTotalMaster2(dateid, milkballkind, cashcost, gamecost, itemcodecnt, cnt)
select dateid, milkballkind, cashcost, gamecost, itemcodecnt, cnt from tRouletteLogTotalMaster order by idx desc

---------------------------------------------
-- 	룰렛 로그 > 통계용
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVRouletteLogTotalSub2', N'U') IS NOT NULL
	DROP TABLE dbo.tFVRouletteLogTotalSub2;
GO

create table dbo.tFVRouletteLogTotalSub2(
	idx				int				identity(1, 1),
	dateid			char(8),							-- 20101210
	milkballkind	int				default(2),

	cashcost		int				default(0),
	gamecost		int				default(0),
	itemcode		int				default(-1),
	cnt				int				default(1),
	comment			varchar(128),

	-- Constraint
	CONSTRAINT	pk_tRouletteLogTotalSub2_dateid_coinball_itemcode PRIMARY KEY(dateid, gamecost, itemcode, milkballkind)
)

insert into tRouletteLogTotalSub2(dateid, milkballkind, cashcost, gamecost, itemcode, cnt, comment)
select dateid, milkballkind, cashcost, gamecost, itemcode, cnt, comment from tRouletteLogTotalSub order by idx asc
*/

/*
--컬럼생성 값입력
alter table dbo.tFVUserMaster add doublepower		int					default(50)
alter table dbo.tFVUserMaster add doubledegree	int					default(50)
update dbo.tFVUserMaster set doublepower = 15, doubledegree = 15
*/

/*

-- 폰인덱싱
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserMaster_phone')
    DROP INDEX tFVUserMaster.idx_tFVUserMaster_phone
GO
CREATE INDEX idx_tFVUserMaster_phone ON tUserMaster (phone)
GO


*/


/*

---------------------------------------------
-- 	(어드민 쪽지)
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVMessageAdmin', N'U') IS NOT NULL
	DROP TABLE dbo.tFVMessageAdmin;
GO

create table dbo.tFVMessageAdmin(
	idx			int					IDENTITY(1,1),
	adminid		varchar(20),
	gameid		varchar(20),
	comment		varchar(1024),

	writedate	datetime			default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tMessageAdmin_idx	PRIMARY KEY(idx)
)

-- insert into tMessageAdmin(adminid, gameid, comment) values('black4', 'guest', '골드지급');
-- select top 100 * from tMessageAdmin order by idx desc

*/

/*

---------------------------------------------
-- 	블럭폰번호 > 가입시 블럭처리자
---------------------------------------------
IF OBJECT_ID (N'dbo.tFVUserBlockPhone', N'U') IS NOT NULL
	DROP TABLE dbo.tFVUserBlockPhone;
GO

create table dbo.tFVUserBlockPhone(
	idx			int 					IDENTITY(1, 1),
	phone			varchar(20),
	comment			varchar(1024),
	writedate		datetime		default(getdate()),

	-- Constraint
	CONSTRAINT	pk_tUserBlockPhone_phone	PRIMARY KEY(phone)
)

-- insert into dbo.tFVUserBlockPhone(phone, comment) values('01022223333', '아이템카피')
-- insert into dbo.tFVUserBlockPhone(phone, comment) values('01092443174', '환전버그카피')
-- select top 100 * from dbo.tFVUserBlockPhone order by idx desc
-- select top 1   * from dbo.tFVUserBlockPhone where phone = '01022223333'

-- 센드키 충돌검사
IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'idx_tFVUserBlockPhone_idx')
    DROP INDEX tFVUserBlockPhone.idx_tFVUserBlockPhone_idx
GO
CREATE INDEX idx_tFVUserBlockPhone_idx ON tUserBlockPhone (idx)
GO
*/

/*

alter table dbo.tFVUserMaster add eventnpcwin			int				default(0)

update dbo.tFVUserMaster
	set
		eventnpcwin = 0
where eventnpcwin is null

select * from dbo.tFVUserMaster where eventnpcwin = 1

*/
/*

alter table dbo.tFVNotice add market			int				default(1)
alter table dbo.tFVNotice add adurl2			varchar(512)
alter table dbo.tFVNotice add adfile2			varchar(512)

update dbo.tFVNotice set market = 1 where market is null
update dbo.tFVNotice set adurl2 = adurl, adfile2 = adfile  where adurl2 is null
update dbo.tFVNotice set branchurl = adurl where branchurl is null
update dbo.tFVNotice set facebookurl = adurl where facebookurl is null

select * from dbo.tFVNotice
where idx in (select max(idx) from dbo.tFVNotice group by market)
order by market asc
*/

/*
alter table dbo.tFVCashLog add market			int				default(1)
update dbo.tFVCashLog set market = 1 where market is null
*/

/*
alter table dbo.tFVUserJoinTotal add market			int				default(1)
update dbo.tFVUserJoinTotal set market = 1 where market is null

insert into dbo.tFVUserJoinTotal(dateid, market, cnt, cnt2)
select dateid, market, cnt, cnt2 from dbo.tFVUserJoinTotal2 order by idx asc

ALTER TABLE dbo.tFVUserJoinTotal DROP pk_tUserJoinTotal_dateid
Alter Table dbo.tFVUserJoinTotal alter column dateid			char(8) not null
Alter Table dbo.tFVUserJoinTotal ADD CONSTRAINT	pk_tUserJoinTotal_dateid_market	PRIMARY KEY(dateid, market)
*/
--------------------------------------------
-- 대용량 푸쉬보내기
---------------------------------------------
/*

-- 대용량으로 입력하기
insert into dbo.tFVQuestUser(gameid, questcode, queststate, queststart)
	select @gameid_, questcode, @QUEST_STATE_USER_ING, getdate()
		from dbo.tFVQuestInfo where questinit = @QUEST_INIT_FIRST



insert into dbo.tFVUserPushAndroid(recepushid, sendid, receid, sendkind, msgpush_id, msgtitle, msgmsg, msgaction)
	select distinct pushid, @ps2_, @gameid_, @p5_, 99, @ps3_, @ps4_, @branchurl from dbo.tFVUserMaster
		where market = 1 and pushid is not null and len(pushid) > 50

	select distinct pushid, 'a2' from dbo.tFVUserMaster
		where market = 1 and pushid is not null and len(pushid) > 50
		and gameid in ('guest74019', 'guest74022')

	select distinct pushid, 'a2' from dbo.tFVUserMaster
		where gameid in ('guest74019', 'guest74022')

*/

--------------------------------------------
--
---------------------------------------------

/*
declare @milkballPrice	int,		@coinballPrice	int, @sale			int

set @sale = 10
set @milkballPrice = 0
set @coinballPrice = 15

		-- 세일을 적용하자.
		if(@sale > 0 and @sale <= 100)
			begin
				if(@milkballPrice > 0)
					begin
						set @milkballPrice = @milkballPrice * (100 - @sale) / 100
					end
				else if(@coinballPrice > 0)
					begin
						set @coinballPrice = @coinballPrice * (100 - @sale) / 100
					end
			end

select @milkballPrice milkballPrice, @coinballPrice coinballPrice
*/
/*
alter table dbo.tFVNotice add adurl			varchar(512)
alter table dbo.tFVNotice add adfile			varchar(512)
update dbo.tFVNotice set adurl = '', adfile = ''
*/
/*
select (getdate() - 1)
alter table dbo.tFVUserMaster add doubledate		datetime			default(getdate() - 1)
update dbo.tFVUserMaster set doubledate = (getdate() - 1)

declare @doubledate datetime
set @doubledate = '20121205'
if(getdate() < @doubledate)
	select '더블모드'
else
	select '일반모드'
select getdate(), DATEADD(dd, 3, getdate())



--추천인 글 남기기
alter table dbo.tFVUserMaster add mboardstate	int						default(0)
update dbo.tFVUserMaster set mboardstate = 0
alter table dbo.tFVMarketPatch add mboardurl	varchar(512)		default('')
update dbo.tFVMarketPatch set mboardurl = ''

declare @gameid			varchar(60)
declare @mboardstate	int
select
	@gameid = gameid, @mboardstate = mboardstate
	from dbo.tFVUserMaster
where gameid = 'superman'
select @gameid gameid, @mboardstate mboardstate

select * from tMarketPatch
delete from tMarketPatch where market = 7 and buytype = 1
delete from tMarketPatch where buytype = 1

select branchurl, mboardurl from dbo.tFVMarketPatch
where market = 1 and buytype = 0

select * from tUs

alter table dbo.tFVUserMaster add resultwinpush		int 					default(0)
update dbo.tFVUserMaster set resultwinpush = 0

*/

--------------------------------------------
-- Android Push 발송후 로그쪽으로 이동하기
---------------------------------------------
/*
-- select min(idx) min, max(idx) max from dbo.tFVUserPushAndroid
-- select * from dbo.tFVUserPushAndroid
DECLARE @tTemp TABLE(
				sendid			varchar(20),
				receid			varchar(20),
				recepushid		varchar(256),
				comment			varchar(256)
			);
delete from dbo.tFVUserPushAndroid
	OUTPUT sendid, receid, recepushid, comment into @tTemp
	where idx in (1, 2)
	--where idx between 1 and 2
-- select * from @tTemp

insert into dbo.tFVUserPushAndroidLog(sendid, receid, recepushid, comment)
	(select sendid, receid, recepushid, comment from @tTemp)
-- select * from dbo.tFVUserPushAndroidLog
*/


--------------------------------------------
-- 아이디 검색을 통해서 랭킹
---------------------------------------------
-- 랭킹Top10산출예제(MSSQL).sql 실행한후에
/*
declare @gameid			varchar(60)
declare @bttotal		int

set @gameid = 'SangSang777'

select count(gameid)+1 as rank, @gameid gameid from dbo.tFVUserTTT where btwin > @btwin
*/

--------------------------------------------
-- 검색 기능 강화
---------------------------------------------
--select top 1 * from dbo.tFVUserMaster where gameid = 'mogly'


--------------------------------------------
-- 진행퀘스트 > 강제로 입력하기
---------------------------------------------
/*
declare @gameid varchar(60)
declare curQuestUser Cursor for
	select gameid from dbo.tFVUserMaster
		where gameid not in (select distinct gameid from dbo.tFVQuestUser)

	Open curQuestUser
	Fetch next from curQuestUser into @gameid
	while @@Fetch_status = 0
		Begin
			insert into dbo.tFVQuestUser(gameid, questcode, queststate, queststart)
				select @gameid, questcode, 2, getdate()
					from dbo.tFVQuestInfo where questinit = 1
			Fetch next from curQuestUser into @gameid
		end
close curQuestUser
Deallocate curQuestUser
*/

--------------------------------------------
-- 진행퀘스트
---------------------------------------------
/*
-- id/quest 생성 > 초기퀘 바로지급 (강제로 퀘너어주기)
insert into dbo.tFVQuestUser(gameid, questcode, queststate, queststart)
	select 'Superman3', questcode, 2, getdate()
		from dbo.tFVQuestInfo where questinit = 1
-- select * from dbo.tFVQuestUser where gameid = 'Superman3'
-- delete from dbo.tFVQuestUser where gameid = 'Superman3'
*/

/*
-- 관리페이지에서 퀘확인
select gameid, i.questlv, u.questcode, u.queststate, queststart, questend, questnext, questkind, questsubkind, questvalue, rewardsb, rewarditem, content, questtime, * from dbo.tFVQuestUser u join
	(select * from dbo.tFVQuestInfo) i
		on u.questcode = i.questcode
where gameid = 'superman3'
--order by questcode asc
*/

/*
-- 로그인 > 퀘시간 확인 -> 퀘리스트 받기(진행대기중, 진행중으로 바뀔시간)
-- update dbo.tFVQuestUser set queststate = 1 where gameid = 'superman3' and questcode = 100
declare @QUEST_CLEAR_NON				int 			set @QUEST_CLEAR_NON 				= 0
declare @QUEST_CLEAR_START				int 			set @QUEST_CLEAR_START 				= 1
declare @QUEST_CLEAR_REWARD				int 			set @QUEST_CLEAR_REWARD				= 2
declare @QUEST_STATE_USER_END			int 			set @QUEST_STATE_USER_END 		= 0
declare @QUEST_STATE_USER_WAIT			int 			set @QUEST_STATE_USER_WAIT 		= 1
declare @QUEST_STATE_USER_ING			int 			set @QUEST_STATE_USER_ING 		= 2
declare @gameid_						varchar(20)		set @gameid_				= 'superman3'
declare @lv								int				set @lv						= 1
declare @questcode	int,	@questkind		int,	@questsubkind		int,		@questclear		int

-- 로그인 > 대기중(1) and 시간이 유효 > 커서로 필터
declare curQuestUser Cursor for
	select questcode, questkind, questsubkind, questclear from dbo.tFVQuestInfo
	where questcode in (select questcode from dbo.tFVQuestUser
						where gameid = @gameid_
							  and queststate = @QUEST_STATE_USER_WAIT
							  and getdate() > queststart)
	Open curQuestUser
	Fetch next from curQuestUser into @questcode, @questkind, @questsubkind, @questclear
	while @@Fetch_status = 0
		Begin
			if(@questclear = @QUEST_CLEAR_START)
				begin
					--select 'DEBUG 로그인 > 데이타 클리어해주세요.', @questcode, @questkind, @questsubkind, @questclear
					exec spu_FVCheckQuestData @gameid_, @questkind, @questsubkind, -1
				end
			-- 보상
			-- exec spu_FVClearQuestUser @gameid_, 2, @questcode, @questkind, @questsubkind, @questclear
			Fetch next from curQuestUser into @questcode, @questkind, @questsubkind, @questclear
		end
close curQuestUser
Deallocate curQuestUser

-- 속도를 위해서 일괄 --> 진행중(2)으로 변경
update dbo.tFVQuestUser set queststate = @QUEST_STATE_USER_ING
where gameid = @gameid_ and queststate = @QUEST_STATE_USER_WAIT and getdate() > queststart

--> 진행중 리스트 만들기
select * from dbo.tFVQuestInfo
where questcode in (
	select questcode from dbo.tFVQuestUser
	where gameid = @gameid_ and queststate = @QUEST_STATE_USER_ING and @lv >= questlv
)
*/

/*
-- select * from dbo.tFVUserMaster where gameid like 'superman%'
-- 진행퀘 보내주기
declare @QUEST_CLEAR_NON				int 			set @QUEST_CLEAR_NON 			= 0
declare @QUEST_CLEAR_START				int 			set @QUEST_CLEAR_START 			= 1
declare @QUEST_CLEAR_REWARD				int 			set @QUEST_CLEAR_REWARD			= 2
declare @QUEST_STATE_USER_END			int 			set @QUEST_STATE_USER_END 		= 0
declare @QUEST_STATE_USER_WAIT			int 			set @QUEST_STATE_USER_WAIT 		= 1
declare @QUEST_STATE_USER_ING			int 			set @QUEST_STATE_USER_ING 		= 2
declare @gameid_						varchar(20)		set @gameid_				= 'superman3'
declare @lv								int				set @lv						= 1
declare @questcode int,		@questkind int,		@questsubkind int,		@questclear int

select * from dbo.tFVQuestUser where gameid = @gameid_ and queststate = @QUEST_STATE_USER_ING
--
-- 퀘완료 > 퀘완료, 다음퀘 세팅
-- select * from dbo.tFVQuestUser where gameid = 'SangSang' and questcode = 100
	-- 퀘스트 완료에 따른 보상지급
	-- update dbo.tFVQuestUser set queststate = 0, questend = getdate() where gameid = 'SangSang' and questcode = 100
	-- update dbo.tFVUserMaster set 보상SB, 보상템 where gameid = 'SangSang'
	--
	-- 다음퀘 세팅하기
	-- select @questnext = questnext from dbo.tFVQuestInfo where questcode = 100
	-- if(@questnext != -1)
	--	select @questtime = questtime from dbo.tFVQuestInfo where questcode = @questnext
	--	if(not exists(select top 1 * from dbo.tFVQuestUser where questcode = @questnext))
	--		insert into dbo.tFVQuestUser(gameid, questcode, queststate, queststart)
	--		values(@gameid, @questnext, 대기중(1), DATEADD(hh, @questtime, getdate())
	--	else
	--		update dbo.tFVQuestUser
	--			set
	--				queststate = 대기중(1),
	--				queststart = DATEADD(hh, @questtime, getdate())
	--		where gameid = @gameid and questcode = @questnext
	-- else
	--	더이상 없으니까 > 자동소멸된다.


-- insert into dbo.tFVQuestUser(gameid, questcode, queststate, queststart) select 'SangSang', questcode, 2, DATEADD(hh, questtime, getdate()) from dbo.tFVQuestInfo where questinit = 1
-- 퀘완료 > 입력, 업데이트
*/



