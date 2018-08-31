use Game4FarmVill3
GO

delete from dbo.tFVItemInfo where category in (30, 31, 32, 33, 34, 35)

-- 캐쉬
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3015', '30', '30', '30', '캐쉬(별)', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '캐쉬(별)')
GO

-- 연구포인트
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3016', '30', '30', '30', '연구포인트 ', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '연구포인트 ')
GO

-- 코인
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3100', '31', '31', '31', '코인', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '코인')
GO

-- VIP
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_vip', '3200', '32', '32', '32', 'VIP포인트', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', 'VIP포인트')
GO

-- 하트
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_heart', '3300', '33', '33', '33', '우정포인트', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '우정포인트')
GO

-- 일반 동물 구매권
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_ticket', '3400', '34', '34', '34', '일반 동물 구매권', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '일반 동물 구매권')
GO

-- 프리미엄 동물 구매권
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_ticket', '3500', '35', '35', '35', '프리미엄 동물 구매권', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '프리미엄 동물 구매권')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_ticket', '3501', '35', '35', '35', '프리미엄 연속 동물 구매권', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '프리미엄 연속 동물 구매권')
GO
