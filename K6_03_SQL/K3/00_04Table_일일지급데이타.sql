if(not exists(select top 1 * from dbo.tFVEventMaster))
	begin
		insert into dbo.tFVEventMaster(eventstatemaster) values(1)
	end

update dbo.tFVEventMaster set eventstatemaster = 1 where idx = 1


-- select * from dbo.tFVEventSub
delete from dbo.tFVEventSub

insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10,  1, 1, 23, '2015�� ���ذ� ��ҽ��ϴ�.', '���� �� ���� ��������', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10,  2, 1, 23, '��ſ� ����� �� 2015�� ���ؿ���', '����ִ� ¥�� ������ �Բ� ��ܿ�', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10,  3, 1, 23, '�ູ�� �ָ�! ����ִ� ¥�� ����', '��� ���� ��ܺ��ƿ�!', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10,  4, 1, 23, '�ູ�� �ָ�! ��ſ� ����LIFE��', '¥������̾߱� �������� ��ܺ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10,  5, 1, 23, '�ǰ��� �����Ͽ���', '��մ� ������ �Բ��ϸ� ��ſ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10,  6, 1, 23, '��̰� �پ��� �̺�Ʈ', '������ �Բ� ��ܺ��ƿ�!', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10,  7, 1, 23, '���δ��� ��Ÿ�� ��ٸ��� �־��~', '���� �����ؼ� ���� �������ּ���~ ������ ���ƿ� ��_��', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10,  8, 1, 23, '��̰� �پ��� �̺�Ʈ', '�ҽ��� ����鿡�� �������ְ� ����ǰ�� �Ǹ������ּ���~', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10,  9, 1, 23, '¥������� �Բ��ϸ� ', '���� �ɽ����� ���� �Ϸ�! ���� �����ϼ���~!', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 10, 1, 23, '������ ī��󶼿� �Բ�', '¥�� ������ ��ܺ�����~', 0)

insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 11, 1, 23, '���ݹٷ� �����غ�����.', '������ ��Ƶ׽��ϴ�. �޾ư�����~', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 12, 1, 23, '�ұݿ� �ų��� ��� ���� �ö�', '¥�� ������ ��ܺ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 13, 1, 23, '���� �� ��� �̺�Ʈ ���� ��', '�����Ͻø� �����Կ� ���������� ���', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 14, 1, 23, '���� �� ��� �̺�Ʈ ���� ��', '�����Ͻø� �����Կ� ���������� ��� ��', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 15, 1, 23, '���ο� ������ ������', '¥�� ������ ���� �����غ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 16, 1, 23, '�߿� �ܿ� �������� ��պ���� ��', '����ִ� ¥�� ������ ��ܺ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 17, 1, 23, '���ɽð� ���Ŀ� �ǰ��� ����', '�����ο� ¥�� �������� �Ƿθ� Ǯ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 18, 1, 23, '�ų��� �پ��� �̺�Ʈ��', '¥�� ������ �Բ� ��ܺ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 19, 1, 23, '�ູ�� ���� �濵 �ùķ��̼� ', '¥�� ������ ��ܺ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 20, 1, 23, '���ִ� ���� �԰� �����Ӱ�', '¥�� ������ ���� �غ� �Ǽ̳���', 0)

insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 21, 1, 23, '��ȣ�� ����!!! �̹���ȸ ��ġ�� ������', '���� ���� 100���� ���������� �����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 22, 1, 23, '�������� �߿��� ���� �־��', '�ҽ��� �������� �������ְ�, ������ǰ�� �Ⱦƺ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 23, 1, 23, '��������� ������� �Բ� ', '��ſ� ¥�� ������ �ų��� ��ܺ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 24, 1, 23, '�����ִ� ���� �������� ¥�� ��������', '����ְ� �ų��� �������� ��ܺ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 25, 1, 23, '�ູ�� �ָ����� ¥������� �Բ�', '��ſ� ���� �������� ��ܺ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 26, 1, 23, '�����Ӱ� ��� �� �ִ�', '¥�� ������ ģ����� �Բ��ؿ�', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 27, 1, 23, '������ �������� ¥�� ������ �Բ�', '���� ����ְ� ��ſ� �Ϸ� ��������', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 28, 1, 23, '¥�� �������� �پ��� �̺�Ʈ��', '�������Դϴ� �����ؼ� ������ �޾ư�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 29, 1, 23, '�ູ�� ���� �濵 �ùķ��̼� ', '¥�� ������ ��ܺ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 30, 1, 23, '���ִ� ���� �԰� �����Ӱ�', '¥�� ������ ���� �غ� �Ǽ̳���', 0)

insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 10, 31, 1, 23, '���ݹٷ� �����غ�����.', '������ ��Ƶ׽��ϴ�. �޾ư�����~', 0)

/*
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 100,  1, 1, 23, '2015�� ���ذ� ��ҽ��ϴ�.', '���� �� ���� ��������', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1,  2, 1, 23, '��ſ� ����� �� 2015�� ���ؿ���', '����ִ� ¥�� ������ �Բ� ��ܿ�', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 200,  3, 1, 23, '�ູ�� �ָ�! ����ִ� ¥�� ����', '��� ���� ��ܺ��ƿ�!', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1,  4, 1, 23, '�ູ�� �ָ�! ��ſ� ����LIFE��', '¥������̾߱� �������� ��ܺ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 200,  5, 1, 23, '�ǰ��� �����Ͽ���', '��մ� ������ �Բ��ϸ� ��ſ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1,  6, 1, 23, '��̰� �پ��� �̺�Ʈ', '������ �Բ� ��ܺ��ƿ�!', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   3,  7, 1, 23, '���δ��� ��Ÿ�� ��ٸ��� �־��~', '���� �����ؼ� ���� �������ּ���~ ������ ���ƿ� ��_��', 0)

insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 100,  8, 1, 23, '��̰� �پ��� �̺�Ʈ', '�ҽ��� ����鿡�� �������ְ� ����ǰ�� �Ǹ������ּ���~', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1,  9, 1, 23, '¥������� �Բ��ϸ� ', '���� �ɽ����� ���� �Ϸ�! ���� �����ϼ���~!', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 200, 10, 1, 23, '������ ī��󶼿� �Բ�', '¥�� ������ ��ܺ�����~', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1, 11, 1, 23, '���ݹٷ� �����غ�����.', '������ ��Ƶ׽��ϴ�. �޾ư�����~', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 200, 12, 1, 23, '�ұݿ� �ų��� ��� ���� �ö�', '¥�� ������ ��ܺ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1, 13, 1, 23, '���� �� ��� �̺�Ʈ ���� ��', '�����Ͻø� �����Կ� ���������� ���', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3500,   1, 14, 1, 23, '���� �� ��� �̺�Ʈ ���� ��', '�����Ͻø� �����Կ� ���������� ��� ��', 0)

insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 100, 15, 1, 23, '���ο� ������ ������', '¥�� ������ ���� �����غ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1, 16, 1, 23, '�߿� �ܿ� �������� ��պ���� ��', '����ִ� ¥�� ������ ��ܺ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 200, 17, 1, 23, '���ɽð� ���Ŀ� �ǰ��� ����', '�����ο� ¥�� �������� �Ƿθ� Ǯ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1, 18, 1, 23, '�ų��� �پ��� �̺�Ʈ��', '¥�� ������ �Բ� ��ܺ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 200, 19, 1, 23, '�ູ�� ���� �濵 �ùķ��̼� ', '¥�� ������ ��ܺ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1, 20, 1, 23, '���ִ� ���� �԰� �����Ӱ�', '¥�� ������ ���� �غ� �Ǽ̳���', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   3, 21, 1, 23, '��ȣ�� ����!!! �̹���ȸ ��ġ�� ������', '���� ���� 100���� ���������� �����', 0)

insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 100, 22, 1, 23, '�������� �߿��� ���� �־��', '�ҽ��� �������� �������ְ�, ������ǰ�� �Ⱦƺ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1, 23, 1, 23, '��������� ������� �Բ� ', '��ſ� ¥�� ������ �ų��� ��ܺ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 200, 24, 1, 23, '�����ִ� ���� �������� ¥�� ��������', '����ְ� �ų��� �������� ��ܺ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1, 25, 1, 23, '�ູ�� �ָ����� ¥������� �Բ�', '��ſ� ���� �������� ��ܺ�����', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3015, 200, 26, 1, 23, '�����Ӱ� ��� �� �ִ�', '¥�� ������ ģ����� �Բ��ؿ�', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3400,   1, 27, 1, 23, '������ �������� ¥�� ������ �Բ�', '���� ����ְ� ��ſ� �Ϸ� ��������', 0)
insert into dbo.tFVEventSub (eventstatedaily, eventitemcode, eventcnt, eventday, eventstarthour, eventendhour, eventpushtitle, eventpushmsg, eventpushstate) values(1, 3500,   1, 28, 1, 23, '¥�� �������� �پ��� �̺�Ʈ��', '�������Դϴ� �����ؼ� ������ �޾ư�����', 0)
*/
