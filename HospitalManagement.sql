CREATE DATABASE HospitalDB;
USE HospitalDB;

CREATE TABLE Patients (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Age INT,
    Gender ENUM('Male', 'Female', 'Other'),
    Phone VARCHAR(15),
    Address TEXT,
    BloodGroup VARCHAR(5),
    AdmissionDate DATE,
    DischargeDate DATE DEFAULT NULL
);

CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Specialty VARCHAR(50),
    Phone VARCHAR(15),
    Email VARCHAR(100) UNIQUE,
    Availability ENUM('Available', 'Not Available') DEFAULT 'Available'
);


CREATE TABLE MedicalRecords (
    RecordID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    Diagnosis TEXT,
    Treatment TEXT,
    Prescription TEXT,
    Date DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE Pharmacy (
    MedicineID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Stock INT DEFAULT 0,
    Price DECIMAL(10,2),
    ExpiryDate DATE
);



CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY AUTO_INCREMENT,
    RoomType ENUM('General', 'Private', 'ICU'),
    Availability ENUM('Available', 'Occupied') DEFAULT 'Available',
    ChargesPerDay DECIMAL(10,2)
);

INSERT INTO Patients (Name, Age, Gender, Phone, Address, BloodGroup, AdmissionDate, DischargeDate)  
VALUES  
('Rajesh Kumar', 45, 'Male', '9876543101', 'Bangalore, India', 'A+', '2024-02-02', NULL),
('Sneha Kapoor', 29, 'Female', '9823123456', 'Hyderabad, India', 'B-', '2024-02-07', NULL),
('Amit Verma', 50, 'Male', '9845678901', 'Chennai, India', 'O+', '2024-01-20', '2024-01-30'),
('Neha Desai', 35, 'Female', '9786543210', 'Pune, India', 'AB+', '2024-01-18', '2024-01-28'),
('Manoj Yadav', 55, 'Male', '9765432109', 'Kolkata, India', 'A-', '2024-02-05', NULL);


INSERT INTO Doctors (Name, Specialty, Phone, Email, Availability)  
VALUES  
('Dr. Anjali Sharma', 'Dermatologist', '9786543211', 'anjali@hospital.com', 'Available'),
('Dr. Vivek Agarwal', 'Orthopedic', '9765432198', 'vivek@hospital.com', 'Available'),
('Dr. Sunita Mehta', 'Pediatrician', '9745632187', 'sunita@hospital.com', 'Not Available'),
('Dr. Ramesh Iyer', 'General Physician', '9723456789', 'ramesh@hospital.com', 'Available'),
('Dr. Kavita Rao', 'Gynecologist', '9709876543', 'kavita@hospital.com', 'Available');


INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Status)  
VALUES  
(2, 3, '2024-02-10 11:00:00', 'Scheduled'),
(3, 5, '2024-02-12 15:00:00', 'Completed'),
(4, 1, '2024-02-15 09:30:00', 'Scheduled'),
(5, 4, '2024-02-18 14:00:00', 'Scheduled'),
(1, 2, '2024-02-20 16:30:00', 'Cancelled');

INSERT INTO MedicalRecords (PatientID, Diagnosis, Treatment, Prescription, Date)  
VALUES  
(1, 'Fever and Cold', 'Rest and hydration', 'Paracetamol 500mg', '2024-02-01'),
(2, 'Skin Rash', 'Allergy medication', 'Cetirizine 10mg', '2024-02-08'),
(3, 'Fractured Wrist', 'Sling and painkillers', 'Ibuprofen 400mg', '2024-01-22'),
(4, 'High Cholesterol', 'Dietary changes & medication', 'Atorvastatin 20mg', '2024-01-19'),
(5, 'Diabetes', 'Insulin therapy & diet control', 'Metformin 500mg', '2024-02-06');


INSERT INTO Pharmacy (Name, Stock, Price, ExpiryDate)  
VALUES  
('Ibuprofen', 150, 15.00, '2026-05-20'),
('Metformin', 200, 25.00, '2025-11-15'),
('Cough Syrup', 80, 30.00, '2026-01-10'),
('Antibiotic Cream', 120, 50.00, '2025-12-31'),
('Vitamin C Tablets', 300, 20.00, '2026-08-05');


INSERT INTO Staff (Name, Role, Salary, Contact)  
VALUES  
('Meera Joshi', 'Nurse', 40000.00, '9812345678'),
('Rahul Nair', 'Receptionist', 30000.00, '9823456781'),
('Anita Sharma', 'Lab Technician', 45000.00, '9834567892'),
('Sameer Khan', 'Administrator', 55000.00, '9845678903'),
('Pooja Deshmukh', 'Pharmacist', 38000.00, '9856789014');


INSERT INTO Billing (PatientID, TotalAmount, PaymentStatus, PaymentDate)  
VALUES  
(1, 7000.00, 'Paid', '2024-02-02'),
(2, 5000.00, 'Unpaid', NULL),
(3, 12000.00, 'Paid', '2024-01-25'),
(4, 9000.00, 'Unpaid', NULL),
(5, 15000.00, 'Paid', '2024-02-07');


INSERT INTO Rooms (RoomType, Availability, ChargesPerDay)  
VALUES  
('General', 'Available', 1000.00),
('Private', 'Occupied', 5000.00),
('ICU', 'Available', 10000.00),
('General', 'Occupied', 1200.00),
('Private', 'Available', 5500.00);

-- Find Patients Admitted for More Than 5 Days
SELECT Name, AdmissionDate, DATEDIFF(CURDATE(), AdmissionDate) AS DaysAdmitted  
FROM Patients  
WHERE DischargeDate IS NULL AND DATEDIFF(CURDATE(), AdmissionDate) > 5;

-- Find Total Revenue from Paid Bills
SELECT SUM(TotalAmount) AS TotalRevenue  
FROM Billing  
WHERE PaymentStatus = 'Paid';


-- Find Available ICU Rooms
SELECT * FROM Rooms WHERE RoomType = 'ICU' AND Availability = 'Available';

-- Get a List of Patients Under a Specific Doctor
SELECT Patients.Name, Doctors.Name AS Doctor, Appointments.AppointmentDate  
FROM Appointments  
JOIN Patients ON Appointments.PatientID = Patients.PatientID  
JOIN Doctors ON Appointments.DoctorID = Doctors.DoctorID  
WHERE Doctors.Name = 'Dr. Priya Verma';













