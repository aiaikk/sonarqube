###############################################################
####  Description of SonarQube's schema in H2 SQL syntax   ####
####                                                       ####
####   This file is autogenerated and stored in SCM to     ####
####   conveniently read the SonarQube's schema at any     ####
####   point in time.                                      ####
####                                                       ####
####          DO NOT MODIFY THIS FILE DIRECTLY             ####
####    use gradle task :server:sonar-db-dao:dumpSchema    ####
###############################################################

CREATE TABLE "SCHEMA_MIGRATIONS"(
    "VERSION" VARCHAR(255) NOT NULL
);

CREATE TABLE "ACTIVE_RULE_PARAMETERS"(
    "VALUE" VARCHAR(4000),
    "RULES_PARAMETER_KEY" VARCHAR(128),
    "UUID" VARCHAR(40) NOT NULL,
    "ACTIVE_RULE_UUID" VARCHAR(40) NOT NULL,
    "RULES_PARAMETER_UUID" VARCHAR(40) NOT NULL
);
ALTER TABLE "ACTIVE_RULE_PARAMETERS" ADD CONSTRAINT "PK_ACTIVE_RULE_PARAMETERS" PRIMARY KEY("UUID");
CREATE INDEX "ARP_ACTIVE_RULE_UUID" ON "ACTIVE_RULE_PARAMETERS"("ACTIVE_RULE_UUID");

CREATE TABLE "ACTIVE_RULES"(
    "FAILURE_LEVEL" INTEGER NOT NULL,
    "INHERITANCE" VARCHAR(10),
    "CREATED_AT" BIGINT,
    "UPDATED_AT" BIGINT,
    "UUID" VARCHAR(40) NOT NULL,
    "PROFILE_UUID" VARCHAR(40) NOT NULL,
    "RULE_UUID" VARCHAR(40) NOT NULL
);
ALTER TABLE "ACTIVE_RULES" ADD CONSTRAINT "PK_ACTIVE_RULES" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "UNIQ_PROFILE_RULE_UUIDS" ON "ACTIVE_RULES"("PROFILE_UUID", "RULE_UUID");

CREATE TABLE "ALM_APP_INSTALLS"(
    "UUID" VARCHAR(40) NOT NULL,
    "ALM_ID" VARCHAR(40) NOT NULL,
    "OWNER_ID" VARCHAR(4000) NOT NULL,
    "INSTALL_ID" VARCHAR(4000) NOT NULL,
    "IS_OWNER_USER" BOOLEAN NOT NULL,
    "USER_EXTERNAL_ID" VARCHAR(255),
    "CREATED_AT" BIGINT NOT NULL,
    "UPDATED_AT" BIGINT NOT NULL
);
ALTER TABLE "ALM_APP_INSTALLS" ADD CONSTRAINT "PK_ALM_APP_INSTALLS" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "ALM_APP_INSTALLS_OWNER" ON "ALM_APP_INSTALLS"("ALM_ID", "OWNER_ID");
CREATE UNIQUE INDEX "ALM_APP_INSTALLS_INSTALL" ON "ALM_APP_INSTALLS"("ALM_ID", "INSTALL_ID");
CREATE INDEX "ALM_APP_INSTALLS_EXTERNAL_ID" ON "ALM_APP_INSTALLS"("USER_EXTERNAL_ID");

CREATE TABLE "ALM_PATS"(
    "UUID" VARCHAR(40) NOT NULL,
    "PAT" VARCHAR(2000) NOT NULL,
    "USER_UUID" VARCHAR(256) NOT NULL,
    "ALM_SETTING_UUID" VARCHAR(40) NOT NULL,
    "UPDATED_AT" BIGINT NOT NULL,
    "CREATED_AT" BIGINT NOT NULL
);
ALTER TABLE "ALM_PATS" ADD CONSTRAINT "PK_ALM_PATS" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "UNIQ_ALM_PATS" ON "ALM_PATS"("USER_UUID", "ALM_SETTING_UUID");

CREATE TABLE "ALM_SETTINGS"(
    "UUID" VARCHAR(40) NOT NULL,
    "ALM_ID" VARCHAR(40) NOT NULL,
    "KEE" VARCHAR(200) NOT NULL,
    "URL" VARCHAR(2000),
    "APP_ID" VARCHAR(80),
    "PRIVATE_KEY" VARCHAR(2000),
    "PAT" VARCHAR(2000),
    "UPDATED_AT" BIGINT NOT NULL,
    "CREATED_AT" BIGINT NOT NULL,
    "CLIENT_ID" VARCHAR(80),
    "CLIENT_SECRET" VARCHAR(80)
);
ALTER TABLE "ALM_SETTINGS" ADD CONSTRAINT "PK_ALM_SETTINGS" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "UNIQ_ALM_SETTINGS" ON "ALM_SETTINGS"("KEE");

CREATE TABLE "ANALYSIS_PROPERTIES"(
    "UUID" VARCHAR(40) NOT NULL,
    "ANALYSIS_UUID" VARCHAR(40) NOT NULL,
    "KEE" VARCHAR(512) NOT NULL,
    "TEXT_VALUE" VARCHAR(4000),
    "CLOB_VALUE" CLOB,
    "IS_EMPTY" BOOLEAN NOT NULL,
    "CREATED_AT" BIGINT NOT NULL
);
ALTER TABLE "ANALYSIS_PROPERTIES" ADD CONSTRAINT "PK_ANALYSIS_PROPERTIES" PRIMARY KEY("UUID");
CREATE INDEX "ANALYSIS_PROPERTIES_ANALYSIS" ON "ANALYSIS_PROPERTIES"("ANALYSIS_UUID");

CREATE TABLE "CE_ACTIVITY"(
    "UUID" VARCHAR(40) NOT NULL,
    "TASK_TYPE" VARCHAR(15) NOT NULL,
    "MAIN_COMPONENT_UUID" VARCHAR(40),
    "COMPONENT_UUID" VARCHAR(40),
    "STATUS" VARCHAR(15) NOT NULL,
    "MAIN_IS_LAST" BOOLEAN NOT NULL,
    "MAIN_IS_LAST_KEY" VARCHAR(55) NOT NULL,
    "IS_LAST" BOOLEAN NOT NULL,
    "IS_LAST_KEY" VARCHAR(55) NOT NULL,
    "SUBMITTER_UUID" VARCHAR(255),
    "SUBMITTED_AT" BIGINT NOT NULL,
    "STARTED_AT" BIGINT,
    "EXECUTED_AT" BIGINT,
    "EXECUTION_COUNT" INTEGER NOT NULL,
    "EXECUTION_TIME_MS" BIGINT,
    "ANALYSIS_UUID" VARCHAR(50),
    "ERROR_MESSAGE" VARCHAR(1000),
    "ERROR_STACKTRACE" CLOB,
    "ERROR_TYPE" VARCHAR(20),
    "WORKER_UUID" VARCHAR(40),
    "CREATED_AT" BIGINT NOT NULL,
    "UPDATED_AT" BIGINT NOT NULL
);
ALTER TABLE "CE_ACTIVITY" ADD CONSTRAINT "PK_CE_ACTIVITY" PRIMARY KEY("UUID");
CREATE INDEX "CE_ACTIVITY_COMPONENT" ON "CE_ACTIVITY"("COMPONENT_UUID");
CREATE INDEX "CE_ACTIVITY_ISLAST" ON "CE_ACTIVITY"("IS_LAST", "STATUS");
CREATE INDEX "CE_ACTIVITY_ISLAST_KEY" ON "CE_ACTIVITY"("IS_LAST_KEY");
CREATE INDEX "CE_ACTIVITY_MAIN_COMPONENT" ON "CE_ACTIVITY"("MAIN_COMPONENT_UUID");
CREATE INDEX "CE_ACTIVITY_MAIN_ISLAST" ON "CE_ACTIVITY"("MAIN_IS_LAST", "STATUS");
CREATE INDEX "CE_ACTIVITY_MAIN_ISLAST_KEY" ON "CE_ACTIVITY"("MAIN_IS_LAST_KEY");
CREATE UNIQUE INDEX "CE_ACTIVITY_UUID" ON "CE_ACTIVITY"("UUID");

CREATE TABLE "CE_QUEUE"(
    "UUID" VARCHAR(40) NOT NULL,
    "TASK_TYPE" VARCHAR(15) NOT NULL,
    "MAIN_COMPONENT_UUID" VARCHAR(40),
    "COMPONENT_UUID" VARCHAR(40),
    "STATUS" VARCHAR(15),
    "SUBMITTER_UUID" VARCHAR(255),
    "STARTED_AT" BIGINT,
    "WORKER_UUID" VARCHAR(40),
    "EXECUTION_COUNT" INTEGER NOT NULL,
    "CREATED_AT" BIGINT NOT NULL,
    "UPDATED_AT" BIGINT NOT NULL
);
ALTER TABLE "CE_QUEUE" ADD CONSTRAINT "PK_CE_QUEUE" PRIMARY KEY("UUID");
CREATE INDEX "CE_QUEUE_MAIN_COMPONENT" ON "CE_QUEUE"("MAIN_COMPONENT_UUID");
CREATE INDEX "CE_QUEUE_COMPONENT" ON "CE_QUEUE"("COMPONENT_UUID");

CREATE TABLE "CE_SCANNER_CONTEXT"(
    "TASK_UUID" VARCHAR(40) NOT NULL,
    "CONTEXT_DATA" BLOB NOT NULL,
    "CREATED_AT" BIGINT NOT NULL,
    "UPDATED_AT" BIGINT NOT NULL
);
ALTER TABLE "CE_SCANNER_CONTEXT" ADD CONSTRAINT "PK_CE_SCANNER_CONTEXT" PRIMARY KEY("TASK_UUID");

CREATE TABLE "CE_TASK_CHARACTERISTICS"(
    "UUID" VARCHAR(40) NOT NULL,
    "TASK_UUID" VARCHAR(40) NOT NULL,
    "KEE" VARCHAR(512) NOT NULL,
    "TEXT_VALUE" VARCHAR(512)
);
ALTER TABLE "CE_TASK_CHARACTERISTICS" ADD CONSTRAINT "PK_CE_TASK_CHARACTERISTICS" PRIMARY KEY("UUID");
CREATE INDEX "CE_CHARACTERISTICS_TASK_UUID" ON "CE_TASK_CHARACTERISTICS"("TASK_UUID");

CREATE TABLE "CE_TASK_INPUT"(
    "TASK_UUID" VARCHAR(40) NOT NULL,
    "INPUT_DATA" BLOB,
    "CREATED_AT" BIGINT NOT NULL,
    "UPDATED_AT" BIGINT NOT NULL
);
ALTER TABLE "CE_TASK_INPUT" ADD CONSTRAINT "PK_CE_TASK_INPUT" PRIMARY KEY("TASK_UUID");

CREATE TABLE "CE_TASK_MESSAGE"(
    "UUID" VARCHAR(40) NOT NULL,
    "TASK_UUID" VARCHAR(40) NOT NULL,
    "MESSAGE" VARCHAR(4000) NOT NULL,
    "CREATED_AT" BIGINT NOT NULL
);
ALTER TABLE "CE_TASK_MESSAGE" ADD CONSTRAINT "PK_CE_TASK_MESSAGE" PRIMARY KEY("UUID");
CREATE INDEX "CE_TASK_MESSAGE_TASK" ON "CE_TASK_MESSAGE"("TASK_UUID");

CREATE TABLE "COMPONENTS"(
    "UUID" VARCHAR(50) NOT NULL,
    "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
    "KEE" VARCHAR(400),
    "DEPRECATED_KEE" VARCHAR(400),
    "NAME" VARCHAR(2000),
    "LONG_NAME" VARCHAR(2000),
    "DESCRIPTION" VARCHAR(2000),
    "ENABLED" BOOLEAN DEFAULT TRUE NOT NULL,
    "SCOPE" VARCHAR(3),
    "QUALIFIER" VARCHAR(10),
    "PRIVATE" BOOLEAN NOT NULL,
    "ROOT_UUID" VARCHAR(50) NOT NULL,
    "LANGUAGE" VARCHAR(20),
    "COPY_COMPONENT_UUID" VARCHAR(50),
    "PATH" VARCHAR(2000),
    "UUID_PATH" VARCHAR(1500) NOT NULL,
    "PROJECT_UUID" VARCHAR(50) NOT NULL,
    "MODULE_UUID" VARCHAR(50),
    "MODULE_UUID_PATH" VARCHAR(1500),
    "MAIN_BRANCH_PROJECT_UUID" VARCHAR(50),
    "B_CHANGED" BOOLEAN,
    "B_NAME" VARCHAR(500),
    "B_LONG_NAME" VARCHAR(500),
    "B_DESCRIPTION" VARCHAR(2000),
    "B_ENABLED" BOOLEAN,
    "B_QUALIFIER" VARCHAR(10),
    "B_LANGUAGE" VARCHAR(20),
    "B_COPY_COMPONENT_UUID" VARCHAR(50),
    "B_PATH" VARCHAR(2000),
    "B_UUID_PATH" VARCHAR(1500),
    "B_MODULE_UUID" VARCHAR(50),
    "B_MODULE_UUID_PATH" VARCHAR(1500),
    "CREATED_AT" TIMESTAMP
);
CREATE INDEX "PROJECTS_ORGANIZATION" ON "COMPONENTS"("ORGANIZATION_UUID");
CREATE UNIQUE INDEX "PROJECTS_KEE" ON "COMPONENTS"("KEE");
CREATE INDEX "PROJECTS_MODULE_UUID" ON "COMPONENTS"("MODULE_UUID");
CREATE INDEX "PROJECTS_PROJECT_UUID" ON "COMPONENTS"("PROJECT_UUID");
CREATE INDEX "PROJECTS_QUALIFIER" ON "COMPONENTS"("QUALIFIER");
CREATE INDEX "PROJECTS_ROOT_UUID" ON "COMPONENTS"("ROOT_UUID");
CREATE INDEX "PROJECTS_UUID" ON "COMPONENTS"("UUID");

CREATE TABLE "DEFAULT_QPROFILES"(
    "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
    "LANGUAGE" VARCHAR(20) NOT NULL,
    "QPROFILE_UUID" VARCHAR(255) NOT NULL,
    "CREATED_AT" BIGINT NOT NULL,
    "UPDATED_AT" BIGINT NOT NULL
);
ALTER TABLE "DEFAULT_QPROFILES" ADD CONSTRAINT "PK_DEFAULT_QPROFILES" PRIMARY KEY("ORGANIZATION_UUID", "LANGUAGE");
CREATE UNIQUE INDEX "UNIQ_DEFAULT_QPROFILES_UUID" ON "DEFAULT_QPROFILES"("QPROFILE_UUID");

CREATE TABLE "DEPRECATED_RULE_KEYS"(
    "UUID" VARCHAR(40) NOT NULL,
    "OLD_REPOSITORY_KEY" VARCHAR(255) NOT NULL,
    "OLD_RULE_KEY" VARCHAR(200) NOT NULL,
    "CREATED_AT" BIGINT NOT NULL,
    "RULE_UUID" VARCHAR(40) NOT NULL
);
ALTER TABLE "DEPRECATED_RULE_KEYS" ADD CONSTRAINT "PK_DEPRECATED_RULE_KEYS" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "UNIQ_DEPRECATED_RULE_KEYS" ON "DEPRECATED_RULE_KEYS"("OLD_REPOSITORY_KEY", "OLD_RULE_KEY");
CREATE INDEX "RULE_UUID_DEPRECATED_RULE_KEYS" ON "DEPRECATED_RULE_KEYS"("RULE_UUID");

CREATE TABLE "DUPLICATIONS_INDEX"(
    "ANALYSIS_UUID" VARCHAR(50) NOT NULL,
    "COMPONENT_UUID" VARCHAR(50) NOT NULL,
    "HASH" VARCHAR(50) NOT NULL,
    "INDEX_IN_FILE" INTEGER NOT NULL,
    "START_LINE" INTEGER NOT NULL,
    "END_LINE" INTEGER NOT NULL,
    "UUID" VARCHAR(40) NOT NULL
);
ALTER TABLE "DUPLICATIONS_INDEX" ADD CONSTRAINT "PK_DUPLICATIONS_INDEX" PRIMARY KEY("UUID");
CREATE INDEX "DUPLICATIONS_INDEX_HASH" ON "DUPLICATIONS_INDEX"("HASH");
CREATE INDEX "DUPLICATION_ANALYSIS_COMPONENT" ON "DUPLICATIONS_INDEX"("ANALYSIS_UUID", "COMPONENT_UUID");

CREATE TABLE "ES_QUEUE"(
    "UUID" VARCHAR(40) NOT NULL,
    "DOC_TYPE" VARCHAR(40) NOT NULL,
    "DOC_ID" VARCHAR(4000) NOT NULL,
    "DOC_ID_TYPE" VARCHAR(20),
    "DOC_ROUTING" VARCHAR(4000),
    "CREATED_AT" BIGINT NOT NULL
);
ALTER TABLE "ES_QUEUE" ADD CONSTRAINT "PK_ES_QUEUE" PRIMARY KEY("UUID");
CREATE INDEX "ES_QUEUE_CREATED_AT" ON "ES_QUEUE"("CREATED_AT");

CREATE TABLE "EVENT_COMPONENT_CHANGES"(
    "UUID" VARCHAR(40) NOT NULL,
    "EVENT_UUID" VARCHAR(40) NOT NULL,
    "EVENT_COMPONENT_UUID" VARCHAR(50) NOT NULL,
    "EVENT_ANALYSIS_UUID" VARCHAR(50) NOT NULL,
    "CHANGE_CATEGORY" VARCHAR(12) NOT NULL,
    "COMPONENT_UUID" VARCHAR(50) NOT NULL,
    "COMPONENT_KEY" VARCHAR(400) NOT NULL,
    "COMPONENT_NAME" VARCHAR(2000) NOT NULL,
    "COMPONENT_BRANCH_KEY" VARCHAR(255),
    "CREATED_AT" BIGINT NOT NULL
);
ALTER TABLE "EVENT_COMPONENT_CHANGES" ADD CONSTRAINT "PK_EVENT_COMPONENT_CHANGES" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "EVENT_COMPONENT_CHANGES_UNIQUE" ON "EVENT_COMPONENT_CHANGES"("EVENT_UUID", "CHANGE_CATEGORY", "COMPONENT_UUID");
CREATE INDEX "EVENT_CPNT_CHANGES_CPNT" ON "EVENT_COMPONENT_CHANGES"("EVENT_COMPONENT_UUID");
CREATE INDEX "EVENT_CPNT_CHANGES_ANALYSIS" ON "EVENT_COMPONENT_CHANGES"("EVENT_ANALYSIS_UUID");

CREATE TABLE "EVENTS"(
    "UUID" VARCHAR(40) NOT NULL,
    "ANALYSIS_UUID" VARCHAR(50) NOT NULL,
    "NAME" VARCHAR(400),
    "CATEGORY" VARCHAR(50),
    "DESCRIPTION" VARCHAR(4000),
    "EVENT_DATA" VARCHAR(4000),
    "EVENT_DATE" BIGINT NOT NULL,
    "CREATED_AT" BIGINT NOT NULL,
    "COMPONENT_UUID" VARCHAR(50) NOT NULL
);
ALTER TABLE "EVENTS" ADD CONSTRAINT "PK_EVENTS" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "EVENTS_UUID" ON "EVENTS"("UUID");
CREATE INDEX "EVENTS_ANALYSIS" ON "EVENTS"("ANALYSIS_UUID");
CREATE INDEX "EVENTS_COMPONENT_UUID" ON "EVENTS"("COMPONENT_UUID");

CREATE TABLE "FILE_SOURCES"(
    "PROJECT_UUID" VARCHAR(50) NOT NULL,
    "FILE_UUID" VARCHAR(50) NOT NULL,
    "LINE_HASHES" CLOB,
    "LINE_HASHES_VERSION" INTEGER,
    "DATA_HASH" VARCHAR(50),
    "SRC_HASH" VARCHAR(50),
    "REVISION" VARCHAR(100),
    "LINE_COUNT" INTEGER NOT NULL,
    "BINARY_DATA" BLOB,
    "CREATED_AT" BIGINT NOT NULL,
    "UPDATED_AT" BIGINT NOT NULL,
    "UUID" VARCHAR(40) NOT NULL
);
ALTER TABLE "FILE_SOURCES" ADD CONSTRAINT "PK_FILE_SOURCES" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "FILE_SOURCES_FILE_UUID" ON "FILE_SOURCES"("FILE_UUID");
CREATE INDEX "FILE_SOURCES_PROJECT_UUID" ON "FILE_SOURCES"("PROJECT_UUID");
CREATE INDEX "FILE_SOURCES_UPDATED_AT" ON "FILE_SOURCES"("UPDATED_AT");

CREATE TABLE "GROUP_ROLES"(
    "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
    "ROLE" VARCHAR(64) NOT NULL,
    "COMPONENT_UUID" VARCHAR(40),
    "UUID" VARCHAR(40) NOT NULL,
    "GROUP_UUID" VARCHAR(40)
);
ALTER TABLE "GROUP_ROLES" ADD CONSTRAINT "PK_GROUP_ROLES" PRIMARY KEY("UUID");
CREATE INDEX "GROUP_ROLES_COMPONENT_UUID" ON "GROUP_ROLES"("COMPONENT_UUID");
CREATE UNIQUE INDEX "UNIQ_GROUP_ROLES" ON "GROUP_ROLES"("ORGANIZATION_UUID", "GROUP_UUID", "COMPONENT_UUID", "ROLE");

CREATE TABLE "GROUPS"(
    "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
    "NAME" VARCHAR(500),
    "DESCRIPTION" VARCHAR(200),
    "CREATED_AT" TIMESTAMP,
    "UPDATED_AT" TIMESTAMP,
    "UUID" VARCHAR(40) NOT NULL
);
ALTER TABLE "GROUPS" ADD CONSTRAINT "PK_GROUPS" PRIMARY KEY("UUID");

CREATE TABLE "GROUPS_USERS"(
    "GROUP_UUID" VARCHAR(40) NOT NULL,
    "USER_UUID" VARCHAR(255) NOT NULL
);
CREATE INDEX "INDEX_GROUPS_USERS_GROUP_UUID" ON "GROUPS_USERS"("GROUP_UUID");
CREATE INDEX "INDEX_GROUPS_USERS_USER_UUID" ON "GROUPS_USERS"("USER_UUID");
CREATE UNIQUE INDEX "GROUPS_USERS_UNIQUE" ON "GROUPS_USERS"("USER_UUID", "GROUP_UUID");

CREATE TABLE "INTERNAL_COMPONENT_PROPS"(
    "UUID" VARCHAR(40) NOT NULL,
    "COMPONENT_UUID" VARCHAR(50) NOT NULL,
    "KEE" VARCHAR(512) NOT NULL,
    "VALUE" VARCHAR(4000),
    "UPDATED_AT" BIGINT NOT NULL,
    "CREATED_AT" BIGINT NOT NULL
);
ALTER TABLE "INTERNAL_COMPONENT_PROPS" ADD CONSTRAINT "PK_INTERNAL_COMPONENT_PROPS" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "UNIQUE_COMPONENT_UUID_KEE" ON "INTERNAL_COMPONENT_PROPS"("COMPONENT_UUID", "KEE");

CREATE TABLE "INTERNAL_PROPERTIES"(
    "KEE" VARCHAR(20) NOT NULL,
    "IS_EMPTY" BOOLEAN NOT NULL,
    "TEXT_VALUE" VARCHAR(4000),
    "CLOB_VALUE" CLOB,
    "CREATED_AT" BIGINT NOT NULL
);
ALTER TABLE "INTERNAL_PROPERTIES" ADD CONSTRAINT "PK_INTERNAL_PROPERTIES" PRIMARY KEY("KEE");

CREATE TABLE "ISSUE_CHANGES"(
    "UUID" VARCHAR(40) NOT NULL,
    "KEE" VARCHAR(50),
    "ISSUE_KEY" VARCHAR(50) NOT NULL,
    "USER_LOGIN" VARCHAR(255),
    "CHANGE_TYPE" VARCHAR(20),
    "CHANGE_DATA" CLOB,
    "CREATED_AT" BIGINT,
    "UPDATED_AT" BIGINT,
    "ISSUE_CHANGE_CREATION_DATE" BIGINT,
    "PROJECT_UUID" VARCHAR(50) NOT NULL
);
ALTER TABLE "ISSUE_CHANGES" ADD CONSTRAINT "PK_ISSUE_CHANGES" PRIMARY KEY("UUID");
CREATE INDEX "ISSUE_CHANGES_ISSUE_KEY" ON "ISSUE_CHANGES"("ISSUE_KEY");
CREATE INDEX "ISSUE_CHANGES_KEE" ON "ISSUE_CHANGES"("KEE");
CREATE INDEX "ISSUE_CHANGES_PROJECT_UUID" ON "ISSUE_CHANGES"("PROJECT_UUID");

CREATE TABLE "ISSUES"(
    "KEE" VARCHAR(50) NOT NULL,
    "RULE_UUID" VARCHAR(40),
    "SEVERITY" VARCHAR(10),
    "MANUAL_SEVERITY" BOOLEAN NOT NULL,
    "MESSAGE" VARCHAR(4000),
    "LINE" INTEGER,
    "GAP" DOUBLE,
    "STATUS" VARCHAR(20),
    "RESOLUTION" VARCHAR(20),
    "CHECKSUM" VARCHAR(1000),
    "REPORTER" VARCHAR(255),
    "ASSIGNEE" VARCHAR(255),
    "AUTHOR_LOGIN" VARCHAR(255),
    "ACTION_PLAN_KEY" VARCHAR(50),
    "ISSUE_ATTRIBUTES" VARCHAR(4000),
    "EFFORT" INTEGER,
    "CREATED_AT" BIGINT,
    "UPDATED_AT" BIGINT,
    "ISSUE_CREATION_DATE" BIGINT,
    "ISSUE_UPDATE_DATE" BIGINT,
    "ISSUE_CLOSE_DATE" BIGINT,
    "TAGS" VARCHAR(4000),
    "COMPONENT_UUID" VARCHAR(50),
    "PROJECT_UUID" VARCHAR(50),
    "LOCATIONS" BLOB,
    "ISSUE_TYPE" TINYINT,
    "FROM_HOTSPOT" BOOLEAN
);
ALTER TABLE "ISSUES" ADD CONSTRAINT "PK_ISSUES" PRIMARY KEY("KEE");
CREATE INDEX "ISSUES_ASSIGNEE" ON "ISSUES"("ASSIGNEE");
CREATE INDEX "ISSUES_COMPONENT_UUID" ON "ISSUES"("COMPONENT_UUID");
CREATE INDEX "ISSUES_CREATION_DATE" ON "ISSUES"("ISSUE_CREATION_DATE");
CREATE UNIQUE INDEX "ISSUES_KEE" ON "ISSUES"("KEE");
CREATE INDEX "ISSUES_PROJECT_UUID" ON "ISSUES"("PROJECT_UUID");
CREATE INDEX "ISSUES_RESOLUTION" ON "ISSUES"("RESOLUTION");
CREATE INDEX "ISSUES_UPDATED_AT" ON "ISSUES"("UPDATED_AT");
CREATE INDEX "ISSUES_RULE_UUID" ON "ISSUES"("RULE_UUID");

CREATE TABLE "LIVE_MEASURES"(
    "UUID" VARCHAR(40) NOT NULL,
    "PROJECT_UUID" VARCHAR(50) NOT NULL,
    "COMPONENT_UUID" VARCHAR(50) NOT NULL,
    "METRIC_UUID" VARCHAR(40) NOT NULL,
    "VALUE" DOUBLE,
    "TEXT_VALUE" VARCHAR(4000),
    "VARIATION" DOUBLE,
    "MEASURE_DATA" BLOB,
    "UPDATE_MARKER" VARCHAR(40),
    "CREATED_AT" BIGINT NOT NULL,
    "UPDATED_AT" BIGINT NOT NULL
);
ALTER TABLE "LIVE_MEASURES" ADD CONSTRAINT "PK_LIVE_MEASURES" PRIMARY KEY("UUID");
CREATE INDEX "LIVE_MEASURES_PROJECT" ON "LIVE_MEASURES"("PROJECT_UUID");
CREATE UNIQUE INDEX "LIVE_MEASURES_COMPONENT" ON "LIVE_MEASURES"("COMPONENT_UUID", "METRIC_UUID");

CREATE TABLE "MANUAL_MEASURES"(
    "VALUE" DOUBLE,
    "TEXT_VALUE" VARCHAR(4000),
    "USER_UUID" VARCHAR(255),
    "DESCRIPTION" VARCHAR(4000),
    "CREATED_AT" BIGINT,
    "UPDATED_AT" BIGINT,
    "COMPONENT_UUID" VARCHAR(50) NOT NULL,
    "UUID" VARCHAR(40) NOT NULL,
    "METRIC_UUID" VARCHAR(40) NOT NULL
);
ALTER TABLE "MANUAL_MEASURES" ADD CONSTRAINT "PK_MANUAL_MEASURES" PRIMARY KEY("UUID");
CREATE INDEX "MANUAL_MEASURES_COMPONENT_UUID" ON "MANUAL_MEASURES"("COMPONENT_UUID");

CREATE TABLE "METRICS"(
    "NAME" VARCHAR(64) NOT NULL,
    "DESCRIPTION" VARCHAR(255),
    "DIRECTION" INTEGER DEFAULT 0 NOT NULL,
    "DOMAIN" VARCHAR(64),
    "SHORT_NAME" VARCHAR(64),
    "QUALITATIVE" BOOLEAN DEFAULT FALSE NOT NULL,
    "VAL_TYPE" VARCHAR(8),
    "USER_MANAGED" BOOLEAN DEFAULT FALSE,
    "ENABLED" BOOLEAN DEFAULT TRUE,
    "WORST_VALUE" DOUBLE,
    "BEST_VALUE" DOUBLE,
    "OPTIMIZED_BEST_VALUE" BOOLEAN,
    "HIDDEN" BOOLEAN,
    "DELETE_HISTORICAL_DATA" BOOLEAN,
    "DECIMAL_SCALE" INTEGER,
    "UUID" VARCHAR(40) NOT NULL
);
ALTER TABLE "METRICS" ADD CONSTRAINT "PK_METRICS" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "METRICS_UNIQUE_NAME" ON "METRICS"("NAME");

CREATE TABLE "NEW_CODE_PERIODS"(
    "UUID" VARCHAR(40) NOT NULL,
    "PROJECT_UUID" VARCHAR(40),
    "BRANCH_UUID" VARCHAR(40),
    "TYPE" VARCHAR(30) NOT NULL,
    "VALUE" VARCHAR(40),
    "UPDATED_AT" BIGINT NOT NULL,
    "CREATED_AT" BIGINT NOT NULL
);
ALTER TABLE "NEW_CODE_PERIODS" ADD CONSTRAINT "PK_NEW_CODE_PERIODS" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "UNIQ_NEW_CODE_PERIODS" ON "NEW_CODE_PERIODS"("PROJECT_UUID", "BRANCH_UUID");

CREATE TABLE "NOTIFICATIONS"(
    "DATA" BLOB,
    "UUID" VARCHAR(40) NOT NULL,
    "CREATED_AT" BIGINT NOT NULL
);
ALTER TABLE "NOTIFICATIONS" ADD CONSTRAINT "PK_NOTIFICATIONS" PRIMARY KEY("UUID");

CREATE TABLE "ORG_QPROFILES"(
    "UUID" VARCHAR(255) NOT NULL,
    "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
    "RULES_PROFILE_UUID" VARCHAR(255) NOT NULL,
    "PARENT_UUID" VARCHAR(255),
    "LAST_USED" BIGINT,
    "USER_UPDATED_AT" BIGINT,
    "CREATED_AT" BIGINT NOT NULL,
    "UPDATED_AT" BIGINT NOT NULL
);
ALTER TABLE "ORG_QPROFILES" ADD CONSTRAINT "PK_ORG_QPROFILES" PRIMARY KEY("UUID");
CREATE INDEX "QPROFILES_ORG_UUID" ON "ORG_QPROFILES"("ORGANIZATION_UUID");
CREATE INDEX "QPROFILES_RP_UUID" ON "ORG_QPROFILES"("RULES_PROFILE_UUID");
CREATE INDEX "ORG_QPROFILES_PARENT_UUID" ON "ORG_QPROFILES"("PARENT_UUID");

CREATE TABLE "ORG_QUALITY_GATES"(
    "UUID" VARCHAR(40) NOT NULL,
    "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
    "QUALITY_GATE_UUID" VARCHAR(40) NOT NULL
);
ALTER TABLE "ORG_QUALITY_GATES" ADD CONSTRAINT "PK_ORG_QUALITY_GATES" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "UNIQ_ORG_QUALITY_GATES" ON "ORG_QUALITY_GATES"("ORGANIZATION_UUID", "QUALITY_GATE_UUID");

CREATE TABLE "ORGANIZATION_ALM_BINDINGS"(
    "UUID" VARCHAR(40) NOT NULL,
    "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
    "ALM_APP_INSTALL_UUID" VARCHAR(40) NOT NULL,
    "ALM_ID" VARCHAR(40) NOT NULL,
    "URL" VARCHAR(2000) NOT NULL,
    "USER_UUID" VARCHAR(255) NOT NULL,
    "MEMBERS_SYNC_ENABLED" BOOLEAN,
    "CREATED_AT" BIGINT NOT NULL
);
ALTER TABLE "ORGANIZATION_ALM_BINDINGS" ADD CONSTRAINT "PK_ORGANIZATION_ALM_BINDINGS" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "ORG_ALM_BINDINGS_ORG" ON "ORGANIZATION_ALM_BINDINGS"("ORGANIZATION_UUID");
CREATE UNIQUE INDEX "ORG_ALM_BINDINGS_INSTALL" ON "ORGANIZATION_ALM_BINDINGS"("ALM_APP_INSTALL_UUID");

CREATE TABLE "ORGANIZATION_MEMBERS"(
    "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
    "USER_UUID" VARCHAR(255) NOT NULL
);
ALTER TABLE "ORGANIZATION_MEMBERS" ADD CONSTRAINT "PK_ORGANIZATION_MEMBERS" PRIMARY KEY("USER_UUID", "ORGANIZATION_UUID");
CREATE INDEX "ORG_MEMBERS_USER_UUID" ON "ORGANIZATION_MEMBERS"("USER_UUID");

CREATE TABLE "ORGANIZATIONS"(
    "UUID" VARCHAR(40) NOT NULL,
    "KEE" VARCHAR(255) NOT NULL,
    "NAME" VARCHAR(255) NOT NULL,
    "DESCRIPTION" VARCHAR(256),
    "URL" VARCHAR(256),
    "AVATAR_URL" VARCHAR(256),
    "GUARDED" BOOLEAN,
    "DEFAULT_QUALITY_GATE_UUID" VARCHAR(40) NOT NULL,
    "DEFAULT_PERM_TEMPLATE_PROJECT" VARCHAR(40),
    "DEFAULT_PERM_TEMPLATE_APP" VARCHAR(40),
    "DEFAULT_PERM_TEMPLATE_PORT" VARCHAR(40),
    "NEW_PROJECT_PRIVATE" BOOLEAN NOT NULL,
    "SUBSCRIPTION" VARCHAR(40) NOT NULL,
    "CREATED_AT" BIGINT NOT NULL,
    "UPDATED_AT" BIGINT NOT NULL,
    "DEFAULT_GROUP_UUID" VARCHAR(40)
);
ALTER TABLE "ORGANIZATIONS" ADD CONSTRAINT "PK_ORGANIZATIONS" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "ORGANIZATION_KEY" ON "ORGANIZATIONS"("KEE");

CREATE TABLE "PERM_TEMPLATES_GROUPS"(
    "PERMISSION_REFERENCE" VARCHAR(64) NOT NULL,
    "CREATED_AT" TIMESTAMP,
    "UPDATED_AT" TIMESTAMP,
    "UUID" VARCHAR(40) NOT NULL,
    "TEMPLATE_UUID" VARCHAR(40) NOT NULL,
    "GROUP_UUID" VARCHAR(40)
);
ALTER TABLE "PERM_TEMPLATES_GROUPS" ADD CONSTRAINT "PK_PERM_TEMPLATES_GROUPS" PRIMARY KEY("UUID");

CREATE TABLE "PERM_TEMPLATES_USERS"(
    "PERMISSION_REFERENCE" VARCHAR(64) NOT NULL,
    "CREATED_AT" TIMESTAMP,
    "UPDATED_AT" TIMESTAMP,
    "UUID" VARCHAR(40) NOT NULL,
    "TEMPLATE_UUID" VARCHAR(40) NOT NULL,
    "USER_UUID" VARCHAR(255) NOT NULL
);
ALTER TABLE "PERM_TEMPLATES_USERS" ADD CONSTRAINT "PK_PERM_TEMPLATES_USERS" PRIMARY KEY("UUID");

CREATE TABLE "PERM_TPL_CHARACTERISTICS"(
    "PERMISSION_KEY" VARCHAR(64) NOT NULL,
    "WITH_PROJECT_CREATOR" BOOLEAN DEFAULT FALSE NOT NULL,
    "CREATED_AT" BIGINT NOT NULL,
    "UPDATED_AT" BIGINT NOT NULL,
    "UUID" VARCHAR(40) NOT NULL,
    "TEMPLATE_UUID" VARCHAR(40) NOT NULL
);
ALTER TABLE "PERM_TPL_CHARACTERISTICS" ADD CONSTRAINT "PK_PERM_TPL_CHARACTERISTICS" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "UNIQ_PERM_TPL_CHARAC" ON "PERM_TPL_CHARACTERISTICS"("TEMPLATE_UUID", "PERMISSION_KEY");

CREATE TABLE "PERMISSION_TEMPLATES"(
    "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
    "NAME" VARCHAR(100) NOT NULL,
    "DESCRIPTION" VARCHAR(4000),
    "CREATED_AT" TIMESTAMP,
    "UPDATED_AT" TIMESTAMP,
    "KEY_PATTERN" VARCHAR(500),
    "UUID" VARCHAR(40) NOT NULL
);
ALTER TABLE "PERMISSION_TEMPLATES" ADD CONSTRAINT "PK_PERMISSION_TEMPLATES" PRIMARY KEY("UUID");

CREATE TABLE "PLUGINS"(
    "UUID" VARCHAR(40) NOT NULL,
    "KEE" VARCHAR(200) NOT NULL,
    "BASE_PLUGIN_KEY" VARCHAR(200),
    "FILE_HASH" VARCHAR(200) NOT NULL,
    "CREATED_AT" BIGINT NOT NULL,
    "UPDATED_AT" BIGINT NOT NULL,
    "TYPE" VARCHAR(10) NOT NULL
);
ALTER TABLE "PLUGINS" ADD CONSTRAINT "PK_PLUGINS" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "PLUGINS_KEY" ON "PLUGINS"("KEE");

CREATE TABLE "PROJECT_ALM_SETTINGS"(
    "UUID" VARCHAR(40) NOT NULL,
    "ALM_SETTING_UUID" VARCHAR(40) NOT NULL,
    "PROJECT_UUID" VARCHAR(50) NOT NULL,
    "ALM_REPO" VARCHAR(256),
    "ALM_SLUG" VARCHAR(256),
    "UPDATED_AT" BIGINT NOT NULL,
    "CREATED_AT" BIGINT NOT NULL,
    "SUMMARY_COMMENT_ENABLED" BOOLEAN
);
ALTER TABLE "PROJECT_ALM_SETTINGS" ADD CONSTRAINT "PK_PROJECT_ALM_SETTINGS" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "UNIQ_PROJECT_ALM_SETTINGS" ON "PROJECT_ALM_SETTINGS"("PROJECT_UUID");
CREATE INDEX "PROJECT_ALM_SETTINGS_ALM" ON "PROJECT_ALM_SETTINGS"("ALM_SETTING_UUID");
CREATE INDEX "PROJECT_ALM_SETTINGS_SLUG" ON "PROJECT_ALM_SETTINGS"("ALM_SLUG");

CREATE TABLE "PROJECT_BRANCHES"(
    "UUID" VARCHAR(50) NOT NULL,
    "PROJECT_UUID" VARCHAR(50) NOT NULL,
    "KEE" VARCHAR(255) NOT NULL,
    "BRANCH_TYPE" VARCHAR(12),
    "MERGE_BRANCH_UUID" VARCHAR(50),
    "KEY_TYPE" VARCHAR(12) NOT NULL,
    "PULL_REQUEST_BINARY" BLOB,
    "MANUAL_BASELINE_ANALYSIS_UUID" VARCHAR(40),
    "CREATED_AT" BIGINT NOT NULL,
    "UPDATED_AT" BIGINT NOT NULL,
    "EXCLUDE_FROM_PURGE" BOOLEAN DEFAULT FALSE NOT NULL,
    "NEED_ISSUE_SYNC" BOOLEAN NOT NULL
);
ALTER TABLE "PROJECT_BRANCHES" ADD CONSTRAINT "PK_PROJECT_BRANCHES" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "PROJECT_BRANCHES_KEE_KEY_TYPE" ON "PROJECT_BRANCHES"("PROJECT_UUID", "KEE", "KEY_TYPE");

CREATE TABLE "PROJECT_LINKS"(
    "UUID" VARCHAR(40) NOT NULL,
    "PROJECT_UUID" VARCHAR(40) NOT NULL,
    "LINK_TYPE" VARCHAR(20) NOT NULL,
    "NAME" VARCHAR(128),
    "HREF" VARCHAR(2048) NOT NULL,
    "CREATED_AT" BIGINT NOT NULL,
    "UPDATED_AT" BIGINT NOT NULL
);
ALTER TABLE "PROJECT_LINKS" ADD CONSTRAINT "PK_PROJECT_LINKS" PRIMARY KEY("UUID");
CREATE INDEX "PROJECT_LINKS_PROJECT" ON "PROJECT_LINKS"("PROJECT_UUID");

CREATE TABLE "PROJECT_MAPPINGS"(
    "UUID" VARCHAR(40) NOT NULL,
    "KEY_TYPE" VARCHAR(200) NOT NULL,
    "KEE" VARCHAR(4000) NOT NULL,
    "PROJECT_UUID" VARCHAR(40) NOT NULL,
    "CREATED_AT" BIGINT NOT NULL
);
ALTER TABLE "PROJECT_MAPPINGS" ADD CONSTRAINT "PK_PROJECT_MAPPINGS" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "KEY_TYPE_KEE" ON "PROJECT_MAPPINGS"("KEY_TYPE", "KEE");
CREATE INDEX "PROJECT_UUID" ON "PROJECT_MAPPINGS"("PROJECT_UUID");

CREATE TABLE "PROJECT_MEASURES"(
    "VALUE" DOUBLE,
    "ANALYSIS_UUID" VARCHAR(50) NOT NULL,
    "COMPONENT_UUID" VARCHAR(50) NOT NULL,
    "TEXT_VALUE" VARCHAR(4000),
    "ALERT_STATUS" VARCHAR(5),
    "ALERT_TEXT" VARCHAR(4000),
    "DESCRIPTION" VARCHAR(4000),
    "PERSON_ID" INTEGER,
    "VARIATION_VALUE_1" DOUBLE,
    "MEASURE_DATA" BLOB,
    "UUID" VARCHAR(40) NOT NULL,
    "METRIC_UUID" VARCHAR(40) NOT NULL
);
ALTER TABLE "PROJECT_MEASURES" ADD CONSTRAINT "PK_PROJECT_MEASURES" PRIMARY KEY("UUID");
CREATE INDEX "MEASURES_COMPONENT_UUID" ON "PROJECT_MEASURES"("COMPONENT_UUID");
CREATE INDEX "MEASURES_ANALYSIS_METRIC" ON "PROJECT_MEASURES"("ANALYSIS_UUID", "METRIC_UUID");

CREATE TABLE "PROJECT_QGATES"(
    "PROJECT_UUID" VARCHAR(40) NOT NULL,
    "QUALITY_GATE_UUID" VARCHAR(40) NOT NULL
);
ALTER TABLE "PROJECT_QGATES" ADD CONSTRAINT "PK_PROJECT_QGATES" PRIMARY KEY("PROJECT_UUID");
CREATE UNIQUE INDEX "UNIQ_PROJECT_QGATES" ON "PROJECT_QGATES"("PROJECT_UUID", "QUALITY_GATE_UUID");

CREATE TABLE "PROJECT_QPROFILES"(
    "PROJECT_UUID" VARCHAR(50) NOT NULL,
    "PROFILE_KEY" VARCHAR(50) NOT NULL,
    "UUID" VARCHAR(40) NOT NULL
);
ALTER TABLE "PROJECT_QPROFILES" ADD CONSTRAINT "PK_PROJECT_QPROFILES" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "UNIQ_PROJECT_QPROFILES" ON "PROJECT_QPROFILES"("PROJECT_UUID", "PROFILE_KEY");

CREATE TABLE "PROJECTS"(
    "UUID" VARCHAR(40) NOT NULL,
    "KEE" VARCHAR(400) NOT NULL,
    "QUALIFIER" VARCHAR(10) NOT NULL,
    "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
    "NAME" VARCHAR(2000),
    "DESCRIPTION" VARCHAR(2000),
    "PRIVATE" BOOLEAN NOT NULL,
    "TAGS" VARCHAR(500),
    "CREATED_AT" BIGINT,
    "UPDATED_AT" BIGINT NOT NULL
);
ALTER TABLE "PROJECTS" ADD CONSTRAINT "PK_NEW_PROJECTS" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "UNIQ_PROJECTS_KEE" ON "PROJECTS"("KEE");
CREATE INDEX "IDX_QUALIFIER" ON "PROJECTS"("QUALIFIER");

CREATE TABLE "PROPERTIES"(
    "PROP_KEY" VARCHAR(512) NOT NULL,
    "IS_EMPTY" BOOLEAN NOT NULL,
    "TEXT_VALUE" VARCHAR(4000),
    "CLOB_VALUE" CLOB,
    "CREATED_AT" BIGINT NOT NULL,
    "COMPONENT_UUID" VARCHAR(40),
    "UUID" VARCHAR(40) NOT NULL,
    "USER_UUID" VARCHAR(255)
);
ALTER TABLE "PROPERTIES" ADD CONSTRAINT "PK_PROPERTIES" PRIMARY KEY("UUID");
CREATE INDEX "PROPERTIES_KEY" ON "PROPERTIES"("PROP_KEY");

CREATE TABLE "QPROFILE_CHANGES"(
    "KEE" VARCHAR(40) NOT NULL,
    "RULES_PROFILE_UUID" VARCHAR(255) NOT NULL,
    "CHANGE_TYPE" VARCHAR(20) NOT NULL,
    "USER_UUID" VARCHAR(255),
    "CHANGE_DATA" CLOB,
    "CREATED_AT" BIGINT NOT NULL
);
ALTER TABLE "QPROFILE_CHANGES" ADD CONSTRAINT "PK_QPROFILE_CHANGES" PRIMARY KEY("KEE");
CREATE INDEX "QP_CHANGES_RULES_PROFILE_UUID" ON "QPROFILE_CHANGES"("RULES_PROFILE_UUID");

CREATE TABLE "QPROFILE_EDIT_GROUPS"(
    "UUID" VARCHAR(40) NOT NULL,
    "QPROFILE_UUID" VARCHAR(255) NOT NULL,
    "CREATED_AT" BIGINT NOT NULL,
    "GROUP_UUID" VARCHAR(40) NOT NULL
);
ALTER TABLE "QPROFILE_EDIT_GROUPS" ADD CONSTRAINT "PK_QPROFILE_EDIT_GROUPS" PRIMARY KEY("UUID");
CREATE INDEX "QPROFILE_EDIT_GROUPS_QPROFILE" ON "QPROFILE_EDIT_GROUPS"("QPROFILE_UUID");
CREATE UNIQUE INDEX "QPROFILE_EDIT_GROUPS_UNIQUE" ON "QPROFILE_EDIT_GROUPS"("GROUP_UUID", "QPROFILE_UUID");

CREATE TABLE "QPROFILE_EDIT_USERS"(
    "UUID" VARCHAR(40) NOT NULL,
    "QPROFILE_UUID" VARCHAR(255) NOT NULL,
    "CREATED_AT" BIGINT NOT NULL,
    "USER_UUID" VARCHAR(255) NOT NULL
);
ALTER TABLE "QPROFILE_EDIT_USERS" ADD CONSTRAINT "PK_QPROFILE_EDIT_USERS" PRIMARY KEY("UUID");
CREATE INDEX "QPROFILE_EDIT_USERS_QPROFILE" ON "QPROFILE_EDIT_USERS"("QPROFILE_UUID");
CREATE UNIQUE INDEX "QPROFILE_EDIT_USERS_UNIQUE" ON "QPROFILE_EDIT_USERS"("USER_UUID", "QPROFILE_UUID");

CREATE TABLE "QUALITY_GATE_CONDITIONS"(
    "OPERATOR" VARCHAR(3),
    "VALUE_ERROR" VARCHAR(64),
    "CREATED_AT" TIMESTAMP,
    "UPDATED_AT" TIMESTAMP,
    "UUID" VARCHAR(40) NOT NULL,
    "METRIC_UUID" VARCHAR(40) NOT NULL,
    "QGATE_UUID" VARCHAR(40) NOT NULL
);
ALTER TABLE "QUALITY_GATE_CONDITIONS" ADD CONSTRAINT "PK_QUALITY_GATE_CONDITIONS" PRIMARY KEY("UUID");

CREATE TABLE "QUALITY_GATES"(
    "UUID" VARCHAR(40) NOT NULL,
    "NAME" VARCHAR(100) NOT NULL,
    "IS_BUILT_IN" BOOLEAN NOT NULL,
    "CREATED_AT" TIMESTAMP,
    "UPDATED_AT" TIMESTAMP
);
ALTER TABLE "QUALITY_GATES" ADD CONSTRAINT "PK_QUALITY_GATES" PRIMARY KEY("UUID");

CREATE TABLE "RULE_REPOSITORIES"(
    "KEE" VARCHAR(200) NOT NULL,
    "LANGUAGE" VARCHAR(20) NOT NULL,
    "NAME" VARCHAR(4000) NOT NULL,
    "CREATED_AT" BIGINT NOT NULL
);
ALTER TABLE "RULE_REPOSITORIES" ADD CONSTRAINT "PK_RULE_REPOSITORIES" PRIMARY KEY("KEE");

CREATE TABLE "RULES"(
    "NAME" VARCHAR(200),
    "PLUGIN_RULE_KEY" VARCHAR(200) NOT NULL,
    "PLUGIN_KEY" VARCHAR(200),
    "PLUGIN_CONFIG_KEY" VARCHAR(200),
    "PLUGIN_NAME" VARCHAR(255) NOT NULL,
    "SCOPE" VARCHAR(20) NOT NULL,
    "DESCRIPTION" CLOB,
    "PRIORITY" INTEGER,
    "STATUS" VARCHAR(40),
    "LANGUAGE" VARCHAR(20),
    "DEF_REMEDIATION_FUNCTION" VARCHAR(20),
    "DEF_REMEDIATION_GAP_MULT" VARCHAR(20),
    "DEF_REMEDIATION_BASE_EFFORT" VARCHAR(20),
    "GAP_DESCRIPTION" VARCHAR(4000),
    "SYSTEM_TAGS" VARCHAR(4000),
    "IS_TEMPLATE" BOOLEAN DEFAULT FALSE NOT NULL,
    "DESCRIPTION_FORMAT" VARCHAR(20),
    "RULE_TYPE" TINYINT,
    "SECURITY_STANDARDS" VARCHAR(4000),
    "IS_AD_HOC" BOOLEAN NOT NULL,
    "IS_EXTERNAL" BOOLEAN NOT NULL,
    "CREATED_AT" BIGINT,
    "UPDATED_AT" BIGINT,
    "UUID" VARCHAR(40) NOT NULL,
    "TEMPLATE_UUID" VARCHAR(40)
);
ALTER TABLE "RULES" ADD CONSTRAINT "PK_RULES" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "RULES_REPO_KEY" ON "RULES"("PLUGIN_RULE_KEY", "PLUGIN_NAME");

CREATE TABLE "RULES_METADATA"(
    "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
    "NOTE_DATA" CLOB,
    "NOTE_USER_UUID" VARCHAR(255),
    "NOTE_CREATED_AT" BIGINT,
    "NOTE_UPDATED_AT" BIGINT,
    "REMEDIATION_FUNCTION" VARCHAR(20),
    "REMEDIATION_GAP_MULT" VARCHAR(20),
    "REMEDIATION_BASE_EFFORT" VARCHAR(20),
    "TAGS" VARCHAR(4000),
    "AD_HOC_NAME" VARCHAR(200),
    "AD_HOC_DESCRIPTION" CLOB,
    "AD_HOC_SEVERITY" VARCHAR(10),
    "AD_HOC_TYPE" TINYINT,
    "CREATED_AT" BIGINT NOT NULL,
    "UPDATED_AT" BIGINT NOT NULL,
    "RULE_UUID" VARCHAR(40) NOT NULL
);
ALTER TABLE "RULES_METADATA" ADD CONSTRAINT "PK_RULES_METADATA" PRIMARY KEY("RULE_UUID", "ORGANIZATION_UUID");

CREATE TABLE "RULES_PARAMETERS"(
    "NAME" VARCHAR(128) NOT NULL,
    "DESCRIPTION" VARCHAR(4000),
    "PARAM_TYPE" VARCHAR(512) NOT NULL,
    "DEFAULT_VALUE" VARCHAR(4000),
    "UUID" VARCHAR(40) NOT NULL,
    "RULE_UUID" VARCHAR(40) NOT NULL
);
ALTER TABLE "RULES_PARAMETERS" ADD CONSTRAINT "PK_RULES_PARAMETERS" PRIMARY KEY("UUID");
CREATE INDEX "RULES_PARAMETERS_RULE_UUID" ON "RULES_PARAMETERS"("RULE_UUID");
CREATE UNIQUE INDEX "RULES_PARAMETERS_UNIQUE" ON "RULES_PARAMETERS"("RULE_UUID", "NAME");

CREATE TABLE "RULES_PROFILES"(
    "NAME" VARCHAR(100) NOT NULL,
    "LANGUAGE" VARCHAR(20),
    "IS_BUILT_IN" BOOLEAN NOT NULL,
    "RULES_UPDATED_AT" VARCHAR(100),
    "CREATED_AT" TIMESTAMP,
    "UPDATED_AT" TIMESTAMP,
    "UUID" VARCHAR(40) NOT NULL
);
ALTER TABLE "RULES_PROFILES" ADD CONSTRAINT "PK_RULES_PROFILES" PRIMARY KEY("UUID");

CREATE TABLE "SAML_MESSAGE_IDS"(
    "UUID" VARCHAR(40) NOT NULL,
    "MESSAGE_ID" VARCHAR(255) NOT NULL,
    "EXPIRATION_DATE" BIGINT NOT NULL,
    "CREATED_AT" BIGINT NOT NULL
);
ALTER TABLE "SAML_MESSAGE_IDS" ADD CONSTRAINT "PK_SAML_MESSAGE_IDS" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "SAML_MESSAGE_IDS_UNIQUE" ON "SAML_MESSAGE_IDS"("MESSAGE_ID");

CREATE TABLE "SESSION_TOKENS"(
    "UUID" VARCHAR(40) NOT NULL,
    "USER_UUID" VARCHAR(255) NOT NULL,
    "EXPIRATION_DATE" BIGINT NOT NULL,
    "CREATED_AT" BIGINT NOT NULL,
    "UPDATED_AT" BIGINT NOT NULL
);
ALTER TABLE "SESSION_TOKENS" ADD CONSTRAINT "PK_SESSION_TOKENS" PRIMARY KEY("UUID");
CREATE INDEX "SESSION_TOKENS_USER_UUID" ON "SESSION_TOKENS"("USER_UUID");

CREATE TABLE "SNAPSHOTS"(
    "UUID" VARCHAR(50) NOT NULL,
    "COMPONENT_UUID" VARCHAR(50) NOT NULL,
    "STATUS" VARCHAR(4) DEFAULT 'U' NOT NULL,
    "ISLAST" BOOLEAN DEFAULT FALSE NOT NULL,
    "VERSION" VARCHAR(500),
    "PURGE_STATUS" INTEGER,
    "BUILD_STRING" VARCHAR(100),
    "REVISION" VARCHAR(100),
    "BUILD_DATE" BIGINT,
    "PERIOD1_MODE" VARCHAR(100),
    "PERIOD1_PARAM" VARCHAR(100),
    "PERIOD1_DATE" BIGINT,
    "CREATED_AT" BIGINT
);
ALTER TABLE "SNAPSHOTS" ADD CONSTRAINT "PK_SNAPSHOTS" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "ANALYSES_UUID" ON "SNAPSHOTS"("UUID");
CREATE INDEX "SNAPSHOT_COMPONENT" ON "SNAPSHOTS"("COMPONENT_UUID");

CREATE TABLE "USER_PROPERTIES"(
    "UUID" VARCHAR(40) NOT NULL,
    "USER_UUID" VARCHAR(255) NOT NULL,
    "KEE" VARCHAR(100) NOT NULL,
    "TEXT_VALUE" VARCHAR(4000) NOT NULL,
    "CREATED_AT" BIGINT NOT NULL,
    "UPDATED_AT" BIGINT NOT NULL
);
ALTER TABLE "USER_PROPERTIES" ADD CONSTRAINT "PK_USER_PROPERTIES" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "USER_PROPERTIES_USER_UUID_KEE" ON "USER_PROPERTIES"("USER_UUID", "KEE");

CREATE TABLE "USER_ROLES"(
    "ORGANIZATION_UUID" VARCHAR(40) NOT NULL,
    "ROLE" VARCHAR(64) NOT NULL,
    "COMPONENT_UUID" VARCHAR(40),
    "UUID" VARCHAR(40) NOT NULL,
    "USER_UUID" VARCHAR(255)
);
ALTER TABLE "USER_ROLES" ADD CONSTRAINT "PK_USER_ROLES" PRIMARY KEY("UUID");
CREATE INDEX "USER_ROLES_COMPONENT_UUID" ON "USER_ROLES"("COMPONENT_UUID");
CREATE INDEX "USER_ROLES_USER" ON "USER_ROLES"("USER_UUID");

CREATE TABLE "USER_TOKENS"(
    "USER_UUID" VARCHAR(255) NOT NULL,
    "NAME" VARCHAR(100) NOT NULL,
    "TOKEN_HASH" VARCHAR(255) NOT NULL,
    "LAST_CONNECTION_DATE" BIGINT,
    "CREATED_AT" BIGINT NOT NULL,
    "UUID" VARCHAR(40) NOT NULL
);
ALTER TABLE "USER_TOKENS" ADD CONSTRAINT "PK_USER_TOKENS" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "USER_TOKENS_USER_UUID_NAME" ON "USER_TOKENS"("USER_UUID", "NAME");
CREATE UNIQUE INDEX "USER_TOKENS_TOKEN_HASH" ON "USER_TOKENS"("TOKEN_HASH");

CREATE TABLE "USERS"(
    "UUID" VARCHAR(255) NOT NULL,
    "LOGIN" VARCHAR(255) NOT NULL,
    "ORGANIZATION_UUID" VARCHAR(40),
    "NAME" VARCHAR(200),
    "EMAIL" VARCHAR(100),
    "CRYPTED_PASSWORD" VARCHAR(100),
    "SALT" VARCHAR(40),
    "HASH_METHOD" VARCHAR(10),
    "ACTIVE" BOOLEAN DEFAULT TRUE,
    "SCM_ACCOUNTS" VARCHAR(4000),
    "EXTERNAL_LOGIN" VARCHAR(255) NOT NULL,
    "EXTERNAL_IDENTITY_PROVIDER" VARCHAR(100) NOT NULL,
    "EXTERNAL_ID" VARCHAR(255) NOT NULL,
    "IS_ROOT" BOOLEAN NOT NULL,
    "USER_LOCAL" BOOLEAN,
    "ONBOARDED" BOOLEAN NOT NULL,
    "HOMEPAGE_TYPE" VARCHAR(40),
    "HOMEPAGE_PARAMETER" VARCHAR(40),
    "LAST_CONNECTION_DATE" BIGINT,
    "CREATED_AT" BIGINT,
    "UPDATED_AT" BIGINT
);
ALTER TABLE "USERS" ADD CONSTRAINT "PK_USERS" PRIMARY KEY("UUID");
CREATE UNIQUE INDEX "USERS_LOGIN" ON "USERS"("LOGIN");
CREATE INDEX "USERS_UPDATED_AT" ON "USERS"("UPDATED_AT");
CREATE UNIQUE INDEX "UNIQ_EXTERNAL_ID" ON "USERS"("EXTERNAL_IDENTITY_PROVIDER", "EXTERNAL_ID");
CREATE UNIQUE INDEX "UNIQ_EXTERNAL_LOGIN" ON "USERS"("EXTERNAL_IDENTITY_PROVIDER", "EXTERNAL_LOGIN");

CREATE TABLE "WEBHOOK_DELIVERIES"(
    "UUID" VARCHAR(40) NOT NULL,
    "WEBHOOK_UUID" VARCHAR(40) NOT NULL,
    "COMPONENT_UUID" VARCHAR(40) NOT NULL,
    "CE_TASK_UUID" VARCHAR(40),
    "ANALYSIS_UUID" VARCHAR(40),
    "NAME" VARCHAR(100) NOT NULL,
    "URL" VARCHAR(2000) NOT NULL,
    "SUCCESS" BOOLEAN NOT NULL,
    "HTTP_STATUS" INTEGER,
    "DURATION_MS" BIGINT NOT NULL,
    "PAYLOAD" CLOB NOT NULL,
    "ERROR_STACKTRACE" CLOB,
    "CREATED_AT" BIGINT NOT NULL
);
ALTER TABLE "WEBHOOK_DELIVERIES" ADD CONSTRAINT "PK_WEBHOOK_DELIVERIES" PRIMARY KEY("UUID");
CREATE INDEX "COMPONENT_UUID" ON "WEBHOOK_DELIVERIES"("COMPONENT_UUID");
CREATE INDEX "CE_TASK_UUID" ON "WEBHOOK_DELIVERIES"("CE_TASK_UUID");

CREATE TABLE "WEBHOOKS"(
    "UUID" VARCHAR(40) NOT NULL,
    "ORGANIZATION_UUID" VARCHAR(40),
    "PROJECT_UUID" VARCHAR(40),
    "NAME" VARCHAR(100) NOT NULL,
    "URL" VARCHAR(2000) NOT NULL,
    "SECRET" VARCHAR(200),
    "CREATED_AT" BIGINT NOT NULL,
    "UPDATED_AT" BIGINT
);
ALTER TABLE "WEBHOOKS" ADD CONSTRAINT "PK_WEBHOOKS" PRIMARY KEY("UUID");
CREATE INDEX "ORGANIZATION_WEBHOOK" ON "WEBHOOKS"("ORGANIZATION_UUID");
CREATE INDEX "PROJECT_WEBHOOK" ON "WEBHOOKS"("PROJECT_UUID");
