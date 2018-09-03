use Game4FarmVill4
GO
delete from dbo.tFVItemInfo where category in (31, 32, 33, 34, 35, 36, 37, 30, 60)

-- 코인
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3100', '31', '31', '31', '코인', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '코인')
GO

-- VIP
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3200', '32', '32', '32', 'VIP포인트', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', 'VIP포인트')
GO

-- 하트
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3300', '33', '33', '33', '하트', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '하트')
GO

-- 건초
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3400', '34', '34', '34', '건초', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '건초')
GO

-- 황금룰렛티켓
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3500', '35', '35', '35', '황금룰렛티켓', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '황금룰렛티켓')
GO

-- 보물뽑기티켓.
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3600', '36', '36', '36', '보물고급티켓', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '보물고급티켓')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3601', '36', '36', '36', '보물최고급티켓', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '보물최고급티켓')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3602', '36', '36', '36', '보물최고급3티켓', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '보물최고급3티켓')
GO

-- 환생포인트.
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3700', '37', '37', '37', '환생(별)', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '환생(별)')
GO

-- 유제품
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3000', '30', '30', '30', '울', '0', '0', '0', '0', '0', '0', '0', '0', '0', '3400', '3', '울')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3001', '30', '30', '30', '앙고라', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1700', '7', '앙고라')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3002', '30', '30', '30', '모직원단', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1000', '12', '모직원단')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3003', '30', '30', '30', '니트', '0', '0', '0', '0', '0', '0', '0', '0', '0', '720', '18', '니트')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3004', '30', '30', '30', '코듀로이', '0', '0', '0', '0', '0', '0', '0', '0', '0', '530', '25', '코듀로이')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3005', '30', '30', '30', '프란넬', '0', '0', '0', '0', '0', '0', '0', '0', '0', '300', '35', '프란넬')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3006', '30', '30', '30', '트위드', '0', '0', '0', '0', '0', '0', '0', '0', '0', '170', '60', '트위드')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3007', '30', '30', '30', '모슬린', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '100', '모슬린')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3008', '30', '30', '30', '울 새틴', '0', '0', '0', '0', '0', '0', '0', '0', '0', '50', '200', '울 새틴')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3009', '30', '30', '30', '울 조젯', '0', '0', '0', '0', '0', '0', '0', '0', '0', '25', '400', '울 조젯')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3010', '30', '30', '30', '벨벳 울', '0', '0', '0', '0', '0', '0', '0', '0', '0', '15', '700', '벨벳 울')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3011', '30', '30', '30', '울 다마스크', '0', '0', '0', '0', '0', '0', '0', '0', '0', '10', '1000', '울 다마스크')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3012', '30', '30', '30', '펠트', '0', '0', '0', '0', '0', '0', '0', '0', '0', '7', '1500', '펠트')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3013', '30', '30', '30', '비큐나', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5', '2000', '비큐나')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3014', '30', '30', '30', '캐시미어', '0', '0', '0', '0', '0', '0', '0', '0', '0', '3', '3000', '캐시미어')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3015', '30', '30', '30', '루비', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '루비')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3016', '30', '30', '30', '황금울', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '황금울')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3017', '30', '30', '30', '황금아고라', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '황금아고라')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3018', '30', '30', '30', '황금모직', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '황금모직')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3019', '30', '30', '30', '황금니트', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '황금니트')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3020', '30', '30', '30', '황금코듀로이', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '황금코듀로이')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3021', '30', '30', '30', '황금프란넬', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '황금프란넬')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3022', '30', '30', '30', '황금트위드', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '황금트위드')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3023', '30', '30', '30', '황금모슬린', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '황금모슬린')
GO


--- 목장기술
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60000', '60', '60', '60', '집의 재물', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '집의 재물')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60001', '60', '60', '60', '탱크의 재물', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '탱크의 재물')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60002', '60', '60', '60', '양의 재물', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '양의 재물')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60003', '60', '60', '60', '필드의 재물', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '필드의 재물')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60004', '60', '60', '60', '일꾼의 재물', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '일꾼의 재물')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60005', '60', '60', '60', '목장의 재물', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '목장의 재물')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60006', '60', '60', '60', '집의 방직물', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '집의 방직물')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60007', '60', '60', '60', '탱크의 방직물', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '탱크의 방직물')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60008', '60', '60', '60', '양의 방직물', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '양의 방직물')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60009', '60', '60', '60', '필드의 방직물', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '필드의 방직물')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60010', '60', '60', '60', '일꾼의 방직물', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '일꾼의 방직물')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60011', '60', '60', '60', '작물 업그레이드 단축', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '작물 업그레이드 단축')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60012', '60', '60', '60', '환생포인트증가', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '환생포인트증가')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60013', '60', '60', '60', '일꾼의 효율', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '일꾼의 효율')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60014', '60', '60', '60', '건초의 재물', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '건초의 재물')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60015', '60', '60', '60', '퀘스트 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '퀘스트 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60020', '60', '60', '60', '울의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '울의 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60021', '60', '60', '60', '앙고라의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '앙고라의 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60022', '60', '60', '60', '모직원단의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '모직원단의 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60023', '60', '60', '60', '니트의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '니트의 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60024', '60', '60', '60', '코듀로이의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '코듀로이의 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60025', '60', '60', '60', '프란넬의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '프란넬의 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60026', '60', '60', '60', '트위드의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '트위드의 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60027', '60', '60', '60', '모슬린의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '모슬린의 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60028', '60', '60', '60', '울 새틴의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '울 새틴의 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60029', '60', '60', '60', '울 조젯의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '울 조젯의 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60030', '60', '60', '60', '벨벳 울의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '벨벳 울의 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60031', '60', '60', '60', '울 다마스크의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '울 다마스크의 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60032', '60', '60', '60', '펠트의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '펠트의 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60033', '60', '60', '60', '비큐나의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '비큐나의 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60034', '60', '60', '60', '캐시미어의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '캐시미어의 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60035', '60', '60', '60', '황금울의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '황금울의 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60036', '60', '60', '60', '황금아고라의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '황금아고라의 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60037', '60', '60', '60', '황금모직의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '황금모직의 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60038', '60', '60', '60', '황금니트의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '황금니트의 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60039', '60', '60', '60', '황금코듀로이의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '황금코듀로이의 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60040', '60', '60', '60', '황금프란넬의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '황금프란넬의 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60041', '60', '60', '60', '황금트위드의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '황금트위드의 기술')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60042', '60', '60', '60', '황금모슬린의 기술', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '황금모슬린의 기술')
GO
