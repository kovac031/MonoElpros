CREATE DATABASE OsmiTreciSrijeda

CREATE TABLE Category (
Id uniqueidentifier not null PRIMARY KEY,
Genre varchar(50) not null,
Class varchar(50) null);

CREATE TABLE Movie (
Id uniqueidentifier not null PRIMARY KEY,
Title varchar(50) not null,
Release int not null,
GenreId uniqueidentifier not null,
CONSTRAINT FK_Category FOREIGN KEY (GenreId) REFERENCES Category (Id));

INSERT INTO Category VALUES
(newid(), 'Horror', 'Fiction'),
(newid(), 'Fantasy', 'Fiction'),
(newid(), 'Historical', 'Nonfiction'),
(newid(), 'Documentary', 'Nonfiction');

INSERT INTO Movie VALUES
(newid(), 'Cabin in the Woods','1987', (SELECT "Id" FROM "Category" WHERE "Genre"='Horror')),
(newid(), 'Titanic', '1996', (SELECT "Id" FROM "Category" WHERE "Genre"='Historical')),
(newid(), 'Harambe', '2016', (SELECT "Id" FROM "Category" WHERE "Genre"='Documentary')),
(newid(), '2012', '2012', (SELECT "Id" FROM "Category" WHERE "Genre"='Fantasy')),
(newid(), 'Lord of the Rings','2001', (SELECT "Id" FROM "Category" WHERE "Genre"='Fantasy')),
(newid(), 'Resident Evil','2013', (SELECT "Id" FROM "Category" WHERE "Genre"='Horror')),
(newid(), 'World War 2','2000', (SELECT "Id" FROM "Category" WHERE "Genre"='Historical'));