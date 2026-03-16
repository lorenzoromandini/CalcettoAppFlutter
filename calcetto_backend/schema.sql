-- =============================================================================
-- Schema for Football Organizer App (Serverpod + PostgreSQL)
-- Final version – March 2026 – with all indexes
-- =============================================================================

-- Enums
CREATE TYPE player_position AS ENUM ('GK', 'DEF', 'MID', 'ST');
CREATE TYPE club_privilege AS ENUM ('OWNER', 'MANAGER', 'MEMBER');
CREATE TYPE match_mode AS ENUM ('5v5', '8v8', '11v11');
CREATE TYPE match_status AS ENUM ('scheduled', 'live', 'finished', 'completed', 'cancelled');
CREATE TYPE match_team_side AS ENUM ('home', 'away');

-- =============================================================================
-- USERS
-- =============================================================================
CREATE TABLE users (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    email       TEXT UNIQUE NOT NULL,
    first_name  TEXT NOT NULL,
    last_name   TEXT NOT NULL,
    nickname    TEXT,
    image_url   TEXT,
    password    TEXT NOT NULL, -- hashed
    created_at  TIMESTAMPTZ DEFAULT now(),
    updated_at  TIMESTAMPTZ DEFAULT now(),
    last_login  TIMESTAMPTZ
);

-- =============================================================================
-- CLUBS
-- =============================================================================
CREATE TABLE clubs (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    name          TEXT NOT NULL,
    description   TEXT,
    image_url     TEXT,
    created_by    UUID REFERENCES users(id),
    created_at    TIMESTAMPTZ DEFAULT now(),
    updated_at    TIMESTAMPTZ DEFAULT now(),
    deleted_at    TIMESTAMPTZ
);

-- =============================================================================
-- CLUB_MEMBERS
-- =============================================================================
CREATE TABLE club_members (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    club_id         UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    jersey_number   INTEGER CHECK (jersey_number BETWEEN 1 AND 99),
    symbol          TEXT,
    nationality     TEXT,
    primary_role    player_position NOT NULL DEFAULT 'CEN',
    secondary_roles player_position[] NOT NULL DEFAULT '{}',
    privilege       club_privilege NOT NULL DEFAULT 'MEMBER',
    joined_at       TIMESTAMPTZ DEFAULT now(),
    left_at         TIMESTAMPTZ,
    UNIQUE(club_id, user_id)
);

-- =============================================================================
-- CLUB_INVITES
-- =============================================================================
CREATE TABLE club_invites (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    club_id     UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    created_by  UUID REFERENCES users(id),
    token       TEXT UNIQUE NOT NULL,
    expires_at  TIMESTAMPTZ NOT NULL,
    created_at  TIMESTAMPTZ DEFAULT now()
);

-- =============================================================================
-- MATCHES
-- =============================================================================
CREATE TABLE matches (
    id               UUID PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    club_id          UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    scheduled_at     TIMESTAMPTZ NOT NULL,
    location         TEXT,
    mode             match_mode NOT NULL,
    status           match_status NOT NULL DEFAULT 'scheduled',
    home_score       INTEGER NOT NULL DEFAULT 0,
    away_score       INTEGER NOT NULL DEFAULT 0,
    notes            TEXT,
    created_by           UUID REFERENCES users(id),
    score_finalized_by   UUID REFERENCES users(id),
    ratings_completed_by UUID REFERENCES users(id),
    created_at       TIMESTAMPTZ DEFAULT now(),
    updated_at       TIMESTAMPTZ DEFAULT now()
);

-- =============================================================================
-- MATCH_PARTICIPANTS
-- =============================================================================
CREATE TABLE match_participants (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    match_id        UUID NOT NULL REFERENCES matches(id) ON DELETE CASCADE,
    club_member_id  UUID NOT NULL REFERENCES club_members(id),
    team_side       match_team_side NOT NULL,
    position        player_position,
    UNIQUE(match_id, club_member_id)
);

-- =============================================================================
-- GOALS
-- =============================================================================
CREATE TABLE goals (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    match_id      UUID NOT NULL REFERENCES matches(id) ON DELETE CASCADE,
    scorer_id     UUID NOT NULL REFERENCES club_members(id),
    assister_id   UUID REFERENCES club_members(id),
    is_own_goal   BOOLEAN DEFAULT false,
    created_at    TIMESTAMPTZ DEFAULT now()
);

-- =============================================================================
-- PLAYER_RATINGS
-- =============================================================================
CREATE TABLE player_ratings (
    id               UUID PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    match_id         UUID NOT NULL REFERENCES matches(id) ON DELETE CASCADE,
    club_member_id   UUID NOT NULL REFERENCES club_members(id),
    rating           NUMERIC(4,2) CHECK (rating >= 1 AND rating <= 10),
    comment          TEXT,
    created_at       TIMESTAMPTZ DEFAULT now(),
    updated_at       TIMESTAMPTZ DEFAULT now(),
    UNIQUE(match_id, club_member_id)
);

-- =============================================================================
-- MATERIALIZED VIEW: MEMBER STATS
-- =============================================================================
CREATE MATERIALIZED VIEW member_stats AS
SELECT
    cm.id AS club_member_id,
    cm.club_id,
    COUNT(DISTINCT mp.match_id) AS appearances,
    COUNT(DISTINCT g.id) FILTER (WHERE g.scorer_id = cm.id AND g.is_own_goal = false) AS goals_scored,
    COUNT(DISTINCT g.id) FILTER (WHERE g.assister_id = cm.id) AS assists
FROM club_members cm
LEFT JOIN match_participants mp ON mp.club_member_id = cm.id
LEFT JOIN goals g ON g.scorer_id = cm.id OR g.assister_id = cm.id
GROUP BY cm.id, cm.club_id;

-- =============================================================================
-- INDEXES (performance)
-- =============================================================================
CREATE INDEX idx_users_email               ON users(email);
CREATE INDEX idx_clubs_created_by          ON clubs(created_by);
CREATE INDEX idx_club_members_club_id      ON club_members(club_id);
CREATE INDEX idx_club_members_user_id      ON club_members(user_id);
CREATE INDEX idx_club_invites_club_id      ON club_invites(club_id);
CREATE INDEX idx_club_invites_token        ON club_invites(token);
CREATE INDEX idx_matches_club_id           ON matches(club_id);
CREATE INDEX idx_matches_scheduled_at      ON matches(scheduled_at);
CREATE INDEX idx_matches_status            ON matches(status);
CREATE INDEX idx_match_participants_match_id      ON match_participants(match_id);
CREATE INDEX idx_match_participants_club_member_id ON match_participants(club_member_id);
CREATE INDEX idx_goals_match_id            ON goals(match_id);
CREATE INDEX idx_goals_scorer_id           ON goals(scorer_id);
CREATE INDEX idx_goals_assister_id         ON goals(assister_id);
CREATE INDEX idx_player_ratings_match_id   ON player_ratings(match_id);
CREATE INDEX idx_player_ratings_club_member_id ON player_ratings(club_member_id);
