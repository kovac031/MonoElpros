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

CREATE TABLE RevenueItem (
Id uniqueidentifier not null PRIMARY KEY,
ItemName varchar(50) not null,
ItemSize varchar(50) null);

CREATE TABLE Employee (
Id uniqueidentifier not null PRIMARY KEY,
FirstName varchar(50) not null,
LastName varchar(50) not null,
HomeAddress varchar(50) not null,
ContactTel varchar(50) null,
ContactEmail varchar(50) not null);

CREATE TABLE PaycheckRecord (
Id uniqueidentifier not null PRIMARY KEY,
EmployeeId uniqueidentifier not null,
ExpenseId uniqueidentifier not null);

CREATE TABLE Expense (
Id uniqueidentifier not null PRIMARY KEY,
ExpenseTime datetime not null,
ItemId uniqueidentifier not null,
SingleCost int not null, --jedinični iznos artikla
Amount int null,
SumCost int null, --umnožak,ukupno
SourceId uniqueidentifier null); --može bit trgovina, dobavljač, zaposlenik; nema tablicu

CREATE TABLE ExpenseItem (
Id uniqueidentifier not null PRIMARY KEY,
ExpenseType varchar(50) not null);

ALTER TABLE Ticket
ADD 
CONSTRAINT FK_Viewing FOREIGN KEY (ViewingId) REFERENCES Viewing (Id),
CONSTRAINT FK_Seating FOREIGN KEY (SeatingId) REFERENCES Seating (Id),
CONSTRAINT FK_Customer FOREIGN KEY (CustomerId) REFERENCES Customer (Id)

ALTER TABLE Viewing
ADD
CONSTRAINT FK_Film FOREIGN KEY (FilmId) REFERENCES Film (Id)

ALTER TABLE Seating
ADD
CONSTRAINT FK_Viewing2 FOREIGN KEY (ViewingId) REFERENCES Viewing (Id), --ovu vezu dropo
CONSTRAINT FK_Ticket FOREIGN KEY (TicketId) REFERENCES Ticket (Id)

ALTER TABLE Customer
ADD
CONSTRAINT FK_Purchase FOREIGN KEY (PurchaseId) REFERENCES Revenue (Id)

ALTER TABLE Member
ADD
CONSTRAINT FK_Customer2 FOREIGN KEY (CustomerId) REFERENCES Customer (Id)

ALTER TABLE MemberHistory
ADD
CONSTRAINT FK_Member FOREIGN KEY (MemberId) REFERENCES Member (Id),
CONSTRAINT FK_Purchase2 FOREIGN KEY (PurchaseId) REFERENCES Revenue (Id)

ALTER TABLE Revenue
ADD
CONSTRAINT FK_Item FOREIGN KEY (ItemId) REFERENCES RevenueItem (Id),
CONSTRAINT FK_Customer3 FOREIGN KEY (CustomerId) REFERENCES Customer (Id)

ALTER TABLE PaycheckRecord
ADD
CONSTRAINT FK_Employee FOREIGN KEY (EmployeeId) REFERENCES Employee (Id),
CONSTRAINT FK_Expense FOREIGN KEY (ExpenseId) REFERENCES Expense (Id)

ALTER TABLE Expense
ADD
CONSTRAINT FK_Item2 FOREIGN KEY (ItemId) REFERENCES ExpenseItem (Id)

-- popravljanje veza

ALTER TABLE Seating
DROP
CONSTRAINT FK_Viewing2,
column ViewingId

ALTER TABLE Seating
DROP
CONSTRAINT FK_Ticket,
column TicketId

ALTER TABLE Ticket
ADD
PurchaseId uniqueidentifier not null,
CONSTRAINT FK_Purchase3 FOREIGN KEY (PurchaseId) REFERENCES Revenue (Id)

ALTER TABLE Customer
DROP
CONSTRAINT FK_Purchase,
column PurchaseId

ALTER TABLE Revenue
DROP
CONSTRAINT FK_Customer3,
column CustomerId

ALTER TABLE MemberHistory
DROP
CONSTRAINT FK_Purchase2,
column PurchaseId

ALTER TABLE Revenue
DROP
CONSTRAINT FK_Item,
column ItemId

CREATE TABLE RevenueM2M ( --many to many tablica
id uniqueidentifier not null PRIMARY KEY,
RevenueItemId uniqueidentifier not null FOREIGN KEY REFERENCES RevenueItem(Id),
MemberHistoryId uniqueidentifier not null FOREIGN KEY REFERENCES MemberHistory(Id));