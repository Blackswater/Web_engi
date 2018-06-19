drop table if exists documents;
create table documents (
       id int not null primary key auto_increment,
       name varchar(64),
       filename varchar(64),
       ownerid int,
       creationdate timestamp not null default current_timestamp,
       archivedate  timestamp null default null,
       deletiondate timestamp null default null,
       sha256 varchar(64),
       mimetype varchar(32),
       bytelength int
);

insert into documents values (1, 'Abrechnung Feb18 Lidl/Schwarz', 'testdocument.pdf', 1, CURRENT_TIMESTAMP, null, null, null, 'application/pdf', 18453);
insert into documents values (2, 'Productbild Florida Pink Grapefruit Artikel-Nr.:32054', 'F32054.jpg', 1, CURRENT_TIMESTAMP, null, null, null, 'application/pdf', 16989);
insert into documents values (3, 'Abrechnung Feb18 Lidl/Schwarz', 'testdocument.pdf', 1, CURRENT_TIMESTAMP, null, null, null, 'application/pdf', 18453);
insert into documents values (4, 'Abrechnung Feb18 Lidl/Schwarz', 'testdocument.pdf', 1, CURRENT_TIMESTAMP, null, null, null, 'application/pdf', 18453);
insert into documents values (5, 'Abrechnung Feb18 Lidl/Schwarz', 'testdocument.pdf', 1, CURRENT_TIMESTAMP, null, null, null, 'application/pdf', 18453);

drop table if exists users;
create table users (
  id INT NOT NULL primary key AUTO_INCREMENT,
  email VARCHAR(80) NOT NULL,
  firstname VARCHAR(50) NOT NULL,
  lastname VARCHAR(50) NOT NULL,
  salthash CHAR(64) NOT NULL,
  accesslevel int, -- 1=admin, 2=user
  creationdate timestamp not null default current_timestamp,
  deletiondate timestamp null default null,
  UNIQUE INDEX (email)
);

insert into users values (1, 'mjanich@chimerasys.com', 'Michael', 'Janich', 'abc', 1, CURRENT_TIMESTAMP, null);

drop table if exists tags;
create table tags (
  id INT NOT NULL primary key AUTO_INCREMENT,
  category varchar(32) not null,
  label varchar(32) not null,
  creationdate timestamp not null default current_timestamp,
  deletiondate timestamp null default null
);

insert into tags (category, label) values ('Abteilung', 'Vertrieb');
insert into tags (category, label) values ('Abteilung', 'Buchhaltung');
insert into tags (category, label) values ('Abteilung', 'Intern');
insert into tags (category, label) values ('Abteilung', 'Manufaktur');
insert into tags (category, label) values ('Kunde', 'Heideldruck');
insert into tags (category, label) values ('Kunde', 'LidlSchwarz');
insert into tags (category, label) values ('Kunde', 'ReweKaufland');
insert into tags (category, label) values ('Kategorie', 'WICHTIG');
insert into tags (category, label) values ('Kategorie', 'DRINGEND');
insert into tags (category, label) values ('Kategorie', 'Ablage');

DROP TABLE IF EXISTS documenttags;
create table documenttags (
       documentid int,
       tagid int,
       creationdate timestamp not null default current_timestamp,
       deletiondate timestamp null default null
);

insert into documenttags (documentid, tagid) values (1, 1);
insert into documenttags (documentid, tagid) values (1, 5);
insert into documenttags (documentid, tagid) values (1, 8);
insert into documenttags (documentid, tagid) values (2, 2);
insert into documenttags (documentid, tagid) values (2, 6);
insert into documenttags (documentid, tagid) values (2, 9);

  drop table if exists events;
  create table events (
         id int not null primary key auto_increment,
         name varchar(128),
         dtstart timestamp not null ,
         dtend timestamp null default null,
         ownerid int,
         alarmmin int,
         status varchar(16),
         location varchar(80),
         repeattype varchar(1), -- 'd' = repeat daily; 'w'=weekly, 'f'=fortnightly, 'm'=monthly, 'y'=annually
         repeatuntil date, -- date of last repeat
         comment text,
         url varchar(128),
         creationdate timestamp not null default current_timestamp,
         deletiondate timestamp null default null
         );

  DROP TABLE IF EXISTS eventtags;
  create table eventtags (
         eventid int,
         tagid int,
         creationdate timestamp not null default current_timestamp,
         deletiondate timestamp null default null
  );


  insert into events values (1, 'Pfingsten 2018', '2018-05-21 00:00:00', '2018-05-21 00:00:00', 1, 0, 'Holiday', '', '', null, '', '', current_timestamp, null);
  insert into events values (2, 'WebEng INF17B', '2018-06-18 13:00:00', '2018-06-18 16:15:00', 1, 0, '', 'B0.260', '', null, 'Letzte Vorlesung', 'http://www.dhbw-mosbach.de/', current_timestamp, null);
  -- repeat weekly till
  -- repeat every 2 weeks
  -- repeat every month
  -- repeat every year
