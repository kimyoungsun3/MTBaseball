use Game4FarmVill3
GO

delete from dbo.tFVItemInfo where category in (30, 31, 32, 33, 34, 35)

-- ĳ��
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3015', '30', '30', '30', 'ĳ��(��)', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', 'ĳ��(��)')
GO

-- ��������Ʈ
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3016', '30', '30', '30', '��������Ʈ ', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '��������Ʈ ')
GO

-- ����
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3100', '31', '31', '31', '����', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '����')
GO

-- VIP
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_vip', '3200', '32', '32', '32', 'VIP����Ʈ', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', 'VIP����Ʈ')
GO

-- ��Ʈ
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_heart', '3300', '33', '33', '33', '��������Ʈ', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '��������Ʈ')
GO

-- �Ϲ� ���� ���ű�
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_ticket', '3400', '34', '34', '34', '�Ϲ� ���� ���ű�', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '�Ϲ� ���� ���ű�')
GO

-- �����̾� ���� ���ű�
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_ticket', '3500', '35', '35', '35', '�����̾� ���� ���ű�', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '�����̾� ���� ���ű�')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_ticket', '3501', '35', '35', '35', '�����̾� ���� ���� ���ű�', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '�����̾� ���� ���� ���ű�')
GO
