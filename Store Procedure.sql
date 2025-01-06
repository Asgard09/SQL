create procedure GetTinhByName
	@Name nvarchar(50)
as
begin
	select * from [dbo].[TINH_TP] where [TEN_T_TP] = @Name
end;

exec GetTinhByName @Name = N'An Giang';

-- Tạo Procedure P1 nhận vào miền và trả về số lượng tỉnh/thành phố trong miền đó. Viết đoạn lệnh thực hiện P1 và in kết quả.
create procedure P1
	@Mien nvarchar(50),
	@SoLuong int output
as
begin
	select @SoLuong = COUNT(*)
	from [dbo].[TINH_TP]
	where @Mien = [MIEN]
end;
go

declare @Name nvarchar(50) = 'Nam';
declare @Soluong int;

exec P1 @Mien = @Name, @SoLuong = @Soluong output;
print N'So luong tinh/thanh thuoc mien ' + @Name + ' la ' +CAST(@Soluong as nvarchar(10));