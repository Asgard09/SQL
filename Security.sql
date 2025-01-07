use master 
go 
create login DB_USER
	with password = N'123',
	check_expiration = off,
	check_policy = off
go

use DiaLy
go
create user DB_USER for login DB_USER;

ALTER ROLE db_datareader ADD MEMBER DB_USER;  -- Cho phép đọc dữ liệu
ALTER ROLE db_datawriter ADD MEMBER DB_USER; -- Cho phép ghi dữ liệu

GRANT SELECT ON [dbo].[TINH_TP] TO DB_USER;

--Thu hoi
REVOKE SELECT ON [dbo].[TINH_TP] FROM DB_USER;

--Tu choi quyen 
DENY SELECT ON [dbo].[TINH_TP] TO DB_USER;


