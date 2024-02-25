use master

create database ShopDB /* Создание новой БД ShopDB */
on (
	name = 'ShopDB_dat', /* Логическое имя файла данных */
	filename = 'C:\DB\laba_3\ShopDB_dat.mdf' /* Путь */
)
log on(
	name = 'ShopDB_log', /* Логическое имя файла журнализации */
	filename = 'C:\DB\laba_3\ShopDB_log.ldf' /* Путь */
)

use ShopDB

create table Goods ( /* Создание таблицы Goods */
	DeptID int not null default 1, check (DeptID between 1 and 10),
	GoodId int identity(10, 10) not null primary key,
	GName varchar(20) not null,
	Descr varchar(50) null, unique (GName, Descr),
	Price smallmoney not null, check (Price > 0),
	GCount int not null, check (Gcount > 0)
)

exec sp_help Goods /* Вывод информации о таблицы Goods */

insert into Goods (DeptID, GName, Descr, Price, GCount) /* Заполнение таблицы Goods */
values (1, 'ручка', 'шариковая', 2, 100),
	   (1, 'ручка', 'гелевая', 10, 50),
       (1, 'карандаш', 'простой', 5, 200),
       (1, 'карандаш', 'механический', 10, 30),
       (2, 'мыло', 'хозяйственное', 6, 200),
       (2, 'мыло', 'детское', 7, 150),
       (2, 'шампунь', '«Чистая линия»', 50, 7)

select * from Goods /* Вывод таблицы Goods */

insert into Goods (DeptID, GName, Descr, Price, GCount) /* Добавление ещё 2 новых значений */
values (3, 'хлеб', 'сельский', 20, 30),
	   (default, 'ручка', null, 15, 40)

delete from Goods /* Удаление всех записей из таблицы Goods, у которых значение Descr = NULL */
where Descr is null

update Goods set Price = Price + (Price * 0.1) /* Увеличиваем цену на 10% для всех записей из таблицы Goods */

select * from Goods /* Вывод таблицы */

select GoodID, GName, Descr /* Вывод GoodId, GName и Descr только у тех записей из таблицы Goods, у которых id отдела = 1 */
from Goods 
where DeptID = 1

select * /* Вывод всех записей из таблицы Goods, у которых цена находится в интервале от 10 до 30*/
from Goods 
where Price between 10 and 30

select * /* Вывод всех записей из таблицы Goods, id отдела которых = 1 или = 3 */
from Goods 
where DeptID in (1, 3)

select * /* Вывести все записи от талицы Goods, у которых наименование товара начинается на символ "р" */
from Goods 
where GName like 'р%'

select * /* Вывести все записи от талицы Goods, у которых наименование товара начинается на символ "_" */
from Goods 
where GName like '%\_%' ESCAPE '\'

select GName /* Вывести наименование всех товаров */
from Goods 

select distinct GName /* Вывести наименование всех товаров без повторений */
from Goods 

select *, Price * GCount "Price-Count" /* Вывести все сведения о товарах, а также столбец (цена * кол-во) */
from Goods

select min(Price) as MinPrice, avg(Price) as AvgPrice, max(Price) as MaxPrice /* Найти минимальную, среднюю, максимальную цену товара */
from Goods

select GName, count(GName) as GNCount /* Вывести кол-во наименований товара из 1-го отдела */
from Goods 
where DeptID = 1 
group by GName

select count(GName) as SumCount /* Вывести кол-во товаров, у которых есть описание */
from Goods 
where Descr is not null

select sum(Price * GCount) as SumPrice /* Вывести суммарную стоимость всех товаров из 2-го отдела */
from Goods 
where DeptId = 2

select * /* Вывести все товары, упорядоченные по имени */
from Goods 
order by GName

select * /* Вывесети все товары, упорядоченные по id отдела и по убыванию цены */
from Goods 
order by DeptId asc, Price desc

select DeptID, sum(Price * GCount) as SumPrice /* Вывести стоимость товара по отделам*/
from Goods 
group by DeptID

select avg(Price) as AvgPrice /* Вывести среднюю цену по всем товарам, у которых цена больше 9 */
from Goods 
where Price > 9

select max(Price) as MaxPrice, GName /* Вывести максимальную ценy по каждому наименованию товара */
from Goods 
group by GName

select DeptID /* Вывести номера отделов, в которых продаются более 2 товаров */
from Goods 
group by DeptID 
having count(GName) > 2
