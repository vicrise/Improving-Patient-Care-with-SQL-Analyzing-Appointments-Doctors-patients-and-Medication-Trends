### PROJECT TITLE
### Improving-Patient-Care-with-SQL-Analyzing-Appointments-Doctors-patients-and-Medication-Trends

### PROJECT OVERVIEW
This dataset used for this project consists of four tables, namely the patients table (first name, last name, gender, phone number and email), 
Appointments table (appointment ID, patient ID, doctor ID),
Doctors table (Doctor ID, first name, last name, specialisation),
Medications table (medication ID, medication name, dosage).
I aim to uncover trends that can enhance healthcare decision-making.

### PROBLEM STATEMENT 
Data plays a crucial role in improving patient care, optimising hospital operations, and ensuring efficient resource allocation.  
Hospitals and clinics generate vast amounts of data daily, including patient demographics, appointment histories, doctor schedules, and medication prescriptions. 
By analysing this data, it will help me to understand patient demographics, identify appointment trends, evaluate doctor workload,
analyse medication prescription patterns to ensure adequate healthcare services are provided to patients,
help the hospital to cut costs, especially in medication and reduce the workload of doctors.

### OBJECTIVES
1.	To analyse patient demographics.
2.	To analyse appointment trends.
3.	To assess doctor performance in terms of patient load.
4.	 To examine medication prescription trends.

### DATASET OVERVIEW

The dataset contains 4 tables, which are:

1.	Appointments Table: Records patient appointment date and purpose.
2.	Patient Table: Contains patient demographics.
3.	Doctors Table: contains the doctor’s information and specialisation. 
4.	Medications Table: Tracks prescribed medications, name, prescription date and expiration date.

### DATA SOURCE 

Eyowhite.com

### METHODOLOGY

-	TOOL USED:
  
 Microsoft SQL Server 
-	DATA CLEANING PROCESS AND TRANSFORMATION:

The dataset was clean, but I checked for any inconsistencies, duplicates, and errors 

### SQL QUERIES AND INSIGHTS

1.	Patient Demographics Analysis
   
•	Total number of genders 

SELECT Gender,

COUNT(*) total_patient

FROM Medical.Patients

GROUP BY Gender; 

It helps to understand the total number of patients (Female =122, Male = 128)

•	Age of the patient according to the date of birth and appointment date

SELECT CONCAT(FirstName,' ', LastName) fullName, 

AppointmentDateTime,

DateOfBirth,

DATEDIFF(YEAR,DateOfBirth,AppointmentDateTime) Age

FROM Medical.Appointments AP

JOIN Medical.Patients PA

ON AP.PatientID = PA.PatientID

ORDER BY  Age;

It helps us to know the age of each patient by subtracting each patient's date of birth from the appointment date, and it ranges from 30 to 70 years

2. To analyze appointment trends.
   
•	Identify peak appointment days in each month of the year

SELECT  DATENAME(DD,AppointmentDateTime) Name_Of_Day,

DATENAME(MM,AppointmentDateTime) Name_Of_Month,

 DATEPART(YYYY,AppointmentDateTime) Year,
 
 COUNT(AppointmentID) Total_Patient
 
 FROM Medical.Appointments
 
 GROUP BY  DATENAME(DD,AppointmentDateTime), 
 
 DATEPART(YYYY,AppointmentDateTime), DATENAME(MM,AppointmentDateTime)


 ORDER BY  DATEPART(YYYY,AppointmentDateTime) ,
 
 DATENAME(MM,AppointmentDateTime),
 
 TOTAL_PATIENT DESC;
 
There are variations in the appointment days in each month of the year, for example,
On 2022 January 24, February 7, April 13 and 28, two patients have appointments, while on  May 12 and 15, three patients have appointments 
On 2023 April 12, June 12,18 and 27, two patients have an appointment, and on March 25, three patients have an appointment, while on some other days, we only have one patient  

•	Identify peak appointment months in 2022 & 2023, respectively.

 SELECT  DATENAME(MM,AppointmentDateTime) Name_Of_Month,
 
 DATEPART(YYYY,AppointmentDateTime) Year,
 
 COUNT(AppointmentID)  Total_Patient
 
 FROM Medical.Appointments
 
 GROUP BY  DATENAME(MM,AppointmentDateTime),
 
 DATEPART(YYYY,AppointmentDateTime)
 
 ORDER BY  DATEPART(YYYY,AppointmentDateTime) ,
 
 Total_Patient DESC;
 
In 2022, the peak months are July, October, September, May, June and January, with 15,14,14,12,10 and 10 patients respectively
In 2023, the peak months are November, March, May, September, June, July and October, with 16,15,14,14,12,11 and 11 patients respectively.

3.   Assess doctor performance in terms of patient load.
   
•	Doctor's details and the number of patients seen

 SELECT CONCAT(FirstName,' ',LastName) Doctor_Full_Name,
 
 Specialisation, COUNT(AppointmentID) Total_Patient_Seen
 
 FROM Medical.Doctors do
 
 JOIN Medical.Appointments ap
 
 ON do.DoctorID = ap.DoctorID
 
 GROUP BY CONCAT(FirstName,' ',LastName),
 
 Specialisation;
 

Each doctor attended to only one patient, which suggests that there is no workload on any doctor 

•	The purpose for which each patient visits a particular doctor, including age and gender 

  SELECT CONCAT(do.FirstName,' ',do.LastName) Doctor_Full_Name,
  
  CONCAT(pa.FirstName, ' ', pa.LastName) Patient_Full_Name,
  
 Specialisation,
 
Purpose, 

Gender

 FROM Medical.Doctors do
 
 JOIN Medical.Appointments ap
 
 on do.DoctorID = ap.DoctorID
 
 JOIN Medical.Patients pa

 on pa.PatientID = ap.PatientID
 
 ORDER Specialisation;
 

Each patients have the doctor who was assigned to them 

5.  Medication prescription trends
   
•	Most prescribed medication

SELECT MedicationName, COUNT(*) Total_Medications
FROM Medical.Medications

GROUP BY MedicationName

ORDER BY COUNT(*) desc;

EndoBalance, MaxilloHeal and VasulaFlow are the top medications that were prescribed to patients, with a total of  8 medications given to different patients,  
while Urosooth, LungEase, and Oncolix are the least prescribed medications

•	Doctors' prescribed medication for different purposes
SELECT MedicationName, 

CONCAT(firstname,' ',LastName) Doctor_Full_Name,

Specialisation,

Purpose,

Dosage

FROM Medical.Medications me

JOIN Medical.Doctors do

ON me.DoctorID = do.DoctorID

JOIN [Medical.Appointments] ap

ON ap.DoctorID =do.DoctorID

ORDER BY MedicationName;

Different doctors have their preferred medications, and a medication can be used to treat different diseases, like AlterClear is used for Eye checks, sleep issues and soon

### RECOMMENDATION 

- Both 2022 and 2023, we have peak patient appointments in May, June, July, September and October; therefore, for the subsequent year, the hospital should prepare for these months by making the necessary things like medications available 
- It was discovered that more than one specialist in a particular specialisation, for example Allergist/immunologist, we have 5 specialists. I will recommend laying off some doctors to save costs, and the hospital can retain the best specialists
- The hospital should stock up on medications that are prescribed the most by doctors in order to save costs, because some medications can expire if they are not prescribed by doctors.
- I will recommend that doctors should do more research about medications that are least prescribed, you never can tell, they may work more than the most prescribed medications

 ### LIMITATIONS
 
-  I wasn’t provided with the information on whether the patients honoured the appointment or not 
- The bill's table wasn’t available to determine the total amount each patient spent.
  
### CONCLUSION 
- Hospital management should provide complete data of their hospitals in order for data professionals to make the right analysis and recommendations that will help the hospital to cut costs and to make good decisions




