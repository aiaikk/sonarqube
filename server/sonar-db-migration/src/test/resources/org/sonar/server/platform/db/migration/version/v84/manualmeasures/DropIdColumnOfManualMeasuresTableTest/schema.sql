CREATE TABLE "MANUAL_MEASURES"(
    "ID" BIGINT NOT NULL AUTO_INCREMENT (1,1),
    "METRIC_ID" INTEGER NOT NULL,
    "VALUE" DOUBLE,
    "TEXT_VALUE" VARCHAR(4000),
    "USER_UUID" VARCHAR(255),
    "DESCRIPTION" VARCHAR(4000),
    "CREATED_AT" BIGINT,
    "UPDATED_AT" BIGINT,
    "COMPONENT_UUID" VARCHAR(50) NOT NULL,
    "UUID" VARCHAR(40) NOT NULL
);
CREATE INDEX "MANUAL_MEASURES_COMPONENT_UUID" ON "MANUAL_MEASURES"("COMPONENT_UUID");