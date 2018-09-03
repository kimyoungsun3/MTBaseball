use Game4FarmVill3
GO
--select * from dbo.tFVItemInfo where category = 80
delete from dbo.tFVItemInfo where category = 80

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80010',     '80',        '80',     '30', 	'³ó»ç²ÛÀÇ ¹ÐÂ¤¸ðÀÚD',       	 '1',     '0', '1 ',      '0', 'treasure01',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀÏ²Û ÃËÁøÁ¦ ÄðÅ¸ÀÓ °¨¼Ò', 	    500,	 200,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80011',     '80',        '80',     '30', 	'³ó»ç²ÛÀÇ ¹ÐÂ¤¸ðÀÚC',       	 '1',     '0', '2 ',      '0', 'treasure01',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀÏ²Û ÃËÁøÁ¦ ÄðÅ¸ÀÓ °¨¼Ò', 	    1000,	 500,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80012',     '80',        '80',     '30', 	'³ó»ç²ÛÀÇ ¹ÐÂ¤¸ðÀÚB',       	 '1',     '0', '3 ',      '0', 'treasure01',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀÏ²Û ÃËÁøÁ¦ ÄðÅ¸ÀÓ °¨¼Ò', 	    3000,	 2200,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80013',     '80',        '80',     '30', 	'³ó»ç²ÛÀÇ ¹ÐÂ¤¸ðÀÚA',       	 '1',     '0', '4 ',      '0', 'treasure01',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀÏ²Û ÃËÁøÁ¦ ÄðÅ¸ÀÓ °¨¼Ò', 	    8000,	 5000,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80014',     '80',        '80',     '30', 	'³ó»ç²ÛÀÇ ¹ÐÂ¤¸ðÀÚS',       	 '1',     '0', '5 ',      '0', 'treasure01',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀÏ²Û ÃËÁøÁ¦ ÄðÅ¸ÀÓ °¨¼Ò', 	    12000,	 9000,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80020',     '80',        '80',     '30', 	'¹Ù±î½ºD',       	 '1',     '0', '1 ',      '0', 'treasure02',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀÏ²Û ÃËÁøÁ¦ Áö¼Ó½Ã°£ Áõ°¡', 	    500,	 200,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80021',     '80',        '80',     '30', 	'¹Ù±î½ºC',       	 '1',     '0', '2 ',      '0', 'treasure02',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀÏ²Û ÃËÁøÁ¦ Áö¼Ó½Ã°£ Áõ°¡', 	    1000,	 500,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80022',     '80',        '80',     '30', 	'¹Ù±î½ºB',       	 '1',     '0', '3 ',      '0', 'treasure02',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀÏ²Û ÃËÁøÁ¦ Áö¼Ó½Ã°£ Áõ°¡', 	    3000,	 1200,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80023',     '80',        '80',     '30', 	'¹Ù±î½ºA',       	 '1',     '0', '4 ',      '0', 'treasure02',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀÏ²Û ÃËÁøÁ¦ Áö¼Ó½Ã°£ Áõ°¡', 	    8000,	 3000,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80024',     '80',        '80',     '30', 	'¹Ù±î½ºS',       	 '1',     '0', '5 ',      '0', 'treasure02',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀÏ²Û ÃËÁøÁ¦ Áö¼Ó½Ã°£ Áõ°¡', 	    12000,	 6000,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80030',     '80',        '80',     '30', 	'³ó»ç²ÛÀÇ Àå°©D',       	 '1',     '0', '1 ',      '0', 'treasure03',      '0',     '0',      '0',      '0',       '0',    '100',  				'ºñ·á ºÎ¼­ÅÍ ÄðÅ¸ÀÓ °¨¼Ò', 	    500,	 200,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80031',     '80',        '80',     '30', 	'³ó»ç²ÛÀÇ Àå°©C',       	 '1',     '0', '2 ',      '0', 'treasure03',      '0',     '0',      '0',      '0',       '0',    '100',  				'ºñ·á ºÎ¼­ÅÍ ÄðÅ¸ÀÓ °¨¼Ò', 	    1000,	 500,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80032',     '80',        '80',     '30', 	'³ó»ç²ÛÀÇ Àå°©B',       	 '1',     '0', '3 ',      '0', 'treasure03',      '0',     '0',      '0',      '0',       '0',    '100',  				'ºñ·á ºÎ¼­ÅÍ ÄðÅ¸ÀÓ °¨¼Ò', 	    3000,	 2200,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80033',     '80',        '80',     '30', 	'³ó»ç²ÛÀÇ Àå°©A',       	 '1',     '0', '4 ',      '0', 'treasure03',      '0',     '0',      '0',      '0',       '0',    '100',  				'ºñ·á ºÎ¼­ÅÍ ÄðÅ¸ÀÓ °¨¼Ò', 	    8000,	 5000,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80034',     '80',        '80',     '30', 	'³ó»ç²ÛÀÇ Àå°©S',       	 '1',     '0', '5 ',      '0', 'treasure03',      '0',     '0',      '0',      '0',       '0',    '100',  				'ºñ·á ºÎ¼­ÅÍ ÄðÅ¸ÀÓ °¨¼Ò', 	    12000,	 9000,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80040',     '80',        '80',     '30', 	'½Ï³­ °¨ÀÚD',       	 '1',     '0', '1 ',      '0', 'treasure04',      '0',     '0',      '0',      '0',       '0',    '100',  				'ºñ·á ºÎ¼­ÅÍ Áö¼Ó½Ã°£ Áõ°¡', 	    500,	 200,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80041',     '80',        '80',     '30', 	'½Ï³­ °¨ÀÚC',       	 '1',     '0', '2 ',      '0', 'treasure04',      '0',     '0',      '0',      '0',       '0',    '100',  				'ºñ·á ºÎ¼­ÅÍ Áö¼Ó½Ã°£ Áõ°¡', 	    1000,	 500,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80042',     '80',        '80',     '30', 	'½Ï³­ °¨ÀÚB',       	 '1',     '0', '3 ',      '0', 'treasure04',      '0',     '0',      '0',      '0',       '0',    '100',  				'ºñ·á ºÎ¼­ÅÍ Áö¼Ó½Ã°£ Áõ°¡', 	    3000,	 1200,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80043',     '80',        '80',     '30', 	'½Ï³­ °¨ÀÚA',       	 '1',     '0', '4 ',      '0', 'treasure04',      '0',     '0',      '0',      '0',       '0',    '100',  				'ºñ·á ºÎ¼­ÅÍ Áö¼Ó½Ã°£ Áõ°¡', 	    8000,	 3000,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80044',     '80',        '80',     '30', 	'½Ï³­ °¨ÀÚS',       	 '1',     '0', '5 ',      '0', 'treasure04',      '0',     '0',      '0',      '0',       '0',    '100',  				'ºñ·á ºÎ¼­ÅÍ Áö¼Ó½Ã°£ Áõ°¡', 	    12000,	 6000,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80050',     '80',        '80',     '30', 	'¾çÄ¡±â ¼Ò³âÀÇ ÇÇ¸®D',       	 '1',     '0', '1 ',      '0', 'treasure05',      '0',     '0',      '0',      '0',       '0',    '100',  				'µ¿¹° ½ºÆÀÆå ÄðÅ¸ÀÓ °¨¼Ò', 	    500,	 200,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80051',     '80',        '80',     '30', 	'¾çÄ¡±â ¼Ò³âÀÇ ÇÇ¸®C',       	 '1',     '0', '2 ',      '0', 'treasure05',      '0',     '0',      '0',      '0',       '0',    '100',  				'µ¿¹° ½ºÆÀÆå ÄðÅ¸ÀÓ °¨¼Ò', 	    1000,	 500,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80052',     '80',        '80',     '30', 	'¾çÄ¡±â ¼Ò³âÀÇ ÇÇ¸®B',       	 '1',     '0', '3 ',      '0', 'treasure05',      '0',     '0',      '0',      '0',       '0',    '100',  				'µ¿¹° ½ºÆÀÆå ÄðÅ¸ÀÓ °¨¼Ò', 	    3000,	 2200,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80053',     '80',        '80',     '30', 	'¾çÄ¡±â ¼Ò³âÀÇ ÇÇ¸®A',       	 '1',     '0', '4 ',      '0', 'treasure05',      '0',     '0',      '0',      '0',       '0',    '100',  				'µ¿¹° ½ºÆÀÆå ÄðÅ¸ÀÓ °¨¼Ò', 	    8000,	 5000,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80054',     '80',        '80',     '30', 	'¾çÄ¡±â ¼Ò³âÀÇ ÇÇ¸®S',       	 '1',     '0', '5 ',      '0', 'treasure05',      '0',     '0',      '0',      '0',       '0',    '100',  				'µ¿¹° ½ºÆÀÆå ÄðÅ¸ÀÓ °¨¼Ò', 	    12000,	 9000,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80060',     '80',        '80',     '30', 	'»ê»ï ÀÎÇüD',       	 '1',     '0', '1 ',      '0', 'treasure06',      '0',     '0',      '0',      '0',       '0',    '100',  				'µ¿¹° ½ºÆÀÆå Áö¼Ó½Ã°£ Áõ°¡', 	    500,	 200,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80061',     '80',        '80',     '30', 	'»ê»ï ÀÎÇüC',       	 '1',     '0', '2 ',      '0', 'treasure06',      '0',     '0',      '0',      '0',       '0',    '100',  				'µ¿¹° ½ºÆÀÆå Áö¼Ó½Ã°£ Áõ°¡', 	    1000,	 500,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80062',     '80',        '80',     '30', 	'»ê»ï ÀÎÇüB',       	 '1',     '0', '3 ',      '0', 'treasure06',      '0',     '0',      '0',      '0',       '0',    '100',  				'µ¿¹° ½ºÆÀÆå Áö¼Ó½Ã°£ Áõ°¡', 	    3000,	 1200,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80063',     '80',        '80',     '30', 	'»ê»ï ÀÎÇüA',       	 '1',     '0', '4 ',      '0', 'treasure06',      '0',     '0',      '0',      '0',       '0',    '100',  				'µ¿¹° ½ºÆÀÆå Áö¼Ó½Ã°£ Áõ°¡', 	    8000,	 3000,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80064',     '80',        '80',     '30', 	'»ê»ï ÀÎÇüS',       	 '1',     '0', '5 ',      '0', 'treasure06',      '0',     '0',      '0',      '0',       '0',    '100',  				'µ¿¹° ½ºÆÀÆå Áö¼Ó½Ã°£ Áõ°¡', 	    12000,	 6000,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80070',     '80',        '80',     '30', 	'³ó»ç²ÛÀÇ ¸ðÁ¾»ðD',       	 '1',     '0', '1 ',      '0', 'treasure07',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀÏ²Û °ÇÃÊ ½É±â ÄðÅ¸ÀÓ °¨¼Ò', 	    100,	 30,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80071',     '80',        '80',     '30', 	'³ó»ç²ÛÀÇ ¸ðÁ¾»ðC',       	 '1',     '0', '2 ',      '0', 'treasure07',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀÏ²Û °ÇÃÊ ½É±â ÄðÅ¸ÀÓ °¨¼Ò', 	    200,	 50,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80072',     '80',        '80',     '30', 	'³ó»ç²ÛÀÇ ¸ðÁ¾»ðB',       	 '1',     '0', '3 ',      '0', 'treasure07',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀÏ²Û °ÇÃÊ ½É±â ÄðÅ¸ÀÓ °¨¼Ò', 	    300,	 100,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80073',     '80',        '80',     '30', 	'³ó»ç²ÛÀÇ ¸ðÁ¾»ðA',       	 '1',     '0', '4 ',      '0', 'treasure07',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀÏ²Û °ÇÃÊ ½É±â ÄðÅ¸ÀÓ °¨¼Ò', 	    500,	 150,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80074',     '80',        '80',     '30', 	'³ó»ç²ÛÀÇ ¸ðÁ¾»ðS',       	 '1',     '0', '5 ',      '0', 'treasure07',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀÏ²Û °ÇÃÊ ½É±â ÄðÅ¸ÀÓ °¨¼Ò', 	    750,	 250,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80080',     '80',        '80',     '30', 	'Äá³ª¹° È­ºÐD',       	 '1',     '0', '1 ',      '0', 'treasure08',      '0',     '0',      '0',      '0',       '0',    '100',  				'°ÇÃÊ ¼ºÀå¼Óµµ °¨¼Ò', 	    500,	 200,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80081',     '80',        '80',     '30', 	'Äá³ª¹° È­ºÐC',       	 '1',     '0', '2 ',      '0', 'treasure08',      '0',     '0',      '0',      '0',       '0',    '100',  				'°ÇÃÊ ¼ºÀå¼Óµµ °¨¼Ò', 	    1000,	 400,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80082',     '80',        '80',     '30', 	'Äá³ª¹° È­ºÐB',       	 '1',     '0', '3 ',      '0', 'treasure08',      '0',     '0',      '0',      '0',       '0',    '100',  				'°ÇÃÊ ¼ºÀå¼Óµµ °¨¼Ò', 	    2000,	 500,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80083',     '80',        '80',     '30', 	'Äá³ª¹° È­ºÐA',       	 '1',     '0', '4 ',      '0', 'treasure08',      '0',     '0',      '0',      '0',       '0',    '100',  				'°ÇÃÊ ¼ºÀå¼Óµµ °¨¼Ò', 	    5000,	 700,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80084',     '80',        '80',     '30', 	'Äá³ª¹° È­ºÐS',       	 '1',     '0', '5 ',      '0', 'treasure08',      '0',     '0',      '0',      '0',       '0',    '100',  				'°ÇÃÊ ¼ºÀå¼Óµµ °¨¼Ò', 	    10000,	 1500,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80090',     '80',        '80',     '30', 	'¿À·¡µÈ ¶óµð¿ÀD',       	 '1',     '0', '1 ',      '0', 'treasure09',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀÏ²Û °ÇÃÊ ¼öÈ® ÄðÅ¸ÀÓ °¨¼Ò', 	    100,	 30,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80091',     '80',        '80',     '30', 	'¿À·¡µÈ ¶óµð¿ÀC',       	 '1',     '0', '2 ',      '0', 'treasure09',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀÏ²Û °ÇÃÊ ¼öÈ® ÄðÅ¸ÀÓ °¨¼Ò', 	    200,	 50,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80092',     '80',        '80',     '30', 	'¿À·¡µÈ ¶óµð¿ÀB',       	 '1',     '0', '3 ',      '0', 'treasure09',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀÏ²Û °ÇÃÊ ¼öÈ® ÄðÅ¸ÀÓ °¨¼Ò', 	    300,	 80,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80093',     '80',        '80',     '30', 	'¿À·¡µÈ ¶óµð¿ÀA',       	 '1',     '0', '4 ',      '0', 'treasure09',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀÏ²Û °ÇÃÊ ¼öÈ® ÄðÅ¸ÀÓ °¨¼Ò', 	    500,	 150,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80094',     '80',        '80',     '30', 	'¿À·¡µÈ ¶óµð¿ÀS',       	 '1',     '0', '5 ',      '0', 'treasure09',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀÏ²Û °ÇÃÊ ¼öÈ® ÄðÅ¸ÀÓ °¨¼Ò', 	    750,	 250,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80100',     '80',        '80',     '30', 	'º¹µÅÁö Àú±ÝÅëD',       	 '1',     '0', '1',      '0', 'treasure33',      '0',     '0',      '0',      '0',       '0',    '100',  				'À¯Á¦Ç° ÆÇ¸Å½Ã ÄÚÀÎÈ¹µæ Áõ°¡', 	    5,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80101',     '80',        '80',     '30', 	'º¹µÅÁö Àú±ÝÅëC',       	 '1',     '0', '2',      '0', 'treasure33',      '0',     '0',      '0',      '0',       '0',    '100',  				'À¯Á¦Ç° ÆÇ¸Å½Ã ÄÚÀÎÈ¹µæ Áõ°¡', 	    10,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80102',     '80',        '80',     '30', 	'º¹µÅÁö Àú±ÝÅëB',       	 '1',     '0', '3',      '0', 'treasure33',      '0',     '0',      '0',      '0',       '0',    '100',  				'À¯Á¦Ç° ÆÇ¸Å½Ã ÄÚÀÎÈ¹µæ Áõ°¡', 	    20,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80103',     '80',        '80',     '30', 	'º¹µÅÁö Àú±ÝÅëA',       	 '1',     '0', '4',      '0', 'treasure33',      '0',     '0',      '0',      '0',       '0',    '100',  				'À¯Á¦Ç° ÆÇ¸Å½Ã ÄÚÀÎÈ¹µæ Áõ°¡', 	    40,	 4,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80104',     '80',        '80',     '30', 	'º¹µÅÁö Àú±ÝÅëS',       	 '1',     '0', '5',      '0', 'treasure33',      '0',     '0',      '0',      '0',       '0',    '100',  				'À¯Á¦Ç° ÆÇ¸Å½Ã ÄÚÀÎÈ¹µæ Áõ°¡', 	    60,	 7,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80110',     '80',        '80',     '30', 	'ºó ¿ìÀ¯º´D',       	 '1',     '0', '1',      '0', 'treasure36',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÅÊÅ©ÀÇ º¸°ü·® Áõ°¡', 	    1,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80111',     '80',        '80',     '30', 	'ºó ¿ìÀ¯º´C',       	 '1',     '0', '2',      '0', 'treasure36',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÅÊÅ©ÀÇ º¸°ü·® Áõ°¡', 	    2,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80112',     '80',        '80',     '30', 	'ºó ¿ìÀ¯º´B',       	 '1',     '0', '3',      '0', 'treasure36',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÅÊÅ©ÀÇ º¸°ü·® Áõ°¡', 	    3,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80113',     '80',        '80',     '30', 	'ºó ¿ìÀ¯º´A',       	 '1',     '0', '4',      '0', 'treasure36',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÅÊÅ©ÀÇ º¸°ü·® Áõ°¡', 	    4,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80114',     '80',        '80',     '30', 	'ºó ¿ìÀ¯º´S',       	 '1',     '0', '5',      '0', 'treasure36',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÅÊÅ©ÀÇ º¸°ü·® Áõ°¡', 	    5,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80120',     '80',        '80',     '30', 	'¿Á¼ö¼öÀÚ·çD',       	 '1',     '0', '1',      '0', 'treasure37',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ã¢°íÀÇ º¸°ü·® Áõ°¡', 	    1,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80121',     '80',        '80',     '30', 	'¿Á¼ö¼öÀÚ·çC',       	 '1',     '0', '2',      '0', 'treasure37',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ã¢°íÀÇ º¸°ü·® Áõ°¡', 	    2,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80122',     '80',        '80',     '30', 	'¿Á¼ö¼öÀÚ·çB',       	 '1',     '0', '3',      '0', 'treasure37',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ã¢°íÀÇ º¸°ü·® Áõ°¡', 	    5,	 4,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80123',     '80',        '80',     '30', 	'¿Á¼ö¼öÀÚ·çA',       	 '1',     '0', '4',      '0', 'treasure37',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ã¢°íÀÇ º¸°ü·® Áõ°¡', 	    10,	 7,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80124',     '80',        '80',     '30', 	'¿Á¼ö¼öÀÚ·çS',       	 '1',     '0', '5',      '0', 'treasure37',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ã¢°íÀÇ º¸°ü·® Áõ°¡', 	    20,	 10,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80130',     '80',        '80',     '30', 	'¿ìÀ¯ °áÁ¤ ¹ÝÁöD',       	 '1',     '0', '1',      '0', 'treasure34',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ãâ¼®½Ã ÀÏÁ¤È®·ü·Î ¿ìÀ¯°áÁ¤ 10°³¸¦ ÁØ´Ù', 	    1,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80131',     '80',        '80',     '30', 	'¿ìÀ¯ °áÁ¤ ¹ÝÁöC',       	 '1',     '0', '2',      '0', 'treasure34',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ãâ¼®½Ã ÀÏÁ¤È®·ü·Î ¿ìÀ¯°áÁ¤ 10°³¸¦ ÁØ´Ù', 	    3,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80132',     '80',        '80',     '30', 	'¿ìÀ¯ °áÁ¤ ¹ÝÁöB',       	 '1',     '0', '3',      '0', 'treasure34',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ãâ¼®½Ã ÀÏÁ¤È®·ü·Î ¿ìÀ¯°áÁ¤ 10°³¸¦ ÁØ´Ù', 	    10,	 4,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80133',     '80',        '80',     '30', 	'¿ìÀ¯ °áÁ¤ ¹ÝÁöA',       	 '1',     '0', '4',      '0', 'treasure34',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ãâ¼®½Ã ÀÏÁ¤È®·ü·Î ¿ìÀ¯°áÁ¤ 10°³¸¦ ÁØ´Ù', 	    15,	 5,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80134',     '80',        '80',     '30', 	'¿ìÀ¯ °áÁ¤ ¹ÝÁöS',       	 '1',     '0', '5',      '0', 'treasure34',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ãâ¼®½Ã ÀÏÁ¤È®·ü·Î ¿ìÀ¯°áÁ¤ 10°³¸¦ ÁØ´Ù', 	    20,	 10,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80140',     '80',        '80',     '30', 	'Å¥ÇÇÆ® È­»ìD',       	 '1',     '0', '1',      '0', 'treasure35',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ãâ¼®½Ã ÀÏÁ¤È®·ü·Î ÇÏÆ® 10°³¸¦ ÁØ´Ù', 	    10,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80141',     '80',        '80',     '30', 	'Å¥ÇÇÆ® È­»ìC',       	 '1',     '0', '2',      '0', 'treasure35',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ãâ¼®½Ã ÀÏÁ¤È®·ü·Î ÇÏÆ® 10°³¸¦ ÁØ´Ù', 	    11,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80142',     '80',        '80',     '30', 	'Å¥ÇÇÆ® È­»ìB',       	 '1',     '0', '3',      '0', 'treasure35',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ãâ¼®½Ã ÀÏÁ¤È®·ü·Î ÇÏÆ® 10°³¸¦ ÁØ´Ù', 	    12,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80143',     '80',        '80',     '30', 	'Å¥ÇÇÆ® È­»ìA',       	 '1',     '0', '4',      '0', 'treasure35',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ãâ¼®½Ã ÀÏÁ¤È®·ü·Î ÇÏÆ® 10°³¸¦ ÁØ´Ù', 	    13,	 4,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80144',     '80',        '80',     '30', 	'Å¥ÇÇÆ® È­»ìS',       	 '1',     '0', '5',      '0', 'treasure35',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ãâ¼®½Ã ÀÏÁ¤È®·ü·Î ÇÏÆ® 10°³¸¦ ÁØ´Ù', 	    14,	 5,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80200',     '80',        '80',     '30', 	'¿ìÀ¯ ¹æ¿ïD',       	 '1',     '0', '1',      '0', 'treasure10',      '0',     '0',      '0',      '0',       '0',    '100',  				'¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    5,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80201',     '80',        '80',     '30', 	'¿ìÀ¯ ¹æ¿ïC',       	 '1',     '0', '2',      '0', 'treasure10',      '0',     '0',      '0',      '0',       '0',    '100',  				'¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    11,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80202',     '80',        '80',     '30', 	'¿ìÀ¯ ¹æ¿ïB',       	 '1',     '0', '3',      '0', 'treasure10',      '0',     '0',      '0',      '0',       '0',    '100',  				'¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    18,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80203',     '80',        '80',     '30', 	'¿ìÀ¯ ¹æ¿ïA',       	 '1',     '0', '4',      '0', 'treasure10',      '0',     '0',      '0',      '0',       '0',    '100',  				'¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    26,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80204',     '80',        '80',     '30', 	'¿ìÀ¯ ¹æ¿ïS',       	 '1',     '0', '5',      '0', 'treasure10',      '0',     '0',      '0',      '0',       '0',    '100',  				'¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    35,	 4,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80205',     '80',        '80',     '30', 	'¿ä±¸¸£Æ® ÄµµðD',       	 '1',     '0', '1',      '0', 'treasure11',      '0',     '0',      '0',      '0',       '0',    '100',  				'¿ä±¸¸£Æ® È¹µæ È®·ü »ó½Â', 	    5,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80206',     '80',        '80',     '30', 	'¿ä±¸¸£Æ® ÄµµðC',       	 '1',     '0', '2',      '0', 'treasure11',      '0',     '0',      '0',      '0',       '0',    '100',  				'¿ä±¸¸£Æ® È¹µæ È®·ü »ó½Â', 	    11,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80207',     '80',        '80',     '30', 	'¿ä±¸¸£Æ® ÄµµðB',       	 '1',     '0', '3',      '0', 'treasure11',      '0',     '0',      '0',      '0',       '0',    '100',  				'¿ä±¸¸£Æ® È¹µæ È®·ü »ó½Â', 	    18,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80208',     '80',        '80',     '30', 	'¿ä±¸¸£Æ® ÄµµðA',       	 '1',     '0', '4',      '0', 'treasure11',      '0',     '0',      '0',      '0',       '0',    '100',  				'¿ä±¸¸£Æ® È¹µæ È®·ü »ó½Â', 	    26,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80209',     '80',        '80',     '30', 	'¿ä±¸¸£Æ® ÄµµðS',       	 '1',     '0', '5',      '0', 'treasure11',      '0',     '0',      '0',      '0',       '0',    '100',  				'¿ä±¸¸£Æ® È¹µæ È®·ü »ó½Â', 	    35,	 4,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80210',     '80',        '80',     '30', 	'ÇÏ¾á ±êÅÐD',       	 '1',     '0', '1',      '0', 'treasure12',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀúÁö¹æ ¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    5,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80211',     '80',        '80',     '30', 	'ÇÏ¾á ±êÅÐC',       	 '1',     '0', '2',      '0', 'treasure12',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀúÁö¹æ ¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    11,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80212',     '80',        '80',     '30', 	'ÇÏ¾á ±êÅÐB',       	 '1',     '0', '3',      '0', 'treasure12',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀúÁö¹æ ¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    18,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80213',     '80',        '80',     '30', 	'ÇÏ¾á ±êÅÐA',       	 '1',     '0', '4',      '0', 'treasure12',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀúÁö¹æ ¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    26,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80214',     '80',        '80',     '30', 	'ÇÏ¾á ±êÅÐS',       	 '1',     '0', '5',      '0', 'treasure12',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÀúÁö¹æ ¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    35,	 4,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80215',     '80',        '80',     '30', 	'±¸¸§ Á¶°¢D',       	 '1',     '0', '1',      '0', 'treasure13',      '0',     '0',      '0',      '0',       '0',    '100',  				'¹«Áö¹æ ¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    5,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80216',     '80',        '80',     '30', 	'±¸¸§ Á¶°¢C',       	 '1',     '0', '2',      '0', 'treasure13',      '0',     '0',      '0',      '0',       '0',    '100',  				'¹«Áö¹æ ¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    11,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80217',     '80',        '80',     '30', 	'±¸¸§ Á¶°¢B',       	 '1',     '0', '3',      '0', 'treasure13',      '0',     '0',      '0',      '0',       '0',    '100',  				'¹«Áö¹æ ¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    18,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80218',     '80',        '80',     '30', 	'±¸¸§ Á¶°¢A',       	 '1',     '0', '4',      '0', 'treasure13',      '0',     '0',      '0',      '0',       '0',    '100',  				'¹«Áö¹æ ¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    26,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80219',     '80',        '80',     '30', 	'±¸¸§ Á¶°¢S',       	 '1',     '0', '5',      '0', 'treasure13',      '0',     '0',      '0',      '0',       '0',    '100',  				'¹«Áö¹æ ¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    35,	 4,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80220',     '80',        '80',     '30', 	'¹Ù³ª³ª ÀÎÇüD',       	 '1',     '0', '1',      '0', 'treasure14',      '0',     '0',      '0',      '0',       '0',    '100',  				'¹Ù³ª³ª¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    5,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80221',     '80',        '80',     '30', 	'¹Ù³ª³ª ÀÎÇüC',       	 '1',     '0', '2',      '0', 'treasure14',      '0',     '0',      '0',      '0',       '0',    '100',  				'¹Ù³ª³ª¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    10,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80222',     '80',        '80',     '30', 	'¹Ù³ª³ª ÀÎÇüB',       	 '1',     '0', '3',      '0', 'treasure14',      '0',     '0',      '0',      '0',       '0',    '100',  				'¹Ù³ª³ª¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    17,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80223',     '80',        '80',     '30', 	'¹Ù³ª³ª ÀÎÇüA',       	 '1',     '0', '4',      '0', 'treasure14',      '0',     '0',      '0',      '0',       '0',    '100',  				'¹Ù³ª³ª¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    24,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80224',     '80',        '80',     '30', 	'¹Ù³ª³ª ÀÎÇüS',       	 '1',     '0', '5',      '0', 'treasure14',      '0',     '0',      '0',      '0',       '0',    '100',  				'¹Ù³ª³ª¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    33,	 4,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80225',     '80',        '80',     '30', 	'»ýÅ©¸² Á¶°¢ ÄÉÀÍD',       	 '1',     '0', '1',      '0', 'treasure15',      '0',     '0',      '0',      '0',       '0',    '100',  				'»ýÅ©¸² È¹µæ È®·ü »ó½Â', 	    5,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80226',     '80',        '80',     '30', 	'»ýÅ©¸² Á¶°¢ ÄÉÀÍC',       	 '1',     '0', '2',      '0', 'treasure15',      '0',     '0',      '0',      '0',       '0',    '100',  				'»ýÅ©¸² È¹µæ È®·ü »ó½Â', 	    10,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80227',     '80',        '80',     '30', 	'»ýÅ©¸² Á¶°¢ ÄÉÀÍB',       	 '1',     '0', '3',      '0', 'treasure15',      '0',     '0',      '0',      '0',       '0',    '100',  				'»ýÅ©¸² È¹µæ È®·ü »ó½Â', 	    17,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80228',     '80',        '80',     '30', 	'»ýÅ©¸² Á¶°¢ ÄÉÀÍA',       	 '1',     '0', '4',      '0', 'treasure15',      '0',     '0',      '0',      '0',       '0',    '100',  				'»ýÅ©¸² È¹µæ È®·ü »ó½Â', 	    24,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80229',     '80',        '80',     '30', 	'»ýÅ©¸² Á¶°¢ ÄÉÀÍS',       	 '1',     '0', '5',      '0', 'treasure15',      '0',     '0',      '0',      '0',       '0',    '100',  				'»ýÅ©¸² È¹µæ È®·ü »ó½Â', 	    33,	 4,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80230',     '80',        '80',     '30', 	'¹öÅÍ ÄíÅ°D',       	 '1',     '0', '1',      '0', 'treasure16',      '0',     '0',      '0',      '0',       '0',    '100',  				'°¡¿°¹öÅÍ È¹µæ È®·ü »ó½Â', 	    5,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80231',     '80',        '80',     '30', 	'¹öÅÍ ÄíÅ°C',       	 '1',     '0', '2',      '0', 'treasure16',      '0',     '0',      '0',      '0',       '0',    '100',  				'°¡¿°¹öÅÍ È¹µæ È®·ü »ó½Â', 	    10,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80232',     '80',        '80',     '30', 	'¹öÅÍ ÄíÅ°B',       	 '1',     '0', '3',      '0', 'treasure16',      '0',     '0',      '0',      '0',       '0',    '100',  				'°¡¿°¹öÅÍ È¹µæ È®·ü »ó½Â', 	    17,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80233',     '80',        '80',     '30', 	'¹öÅÍ ÄíÅ°A',       	 '1',     '0', '4',      '0', 'treasure16',      '0',     '0',      '0',      '0',       '0',    '100',  				'°¡¿°¹öÅÍ È¹µæ È®·ü »ó½Â', 	    24,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80234',     '80',        '80',     '30', 	'¹öÅÍ ÄíÅ°S',       	 '1',     '0', '5',      '0', 'treasure16',      '0',     '0',      '0',      '0',       '0',    '100',  				'°¡¿°¹öÅÍ È¹µæ È®·ü »ó½Â', 	    33,	 4,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80235',     '80',        '80',     '30', 	'º£ÀÌ±ÛD',       	 '1',     '0', '1',      '0', 'treasure17',      '0',     '0',      '0',      '0',       '0',    '100',  				'Å©¸²Ä¡Áî È¹µæ È®·ü »ó½Â', 	    4,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80236',     '80',        '80',     '30', 	'º£ÀÌ±ÛC',       	 '1',     '0', '2',      '0', 'treasure17',      '0',     '0',      '0',      '0',       '0',    '100',  				'Å©¸²Ä¡Áî È¹µæ È®·ü »ó½Â', 	    8,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80237',     '80',        '80',     '30', 	'º£ÀÌ±ÛB',       	 '1',     '0', '3',      '0', 'treasure17',      '0',     '0',      '0',      '0',       '0',    '100',  				'Å©¸²Ä¡Áî È¹µæ È®·ü »ó½Â', 	    14,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80238',     '80',        '80',     '30', 	'º£ÀÌ±ÛA',       	 '1',     '0', '4',      '0', 'treasure17',      '0',     '0',      '0',      '0',       '0',    '100',  				'Å©¸²Ä¡Áî È¹µæ È®·ü »ó½Â', 	    20,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80239',     '80',        '80',     '30', 	'º£ÀÌ±ÛS',       	 '1',     '0', '5',      '0', 'treasure17',      '0',     '0',      '0',      '0',       '0',    '100',  				'Å©¸²Ä¡Áî È¹µæ È®·ü »ó½Â', 	    28,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80240',     '80',        '80',     '30', 	'¿ìÀ¯ °ÅÇ°D',       	 '1',     '0', '1',      '0', 'treasure18',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ä«Æä¶ó¶¼ È¹µæ È®·ü »ó½Â', 	    4,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80241',     '80',        '80',     '30', 	'¿ìÀ¯ °ÅÇ°C',       	 '1',     '0', '2',      '0', 'treasure18',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ä«Æä¶ó¶¼ È¹µæ È®·ü »ó½Â', 	    8,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80242',     '80',        '80',     '30', 	'¿ìÀ¯ °ÅÇ°B',       	 '1',     '0', '3',      '0', 'treasure18',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ä«Æä¶ó¶¼ È¹µæ È®·ü »ó½Â', 	    14,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80243',     '80',        '80',     '30', 	'¿ìÀ¯ °ÅÇ°A',       	 '1',     '0', '4',      '0', 'treasure18',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ä«Æä¶ó¶¼ È¹µæ È®·ü »ó½Â', 	    20,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80244',     '80',        '80',     '30', 	'¿ìÀ¯ °ÅÇ°S',       	 '1',     '0', '5',      '0', 'treasure18',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ä«Æä¶ó¶¼ È¹µæ È®·ü »ó½Â', 	    28,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80245',     '80',        '80',     '30', 	'³ìÂ÷ Æ¼¹éD',       	 '1',     '0', '1',      '0', 'treasure19',      '0',     '0',      '0',      '0',       '0',    '100',  				'±×¸°Æ¼ ¶ó¶¼ È¹µæ È®·ü »ó½Â', 	    4,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80246',     '80',        '80',     '30', 	'³ìÂ÷ Æ¼¹éC',       	 '1',     '0', '2',      '0', 'treasure19',      '0',     '0',      '0',      '0',       '0',    '100',  				'±×¸°Æ¼ ¶ó¶¼ È¹µæ È®·ü »ó½Â', 	    8,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80247',     '80',        '80',     '30', 	'³ìÂ÷ Æ¼¹éB',       	 '1',     '0', '3',      '0', 'treasure19',      '0',     '0',      '0',      '0',       '0',    '100',  				'±×¸°Æ¼ ¶ó¶¼ È¹µæ È®·ü »ó½Â', 	    14,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80248',     '80',        '80',     '30', 	'³ìÂ÷ Æ¼¹éA',       	 '1',     '0', '4',      '0', 'treasure19',      '0',     '0',      '0',      '0',       '0',    '100',  				'±×¸°Æ¼ ¶ó¶¼ È¹µæ È®·ü »ó½Â', 	    20,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80249',     '80',        '80',     '30', 	'³ìÂ÷ Æ¼¹éS',       	 '1',     '0', '5',      '0', 'treasure19',      '0',     '0',      '0',      '0',       '0',    '100',  				'±×¸°Æ¼ ¶ó¶¼ È¹µæ È®·ü »ó½Â', 	    28,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80250',     '80',        '80',     '30', 	'¸ðÂ¥·¼¶ó Á¶°¢D',       	 '1',     '0', '1',      '0', 'treasure20',      '0',     '0',      '0',      '0',       '0',    '100',  				'¸ðÂ¥·¼¶ó È¹µæ È®·ü »ó½Â', 	    3,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80251',     '80',        '80',     '30', 	'¸ðÂ¥·¼¶ó Á¶°¢C',       	 '1',     '0', '2',      '0', 'treasure20',      '0',     '0',      '0',      '0',       '0',    '100',  				'¸ðÂ¥·¼¶ó È¹µæ È®·ü »ó½Â', 	    7,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80252',     '80',        '80',     '30', 	'¸ðÂ¥·¼¶ó Á¶°¢B',       	 '1',     '0', '3',      '0', 'treasure20',      '0',     '0',      '0',      '0',       '0',    '100',  				'¸ðÂ¥·¼¶ó È¹µæ È®·ü »ó½Â', 	    12,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80253',     '80',        '80',     '30', 	'¸ðÂ¥·¼¶ó Á¶°¢A',       	 '1',     '0', '4',      '0', 'treasure20',      '0',     '0',      '0',      '0',       '0',    '100',  				'¸ðÂ¥·¼¶ó È¹µæ È®·ü »ó½Â', 	    18,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80254',     '80',        '80',     '30', 	'¸ðÂ¥·¼¶ó Á¶°¢S',       	 '1',     '0', '5',      '0', 'treasure20',      '0',     '0',      '0',      '0',       '0',    '100',  				'¸ðÂ¥·¼¶ó È¹µæ È®·ü »ó½Â', 	    25,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80255',     '80',        '80',     '30', 	'½Ã³ª¸ó ½ºÆ½D',       	 '1',     '0', '1',      '0', 'treasure21',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ä«ÇªÄ¡³ë È¹µæ È®·ü »ó½Â', 	    3,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80256',     '80',        '80',     '30', 	'½Ã³ª¸ó ½ºÆ½C',       	 '1',     '0', '2',      '0', 'treasure21',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ä«ÇªÄ¡³ë È¹µæ È®·ü »ó½Â', 	    7,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80257',     '80',        '80',     '30', 	'½Ã³ª¸ó ½ºÆ½B',       	 '1',     '0', '3',      '0', 'treasure21',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ä«ÇªÄ¡³ë È¹µæ È®·ü »ó½Â', 	    12,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80258',     '80',        '80',     '30', 	'½Ã³ª¸ó ½ºÆ½A',       	 '1',     '0', '4',      '0', 'treasure21',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ä«ÇªÄ¡³ë È¹µæ È®·ü »ó½Â', 	    18,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80259',     '80',        '80',     '30', 	'½Ã³ª¸ó ½ºÆ½S',       	 '1',     '0', '5',      '0', 'treasure21',      '0',     '0',      '0',      '0',       '0',    '100',  				'Ä«ÇªÄ¡³ë È¹µæ È®·ü »ó½Â', 	    25,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80260',     '80',        '80',     '30', 	'¿¡¸àÅ» Á¶°¢D',       	 '1',     '0', '1',      '0', 'treasure22',      '0',     '0',      '0',      '0',       '0',    '100',  				'¿¡¸àÅ» È¹µæ È®·ü »ó½Â', 	    3,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80261',     '80',        '80',     '30', 	'¿¡¸àÅ» Á¶°¢C',       	 '1',     '0', '2',      '0', 'treasure22',      '0',     '0',      '0',      '0',       '0',    '100',  				'¿¡¸àÅ» È¹µæ È®·ü »ó½Â', 	    7,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80262',     '80',        '80',     '30', 	'¿¡¸àÅ» Á¶°¢B',       	 '1',     '0', '3',      '0', 'treasure22',      '0',     '0',      '0',      '0',       '0',    '100',  				'¿¡¸àÅ» È¹µæ È®·ü »ó½Â', 	    12,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80263',     '80',        '80',     '30', 	'¿¡¸àÅ» Á¶°¢A',       	 '1',     '0', '4',      '0', 'treasure22',      '0',     '0',      '0',      '0',       '0',    '100',  				'¿¡¸àÅ» È¹µæ È®·ü »ó½Â', 	    18,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80264',     '80',        '80',     '30', 	'¿¡¸àÅ» Á¶°¢S',       	 '1',     '0', '5',      '0', 'treasure22',      '0',     '0',      '0',      '0',       '0',    '100',  				'¿¡¸àÅ» È¹µæ È®·ü »ó½Â', 	    25,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80265',     '80',        '80',     '30', 	'¾óÀ½ Á¶°¢D',       	 '1',     '0', '1',      '0', 'treasure23',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÇÁ¶óÇªÄ¡³ë È¹µæ È®·ü »ó½Â', 	    3,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80266',     '80',        '80',     '30', 	'¾óÀ½ Á¶°¢C',       	 '1',     '0', '2',      '0', 'treasure23',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÇÁ¶óÇªÄ¡³ë È¹µæ È®·ü »ó½Â', 	    6,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80267',     '80',        '80',     '30', 	'¾óÀ½ Á¶°¢B',       	 '1',     '0', '3',      '0', 'treasure23',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÇÁ¶óÇªÄ¡³ë È¹µæ È®·ü »ó½Â', 	    11,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80268',     '80',        '80',     '30', 	'¾óÀ½ Á¶°¢A',       	 '1',     '0', '4',      '0', 'treasure23',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÇÁ¶óÇªÄ¡³ë È¹µæ È®·ü »ó½Â', 	    16,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80269',     '80',        '80',     '30', 	'¾óÀ½ Á¶°¢S',       	 '1',     '0', '5',      '0', 'treasure23',      '0',     '0',      '0',      '0',       '0',    '100',  				'ÇÁ¶óÇªÄ¡³ë È¹µæ È®·ü »ó½Â', 	    23,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80270',     '80',        '80',     '30', 	'°í¸£°ïÁ¹¶ó Á¶°¢D',       	 '1',     '0', '1',      '0', 'treasure24',      '0',     '0',      '0',      '0',       '0',    '100',  				'°í¸£°ïÁ¹¶ó È¹µæ È®·ü »ó½Â', 	    3,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80271',     '80',        '80',     '30', 	'°í¸£°ïÁ¹¶ó Á¶°¢C',       	 '1',     '0', '2',      '0', 'treasure24',      '0',     '0',      '0',      '0',       '0',    '100',  				'°í¸£°ïÁ¹¶ó È¹µæ È®·ü »ó½Â', 	    6,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80272',     '80',        '80',     '30', 	'°í¸£°ïÁ¹¶ó Á¶°¢B',       	 '1',     '0', '3',      '0', 'treasure24',      '0',     '0',      '0',      '0',       '0',    '100',  				'°í¸£°ïÁ¹¶ó È¹µæ È®·ü »ó½Â', 	    11,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80273',     '80',        '80',     '30', 	'°í¸£°ïÁ¹¶ó Á¶°¢A',       	 '1',     '0', '4',      '0', 'treasure24',      '0',     '0',      '0',      '0',       '0',    '100',  				'°í¸£°ïÁ¹¶ó È¹µæ È®·ü »ó½Â', 	    16,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80274',     '80',        '80',     '30', 	'°í¸£°ïÁ¹¶ó Á¶°¢S',       	 '1',     '0', '5',      '0', 'treasure24',      '0',     '0',      '0',      '0',       '0',    '100',  				'°í¸£°ïÁ¹¶ó È¹µæ È®·ü »ó½Â', 	    23,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80275',     '80',        '80',     '30', 	'ºí·çº£¸® ¸ñ°ÉÀÌD',       	 '1',     '0', '1',      '0', 'treasure25',      '0',     '0',      '0',      '0',       '0',    '100',  				'ºí·çº£¸®À¯ È¹µæ È®·ü »ó½Â', 	    3,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80276',     '80',        '80',     '30', 	'ºí·çº£¸® ¸ñ°ÉÀÌC',       	 '1',     '0', '2',      '0', 'treasure25',      '0',     '0',      '0',      '0',       '0',    '100',  				'ºí·çº£¸®À¯ È¹µæ È®·ü »ó½Â', 	    6,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80277',     '80',        '80',     '30', 	'ºí·çº£¸® ¸ñ°ÉÀÌB',       	 '1',     '0', '3',      '0', 'treasure25',      '0',     '0',      '0',      '0',       '0',    '100',  				'ºí·çº£¸®À¯ È¹µæ È®·ü »ó½Â', 	    11,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80278',     '80',        '80',     '30', 	'ºí·çº£¸® ¸ñ°ÉÀÌA',       	 '1',     '0', '4',      '0', 'treasure25',      '0',     '0',      '0',      '0',       '0',    '100',  				'ºí·çº£¸®À¯ È¹µæ È®·ü »ó½Â', 	    16,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80279',     '80',        '80',     '30', 	'ºí·çº£¸® ¸ñ°ÉÀÌS',       	 '1',     '0', '5',      '0', 'treasure25',      '0',     '0',      '0',      '0',       '0',    '100',  				'ºí·çº£¸®À¯ È¹µæ È®·ü »ó½Â', 	    23,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80280',     '80',        '80',     '30', 	'¿¬ÁúÄ¡Áî Á¶°¢D',       	 '1',     '0', '1',      '0', 'treasure26',      '0',     '0',      '0',      '0',       '0',    '100',  				'¿¬ÁúÄ¡Áî È¹µæ È®·ü »ó½Â', 	    2,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80281',     '80',        '80',     '30', 	'¿¬ÁúÄ¡Áî Á¶°¢C',       	 '1',     '0', '2',      '0', 'treasure26',      '0',     '0',      '0',      '0',       '0',    '100',  				'¿¬ÁúÄ¡Áî È¹µæ È®·ü »ó½Â', 	    5,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80282',     '80',        '80',     '30', 	'¿¬ÁúÄ¡Áî Á¶°¢B',       	 '1',     '0', '3',      '0', 'treasure26',      '0',     '0',      '0',      '0',       '0',    '100',  				'¿¬ÁúÄ¡Áî È¹µæ È®·ü »ó½Â', 	    9,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80283',     '80',        '80',     '30', 	'¿¬ÁúÄ¡Áî Á¶°¢A',       	 '1',     '0', '4',      '0', 'treasure26',      '0',     '0',      '0',      '0',       '0',    '100',  				'¿¬ÁúÄ¡Áî È¹µæ È®·ü »ó½Â', 	    14,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80284',     '80',        '80',     '30', 	'¿¬ÁúÄ¡Áî Á¶°¢S',       	 '1',     '0', '5',      '0', 'treasure26',      '0',     '0',      '0',      '0',       '0',    '100',  				'¿¬ÁúÄ¡Áî È¹µæ È®·ü »ó½Â', 	    20,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80285',     '80',        '80',     '30', 	'¿ìÀ¯ ±¸½½D',       	 '1',     '0', '1',      '0', 'treasure27',      '0',     '0',      '0',      '0',       '0',    '100',  				'¸¼Àº¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    2,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80286',     '80',        '80',     '30', 	'¿ìÀ¯ ±¸½½C',       	 '1',     '0', '2',      '0', 'treasure27',      '0',     '0',      '0',      '0',       '0',    '100',  				'¸¼Àº¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    5,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80287',     '80',        '80',     '30', 	'¿ìÀ¯ ±¸½½B',       	 '1',     '0', '3',      '0', 'treasure27',      '0',     '0',      '0',      '0',       '0',    '100',  				'¸¼Àº¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    9,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80288',     '80',        '80',     '30', 	'¿ìÀ¯ ±¸½½A',       	 '1',     '0', '4',      '0', 'treasure27',      '0',     '0',      '0',      '0',       '0',    '100',  				'¸¼Àº¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    14,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80289',     '80',        '80',     '30', 	'¿ìÀ¯ ±¸½½S',       	 '1',     '0', '5',      '0', 'treasure27',      '0',     '0',      '0',      '0',       '0',    '100',  				'¸¼Àº¿ìÀ¯ È¹µæ È®·ü »ó½Â', 	    20,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80290',     '80',        '80',     '30', 	'¸ðÂ¥·¼¶ó Å¥ºê ¸ñ°ÉÀÌD',       	 '1',     '0', '1',      '0', 'treasure28',      '0',     '0',      '0',      '0',       '0',    '100',  				'°í±Þ¸ðÂ¥·¼¶ó È¹µæ È®·ü »ó½Â', 	    2,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80291',     '80',        '80',     '30', 	'¸ðÂ¥·¼¶ó Å¥ºê ¸ñ°ÉÀÌC',       	 '1',     '0', '2',      '0', 'treasure28',      '0',     '0',      '0',      '0',       '0',    '100',  				'°í±Þ¸ðÂ¥·¼¶ó È¹µæ È®·ü »ó½Â', 	    5,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80292',     '80',        '80',     '30', 	'¸ðÂ¥·¼¶ó Å¥ºê ¸ñ°ÉÀÌB',       	 '1',     '0', '3',      '0', 'treasure28',      '0',     '0',      '0',      '0',       '0',    '100',  				'°í±Þ¸ðÂ¥·¼¶ó È¹µæ È®·ü »ó½Â', 	    9,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80293',     '80',        '80',     '30', 	'¸ðÂ¥·¼¶ó Å¥ºê ¸ñ°ÉÀÌA',       	 '1',     '0', '4',      '0', 'treasure28',      '0',     '0',      '0',      '0',       '0',    '100',  				'°í±Þ¸ðÂ¥·¼¶ó È¹µæ È®·ü »ó½Â', 	    14,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80294',     '80',        '80',     '30', 	'¸ðÂ¥·¼¶ó Å¥ºê ¸ñ°ÉÀÌS',       	 '1',     '0', '5',      '0', 'treasure28',      '0',     '0',      '0',      '0',       '0',    '100',  				'°í±Þ¸ðÂ¥·¼¶ó È¹µæ È®·ü »ó½Â', 	    20,	 3,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80295',     '80',        '80',     '30', 	'Ä«ÇªÄ¡³ë °ÅÇ°D',       	 '1',     '0', '1',      '0', 'treasure29',      '0',     '0',      '0',      '0',       '0',    '100',  				'°í±ÞÄ«ÇªÄ¡³ë È¹µæ È®·ü »ó½Â', 	    2,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80296',     '80',        '80',     '30', 	'Ä«ÇªÄ¡³ë °ÅÇ°C',       	 '1',     '0', '2',      '0', 'treasure29',      '0',     '0',      '0',      '0',       '0',    '100',  				'°í±ÞÄ«ÇªÄ¡³ë È¹µæ È®·ü »ó½Â', 	    4,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80297',     '80',        '80',     '30', 	'Ä«ÇªÄ¡³ë °ÅÇ°B',       	 '1',     '0', '3',      '0', 'treasure29',      '0',     '0',      '0',      '0',       '0',    '100',  				'°í±ÞÄ«ÇªÄ¡³ë È¹µæ È®·ü »ó½Â', 	    8,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80298',     '80',        '80',     '30', 	'Ä«ÇªÄ¡³ë °ÅÇ°A',       	 '1',     '0', '4',      '0', 'treasure29',      '0',     '0',      '0',      '0',       '0',    '100',  				'°í±ÞÄ«ÇªÄ¡³ë È¹µæ È®·ü »ó½Â', 	    12,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80299',     '80',        '80',     '30', 	'Ä«ÇªÄ¡³ë °ÅÇ°S',       	 '1',     '0', '5',      '0', 'treasure29',      '0',     '0',      '0',      '0',       '0',    '100',  				'°í±ÞÄ«ÇªÄ¡³ë È¹µæ È®·ü »ó½Â', 	    18,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80300',     '80',        '80',     '30', 	'¿¡¸àÅ» Å¥ºê ¸ñ°ÉÀÌD',       	 '1',     '0', '1',      '0', 'treasure30',      '0',     '0',      '0',      '0',       '0',    '100',  				'°í±Þ¿¡¸àÅ» È¹µæ È®·ü »ó½Â', 	    2,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80301',     '80',        '80',     '30', 	'¿¡¸àÅ» Å¥ºê ¸ñ°ÉÀÌC',       	 '1',     '0', '2',      '0', 'treasure30',      '0',     '0',      '0',      '0',       '0',    '100',  				'°í±Þ¿¡¸àÅ» È¹µæ È®·ü »ó½Â', 	    4,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80302',     '80',        '80',     '30', 	'¿¡¸àÅ» Å¥ºê ¸ñ°ÉÀÌB',       	 '1',     '0', '3',      '0', 'treasure30',      '0',     '0',      '0',      '0',       '0',    '100',  				'°í±Þ¿¡¸àÅ» È¹µæ È®·ü »ó½Â', 	    8,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80303',     '80',        '80',     '30', 	'¿¡¸àÅ» Å¥ºê ¸ñ°ÉÀÌA',       	 '1',     '0', '4',      '0', 'treasure30',      '0',     '0',      '0',      '0',       '0',    '100',  				'°í±Þ¿¡¸àÅ» È¹µæ È®·ü »ó½Â', 	    12,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80304',     '80',        '80',     '30', 	'¿¡¸àÅ» Å¥ºê ¸ñ°ÉÀÌS',       	 '1',     '0', '5',      '0', 'treasure30',      '0',     '0',      '0',      '0',       '0',    '100',  				'°í±Þ¿¡¸àÅ» È¹µæ È®·ü »ó½Â', 	    18,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80305',     '80',        '80',     '30', 	'°í¸£°ïÁ¹¶ó Å¥ºê ¸ñ°ÉÀÌD',       	 '1',     '0', '1',      '0', 'treasure31',      '0',     '0',      '0',      '0',       '0',    '100',  				'DHA°í¸£°ïÁ¹¶ó È¹µæ È®·ü »ó½Â', 	    1,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80306',     '80',        '80',     '30', 	'°í¸£°ïÁ¹¶ó Å¥ºê ¸ñ°ÉÀÌC',       	 '1',     '0', '2',      '0', 'treasure31',      '0',     '0',      '0',      '0',       '0',    '100',  				'DHA°í¸£°ïÁ¹¶ó È¹µæ È®·ü »ó½Â', 	    3,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80307',     '80',        '80',     '30', 	'°í¸£°ïÁ¹¶ó Å¥ºê ¸ñ°ÉÀÌB',       	 '1',     '0', '3',      '0', 'treasure31',      '0',     '0',      '0',      '0',       '0',    '100',  				'DHA°í¸£°ïÁ¹¶ó È¹µæ È®·ü »ó½Â', 	    6,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80308',     '80',        '80',     '30', 	'°í¸£°ïÁ¹¶ó Å¥ºê ¸ñ°ÉÀÌA',       	 '1',     '0', '4',      '0', 'treasure31',      '0',     '0',      '0',      '0',       '0',    '100',  				'DHA°í¸£°ïÁ¹¶ó È¹µæ È®·ü »ó½Â', 	    10,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80309',     '80',        '80',     '30', 	'°í¸£°ïÁ¹¶ó Å¥ºê ¸ñ°ÉÀÌS',       	 '1',     '0', '5',      '0', 'treasure31',      '0',     '0',      '0',      '0',       '0',    '100',  				'DHA°í¸£°ïÁ¹¶ó È¹µæ È®·ü »ó½Â', 	    15,	 2,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80310',     '80',        '80',     '30', 	'È²±Ý ¿ìÀ¯ ±¸½½D',       	 '1',     '0', '1',      '0', 'treasure32',      '0',     '0',      '0',      '0',       '0',    '100',  				'½Å¼±ÃÊÀ¯ È¹µæ È®·ü »ó½Â', 	    1,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80311',     '80',        '80',     '30', 	'È²±Ý ¿ìÀ¯ ±¸½½C',       	 '1',     '0', '2',      '0', 'treasure32',      '0',     '0',      '0',      '0',       '0',    '100',  				'½Å¼±ÃÊÀ¯ È¹µæ È®·ü »ó½Â', 	    2,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80312',     '80',        '80',     '30', 	'È²±Ý ¿ìÀ¯ ±¸½½B',       	 '1',     '0', '3',      '0', 'treasure32',      '0',     '0',      '0',      '0',       '0',    '100',  				'½Å¼±ÃÊÀ¯ È¹µæ È®·ü »ó½Â', 	    5,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80313',     '80',        '80',     '30', 	'È²±Ý ¿ìÀ¯ ±¸½½A',       	 '1',     '0', '4',      '0', 'treasure32',      '0',     '0',      '0',      '0',       '0',    '100',  				'½Å¼±ÃÊÀ¯ È¹µæ È®·ü »ó½Â', 	    8,	 1,	  7)
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot,    itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, 				description,  param1, param2, param3)
values(                     'lv_skill', '80314',     '80',        '80',     '30', 	'È²±Ý ¿ìÀ¯ ±¸½½S',       	 '1',     '0', '5',      '0', 'treasure32',      '0',     '0',      '0',      '0',       '0',    '100',  				'½Å¼±ÃÊÀ¯ È¹µæ È®·ü »ó½Â', 	    13,	 2,	  7)
GO

