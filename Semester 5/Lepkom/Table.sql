Create database hr;
use hr;

CREATE TABLE regions
    ( region_id      NUMERIC 
       CONSTRAINT  region_id_nn NOT NULL 
    , region_name    VARCHAR(25) 
    );

CREATE TABLE countries 
    ( country_id      CHAR(2) 
       CONSTRAINT  country_id_nn NOT NULL 
    , country_name    VARCHAR(40) 
    , region_id       NUMERIC 
     CONSTRAINT     country_c_id_pk 
        	     PRIMARY KEY (country_id) 
    ); 
       		    	     	  
CREATE TABLE locations
    ( location_id    NUMERIC(4) 
	CONSTRAINT  location_id_nn NOT NULL 
    , street_address VARCHAR(40)
    , postal_code    VARCHAR(12)
    , city       VARCHAR(30)
	CONSTRAINT     loc_city_nn  NOT NULL
    , state_province VARCHAR(25)
    , country_id     CHAR(2)
    ) ;
    
    CREATE TABLE departments
    ( department_id    NUMERIC(4)
     CONSTRAINT  department_id_nn NOT NULL 
    , department_name  VARCHAR(30)
	CONSTRAINT  dept_name_nn  NOT NULL
    , manager_id       NUMERIC(6)
    , location_id      NUMERIC(4)
    ) ;
    
    CREATE TABLE jobs
    ( job_id         VARCHAR(10)
    , job_title      VARCHAR(35)
	CONSTRAINT     job_title_nn  NOT NULL
    , min_salary     NUMERIC(6)
    , max_salary     NUMERIC(6)
    ) ;

    CREATE TABLE employees
    ( employee_id    NUMERIC(6)
    , first_name     VARCHAR(20)
    , last_name      VARCHAR(25)
	 CONSTRAINT     emp_last_name_nn  NOT NULL
    , email          VARCHAR(25)
	CONSTRAINT     emp_email_nn  NOT NULL
    , phone_NUMERIC   VARCHAR(20)
    , hire_date      DATE
	CONSTRAINT     emp_hire_date_nn  NOT NULL
    , job_id         VARCHAR(10)
	CONSTRAINT     emp_job_nn  NOT NULL
    , salary         NUMERIC(8,2)
    , commission_pct NUMERIC(2,2)
    , manager_id     NUMERIC(6)
    , department_id  NUMERIC(4)
    , CONSTRAINT     emp_salary_min
                     CHECK (salary > 0) 
    , CONSTRAINT     emp_email_uk
                     UNIQUE (email)
    ) ;
    
   CREATE TABLE job_history
    ( employee_id   NUMERIC(6)
	 CONSTRAINT    jhist_employee_nn  NOT NULL
    , start_date    DATE
	CONSTRAINT    jhist_start_date_nn  NOT NULL
    , end_date      DATE
	CONSTRAINT    jhist_end_date_nn  NOT NULL
    , job_id        VARCHAR(10)
	CONSTRAINT    jhist_job_nn  NOT NULL
    , department_id NUMERIC(4)
    , CONSTRAINT    jhist_date_interval
                    CHECK (end_date > start_date)
    ) ;

 
CREATE UNIQUE INDEX reg_id_pk
ON regions (region_id);

ALTER TABLE regions add constraint region_pk PRIMARY KEY (region_id);

    ALTER TABLE countries
ADD CONSTRAINT countr_reg_fk
        	 FOREIGN KEY (region_id)
          	  REFERENCES regions(region_id);
    
    ALTER TABLE locations
ADD CONSTRAINT loc_id_pk
PRIMARY KEY (location_id), CONSTRAINT loc_c_id_fk
       		 FOREIGN KEY (country_id)
        	  REFERENCES countries(country_id);          	  
        
        
          	   
ALTER TABLE departments ADD CONSTRAINT dept_id_pk PRIMARY KEY (department_id), 
CONSTRAINT dept_loc_fk
       		 FOREIGN KEY (location_id)
        	  REFERENCES locations (location_id);