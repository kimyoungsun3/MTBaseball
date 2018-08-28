use Farm
GO

DECLARE @tItemExpire TABLE(
	itemcode	int,
	itemname	varchar(128),
	fresh		int
);


insert into @tItemExpire
select itemcode, itemname, param6 fresh from dbo.tFVItemInfo
where category = 1 and subcategory in (1, 2, 3) --and itmename not like '%πÃ¡§%'


select * from @tItemExpire order by fresh asc

delete from @tItemExpire
insert into @tItemExpire select itemcode, itemname, param6 fresh from dbo.tFVItemInfo where itemcode in (4, 201, 200, 104, 203, 105, 8, 9, 106, 204, 205, 107, 10, 11, 108, 206, 207, 109, 12, 13, 110, 208, 111, 14, 15, 209, 210, 112 ,211 ,113)
select * from @tItemExpire order by fresh asc