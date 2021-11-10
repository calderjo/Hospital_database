USE calderon_cs355fl20;

DROP TABLE IF EXISTS hospital_medical_equipment;
DROP TABLE IF EXISTS hospital_nurse_patient;
DROP TABLE IF EXISTS hospital_nurses;
DROP TABLE IF EXISTS hospital_patient_symptoms;
DROP TABLE IF EXISTS hospital_medical_charts;
DROP TABLE IF EXISTS hospital_patients;
DROP TABLE IF EXISTS hospital_doctors;

-- This will create a table that will hold information about doctors
CREATE TABLE hospital_doctors(
       doctor_id char(6)
       		  CHECK (doctor_id REGEXP 'D[0-9]{5}'),

       specialty varchar(30)
       		 CHECK ( specialty IN
       		       ( 
       		       'Allergists', 'Dermatologists', 'Infectious disease', 'Ophthalmologists', 'gynecologists',
       		       'Cardiologists', 'Endocrinologists', 'Gastroenterologists','Nephrologists', 'Urologists',
       		       'Neurologists', 'Oncologists'
       		        )),
		       
       fName varchar(30) NOT NULL,
       lName varchar(30) NOT NULL,

       UNIQUE (fName, lName),

       PRIMARY KEY(doctor_id)
);

-- this will create a table that will hold information about patients 
CREATE TABLE hospital_patients(
        patient_id char(6) CHECK (patient_id REGEXP 'P[0-9]{5}'),
		    
        fName  varchar(30) DEFAULT 'John',
	lName  varchar(30) DEFAULT 'Doe',

	admission_date date,

	doctor char(6) DEFAULT NULL,

	PRIMARY KEY(patient_id),

	FOREIGN KEY(doctor) REFERENCES hospital_doctors(doctor_id)
	ON DELETE SET NULL
	ON UPDATE CASCADE
);

CREATE TABLE hospital_medical_charts(
       chart_id       char(6),
       patient        char(6),
       doctor         char(6),

       diagnosis      varchar(100),
       treatment      varchar(200),

       PRIMARY KEY(chart_id, patient, doctor),

       FOREIGN KEY (doctor)  REFERENCES hospital_doctors(doctor_id)
       ON DELETE NO ACTION
       ON UPDATE CASCADE,

       FOREIGN KEY (patient) REFERENCES hospital_patients(patient_id)
       ON DELETE CASCADE
       ON UPDATE NO ACTION
);

CREATE TABLE hospital_patient_symptoms(
       chart       char(6),
       patient     char(6),
       doctor      char(6),
       symptom     varchar(20),
       PRIMARY KEY (patient, doctor, chart, symptom),

       FOREIGN KEY (doctor)  REFERENCES hospital_doctors(doctor_id)
       ON DELETE CASCADE
       ON UPDATE CASCADE,

       FOREIGN KEY (patient) REFERENCES hospital_patients(patient_id)
       ON DELETE CASCADE
       ON UPDATE NO ACTION,

       FOREIGN KEY (chart)   REFERENCES hospital_medical_charts(chart_id)
       ON DELETE CASCADE
       ON UPDATE NO ACTION
);

-- This will create a table will hold information about nurses
CREATE TABLE hospital_nurses(
       nurse_id  char(6)
       		 CHECK (nurse_id REGEXP 'N[0-9]{5}'),

       specialty varchar(50),
       		 CHECK ( specialty IN
		       (
		       'Registered', 'Cardiac', 'Anesthetist', 'Critical Care', 'ER', 'Midwife',
		       'Family', 'Practitioner'
			)),

       fName varchar(30) NOT NULL,
       lName varchar(30) NOT NULL,

       PRIMARY KEY(nurse_id)	 
);


CREATE TABLE hospital_nurse_patient(
       nurse     char(6),
       patient   char(6),

       PRIMARY KEY (nurse, patient),

       FOREIGN KEY (nurse)   REFERENCES hospital_nurses(nurse_id)
       ON DELETE CASCADE
       ON UPDATE NO ACTION,

       FOREIGN KEY (patient) REFERENCES hospital_patients(patient_id)
       ON DELETE CASCADE
       ON UPDATE NO ACTION
);

-- This will create a table that will hold information about medical equiment
CREATE TABLE hospital_medical_equipment(
       equipment_number char(3),
       equipment_name   varchar(20),
       description      varchar(100),

       nurse            char(6) DEFAULT NULL,
       patient          char(6) DEFAULT NULL,
       
       PRIMARY KEY (equipment_number, equipment_name),

       FOREIGN KEY (nurse) REFERENCES hospital_nurses(nurse_id)
       ON DELETE SET NULL
       ON UPDATE CASCADE,

       FOREIGN KEY (patient) REFERENCES hospital_patients(patient_id)
       ON DELETE SET NULL
       ON UPDATE CASCADE
);

------------------------------------------------------------------------
-- We will clear out any data that might be in the data base
DELETE FROM hospital_medical_equipment;
DELETE FROM hospital_nurse_patient;
DELETE FROM hospital_nurses;
DELETE FROM hospital_patient_symptoms;
DELETE FROM hospital_medical_charts;
DELETE FROM hospital_patients;
DELETE FROM hospital_doctors;

-- The insert in this section on the code is related hospital patient
INSERT INTO hospital_doctors VALUES ('D37513',	     'Infectious disease',	'Gotzon',	'Tucker');
INSERT INTO hospital_doctors VALUES ('D99008',	     'Ophthalmologists',	'Ora',		'Knox');
INSERT INTO hospital_doctors VALUES ('D16066',	     'Urologists',		'Florence',	'Ewing');
INSERT INTO hospital_doctors VALUES ('D89187',	     'Oncologists',		'Cora',		'Vaughn');
INSERT INTO hospital_doctors VALUES ('D20724',	     'Allergists',		'River',	'Fowler');
INSERT INTO hospital_doctors VALUES ('D38356',	     'Urologists',		'Delfina',	'Pollard');
INSERT INTO hospital_doctors VALUES ('D47483',	     'Cardiologists',		'Paulina',	'Finley');
INSERT INTO hospital_doctors VALUES ('D49600',	     'Nephrologists',		'Richard',	'Bridges');
INSERT INTO hospital_doctors VALUES ('D13430',	     'Gastroenterologists',	'Max',		'Leach');
INSERT INTO hospital_doctors VALUES ('D34972',	     'Endocrinologists',	'Angelina',	'Chaney');



INSERT INTO hospital_patients VALUES ('P82089',	     'Rebecca',			'Gillespie',	'2020-08-28',	'D37513');
INSERT INTO hospital_patients VALUES ('P49711',	     'Molly',			'Cook',		'2020-08-31',	'D99008');
INSERT INTO hospital_patients VALUES ('P34139',	     'Walter',			'White',	'2020-09-15',	'D38356');
INSERT INTO hospital_patients VALUES ('P39242',	     'Nicole',			'Lawson',	'2020-09-24',	'D47483');
INSERT INTO hospital_patients VALUES ('P17395',	     'Jasmine',			'Wolf',		'2020-09-27',	'D49600');
INSERT INTO hospital_patients VALUES ('P50700',	     'Millie',			'Bolton',	'2020-09-29',	'D99008');
INSERT INTO hospital_patients (patient_id, fName, lName, admission_date) VALUES ('P41862',	     'Amy',			'Summers',	'2020-10-04');
INSERT INTO hospital_patients VALUES ('P54500',	     'Anna',			'Watkins',	'2020-10-05',	'D89187');
INSERT INTO hospital_patients VALUES ('P25017',	     'Queta',			'Graves',	'2020-10-06',	'D47483');
INSERT INTO hospital_patients VALUES ('P17742',	     'Tasia',			'Mitchell',	'2020-10-08',	'D37513');
INSERT INTO hospital_patients VALUES ('P94612',	     'Thomas',			'May',		'2020-10-09',	'D34972');
INSERT INTO hospital_patients VALUES ('P48072',	     'Harry',			'Ho',		'2020-10-11',	'D20724');
INSERT INTO hospital_patients VALUES ('P18228',	     'Aaron',			'Haynes',	'2020-10-12',	'D38356');
INSERT INTO hospital_patients VALUES ('P67649',	     'Oliver',			'Cherry',	'2020-10-16',	'D47483');
INSERT INTO hospital_patients VALUES ('P61007',	     'Mireia',			'Morrison',	'2020-10-17',	'D37513');



INSERT INTO hospital_medical_charts VALUES('691391','P82089','D37513','COVID19','Bronchodilator');
INSERT INTO hospital_medical_charts VALUES('572140','P49711','D99008','Urinary tract infection','Amoxicillin');
INSERT INTO hospital_medical_charts VALUES('460227','P34139','D38356','Lung Cancer','Chemotherapy');
INSERT INTO hospital_medical_charts VALUES('395028','P39242','D47483','Hypertension','ACE inhibitor');
INSERT INTO hospital_medical_charts VALUES('226663','P17395','D49600','Hyperlipidemia','steroid therapy');
INSERT INTO hospital_medical_charts VALUES('181353','P50700','D99008','Diabetes','Insulin');
INSERT INTO hospital_medical_charts VALUES('994313','P41862','D16066','Back pain','Naproxen');
INSERT INTO hospital_medical_charts VALUES('884548','P54500','D89187','Anxiety','Diazepam');
INSERT INTO hospital_medical_charts VALUES('716288','P25017','D47483','Obesity','Bypass surgery');
INSERT INTO hospital_medical_charts VALUES('668813','P17742','D37513','Dysentery','Oral rehydration therapy');
INSERT INTO hospital_medical_charts VALUES('520092','P94612','D34972','COVID19','Bronchodilator');
INSERT INTO hospital_medical_charts VALUES('491474','P48072','D20724','Coronary atherosclerosis','Angioplasty');
INSERT INTO hospital_medical_charts VALUES('325283','P18228','D38356','Acute bronchitis','Analgesic');
INSERT INTO hospital_medical_charts VALUES('247832','P67649','D47483','Asthma','Bronchodilator');
INSERT INTO hospital_medical_charts VALUES('138167','P61007','D37513','Urinary tract infection','Amoxicillin');



INSERT INTO hospital_patient_symptoms VALUES('668813','P17742','D37513','Fever');
INSERT INTO hospital_patient_symptoms VALUES('572140','P49711','D99008','Body aches');
INSERT INTO hospital_patient_symptoms VALUES('460227','P34139','D38356','Chest pain');
INSERT INTO hospital_patient_symptoms VALUES('395028','P39242','D47483','Confusion');
INSERT INTO hospital_patient_symptoms VALUES('226663','P17395','D49600','Headache');
INSERT INTO hospital_patient_symptoms VALUES('181353','P50700','D99008','Fatigue');
INSERT INTO hospital_patient_symptoms VALUES('994313','P41862','D16066','Jumbled speech');
INSERT INTO hospital_patient_symptoms VALUES('884548','P54500','D89187','Hallucination');
INSERT INTO hospital_patient_symptoms VALUES('716288','P25017','D47483','Tenderness');
INSERT INTO hospital_patient_symptoms VALUES('668813','P17742', 'D37513','Chest pain');
INSERT INTO hospital_patient_symptoms VALUES('520092','P94612', 'D34972','Headache');
INSERT INTO hospital_patient_symptoms VALUES('491474','P48072', 'D20724','Urinary retention');
INSERT INTO hospital_patient_symptoms VALUES('325283','P18228',	'D38356','Cramping');
INSERT INTO hospital_patient_symptoms VALUES('247832','P67649', 'D47483','Fever');
INSERT INTO hospital_patient_symptoms VALUES('138167','P61007',	'D37513','Nausea');
INSERT INTO hospital_patient_symptoms VALUES('572140','P49711',	'D99008','Nausea');
INSERT INTO hospital_patient_symptoms VALUES('460227','P34139', 'D38356','Fatigue');
INSERT INTO hospital_patient_symptoms VALUES('395028','P39242',	'D47483','Cramping');
INSERT INTO hospital_patient_symptoms VALUES('226663','P17395',	'D49600','Inflammation');
INSERT INTO hospital_patient_symptoms VALUES('181353','P50700',	'D99008','Chest pain');
INSERT INTO hospital_patient_symptoms VALUES('994313','P41862',	'D16066','Inflammation');
INSERT INTO hospital_patient_symptoms VALUES('884548','P54500',	'D89187','Nausea');
INSERT INTO hospital_patient_symptoms VALUES('716288','P25017',	'D47483','Diarrhea');
INSERT INTO hospital_patient_symptoms VALUES('668813','P17742',	'D37513','Dry Cough');
INSERT INTO hospital_patient_symptoms VALUES('520092','P94612',	'D34972','Urinary retention');
INSERT INTO hospital_patient_symptoms VALUES('491474','P48072',	'D20724','Swelling');
INSERT INTO hospital_patient_symptoms VALUES('325283','P18228',	'D38356','Fever');
INSERT INTO hospital_patient_symptoms VALUES('247832','P67649',	'D47483','Tenderness');
INSERT INTO hospital_patient_symptoms VALUES('138167','P61007', 'D37513','Diarrhea');



INSERT INTO hospital_nurses VALUES('N72751',	'Anesthetist',		'Gotzone',	'Arnold');
INSERT INTO hospital_nurses VALUES('N29004',	'Cardiac',		'Adam',		'Gentry');
INSERT INTO hospital_nurses VALUES('N84828',	'Critical Care',	'Queta',	'Dean');
INSERT INTO hospital_nurses VALUES('N47661',	'Critical Care',	'Molly',	'Wu');
INSERT INTO hospital_nurses VALUES('N17737',	'Critical Care',	'Rebecca',	'Burns');
INSERT INTO hospital_nurses VALUES('N95709',	'Critical Care',	'Septima',	'Smith');
INSERT INTO hospital_nurses VALUES('N14530',	'Practitioner',		'Jacob',	'Jacobs');
INSERT INTO hospital_nurses VALUES('N48911',	'Practitioner',		'Andrea',	'Mcintosh');
INSERT INTO hospital_nurses VALUES('N27085',	'Anesthetist',		'Gotzone',	'Rhodes');
INSERT INTO hospital_nurses VALUES('N33946',	'Midwife',		'Tasia',	'Fitzpatrick');
INSERT INTO hospital_nurses VALUES('N91698',	'Midwife',		'Alexandra',	'Berg');
INSERT INTO hospital_nurses VALUES('N93084',	'Midwife',		'Adam',		'Haley');
INSERT INTO hospital_nurses VALUES('N28434',	'Midwife',		'Jacob',	'Cooper');
INSERT INTO hospital_nurses VALUES('N18619',	'ER',			'Joseph',	'Potts');
INSERT INTO hospital_nurses VALUES('N91367',	'ER',			'Rivka',	'Anthony');
INSERT INTO hospital_nurses VALUES('N23993',	'ER',			'Harrison',	'Deleon');
INSERT INTO hospital_nurses VALUES('N69195',	'ER',			'Christopher',	'Henson');
INSERT INTO hospital_nurses VALUES('N81278',	'ER',			'Joshua',	'Hardin');



INSERT INTO hospital_nurse_patient VALUES('N28434',         'P82089' );
INSERT INTO hospital_nurse_patient VALUES('N72751',	    'P49711' );
INSERT INTO hospital_nurse_patient VALUES('N29004',	    'P34139' );
INSERT INTO hospital_nurse_patient VALUES('N84828',	    'P39242' );
INSERT INTO hospital_nurse_patient VALUES('N47661',	    'P17395' );
INSERT INTO hospital_nurse_patient VALUES('N17737',	    'P50700' );
INSERT INTO hospital_nurse_patient VALUES('N95709',	    'P41862' );
INSERT INTO hospital_nurse_patient VALUES('N14530',	    'P54500' );
INSERT INTO hospital_nurse_patient VALUES('N48911',	    'P25017' );
INSERT INTO hospital_nurse_patient VALUES('N27085',	    'P17742' );
INSERT INTO hospital_nurse_patient VALUES('N33946',	    'P94612' );
INSERT INTO hospital_nurse_patient VALUES('N91698',	    'P48072' );
INSERT INTO hospital_nurse_patient VALUES('N93084',	    'P18228' );
INSERT INTO hospital_nurse_patient VALUES('N91367',	    'P67649' );
INSERT INTO hospital_nurse_patient VALUES('N23993',	    'P61007' );
INSERT INTO hospital_nurse_patient VALUES('N69195',	    'P82089' );
INSERT INTO hospital_nurse_patient VALUES('N81278',	    'P49711' );
INSERT INTO hospital_nurse_patient VALUES('N84828',	    'P34139' );
INSERT INTO hospital_nurse_patient VALUES('N47661',	    'P39242' );
INSERT INTO hospital_nurse_patient VALUES('N17737',	    'P17395' );
INSERT INTO hospital_nurse_patient VALUES('N95709',	    'P50700' );
INSERT INTO hospital_nurse_patient VALUES('N14530',	    'P41862' );
INSERT INTO hospital_nurse_patient VALUES('N48911',	    'P54500' );
INSERT INTO hospital_nurse_patient VALUES('N27085',	    'P25017' );
INSERT INTO hospital_nurse_patient VALUES('N33946',	    'P17742' );
INSERT INTO hospital_nurse_patient VALUES('N91698',	    'P94612' );
INSERT INTO hospital_nurse_patient VALUES('N93084',	    'P48072' );
INSERT INTO hospital_nurse_patient VALUES('N28434',	    'P18228' );
INSERT INTO hospital_nurse_patient VALUES('N18619',	    'P67649' );
INSERT INTO hospital_nurse_patient VALUES('N28434',	    'P61007' );
INSERT INTO hospital_nurse_patient VALUES('N91698',	    'P25017' );
INSERT INTO hospital_nurse_patient VALUES('N93084',	    'P17742' );
INSERT INTO hospital_nurse_patient VALUES('N28434',	    'P94612' );
INSERT INTO hospital_nurse_patient VALUES('N18619',	    'P48072' );
INSERT INTO hospital_nurse_patient VALUES('N72751',	    'P18228' );
INSERT INTO hospital_nurse_patient VALUES('N29004',	    'P67649' );
INSERT INTO hospital_nurse_patient VALUES('N84828',	    'P61007' );



INSERT INTO hospital_medical_equipment VALUES('1','Insulin pump','Inserts insulin into body','N28434','P82089');
INSERT INTO hospital_medical_equipment (equipment_number ,equipment_name, description) VALUES('2','Insulin pump','Inserts insulin into body');
INSERT INTO hospital_medical_equipment(equipment_number ,equipment_name, description) VALUES('3','Insulin pump','Inserts insulin into body');
INSERT INTO hospital_medical_equipment(equipment_number ,equipment_name, description) VALUES('4','Insulin pump','Inserts insulin into body');
INSERT INTO hospital_medical_equipment(equipment_number ,equipment_name, description) VALUES('5','Insulin pump','Inserts insulin into body');



INSERT INTO hospital_medical_equipment  VALUES('1','Incubator','Safe place for babies','N72751','P49711');
INSERT INTO hospital_medical_equipment(equipment_number ,equipment_name, description) VALUES('2','Incubator','Safe place for babies');
INSERT INTO hospital_medical_equipment(equipment_number ,equipment_name, description) VALUES('3','Incubator','Safe place for babies');
INSERT INTO hospital_medical_equipment(equipment_number ,equipment_name, description) VALUES('4','Incubator','Safe place for babies');
INSERT INTO hospital_medical_equipment(equipment_number ,equipment_name, description) VALUES('5','Incubator','Safe place for babies');
INSERT INTO hospital_medical_equipment(equipment_number ,equipment_name, description) VALUES('6','Incubator','Safe place for babies');



INSERT INTO hospital_medical_equipment VALUES('1','Heart-lung Machine','Helps blood flow in the body','N29004','P34139');
INSERT INTO hospital_medical_equipment(equipment_number ,equipment_name, description) VALUES('2','Heart-lung Machine','Helps blood flow in the body');



INSERT INTO hospital_medical_equipment VALUES('1','Medical Ventilator','Helps patient breathe','N84828','P39242');
INSERT INTO hospital_medical_equipment VALUES('4','Medical Ventilator','Helps patient breathe','N28434','P82089');
INSERT INTO hospital_medical_equipment(equipment_number ,equipment_name, description) VALUES('2','Medical Ventilator','"helps patient breathe');
INSERT INTO hospital_medical_equipment(equipment_number ,equipment_name, description) VALUES('3','Medical Ventilator','"helps patient breathe');



INSERT INTO hospital_medical_equipment VALUES('1', 'Dialysis Machine', 'Filters blood','N47661','P17395');
INSERT INTO hospital_medical_equipment VALUES('1','Anesthesia machine','Numbs the pain','N17737','P50700');
INSERT INTO hospital_medical_equipment(equipment_number ,equipment_name, description) VALUES('1','X-ray','Veiw the inside of a body without the use of surgery');

