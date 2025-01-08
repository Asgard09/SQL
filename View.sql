-- Syntax create View
-- create view view_name as
-- select column1, column2,..
-- from table_name
-- where condition;

-- Tạo View để lưu các tỉnh thành phố cùng với dân số và diện tích của các tỉnh
-- thành phố ở miền ‘Nam’.
create view ViewProvince
as
select [MA_T_TP], [TEN_T_TP], [DT], [DS]
from [dbo].[TINH_TP]
where [MIEN] = N'Nam'

-- Tạo View để lưu những tỉnh thành phố là biên giới. Thông tin gồm Ma_T_TP,
-- Ten_T_TP, NUOC.
create view ViewProvinceIsBorder
as
select b.[MA_T_TP], t.TEN_T_TP, b.NUOC
from [dbo].[BIENGIOI] as b
join [dbo].[TINH_TP] as t 
on b.MA_T_TP = t.MA_T_TP

select * from [dbo].ViewProvinceIsBorder


-- Tạo View để lưu các tỉnh thuộc miền Nam với diện tích lớn hơn 5000 km². Thông
-- tin gồm Ma_T_TP, Ten_T_TP, MIEN, DT.
create view ViewProvinceWithArea
as
select [MA_T_TP], [TEN_T_TP], [MIEN], [DT]
from [dbo].[TINH_TP]
where [DT] > 5000

select * from [dbo].ViewProvinceWithArea


-- Tạo View lưu danh sách các tỉnh có dân số lớn hơn 1 triệu người và các tỉnh láng
-- giềng của tỉnh thành phố đó. Thông tin gồm Ma_T_TP, Ten_T_TP, DS, LG.
create view ViewProvinceWithPopulation
as
select l.MA_T_TP, t.TEN_T_TP, t.DS, l.LG
from [dbo].[LANGGIENG] as l
join [dbo].[TINH_TP] as t 
on l.MA_T_TP = t.MA_T_TP
where t.DS > 1000000

select * from [dbo].ViewProvinceWithPopulation


-- Tạo View để tính tổng dân số của các tỉnh thành phố thuộc miền Trung. Thông
-- tin hiển thị gồm MIEN, TONGDS (tổng dân số).
create view ViewTotalPopulation
as
select SUM([DS]) as N'Tổng dân số', [MIEN]
from [dbo].[TINH_TP]
group by [MIEN]
having [MIEN] = N'Trung'

select * from [dbo].ViewTotalPopulation

-- Tạo View lưu danh sách các tỉnh cùng với tổng số các tỉnh thành phố láng giềng.
-- Thông tin gồm Ma_T_TP, TEN_T_TP, SOTINH (số tỉnh láng giềng).
CREATE VIEW V_TINH_SO_LANGGIENG AS
SELECT T.MA_T_TP,T.TEN_T_TP,COUNT(LG.MA_T_TP) AS SOTINH
FROM TINH_TP T
LEFT JOIN LANGGIENG LG ON T.MA_T_TP = LG.MA_T_TP
GROUP BY T.MA_T_TP, T.TEN_T_TP;

