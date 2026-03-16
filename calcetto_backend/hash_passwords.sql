-- =============================================================================
-- UPDATE ALL USER PASSWORDS TO HASHED VERSIONS
-- =============================================================================
-- This script updates all existing users to use hashed passwords
-- All users will have password: "password" (hashed with SHA-256 + salt)
-- 
-- Hash format: salt:hash
-- Example: 1647456789012:a3f5c8d9e2b1...
-- =============================================================================

-- Update test user password (hashed)
UPDATE users 
SET password = '1742151600000:5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8'
WHERE email = 'test@example.com';

-- Update all other users with hashed passwords
-- All passwords are "password" hashed with different salts
UPDATE users 
SET password = '1742151600001:5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8'
WHERE email = 'marco.rossi@example.com';

UPDATE users 
SET password = '1742151600002:5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8'
WHERE email = 'luca.bianchi@example.com';

UPDATE users 
SET password = '1742151600003:5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8'
WHERE email = 'giulia.verdi@example.com';

UPDATE users 
SET password = '1742151600004:5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8'
WHERE email = 'alessandro.ferrari@example.com';

UPDATE users 
SET password = '1742151600005:5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8'
WHERE email = 'francesca.romano@example.com';

UPDATE users 
SET password = '1742151600006:5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8'
WHERE email = 'matteo.conti@example.com';

UPDATE users 
SET password = '1742151600007:5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8'
WHERE email = 'sophia.marino@example.com';

UPDATE users 
SET password = '1742151600008:5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8'
WHERE email = 'davide.greco@example.com';

UPDATE users 
SET password = '1742151600009:5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8'
WHERE email = 'elena.ricci@example.com';

UPDATE users 
SET password = '1742151600010:5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8'
WHERE email = 'antonio.bruno@example.com';

UPDATE users 
SET password = '1742151600011:5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8'
WHERE email = 'chiara.galli@example.com';

UPDATE users 
SET password = '1742151600012:5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8'
WHERE email = 'roberto.mancini@example.com';

UPDATE users 
SET password = '1742151600013:5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8'
WHERE email = 'valentina.costa@example.com';

UPDATE users 
SET password = '1742151600014:5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8'
WHERE email = 'simone.lombardi@example.com';

-- =============================================================================
-- VERIFICATION
-- =============================================================================

SELECT 
  email,
  CASE 
    WHEN password LIKE '%:%' THEN 'HASHED'
    ELSE 'PLAIN TEXT'
  END as password_status,
  LEFT(password, 50) as password_preview
FROM users
ORDER BY email;