use ShopDB /* ���������� �� ShopDB */

create table Departments ( /* ������ ����� ������� ������������ */
	DeptID int not null primary key, check (DeptID between 1 and 10),
	DeptName varchar(50) not null
)

insert into Departments (DeptID, DeptName)/* ��������� ������� ������������ */
	values (1, '����������'),
			(2, '��� ������'),
			(3, '�������')

select distinct DeptId, '' as DeptNAme
from Goods

select * from Goods, Departments /* ����� � ������� ����������� ������������ */

select * /* ����� � �������� ���������� �� ������� DeptId */
from Goods, Departments 
where Goods.DeptID = Departments.DeptID

select * /* ���������� ���������� ������ Departments � Goods �� ������� DeptId */
from Goods join Departments 
on Goods.DeptID = Departments.DeptID

insert into Departments (DeptID, DeptName) /* ���������� ������ ������ � ������������ */
values (4, '��������')

select * /* ������� ����� ���������� ������ Departments � Goods �� ������� DeptId */
from Departments left join Goods 
on Goods.DeptID = Departments.DeptID

insert into Goods (DeptID, GName, Descr, Price, GCount) /* ��������� ������ ������ � ������� Goods */
values (5, '������', '5%', 67, 45)

select * /* ������� ������ ���������� ������ Departments � Goods �� ������� DeptId */
from Departments right join Goods 
on Goods.DeptID = Departments.DeptID

select * /* ������ ���������� ������ Departments � Goods �� ������� DeptId */
from Departments full join Goods 
on Goods.DeptID = Departments.DeptID

select * /* ����� �������, ��� ������� ��� �������, � �������, ��� ������� ��� ������� */
from Departments full join Goods 
on Goods.DeptID = Departments.DeptID 
except
select * 
from Departments join Goods 
on Goods.DeptID = Departments.DeptID

select Departments.DeptID, DeptName /* ����� ���� �������, � ������� ��������� ���� �� 1 ����� */
from Departments left join Goods 
on Goods.DeptID = Departments.DeptID 
group by Departments.DeptID, DeptName  
having count(Gname) > 0 /* � ������� COUNT() */

select distinct Departments.DeptID,DeptName /* ����� ���� �������, � ������� ��������� ���� �� 1 ����� */
from Departments left join Goods 
on Goods.DeptID = Departments.DeptID 
where Departments.DeptID = any ( /* � ������� any */
	select distinct DeptID 
	from Goods 
	where Descr is not null
)

select distinct Departments.DeptID,DeptName /* ����� ���� �������, � ������� ��������� ���� �� 1 ����� */
from Departments left join Goods 
on Goods.DeptID = Departments.DeptID 
where Departments.DeptID in ( /* � ������� in */
	select distinct DeptID 
	from Goods 
	where Descr is not null
)

/* ������� id, ��������, ��������� ��������� ���������� ������ ��� ������� �� ������� */
select distinct Goods.DeptID, Departments.DeptName, sum(Price * GCount) as SumPrice
from Departments left join Goods 
on Goods.DeptID = Departments.DeptID 
where Descr is not null 
group by Goods.DeptID, Departments.DeptName

/* ������� id � �������� ������, � �������� ���������� ����� ���������� ������ */
select DeptID, DeptName
from (
	select distinct top 1 Goods.DeptID, Departments.DeptName, sum(Price * GCount) as SumPrice
	from Departments left join Goods 
	on Goods.DeptID = Departments.DeptID 
	where Descr is not null 
	group by Goods.DeptID,Departments.DeptName
	order by SumPrice desc
) t

/* ������� id � �������� 2 �������, � ������� ���������� ����� ���������� ������ */
select DeptID, DeptName
from (
	select distinct top 2 Goods.DeptID, Departments.DeptName, sum(Price * GCount) as SumPrice
	from Departments left join Goods 
	on Goods.DeptID = Departments.DeptID 
	where Descr is not null 
	group by Goods.DeptID,Departments.DeptName
	order by SumPrice desc
) t

/* ������� ���������� ����������� ��������� ������ �� ��������� ��������� ������� � ������ */
select GoodId, GName, (Price / SumPrice * 100) as PercentPrice
from Departments full join Goods 
on Goods.DeptID = Departments.DeptID
left join (
	select distinct Goods.DeptID, Departments.DeptName, sum(Price) as SumPrice
	from Departments left join Goods 
	on Goods.DeptID = Departments.DeptID 
	where Descr is not null 
	group by Goods.DeptID,Departments.DeptName
) t
 on Goods.DeptID = t.DeptID 
 where Descr is not null and t.DeptName is not null

 /* ��������� ���� ���� ������� �� 10% �� ������� ���� �� ����� �� ���� ������� Goods */
update Goods set Price = Price + (AvgPrice * 0.1)
from Goods left join (
    select GoodID, GName, AvgPrice
    from Departments full join Goods
    on Goods.DeptID = Departments.DeptID
    left join (
        select Departments.DeptID, DeptName, avg(Price) as AvgPrice
        from Departments left join Goods
        on Goods.DeptID = Departments.DeptID
        group by Departments.DeptID, DeptName
    ) t
    on Departments.DeptID = t.DeptID
    where GoodID is not null
) t
on Goods.GoodID = t.GoodID
where SumPrice is not null

select * from Goods /* ����� ������� Goods */

select *, case /* ������������ ����� ������� �� �������� */
	when Price < 10 then Price * 0.2
	when 10 <= Price and Price <= 50 then Price * 0.1
	else Price * 0.05
end as PriceDiscount
from Goods

insert into Departments
select DeptID, '' as DeptName
from Goods
where DeptID not in (
	select distinct DeptID
	from Departments
)

alter table Goods /* ��������� ������� Departments � Goods �� ����� DeptId */
add constraint fk_dept
foreign key (DeptId) references Departments(DeptId)

exec sp_help Goods /* ����� ���������� �� ������� Goods */
