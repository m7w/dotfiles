-- Create "products" table if not exists
CREATE TABLE IF NOT EXISTS "public"."products" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "price" NUMERIC(10, 2) NOT NULL DEFAULT 0,
    PRIMARY KEY ("id")
);

-- Create "users" table if not exists
CREATE TABLE IF NOT EXISTS "public"."users" (
    "id" SERIAL NOT NULL,
    "username" VARCHAR(50) NOT NULL,
    "email" VARCHAR(50) NOT NULL,
    PRIMARY KEY ("id")
);
