-- =============================================================================
-- FIX PASSWORD HASHES - Proper SHA-256 with salt
-- =============================================================================
-- The stored passwords were created incorrectly.
-- This script updates them to use the correct format that matches
-- the auth_endpoint.dart verification logic.
-- 
-- All passwords will be: "password"
-- Format: salt:SHA256(password + salt)
-- =============================================================================

-- For test@example.com with salt 1742151600000
-- SHA256("password1742151600000") = 
UPDATE users 
SET password = '1742151600000:' || encode(digest('password' || '1742151600000', 'sha256'), 'hex')
WHERE email = 'test@example.com';

-- Update all other users with properly salted passwords
-- Using different salts for each user
UPDATE users SET password = '1742151600001:' || encode(digest('password' || '1742151600001', 'sha256'), 'hex') WHERE email = 'marco.rossi@example.com';
UPDATE users SET password = '1742151600002:' || encode(digest('password' || '1742151600002', 'sha256'), 'hex') WHERE email = 'luca.bianchi@example.com';
UPDATE users SET password = '1742151600003:' || encode(digest('password' || '1742151600003', 'sha256'), 'hex') WHERE email = 'giulia.verdi@example.com';
UPDATE users SET password = '1742151600004:' || encode(digest('password' || '1742151600004', 'sha256'), 'hex') WHERE email = 'alessandro.ferrari@example.com';
UPDATE users SET password = '1742151600005:' || encode(digest('password' || '1742151600005', 'sha256'), 'hex') WHERE email = 'francesca.romano@example.com';
UPDATE users SET password = '1742151600006:' || encode(digest('password' || '1742151600006', 'sha256'), 'hex') WHERE email = 'matteo.conti@example.com';
UPDATE users SET password = '1742151600007:' || encode(digest('password' || '1742151600007', 'sha256'), 'hex') WHERE email = 'sophia.marino@example.com';
UPDATE users SET password = '1742151600008:' || encode(digest('password' || '1742151600008', 'sha256'), 'hex') WHERE email = 'davide.greco@example.com';
UPDATE users SET password = '1742151600009:' || encode(digest('password' || '1742151600009', 'sha256'), 'hex') WHERE email = 'elena.ricci@example.com';
UPDATE users SET password = '1742151600010:' || encode(digest('password' || '1742151600010', 'sha256'), 'hex') WHERE email = 'antonio.bruno@example.com';
UPDATE users SET password = '1742151600011:' || encode(digest('password' || '1742151600011', 'sha256'), 'hex') WHERE email = 'chiara.galli@example.com';
UPDATE users SET password = '1742151600012:' || encode(digest('password' || '1742151600012', 'sha256'), 'hex') WHERE email = 'roberto.mancini@example.com';
UPDATE users SET password = '1742151600013:' || encode(digest('password' || '1742151600013', 'sha256'), 'hex') WHERE email = 'valentina.costa@example.com';
UPDATE users SET password = '1742151600014:' || encode(digest('password' || '1742151600014', 'sha256'), 'hex') WHERE email = 'simone.lombardi@example.com';

-- Verify the update
SELECT email, LEFT(password, 70) as password_preview FROM users WHERE email = 'test@example.com';