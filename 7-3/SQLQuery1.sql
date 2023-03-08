CREATE DATABASE actorsdb5;

CREATE TABLE Actor (
Id uniqueidentifier not null PRIMARY KEY,
First_name varchar(100) not null,
Last_name varchar(100) not null);

CREATE TABLE Actor_id_info (
Id uniqueidentifier not null PRIMARY KEY FOREIGN KEY REFERENCES Actor (Id),
Id_number varchar(100) not null,
Issue_date date not null,
Expiration_date date not null);

CREATE TABLE Oscar (
Id uniqueidentifier not null PRIMARY KEY,
Oscar_category varchar(100) not null,
CONSTRAINT FK_Actor FOREIGN KEY (Id) REFERENCES Actor (Id));

CREATE TABLE Film (
Id uniqueidentifier not null PRIMARY KEY,
Movie_name varchar(100) not null,
Genre varchar(100) not null,
Release_year int not null);

CREATE TABLE ActorFilm (
Id uniqueidentifier not null PRIMARY KEY,
Actor_id uniqueidentifier not null FOREIGN KEY REFERENCES Actor(Id),
Film_id uniqueidentifier not null FOREIGN KEY REFERENCES Film(Id));

INSERT INTO Actor VALUES (newid(), 'Brad', 'Pitt');
INSERT INTO Actor VALUES (newid(), 'Angelina', 'Jolie');
INSERT INTO Actor VALUES (newid(), 'Chris', 'Rock');
INSERT INTO Actor_id_info VALUES ((SELECT "Id" FROM "Actor" WHERE "First_name"='Brad'), rand(), '1/1/2022', '1/1/2023');
INSERT INTO Oscar VALUES (newid(), rand());
INSERT INTO Film VALUES (newid(), rand(), rand(), '2002');
INSERT INTO ActorFilm VALUES (newid(), newid(), newid());