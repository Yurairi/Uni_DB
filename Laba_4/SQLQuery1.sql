use ShopDB /* Используем БД ShopDB */

create table Departments ( /* Создаём новую таблицу департаменты */
	DeptID int not null primary key, check (DeptID between 1 and 10),
	DeptName varchar(50) not null
)

insert into Departments (DeptID, DeptName)/* Заполняем таблицу департаменты */
	values (1, 'Канцелярия'),
			(2, 'Хоз товары'),
			(3, 'Пекарня')

select distinct DeptId, '' as DeptNAme
from Goods

select * from Goods, Departments /* Вывод с помощью декартового произведения */

select * /* Вывод с условием соединения по столбцу DeptId */
from Goods, Departments 
where Goods.DeptID = Departments.DeptID

select * /* Внутреннее соединение таблиц Departments и Goods по столбцу DeptId */
from Goods join Departments 
on Goods.DeptID = Departments.DeptID

insert into Departments (DeptID, DeptName) /* Добавление нового отдела в департаменты */
values (4, 'Молочный')

select * /* Внешнее левое соединение таблиц Departments и Goods по столбцу DeptId */
from Departments left join Goods 
on Goods.DeptID = Departments.DeptID

insert into Goods (DeptID, GName, Descr, Price, GCount) /* Добаление нового товара в таблицу Goods */
values (5, 'творог', '5%', 67, 45)

select * /* Внешнее правое соединение таблиц Departments и Goods по столбцу DeptId */
from Departments right join Goods 
on Goods.DeptID = Departments.DeptID

select * /* Полное соединение таблиц Departments и Goods по столбцу DeptId */
from Departments full join Goods 
on Goods.DeptID = Departments.DeptID

select * /* Вывод отделов, для которых нет товаров, и товаров, для которых нет отделов */
from Departments full join Goods 
on Goods.DeptID = Departments.DeptID 
except
select * 
from Departments join Goods 
on Goods.DeptID = Departments.DeptID

select Departments.DeptID, DeptName /* Вывод всех отделов, в которых продается хотя бы 1 товар */
from Departments left join Goods 
on Goods.DeptID = Departments.DeptID 
group by Departments.DeptID, DeptName  
having count(Gname) > 0 /* С помощью COUNT() */

select distinct Departments.DeptID,DeptName /* Вывод всех отделов, в которых продается хотя бы 1 товар */
from Departments left join Goods 
on Goods.DeptID = Departments.DeptID 
where Departments.DeptID = any ( /* С помощью any */
	select distinct DeptID 
	from Goods 
	where Descr is not null
)

select distinct Departments.DeptID,DeptName /* Вывод всех отделов, в которых продается хотя бы 1 товар */
from Departments left join Goods 
on Goods.DeptID = Departments.DeptID 
where Departments.DeptID in ( /* С помощью in */
	select distinct DeptID 
	from Goods 
	where Descr is not null
)

/* Вывести id, название, суммарную стоимость проданного товара для каждого из отделов */
select distinct Goods.DeptID, Departments.DeptName, sum(Price * GCount) as SumPrice
from Departments left join Goods 
on Goods.DeptID = Departments.DeptID 
where Descr is not null 
group by Goods.DeptID, Departments.DeptName

/* Вывести id и название отдела, у которого наибольшая сумма проданного товара */
select DeptID, DeptName
from (
	select distinct top 1 Goods.DeptID, Departments.DeptName, sum(Price * GCount) as SumPrice
	from Departments left join Goods 
	on Goods.DeptID = Departments.DeptID 
	where Descr is not null 
	group by Goods.DeptID,Departments.DeptName
	order by SumPrice desc
) t

/* Вывести id и название 2 отделов, у которых наибольшая сумма проданного товара */
select DeptID, DeptName
from (
	select distinct top 2 Goods.DeptID, Departments.DeptName, sum(Price * GCount) as SumPrice
	from Departments left join Goods 
	on Goods.DeptID = Departments.DeptID 
	where Descr is not null 
	group by Goods.DeptID,Departments.DeptName
	order by SumPrice desc
) t

/* Вывести процентное соотношение стоимости товара от суммарной стоимости товаров в отделе */
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

 /* Повышение цены всех товаров на 10% от средней цены на товар по всей таблице Goods */
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

select * from Goods /* Вывод таблицы Goods */

select *, case /* Формирование новой таблицы со скидками */
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

alter table Goods /* Связываем таблицы Departments и Goods по ключу DeptId */
add constraint fk_dept
foreign key (DeptId) references Departments(DeptId)

exec sp_help Goods /* Вывод информации по таблице Goods */
