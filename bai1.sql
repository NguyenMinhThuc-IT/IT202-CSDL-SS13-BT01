CREATE DATABASE bai1_db;

USE bai1_db;

CREATE TABLE Appointments(
	appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_date DATETIME
);

INSERT INTO Appointments(appointment_id, appointment_date)
VALUES
(104, '2026-07-20 09:00:00');

DELIMITER \\
CREATE TRIGGER PreventPastAppointments
BEFORE UPDATE ON Appointments
FOR EACH ROW
BEGIN

	IF OLD.appointment_date < NOW() THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi: Không thể đặt lịch khám vào thời điểm trong quá khứ';
	END IF;
    
END \\
DELIMITER ;

UPDATE Appointments
SET appointment_date = '2025-01-10 08:00:00'
WHERE appointment_id = 104;

DROP TRIGGER IF EXISTS PreventPastAppointments;

DELIMITER \\
CREATE TRIGGER PreventPastAppointments
BEFORE UPDATE ON Appointments
FOR EACH ROW
BEGIN

	IF NEW.appointment_date < NOW() THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi: Không thể đặt lịch khám vào thời điểm trong quá khứ';
	END IF;
    
END \\
DELIMITER ;