CREATE TABLE "public.customers" (
	"id" serial NOT NULL,
	"name" TEXT NOT NULL,
	"e-mail" TEXT NOT NULL UNIQUE,
	"password" TEXT NOT NULL,
	CONSTRAINT "customers_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.customersAdresses" (
	"id" serial NOT NULL,
	"customerId" integer NOT NULL,
	"street" TEXT NOT NULL,
	"number" TEXT NOT NULL,
	"complement" TEXT,
	"postalCode" TEXT NOT NULL,
	CONSTRAINT "customersAdresses_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.products" (
	"id" serial NOT NULL,
	"name" TEXT NOT NULL UNIQUE,
	"price" integer NOT NULL,
	"albumId" integer NOT NULL UNIQUE,
	"categoryId" integer NOT NULL UNIQUE,
	"size" varchar(3) NOT NULL,
	CONSTRAINT "products_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.productsCategories" (
	"id" serial NOT NULL,
	"name" TEXT NOT NULL UNIQUE,
	CONSTRAINT "productsCategories_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.producsAlbum" (
	"id" serial NOT NULL,
	"coverId" integer NOT NULL,
	CONSTRAINT "producsAlbum_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.productsPhotos" (
	"id" serial NOT NULL UNIQUE,
	"albumId" integer NOT NULL,
	"urlImage" TEXT NOT NULL UNIQUE,
	CONSTRAINT "productsPhotos_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.purchasesCarts" (
	"id" serial NOT NULL,
	"customerId" integer NOT NULL,
	CONSTRAINT "purchasesCarts_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.purchasesItens" (
	"id" serial NOT NULL,
	"cartId" serial NOT NULL,
	"productId" integer NOT NULL,
	"amount" integer NOT NULL,
	CONSTRAINT "purchasesItens_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);


CREATE TYPE "purchasesStatus" AS ENUM ('created', 'paid', 'delivered', 'canceled');

CREATE TABLE "public.Purchases" (
	"id" serial NOT NULL,
	"customerId" integer NOT NULL,
	"cartId" integer NOT NULL,
	type "purchasesStatus" NOT NULL,
	"date" TIMESTAMP WITHOUT TIME ZONE DEFAULT 'NOW()',
	"customerAdressId" integer NOT NULL,
	CONSTRAINT "Purchases_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);




ALTER TABLE "customersAdresses" ADD CONSTRAINT "customersAdresses_fk0" FOREIGN KEY ("customerId") REFERENCES "customers"("id");

ALTER TABLE "products" ADD CONSTRAINT "products_fk0" FOREIGN KEY ("albumId") REFERENCES "producsAlbum"("id");
ALTER TABLE "products" ADD CONSTRAINT "products_fk1" FOREIGN KEY ("categoryId") REFERENCES "productsCategories"("id");


ALTER TABLE "productsPhotos" ADD CONSTRAINT "productsPhotos_fk0" FOREIGN KEY ("albumId") REFERENCES "producsAlbum"("id");


ALTER TABLE "productsAlbum" ADD CONSTRAINT "productsAlbum_fk0" FOREIGN KEY ("coverId") REFERENCES "producsPhotos"("id");


ALTER TABLE "purchasesCarts" ADD CONSTRAINT "purchasesCarts_fk0" FOREIGN KEY ("customerId") REFERENCES "customers"("id");

ALTER TABLE "purchasesItens" ADD CONSTRAINT "purchasesItens_fk0" FOREIGN KEY ("cartId") REFERENCES "purchasesCarts"("id");
ALTER TABLE "purchasesItens" ADD CONSTRAINT "purchasesItens_fk1" FOREIGN KEY ("productId") REFERENCES "products"("id");

ALTER TABLE "Purchases" ADD CONSTRAINT "Purchases_fk0" FOREIGN KEY ("customerId") REFERENCES "customers"("id");
ALTER TABLE "Purchases" ADD CONSTRAINT "Purchases_fk1" FOREIGN KEY ("cartId") REFERENCES "purchasesCarts"("id");
ALTER TABLE "Purchases" ADD CONSTRAINT "Purchases_fk2" FOREIGN KEY ("customerAdressId") REFERENCES "customersAdresses"("id");










