use master

create database BookshopDB /* Создание БД BookShopDB */
on (
	name = 'BookshopDB_dat', /* Логическое имя файла данных */
	filename = 'C:\DB\Laba_2\BookshopDB_dat.mdf' /* Путь */
)
log on (
	name = 'BookshopDB_log', /* Логическое имя файла журнализации */
	filename = 'C:\DB\Laba_2\BookshopDB_log.ldf' /* Путь */
)

exec sp_helpdb BookshopDB /* Просмотр свойств созданной БД */

use BookshopDB

create table Authors ( /* Создание таблицы авторов */
	AuthorID int identity not null,
	FirstName varchar(30) not null default 'unknown',
	LastName varchar(30) null,
	YearBorn char(4) null,
	YearDied char(4) not null default 'no',
)

exec sp_help Authors /* Просмотр свойств созданной таблицы */

alter table Authors add Descr varchar(200) not null /* Добавление нового сталбца описание в таблицу авторов */

create table Books ( /* Создание таблицы книг */
	BookID int not null primary key,
	Title varchar(100) not null,
	Genre varchar(50) null
)

create table BookAuthor ( /* Создание таблицы книга-автор */
	BookID int not null,
	AuthorID int not null
)

alter table BookAuthor /* Добавление ограничения первичного ключа в таблицу книга-автор */
add primary key (BookID, AuthorID) /* Первычный ключ содержит id книги и id автора */

alter table BookAuthor /* Связываем таблицы книги и книга-автор */
add constraint fk_book
foreign key (BookID) references Books(BookID) /* Внешний ключ id книги из таблицы книга-автор, первичный ключ - id книги из таблицы книги */

alter table Authors
add primary key (AuthorID)

alter table BookAuthor /* Связываем таблицы авторы и книга-автор */
add constraint fk_author
foreign key (AuthorID) references Authors(AuthorID) /* Внешний ключ id автора из таблицы книга-автор, первичный ключ - id автора из таблицы авторы */

alter table Authors add check (YearBorn like '[1-2][0,6-9][0-9][0-9]') /* Добавляет ограничение для столбца YearBorn */

alter table Authors add check (YearDied like '[1-2][0,6-9][0-9][0-9]')  /* Добавляет ограничение для столбца YearDied */

alter table Authors add check (YearBorn < YearDied)  /* Добавляет ограничение: год рождения должна быть < года смерти */

insert into Authors (FirstName, LastName, YearBorn, YearDied, Descr) /* Заполнение таблицы авторов */
values ('Владимир', 'Маяковский', '1893', '1930', 'Русский и советский поэт. Футурист. Один из наиболее значимых русских поэтов XX века. Классик советской литературы.'),
       ('Николай', 'Некрасов', '1821', '1877', 'Русский поэт, прозаик, публицист, классик русской литературы.'),
	   ('Михаил', 'Лермонтов', '1814', '1841', 'Русский поэт, прозаик, драматург, художник. Поручик лейб-гвардии Гусарского полка.'),
	   ('Александр', 'Блок', '1880', '1921', ' Русский поэт Серебряного века, писатель, публицист, драматург, переводчик, литературный критик. Классик русской литературы XX столетия, один из крупнейших представителей русского символизма.')

insert into Books (BookID, Title, Genre) /* Заполнение таблицы книги */
values (1, 'Облако в штанах', 'Поэма'),
	   (2, 'Двенадцать', 'Поэма'),
	   (3, 'Баня', 'Пьеса'),
	   (4, 'Мёртвое озеро', 'Роман'),
	   (5, 'Осенняя скука', 'Пьеса'),
	   (6, 'Федя и Володя', 'Пьеса')

insert into BookAuthor(AuthorID, BookID) /* Заполнение таблицы книга-автор */
values (1, 1), 
	   (2, 6),
	   (2, 5),
	   (4, 2),
	   (1, 3)

/* Вывод всех таблиц */
select * from Authors
select * from Books
select * from BookAuthor

