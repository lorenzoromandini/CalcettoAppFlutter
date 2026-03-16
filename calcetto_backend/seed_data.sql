-- =============================================================================
-- COMPREHENSIVE SEED DATA FOR CALCETTO APP
-- =============================================================================
-- This script creates:
--   - 15 users (including test@example.com)
--   - 8 clubs
--   - Multiple memberships per club
--   - Test user as: OWNER of 1 club, MANAGER of 1 club, MEMBER of 1 club
--   - Multiple matches per club
-- =============================================================================

-- Clear existing data (optional - comment out if you want to keep data)
-- TRUNCATE TABLE goals, match_participants, player_ratings, matches, club_invites, club_members, clubs, users CASCADE;

-- =============================================================================
-- CREATE USERS
-- =============================================================================

DO $$
DECLARE
  test_user_id UUID;
BEGIN
  -- Get or create test user
  SELECT id INTO test_user_id FROM users WHERE email = 'test@example.com';
  
  IF test_user_id IS NULL THEN
    INSERT INTO users (id, email, "firstName", "lastName", nickname, "imageUrl", password, "createdAt", "updatedAt")
    VALUES (gen_random_uuid_v7(), 'test@example.com', 'Test', 'User', 'Tester', NULL, 'password123', NOW(), NOW())
    RETURNING id INTO test_user_id;
  END IF;

  -- Create additional users (14 more users)
  INSERT INTO users (id, email, "firstName", "lastName", nickname, "imageUrl", password, "createdAt", "updatedAt") VALUES
    (gen_random_uuid_v7(), 'marco.rossi@example.com', 'Marco', 'Rossi', 'Il Capitano', NULL, 'hash1', NOW(), NOW()),
    (gen_random_uuid_v7(), 'luca.bianchi@example.com', 'Luca', 'Bianchi', 'Super Luca', NULL, 'hash2', NOW(), NOW()),
    (gen_random_uuid_v7(), 'giulia.verdi@example.com', 'Giulia', 'Verdi', 'Gol', NULL, 'hash3', NOW(), NOW()),
    (gen_random_uuid_v7(), 'alessandro.ferrari@example.com', 'Alessandro', 'Ferrari', 'Ale', NULL, 'hash4', NOW(), NOW()),
    (gen_random_uuid_v7(), 'francesca.romano@example.com', 'Francesca', 'Romano', 'Francy', NULL, 'hash5', NOW(), NOW()),
    (gen_random_uuid_v7(), 'matteo.conti@example.com', 'Matteo', 'Conti', 'Matte', NULL, 'hash6', NOW(), NOW()),
    (gen_random_uuid_v7(), 'sophia.marino@example.com', 'Sophia', 'Marino', 'Soph', NULL, 'hash7', NOW(), NOW()),
    (gen_random_uuid_v7(), 'davide.greco@example.com', 'Davide', 'Greco', 'Dado', NULL, 'hash8', NOW(), NOW()),
    (gen_random_uuid_v7(), 'elena.ricci@example.com', 'Elena', 'Ricci', 'Ele', NULL, 'hash9', NOW(), NOW()),
    (gen_random_uuid_v7(), 'antonio.bruno@example.com', 'Antonio', 'Bruno', 'Tony', NULL, 'hash10', NOW(), NOW()),
    (gen_random_uuid_v7(), 'chiara.galli@example.com', 'Chiara', 'Galli', 'Chia', NULL, 'hash11', NOW(), NOW()),
    (gen_random_uuid_v7(), 'roberto.mancini@example.com', 'Roberto', 'Mancini', 'Roby', NULL, 'hash12', NOW(), NOW()),
    (gen_random_uuid_v7(), 'valentina.costa@example.com', 'Valentina', 'Costa', 'Vale', NULL, 'hash13', NOW(), NOW()),
    (gen_random_uuid_v7(), 'simone.lombardi@example.com', 'Simone', 'Lombardi', 'Simo', NULL, 'hash14', NOW(), NOW())
  ON CONFLICT (email) DO NOTHING;

  -- =============================================================================
  -- CREATE CLUBS
  -- =============================================================================
  
  -- Club 1: FC Dragons (test user will be OWNER)
  INSERT INTO clubs (id, name, description, "imageUrl", "createdBy", "createdAt", "updatedAt")
  SELECT gen_random_uuid_v7(), 'FC Dragons', 'Dragons pronti a segnare! Squadra storica del calcetto locale.', NULL, test_user_id, NOW(), NOW()
  WHERE NOT EXISTS (SELECT 1 FROM clubs WHERE name = 'FC Dragons');

  -- Club 2: Real Atletico (test user will be MANAGER)
  INSERT INTO clubs (id, name, description, "imageUrl", "createdBy", "createdAt", "updatedAt")
  SELECT gen_random_uuid_v7(), 'Real Atletico', 'Atletico sempre in corsa. Competizione e divertimento.', NULL, 
    (SELECT id FROM users WHERE email = 'marco.rossi@example.com' LIMIT 1), NOW(), NOW()
  WHERE NOT EXISTS (SELECT 1 FROM clubs WHERE name = 'Real Atletico');

  -- Club 3: Sporting Club (test user will be MEMBER)
  INSERT INTO clubs (id, name, description, "imageUrl", "createdBy", "createdAt", "updatedAt")
  SELECT gen_random_uuid_v7(), 'Sporting Club', 'Sport e divertimento per tutti. Amichevole e inclusivo.', NULL,
    (SELECT id FROM users WHERE email = 'luca.bianchi@example.com' LIMIT 1), NOW(), NOW()
  WHERE NOT EXISTS (SELECT 1 FROM clubs WHERE name = 'Sporting Club');

  -- Club 4: Aurora FC
  INSERT INTO clubs (id, name, description, "imageUrl", "createdBy", "createdAt", "updatedAt")
  SELECT gen_random_uuid_v7(), 'Aurora FC', 'Aurora vince sempre! Squadra giovane e dinamica.', NULL,
    (SELECT id FROM users WHERE email = 'giulia.verdi@example.com' LIMIT 1), NOW(), NOW()
  WHERE NOT EXISTS (SELECT 1 FROM clubs WHERE name = 'Aurora FC');

  -- Club 5: Inter Milano
  INSERT INTO clubs (id, name, description, "imageUrl", "createdBy", "createdAt", "updatedAt")
  SELECT gen_random_uuid_v7(), 'Inter Milano', 'Nerazzurri del calcetto. Passione e tradizione.', NULL,
    (SELECT id FROM users WHERE email = 'alessandro.ferrari@example.com' LIMIT 1), NOW(), NOW()
  WHERE NOT EXISTS (SELECT 1 FROM clubs WHERE name = 'Inter Milano');

  -- Club 6: Juventus Club
  INSERT INTO clubs (id, name, description, "imageUrl", "createdBy", "createdAt", "updatedAt")
  SELECT gen_random_uuid_v7(), 'Juventus Club', 'Fino alla fine! Determinazione e grinta.', NULL,
    (SELECT id FROM users WHERE email = 'francesca.romano@example.com' LIMIT 1), NOW(), NOW()
  WHERE NOT EXISTS (SELECT 1 FROM clubs WHERE name = 'Juventus Club');

  -- Club 7: Milan United
  INSERT INTO clubs (id, name, description, "imageUrl", "createdBy", "createdAt", "updatedAt")
  SELECT gen_random_uuid_v7(), 'Milan United', 'Rossoneri in campo. Stile e tecnica.', NULL,
    (SELECT id FROM users WHERE email = 'matteo.conti@example.com' LIMIT 1), NOW(), NOW()
  WHERE NOT EXISTS (SELECT 1 FROM clubs WHERE name = 'Milan United');

  -- Club 8: Roma Calcio
  INSERT INTO clubs (id, name, description, "imageUrl", "createdBy", "createdAt", "updatedAt")
  SELECT gen_random_uuid_v7(), 'Roma Calcio', 'Giallorossi per sempre. Cuore e passione.', NULL,
    (SELECT id FROM users WHERE email = 'sophia.marino@example.com' LIMIT 1), NOW(), NOW()
  WHERE NOT EXISTS (SELECT 1 FROM clubs WHERE name = 'Roma Calcio');

  -- =============================================================================
  -- CREATE CLUB MEMBERSHIPS
  -- =============================================================================
  -- Privilege: 0=OWNER, 1=MANAGER, 2=MEMBER
  -- Position: 0=GK, 1=DEF, 2=MID, 3=ST

  DECLARE
    dragons_id UUID;
    atletico_id UUID;
    sporting_id UUID;
    aurora_id UUID;
    inter_id UUID;
    juventus_id UUID;
    milan_id UUID;
    roma_id UUID;
    marco_id UUID;
    luca_id UUID;
    giulia_id UUID;
    ale_id UUID;
    fran_id UUID;
    matteo_id UUID;
    sophia_id UUID;
    davide_id UUID;
    elena_id UUID;
    antonio_id UUID;
    chiara_id UUID;
    roberto_id UUID;
    valentina_id UUID;
    simone_id UUID;
  BEGIN
    -- Get club IDs
    SELECT id INTO dragons_id FROM clubs WHERE name = 'FC Dragons';
    SELECT id INTO atletico_id FROM clubs WHERE name = 'Real Atletico';
    SELECT id INTO sporting_id FROM clubs WHERE name = 'Sporting Club';
    SELECT id INTO aurora_id FROM clubs WHERE name = 'Aurora FC';
    SELECT id INTO inter_id FROM clubs WHERE name = 'Inter Milano';
    SELECT id INTO juventus_id FROM clubs WHERE name = 'Juventus Club';
    SELECT id INTO milan_id FROM clubs WHERE name = 'Milan United';
    SELECT id INTO roma_id FROM clubs WHERE name = 'Roma Calcio';

    -- Get user IDs
    SELECT id INTO marco_id FROM users WHERE email = 'marco.rossi@example.com';
    SELECT id INTO luca_id FROM users WHERE email = 'luca.bianchi@example.com';
    SELECT id INTO giulia_id FROM users WHERE email = 'giulia.verdi@example.com';
    SELECT id INTO ale_id FROM users WHERE email = 'alessandro.ferrari@example.com';
    SELECT id INTO fran_id FROM users WHERE email = 'francesca.romano@example.com';
    SELECT id INTO matteo_id FROM users WHERE email = 'matteo.conti@example.com';
    SELECT id INTO sophia_id FROM users WHERE email = 'sophia.marino@example.com';
    SELECT id INTO davide_id FROM users WHERE email = 'davide.greco@example.com';
    SELECT id INTO elena_id FROM users WHERE email = 'elena.ricci@example.com';
    SELECT id INTO antonio_id FROM users WHERE email = 'antonio.bruno@example.com';
    SELECT id INTO chiara_id FROM users WHERE email = 'chiara.galli@example.com';
    SELECT id INTO roberto_id FROM users WHERE email = 'roberto.mancini@example.com';
    SELECT id INTO valentina_id FROM users WHERE email = 'valentina.costa@example.com';
    SELECT id INTO simone_id FROM users WHERE email = 'simone.lombardi@example.com';

    -- ========================================
    -- FC DRAGONS (test user = OWNER)
    -- ========================================
    IF test_user_id IS NOT NULL AND dragons_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), dragons_id, test_user_id, 10, 'TU', 'IT', 2, '[3]'::jsonb, 0, NOW())
      ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;

    -- Add 7 more members to FC Dragons
    IF marco_id IS NOT NULL AND dragons_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), dragons_id, marco_id, 1, 'MR', 'IT', 0, '[]'::jsonb, 1, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF luca_id IS NOT NULL AND dragons_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), dragons_id, luca_id, 4, 'LB', 'IT', 1, '[2]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF giulia_id IS NOT NULL AND dragons_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), dragons_id, giulia_id, 9, 'GV', 'IT', 3, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF davide_id IS NOT NULL AND dragons_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), dragons_id, davide_id, 6, 'DG', 'IT', 2, '[1]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF elena_id IS NOT NULL AND dragons_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), dragons_id, elena_id, 8, 'ER', 'IT', 2, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF antonio_id IS NOT NULL AND dragons_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), dragons_id, antonio_id, 3, 'AB', 'IT', 1, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF chiara_id IS NOT NULL AND dragons_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), dragons_id, chiara_id, 11, 'CG', 'IT', 3, '[2]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;

    -- ========================================
    -- REAL ATLETICO (test user = MANAGER)
    -- ========================================
    IF test_user_id IS NOT NULL AND atletico_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), atletico_id, test_user_id, 7, 'TU', 'IT', 2, '[1,3]'::jsonb, 1, NOW())
      ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;

    -- Add more members to Real Atletico
    IF marco_id IS NOT NULL AND atletico_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), atletico_id, marco_id, 1, 'MR', 'IT', 0, '[]'::jsonb, 0, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF luca_id IS NOT NULL AND atletico_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), atletico_id, luca_id, 5, 'LB', 'IT', 2, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF giulia_id IS NOT NULL AND atletico_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), atletico_id, giulia_id, 10, 'GV', 'IT', 3, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF ale_id IS NOT NULL AND atletico_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), atletico_id, ale_id, 8, 'AF', 'IT', 1, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF fran_id IS NOT NULL AND atletico_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), atletico_id, fran_id, 6, 'FR', 'IT', 2, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;

    -- ========================================
    -- SPORTING CLUB (test user = MEMBER)
    -- ========================================
    IF test_user_id IS NOT NULL AND sporting_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), sporting_id, test_user_id, 15, 'TU', 'IT', 1, '[]'::jsonb, 2, NOW())
      ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;

    -- Add more members to Sporting Club
    IF luca_id IS NOT NULL AND sporting_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), sporting_id, luca_id, 1, 'LB', 'IT', 0, '[]'::jsonb, 0, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF matteo_id IS NOT NULL AND sporting_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), sporting_id, matteo_id, 4, 'MC', 'IT', 1, '[]'::jsonb, 1, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF sophia_id IS NOT NULL AND sporting_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), sporting_id, sophia_id, 9, 'SM', 'IT', 3, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF roberto_id IS NOT NULL AND sporting_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), sporting_id, roberto_id, 7, 'RM', 'IT', 2, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF valentina_id IS NOT NULL AND sporting_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), sporting_id, valentina_id, 11, 'VC', 'IT', 2, '[3]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF simone_id IS NOT NULL AND sporting_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), sporting_id, simone_id, 3, 'SL', 'IT', 1, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;

    -- ========================================
    -- AURORA FC (test user NOT a member)
    -- ========================================
    IF giulia_id IS NOT NULL AND aurora_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), aurora_id, giulia_id, 10, 'GV', 'IT', 3, '[]'::jsonb, 0, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF ale_id IS NOT NULL AND aurora_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), aurora_id, ale_id, 1, 'AF', 'IT', 0, '[]'::jsonb, 1, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF fran_id IS NOT NULL AND aurora_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), aurora_id, fran_id, 8, 'FR', 'IT', 2, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF matteo_id IS NOT NULL AND aurora_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), aurora_id, matteo_id, 5, 'MC', 'IT', 1, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF sophia_id IS NOT NULL AND aurora_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), aurora_id, sophia_id, 9, 'SM', 'IT', 2, '[3]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;

    -- ========================================
    -- INTER MILANO
    -- ========================================
    IF ale_id IS NOT NULL AND inter_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), inter_id, ale_id, 4, 'AF', 'IT', 2, '[]'::jsonb, 0, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF fran_id IS NOT NULL AND inter_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), inter_id, fran_id, 1, 'FR', 'IT', 0, '[]'::jsonb, 1, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF davide_id IS NOT NULL AND inter_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), inter_id, davide_id, 10, 'DG', 'IT', 3, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF elena_id IS NOT NULL AND inter_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), inter_id, elena_id, 6, 'ER', 'IT', 1, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF antonio_id IS NOT NULL AND inter_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), inter_id, antonio_id, 8, 'AB', 'IT', 2, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;

    -- ========================================
    -- JUVENTUS CLUB
    -- ========================================
    IF fran_id IS NOT NULL AND juventus_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), juventus_id, fran_id, 10, 'FR', 'IT', 3, '[]'::jsonb, 0, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF matteo_id IS NOT NULL AND juventus_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), juventus_id, matteo_id, 1, 'MC', 'IT', 0, '[]'::jsonb, 1, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF sophia_id IS NOT NULL AND juventus_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), juventus_id, sophia_id, 4, 'SM', 'IT', 1, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF chiara_id IS NOT NULL AND juventus_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), juventus_id, chiara_id, 8, 'CG', 'IT', 2, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF roberto_id IS NOT NULL AND juventus_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), juventus_id, roberto_id, 6, 'RM', 'IT', 2, '[3]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;

    -- ========================================
    -- MILAN UNITED
    -- ========================================
    IF matteo_id IS NOT NULL AND milan_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), milan_id, matteo_id, 9, 'MC', 'IT', 2, '[]'::jsonb, 0, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF sophia_id IS NOT NULL AND milan_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), milan_id, sophia_id, 1, 'SM', 'IT', 0, '[]'::jsonb, 1, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF davide_id IS NOT NULL AND milan_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), milan_id, davide_id, 7, 'DG', 'IT', 1, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF elena_id IS NOT NULL AND milan_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), milan_id, elena_id, 10, 'ER', 'IT', 3, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF antonio_id IS NOT NULL AND milan_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), milan_id, antonio_id, 4, 'AB', 'IT', 2, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;

    -- ========================================
    -- ROMA CALCIO
    -- ========================================
    IF sophia_id IS NOT NULL AND roma_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), roma_id, sophia_id, 10, 'SM', 'IT', 3, '[]'::jsonb, 0, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF davide_id IS NOT NULL AND roma_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), roma_id, davide_id, 1, 'DG', 'IT', 0, '[]'::jsonb, 1, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF elena_id IS NOT NULL AND roma_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), roma_id, elena_id, 8, 'ER', 'IT', 2, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF antonio_id IS NOT NULL AND roma_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), roma_id, antonio_id, 6, 'AB', 'IT', 1, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF chiara_id IS NOT NULL AND roma_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), roma_id, chiara_id, 4, 'CG', 'IT', 2, '[3]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF roberto_id IS NOT NULL AND roma_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), roma_id, roberto_id, 7, 'RM', 'IT', 2, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF valentina_id IS NOT NULL AND roma_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), roma_id, valentina_id, 9, 'VC', 'IT', 3, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;
    IF simone_id IS NOT NULL AND roma_id IS NOT NULL THEN
      INSERT INTO club_members (id, "clubId", "userId", "jerseyNumber", symbol, nationality, "primaryRole", "secondaryRoles", privilege, "joinedAt")
      VALUES (gen_random_uuid_v7(), roma_id, simone_id, 5, 'SL', 'IT', 1, '[]'::jsonb, 2, NOW()) ON CONFLICT ("clubId", "userId") DO NOTHING;
    END IF;

    -- =============================================================================
    -- CREATE MATCHES
    -- =============================================================================
    -- MatchMode: 0=fiveVsFive, 1=eightVsEight, 2=elevenVsEleven
    -- MatchStatus: 0=scheduled, 1=live, 2=finished, 3=completed, 4=cancelled

    -- FC Dragons matches
    IF dragons_id IS NOT NULL THEN
      INSERT INTO matches (id, "clubId", "scheduledAt", location, mode, status, "homeScore", "awayScore", notes, "createdBy", "createdAt", "updatedAt") VALUES
        (gen_random_uuid_v7(), dragons_id, NOW() + INTERVAL '2 days', 'Campo Centrale', 0, 0, 0, 0, 'Prossima partita importante!', test_user_id, NOW(), NOW()),
        (gen_random_uuid_v7(), dragons_id, NOW() - INTERVAL '3 days', 'Campo Centrale', 0, 3, 3, 1, 'Grande vittoria!', test_user_id, NOW(), NOW()),
        (gen_random_uuid_v7(), dragons_id, NOW() - INTERVAL '10 days', 'Campo 2', 0, 3, 2, 2, 'Pareggio combattuto', test_user_id, NOW(), NOW()),
        (gen_random_uuid_v7(), dragons_id, NOW() + INTERVAL '7 days', 'Stadium', 0, 0, 0, 0, NULL, test_user_id, NOW(), NOW())
      ON CONFLICT DO NOTHING;
    END IF;

    -- Real Atletico matches
    IF atletico_id IS NOT NULL THEN
      INSERT INTO matches (id, "clubId", "scheduledAt", location, mode, status, "homeScore", "awayScore", notes, "createdBy", "createdAt", "updatedAt") VALUES
        (gen_random_uuid_v7(), atletico_id, NOW() + INTERVAL '1 day', 'Palestra Comunale', 0, 0, 0, 0, 'Derby locale!', marco_id, NOW(), NOW()),
        (gen_random_uuid_v7(), atletico_id, NOW() - INTERVAL '5 days', 'Palestra Comunale', 0, 3, 1, 0, 'Vittoria in trasferta', marco_id, NOW(), NOW()),
        (gen_random_uuid_v7(), atletico_id, NOW() - INTERVAL '15 days', 'Campo Sportivo', 0, 3, 0, 2, 'Sconfitta amara', marco_id, NOW(), NOW())
      ON CONFLICT DO NOTHING;
    END IF;

    -- Sporting Club matches
    IF sporting_id IS NOT NULL THEN
      INSERT INTO matches (id, "clubId", "scheduledAt", location, mode, status, "homeScore", "awayScore", notes, "createdBy", "createdAt", "updatedAt") VALUES
        (gen_random_uuid_v7(), sporting_id, NOW() + INTERVAL '3 days', 'Campo 3', 0, 0, 0, 0, 'Amichevole', luca_id, NOW(), NOW()),
        (gen_random_uuid_v7(), sporting_id, NOW() - INTERVAL '2 days', 'Campo 3', 0, 3, 4, 3, 'Partita spettacolare!', luca_id, NOW(), NOW()),
        (gen_random_uuid_v7(), sporting_id, NOW() - INTERVAL '8 days', 'Campo 3', 0, 3, 1, 1, 'Pareggio', luca_id, NOW(), NOW()),
        (gen_random_uuid_v7(), sporting_id, NOW() + INTERVAL '5 days', 'Campo 3', 0, 0, 0, 0, NULL, luca_id, NOW(), NOW())
      ON CONFLICT DO NOTHING;
    END IF;

    -- Aurora FC matches
    IF aurora_id IS NOT NULL THEN
      INSERT INTO matches (id, "clubId", "scheduledAt", location, mode, status, "homeScore", "awayScore", notes, "createdBy", "createdAt", "updatedAt") VALUES
        (gen_random_uuid_v7(), aurora_id, NOW() + INTERVAL '4 days', 'Campo Aurora', 0, 0, 0, 0, NULL, giulia_id, NOW(), NOW()),
        (gen_random_uuid_v7(), aurora_id, NOW() - INTERVAL '1 day', 'Campo Aurora', 0, 3, 2, 0, 'Vittoria!', giulia_id, NOW(), NOW())
      ON CONFLICT DO NOTHING;
    END IF;

    -- Inter Milano matches
    IF inter_id IS NOT NULL THEN
      INSERT INTO matches (id, "clubId", "scheduledAt", location, mode, status, "homeScore", "awayScore", notes, "createdBy", "createdAt", "updatedAt") VALUES
        (gen_random_uuid_v7(), inter_id, NOW() + INTERVAL '6 days', 'Campo Inter', 0, 0, 0, 0, NULL, ale_id, NOW(), NOW()),
        (gen_random_uuid_v7(), inter_id, NOW() - INTERVAL '4 days', 'Campo Inter', 0, 3, 3, 2, 'Vittoria in rimonta', ale_id, NOW(), NOW())
      ON CONFLICT DO NOTHING;
    END IF;

    -- Juventus Club matches
    IF juventus_id IS NOT NULL THEN
      INSERT INTO matches (id, "clubId", "scheduledAt", location, mode, status, "homeScore", "awayScore", notes, "createdBy", "createdAt", "updatedAt") VALUES
        (gen_random_uuid_v7(), juventus_id, NOW() + INTERVAL '1 week', 'Campo Juve', 0, 0, 0, 0, 'Partita del campionato', fran_id, NOW(), NOW()),
        (gen_random_uuid_v7(), juventus_id, NOW() - INTERVAL '6 days', 'Campo Juve', 0, 3, 1, 1, 'Pareggio', fran_id, NOW(), NOW())
      ON CONFLICT DO NOTHING;
    END IF;

    -- Milan United matches
    IF milan_id IS NOT NULL THEN
      INSERT INTO matches (id, "clubId", "scheduledAt", location, mode, status, "homeScore", "awayScore", notes, "createdBy", "createdAt", "updatedAt") VALUES
        (gen_random_uuid_v7(), milan_id, NOW() + INTERVAL '5 days', 'Campo Milan', 0, 0, 0, 0, NULL, matteo_id, NOW(), NOW()),
        (gen_random_uuid_v7(), milan_id, NOW() - INTERVAL '7 days', 'Campo Milan', 0, 3, 0, 1, 'Sconfitta', matteo_id, NOW(), NOW())
      ON CONFLICT DO NOTHING;
    END IF;

    -- Roma Calcio matches
    IF roma_id IS NOT NULL THEN
      INSERT INTO matches (id, "clubId", "scheduledAt", location, mode, status, "homeScore", "awayScore", notes, "createdBy", "createdAt", "updatedAt") VALUES
        (gen_random_uuid_v7(), roma_id, NOW() + INTERVAL '3 days', 'Campo Roma', 0, 0, 0, 0, 'Derby!', sophia_id, NOW(), NOW()),
        (gen_random_uuid_v7(), roma_id, NOW() - INTERVAL '12 days', 'Campo Roma', 0, 3, 2, 1, 'Vittoria', sophia_id, NOW(), NOW())
      ON CONFLICT DO NOTHING;
    END IF;

  END;

END $$;

-- =============================================================================
-- VERIFICATION SUMMARY
-- =============================================================================

SELECT 'USERS' as category, COUNT(*) as count FROM users
UNION ALL
SELECT 'CLUBS', COUNT(*) FROM clubs
UNION ALL
SELECT 'CLUB_MEMBERS', COUNT(*) FROM club_members
UNION ALL
SELECT 'MATCHES', COUNT(*) FROM matches;

-- Show test user memberships
SELECT 
  c.name as club_name,
  CASE cm.privilege 
    WHEN 0 THEN 'OWNER'
    WHEN 1 THEN 'MANAGER' 
    WHEN 2 THEN 'MEMBER'
  END as role,
  cm."jerseyNumber" as jersey
FROM club_members cm
JOIN clubs c ON cm."clubId" = c.id
JOIN users u ON cm."userId" = u.id
WHERE u.email = 'test@example.com'
ORDER BY cm.privilege;