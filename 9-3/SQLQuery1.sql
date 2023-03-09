CREATE DATABASE Cinemania

CREATE TABLE Category (
Id uniqueidentifier not null PRIMARY KEY,
Genre varchar(50) not null,
Class varchar(50) null,
Popularity float not null);

CREATE TABLE Movie (
Id uniqueidentifier not null PRIMARY KEY,
Title varchar(50) not null,
Release int null,
Score float null,
GenreId uniqueidentifier not null,
CONSTRAINT FK_Category FOREIGN KEY (GenreId) REFERENCES Category (Id));

CREATE FUNCTION "Randv2" (@rand float) --rand ali za score od 1-10 decimala
returns int
AS
BEGIN
declare @decimal integer;
set @decimal=(@rand * 10);
return @decimal;
END;

SELECT dbo.Randv2(rand())

ALTER FUNCTION "Randv2" (@rand float) --ne zelim int nego decimalu
returns float
AS
BEGIN
declare @decimal float;
set @decimal=(@rand * 10);
return @decimal;
END;

SELECT dbo.Randv2(rand())

INSERT INTO Category VALUES
(newid(), 'Horror', 'Fiction', (SELECT dbo.Randv2(rand()))),
(newid(), 'Fantasy', 'Fiction', (SELECT dbo.Randv2(rand()))),
(newid(), 'Historical', NULL, (SELECT dbo.Randv2(rand()))),
(newid(), 'Documentary', 'Nonfiction', (SELECT dbo.Randv2(rand()))),
(newid(), 'Romance', NULL, (SELECT dbo.Randv2(rand())));

INSERT INTO Movie VALUES
(newid(), 'Cabin in the Woods','1987', (SELECT dbo.Randv2(rand())), (SELECT "Id" FROM "Category" WHERE "Genre"='Horror')),
(newid(), 'Titanic', '1996', (SELECT dbo.Randv2(rand())), (SELECT "Id" FROM "Category" WHERE "Genre"='Historical')),
(newid(), 'Harambe', '2016', (SELECT dbo.Randv2(rand())), (SELECT "Id" FROM "Category" WHERE "Genre"='Documentary')),
(newid(), '2012', '2012', (SELECT dbo.Randv2(rand())), (SELECT "Id" FROM "Category" WHERE "Genre"='Fantasy')),
(newid(), 'Lord of the Rings','2001', (SELECT dbo.Randv2(rand())), (SELECT "Id" FROM "Category" WHERE "Genre"='Fantasy')),
(newid(), 'Resident Evil','2013', (SELECT dbo.Randv2(rand())), (SELECT "Id" FROM "Category" WHERE "Genre"='Horror')),
(newid(), 'World War 2','2000', (SELECT dbo.Randv2(rand())), (SELECT "Id" FROM "Category" WHERE "Genre"='Historical')),
(newid(), 'Kingdom of Heaven', NULL, (SELECT dbo.Randv2(rand())), (SELECT "Id" FROM "Category" WHERE "Genre"='Historical')),
(newid(), 'Batman', NULL, (SELECT dbo.Randv2(rand())), (SELECT "Id" FROM "Category" WHERE "Genre"='Fantasy')),
(newid(), 'Train to Busan', NULL, (SELECT dbo.Randv2(rand())), (SELECT "Id" FROM "Category" WHERE "Genre"='Horror')),
(newid(), 'Scary Movie', NULL, (SELECT dbo.Randv2(rand())), (SELECT "Id" FROM "Category" WHERE "Genre"='Horror')),
(newid(), 'Camelot' , NULL, (SELECT dbo.Randv2(rand())), (SELECT "Id" FROM "Category" WHERE "Genre"='Fantasy')),
(newid(), 'Space', NULL, (SELECT dbo.Randv2(rand())), (SELECT "Id" FROM "Category" WHERE "Genre"='Documentary')),
(newid(), 'Leap Year', NULL, (SELECT dbo.Randv2(rand())), (SELECT "Id" FROM "Category" WHERE "Genre"='Romance'));

SELECT * INTO "BestMovies_temp" from "Movie"
WHERE "Score" >'5'

SELECT Title, Score FROM BestMovies_temp
ORDER BY Score DESC

CREATE VIEW "Overview" as (
SELECT m."Title" as "MovieTitle", m."Release" as "ReleaseYear", c."Genre", m."Score"  
FROM "Movie" m 
full outer join "Category" c on c."Id"=m."GenreId")

SELECT * FROM Overview
ORDER BY Score DESC

