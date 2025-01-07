-- Similar store procedure but it is used to catch the event

create trigger MakeProvinceNameUpperCase
on [dbo].[TINH_TP]
after insert 
as
begin
	update [dbo].[TINH_TP]
	set [TEN_T_TP] = UPPER(i.[TEN_T_TP])
	from inserted i
	where [dbo].[TINH_TP].TEN_T_TP = i.TEN_T_TP
end;

--insert into [dbo].[TINH_TP](MA_T_TP, TEN_T_TP, DT, DS, MIEN)
--values ('NY', N'New York', 5600, 2560000, 'Nam')

create trigger PreventDTNegative
on [dbo].[TINH_TP]
after insert
as 
begin
	if exists (select 1 from inserted where [DT]<0)
	begin
		rollback;
		raiserror ('DT khong the nho hon 0',16,1)
	end
end
	
insert into [dbo].[TINH_TP](MA_T_TP, TEN_T_TP, DT, DS, MIEN)
values ('CL', N'California', -1, 2560000, 'Nam')


