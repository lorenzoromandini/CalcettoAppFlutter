BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_info" (
    "id" bigserial PRIMARY KEY,
    "email" text NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    "nickname" text,
    "imageUrl" text,
    "passwordHash" text NOT NULL,
    "passwordSalt" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "lastLogin" timestamp without time zone,
    "deletedAt" timestamp without time zone
);


--
-- MIGRATION VERSION FOR calcetto_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('calcetto_backend', '20260310163027267', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260310163027267', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
