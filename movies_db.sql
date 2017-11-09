DROP TABLE IF EXISTS Actors;
DROP TABLE IF EXISTS Companies;
DROP TABLE IF EXISTS Movies;
DROP TABLE IF EXISTS Characters;
DROP TABLE IF EXISTS Pay;
DROP TABLE IF EXISTS Scripts;


CREATE TABLE Actors(
  actor_id		numeric(4,0) not null,
  actor_first		varchar(25) not null,
  actor_last		varchar(25) null,
  Primary Key		(actor_ID)
);

CREATE TABLE  Companies (
  company_id			numeric(2,0) NOT NULL,
  company_name		varchar(50) NOT NULL,
  Primary Key			(company_id)
);

CREATE TABLE  Movies (
  movie_id			numeric(6,0) NOT NULL,
  movie_title			varchar(50) NOT NULL,
  company_id			numeric(2,0) NOT NULL,
  movie_rev			decimal(20,2) NOT NULL,
  movie_cost			decimal(20,2) NOT NULL,
  Primary Key			(movie_id),
  Foreign Key			(company_id) references Companies(company_id));

CREATE TABLE Characters (
  char_id				numeric(3,0) NOT NULL,
  char_name			varchar(50) NOT NULL,
  actor_id			numeric(4,0) NOT NULL,
  movie_id			numeric(6,0) NOT NULL,
  Primary Key			(char_id),
  Foreign Key			(actor_id) references Actors(actor_id),
  Foreign Key			(movie_id) references Movies(movie_id));

CREATE TABLE  Pay (

  pay_id				numeric(3,0) NOT NULL,
  actor_id			numeric(4,0) NOT NULL,
  movie_id			numeric(6,0) NOT NULL,
  base_pay			decimal(15,2) NOT NULL,
  rev_share			decimal(4,2) NOT NULL,
  Primary Key			(pay_id),
  Foreign Key			(actor_id) references Actors(actor_id),
  Foreign Key			(movie_id) references Movies(movie_id));


CREATE TABLE  Scripts (

  script_id			numeric(2,0) NOT NULL,
  movie_id			numeric(6,0) NOT NULL,
  char_id				numeric(3,0) NOT NULL,
  line_num			numeric(4,0) NOT NULL,
  line_text			varchar(200) NOT NULL,
  Primary Key			(script_id),
  Foreign Key			(movie_id) references Movies(movie_id),
  Foreign Key			(char_id) references Characters(char_id));

#actors
INSERT INTO Actors(actor_id, actor_first, actor_last) VALUES('1646', 'Martha', 'Higareda');

INSERT INTO Actors(actor_id, actor_first, actor_last) VALUES('0287' , 'Alfonso', 'Dosal');

INSERT INTO Actors(actor_id, actor_first, actor_last) VALUES('4515', 'Christian', 'Vasquez');

INSERT INTO Actors(actor_id, actor_first, actor_last) VALUES('1655', 'German', 'Valdez');

INSERT INTO Actors(actor_id, actor_first, actor_last) VALUES('4174', 'Al', 'Gore');

INSERT INTO Actors(actor_id, actor_first, actor_last) VALUES('7515', 'George W.' ,'Bush');

INSERT INTO Actors(actor_id, actor_first, actor_last) VALUES('7821', 'John', 'Kerry');

INSERT INTO Actors(actor_id, actor_first, actor_last) VALUES('7191', 'Marco' ,'Krapels');

INSERT INTO Actors(actor_id, actor_first, actor_last) VALUES('7419', 'Dane' ,'DeHaan');

INSERT INTO Actors(actor_id, actor_first, actor_last) VALUES('0245', 'Jason', 'Isaacs');

INSERT INTO Actors(actor_id, actor_first, actor_last) VALUES('1378', 'Mia', 'Goth');

INSERT INTO Actors(actor_id, actor_first, actor_last) VALUES('0601' , 'Ivo', 'Nandi');


#companies
INSERT INTO Companies (company_id, company_name) VALUES('84', '20th Century Fox');

INSERT INTO Companies (company_id, company_name) VALUES('42', 'Paramount Pictures');

INSERT INTO Companies (company_id, company_name) VALUES('65', 'Lionsgate');


#movies
INSERT INTO Movies (movie_id, movie_title, company_id, movie_rev, movie_cost) VALUES('391329', 'A Cure for Wellness', '84', '24499901.00', '40000000000.00');

INSERT INTO Movies (movie_id, movie_title, company_id, movie_rev, movie_cost) VALUES('570478', 'A Inconveniont Sequel: True to Power', '42', '4014111.00', '1000000000.00');

INSERT INTO Movies (movie_id, movie_title, company_id, movie_rev, movie_cost) VALUES('747395' , '3 Idiotas', '65', '7684685.00', '5406660.00');



#characters
INSERT INTO Characters(char_id, char_name, actor_id, movie_id) VALUES('593', 'Mariana', '1646','747395');

INSERT INTO Characters(char_id, char_name, actor_id, movie_id) VALUES('028' , 'Pancho', '0287','747395');

INSERT INTO Characters(char_id, char_name, actor_id, movie_id) VALUES('451', 'Felipe','4515', '747395');

INSERT INTO Characters(char_id, char_name, actor_id, movie_id) VALUES('164', 'Beto','1655', '747395');

INSERT INTO Characters(char_id, char_name, actor_id, movie_id) VALUES('417', 'Al Gore','4174', '570478');

INSERT INTO Characters(char_id, char_name, actor_id, movie_id) VALUES('751', 'George W. Bush' ,'7515', '570478');

INSERT INTO Characters(char_id, char_name, actor_id, movie_id) VALUES('782', 'John Kerry','7821', '570478');

INSERT INTO Characters(char_id, char_name, actor_id, movie_id) VALUES('719', 'Marco Krapels' ,'7191' ,'570478');

INSERT INTO Characters(char_id, char_name, actor_id, movie_id) VALUES('741', 'Lockhart' ,'7419','391329');

INSERT INTO Characters(char_id, char_name, actor_id, movie_id) VALUES('024', 'Volmer', '0245','391329');

INSERT INTO Characters(char_id, char_name, actor_id, movie_id) VALUES('137', 'Hannah', '1378','391329');

INSERT INTO Characters(char_id, char_name, actor_id, movie_id) VALUES('060' , 'Enrico','0601', '391329');



#pay
INSERT INTO Pay (pay_id, actor_id, movie_id, base_pay, rev_share) VALUES('004', '1646', '747395', '1234567.00', '11.00');

INSERT INTO Pay (pay_id, actor_id, movie_id, base_pay, rev_share) VALUES('725', '0287', '747395', '12345678.00', '15.00');

INSERT INTO Pay (pay_id, actor_id, movie_id, base_pay, rev_share) VALUES('900', '4515', '747395', '1234567.00', '12.00');

INSERT INTO Pay (pay_id, actor_id, movie_id, base_pay, rev_share) VALUES('925', '1655', '747395', '1234567.00', '13.00');

INSERT INTO Pay (pay_id, actor_id, movie_id, base_pay, rev_share) VALUES('125', '4174', '570478', '83415166.00', '16.00');

INSERT INTO Pay (pay_id, actor_id, movie_id, base_pay, rev_share) VALUES('774', '7515', '570478', '1565225.00', '12.00');

INSERT INTO Pay (pay_id, actor_id, movie_id, base_pay, rev_share) VALUES('342', '7821', '570478', '7853513.00', '11.00');

INSERT INTO Pay (pay_id, actor_id, movie_id, base_pay, rev_share) VALUES('322', '7191', '570478', '3258946.00', '14.00');

INSERT INTO Pay (pay_id, actor_id, movie_id, base_pay, rev_share) VALUES('317', '7419', '391329', '456561.00', '1.00');

INSERT INTO Pay (pay_id, actor_id, movie_id, base_pay, rev_share) VALUES('472', '0245', '391329', '8568156.00', '12.00');

INSERT INTO Pay (pay_id, actor_id, movie_id, base_pay, rev_share) VALUES('923', '1378', '391329', '58789556.00', '15.00');

INSERT INTO Pay (pay_id, actor_id, movie_id, base_pay, rev_share) VALUES('612', '0601', '391329', '5651235.00', '21.00');


#script
INSERT INTO Scripts (script_id, movie_id, char_id, line_num, line_text) VALUES('59','747395' , '593', '5157', 'Yes, in fact that tall man you see there, is my dad.');

INSERT INTO Scripts (script_id, movie_id, char_id, line_num, line_text) VALUES('78', '747395', '028', '9202', 'You have a rigid and old-fashioned system. ');

INSERT INTO Scripts (script_id, movie_id, char_id, line_num, line_text) VALUES('38','747395', '451', '2907', 'I am also the first of all my family to go to university. ');

INSERT INTO Scripts (script_id, movie_id, char_id, line_num, line_text) VALUES('48', '747395', '164', '2414', 'Success, money, fame, do not follow you to the grave, but the pleasure of fulfilling your passion does. ');

INSERT INTO Scripts (script_id, movie_id, char_id, line_num, line_text) VALUES('16', '570478', '417', '5226', 'In order to address the environmental crisis, we are going to have to spend some time fixing the democracy crisis. ');

INSERT INTO Scripts (script_id, movie_id, char_id, line_num, line_text) VALUES('37', '570478', '751', '5186', 'We will not tire, we will not falter, and we will not fail.');

INSERT INTO Scripts (script_id, movie_id, char_id, line_num, line_text) VALUES('05', '570478', '782', '0869', 'How do you ask a man to be the last man to die in Vietnam? How do you ask a man to be the last man to die?');

INSERT INTO Scripts (script_id, movie_id, char_id, line_num, line_text) VALUES('60', '570478', '719', '7780', 'It appears the federal emergency response is focused on diesel to repower the island.');

INSERT INTO Scripts (script_id, movie_id, char_id, line_num, line_text) VALUES('17', '570478', '417', '5226', 'During my service in the United States Congress, I took the initiative in creating the Internet.');

INSERT INTO Scripts (script_id, movie_id, char_id, line_num, line_text) VALUES('26', '391329', '024', '4651', 'What we offer here is a process of purification away from pressures of the modern world');

INSERT INTO Scripts (script_id, movie_id, char_id, line_num, line_text) VALUES('55', '391329', '024', '2683', 'You plan to take Mr. Pembroke back with you?');

INSERT INTO Scripts (script_id, movie_id, char_id, line_num, line_text) VALUES('87', '570478', '751', '5186', 'It is clearly a budget. It has got a lot of numbers in it.');

INSERT INTO Scripts (script_id, movie_id, char_id, line_num, line_text) VALUES('82', '391329', '741', '4960', 'Is that a problem?');

INSERT INTO Scripts (script_id, movie_id, char_id, line_num, line_text) VALUES('28', '391329', '741', '5123', 'I saw bodies! ');

INSERT INTO Scripts (script_id, movie_id, char_id, line_num, line_text) VALUES('39', '391329', '137','3054' , 'You have the cure?');

INSERT INTO Scripts (script_id, movie_id, char_id, line_num, line_text) VALUES('89', '391329', '137', '7813', 'It is all part of the cure. ');

INSERT INTO Scripts (script_id, movie_id, char_id, line_num, line_text) VALUES('79', '391329', '060', '0613', 'That was two hundred years ago.');

INSERT INTO Scripts (script_id, movie_id, char_id, line_num, line_text) VALUES('24','391329', '060', '8048', 'Ivo Nandi.');

INSERT INTO Scripts (script_id, movie_id, char_id, line_num, line_text) VALUES('91', '570478', '417','1974' , 'No matter how hard the loss, defeat might serve as well as victory to shake the soul and let the glory out.');
;