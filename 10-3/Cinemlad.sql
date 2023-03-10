CREATE DATABASE Cinemlad

CREATE TABLE Showing (
Id uniqueidentifier not null PRIMARY KEY,
Title varchar(50) not null,
Release int not null,
Genre varchar(50) null,
Duration int not null,
ShowingStart date not null, --početak prikazivanja u godini
ShowingEnd date not null,
StartTime time not null); --u koliko sati taj dan se prikazuje

CREATE TABLE Revenue (
Id uniqueidentifier not null PRIMARY KEY,
CustomerId uniqueidentifier not null,
RevenueWhen datetime not null,
Category varchar(50) null,
Amount int not null,
SingleItemRev int not null, --jedinični prihod
SumItemRev int not null); --jedinični puta količina

CREATE TABLE ShowingRevenue (
Id uniqueidentifier not null PRIMARY KEY,
FilmId uniqueidentifier not null,
RevenueId uniqueidentifier not null,
CONSTRAINT FK_Showing FOREIGN KEY (FilmId) REFERENCES Showing(Id),
CONSTRAINT FK_Revenue FOREIGN KEY (RevenueId) REFERENCES Revenue(Id));