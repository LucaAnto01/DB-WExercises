CREATE DATABASE travel_agency;

USE travel_agency;

CREATE TABLE clients(
    id integer(3) AUTO_INCREMENT,
    username varchar(15) NOT NULL,
    birthdate date NOT NULL,
    firstname varchar(30) NOT NULL,
    lastname varchar(50) NOT NULL,
    primary key (id)
);

CREATE TABLE destinations(
    id integer(3) AUTO_INCREMENT,
    city varchar(50) NOT NULL,
    country varchar(50) NOT NULL, 
    primary key (id) 
);

CREATE TABLE flights(
    code integer(3) AUTO_INCREMENT,
    fkIdDestination integer(3),
    departure date NOT NULL,
    distance integer(5) NOT NULL,
    cost float(5) NOT NULL,
    primary key (code),
    foreign key(fkIdDestination) references destinations(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE  
);

CREATE TABLE bookings(
    id integer(3) AUTO_INCREMENT,
    fkCodeFly integer(3),
    fkIdClient integer(3),
    place varchar(5) NOT NULL,
    primary key (id),
    foreign key(fkCodeFly) references flights(code),
    foreign key(fkIdClient) references clients(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE 
);