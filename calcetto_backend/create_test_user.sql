-- Use existing email, update password
UPDATE user_info 
SET 
  "passwordHash" = ENCODE(DIGEST('password123' || 'salt', 'sha256'), 'hex'),
  "passwordSalt" = 'salt',
  "updatedAt" = NOW()
WHERE id = 1;

SELECT 'Done' as status, id, email FROM user_info WHERE id = 1;
