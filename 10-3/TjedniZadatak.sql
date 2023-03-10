CREATE DATABASE SmallCinema

CREATE TABLE Ticket (
Id uniqueidentifier not null PRIMARY KEY,
PurchaseTime datetime not null,
ViewingId uniqueidentifier not null,
SeatingId uniqueidentifier not null,
CustomerId uniqueidentifier not null);

CREATE TABLE Viewing (
Id uniqueidentifier not null PRIMARY KEY,
FilmId uniqueidentifier not null,
StartsAt time not null,
StartsOn date not null);

CREATE TABLE Film (
Id uniqueidentifier not null PRIMARY KEY,
Title varchar(50) not null,
Release int not null, --year
Genre varchar(50) null,
Duration int not null); --minutes

CREATE TABLE Seating (
Id uniqueidentifier not null PRIMARY KEY,
ViewingId uniqueidentifier not null,
TicketId uniqueidentifier null,
SeatNb int not null, --broj sjedala, ali treba od 11 (prvi red prvo sjedalo) do cca 55 ili nešto, malo kino
Booked bit not null);

CREATE TABLE Customer (
Id uniqueidentifier not null PRIMARY KEY,
Member bit null,
PurchaseId uniqueidentifier not null);

CREATE TABLE Member (
Id uniqueidentifier not null PRIMARY KEY,
CustomerId uniqueidentifier not null,
FirstName varchar(50) not null,
LastName varchar(50) not null,
HomeAddress varchar(50) not null,
ContactTel varchar(50) null,
ContactEmail varchar(50) not null);

CREATE TABLE MemberHistory (
Id uniqueidentifier not null PRIMARY KEY,
MemberId uniqueidentifier not null,
PurchaseId uniqueidentifier not null);

CREATE TABLE Revenue (
Id uniqueidentifier not null PRIMARY KEY,
PurchaseTime datetime not null,
ItemId uniqueidentifier not null,
SingleCost int not null, --jedinični iznos artikla
Amount int not null,
SumCost int not null, --umnožak,ukupno
CustomerId uniqueidentifier not null);

CREATE TABLE RevenueItems (
Id uniqueidentifier not null PRIMARY KEY,
ItemName varchar(50) not null,
ItemSize varchar(50) null);
