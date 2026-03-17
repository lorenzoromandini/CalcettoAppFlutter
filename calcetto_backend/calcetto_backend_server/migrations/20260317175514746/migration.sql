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
-- ACTION DROP TABLE
--
DROP TABLE "goals" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "match_player_stats" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "matchId" uuid NOT NULL,
    "clubMemberId" uuid NOT NULL,
    "goalsOpen" bigint NOT NULL DEFAULT 0,
    "goalsPenalty" bigint NOT NULL DEFAULT 0,
    "assists" bigint NOT NULL DEFAULT 0,
    "ownGoals" bigint NOT NULL DEFAULT 0,
    "penaltiesMissed" bigint NOT NULL DEFAULT 0,
    "penaltiesSaved" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "match_player_stats_match_id_idx" ON "match_player_stats" USING btree ("matchId");
CREATE INDEX "match_player_stats_club_member_id_idx" ON "match_player_stats" USING btree ("clubMemberId");
CREATE UNIQUE INDEX "match_player_stats_unique" ON "match_player_stats" USING btree ("matchId", "clubMemberId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "player_ratings" ADD COLUMN "ratingPreCaps" double precision;
ALTER TABLE "player_ratings" ADD COLUMN "bonusMinusMalus" double precision;
ALTER TABLE "player_ratings" ADD COLUMN "mvp" boolean NOT NULL DEFAULT false;
ALTER TABLE "player_ratings" ADD COLUMN "mention" bigint NOT NULL DEFAULT 0;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "match_player_stats"
    ADD CONSTRAINT "match_player_stats_fk_0"
    FOREIGN KEY("matchId")
    REFERENCES "matches"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "match_player_stats"
    ADD CONSTRAINT "match_player_stats_fk_1"
    FOREIGN KEY("clubMemberId")
    REFERENCES "club_members"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR calcetto_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('calcetto_backend', '20260317175514746', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260317175514746', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
