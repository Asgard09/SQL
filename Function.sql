-- Tạo function F1 nhận vào tên miền và trả về mật độ dân số trung bình của miền
-- đó. Viết lệnh gọi và hiển thị kết quả từ F1.
create function F1 (@Name nvarchar(50))
returns float
as 
begin 
	declare @res float;
	select @res = AVG([DS]/[DT])
	from [dbo].[TINH_TP]
	where [MIEN] = @Name;
	return @res
end;

print [dbo].[F1]('Nam');


--Tạo function F2 tham số truyền vào là một số nguyên. Trả về danh sách các tỉnh/
--thành phố có dân số nhỏ hơn số truyền vào.
create function F2(@Input int)
returns table
as 
return 
(
	select [TEN_T_TP]
	from [dbo].[TINH_TP]
	where [DS] < @Input
)
select * from [dbo].[F2](500000)

--Tạo function F3 nhận vào một số nguyên. Trả về danh sách các tỉnh/thành phố
--có diện tích lớn hơn số truyền vào. Nếu không có tỉnh/thành phố nào có diện tích
--lớn hơn số truyền vào thì hiển thị câu “số bạn yêu cầu quá lớn”.

create function F3(@Input int)
returns table
as 
return
(
	select [TEN_T_TP]
	from [dbo].[TINH_TP]
	where [DT] > @Input
)

declare @Res int;

select @Res = COUNT(*)
from [dbo].[F3](10000000)

IF @Res = 0
begin
	print('So ban yeu cau qua lon')
end
else
begin 
	select * from [dbo].[F3](10000000)
end

--Tạo function F4 nhận vào một trong 2 yếu cầu: “dân số lớn nhất” hoặc “mật độ
--dân số lớn nhất”. kết quả trả về là tên tỉnh/thành phố thỏa theo yêu cầu. Trường
--hợp đưa ra yêu cầu khác thì câu trả lời là “không có chức năng này”.
create function F4(@Request nvarchar(100))
returns nvarchar(100)
as 
begin
	declare @Res nvarchar(100)
	if @Request = N'dân số lớn nhất'
	begin 
		select top 1 @Res = [TEN_T_TP]
		from [dbo].[TINH_TP]
		order by [DS] desc
	end
	else if @Request = N'mật độ dân số lớn nhất'
	begin
		select top 1 @Res = [TEN_T_TP]
		from [dbo].[TINH_TP]
		order by [DS]/[DT] desc
	end
	else
	begin 
		set @Res = N'Khong co chuc nang nay'
	end
	return @Res
end

print([dbo].[F4](N'mật độ dân số lớn nhất'))



