use GameMTBaseball
GO

-- ���������ϱ�.
declare @kakaouserid	varchar(60)
declare @gameid			varchar(20) 	set @gameid		= ''
declare @password		varchar(20) 	set @password	= ''
declare @kakaostatus	int				set @kakaostatus=  1
declare @deletestate	int				set @deletestate= -1
declare @anilistidx 	int				set @anilistidx = -1	-- ����.
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
--set @kakaouserid = '88470968441492992'	-- �Ӱ�����

select @gameid = gameid from dbo.tKakaoMaster where kakaouserid = @kakaouserid
select @deletestate = deletestate, @kakaostatus = kakaostatus, @password = password from dbo.tUserMaster where gameid = @gameid
if( @gameid = '' or @kakaostatus != 1 or @deletestate != 0 )
	begin
		select 'DEBUG ���� ������ Ȱ���Ȱ����� ����.'
	end
--delete from dbo.tGiftList where gameid = @gameid										-- �����ʱ�ȭ
delete from dbo.tUserItem where gameid = @gameid and invenkind in (1, 1040, 36)		-- ������ ����
--delete from dbo.tPromoteLogPerson where gameid = @gameid								-- �ΰ����
update dbo.tUserFarm set buystate  = 1, playcnt = 10, star = 3 where gameid = @gameid	-- ���屸�Ż���.
exec spu_SetDirectItemNew @gameid, 3600, 999999, 1, -1									-- �±�Ƽ��
update dbo.tUserMaster set cashcost = 100000, gamecost = 99100000, heart = 100000, randserial = -1, battleticket = 9999 where gameid = @gameid

	------------------------------------
	-- ���޵���.
	-- ����:����;
	------------------------------------
	--set @listset = '0:1;0:2;'			-- �±��׽�Ʈ.
	--set @listset = '0:1;0:2;0:3;0:4;0:5;0:6;0:7;0:8;0:9;0:10;'			-- �±��׽�Ʈ.
	--set @listset = '0:11;0:12;0:13;0:14;0:15;0:16;0:17;0:18;0:19;0:20;'	-- �±��׽�Ʈ.
	--set @listset = '0:21;0:22;0:23;0:24;0:25;0:26;0:27;0:28;0:29;'		-- �±��׽�Ʈ.
	--set @listset = '0:100;0:101;0:102;0:103;0:104;0:105;0:106;0:107;0:108;0:109;0:110;'	-- �±��׽�Ʈ.
	--set @listset = '0:111;0:112;0:113;0:114;0:115;0:116;0:117;0:118;0:119;0:120;'		-- �±��׽�Ʈ.
	--set @listset = '0:121;0:122;0:123;0:124;0:125;0:126;0:127;0:128;0:129;0:130;'		-- �±��׽�Ʈ.
	--set @listset = '0:200;0:201;0:202;0:203;0:204;0:205;0:206;0:207;0:208;0:209;0:210;'	-- �±��׽�Ʈ.
	--set @listset = '0:211;0:212;0:213;0:214;0:215;0:216;0:217;0:218;0:219;0:220;'		-- �±��׽�Ʈ.
	--set @listset = '0:221;0:222;0:223;0:224;0:225;0:226;0:227;0:228;0:229;0:230;'		-- �±��׽�Ʈ.

	set @listset = '0:1;0:2;0:3;0:4;0:5;0:6;0:7;0:8;0:9;0:10;0:11;0:12;0:13;0:14;0:15;0:16;0:17;0:18;0:19;0:20;0:21;0:22;0:23;0:24;0:25;0:26;0:27;0:28;0:29;0:100;0:101;0:102;0:103;0:104;0:105;0:106;0:107;0:108;0:109;0:110;0:111;0:112;0:113;0:114;0:115;0:116;0:117;0:118;0:119;0:120;0:121;0:122;0:123;0:124;0:125;0:126;0:127;0:128;0:129;0:130;0:200;0:201;0:202;0:203;0:204;0:205;0:206;0:207;0:208;0:209;0:210;0:211;0:212;0:213;0:214;0:215;0:216;0:217;0:218;0:219;0:220;0:221;0:222;0:223;0:224;0:225;0:226;0:227;0:228;0:229;0:230;'		-- �±��׽�Ʈ.
	set @listset = replace(@listset, '0:', '8:');

	-- 1. Ŀ�� ����
	declare curApartItemcode Cursor for
	select * FROM dbo.fnu_SplitTwo(';', ':', @listset)

	-- 2. Ŀ������
	open curApartItemcode

	-- 3. Ŀ�� ���
	Fetch next from curApartItemcode into @kind, @info
	while @@Fetch_status = 0
		Begin
			-- �±� ������ �ʿ��� ������ ���� Ȯ��.
			set @needcnt 	= 0
			set @needcnt2	= 0
			select @itemcode = itemcode, @needcnt = param4, @needcnt2 = param4 from dbo.tItemInfo
			where subcategory = 1020 and ( param5 = @info or param6 = @info or param7 = @info or param8 = @info or param9 = @info)

			-- �����ֱ�.
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

			-- �±��ϱ�.
			set @rand 		= Convert(int, ceiling(RAND() * 10000))
			--exec spu_AniPromote @gameid, @password, @itemcode, @listidxs1, @listidxs2, @listidxs3, @listidxs4, @listidxs5, @rand, -1	-- 2����

			--select 'DEBUG ', @kind, @info
			set @loop = @loop + 1
			Fetch next from curApartItemcode into @kind, @info
		end
	-- 4. Ŀ���ݱ�
	close curApartItemcode
	Deallocate curApartItemcode


