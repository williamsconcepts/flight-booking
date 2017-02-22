create table city( id int primary key AUTO_INCREMENT,
name varchar(25) not null,
state varchar(25) not null
);


create table travel_class( 
	id int not null primary key AUTO_INCREMENT,
	name varchar(10) not null,
	UNIQUE (name)
);


CREATE TABLE user (
  id int(11) NOT NULL AUTO_INCREMENT,
  password_hash char(32) NOT NULL,
  fname varchar(10) NOT NULL,
  mname varchar(10) DEFAULT NULL,
  lname varchar(10) NOT NULL,
  sex char(1) DEFAULT NULL,
  address varchar(50) DEFAULT NULL,
  email varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT check_sex check(sex='M' OR sex='F')
);


create table airline(
			id int PRIMARY KEY AUTO_INCREMENT ,
			name varchar(30) NOT NULL,
			short_name char(2) NOT NULL,
			logo BLOB
);

Create table airplane ( 
	id int primary key AUTO_INCREMENT,
	airline_id int not null,
	CONSTRAINT _FK_airplane_airline 
		foreign key(airline_id)
		references airline(id)
);

create table airplane_capacity(
	airplane_id int not null,
	class_id int not null,
	capacity int not null,
	CONSTRAINT _FK_airplane_capacity_airplane foreign key(airplane_id) 
		references airplane(id),
	CONSTRAINT _FK_airplane_capacity_travel_class foreign key(class_id) 
		references travel_class(id)	
	);


Create table flight( 
id int primary key AUTO_INCREMENT,
fnumber int not null,
 airplane_id int not null, 
 d_city int not null, 
 d_date_time datetime not null,
 a_city int not null,
 a_date_time datetime not null,
 price numeric(8,2) not null,
 free_meals BOOLEAN not null,
 refundable BOOLEAN not null,
CONSTRAINT _FK_flight_airplane  Foreign key(airplane_id) 
 	REFERENCES airplane(id),
CONSTRAINT _FK_flight_city_dcity Foreign key(d_city) 
 	references city(id),
CONSTRAINT _FK_flight_city_acity Foreign key(a_city) 
 	references city(id)
 );



Create table Booking( 
	id int primary key AUTO_INCREMENT,
	booking_time datetime not null,
	flight_id int not null,
	user_id int not null,
	noOfTravellers int not null,
	class_id int not null,
	status char(3) DEFAULT NULL,
CONSTRAINT _FK_booking_user Foreign key(user_id)
		references user(id),
CONSTRAINT _FK_booking_flight Foreign key(flight_id) 
		references flight(id),
CONSTRAINT _FK_booking_travel_class Foreign Key(class_id)
		references travel_class(id)
	);


create table Passenger(
	booking_id int not null,
	fname varchar(20) not null,
	mname varchar(20),
	lname varchar(20) not null,
	age int not null,
	CONSTRAINT _FK_passenger_booking foreign key(booking_id)
		references Booking(id)
	);



create table seats_booked(
	flight_id int not null,
	class_id int not null,
	seats_booked int not null,
	CONSTRAINT _FK_seats_booked_travel_class Foreign key(class_id) 
		references travel_class(id),
	CONSTRAINT _FK_seats_booked_flight Foreign key(flight_id) 
		references flight(id),
	PRIMARY KEY(flight_id,class_id)
	);


DELIMITER $$
CREATE TRIGGER update_seats_available_on_delete BEFORE UPDATE ON booking 
FOR EACH ROW 
BEGIN
	IF NEW.status = 'CAN' THEN
		UPDATE seats_booked SET seats_booked = seats_booked - OLD.noOfTravellers WHERE class_id=OLD.class_id AND flight_id=OLD.flight_id;
	 END IF;
END$$
DELIMITER ;



insert into city (name,state) values("Jaipur","Rajasthan");
insert into city (name,state) values("New Delhi","Delhi");
insert into city (name,state) values("Mumbai","Karnataka");
insert into city (name,state) values("Chennai","Tamil Nadu");
insert into city (name,state) values("Bangalore","Karnataka");



insert into travel_class (name) values('Economy');
insert into travel_class (name) values('Business');


insert into flights values(1,901,1,1,"2016-04-09 15:45:21",3,"2016-04-09 18:05:00",3500.00);
insert into flights values(2,504,2,3,"2016-04-15 22:45:15",1,"2016-04-15 23:05:00",4500.00);
insert into flights values(3,101,3,2,"2016-04-20 10:25:21",4,"2016-04-20 13:40:00",7570.00);
insert into flights values(4,999,3,5,"2016-04-25 19:45:21",3,"2016-04-25 21:35:00",4700.00);
insert into flights values(5,456,3,5,"2016-04-27 13:45:00",3,"2016-04-27 17:35:00",6700.00);
insert into flights values(6,123,2,1,"2016-04-22 13:45:00",3,"2016-04-22 17:35:00",6700.00);




	insert into users (password_hash,fname,mname,lname,sex,address,email) VALUES(
		'f6a63dfae760d39bd467a28d053938cb',
		'Nishant',
		'',
		'Banka',
		'M',
		'48,Adarsh Nagar,Guhawat',
		'banka@gmail.com'
		);

		





LOAD DATA INFILE 'd:/city.csv' 
INTO TABLE flights 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';





		insert into airline values(1,"Indigo","IN","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
JIEREAREQBERAEREA//Z");









insert into airline values(2,"SpiceJet","SJ","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");


insert into airline values(3,"AirIndia","AI","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");




insert into airline values(4,"AirAsia","AS","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
/wBbzHWHeuL1KgAAAABJRU5ErkJggg==");



insert into airline (name,logo,short_name) values("Go Air","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","GA");

insert into airline (name,logo,short_name) values("Jet Airways","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","JA");


SELECT * FROM flights WHERE TRY_CONVERT(DATE, d_date_time, 105) = '04/09/2016'