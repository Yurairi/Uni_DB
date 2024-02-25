use master

create database ShopDB /* �������� ����� �� ShopDB */
on (
	name = 'ShopDB_dat', /* ���������� ��� ����� ������ */
	filename = 'C:\DB\laba_3\ShopDB_dat.mdf' /* ���� */
)
log on(
	name = 'ShopDB_log', /* ���������� ��� ����� ������������ */
	filename = 'C:\DB\laba_3\ShopDB_log.ldf' /* ���� */
)

use ShopDB

create table Goods ( /* �������� ������� Goods */
	DeptID int not null default 1, check (DeptID between 1 and 10),
	GoodId int identity(10, 10) not null primary key,
	GName varchar(20) not null,
	Descr varchar(50) null, unique (GName, Descr),
	Price smallmoney not null, check (Price > 0),
	GCount int not null, check (Gcount > 0)
)

exec sp_help Goods /* ����� ���������� � ������� Goods */

insert into Goods (DeptID, GName, Descr, Price, GCount) /* ���������� ������� Goods */
values (1, '�����', '���������', 2, 100),
	   (1, '�����', '�������', 10, 50),
       (1, '��������', '�������', 5, 200),
       (1, '��������', '������������', 10, 30),
       (2, '����', '�������������', 6, 200),
       (2, '����', '�������', 7, 150),
       (2, '�������', '������� ������', 50, 7)

select * from Goods /* ����� ������� Goods */

insert into Goods (DeptID, GName, Descr, Price, GCount) /* ���������� ��� 2 ����� �������� */
values (3, '����', '��������', 20, 30),
	   (default, '�����', null, 15, 40)

delete from Goods /* �������� ���� ������� �� ������� Goods, � ������� �������� Descr = NULL */
where Descr is null

update Goods set Price = Price + (Price * 0.1) /* ����������� ���� �� 10% ��� ���� ������� �� ������� Goods */

select * from Goods /* ����� ������� */

select GoodID, GName, Descr /* ����� GoodId, GName � Descr ������ � ��� ������� �� ������� Goods, � ������� id ������ = 1 */
from Goods 
where DeptID = 1

select * /* ����� ���� ������� �� ������� Goods, � ������� ���� ��������� � ��������� �� 10 �� 30*/
from Goods 
where Price between 10 and 30

select * /* ����� ���� ������� �� ������� Goods, id ������ ������� = 1 ��� = 3 */
from Goods 
where DeptID in (1, 3)

select * /* ������� ��� ������ �� ������ Goods, � ������� ������������ ������ ���������� �� ������ "�" */
from Goods 
where GName like '�%'

select * /* ������� ��� ������ �� ������ Goods, � ������� ������������ ������ ���������� �� ������ "_" */
from Goods 
where GName like '%\_%' ESCAPE '\'

select GName /* ������� ������������ ���� ������� */
from Goods 

select distinct GName /* ������� ������������ ���� ������� ��� ���������� */
from Goods 

select *, Price * GCount "Price-Count" /* ������� ��� �������� � �������, � ����� ������� (���� * ���-��) */
from Goods

select min(Price) as MinPrice, avg(Price) as AvgPrice, max(Price) as MaxPrice /* ����� �����������, �������, ������������ ���� ������ */
from Goods

select GName, count(GName) as GNCount /* ������� ���-�� ������������ ������ �� 1-�� ������ */
from Goods 
where DeptID = 1 
group by GName

select count(GName) as SumCount /* ������� ���-�� �������, � ������� ���� �������� */
from Goods 
where Descr is not null

select sum(Price * GCount) as SumPrice /* ������� ��������� ��������� ���� ������� �� 2-�� ������ */
from Goods 
where DeptId = 2

select * /* ������� ��� ������, ������������� �� ����� */
from Goods 
order by GName

select * /* �������� ��� ������, ������������� �� id ������ � �� �������� ���� */
from Goods 
order by DeptId asc, Price desc

select DeptID, sum(Price * GCount) as SumPrice /* ������� ��������� ������ �� �������*/
from Goods 
group by DeptID

select avg(Price) as AvgPrice /* ������� ������� ���� �� ���� �������, � ������� ���� ������ 9 */
from Goods 
where Price > 9

select max(Price) as MaxPrice, GName /* ������� ������������ ���y �� ������� ������������ ������ */
from Goods 
group by GName

select DeptID /* ������� ������ �������, � ������� ��������� ����� 2 ������� */
from Goods 
group by DeptID 
having count(GName) > 2
