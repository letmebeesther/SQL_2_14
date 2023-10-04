create proc grd
@성별 char(2)
as
select max(점수)
from 성적
where 성별=@성별

exec grd '남'

--------------------------

create proc top5
as
select top 5 *
from 성적
order by 점수 desc

exec top5

--------------------------
create proc book
@출판사코드 varchar(30), @평균책가격 int output
as
select @평균책가격=avg(가격)
from 책
where 출판사코드=@출판사코드

declare @평균책가격 int
exec book 'P005', @평균책가격 output
select @평균책가격

--------------------------
create proc bookRT
@출판사코드 varchar(30)
as
declare @평균책가격 int
select @평균책가격 = avg(가격)
from 책
where 출판사코드=@출판사코드
return @평균책가격

declare @평균책가격 int
exec @평균책가격=bookRT 'P005'
select @평균책가격

 --------------------------

--티켓테이블
create table 티켓
(번호 int identity,
 아동 int,
 청소년 int,
 성인 int)

--회원테이블
create table 회원
(회원ID char(10) primary key,
 이름 char(20),
 마일리지 int default 500,
 고객등급 char(10))

 --------------------------
 create trigger isrt
 on 티켓
 after insert
 as
 begin
	 select (아동*2000 + 청소년*3000 + 성인*5000)
	 from inserted
 end

 insert 티켓 values (2,1,2)
 insert 티켓 values (4,1,2)

 select * from 티켓
 drop table 티켓
 drop trigger isrt

  --------------------------
 create trigger upt
 on 티켓
 after update
 as
 begin
	 select (아동*2000 + 청소년*3000 + 성인*5000) from inserted
 end

 update 티켓 set 아동=3 where 번호=2

 --------------------------
insert 회원 values ('abc','홍길동',2500,null)
insert 회원 values ('angel','김선달',5100,null)
insert 회원 values ('bw77','최영희',1250,null)
  --------------------------
create function fn_id (@name varchar(20))
	returns varchar(20)
as
begin
	return(select 이름 from 회원 where 회원ID=@name )
end

select dbo.fn_id('abc')

--------------------------
create function f_회원1(@등급 varchar(5))
	returns table
as
return(select 회원ID,이름 from 회원 where 고객등급=@등급)

select * from dbo.f_회원1('VIP')

--------------------------
create function f_회원2(@등급 varchar(5))
returns @t table (회원id char(10), 이름 char(20))
as
begin
	insert @t
	select 회원id, 이름
	from 회원
	where 고객등급=@등급
	return
end

select * from dbo.f_회원2('VIP')