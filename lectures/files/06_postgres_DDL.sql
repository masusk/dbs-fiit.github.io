CREATE  TABLE restaurants (
  id serial NOT NULL,
  name VARCHAR(45) NOT NULL,
  capacity INT,
  PRIMARY KEY(id) );

CREATE  TABLE students (
  id serial NOT NULL PRIMARY KEY,
  name VARCHAR(45) NOT NULL,
  vsp FLOAT NULL);


CREATE  TABLE lunches (
  id serial NOT NULL PRIMARY KEY,
  student_id BIGINT NOT NULL REFERENCES students(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  restaurant_id BIGINT NOT NULL REFERENCES restaurants(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  was_tasty BOOLEAN
  );

INSERT INTO students(id,name,vsp) VALUES
  (1,'Jozko Mrkvicka', 3.9),
  (2,'Ferko Fazulka', 2.1),
  (3,'Zuzka Hraskova', 1.2),
  (4,'Katka Malinova', 2.5),
  (5,'Petko Egresovy', 1.2),
  (6,'Janko Zemiakovy', 1.7),
  (7,'Zuzka Hraskova', 2.2);

INSERT INTO restaurants(id,name,capacity) VALUES
  (1,'horna', 300),
  (2,'dolna', 150),
  (3,'studentska', 80),
  (4,'prifuk', 60),
  (5,'palmyra', 50);
  
INSERT INTO lunches(student_id,restaurant_id,was_tasty) VALUES
  (1,2,true),
  (1,3,false),
  (2,1,true),
  (2,5,true),
  (3,1,false),
  (3,4,true),
  (4,3,false),
  (4,4,false),
  (5,1,true),
  (5,1,true);