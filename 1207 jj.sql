create proc grd
@���� char(2)
as
select max(����)
from ����
where ����=@����

exec grd '��'

--------------------------

create proc top5
as
select top 5 *
from ����
order by ���� desc

exec top5

--------------------------
create proc book
@���ǻ��ڵ� varchar(30), @���å���� int output
as
select @���å����=avg(����)
from å
where ���ǻ��ڵ�=@���ǻ��ڵ�

declare @���å���� int
exec book 'P005', @���å���� output
select @���å����

--------------------------
create proc bookRT
@���ǻ��ڵ� varchar(30)
as
declare @���å���� int
select @���å���� = avg(����)
from å
where ���ǻ��ڵ�=@���ǻ��ڵ�
return @���å����

declare @���å���� int
exec @���å����=bookRT 'P005'
select @���å����

 --------------------------

--Ƽ�����̺�
create table Ƽ��
(��ȣ int identity,
 �Ƶ� int,
 û�ҳ� int,
 ���� int)

--ȸ�����̺�
create table ȸ��
(ȸ��ID char(10) primary key,
 �̸� char(20),
 ���ϸ��� int default 500,
 ����� char(10))

 --------------------------
 create trigger isrt
 on Ƽ��
 after insert
 as
 begin
	 select (�Ƶ�*2000 + û�ҳ�*3000 + ����*5000)
	 from inserted
 end

 insert Ƽ�� values (2,1,2)
 insert Ƽ�� values (4,1,2)

 select * from Ƽ��
 drop table Ƽ��
 drop trigger isrt

  --------------------------
 create trigger upt
 on Ƽ��
 after update
 as
 begin
	 select (�Ƶ�*2000 + û�ҳ�*3000 + ����*5000) from inserted
 end

 update Ƽ�� set �Ƶ�=3 where ��ȣ=2

 --------------------------
insert ȸ�� values ('abc','ȫ�浿',2500,null)
insert ȸ�� values ('angel','�輱��',5100,null)
insert ȸ�� values ('bw77','�ֿ���',1250,null)
  --------------------------
create function fn_id (@name varchar(20))
	returns varchar(20)
as
begin
	return(select �̸� from ȸ�� where ȸ��ID=@name )
end

select dbo.fn_id('abc')

--------------------------
create function f_ȸ��1(@��� varchar(5))
	returns table
as
return(select ȸ��ID,�̸� from ȸ�� where �����=@���)

select * from dbo.f_ȸ��1('VIP')

--------------------------
create function f_ȸ��2(@��� varchar(5))
returns @t table (ȸ��id char(10), �̸� char(20))
as
begin
	insert @t
	select ȸ��id, �̸�
	from ȸ��
	where �����=@���
	return
end

select * from dbo.f_ȸ��2('VIP')