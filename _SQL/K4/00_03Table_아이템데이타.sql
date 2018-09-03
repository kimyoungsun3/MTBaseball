use Game4FarmVill4
GO
delete from dbo.tFVItemInfo where category in (31, 32, 33, 34, 35, 36, 37, 30, 60)

-- ����
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3100', '31', '31', '31', '����', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '����')
GO

-- VIP
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3200', '32', '32', '32', 'VIP����Ʈ', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', 'VIP����Ʈ')
GO

-- ��Ʈ
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3300', '33', '33', '33', '��Ʈ', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '��Ʈ')
GO

-- ����
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3400', '34', '34', '34', '����', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '����')
GO

-- Ȳ�ݷ귿Ƽ��
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3500', '35', '35', '35', 'Ȳ�ݷ귿Ƽ��', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', 'Ȳ�ݷ귿Ƽ��')
GO

-- �����̱�Ƽ��.
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3600', '36', '36', '36', '�������Ƽ��', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '�������Ƽ��')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3601', '36', '36', '36', '�����ְ��Ƽ��', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '�����ְ��Ƽ��')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3602', '36', '36', '36', '�����ְ��3Ƽ��', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '�����ְ��3Ƽ��')
GO

-- ȯ������Ʈ.
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3700', '37', '37', '37', 'ȯ��(��)', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', 'ȯ��(��)')
GO

-- ����ǰ
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_coin', '3000', '30', '30', '30', '��', '0', '0', '0', '0', '0', '0', '0', '0', '0', '3400', '3', '��')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3001', '30', '30', '30', '�Ӱ��', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1700', '7', '�Ӱ��')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3002', '30', '30', '30', '��������', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1000', '12', '��������')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3003', '30', '30', '30', '��Ʈ', '0', '0', '0', '0', '0', '0', '0', '0', '0', '720', '18', '��Ʈ')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3004', '30', '30', '30', '�ڵ����', '0', '0', '0', '0', '0', '0', '0', '0', '0', '530', '25', '�ڵ����')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3005', '30', '30', '30', '������', '0', '0', '0', '0', '0', '0', '0', '0', '0', '300', '35', '������')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3006', '30', '30', '30', 'Ʈ����', '0', '0', '0', '0', '0', '0', '0', '0', '0', '170', '60', 'Ʈ����')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3007', '30', '30', '30', '�𽽸�', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '100', '�𽽸�')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3008', '30', '30', '30', '�� ��ƾ', '0', '0', '0', '0', '0', '0', '0', '0', '0', '50', '200', '�� ��ƾ')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3009', '30', '30', '30', '�� ����', '0', '0', '0', '0', '0', '0', '0', '0', '0', '25', '400', '�� ����')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3010', '30', '30', '30', '���� ��', '0', '0', '0', '0', '0', '0', '0', '0', '0', '15', '700', '���� ��')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3011', '30', '30', '30', '�� �ٸ���ũ', '0', '0', '0', '0', '0', '0', '0', '0', '0', '10', '1000', '�� �ٸ���ũ')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3012', '30', '30', '30', '��Ʈ', '0', '0', '0', '0', '0', '0', '0', '0', '0', '7', '1500', '��Ʈ')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3013', '30', '30', '30', '��ť��', '0', '0', '0', '0', '0', '0', '0', '0', '0', '5', '2000', '��ť��')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3014', '30', '30', '30', 'ĳ�ù̾�', '0', '0', '0', '0', '0', '0', '0', '0', '0', '3', '3000', 'ĳ�ù̾�')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3015', '30', '30', '30', '���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3016', '30', '30', '30', 'Ȳ�ݿ�', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', 'Ȳ�ݿ�')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3017', '30', '30', '30', 'Ȳ�ݾư��', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', 'Ȳ�ݾư��')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3018', '30', '30', '30', 'Ȳ�ݸ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', 'Ȳ�ݸ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3019', '30', '30', '30', 'Ȳ�ݴ�Ʈ', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', 'Ȳ�ݴ�Ʈ')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3020', '30', '30', '30', 'Ȳ���ڵ����', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', 'Ȳ���ڵ����')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3021', '30', '30', '30', 'Ȳ��������', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', 'Ȳ��������')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3022', '30', '30', '30', 'Ȳ��Ʈ����', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', 'Ȳ��Ʈ����')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '3023', '30', '30', '30', 'Ȳ�ݸ𽽸�', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', 'Ȳ�ݸ𽽸�')
GO


--- ������
insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60000', '60', '60', '60', '���� �繰', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '���� �繰')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60001', '60', '60', '60', '��ũ�� �繰', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '��ũ�� �繰')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60002', '60', '60', '60', '���� �繰', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '���� �繰')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60003', '60', '60', '60', '�ʵ��� �繰', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '�ʵ��� �繰')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60004', '60', '60', '60', '�ϲ��� �繰', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '�ϲ��� �繰')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60005', '60', '60', '60', '������ �繰', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '������ �繰')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60006', '60', '60', '60', '���� ������', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '���� ������')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60007', '60', '60', '60', '��ũ�� ������', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '��ũ�� ������')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60008', '60', '60', '60', '���� ������', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '���� ������')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60009', '60', '60', '60', '�ʵ��� ������', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '�ʵ��� ������')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60010', '60', '60', '60', '�ϲ��� ������', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '�ϲ��� ������')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60011', '60', '60', '60', '�۹� ���׷��̵� ����', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '�۹� ���׷��̵� ����')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60012', '60', '60', '60', 'ȯ������Ʈ����', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', 'ȯ������Ʈ����')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60013', '60', '60', '60', '�ϲ��� ȿ��', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '�ϲ��� ȿ��')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60014', '60', '60', '60', '������ �繰', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '������ �繰')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60015', '60', '60', '60', '����Ʈ ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '����Ʈ ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60020', '60', '60', '60', '���� ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '���� ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60021', '60', '60', '60', '�Ӱ���� ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '�Ӱ���� ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60022', '60', '60', '60', '���������� ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '���������� ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60023', '60', '60', '60', '��Ʈ�� ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '��Ʈ�� ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60024', '60', '60', '60', '�ڵ������ ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '�ڵ������ ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60025', '60', '60', '60', '�������� ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '�������� ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60026', '60', '60', '60', 'Ʈ������ ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', 'Ʈ������ ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60027', '60', '60', '60', '�𽽸��� ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '�𽽸��� ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60028', '60', '60', '60', '�� ��ƾ�� ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '�� ��ƾ�� ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60029', '60', '60', '60', '�� ������ ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '�� ������ ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60030', '60', '60', '60', '���� ���� ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '���� ���� ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60031', '60', '60', '60', '�� �ٸ���ũ�� ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '�� �ٸ���ũ�� ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60032', '60', '60', '60', '��Ʈ�� ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '��Ʈ�� ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60033', '60', '60', '60', '��ť���� ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', '��ť���� ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60034', '60', '60', '60', 'ĳ�ù̾��� ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', 'ĳ�ù̾��� ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60035', '60', '60', '60', 'Ȳ�ݿ��� ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', 'Ȳ�ݿ��� ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60036', '60', '60', '60', 'Ȳ�ݾư���� ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', 'Ȳ�ݾư���� ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60037', '60', '60', '60', 'Ȳ�ݸ����� ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', 'Ȳ�ݸ����� ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60038', '60', '60', '60', 'Ȳ�ݴ�Ʈ�� ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', 'Ȳ�ݴ�Ʈ�� ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60039', '60', '60', '60', 'Ȳ���ڵ������ ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', 'Ȳ���ڵ������ ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60040', '60', '60', '60', 'Ȳ���������� ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', 'Ȳ���������� ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60041', '60', '60', '60', 'Ȳ��Ʈ������ ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', 'Ȳ��Ʈ������ ���')
GO

insert into dbo.tFVItemInfo(labelname, itemcode, category, subcategory, equpslot, itemname, activate, toplist, grade, discount, icon, playerlv, houselv, gamecost, cashcost, buyamount, sellcost, description)
values('lb_product', '60042', '60', '60', '60', 'Ȳ�ݸ𽽸��� ���', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '100', 'Ȳ�ݸ𽽸��� ���')
GO
