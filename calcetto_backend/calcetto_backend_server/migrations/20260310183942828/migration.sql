BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "club" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" text,
    "imageUrl" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "deletedAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "club_member" (
    "id" bigserial PRIMARY KEY,
    "clubId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "privileges" bigint NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL,
    "deletedAt" timestamp without time zone
);


--
-- MIGRATION VERSION FOR calcetto_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('calcetto_backend', '20260310183942828', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260310183942828', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
