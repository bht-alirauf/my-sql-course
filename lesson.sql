-- This query brings list of patients in Kingston

/* Instructions:
   1. Uncomment the AND conditions one by one to filter the results further.
   2. Adjust the date range, tariff, or ward as needed for your specific requirements.
*/
SELECT 
    PatientId, 
    AdmittedDate, 
    DischargeDate,
    DATEDIFF(DAY, AdmittedDate, DischargeDate) AS LengthOfStay,
    DATEADD(WEEK, -2, AdmittedDate) as ReminderDate, -- 2 weeks before admitteddate
    DATEADD(MONTH, 3, DischargeDate) as AppointmentDate, -- 3 months after dischargedate
    Hospital,
    Ward, 
    Tariff
FROM 
    PatientStay
WHERE
    Hospital IN ('Kingston', 'PRUH')
/*ORDER BY
    Hospital,
    Ward,
    Tariff DESC*/
ORDER BY
    PatientId DESC

/*AND
    Ward LIKE '%Surgery%'
AND 
    AdmittedDate BETWEEN '2024-02-27' AND '2024-03-02'
AND
    Tariff >= 6
AND
    Ward = 'Dermatology'*/

SELECT
    Hospital
    ,Ward
    ,COUNT(*) AS [Number Of Pts] 
    ,SUM(Tariff) AS [Total Tariff]
FROM
    PatientStay -- [If you want the name of your column with spaces, you need to use SQUARE BRACKETS]
GROUP BY 
    Hospital
    , Ward

SELECT -- List of patients admitted to teaching hospitals
    PS.PatientId -- PS is the alias for PatientStay as this is Best Practice
    , PS.AdmittedDate
    , H.Hospital
    , H.HospitalType
    , H.HospitalSize
FROM -- Main table containing patient stay information
    PatientStay PS -- PS is the alias for PatientStay
JOIN -- To join two tables together 
    DimHospital H -- H is the alias for DimHospital
ON -- Specify the condition on which to join the tables
    PS.Hospital = H.Hospital
WHERE -- Filtering condition
    H.HospitalType = 'Teaching'


SELECT
    ps.PatientId
    ,ps.AdmittedDate
    ,ps.Hospital AS [PS Hospital]
    ,h.Hospital AS [H Hospital]
    ,h.HospitalType
    ,h.HospitalSize
FROM
    PatientStay ps 
FULL OUTER JOIN
    DimHospitalBad h 
ON 
    ps.Hospital = h.Hospital