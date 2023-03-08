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
