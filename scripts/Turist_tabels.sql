CREATE TABLE tourist(
    id_tourist  NUMBER(4) PRIMARY KEY,
    fio VARCHAR2(70),
    birthday_date DATE,
    telephone VARCHAR2(11),
    mail VARCHAR2(50),
    physical_level VARCHAR2(50),
    gender VARCHAR2(15),
    dif_category VARCHAR2(30),
    ranking VARCHAR2(30)
);

alter table tourist add CONSTRAINT telephone CHECK (SUBSTR(TELEPHONE,1,1)='8' ) ;
alter TABLE tourist add CONSTRAINT physical_level CHECK (physical_level >=1 and physical_level<= 10);
alter TABLE tourist add CONSTRAINT gender CHECK (gender = 'ж' or gender = 'м');
alter TABLE tourist add CONSTRAINT DIF_CATEGORY CHECK (DIF_CATEGORY >=1 and DIF_CATEGORY<= 5);
alter TABLE tourist add CONSTRAINT RANKING CHECK (RANKING = 'любитель' or RANKING= 'спортсмен'or RANKING= 'тренер');

ALTER TABLE tourist MODIFY fio VARCHAR2(500);
ALTER TABLE tourist MODIFY mail VARCHAR2(500);
ALTER TABLE tourist MODIFY gender VARCHAR(10);
ALTER TABLE tourist MODIFY physical_level NUMBER(10);
ALTER TABLE tourist MODIFY dif_category NUMBER(2);


CREATE TABLE hike_instructor(
    id_inst  NUMBER(4) PRIMARY KEY,
    id_tourist NUMBER(4) REFERENCES tourist(id_tourist)
);

CREATE TABLE route(
    id_route  NUMBER(4) PRIMARY KEY,
    name VARCHAR2(40),
    days NUMBER(3),
    dif_level VARCHAR2(11),
    length NUMBER(3)
);
alter TABLE route add CONSTRAINT dif_level CHECK (DIF_level >=1 and DIF_level<= 5);

ALTER TABLE route MODIFY name VARCHAR2(500);
ALTER TABLE route MODIFY dif_level VARCHAR2(2);


CREATE TABLE camp(
    id_camp  NUMBER(4) PRIMARY KEY,
    time date,
    location  VARCHAR2(30),
    id_route  NUMBER(4) REFERENCES route(id_route)
    
);

ALTER TABLE camp MODIFY time VARCHAR2(100);
ALTER TABLE camp MODIFY location VARCHAR2(200);

CREATE TABLE hike(
    id_hike  NUMBER(4) PRIMARY KEY,
    date_hike date,
    type  VARCHAR2(30),
    id_route  NUMBER(4) REFERENCES route(id_route),
    id_inst  NUMBER(4) REFERENCES hike_instructor(id_inst)
);


CREATE TABLE hike_tourist(
    id_hike  NUMBER(4) REFERENCES hike(id_hike),
    id_tourist  NUMBER(4) REFERENCES tourist(id_tourist)
);

CREATE TABLE section(
    id_section  NUMBER(4) PRIMARY KEY,
    direction VARCHAR2(30)
);
ALTER TABLE section MODIFY direction VARCHAR2(100);

CREATE TABLE load(
    id_load  NUMBER(4) PRIMARY KEY,
    type VARCHAR2(30),
    hour  NUMBER(3),
    salary  NUMBER(5) 
);
ALTER TABLE load MODIFY type VARCHAR2(200);

CREATE TABLE trainer(
    id_trainer  NUMBER(4) PRIMARY KEY,
    date_start date,
    id_tourist  NUMBER(4) REFERENCES tourist(id_tourist),
    specialization VARCHAR2(30)
);
ALTER TABLE trainer MODIFY specialization  VARCHAR2(200);

CREATE TABLE team(
    id_team NUMBER(4) PRIMARY KEY,
    name VARCHAR2(30),
    physical_level VARCHAR2(50),
    id_trainer  NUMBER(4) REFERENCES trainer(id_trainer),
    id_section  NUMBER(4) REFERENCES section(id_section)
);
ALTER TABLE team MODIFY physical_level  VARCHAR2(2);
alter TABLE team add CONSTRAINT phys CHECK (physical_level  >=1 and physical_level<= 10);

CREATE TABLE lesson(
    id_team NUMBER(4)   REFERENCES team(id_team),
    date_lesson DATE ,
    description VARCHAR2(50),
    id_trainer  NUMBER(4) REFERENCES trainer(id_trainer)
);
ALTER TABLE lesson MODIFY description  VARCHAR2(200);

ALTER TABLE lesson
ADD CONSTRAINT PK_YourTableNameHere
PRIMARY KEY(id_team, date_lesson);

CREATE TABLE tourist_group(
    id_team NUMBER(4)   REFERENCES team(id_team),
    id_tourist NUMBER(4) REFERENCES tourist(id_tourist)
);

CREATE TABLE sportsman(
    id_sportsman NUMBER(4)PRIMARY KEY,
    id_tourist NUMBER(4) REFERENCES tourist(id_tourist),
    id_trainer  NUMBER(4) REFERENCES trainer(id_trainer)
);

CREATE TABLE competition(
    id_competition NUMBER(4)PRIMARY KEY,
    type VARCHAR2(30),
    stage VARCHAR2(30),
    date_competition DATE,
    location VARCHAR2(40)
);
ALTER TABLE competition MODIFY type  VARCHAR2(200);
ALTER TABLE competition MODIFY stage  VARCHAR2(200);
ALTER TABLE competition MODIFY location  VARCHAR2(200);

CREATE TABLE competition_sportcman(
    id_competition NUMBER(4) REFERENCES competition(id_competition),
    id_sportsman NUMBER(4) REFERENCES sportsman(id_sportsman)
);

CREATE TABLE head_section(
    id_head  NUMBER(4) PRIMARY KEY,
    fio VARCHAR2(70),
    birthday_date DATE,
    telephone VARCHAR2(11),
    mail VARCHAR2(50),
    salary NUMBER(5),
    date_start date,
    id_section  NUMBER(4) REFERENCES section(id_section)
);
alter table head_section add CONSTRAINT teleph CHECK (SUBSTR(TELEPHONE,1,1)='8' ) ;

ALTER TABLE head_section MODIFY fio VARCHAR2(500);
ALTER TABLE head_section MODIFY mail VARCHAR2(500);


CREATE TABLE load_trainer(
    id_load  NUMBER(4)   REFERENCES load(id_load),
    id_trainer NUMBER(4) REFERENCES trainer(id_trainer),
    date_est DATE,
    hours NUMBER(4)
);





















