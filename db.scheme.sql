CREATE TABLE "buss" (
  "id" int PRIMARY KEY,
  "mark" varchar,
  "created_at" datetime,
  "gps" int,
  "capacity" int
);

CREATE TABLE "GPSService" (
  "id" int PRIMARY KEY
);

CREATE TABLE "driver" (
  "id" int PRIMARY KEY,
  "expirience" float
);

CREATE TABLE "trip" (
  "id" int PRIMARY KEY,
  "buss" int,
  "time_trip" datetime,
  "start_time" datetime,
  "end_time" datetime,
  "path" varchar,
  "price" float
);

CREATE TABLE "path" (
  "id" int PRIMARY KEY,
  "city" varchar,
  "title" varchar,
  "cities_array" int[],
  "code" varchar
);

CREATE TABLE "city" (
  "id" int PRIMARY KEY,
  "name" varchar,
  "created_at" datetime
);

CREATE TABLE "station" (
  "id" int PRIMARY KEY,
  "city" int
);

CREATE TABLE "seller" (
  "id" int PRIMARY KEY,
  "user_id" int,
  "station" int,
  "registered" datetime
);

CREATE TABLE "ticket" (
  "id" int PRIMARY KEY,
  "code" varchar,
  "start_time" datetime,
  "end_time" datetime,
  "station" int,
  "price" float,
  "client" int,
  "discount" int,
  "created_at" datetime,
  "company" int
);

CREATE TABLE "Client" (
  "id" int PRIMARY KEY,
  "discount" float
);

CREATE TABLE "discount" (
  "id" int PRIMARY KEY,
  "amount" float
);

CREATE TABLE "user" (
  "id" int PRIMARY KEY,
  "usertype" text,
  "email" text,
  "first_login" text,
  "address" text,
  "address_lat" text,
  "address_lng" text,
  "phone" text,
  "avatar" text
);

CREATE TABLE "UserToken" (
  "id" int PRIMARY KEY,
  "parent" int,
  "email" text,
  "token" text,
  "accepted" boolean,
  "expired" boolean,
  "expired_time" datetime,
  "timestamp" datetime
);

CREATE TABLE "Company" (
  "id" int PRIMARY KEY,
  "name" varchar,
  "type" varchar,
  "cities_array" int
);

CREATE TABLE "Manager" (
  "id" int PRIMARY KEY,
  "company" int,
  "type" varchar
);

CREATE TABLE "Post" (
  "id" int PRIMARY KEY,
  "title" varchar,
  "author" int,
  "body" text,
  "tags" int,
  "category" int,
  "place" int
);

CREATE TABLE "Tag" (
  "id" int PRIMARY KEY,
  "name" varchar
);

CREATE TABLE "Category" (
  "id" int PRIMARY KEY,
  "name" varchar
);

CREATE TABLE "Media" (
  "id" int PRIMARY KEY,
  "user" int,
  "media_type" varchar,
  "media_size" int,
  "object_type" varchar,
  "object_id" int,
  "created_at" datetime
);

CREATE TABLE "Order" (
  "id" int PRIMARY KEY,
  "user" int,
  "trip" int,
  "paid" boolean,
  "paymant" int,
  "seller" int,
  "company" int,
  "created_at" datetime,
  "updated_at" datetime
);

CREATE TABLE "PaymentOrder" (
  "id" int PRIMARY KEY,
  "uuid" varchar,
  "complete" boolean,
  "created_at" datetime,
  "updated_at" datetime
);

CREATE TABLE "Feedback" (
  "id" int PRIMARY KEY,
  "user" int,
  "content" text,
  "rating" int,
  "object_type" varchar,
  "object_id" int
);

ALTER TABLE "buss" ADD FOREIGN KEY ("gps") REFERENCES "GPSService" ("id");

ALTER TABLE "driver" ADD FOREIGN KEY ("id") REFERENCES "buss" ("id");

ALTER TABLE "driver" ADD FOREIGN KEY ("id") REFERENCES "user" ("id");

ALTER TABLE "trip" ADD FOREIGN KEY ("path") REFERENCES "path" ("id");

ALTER TABLE "trip" ADD FOREIGN KEY ("buss") REFERENCES "buss" ("id");

ALTER TABLE "path" ADD FOREIGN KEY ("cities_array") REFERENCES "city" ("id");

ALTER TABLE "path" ADD FOREIGN KEY ("city") REFERENCES "city" ("id");

ALTER TABLE "station" ADD FOREIGN KEY ("city") REFERENCES "city" ("id");

ALTER TABLE "seller" ADD FOREIGN KEY ("station") REFERENCES "station" ("id");

ALTER TABLE "seller" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");

ALTER TABLE "ticket" ADD FOREIGN KEY ("company") REFERENCES "Company" ("id");

ALTER TABLE "ticket" ADD FOREIGN KEY ("client") REFERENCES "Client" ("id");

ALTER TABLE "ticket" ADD FOREIGN KEY ("start_time") REFERENCES "trip" ("start_time");

ALTER TABLE "ticket" ADD FOREIGN KEY ("end_time") REFERENCES "trip" ("end_time");

ALTER TABLE "ticket" ADD FOREIGN KEY ("station") REFERENCES "station" ("id");

ALTER TABLE "ticket" ADD FOREIGN KEY ("price") REFERENCES "trip" ("price");

ALTER TABLE "ticket" ADD FOREIGN KEY ("discount") REFERENCES "Client" ("discount");

ALTER TABLE "Client" ADD FOREIGN KEY ("id") REFERENCES "user" ("id");

ALTER TABLE "Client" ADD FOREIGN KEY ("discount") REFERENCES "discount" ("id");

ALTER TABLE "UserToken" ADD FOREIGN KEY ("parent") REFERENCES "user" ("id");

ALTER TABLE "path" ADD FOREIGN KEY ("id") REFERENCES "ticket" ("id");

ALTER TABLE "seller" ADD FOREIGN KEY ("id") REFERENCES "Company" ("id");

ALTER TABLE "Company" ADD FOREIGN KEY ("cities_array") REFERENCES "city" ("id");

ALTER TABLE "Manager" ADD FOREIGN KEY ("company") REFERENCES "Company" ("id");

ALTER TABLE "Post" ADD FOREIGN KEY ("author") REFERENCES "user" ("id");

ALTER TABLE "Post" ADD FOREIGN KEY ("tags") REFERENCES "Tag" ("id");

ALTER TABLE "Post" ADD FOREIGN KEY ("category") REFERENCES "Category" ("id");

ALTER TABLE "Post" ADD FOREIGN KEY ("place") REFERENCES "city" ("id");

ALTER TABLE "Media" ADD FOREIGN KEY ("user") REFERENCES "user" ("id");

ALTER TABLE "Order" ADD FOREIGN KEY ("user") REFERENCES "user" ("id");

ALTER TABLE "Order" ADD FOREIGN KEY ("trip") REFERENCES "trip" ("id");

ALTER TABLE "Order" ADD FOREIGN KEY ("seller") REFERENCES "seller" ("id");

ALTER TABLE "Order" ADD FOREIGN KEY ("company") REFERENCES "Company" ("id");

ALTER TABLE "Order" ADD FOREIGN KEY ("paymant") REFERENCES "PaymentOrder" ("id");

ALTER TABLE "Feedback" ADD FOREIGN KEY ("user") REFERENCES "user" ("id");
