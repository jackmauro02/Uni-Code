------------------------------------------------------------------------------

-- This is the template for your COMP5320 Assessment 3 submission.

-- Please leave the overall structure and order of queries unchanged.

-- You can freely add queries add you need, but please place them in the

-- corresponding sections. And please do not remove any comments.

-------------------------------------------------------------------------------

-- Please fill in your name and login:

-- name: Jack Mauro

-- login: jm2286

-------------------------------------------------------------------------------

-- The following lines make sure you can rerun this whole script as often

-- as you want.

DROP TABLE IF EXISTS BookingLodge;

DROP TABLE IF EXISTS Lodge;

DROP TABLE IF EXISTS Admin;

DROP TABLE IF EXISTS Activity;

DROP TABLE IF EXISTS ActivityLeader;

DROP TABLE IF EXISTS Booking;

DROP TABLE IF EXISTS Park;

DROP TABLE IF EXISTS Customer;

-------------------------------------------------------------------------------

-- Task 1: Create Tables and Insert Data

-------------------------------------------------------------------------------

CREATE TABLE Customer (
    CustomerNo INTEGER NOT NULL PRIMARY KEY,
    Firstname varchar(50) NOT NULL,
    Surname varchar(50) NOT NULL,
    EmailAddress varchar(100) NOT NULL,
    PhoneNo varchar(11) NOT NULL
);
CREATE TABLE Park (
    ParkID INTEGER NOT NULL PRIMARY KEY,
    Address varchar(50) NOT NULL,
    Postcode varchar(20) NOT NULL
);
CREATE TABLE Booking (
    BookingNo INTEGER NOT NULL PRIMARY KEY,
    CustomerNo INTEGER NOT NULL,
    ParkID INTEGER NOT NULL,
    BookingDate DATE NOT NULL,
    ArrivalDate DATE NOT NULL,
    DepartureDate DATE NOT NULL,
    SpecialRequests text,
    FOREIGN KEY (CustomerNo) REFERENCES Customer(CustomerNo),
    FOREIGN KEY (ParkID) REFERENCES Park(ParkID),
    CONSTRAINT ArrivalDate CHECK (ArrivalDate >= CURRENT_DATE),
    CONSTRAINT DepartureDate CHECK (DepartureDate >= ArrivalDate)
);
CREATE TABLE ActivityLeader (
    StaffID INTEGER NOT NULL PRIMARY KEY,
    ParkID INTEGER NOT NULL,
    Firstname varchar(50) NOT NULL,
    Surname varchar(50) NOT NULL,
    DOB DATE NOT NULL,
    Address varchar(50) NOT NULL,
    PhoneNo varchar(11) NOT NULL,
    Salary MONEY NOT NULL,
    WorkAdjustments text,
    DBSCheck varchar(200),
    Speciality varchar(200) NOT NULL,
    FOREIGN KEY (ParkID) REFERENCES Park(ParkID),
    CONSTRAINT DOB CHECK (DOB <= CURRENT_DATE)
);
CREATE TABLE Activity (
    ActivityID INTEGER NOT NULL PRIMARY KEY,
    ParkID INTEGER NOT NULL,
    StaffID INTEGER NOT NULL,
    Name varchar(50) NOT NULL,
    OnDateTime varchar(50) NOT NULL,
    Duration INTEGER NOT NULL,
    TargetAudience varchar(200) NOT NULL,
    CHECK (TargetAudience IN ('Children', 'Adults', 'All')),
    FOREIGN KEY (ParkID) REFERENCES Park(ParkID),
    FOREIGN KEY (StaffID) REFERENCES ActivityLeader(StaffID)
);
CREATE TABLE Admin (
    StaffID INTEGER NOT NULL PRIMARY KEY,
    ParkID INTEGER NOT NULL,
    Firstname varchar(50) NOT NULL,
    Surname varchar(50) NOT NULL,
    DOB DATE NOT NULL,
    Address varchar(50) NOT NULL,
    PhoneNo varchar(11) NOT NULL,
    Salary MONEY NOT NULL,
    WorkAdjustments text,
    Role varchar(200) NOT NULL,
    CHECK (
        Role IN (
            'Manager',
            'Receptionist',
            'HR',
            'Sales',
            'Marketing'
        )
    ),
    FOREIGN KEY (ParkID) REFERENCES Park(ParkID),
    CONSTRAINT DOB CHECK (DOB <= CURRENT_DATE)
);

CREATE TABLE
    Lodge (
        LodgeID INTEGER NOT NULL PRIMARY KEY,
        ParkID INTEGER NOT NULL,
        Area varchar(50) NOT NULL,
        CHECK (
            Area IN (
                'Central',
                'Outer',
                'Exclusive'
            )
        ),
        LodgeNo INTEGER NOT NULL,
        MaxOccupants INT NOT NULL CHECK (MaxOccupants > 0),
        WheelchairAccessible varchar(50) NOT NULL,
        DogsAllowed varchar(50) NOT NULL,
        Foreign Key (ParkID) REFERENCES Park(ParkID),
        CONSTRAINT LodgeNo CHECK (LodgeNo > 0),
        CONSTRAINT MaxOccupants CHECK (MaxOccupants > 0)
        --CONSTRAINT UniqueAreaLodgeNo UNIQUE (Area, LodgeNo)
    );
    
CREATE TABLE BookingLodge (
    LodgeID INTEGER NOT NULL PRIMARY KEY,
    BookingNo INTEGER NOT NULL,
    NumberGuests INTEGER NOT NULL,
    Price MONEY NOT NULL,
    FOREIGN KEY (LodgeID) REFERENCES Lodge(LodgeID),
    FOREIGN KEY (BookingNo) REFERENCES Booking(BookingNo)
);

-- Add data to the tables:
-- (add your queries here)
INSERT INTO Customer (CustomerNo,Firstname,Surname,PhoneNo,EmailAddress)
VALUES (1,'John','Smith','0123456789','email@address.com'),
       (2,'Anna','Jones','0123456780','anna@example.com'),
       (3,'Peter','Brown','0123456781','pb@example.com');

SELECT * FROM Customer;

INSERT INTO Park (ParkID, Address, Postcode)
VALUES (1, '123 Example Street', 'EX1 111'),
       (2, '456 Example Street', 'EX1 222'),
       (3, '789 Example Street', 'EX1 333');

SELECT * FROM Park;

INSERT INTO Booking (BookingNo,BookingDate,ArrivalDate,DepartureDate,SpecialRequests,CustomerNo,ParkID)
VALUES              (1,'2023-05-01','2023-06-01','2023-06-05','null',1,1),
                     (2,'2023-05-01','2023-06-01','2023-06-05','null',2,2),
                     (3,'2023-05-01','2023-06-01','2023-06-05','null',3,3);
SELECT * FROM Booking;

INSERT INTO ActivityLeader (StaffID,Firstname,Surname,DOB,Address,PhoneNo,Salary,WorkAdjustments,DBSCheck,Speciality,ParkID)
VALUES                     (1,'Freya','Evans','1980-01-01','1 Example Street','0000000001','£31,000.00','null','null','Climbing',1),
                           (2,'George','Bishop','1989-02-13','2 Example Street', '0000000002','£31,000.00','null','null','Surfing',1),
                           (3,'Amelia','Thomas','1999-12-07 ','3 Example Street', '0000000003','£31,000.00','null','null','Climbing',2),
                           (4,'Olivia','Williams','1999-12-07 ','4 Example Street', '0000000004','£31,000.00','null','null','Climbing',1);

SELECT * FROM ActivityLeader;

INSERT INTO Activity (ActivityID,Name,OnDateTime,Duration,TargetAudience,ParkID,StaffID)
VALUES               (1,'Climbing','2023-06-01 10:00:00',60,'Children',1,1),
                     (2,'Surfing','2023-06-01 10:00:00',60,'All',1,2),
                     (3,'Climbing','2023-06-01 10:00:00',60,'Children',2,3),
                     (4,'Surfing','2023-06-01 11:00:00',60,'Children',1,2);
SELECT * FROM Activity;

INSERT INTO Admin (StaffID,Firstname,Surname,DOB,Address,PhoneNo,Salary,WorkAdjustments,Role,ParkID)
VALUES            (1,'Sophie','Frank','1980-01-01','1 Example Street','0323456780','£31,000.00','null','Manager',1 ),
                  (2,'Isabella','Smith','1989-02-13','2 Example Street','0323456789','£31,000.00','null','Receptionist',1 ),
                  (3,'Muhammad','Fisher','1999-12-07','3 Example Street','0323456781','£31,000.00','null','HR',2 ),
                  (4,'Eliot','Gibson','1999-12-07','4 Example Street','0323456783','£31,000.00','null','Sales',3 ),
                  (5,'Fabio','Gibson','1999-12-07','5 Example Street','0323456784','£31,000.00','null','Marketing',3 );
SELECT * FROM Admin;

INSERT INTO Lodge (LodgeID,Area,LodgeNo,MaxOccupants,WheelchairAccessible,DogsAllowed,ParkID)
VALUES (1, 'Central', '1', '2', 'true', 'false', 1),
       (2, 'Outer', '2', '2', 'true', 'false', 1),
       (3, 'Exclusive', '3', '4', 'true', 'false', 1),
       (4, 'Central', '1', '6', 'true', 'false', 2),
       (5, 'Outer', '2', '6', 'true', 'false', 2),
       (6, 'Exclusive', '3', '4', 'true', 'false', 2);
SELECT * FROM Lodge;

-- need to fix LODGE TABLE

INSERT INTO BookingLodge (BookingNo,LodgeID,NumberGuests,Price)
VALUES                   (1, 1, '2', '£100.00'),
                         (2, 2, '2', '£100.00'),
                         (3, 3, '4', '£200.00'),
                         (1, 4, '6', '£300.00'),
                         (1, 5, '6', '£300.00'),
                         (3, 6, '4', '£200.00');
SELECT * FROM BookingLodge;


-- (add your queries here)

-------------------------------------------------------------------------------

-- Task 2: Query the Database

-------------------------------------------------------------------------------

-- 2.1 List all bookings where the total price is lower than £200. Show the total price, the customer name, and the email address.SELECT * FROM Module m
SELECT b.BookingNo, c.FirstName, c.EmailAddress, bl.Price
FROM Booking b
JOIN Customer c ON b.CustomerNo = c.CustomerNo
JOIN BookingLodge bl ON b.BookingNo = bl.BookingNo
WHERE bl.Price < '£200';

-- 2.2 Who is the most busy activity leader? Show the name and give number of activities as activityCount.
SELECT al.FirstName, COUNT(a.ActivityID) AS activityCount
FROM ActivityLeader al
JOIN Activity a ON al.StaffID = a.StaffID
GROUP BY al.FirstName
ORDER BY activityCount DESC
LIMIT 1;

-- 2.3 Take the query from 2.2 and modify it to show the three least busy activity leaders.
SELECT al.FirstName, COUNT(a.ActivityID) AS activityCount
FROM ActivityLeader al
JOIN Activity a ON al.StaffID = a.StaffID
GROUP BY al.FirstName
ORDER BY activityCount ASC
LIMIT 3;

-- 2.4 The following query was written to answer how much salary Sophie Frank earns.

--     However, it makes one crucial assumption, which may not be correct

--     in general when we ask for the salary of an employee. Fix the query.

SELECT salary
FROM Admin a
WHERE
    a.StaffID = 1;

-- 2.5 Update the data in the database to demonstrate the problem with the above query.

--     Thus, you may want to change, remove, and/or insert data into the database.
SELECT P.ParkID, SUM(Salary) AS salary
FROM Park P
JOIN (
    SELECT ParkID, Salary FROM Admin
    UNION ALL
    SELECT ParkID, Salary FROM ActivityLeader
) AS CombinedSalaries ON P.ParkID = CombinedSalaries.ParkID
GROUP BY P.ParkID;

-- 2.6 List the address, postcode, and the maximum number of guests (as maxGuests) that can stay in each park at a given point in time.
SELECT
  P.Address, P.Postcode, SUM(L.MaxOccupants) AS maxGuests
FROM Park P
JOIN Lodge L ON P.ParkID = L.ParkID
GROUP BY
  P.ParkID, P.Address, P.Postcode;
  
-- 2.7 What are the salary costs for each park?  Show the park id and the total salary costs as salary.
SELECT P.ParkID, SUM(Salary) AS salary
FROM Park P
JOIN (
    SELECT ParkID, Salary FROM Admin
    UNION ALL
    SELECT ParkID, Salary FROM ActivityLeader
) AS CombinedSalaries ON P.ParkID = CombinedSalaries.ParkID
GROUP BY P.ParkID;
-------------------------------------------------------------------------------