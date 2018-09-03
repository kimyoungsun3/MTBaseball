use GameMTBaseball
GO

-- 동물선물하기.
declare @kakaouserid	varchar(60)
declare @gameid			varchar(20) 	set @gameid		= ''
declare @password		varchar(20) 	set @password	= ''
declare @anilistidx 	int				set @anilistidx = -1	-- 동물.
declare @celllistidx 	int				set @celllistidx = -1	-- 줄기세포.
declare @listset		varchar(2560)
declare @listset2		varchar(2560)
declare @kind			int
declare @info			int
declare @upcnt			int
declare @upstepmax		int
declare @upstepmax2		int
declare @stemcellitemcode	int
declare @rand			int
declare @upsteplvcnt	int
declare @cellgrade		int
declare @cellgrademin	int
declare @cellgrademax	int


-- 3-1. 커서선언
declare curUserInfo Cursor for
select gameid from dbo.tUserMaster where kakaonickname in (select gameid from dbo.tSample)

-- 3-2. 커서오픈
open curUserInfo

-- 3-3. 커서 사용
Fetch next from curUserInfo into @gameid
while @@Fetch_status = 0
	Begin
		--select 'DEBUG step 1', @gameid gameid

		select @password = password from dbo.tUserMaster where gameid = @gameid
		delete from dbo.tGiftList where gameid = @gameid								-- 선물초기화
		delete from dbo.tUserItem where gameid = @gameid and invenkind in (1, 1040)		-- 동물과 세포
		--update dbo.tUserGameMTBaseball set buystate  = 1, playcnt = 10, star = 3 where gameid = @gameid		-- 목장구매상태.
		--update dbo.tUserMaster set battleticket = 9999 where gameid = @gameid

		------------------------------------
		-- 지급동물.
		--	레벨:동물;
		------------------------------------
		set @listset = '0:1;0:2;0:3;0:100;0:101;0:4;0:5;0:6;0:102;0:103;0:200;0:201;0:202;0:7;0:8;0:9;0:104;0:105;0:203;0:204;0:10;0:11;0:12;0:106;0:107;0:108;0:205;0:13;0:14;0:15;0:109;0:110;0:111;0:206;0:207;0:208;0:16;0:17;0:18;0:19;0:112;0:113;0:114;0:115;0:209;0:210;0:211;0:20;0:21;0:23;0:24;0:25;0:116;0:117;0:118;0:119;0:120;0:212;0:213;0:214;0:215;0:26;0:27;0:28;0:29;0:121;0:122;0:123;0:124;0:216;0:217;0:218;0:219;0:125;0:126;0:127;0:220;0:221;0:222;0:223;0:224;0:225;0:226;0:227;'
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
				-- 초기화하기.
				set @upstepmax = 0

				-- 동물넣기.
				exec spu_SetDirectItemNew @gameid, @info, 1, 3, @rtn_ = @anilistidx OUTPUT
				select @upcnt = upcnt, @upstepmax = upstepmax  from dbo.tUserItem where gameid = @gameid and listidx = @anilistidx
				set @upstepmax2 = @kind * (@upstepmax / 8 )

				select @cellgrade = grade from dbo.tItemInfo where itemcode = @info
				set @cellgrademin = case
										when @cellgrade <= 0  then 1
										when @cellgrade <= 1  then 1
										when @cellgrade <= 2  then 2-1
										when @cellgrade <= 3  then 2-1
										when @cellgrade <= 4  then 2-1
										when @cellgrade <= 5  then 3-1
										when @cellgrade <= 6  then 3-1
										when @cellgrade <= 7  then 4-1
										when @cellgrade <= 8  then 4-1
										when @cellgrade <= 9  then 5-1
										when @cellgrade <= 10 then 5-1
										else					   1
								end
				set @cellgrademax = case
										when @cellgrade <= 0  then 1
										when @cellgrade <= 1  then 1
										when @cellgrade <= 2  then 2
										when @cellgrade <= 3  then 2
										when @cellgrade <= 4  then 2
										when @cellgrade <= 5  then 3
										when @cellgrade <= 6  then 3
										when @cellgrade <= 7  then 4
										when @cellgrade <= 8  then 4
										when @cellgrade <= 9  then 5
										when @cellgrade <= 10 then 5
										else					   1
								end
				--select 'DEBUG ', @upcnt upcnt, @upstepmax upstepmax, @upstepmax2 upstepmax2, @kind kind, @info itemcode, @cellgrademin cellgrademin, @cellgrademax cellgrademax


				while(@upcnt < @upstepmax2)
					begin
						-- 줄기세포 찾아서서 강화..
						select top 1 @stemcellitemcode = itemcode from dbo.tItemInfo where category = 1040 and grade >= @cellgrademin and grade <= @cellgrademax order by newid()
						exec spu_SetDirectItemNew @gameid, @stemcellitemcode, 1, 3, @rtn_ = @celllistidx OUTPUT


						-- 동물에 줄기세포 강화.
						update dbo.tUserMaster set gamecost = 1000000, heart = 100000 where gameid = @gameid
						set @rand 		= Convert(int, ceiling(RAND() * 10000))
						set @listset2	= '0:' + ltrim(rtrim(str(@celllistidx))) + ';'
						exec spu_AniUpgrade @gameid, @password, @anilistidx, @listset2, @rand, -1

						set @upcnt = @upcnt + 1
					end

				Fetch next from curApartItemcode into @kind, @info
			end
		-- 4. 커서닫기
		close curApartItemcode
		Deallocate curApartItemcode

		Fetch next from curUserInfo into @gameid
	end

-- 3-4. 커서닫기
close curUserInfo
Deallocate curUserInfo