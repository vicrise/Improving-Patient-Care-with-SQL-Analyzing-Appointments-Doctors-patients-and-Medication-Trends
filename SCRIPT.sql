
-- 1. Patient Demographics Analysis
 -- a. total number of gender 
SELECT Gender, COUNT(*) total_patient
FROM [Medical.Patients]
GROUP BY Gender;

-- b. age of the patient according to the date of birth and appointment date
SELECT PatientID, 
AppointmentDateTime,
DateOfBirth ,
DATEDIFF(YEAR,DateOfBirth,AppointmentDateTime) Age
FROM [Medical.Appointments] AP
JOIN [Medical.Patients] PA
ON AP.PatientID = PA.PatientID
ORDER BY  Age;

--2.	To analyze appointment trends.
 -- a.	Identify peak appointment days in each month of the year 
 SELECT  DATENAME(DD,AppointmentDateTime) Name_Of_Day,  DATENAME(MM,AppointmentDateTime) Name_Of_Month,
 DATEPART(YYYY,AppointmentDateTime) Year,
 COUNT(AppointmentID) Total_Patient
 FROM [Medical.Appointments]
 GROUP BY  DATENAME(DD,AppointmentDateTime), 
 DATEPART(YYYY,AppointmentDateTime), DATENAME(MM,AppointmentDateTime)
 ORDER BY  DATEPART(YYYY,AppointmentDateTime) ,
 DATENAME(MM,AppointmentDateTime),
 TOTAL_PATIENT DESC;


 --a.	Identify peak appointment months in 2022 & 2023 respectively .
 SELECT  DATENAME(MM,AppointmentDateTime) NAME_OF_MONTH,
 DATEPART(YYYY,AppointmentDateTime) Year,
 COUNT(AppointmentID)  Total_Patient
 FROM [Medical.Appointments]
 GROUP BY  DATENAME(MM,AppointmentDateTime), 
 DATEPART(YYYY,AppointmentDateTime)
 ORDER BY  DATEPART(YYYY,AppointmentDateTime) ,
 Total_Patient DESC;



 --3.	Assess doctor performance in terms of patient load.

 --a. doctor's details and the number of patients seen
 SELECT 
 CONCAT(FirstName,' ',LastName) Doctor_Full_Name,
 Specialisation, COUNT(AppointmentID) Total_Patient_Seen
 FROM [Medical.Doctors] do
 JOIN [Medical.Appointments] ap
 ON DO.DoctorID = AP.DoctorID
 GROUP BY CONCAT(FirstName,' ',LastName),
 Specialisation;

 -- the purpose why each patient visit a particular doctor with the age and gender 
  SELECT CONCAT(do.FirstName,' ',do.LastName) Doctor_Full_Name,
 PatientID,
 Specialisation,Purpose,  Gender
 FROM [Medical.Doctors] do
 JOIN [Medical.Appointments]ap
 on do.DoctorID = ap.DoctorID
 JOIN [Medical.Patients] pa
 on pa.PatientID = ap.PatientID
 ORDER BY Specialisation;


--4. Medication prescription trends

--a. The most prescribed medication
SELECT MedicationName, COUNT(*) Total_Medications 
FROM [Medical.Medications] 
GROUP BY MedicationName
ORDER BY COUNT(*) desc;

--doctor's prescribed medication for different purposes
SELECT MedicationName, 
CONCAT(firstname,' ',LastName) Doctor_Full_Name,
Specialisation,
Purpose,
Dosage
FROM [Medical.Medications] me
JOIN [Medical.Doctors] do
ON me.DoctorID = do.DoctorID
JOIN [Medical.Appointments] ap
ON ap.DoctorID =do.DoctorID
ORDER BY MedicationName;


