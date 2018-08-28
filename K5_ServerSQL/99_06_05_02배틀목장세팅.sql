use GameMTBaseball
GO
declare @enemyani	int,
		@enemylv	int,
		@enemycnt	int,
		@stagecnt	int,
		@enemyboss	int

delete from dbo.tItemInfo where itemcode in (6926, 6927, 6928, 6929)
set @enemyani	= 4
set @enemylv	= 10


set @enemycnt	= 6
set @stagecnt	= 5
set @enemyboss	= 3
insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14, param15, param16, param17, param18, param19, param20, param21, param22, param23, param24, param25, param26, param27, param28, param29, param30)
--values('farmworld', '6926', '69', '69', '0', '¸ùÃÌ ¸ñÀå', '1', '-1', '0', '0', '16', '27', '0', '18500', '0', '1', '18500', '¸ùÃÌ ¸ñÀå', '180', '450', '2015', '5', '188;-68', '12', '6925', '107', '2000', '0', '5000', '50', '55', '5', '4', '3', '27', '12', '5', '0', '10', '14', '104031', '104032', '104035', '104036', '1', '72', '60', '90')
values(                   'farmworld', '6926',     '69',         '69',     '0', '¿Â¼ö ¸ñÀå',   '1',    '-1',   '0',      '0', '16',      '1',     '0',    '900',      '0',       '1',    '900',  '¿Â¼ö ¸ñÀå',  '30',   '60', '2015',    '5', '-244;28', '1',   '-1',   '-1',   '-1',     '0',    '-1',     '0',    '30',     '3',     '0', @enemyani, @enemylv, @enemycnt, @stagecnt,@enemyboss,     '0',     '3','104010','104011','104005','104016',     '1',    '20',    '60',    '90')

set @enemycnt	= 11
set @stagecnt	= 5
set @enemyboss	= 3
insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14, param15, param16, param17, param18, param19, param20, param21, param22, param23, param24, param25, param26, param27, param28, param29, param30)
--values('farmworld', '6927', '69', '69', '0', '±¸·æ ¸ñÀå', '1', '-1', '0', '0', '16', '28', '0', '19500', '0', '1', '19500', '±¸·æ ¸ñÀå', '195', '465', '2015', '5', '-11;-156', '206', '6926', '101', '500', '0', '5000', '50', '55', '5', '1', '5', '28', '12', '6', '0', '10', '15', '104032', '104033', '104035', '104036', '1', '74', '60', '90')
values(                   'farmworld', '6927',     '69',        '69',      '0', 'Ãµ¿Õ ¸ñÀå',   '1',    '-1',   '0',      '0', '16',      '2',     '0',   '1000',      '0',       '1',   '1200', 'Ãµ¿Õ ¸ñÀå',   '30',   '75', '2015',    '5', '-182;71', '2', '6900',  '101',    '5',     '0',  '5000',    '25',    '30',     '3',     '0', @enemyani, @enemylv, @enemycnt, @stagecnt,@enemyboss,     '0',     '3','104011','104012','104005','104016',     '1',    '22',    '60',    '90')

set @enemycnt	= 16
set @stagecnt	= 5
set @enemyboss	= 3
insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14, param15, param16, param17, param18, param19, param20, param21, param22, param23, param24, param25, param26, param27, param28, param29, param30)
--values('farmworld', '6928', '69', '69', '0', 'ºÀÃµ ¸ñÀå', '1', '-1', '0', '0', '16', '29', '0', '20500', '0', '1', '20500', 'ºÀÃµ ¸ñÀå', '210', '480', '2015', '5', '49;-132', '207', '6927', '103', '100', '0', '5000', '50', '55', '5', '1', '6', '29', '13', '4', '0', '11', '15', '104033', '104034', '104035', '104036', '1', '76', '60', '90')
values('farmworld', '6928', '69', '69', '0', '±¤¸í ¸ñÀå', '1', '-1', '0', '0', '16',  '3', '0',  '1400', '0', '1',  '1600', '±¤¸í ¸ñÀå', '30', '90',   '2015', '5', '-165;4',   '3',  '6901', '103',   '5', '0', '5000', '25', '30', '3', '0', @enemyani, @enemylv, @enemycnt, @stagecnt,@enemyboss,     '0', '3', '104012', '104013', '104005', '104016', '1', '24', '60', '90')

set @enemycnt	= 4
set @stagecnt	= 2
set @enemyboss	= 16
insert into dbo.tItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14, param15, param16, param17, param18, param19, param20, param21, param22, param23, param24, param25, param26, param27, param28, param29, param30)
--values('farmworld', '6929', '69', '69', '0', '½Å¼±Áö ¸ñÀå', '1', '-1', '0', '0', '16', '30', '0', '21500', '0', '1', '21500', '½Å¼±Áö ¸ñÀå', '225', '495', '2015', '5', '77;-175', '109', '6928', '100', '50', '0', '5000', '50', '55', '5', '2', '3', '30', '13', '5', '0', '11', '16', '104034', '104030', '104035', '104036', '1', '78', '60', '90')
values('farmworld', '6929', '69', '69', '0', 'Ã¶»ê ¸ñÀå', '1', '-1', '0', '0', '16', '4', '0', '1800', '0', '1', '2100', 'Ã¶»ê ¸ñÀå', '45', '105', '2015', '5', '-127;125', '100', '6902', '100', '5', '0', '5000', '25', '30', '3', '0', @enemyani, @enemylv, @enemycnt, @stagecnt,@enemyboss,     '1', '4', '104013', '104014', '104005', '104016', '1', '26', '60', '90')

