USE calderon_cs355fl20;
-- CREATED BY JONATHAN CALDERON CHAVEZ
-- BY OCT 29, 2020

-- This is view of all the patients in the database,
-- with thier associated diagnosis and treatment
CREATE OR REPLACE VIEW patient_overview AS
SELECT
P.patient_id,
P.fName  AS  firstName,
C.diagnosis,
C.treatment

FROM
hospital_patients        AS  P,
hospital_medical_charts  AS  C

WHERE
P.patient_id = C.patient;



-- This function will take a doctor id,
-- and will return the number of patient.
-- this is my derived attribute 
DELIMITER //
CREATE OR REPLACE FUNCTION  num_patients
(
docID char(6) 
)
RETURNS integer

BEGIN
DECLARE p_count INTEGER DEFAULT 0;

SELECT count(P.patient_id) INTO p_count
FROM hospital_patients AS P

WHERE docID = P.doctor;

RETURN p_count;

END //
DELIMITER ;

-- Procedure will take 
DELIMITER //
CREATE OR REPLACE PROCEDURE remove_doctor
(
IN     patientID  char(6)
)

BEGIN
UPDATE hospital_patients
SET doctor = NULL
WHERE
patient_id = patientID;
END //
DELIMITER ;



-- Query(1)
-- This query will list the name and id of all
-- patient that have covid and are currently
-- on a ventilator
SELECT
P.patient_id,
P.fName  AS  firstName 

FROM
hospital_patients AS P

WHERE

P.patient_id

IN
(
SELECT C.patient
FROM
hospital_medical_equipment    AS   E,
hospital_medical_charts       AS   C

WHERE 
(C.diagnosis like 'COVID19')
and 
(E.equipment_name like 'Medical Ventilator')
and
(C.patient = E.patient)
);



-- Query (2)
-- This query will show us which types of teams of nurse
-- are under staffed (less than 5 nurse of the same specialty)
SELECT
N.specialty,
COUNT(N.nurse_id)    AS    numNurses

FROM hospital_nurses AS N

GROUP BY ( N.specialty )

HAVING ( numNurses < 5 ); 



-- Query (3)
-- This query will return patients that have                                                                                                                                                   -- shown some of the  symptoms of COVID19                                                                                                                                                                                                                    
SELECT DISTINCT
P.patient_id,
P.fName                    AS nameOfPatient

FROM
hospital_patients          AS P,
hospital_patient_symptoms  AS S

WHERE
(P.patient_id = S.patient)
AND
(S.symptom like 'Fever')
OR
(S.symptom like 'Dry Cough')
OR
(S.symptom like 'Chest pain');



-- Query (4)
-- this query will show the medical equipment that are being used by
-- by equipment name,
-- as well as the name of the nurse and patient that are using it.
SELECT
P.fName  AS   P_firstName,
P.lName  AS   P_lastName,
E.equipment_name,
N.fName  AS  N_firstName,
N.lName  AS  N_lastName

FROM
hospital_medical_equipment    AS   E
inner join 
hospital_patients             AS   P
on
(P.patient_id = E.patient)
inner join
hospital_nurses               AS   N
on
(N.nurse_id = E.nurse);



-- QUERY (5)
-- This will find nurses that are currently
-- using a medical equipment
SELECT DISTINCT 
N.nurse_id

FROM
hospital_nurses  AS  N

WHERE EXISTS
(

SELECT DISTINCT 
E.nurse 

FROM
hospital_medical_equipment  AS   E

WHERE E.nurse = N.nurse_id
);



-- Query (6)
-- this will give the id of all doctor that don't
-- have patient and 
-- patients that don't have doctor
SELECT
D.doctor_id
FROM
hospital_doctors   AS   D
WHERE
NOT EXISTS
(
SELECT
P.doctor
FROM hospital_patients   AS   P
WHERE P.doctor = D.doctor_id
)

UNION

SELECT
P.patient_id
FROM
hospital_patients   AS   P
WHERE
P.doctor IS NUll;



-- QUERY (7)
-- This will update all
-- update patient P82089
-- to have no medical equipment
-- listed under their name
UPDATE  hospital_medical_equipment
SET patient = NULL
WHERE 
patient  LIKE 'P82089';

--- END OF SCRIPT----

