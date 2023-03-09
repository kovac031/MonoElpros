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