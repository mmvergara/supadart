-- Cleanup Qeuries
DROP VIEW IF EXISTS public.combined_types_view;

DROP TABLE IF EXISTS public.numeric_types;
DROP TABLE IF EXISTS public.string_types;
DROP TABLE IF EXISTS public.datetime_types;
DROP TABLE IF EXISTS public.boolean_bit_types;
DROP TABLE IF EXISTS public.geometric_types;
DROP TABLE IF EXISTS public.network_types;
DROP TABLE IF EXISTS public.json_types;
DROP TABLE IF EXISTS public.binary_xml_types;
DROP TABLE IF EXISTS public.misc_types;

DROP TABLE IF EXISTS public.enum_types;
DROP TYPE IF EXISTS public.mood;

CREATE TABLE public.numeric_types (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    col_bigint BIGINT NULL,
    col_bigint_array BIGINT[] NULL,
    col_integer INTEGER NULL,
    col_integer_array INTEGER[] NULL,
    col_smallint SMALLINT NULL,
    col_smallint_array SMALLINT[] NULL,
    -- col_bigserial BIGSERIAL,
    -- col_bigserial_array BIGSERIAL[] NULL,
    -- col_smallserial SMALLSERIAL,
    -- col_smallserial_array SMALLSERIAL[] NULL,
    -- col_serial SERIAL,
    -- col_serial_array SERIAL[] NULL,
    col_double DOUBLE PRECISION NULL,
    col_double_array DOUBLE PRECISION[] NULL,
    col_real REAL NULL,
    col_real_array REAL[] NULL,
    col_numeric NUMERIC NULL,
    col_numeric_array NUMERIC[] NULL
);
-- for serial columns
-- COMMENT ON COLUMN public.numeric_types.col_bigserial IS '[supadart:serial]';
-- COMMENT ON COLUMN public.numeric_types.col_smallserial IS '[supadart:serial]';
-- COMMENT ON COLUMN public.numeric_types.col_serial IS '[supadart:serial]';


-- String Types Table
CREATE TABLE public.string_types (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    col_uuid UUID NULL,
    col_uuid_array UUID[] NULL,
    col_character CHARACTER(1) NULL,
    col_character_array CHARACTER(1)[] NULL,
    col_charactervarying CHARACTER VARYING NULL,
    col_charactervarying_array CHARACTER VARYING[] NULL,
    col_text TEXT NULL,
    col_text_array TEXT[] NULL
);

-- Date and Time Types Table
CREATE TABLE public.datetime_types (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    col_date DATE NULL,
    col_date_array DATE[] NULL,
    col_time TIME WITHOUT TIME ZONE NULL,
    col_time_array TIME WITHOUT TIME ZONE[] NULL,
    col_timetz TIME WITH TIME ZONE NULL,
    col_timetz_array TIME WITH TIME ZONE[] NULL,
    col_timestamp TIMESTAMP WITHOUT TIME ZONE NULL,
    col_timestamp_array TIMESTAMP WITHOUT TIME ZONE[] NULL,
    col_timestamptz TIMESTAMP WITH TIME ZONE NULL,
    col_timestamptz_array TIMESTAMP WITH TIME ZONE[] NULL,
    col_interval INTERVAL NULL,
    col_interval_array INTERVAL[] NULL
);

-- Boolean and Bit Types Table
CREATE TABLE public.boolean_bit_types (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    col_boolean BOOLEAN NULL,
    col_boolean_array BOOLEAN[] NULL,
    col_bit BIT(1) NULL,
    col_bit_array BIT(1)[] NULL,
    col_bitvarying BIT VARYING NULL,
    col_bitvarying_array BIT VARYING[] NULL
);

-- Geometric Types Table
CREATE TABLE public.geometric_types (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    col_point POINT NULL,
    col_point_array POINT[] NULL,
    col_line LINE NULL,
    col_line_array LINE[] NULL,
    col_lseg LSEG NULL,
    col_lseg_array LSEG[] NULL,
    col_box BOX NULL,
    col_box_array BOX[] NULL,
    col_path PATH NULL,
    col_path_array PATH[] NULL,
    col_polygon POLYGON NULL,
    col_polygon_array POLYGON[] NULL,
    col_circle CIRCLE NULL,
    col_circle_array CIRCLE[] NULL
);

-- Network Address Types Table
CREATE TABLE public.network_types (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    col_cidr CIDR NULL,
    col_cidr_array CIDR[] NULL,
    col_inet INET NULL,
    col_inet_array INET[] NULL,
    col_macaddr MACADDR NULL,
    col_macaddr_array MACADDR[] NULL,
    col_macaddr8 MACADDR8 NULL,
    col_macaddr8_array MACADDR8[] NULL
);

-- JSON Types Table
CREATE TABLE public.json_types (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    col_json JSON NULL,
    col_json_array JSON[] NULL,
    col_jsonb JSONB NULL,
    col_jsonb_array JSONB[] NULL
);

-- Binary Data and XML Types Table
CREATE TABLE public.binary_xml_types (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    col_bytea BYTEA NULL,
    col_bytea_array BYTEA[] NULL,
    col_xml XML NULL,
    col_xml_array XML[] NULL
);

-- Miscellaneous Types Table
CREATE TABLE public.misc_types (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    col_money MONEY NULL,
    col_money_array MONEY[] NULL,
    col_pg_lsn PG_LSN NULL,
    col_pg_lsn_array PG_LSN[] NULL,
    col_pg_snapshot PG_SNAPSHOT NULL,
    col_pg_snapshot_array PG_SNAPSHOT[] NULL,
    col_tsquery TSQUERY NULL,
    col_tsquery_array TSQUERY[] NULL,
    col_tsvector TSVECTOR NULL,
    col_tsvector_array TSVECTOR[] NULL,
    col_txid_snapshot TXID_SNAPSHOT NULL,
    col_txid_snapshot_array TXID_SNAPSHOT[] NULL
);



-- Create a simple view
CREATE OR REPLACE VIEW public.combined_types_view AS
SELECT 
    nt.id AS numeric_id,
    nt.col_integer,
    nt.col_double,
    st.id AS string_id,
    st.col_text,
    st.col_uuid
FROM 
    public.numeric_types nt
JOIN 
    public.string_types st ON nt.id = st.id;

-- add comment to view
-- COMMENT ON VIEW public.combined_types_view IS '[supadart:view]';

-- Remove view
-- DROP VIEW IF EXISTS public.combined_types_view;


CREATE TYPE mood AS ENUM ('happy', 'sad', 'neutral', 'excited', 'angry');

CREATE TABLE enum_types (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    col_mood mood NOT NULL,
    col_mood_array mood[] NOT NULL
);


CREATE TYPE public.usergroup AS ENUM ('USERS', 'ADMIN', 'MODERATOR');


create table
  public.profiles (
    id uuid not null default extensions.uuid_generate_v4 (),
    first_name character varying(100) null,
    last_name character varying(100) null,
    user_groups usergroup[] not null default '{{USERS}}'::usergroup[]
  );
