CREATE DATABASE MyDB;

USE MyDB
GO

CREATE TABLE table1
(
	id int NOT NULL,
	fio varchar(20) NULL,
	datar date
)

INSERT INTO table1 (id, fio, datar)
	VALUES 
		(0, 'Иванов Р.Д.', '2023-04-05'),
		(1, 'Ваненко Р.Л.', '1954-04-01'),
		(2, 'Сергеенко Н.Л.', '1705-07-26');

SELECT * FROM table1

ALTER DATABASE MyDB ADD FILEGROUP Firstgroup

ALTER DATABASE MyDB ADD FILE
(
	NAME = my_file,
	FILENAME = 'C:\DB\Laba_1\new_file.ndf'
)
TO FILEGROUP Firstgroup

ALTER DATABASE MyDB MODIFY FILEGROUP Firstgroup DEFAULT

CREATE DATABASE MyDB_snapshot ON
(
	NAME = my_file,
	FILENAME = 'C:\DB\Laba_1\my_file.ss'
),
(
	NAME = MyDB,
	FILENAME = 'C:\DB\Laba_1\MyDB.ss'
)
AS SNAPSHOT OF MyDB

SELECT * FROM MyDB.dbo.table1 WHERE id = 0
SELECT * FROM MyDB_snapshot.dbo.table1 WHERE id = 0

UPDATE table1 SET fio = 'CHANGED' WHERE id = 0

SELECT * FROM MyDB.dbo.table1 WHERE id = 0
SELECT * FROM MyDB_snapshot.dbo.table1 WHERE id = 0

DROP DATABASE MyDB_snapshot

USE master

 DROP DATABASE MyDB