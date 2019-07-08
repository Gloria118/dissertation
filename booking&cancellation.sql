create table flight(
flight_id int,
name varchar(64),
airport_departure int,
airport_destination int,
departure_start_time time,
flight_duration_minute int,
price int,
description varchar(256),
primary key(flight_id)
);

create table seat(
seat_id int,
flight_id int,
location_x int,
location_y int,
class int,
primary key(seat_id)
);

create table airport(
airport_id int,
name varchar(64),
city_id int,
primary key(airport_id)
);

create table city(
city_id int,
name varchar(64),
country_id int,
longitude int,
latitude int,
timezone int,
description varchar(512),
primary key(city_id)
);

create table country(
country_id int,
name varchar(64),
description varchar(512),
primary key(country_id)
);

create table passenger(
passenger_id int,
surname varchar(64),
given_name varchar(64),
passport_number int,
passport_expiry date,
id_card_number int,
phone_number int,
gender int,
birthday date,
primary key(passenger_id)
);

create table discount(
discount_id int,
name varchar(64),
discount float,
description varchar(512),
effective_from date,
effective_to date,
primary key(discount_id)
);

create table booking(
booking_id int,
passenger_id int,
flight_id int,
seat_id int ,
payment_id int,
discount_id int,
departure_date date,
create_time timestamp default current_timestamp,
update_time timestamp default current_timestamp on update current_timestamp,
unique(seat_id, departure_date),
unique(flight_id, departure_date, passenger_id),
primary key(booking_id)
);

create table payment(
payment_id int,
booking_id int,
payment_status int,
paid_time timestamp,
payment_dollar float,
payment_tax_dollar float,
primary key(payment_id)
);



select seat_id, flight_id, name, location_x, location_y, class from seat st
where st.seat_id not in (
select seat_id from seat s, flight f, booking b
where s.flight_id = f.flight_id 
and f.flight_id = b.flight_id
and s.seat_id = b.seat_id
and b.flight_id = ?
and b.departure_date = ?
) 
and st.flight_id = ?;


select seat_id from seat st
where st.seat_id not in (
select seat_id from seat s, flight f, booking b
where s.flight_id = f.flight_id 
and f.flight_id = b.flight_id
and s.seat_id = b.seat_id
and b.flight_id = ?
and b.departure_date = ?
and b.class = ?
);


insert into booking(booking_id, passenger_id, flight_id, seat_id, payment_id, discount_id, depature_date)
values(?, ?, ?, ?, ?, ?, ?);




delete from booking where seat_id = ? and departure_date = ?;


select passenger_id, surname, given_name, passport_number, passport_expiry, id_card_number, phone_number, gender, birthday
from passenger p, booking b
where p.passenger_id = b.passenger_id
and b.departure_date = ?
and b.flight_number = ?;
