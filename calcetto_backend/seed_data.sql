-- Seed Data Script for Calcetto Database
-- Run with: docker exec -i calcetto-postgres psql -U calcetto -d calcetto < seed_data.sql

-- ============================================================
-- CREATE 4 ADDITIONAL USERS
-- ============================================================
INSERT INTO user_info (email, "firstName", "lastName", nickname, "passwordHash", "passwordSalt", "createdAt", "updatedAt")
VALUES 
  ('marco@example.com', 'Marco', 'Rossi', 'Il Capitano', 'hash1', 'salt1', NOW(), NOW()),
  ('luca@example.com', 'Luca', 'Bianchi', 'Super Luca', 'hash2', 'salt2', NOW(), NOW()),
  ('giulia@example.com', 'Giulia', 'Verdi', 'Gol', 'hash3', 'salt3', NOW(), NOW()),
  ('alessandro@example.com', 'Alessandro', 'Ferrari', 'Ale', 'hash4', 'salt4', NOW(), NOW());

-- ============================================================
-- CREATE 4 NEW CLUBS (test user: p7yur7wrm0ct8w96rb0s6xiv)
-- ============================================================
INSERT INTO clubs (id, name, description, created_by, created_at, updated_at)
VALUES 
  ('club_dragons', 'FC Dragons', 'Dragons pronti a segnare', 'p7yur7wrm0ct8w96rb0s6xiv', NOW(), NOW()),
  ('club_atletico', 'Real Atletico', 'Atletico sempre in corsa', 'p7yur7wrm0ct8w96rb0s6xiv', NOW(), NOW()),
  ('club_sporting', 'Sporting Club', 'Sport e divertimento', 'p7yur7wrm0ct8w96rb0s6xiv', NOW(), NOW()),
  ('club_aurora', 'Aurora FC', 'Aurora vince sempre', 'p7yur7wrm0ct8w96rb0s6xiv', NOW(), NOW());

-- ============================================================
-- CREATE CLUB MEMBERSHIPS
-- Test user roles:
-- - Already OWNER of existing club
-- - MANAGER of FC Dragons  
-- - MEMBER of Real Atletico
-- ============================================================
-- Marco as OWNER of Dragons
INSERT INTO club_members (club_id, user_id, privileges, "primaryRole", "jerseyNumber", joined_at)
SELECT 
  c.id, u.id, 'OWNER', 'CEN', 10, NOW()
FROM clubs c, user_info u
WHERE c.name = 'FC Dragons' AND u.email = 'marco@example.com';

-- Test user as MANAGER in Dragons
INSERT INTO club_members (club_id, user_id, privileges, "primaryRole", "jerseyNumber", joined_at)
VALUES
  ('club_dragons', 'p7yur7wrm0ct8w96rb0s6xiv', 'MANAGER', 'ATT', 9, NOW());

-- Test user as MEMBER in Real Atletico  
INSERT INTO club_members (club_id, user_id, privileges, "primaryRole", "jerseyNumber", joined_at)
VALUES
  ('club_atletico', 'p7yur7wrm0ct8w96rb0s6xiv', 'MEMBER', 'DIF', 4, NOW());

-- ============================================================
-- CREATE MATCHES
-- ============================================================
INSERT INTO matches (id, club_id, scheduled_at, location, mode, status, home_score, away_score, created_by, created_at, updated_at)
VALUES
  ('match_001', 'club_dragons', '2026-03-15 20:00'::timestamp, 'Campo Centrale', 'FIVE_V_FIVE', 'COMPLETED', 3, 1, 'p7yur7wrm0ct8w96rb0s6xiv', NOW(), NOW()),
  ('match_002', 'club_dragons', '2026-03-20 21:00'::timestamp, 'Campo 2', 'FIVE_V_FIVE', 'SCHEDULED', 0, 0, 'p7yur7wrm0ct8w96rb0s6xiv', NOW(), NOW()),
  ('match_003', 'club_atletico', '2026-03-12 19:30'::timestamp, 'Palestra', 'FIVE_V_FIVE', 'COMPLETED', 2, 2, 'p7yur7wrm0ct8w96rb0s6xiv', NOW(), NOW()),
  ('match_004', 'club_sporting', NOW()::timestamp, 'Campo 3', 'FIVE_V_FIVE', 'IN_PROGRESS', 1, 0, 'p7yur7wrm0ct8w96rb0s6xiv', NOW(), NOW()),
  ('match_005', 'club_aurora', '2026-03-25 20:30'::timestamp, 'Stadium', 'FIVE_V_FIVE', 'SCHEDULED', 0, 0, 'p7yur7wrm0ct8w96rb0s6xiv', NOW(), NOW());

-- ============================================================
-- CREATE FORMATIONS FOR MATCH 1
-- ============================================================
INSERT INTO formations (id, match_id, is_home, formation_name, created_at, updated_at)
VALUES 
  ('form_001', 'match_001', true, '3-2-1', NOW(), NOW()),
  ('form_002', 'match_001', false, '2-3-1', NOW(), NOW());

-- ============================================================
-- VERIFY RESULTS
-- ============================================================
SELECT c.name AS club, cm.privileges AS role, cm."primaryRole" AS position
FROM club_members cm
JOIN clubs c ON cm.club_id = c.id
WHERE cm.user_id = 'p7yur7wrm0ct8w96rb0s6xiv'
ORDER BY c.name;
