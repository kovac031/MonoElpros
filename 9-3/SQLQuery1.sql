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

INSERT INTO Category VALUES
(newid(), 'Horror', 'Fiction', (SELECT dbo.Randv2(rand()))),
(newid(), 'Fantasy', 'Fiction', '5.67'),
(newid(), 'Historical', 'Nonfiction','),
(newid(), 'Documentary', 'Nonfiction');