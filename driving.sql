/*
Jordan Lee
2068370
CSE-414, Spring 23
HW4 - driving.sql
*/

CREATE TABLE Vehicle (
  -- lets just say a license plate is no longer than 7 characters
  licensePlate VARCHAR(7) PRIMARY KEY,
  year INT
);

CREATE TABLE InsuranceCo (
  name VARCHAR(50) PRIMARY KEY,
  phone int
);

CREATE TABLE Person (
  ssn INT NOT NULL PRIMARY KEY,
  name VARCHAR(50)
);

CREATE TABLE Car (
  licensePlate VARCHAR(7) PRIMARY KEY,
  make VARCHAR(50),
  FOREIGN KEY (licensePlate) REFERENCES vehicle (licensePlate)
);

CREATE TABLE Truck (
  licensePlate VARCHAR(7) PRIMARY KEY,
  capacity INT,
  FOREIGN KEY (licensePlate) REFERENCES vehicle (licensePlate)
);

CREATE TABLE Insures (
  licensePlate VARCHAR(7) PRIMARY KEY,
  maxLiability REAL,
  name VARCHAR(50),
  FOREIGN KEY (name) REFERENCES insuranceCo (name),
  FOREIGN KEY (licensePlate) REFERENCES vehicle (licensePlate)
);

CREATE TABLE Owns (
  ssn INT,
  licensePlate VARCHAR(7),
  FOREIGN KEY (ssn) REFERENCES Person (ssn),
  FOREIGN KEY (licensePlate) REFERENCES Vehicle (licensePlate)
);

CREATE TABLE Driver (
  driverID INT PRIMARY KEY,
  ssn INT,
  FOREIGN KEY (ssn) REFERENCES Person (ssn)
);

CREATE TABLE NonProfessionalDriver (
  driverID INT PRIMARY KEY,
  FOREIGN KEY (driverID) REFERENCES Driver (driverID)
);

CREATE TABLE ProfessionalDriver (
  driverID INT PRIMARY KEY,
  medicalHistory VARCHAR(50),
  FOREIGN KEY (driverID) REFERENCES Driver (driverID)
);

CREATE TABLE Drives (
  driverID INT PRIMARY KEY,
  licensePlate VARCHAR(7),
  FOREIGN KEY (driverID) REFERENCES NonProfessionalDriver (driverID),
  FOREIGN KEY (licensePlate) REFERENCES Car (licensePlate)
);

CREATE TABLE Operates (
  driverID INT PRIMARY KEY,
  licensePlate VARCHAR(7),
  FOREIGN KEY (driverID) REFERENCES ProfessionalDriver (driverID),
  FOREIGN KEY (licensePlate) REFERENCES Truck (licensePlate)
);

/*
b. (5 points) Which relation in your relational schema represents the
relationship "insures" in the E/R diagram? Why is that your representation?

The Insures table represents "insures" from the E/R diagram. From the diagram
it can be precieved that the connection from InsuranceCo to Vehicle can be a
many-to-many relationship, since Insurance Companies can insure many vehicles,
and Vehicles can be ensured by many Companies at the same time. In order to break
this many-to-many relationship and normalize the data, the implementation of the Insures table
helps to do this. The schema has it so that the Insures table references both
the primary keys of InsuranceCo(name) and Vehicle(licensePlate), allowing for
connections that are one-to-many.

c. (5 points) Compare the representation of the relationships "drives" and
"operates" in your schema, and explain why they are different.

The primary difference between the "drives" and "operates" relationships in the
schema are that they reference two different takes. "Drives" references Car and
"Operates" references Truck. Additionally, "Drives" references NonProfessional Driver,
while "Operates" references ProfessionalDriver. In the case of this diagram, this
establishes that NonProfessionalDrivers only drive Cars, while ProfessionalDrivers
drive trucks and also need medical records. Moreover, this at the same time helps
break the many-to-many relationships. For example, many NonProfessional drivers
can drive many cars, at the same time the same car can be driven by many people.
Once again this helps create and establish a schema for the table to normalize
its data.

*/