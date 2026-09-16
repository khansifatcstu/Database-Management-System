
-- Hospital Management System Database


CREATE DATABASE IF NOT EXISTS hospital_management;
USE hospital_management;


CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(10) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(200)
);



CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(20)
);



CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Scheduled',

    FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id)
        ON DELETE CASCADE,

    FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id)
        ON DELETE CASCADE
);


INSERT INTO patients (name, age, gender, phone, address)
VALUES
('Sifat Ahmed', 21, 'Male', '01711111111', 'Chandpur'),
('Nusrat Jahan', 25, 'Female', '01822222222', 'Dhaka'),
('Rahim Uddin', 45, 'Male', '01933333333', 'Chittagong'),
('Mim Akter', 30, 'Female', '01644444444', 'Cumilla'),
('Tanvir Hasan', 35, 'Male', '01555555555', 'Feni');

INSERT INTO doctors (name, specialization, phone)
VALUES
('Dr. Ahmed Karim', 'Cardiology', '01710000001'),
('Dr. Farzana Rahman', 'Neurology', '01810000002'),
('Dr. Mahmud Hasan', 'Dermatology', '01910000003'),
('Dr. Sadia Islam', 'Psychiatry', '01610000004');

INSERT INTO appointments
(patient_id, doctor_id, appointment_date, status)
VALUES
(1, 1, '2026-09-18', 'Scheduled'),
(2, 2, '2026-09-19', 'Scheduled'),
(3, 1, '2026-09-20', 'Completed'),
(4, 3, '2026-09-21', 'Scheduled'),
(5, 4, '2026-09-22', 'Scheduled');


-- Display all patients
SELECT * FROM patients;

-- Display all doctors
SELECT * FROM doctors;

-- Display all appointments
SELECT * FROM appointments;


SELECT
    appointments.appointment_id,
    patients.name AS patient_name,
    doctors.name AS doctor_name,
    doctors.specialization,
    appointments.appointment_date,
    appointments.status
FROM appointments
JOIN patients
    ON appointments.patient_id = patients.patient_id
JOIN doctors
    ON appointments.doctor_id = doctors.doctor_id;


INSERT INTO patients
(name, age, gender, phone, address)
VALUES
('Arif Hossain', 28, 'Male', '01766666666', 'Noakhali');


UPDATE patients
SET phone = '01799999999'
WHERE patient_id = 1;

-- Update appointment status
UPDATE appointments
SET status = 'Completed'
WHERE appointment_id = 1;


DELETE FROM patients
WHERE patient_id = 6;


DELIMITER //

CREATE TRIGGER before_appointment_insert
BEFORE INSERT ON appointments
FOR EACH ROW
BEGIN
    IF NEW.status IS NULL OR NEW.status = '' THEN
        SET NEW.status = 'Scheduled';
    END IF;
END //

DELIMITER ;


INSERT INTO appointments
(patient_id, doctor_id, appointment_date, status)
VALUES
(1, 2, '2026-09-25', '');

-- Check the inserted appointment
SELECT * FROM appointments;


-- Find patients older than 30
SELECT *
FROM patients
WHERE age > 30;

-- Find all scheduled appointments
SELECT *
FROM appointments
WHERE status = 'Scheduled';

-- Count total patients
SELECT COUNT(*) AS total_patients
FROM patients;

-- Count doctors by specialization
SELECT specialization, COUNT(*) AS total_doctors
FROM doctors
GROUP BY specialization;