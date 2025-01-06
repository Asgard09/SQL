-- Mỗi procedure có thể trả về 1 hoặc nhiều output
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

-- Tạo Procedure P2 cho biết miền nào có nhiều tỉnh/thành phố nhất (yêu cầu trong P2 gọi P1 và so sánh kết quả trả về).
CREATE PROCEDURE P2
AS
BEGIN
    DECLARE @MIEN_Bac INT, @MIEN_Trung INT, @MIEN_Nam INT;

    -- Gọi thủ tục P1 và lưu kết quả trả về vào các biến
    EXEC P1 @MIEN = 'Bắc', @SoLuong = @MIEN_Bac OUTPUT;
    EXEC P1 @MIEN = 'Trung', @SoLuong = @MIEN_Trung OUTPUT;
    EXEC P1 @MIEN = 'Nam', @SoLuong = @MIEN_Nam OUTPUT;

    -- So sánh kết quả trả về từ P1 và in kết quả
    IF @MIEN_Bac >= @MIEN_Trung AND @MIEN_Bac >= @MIEN_Nam
	-- Nếu một khối IF hoặc ELSE bao gồm nhiều lệnh, chúng phải được bao bọc trong một khối BEGIN ... END
    BEGIN
        PRINT N'Miền có nhiều tỉnh/thành phố nhất là miền Bắc với ' + CAST(@MIEN_Bac AS NVARCHAR(10)) + N' tỉnh/thành phố.';
    END
    ELSE IF @MIEN_Trung >= @MIEN_Bac AND @MIEN_Trung >= @MIEN_Nam
    BEGIN
        PRINT N'Miền có nhiều tỉnh/thành phố nhất là miền Trung với ' + CAST(@MIEN_Trung AS NVARCHAR(10)) + N' tỉnh/thành phố.';
    END
    ELSE
    BEGIN
        PRINT N'Miền có nhiều tỉnh/thành phố nhất là miền Nam với ' + CAST(@MIEN_Nam AS NVARCHAR(10)) + N' tỉnh/thành phố.';
    END
END;
GO

exec P2

-- Tạo Procedure P3 nhận vào tên một tỉnh/thành phố và cho biết miền mà tỉnh/thành phố đó thuộc về.
create procedure P3
	@Tinh nvarchar(50),
	@Mien nvarchar(50) output
as
begin
	select @Mien = [MIEN] 
	from [dbo].[TINH_TP]
	where @Tinh = [TEN_T_TP]
end

declare @TenTinh nvarchar(50) = N'An Giang';
declare @TenMien nvarchar(50)
exec P3 @Tinh = @TenTinh, @Mien = @TenMien output;
print N'Tinh ' + @TenTinh + ' thuoc mien ' + @TenMien

-- Tạo Procedure P4 cho biết tên miền có chứa tỉnh/thành phố có diện tích lớn nhất cả nước.
create procedure P4
as
begin
	declare @Tinh nvarchar(50)
	declare @Mien nvarchar(50)
	select top 1 @Tinh = [TEN_T_TP], @Mien = [MIEN]
	from [dbo].[TINH_TP]
	order by [DT] DESC;
	print N'Tinh ' + @Tinh + ' thuoc mien ' + @Mien + ' co dien tich lon nhat';
end

exec P4

-- Tạo Procedure P5 nhận vào một số nguyên và hiển thị danh sách các tỉnh/thành phố có diện tích lớn hơn số đó.
create procedure P5
	@Input int
as
begin
	Select [TEN_T_TP] 
	from [dbo].[TINH_TP]
	where [DT] < @Input
end

exec P5 @Input = 4000;

