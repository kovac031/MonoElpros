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

-- sad je sve povezano
-- dropat ove rashodovne tablice jer je previše tablica

ALTER TABLE PaycheckRecord
DROP
CONSTRAINT FK_Employee, FK_Expense 
DROP TABLE PaycheckRecord

ALTER TABLE Expense
DROP
CONSTRAINT FK_Item2 
DROP TABLE Expense

DROP TABLE Employee, ExpenseItem

-- vrijeme za insert 

SELECT * FROM viewing

INSERT INTO Ticket VALUES
(newid(), '2023-02-18 18:53:27', (SELECT "Id" FROM "Viewing" WHERE Id like '4%' ), (SELECT "Id" FROM "Seating" WHERE SeatNb='11'),(SELECT "Id" FROM "Customer" WHERE Id like '9A%'),(SELECT "Id" FROM "Revenue" WHERE SingleCost='140')),
(newid(), '2023-02-17 17:53:27', (SELECT "Id" FROM "Viewing" WHERE Id like '71%'), (SELECT "Id" FROM "Seating" WHERE SeatNb='12'),(SELECT "Id" FROM "Customer" WHERE Id like '8E%'),(SELECT "Id" FROM "Revenue" WHERE SingleCost='120')),
(newid(), '2023-02-16 16:53:27', (SELECT "Id" FROM "Viewing" WHERE Id like '2%'), (SELECT "Id" FROM "Seating" WHERE SeatNb='13'),(SELECT "Id" FROM "Customer" WHERE Id like '99%'),(SELECT "Id" FROM "Revenue" WHERE SingleCost='130')),
(newid(), '2023-02-15 15:53:27', (SELECT "Id" FROM "Viewing" WHERE Id like '73%'), (SELECT "Id" FROM "Seating" WHERE SeatNb='14'),(SELECT "Id" FROM "Customer" WHERE Id like '21%'),(SELECT "Id" FROM "Revenue" WHERE SingleCost='150')),
(newid(), '2023-02-14 14:53:27', (SELECT "Id" FROM "Viewing" WHERE Id like 'F%'), (SELECT "Id" FROM "Seating" WHERE SeatNb='15'),(SELECT "Id" FROM "Customer" WHERE Id like '43%'),(SELECT "Id" FROM "Revenue" WHERE SingleCost='100'));

INSERT INTO Viewing VALUES
(newid(), (SELECT "Id" FROM "FIlm" WHERE Title like '%1'), '18:53:27','2023-02-18'),
(newid(), (SELECT "Id" FROM "FIlm" WHERE Title like '%2'), '17:53:27','2023-02-17'),
(newid(), (SELECT "Id" FROM "FIlm" WHERE Title like '%3'), '16:53:27','2023-02-16'),
(newid(), (SELECT "Id" FROM "FIlm" WHERE Title like '%4'), '15:53:27','2023-02-15'),
(newid(), (SELECT "Id" FROM "FIlm" WHERE Title like '%5'), '14:53:27','2023-02-14');

INSERT INTO Film VALUES
(newid(), 'film1','1991','zanr1','120'),
(newid(), 'film2','1991','zanr2','121'),
(newid(), 'film3','1991','zanr3','122'),
(newid(), 'film4','1991','zanr4','123'),
(newid(), 'film5','1991','zanr5','124');

INSERT INTO Seating VALUES
(newid(),'11',1),
(newid(),'12',1),
(newid(),'13',0),
(newid(),'14',0),
(newid(),'15',1);

INSERT INTO Customer VALUES
(newid(),1),
(newid(),1),
(newid(),0),
(newid(),0),
(newid(),1);

INSERT INTO Member VALUES
(newid(), (SELECT "Id" FROM "Customer" WHERE Id like '9A%'), 'name1','surname1','address1','phone1','email1'),
(newid(), (SELECT "Id" FROM "Customer" WHERE Id like '8E%'), 'name2','surname2','address2','phone2','email2'),
(newid(), (SELECT "Id" FROM "Customer" WHERE Id like '99%'), 'name3','surname3','address3','phone3','email3'),
(newid(), (SELECT "Id" FROM "Customer" WHERE Id like '21%'), 'name4','surname4','address4','phone4','email4'),
(newid(), (SELECT "Id" FROM "Customer" WHERE Id like '43%'), 'name5','surname5','address5','phone5','email5');

INSERT INTO MemberHistory VALUES
(newid(), (SELECT "Id" FROM "Member" WHERE FirstName like '%1')),
(newid(), (SELECT "Id" FROM "Member" WHERE FirstName like '%2')),
(newid(), (SELECT "Id" FROM "Member" WHERE FirstName like '%3')),
(newid(), (SELECT "Id" FROM "Member" WHERE FirstName like '%4')),
(newid(), (SELECT "Id" FROM "Member" WHERE FirstName like '%5'));

INSERT INTO Revenue VALUES
(newid(), '2023-02-18 18:53:27', '100','1','100'),
(newid(), '2023-02-17 17:53:27', '120','2','240'),
(newid(), '2023-02-16 16:53:27', '130','1','130'),
(newid(), '2023-02-15 15:53:27', '140','2','280'),
(newid(), '2023-02-14 14:53:27', '150','3','450');

INSERT INTO RevenueItem VALUES
(newid(), 'kokice', 'M'),
(newid(), 'kokice', 'XL'),
(newid(), 'nachosi', 'M'),
(newid(), 'nachosi', 'L'),
(newid(), 'kola', 'M');

INSERT INTO RevenueM2M VALUES
(newid(), (SELECT "Id" FROM "RevenueItem" WHERE Id like '68%'), (SELECT "Id" FROM "MemberHistory" WHERE Id like '71%')),
(newid(), (SELECT "Id" FROM "RevenueItem" WHERE Id like 'BF%'), (SELECT "Id" FROM "MemberHistory" WHERE Id like '41%')),
(newid(), (SELECT "Id" FROM "RevenueItem" WHERE Id like '55%'), (SELECT "Id" FROM "MemberHistory" WHERE Id like '56%')),
(newid(), (SELECT "Id" FROM "RevenueItem" WHERE Id like '85%'), (SELECT "Id" FROM "MemberHistory" WHERE Id like 'E7%')),
(newid(), (SELECT "Id" FROM "RevenueItem" WHERE Id like '35%'), (SELECT "Id" FROM "MemberHistory" WHERE Id like 'C1%'));

--- sve insertano