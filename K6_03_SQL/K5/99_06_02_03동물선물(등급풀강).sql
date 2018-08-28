use GameMTBaseball
GO

-- ���������ϱ�.
declare @kakaouserid	varchar(60)
declare @gameid			varchar(20) 	set @gameid		= ''
declare @password		varchar(20) 	set @password	= ''
declare @itemcode		int
declare @kakaostatus	int				set @kakaostatus=  1
declare @deletestate	int				set @deletestate= -1
declare @anilistidx 	int				set @anilistidx = -1	-- ����.
declare @celllistidx 	int				set @celllistidx = -1	-- �ٱ⼼��.
declare @listset		varchar(2560)
declare @kind			int
declare @info			int
declare @upcnt			int
declare @upstepmax		int
declare @upstepmax2		int
declare @stemcellitemcode	int
declare @rand			int
declare @upsteplvcnt	int
declare @listset2		varchar(2560)
declare @cellgrade		int					set @cellgrade = 3-2

set @kakaouserid	= '88470968441492993'	-- PC
--set @kakaouserid	= '88258263875124913'	-- �����ڵ���
--set @kakaouserid = '91188455545412245'	--��ö
--set @kakaouserid = '88470968441492992'	-- �Ӱ�����
--set @kakaouserid = '91188455545412246'	-- ����


select @gameid = gameid from dbo.tKakaoMaster where kakaouserid = @kakaouserid
select @deletestate = deletestate, @kakaostatus = kakaostatus, @password = password from dbo.tUserMaster where gameid = @gameid
if( @gameid = '' or @kakaostatus != 1 or @deletestate != 0 )
	begin
		select 'DEBUG ���� ������ Ȱ���Ȱ����� ����.'
	end
delete from dbo.tGiftList where gameid = @gameid								-- �����ʱ�ȭ
delete from dbo.tUserItem where gameid = @gameid and invenkind in (1, 1040)		-- ������ ����
update dbo.tUserGameMTBaseball set buystate  = 1, playcnt = 10, star = 3 where gameid = @gameid		-- ���屸�Ż���.
update dbo.tUserMaster set battleticket = 9999 where gameid = @gameid

	------------------------------------
	-- ���޵���.
	--	����:����;
	------------------------------------
	--set @listset = '0:1;0:2;0:4;0:7;0:10;0:13;0:16;0:20;0:26;0:125;0:222;0:224;'
	--set @listset = '4:1;4:2;4:4;4:7;4:10;4:13;4:16;4:20;4:26;4:125;4:222;4:224;'
	--set @listset = '8:1;8:2;8:4;8:7;8:10;8:13;8:16;8:20;8:26;8:125;8:222;8:224;'
	--set @listset = '0:2;0:4;0:9;0:18;0:100;0:101;0:103;0:113;0:114;0:200;0:202;0:209;0:210;0:213;0:20;0:115;0:213;0:115;0:16;0:19;0:114;'
	--set @listset = '8:2;8:4;8:9;8:18;8:100;8:101;8:103;8:113;8:114;8:200;8:202;8:209;8:210;8:213;8:20;8:115;8:213;8:115;8:16;8:19;8:114;'
	--set @listset = '0:16;0:17;0:115;0:117;0:215;0:217;'				-- ����� ������.
	--set @listset = '5:1;0:1;0:1;5:2;0:2;0:2;5:2;0:2;0:2;5:2;0:2;0:2;'	-- �ռ��׽�Ʈ.
	--set @listset = '0:27;0:1;0:1;0:2;0:2;0:2;0:2;0:2;0:2;0:2;0:2;0:2;'	-- �±��׽�Ʈ.
	-- ����(0)
	-- �Ϲ�(1)
	-- ���(2)
	-- ���(3)
	-- Ȳ��(4)
	-- ����(5)
	-- ����(6)
	-- ����(7)
	-- ����(8)
	-- ����(9)
	-- ��ȭ(10)
	set @listset = '0:4;0:5;0:6;0:102;0:103;0:200;0:201;0:202;0:7;0:8;0:9;0:104;0:105;0:203;0:204;0:10;0:11;0:12;0:106;0:107;0:108;0:205;'
	--set @listset = '0:1;0:2;0:3;0:100;0:101;0:4;0:5;0:6;0:102;0:103;0:200;0:201;0:202;0:7;0:8;0:9;0:104;0:105;0:203;0:204;0:10;0:11;0:12;0:106;0:107;0:108;0:205;0:13;0:14;0:15;0:109;0:110;0:111;0:206;0:207;0:208;0:16;0:17;0:18;0:19;0:112;0:113;0:114;0:115;0:209;0:210;0:211;0:20;0:21;0:22;0:23;0:24;0:25;0:116;0:117;0:118;0:119;0:120;0:212;0:213;0:214;0:215;0:26;0:27;0:28;0:29;0:121;0:122;0:123;0:124;0:216;0:217;0:218;0:219;0:125;0:126;0:127;0:220;0:221;0:222;0:223;0:224;0:225;0:226;0:227;'
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
			-- �ʱ�ȭ�ϱ�.
			set @upstepmax = 0

			-- �����ֱ�.
			exec spu_SetDirectItemNew @gameid, @info, 1, 3, @rtn_ = @anilistidx OUTPUT
			select @upcnt = upcnt, @upstepmax = upstepmax  from dbo.tUserItem where gameid = @gameid and listidx = @anilistidx
			set @upstepmax2 = @kind * (@upstepmax / 8 )
			--select 'DEBUG ', @upcnt upcnt, @upstepmax upstepmax, @upstepmax2 upstepmax2, @kind kind

			while(@upcnt < @upstepmax2)
				begin
					-- �ٱ⼼�� ã�Ƽ��� ��ȭ..
					select top 1 @stemcellitemcode = itemcode from dbo.tItemInfo where category = 1040 and grade <= @cellgrade order by newid()
					exec spu_SetDirectItemNew @gameid, @stemcellitemcode, 1, 3, @rtn_ = @celllistidx OUTPUT


					-- ������ �ٱ⼼�� ��ȭ.
					update dbo.tUserMaster set gamecost = 1000000, heart = 100000 where gameid = @gameid
					set @rand 		= Convert(int, ceiling(RAND() * 10000))
					set @listset2	= '0:' + ltrim(rtrim(str(@celllistidx))) + ';'
					exec spu_AniUpgrade @gameid, @password, @anilistidx, @listset2, @rand, -1

					set @upcnt = @upcnt + 1
				end

			Fetch next from curApartItemcode into @kind, @info
		end
	-- 4. Ŀ���ݱ�
	close curApartItemcode
	Deallocate curApartItemcode

