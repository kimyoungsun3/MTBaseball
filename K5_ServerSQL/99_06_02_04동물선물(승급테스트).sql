use GameMTBaseball
GO

-- 동물선물하기.
declare @kakaouserid	varchar(60)
declare @gameid			varchar(20) 	set @gameid		= ''
declare @password		varchar(20) 	set @password	= ''
declare @kakaostatus	int				set @kakaostatus=  1
declare @deletestate	int				set @deletestate= -1
declare @anilistidx 	int				set @anilistidx = -1	-- 동물.
declare @listset		varchar(2560)
declare @kind			int
declare @info			int
declare @loop 			int				set @loop		= 0
declare @itemcode		int
declare @needcnt		int
declare @needcnt2		int
declare @listidxs1		int
declare @listidxs2		int
declare @listidxs3		int
declare @listidxs4		int
declare @listidxs5		int
declare @rand			int

set @kakaouserid	= '88470968441492993'	-- PC
--set @kakaouserid = '88470968441492992'	-- 임과장폰

select @gameid = gameid from dbo.tKakaoMaster where kakaouserid = @kakaouserid
select @deletestate = deletestate, @kakaostatus = kakaostatus, @password = password from dbo.tUserMaster where gameid = @gameid
if( @gameid = '' or @kakaostatus != 1 or @deletestate != 0 )
	begin
		select 'DEBUG 현재 유저는 활성된계정이 없음.'
	end
--delete from dbo.tGiftList where gameid = @gameid										-- 선물초기화
delete from dbo.tUserItem where gameid = @gameid and invenkind in (1, 1040, 36)		-- 동물과 세포
--delete from dbo.tPromoteLogPerson where gameid = @gameid								-- 로고삭제
update dbo.tUserFarm set buystate  = 1, playcnt = 10, star = 3 where gameid = @gameid	-- 목장구매상태.
exec spu_SetDirectItemNew @gameid, 3600, 999999, 1, -1									-- 승급티켓
update dbo.tUserMaster set cashcost = 100000, gamecost = 99100000, heart = 100000, randserial = -1, battleticket = 9999 where gameid = @gameid

	------------------------------------
	-- 지급동물.
	-- 레벨:동물;
	------------------------------------
	--set @listset = '0:1;0:2;'			-- 승급테스트.
	--set @listset = '0:1;0:2;0:3;0:4;0:5;0:6;0:7;0:8;0:9;0:10;'			-- 승급테스트.
	--set @listset = '0:11;0:12;0:13;0:14;0:15;0:16;0:17;0:18;0:19;0:20;'	-- 승급테스트.
	--set @listset = '0:21;0:22;0:23;0:24;0:25;0:26;0:27;0:28;0:29;'		-- 승급테스트.
	--set @listset = '0:100;0:101;0:102;0:103;0:104;0:105;0:106;0:107;0:108;0:109;0:110;'	-- 승급테스트.
	--set @listset = '0:111;0:112;0:113;0:114;0:115;0:116;0:117;0:118;0:119;0:120;'		-- 승급테스트.
	--set @listset = '0:121;0:122;0:123;0:124;0:125;0:126;0:127;0:128;0:129;0:130;'		-- 승급테스트.
	--set @listset = '0:200;0:201;0:202;0:203;0:204;0:205;0:206;0:207;0:208;0:209;0:210;'	-- 승급테스트.
	--set @listset = '0:211;0:212;0:213;0:214;0:215;0:216;0:217;0:218;0:219;0:220;'		-- 승급테스트.
	--set @listset = '0:221;0:222;0:223;0:224;0:225;0:226;0:227;0:228;0:229;0:230;'		-- 승급테스트.

	set @listset = '0:1;0:2;0:3;0:4;0:5;0:6;0:7;0:8;0:9;0:10;0:11;0:12;0:13;0:14;0:15;0:16;0:17;0:18;0:19;0:20;0:21;0:22;0:23;0:24;0:25;0:26;0:27;0:28;0:29;0:100;0:101;0:102;0:103;0:104;0:105;0:106;0:107;0:108;0:109;0:110;0:111;0:112;0:113;0:114;0:115;0:116;0:117;0:118;0:119;0:120;0:121;0:122;0:123;0:124;0:125;0:126;0:127;0:128;0:129;0:130;0:200;0:201;0:202;0:203;0:204;0:205;0:206;0:207;0:208;0:209;0:210;0:211;0:212;0:213;0:214;0:215;0:216;0:217;0:218;0:219;0:220;0:221;0:222;0:223;0:224;0:225;0:226;0:227;0:228;0:229;0:230;'		-- 승급테스트.
	set @listset = replace(@listset, '0:', '8:');

	-- 1. 커서 생성
	declare curApartItemcode Cursor for
	select * FROM dbo.fnu_SplitTwo(';', ':', @listset)

	-- 2. 커서오픈
	open curApartItemcode

	-- 3. 커서 사용
	Fetch next from curApartItemcode into @kind, @info
	while @@Fetch_status = 0
		Begin
			-- 승급 종류에 필요한 동물의 수량 확인.
			set @needcnt 	= 0
			set @needcnt2	= 0
			select @itemcode = itemcode, @needcnt = param4, @needcnt2 = param4 from dbo.tItemInfo
			where subcategory = 1020 and ( param5 = @info or param6 = @info or param7 = @info or param8 = @info or param9 = @info)

			-- 동물넣기.
			set @listidxs1	= -1
			set @listidxs2	= -1
			set @listidxs3	= -1
			set @listidxs4	= -1
			set @listidxs5	= -1
			while(@needcnt2 > 0)
				begin
					exec spu_SetDirectItemNew @gameid, @info, 1, 3, @rtn_ = @anilistidx OUTPUT
					update dbo.tUserItem set upcnt = upstepmax, freshstem100 = 1, attstem100 = 2, timestem100 = 3, defstem100 = 4, hpstem100 = 5 where gameid = @gameid and listidx = @anilistidx

					if(@needcnt = @needcnt2)
						begin
							set @listidxs1 = @anilistidx
						end
					else if(@needcnt - 1 = @needcnt2)
						begin
							set @listidxs2 = @anilistidx
						end
					else if(@needcnt - 2 = @needcnt2)
						begin
							set @listidxs3 = @anilistidx
						end
					else if(@needcnt - 3 = @needcnt2)
						begin
							set @listidxs4 = @anilistidx
						end
					else if(@needcnt - 4 = @needcnt2)
						begin
							set @listidxs5 = @anilistidx
						end
					set @needcnt2 = @needcnt2 - 1
				end

			-- 승급하기.
			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			--exec spu_AniPromote @gameid, @password, @itemcode, @listidxs1, @listidxs2, @listidxs3, @listidxs4, @listidxs5, @rand, -1	-- 2마리

			--select 'DEBUG ', @kind, @info
			set @loop = @loop + 1
			Fetch next from curApartItemcode into @kind, @info
		end
	-- 4. 커서닫기
	close curApartItemcode
	Deallocate curApartItemcode


