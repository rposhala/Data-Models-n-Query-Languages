DROP DATABASE IF EXISTS PROJECT1;

CREATE DATABASE PROJECT1;

USE PROJECT1;


	CREATE TABLE USER (
	username varchar(155) NOT NULL UNIQUE,
    firstname char NOT NULL,
    lastname char NOT NULL,
	address varchar(155) NOT NULL,
    dob varchar(50)  NOT NULL,
    PRIMARY KEY (username)
    
	);
	CREATE TABLE ACCOUNT (
	email_ID varchar(155) NOT NULL UNIQUE,
	displayname varchar(50) UNIQUE,
    password varchar(40) NOT NULL,
    username varchar(155) NOT NULL UNIQUE,
    PRIMARY KEY (email_ID),
    FOREIGN KEY (username) REFERENCES USER (username)
	);
    
	CREATE TABLE DEPARTMENT (
	  department_ID varchar(100) NOT NULL UNIQUE,	
      department_name char NOT NULL UNIQUE,
	  PRIMARY KEY (department_ID)
      
	);
    CREATE TABLE PROGRAM (
    program_ID varchar(100) NOT NULL UNIQUE,
    program_name char NOT NULL UNIQUE,
    department_ID varchar(100) NOT NULL UNIQUE,
    PRIMARY KEY (program_ID),
    FOREIGN KEY (department_ID) REFERENCES DEPARTMENT (department_ID)
    );
	CREATE TABLE OFFERS (
    department_id varchar (100) NOT NULL,
    program_id varchar(100) NOT NULL,
    PRIMARY KEY (department_id, program_id),
    FOREIGN KEY (department_ID) REFERENCES DEPARTMENT (department_ID),
    FOREIGN KEY (program_ID) REFERENCES PROGRAM (program_ID)
    
    );
    CREATE TABLE STUDENT (
	  student_ID varchar(155) NOT NULL UNIQUE,
      username char NOT NULL UNIQUE,
	  PRIMARY KEY (student_id),
	  FOREIGN KEY (username) REFERENCES USER (username)
	);

	CREATE TABLE STAFF (
	  staff_ID varchar(100) NOT NULL,
      username char NOT NULL UNIQUE,
      department_ID varchar(100) NOT NULL,
	  PRIMARY KEY (staff_ID),
      FOREIGN KEY (department_ID) REFERENCES DEPARTMENT (department_ID),
	  FOREIGN KEY (username) REFERENCES USER (username)
	);
    
    CREATE TABLE PROFESSOR (
	  professor_ID varchar(100) NOT NULL,
      department_ID varchar(100) NOT NULL,
      username char NOT NULL UNIQUE,
	  PRIMARY KEY (professor_ID),
	  FOREIGN KEY (department_ID) REFERENCES DEPARTMENT (department_ID),
      FOREIGN KEY (username) REFERENCES USER (username)
	);
	CREATE TABLE SEMESTER (
      sem_year int NOT NULL,
      sem_seaon char NOT NULL,
	  PRIMARY KEY (sem_year,sem_season)
	  );

    CREATE TABLE COURSE (
	  course_ID varchar(100) NOT NULL UNIQUE ,
	  course_name varchar(50) NOT NULL,
      department_id varchar(100) NOT NULL,   
	  PRIMARY KEY (course_ID),
      FOREIGN KEY (department_id) REFERENCES OFFERS (department_ID)
	  );
     
	CREATE TABLE PREREQUISITES (
	course_id varchar(100) NOT NULL,
    prereq_id varchar(100),
    PRIMARY KEY (course_id,prereq_id),
    FOREIGN KEY (course_id) REFERENCES COURSE (course_id),
    FOREIGN KEY (prereq__id) REFERENCES COURSE (course_id)
	);
     
     
     
    CREATE TABLE OPENS_IN (
	    sem_year int NOT NULL,
      sem_season char NOT NULL,
      course_ID varchar(100) NOT NULL,
      student_id varchar(155) NOT NULL,
      capacity int NOT NULL,
      primary key(sem_year, sem_season, course_ID),
	  FOREIGN KEY (sem_year) REFERENCES SEMESTER (sem_year),
      FOREIGN KEY (sem_season) REFERENCES SEMESTER (sem_season),
      FOREIGN KEY (course_ID) REFERENCES COURSE (course_ID)
	  );
          
	CREATE TABLE TA (
    ta_ID varchar(100) NOT NULL ,
    course_ID varchar(100) NOT NULL,
    ta_from date NOT NULL,
    ta_to date NOT NULL, 
    sem_year int NOT NULL,
    sem_season char NOT NULL,
    PRIMARY KEY (ta_ID,course_ID,sem_year,sem_season),
    FOREIGN KEY (ta_ID) REFERENCES STUDENT (student_ID),
    FOREIGN KEY (course_id) REFERENCES OPENS_IN(course_ID),
    FOREIGN KEY (sem_year) REFERENCES OPENS_IN (sem_year),
    FOREIGN KEY (sem_season) REFERENCES OPENS_IN (sem_season)
    );
	
    CREATE TABLE INSTRUCTOR (
    instructor_ID varchar(100) NOT NULL,
    PRIMARY KEY (instructor_ID),
    FOREIGN KEY (instructor_ID) REFERENCES PROFESSOR (professor_ID)
    );
      
      CREATE TABLE MAJORS_IN (
	  student_ID varchar(100) NOT NULL,
      department_ID varchar(100) NOT NULL,
      primary key (student_id, department_id),
	  FOREIGN KEY (student_ID) REFERENCES STUDENT (student_ID),
      FOREIGN KEY (department_ID) REFERENCES OFFERS (department_ID)
	  );
      
      CREATE TABLE REGISTERS (
		student_id varchar(100) NOT NULL,
        sem_year int NOT NULL,
        sem_season char NOT NULL,
        PRIMARY KEY (student_id, sem_year, sem_season),
        FOREIGN KEY (student_id) REFERENCES MAJORS_IN (student_id),
        FOREIGN KEY (sem_year) REFERENCES SEMESTER (sem_year),
        FOREIGN KEY (sem_season) REFERENCES SEMESTER (sem_season)
      );
      
      CREATE TABLE ENROLL (
	  student_ID varchar(100) NOT NULL,
      course_id varchar(100) NOT NULL,
      sem_year int NOT NULL,
      sem_season char NOT NULL,
      primary key (student_id, course_ID, sem_year, sem_season),
	  FOREIGN KEY (student_ID) REFERENCES REGISTERS (student_ID),
      FOREIGN KEY (course_id) REFERENCES OPENS_IN (course_id),
      FOREIGN KEY (sem_year) REFERENCES OPENS_IN (sem_year),
      FOREIGN KEY (sem_season) REFERENCES OPENS_IN (sem_season)
	  );
      
      CREATE TABLE INSTRUCTS (
      instructor_id varchar(100) NOT NULL,
      course_id varchar(100) NOT NULL,
      inst_from date NOT NULL,
      inst_to date NOT NULL,
      sem_year int NOT NULL,
      sem_season char NOT NULL,
      PRIMARY KEY (instructor_id, course_id, sem_season, sem_year),
      FOREIGN KEY (instructor_id) REFERENCES INSTRUCTOR (instructor_id),
      FOREIGN KEY (course_id) REFERENCES OPENS_IN (course_id)
      );
      
      
      CREATE TABLE FEEDBACK (
	  student_ID varchar(100) NOT NULL,      
      instructor_id varchar(100) NOT NULL,
      course_ID varchar(100) NOT NULL,
      sem_year int NOT NULL,
      sem_season char NOT NULL,
      feedback varchar(150) NOT NULL,
      primary key (student_id, course_id, sem_year, sem_season, instructor_id),
	  FOREIGN KEY (student_ID) REFERENCES ENROLL (student_ID),      
      FOREIGN KEY (instructor_ID) REFERENCES INSTRUCTS (instructor_ID),
      FOREIGN KEY (course_id) REFERENCES ENROLL (course_ID),
      FOREIGN KEY (sem_year) REFERENCES ENROLL (sem_year),
      FOREIGN KEY (sem_season) REFERENCES ENROLL (sem_season)
	  );
      
      CREATE TABLE EXAM (
      course_id varchar(100) NOT NULL,
      exam_id varchar(100) NOT NULL,
      student_id varchar (100) NOT NULL,
      problems varchar(255) NOT NULL,
      answers varchar(255) NOT NULL,
      percentage double NOT NULL,
      primary key(exam_id),
      FOREIGN KEY (course_id) REFERENCES ENROLL (course_id),
      FOREIGN KEY (course_id) REFERENCES ENROLL (student_id)
	  );
      
      CREATE TABLE GRADES (
      letters char NOT NULL,
      percentage double NOT NULL,
      PRIMARY KEY (letters)
      );
      
      
      
