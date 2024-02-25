use master

create database BookshopDB /* �������� �� BookShopDB */
on (
	name = 'BookshopDB_dat', /* ���������� ��� ����� ������ */
	filename = 'C:\DB\Laba_2\BookshopDB_dat.mdf' /* ���� */
)
log on (
	name = 'BookshopDB_log', /* ���������� ��� ����� ������������ */
	filename = 'C:\DB\Laba_2\BookshopDB_log.ldf' /* ���� */
)

exec sp_helpdb BookshopDB /* �������� ������� ��������� �� */

use BookshopDB

create table Authors ( /* �������� ������� ������� */
	AuthorID int identity not null,
	FirstName varchar(30) not null default 'unknown',
	LastName varchar(30) null,
	YearBorn char(4) null,
	YearDied char(4) not null default 'no',
)

exec sp_help Authors /* �������� ������� ��������� ������� */

alter table Authors add Descr varchar(200) not null /* ���������� ������ ������� �������� � ������� ������� */

create table Books ( /* �������� ������� ���� */
	BookID int not null primary key,
	Title varchar(100) not null,
	Genre varchar(50) null
)

create table BookAuthor ( /* �������� ������� �����-����� */
	BookID int not null,
	AuthorID int not null
)

alter table BookAuthor /* ���������� ����������� ���������� ����� � ������� �����-����� */
add primary key (BookID, AuthorID) /* ��������� ���� �������� id ����� � id ������ */

alter table BookAuthor /* ��������� ������� ����� � �����-����� */
add constraint fk_book
foreign key (BookID) references Books(BookID) /* ������� ���� id ����� �� ������� �����-�����, ��������� ���� - id ����� �� ������� ����� */

alter table Authors
add primary key (AuthorID)

alter table BookAuthor /* ��������� ������� ������ � �����-����� */
add constraint fk_author
foreign key (AuthorID) references Authors(AuthorID) /* ������� ���� id ������ �� ������� �����-�����, ��������� ���� - id ������ �� ������� ������ */

alter table Authors add check (YearBorn like '[1-2][0,6-9][0-9][0-9]') /* ��������� ����������� ��� ������� YearBorn */

alter table Authors add check (YearDied like '[1-2][0,6-9][0-9][0-9]')  /* ��������� ����������� ��� ������� YearDied */

alter table Authors add check (YearBorn < YearDied)  /* ��������� �����������: ��� �������� ������ ���� < ���� ������ */

insert into Authors (FirstName, LastName, YearBorn, YearDied, Descr) /* ���������� ������� ������� */
values ('��������', '����������', '1893', '1930', '������� � ��������� ����. ��������. ���� �� �������� �������� ������� ������ XX ����. ������� ��������� ����������.'),
       ('�������', '��������', '1821', '1877', '������� ����, �������, ���������, ������� ������� ����������.'),
	   ('������', '���������', '1814', '1841', '������� ����, �������, ���������, ��������. ������� ����-������� ���������� �����.'),
	   ('���������', '����', '1880', '1921', ' ������� ���� ����������� ����, ��������, ���������, ���������, ����������, ������������ ������. ������� ������� ���������� XX ��������, ���� �� ���������� �������������� �������� ����������.')

insert into Books (BookID, Title, Genre) /* ���������� ������� ����� */
values (1, '������ � ������', '�����'),
	   (2, '����������', '�����'),
	   (3, '����', '�����'),
	   (4, '̸����� �����', '�����'),
	   (5, '������� �����', '�����'),
	   (6, '���� � ������', '�����')

insert into BookAuthor(AuthorID, BookID) /* ���������� ������� �����-����� */
values (1, 1), 
	   (2, 6),
	   (2, 5),
	   (4, 2),
	   (1, 3)

/* ����� ���� ������ */
select * from Authors
select * from Books
select * from BookAuthor

