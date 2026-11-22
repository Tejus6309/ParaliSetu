--
-- ParaliSetu Initial Migration for PostgreSQL
--

BEGIN;

CREATE TABLE IF NOT EXISTS "paralisetu_user" (
    "id" serial PRIMARY KEY,
    "email" text NOT NULL,
    "name" text NOT NULL,
    "role" text NOT NULL,
    "passwordHash" text NOT NULL,
    "createdAt" timestamp without time zone
);

CREATE UNIQUE INDEX IF NOT EXISTS "paralisetu_user_email_idx" ON "paralisetu_user" ("email");

CREATE TABLE IF NOT EXISTS "paralisetu_listing" (
    "id" serial PRIMARY KEY,
    "farmerId" bigint NOT NULL,
    "crop" text NOT NULL,
    "district" text NOT NULL,
    "description" text NOT NULL,
    "availableKg" bigint NOT NULL CHECK ("availableKg" >= 0),
    "pricePerKg" double precision NOT NULL CHECK ("pricePerKg" > 0),
    "harvestDate" timestamp without time zone NOT NULL,
    "availableFrom" timestamp without time zone NOT NULL,
    "availableUntil" timestamp without time zone NOT NULL,
    "status" text NOT NULL DEFAULT 'ACTIVE',
    "version" bigint NOT NULL DEFAULT 0,
    "farmerName" text,
    CONSTRAINT "valid_listing_window" CHECK ("harvestDate" <= "availableFrom" AND "availableFrom" <= "availableUntil")
);

CREATE INDEX IF NOT EXISTS "paralisetu_listing_market_idx" ON "paralisetu_listing" ("status", "crop", "district");

CREATE TABLE IF NOT EXISTS "paralisetu_order" (
    "id" serial PRIMARY KEY,
    "listingId" bigint NOT NULL,
    "farmerId" bigint NOT NULL,
    "buyerId" bigint NOT NULL,
    "carrierId" bigint,
    "quantityKg" bigint NOT NULL CHECK ("quantityKg" > 0),
    "pricePerKg" double precision NOT NULL,
    "crop" text NOT NULL,
    "district" text NOT NULL,
    "status" text NOT NULL DEFAULT 'REQUESTED',
    "farmerArrivedAt" timestamp without time zone,
    "carrierArrivedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL,
    "farmerName" text,
    "buyerName" text,
    "carrierName" text
);

CREATE INDEX IF NOT EXISTS "paralisetu_order_listing_status_idx" ON "paralisetu_order" ("listingId", "status");

COMMIT;
