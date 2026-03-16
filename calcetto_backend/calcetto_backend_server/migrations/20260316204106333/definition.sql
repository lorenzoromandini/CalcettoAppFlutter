BEGIN;

--
-- Function: gen_random_uuid_v7()
-- Source: https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
-- License: MIT (copyright notice included on the generator source code).
--
create or replace function gen_random_uuid_v7()
returns uuid
as $$
begin
  -- use random v4 uuid as starting point (which has the same variant we need)
  -- then overlay timestamp
  -- then set version 7 by flipping the 2 and 1 bit in the version 4 string
  return encode(
    set_bit(
      set_bit(
        overlay(uuid_send(gen_random_uuid())
                placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
                from 1 for 6
        ),
        52, 1
      ),
      53, 1
    ),
    'hex')::uuid;
end
$$
language plpgsql
volatile;

--
-- Class ClubInvite as table club_invites
--
CREATE TABLE "club_invites" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "clubId" uuid NOT NULL,
    "createdBy" uuid,
    "token" text NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "club_invites_club_id_idx" ON "club_invites" USING btree ("clubId");
CREATE UNIQUE INDEX "club_invites_token_idx" ON "club_invites" USING btree ("token");

--
-- Class ClubMember as table club_members
--
CREATE TABLE "club_members" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "clubId" uuid NOT NULL,
    "userId" uuid NOT NULL,
    "jerseyNumber" bigint,
    "symbol" text,
    "nationality" text,
    "primaryRole" bigint NOT NULL,
    "secondaryRoles" json NOT NULL,
    "privilege" bigint NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "leftAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "club_members_club_id_idx" ON "club_members" USING btree ("clubId");
CREATE INDEX "club_members_user_id_idx" ON "club_members" USING btree ("userId");
CREATE UNIQUE INDEX "club_members_club_user_unique" ON "club_members" USING btree ("clubId", "userId");

--
-- Class Club as table clubs
--
CREATE TABLE "clubs" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "name" text NOT NULL,
    "description" text,
    "imageUrl" text,
    "createdBy" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "clubs_created_by_idx" ON "clubs" USING btree ("createdBy");

--
-- Class Goal as table goals
--
CREATE TABLE "goals" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "matchId" uuid NOT NULL,
    "scorerId" uuid NOT NULL,
    "assisterId" uuid,
    "isOwnGoal" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "goals_match_id_idx" ON "goals" USING btree ("matchId");
CREATE INDEX "goals_scorer_id_idx" ON "goals" USING btree ("scorerId");
CREATE INDEX "goals_assister_id_idx" ON "goals" USING btree ("assisterId");

--
-- Class MatchParticipant as table match_participants
--
CREATE TABLE "match_participants" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "matchId" uuid NOT NULL,
    "clubMemberId" uuid NOT NULL,
    "teamSide" bigint NOT NULL,
    "position" bigint
);

-- Indexes
CREATE INDEX "match_participants_match_id_idx" ON "match_participants" USING btree ("matchId");
CREATE INDEX "match_participants_club_member_id_idx" ON "match_participants" USING btree ("clubMemberId");
CREATE UNIQUE INDEX "match_participants_unique" ON "match_participants" USING btree ("matchId", "clubMemberId");

--
-- Class Match as table matches
--
CREATE TABLE "matches" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "clubId" uuid NOT NULL,
    "scheduledAt" timestamp without time zone NOT NULL,
    "location" text,
    "mode" bigint NOT NULL,
    "status" bigint NOT NULL,
    "homeScore" bigint NOT NULL,
    "awayScore" bigint NOT NULL,
    "notes" text,
    "createdBy" uuid,
    "scoreFinalizedBy" uuid,
    "ratingsCompletedBy" uuid,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "matches_club_id_idx" ON "matches" USING btree ("clubId");
CREATE INDEX "matches_scheduled_at_idx" ON "matches" USING btree ("scheduledAt");
CREATE INDEX "matches_status_idx" ON "matches" USING btree ("status");

--
-- Class PlayerRating as table player_ratings
--
CREATE TABLE "player_ratings" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "matchId" uuid NOT NULL,
    "clubMemberId" uuid NOT NULL,
    "rating" double precision NOT NULL,
    "comment" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "player_ratings_match_id_idx" ON "player_ratings" USING btree ("matchId");
CREATE INDEX "player_ratings_club_member_id_idx" ON "player_ratings" USING btree ("clubMemberId");
CREATE UNIQUE INDEX "player_ratings_unique" ON "player_ratings" USING btree ("matchId", "clubMemberId");

--
-- Class User as table users
--
CREATE TABLE "users" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "email" text NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    "nickname" text,
    "imageUrl" text,
    "password" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastLogin" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "users_email_idx" ON "users" USING btree ("email");

--
-- Class CloudStorageEntry as table serverpod_cloud_storage
--
CREATE TABLE "serverpod_cloud_storage" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone,
    "byteData" bytea NOT NULL,
    "verified" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE INDEX "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");

--
-- Class CloudStorageDirectUploadEntry as table serverpod_cloud_storage_direct_upload
--
CREATE TABLE "serverpod_cloud_storage_direct_upload" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");

--
-- Class FutureCallEntry as table serverpod_future_call
--
CREATE TABLE "serverpod_future_call" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serverId" text NOT NULL,
    "identifier" text
);

-- Indexes
CREATE INDEX "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");

--
-- Class ServerHealthConnectionInfo as table serverpod_health_connection_info
--
CREATE TABLE "serverpod_health_connection_info" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "active" bigint NOT NULL,
    "closing" bigint NOT NULL,
    "idle" bigint NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");

--
-- Class ServerHealthMetric as table serverpod_health_metric
--
CREATE TABLE "serverpod_health_metric" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    "value" double precision NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");

--
-- Class LogEntry as table serverpod_log
--
CREATE TABLE "serverpod_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "reference" text,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" bigint NOT NULL,
    "message" text NOT NULL,
    "error" text,
    "stackTrace" text,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId");

--
-- Class MessageLogEntry as table serverpod_message_log
--
CREATE TABLE "serverpod_message_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "serverId" text NOT NULL,
    "messageId" bigint NOT NULL,
    "endpoint" text NOT NULL,
    "messageName" text NOT NULL,
    "duration" double precision NOT NULL,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

--
-- Class MethodInfo as table serverpod_method
--
CREATE TABLE "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- Class DatabaseMigrationVersion as table serverpod_migrations
--
CREATE TABLE "serverpod_migrations" (
    "id" bigserial PRIMARY KEY,
    "module" text NOT NULL,
    "version" text NOT NULL,
    "timestamp" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");

--
-- Class QueryLogEntry as table serverpod_query_log
--
CREATE TABLE "serverpod_query_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "query" text NOT NULL,
    "duration" double precision NOT NULL,
    "numRows" bigint,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId");

--
-- Class ReadWriteTestEntry as table serverpod_readwrite_test
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
);

--
-- Class RuntimeSettings as table serverpod_runtime_settings
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- Class SessionLogEntry as table serverpod_session_log
--
CREATE TABLE "serverpod_session_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "module" text,
    "endpoint" text,
    "method" text,
    "duration" double precision,
    "numQueries" bigint,
    "slow" boolean,
    "error" text,
    "stackTrace" text,
    "authenticatedUserId" bigint,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");

--
-- Foreign relations for "club_invites" table
--
ALTER TABLE ONLY "club_invites"
    ADD CONSTRAINT "club_invites_fk_0"
    FOREIGN KEY("clubId")
    REFERENCES "clubs"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "club_invites"
    ADD CONSTRAINT "club_invites_fk_1"
    FOREIGN KEY("createdBy")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "club_members" table
--
ALTER TABLE ONLY "club_members"
    ADD CONSTRAINT "club_members_fk_0"
    FOREIGN KEY("clubId")
    REFERENCES "clubs"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "club_members"
    ADD CONSTRAINT "club_members_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "clubs" table
--
ALTER TABLE ONLY "clubs"
    ADD CONSTRAINT "clubs_fk_0"
    FOREIGN KEY("createdBy")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "goals" table
--
ALTER TABLE ONLY "goals"
    ADD CONSTRAINT "goals_fk_0"
    FOREIGN KEY("matchId")
    REFERENCES "matches"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "goals"
    ADD CONSTRAINT "goals_fk_1"
    FOREIGN KEY("scorerId")
    REFERENCES "club_members"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "goals"
    ADD CONSTRAINT "goals_fk_2"
    FOREIGN KEY("assisterId")
    REFERENCES "club_members"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "match_participants" table
--
ALTER TABLE ONLY "match_participants"
    ADD CONSTRAINT "match_participants_fk_0"
    FOREIGN KEY("matchId")
    REFERENCES "matches"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "match_participants"
    ADD CONSTRAINT "match_participants_fk_1"
    FOREIGN KEY("clubMemberId")
    REFERENCES "club_members"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "matches" table
--
ALTER TABLE ONLY "matches"
    ADD CONSTRAINT "matches_fk_0"
    FOREIGN KEY("clubId")
    REFERENCES "clubs"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "matches"
    ADD CONSTRAINT "matches_fk_1"
    FOREIGN KEY("createdBy")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "matches"
    ADD CONSTRAINT "matches_fk_2"
    FOREIGN KEY("scoreFinalizedBy")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "matches"
    ADD CONSTRAINT "matches_fk_3"
    FOREIGN KEY("ratingsCompletedBy")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "player_ratings" table
--
ALTER TABLE ONLY "player_ratings"
    ADD CONSTRAINT "player_ratings_fk_0"
    FOREIGN KEY("matchId")
    REFERENCES "matches"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "player_ratings"
    ADD CONSTRAINT "player_ratings_fk_1"
    FOREIGN KEY("clubMemberId")
    REFERENCES "club_members"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_log" table
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_message_log" table
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_query_log" table
--
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR calcetto_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('calcetto_backend', '20260316204106333', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260316204106333', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
