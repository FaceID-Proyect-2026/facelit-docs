-- FACELIT-DB | DQL: consultas de lectura basadas en las tablas existentes.
-- Consultas sin datos ficticios.

-- Consulta de security.user_app
SELECT * FROM security.user_app LIMIT 100;

-- Consulta de security.credential
SELECT * FROM security.credential LIMIT 100;

-- Consulta de security.password_recovery
SELECT * FROM security.password_recovery LIMIT 100;

-- Consulta de security.user_session
SELECT * FROM security.user_session LIMIT 100;

-- Consulta de security.user_configuration
SELECT * FROM security.user_configuration LIMIT 100;

-- Consulta de roleandpermission.role
SELECT * FROM roleandpermission.role LIMIT 100;

-- Consulta de roleandpermission.permission
SELECT * FROM roleandpermission.permission LIMIT 100;

-- Consulta de roleandpermission.user_role
SELECT * FROM roleandpermission.user_role LIMIT 100;

-- Consulta de roleandpermission.role_permission
SELECT * FROM roleandpermission.role_permission LIMIT 100;

-- Consulta de academic.program
SELECT * FROM academic.program LIMIT 100;

-- Consulta de academic.instructor
SELECT * FROM academic.instructor LIMIT 100;

-- Consulta de academic.instructor_program
SELECT * FROM academic.instructor_program LIMIT 100;

-- Consulta de academic.change_history
SELECT * FROM academic.change_history LIMIT 100;

-- Consulta de academic.chip
SELECT * FROM academic.chip LIMIT 100;

-- Consulta de academic.instructor_chip
SELECT * FROM academic.instructor_chip LIMIT 100;

-- Consulta de academic.apprentice
SELECT * FROM academic.apprentice LIMIT 100;

-- Consulta de academic.apprentice_chip
SELECT * FROM academic.apprentice_chip LIMIT 100;

-- Consulta de academic.csv_pending_transfer
SELECT * FROM academic.csv_pending_transfer LIMIT 100;

-- Consulta de environment.environment
SELECT * FROM environment.environment LIMIT 100;

-- Consulta de environment.chip_environment
SELECT * FROM environment.chip_environment LIMIT 100;

-- Consulta de environment.record_environment
SELECT * FROM environment.record_environment LIMIT 100;

-- Consulta de notification.notification
SELECT * FROM notification.notification LIMIT 100;

-- Consulta de notification.email_log
SELECT * FROM notification.email_log LIMIT 100;

-- Consulta de legal.terms_acceptance
SELECT * FROM legal.terms_acceptance LIMIT 100;

-- Consulta de facialrecognition.device
SELECT * FROM facialrecognition.device LIMIT 100;

-- Consulta de facialrecognition.user_face
SELECT * FROM facialrecognition.user_face LIMIT 100;

-- Consulta de facialrecognition.facial_event
SELECT * FROM facialrecognition.facial_event LIMIT 100;

-- Consulta de facialrecognition.biometric_log
SELECT * FROM facialrecognition.biometric_log LIMIT 100;

-- Consulta de facialrecognition.face_reset_request
SELECT * FROM facialrecognition.face_reset_request LIMIT 100;
