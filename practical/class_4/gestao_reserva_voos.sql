CREATE TABLE Flight(
    [Number] VARCHAR(32) NOT NULL PRIMARY KEY,
    [Airline] VARCHAR(64),
    [Weekdays] VARCHAR(32) 
);

CREATE TABLE Airport(
    [Code] VARCHAR(8) NOT NULL PRIMARY KEY,
    [City] VARCHAR(32) NOT NULL,
    [State] VARCHAR(32) NOT NULL,
    [Name] VARCHAR(64) 
);

CREATE TABLE Flight_leg(
    [FLIGHT_Number] VARCHAR(32) REFERENCES Flight(Number) NOT NULL PRIMARY KEY,
    [Leg_no] SMALLINT NOT NULL,
    [Scheduled_arr_time] DATETIME NOT NULL,
    [Scheduled_dep_time] DATETIME,
    [ARRIVAL_AIRPORT_Code] VARCHAR(8) REFERENCES Airport(Code) NOT NULL,
    [DEPARTURE_AIRPORT_Code] VARCHAR(8) REFERENCES Airport(Code) NOT NULL
);

CREATE TABLE Fare(
    [Code] INTEGER NOT NULL,
    [FLIGHT_Number] VARCHAR(32) NOT NULL,
    [Restrictions] VARCHAR(64),
    [Amount] FLOAT,
    PRIMARY KEY(Code, FLIGHT_Number) /* Use two Primary Keys */
);

CREATE TABLE Airplane_type(
    [Name] VARCHAR(32) NOT NULL PRIMARY KEY,
    [Max_seats] SMALLINT,
    [Company] VARCHAR(64)
);

CREATE TABLE Airplane(
    [Id] INTEGER NOT NULL IDENTITY PRIMARY KEY, /* Identity -> Auto Increment */
    [AIRPLANE_TYPE_Name] VARCHAR(32) NOT NULL,
    [Total_no_of_seats] SMALLINT
);

CREATE TABLE Leg_Instance(
    [AIRPORT_Code] VARCHAR(8) NOT NULL, 
    [AIRPLANE_Id] INTEGER REFERENCES Airplane(Id) NOT NULL,
    [FLIGHT_Number] VARCHAR(32) REFERENCES Flight(Number) NOT NULL,
    [No_of_avail_seats] SMALLINT,
    [Dep_time] DATETIME NOT NULL,
    [Arr_time] DATETIME,
    PRIMARY KEY(AIRPORT_Code, AIRPLANE_Id, FLIGHT_Number)
);

CREATE TABLE Airport_Airplane_Type(
    [AIRPLANE_TYPE_Name] VARCHAR(32) REFERENCES Airplane_type(Name) NOT NULL,
    [AIRPLANE_Code] VARCHAR(32) REFERENCES Airplane_type(Name) NOT NULL,
    PRIMARY KEY(AIRPLANE_TYPE_Name, AIRPLANE_Code)
);

CREATE TABLE Seat(
    [LEG_INSTANCE_Code] VARCHAR(8) REFERENCES Airport(Code) NOT NULL,
    [LEG_INSTANCE_Id] INTEGER REFERENCES Airplane(Id) NOT NULL,
    [LEG_INSTANCE_Number] VARCHAR(32) REFERENCES Flight(Number) NOT NULL,
    [Seat_no] SMALLINT NOT NULL,
    [Cphone] INTEGER,
    [Customer_name] VARCHAR(256),
    PRIMARY KEY(LEG_INSTANCE_Code, LEG_INSTANCE_Id, LEG_INSTANCE_Number, Seat_no)
);