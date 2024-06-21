DROP TABLE IF EXISTS all_types;

CREATE TABLE all_types (
    bigintx BIGINT PRIMARY KEY,
    bigserialx BIGSERIAL,
    bitx BIT(1),
    bitvaryingx BIT VARYING,
    booleanx BOOLEAN,
    boxx BOX,
    byteax BYTEA,
    characterx CHARACTER(1),
    charactervaryingx CHARACTER VARYING,
    cidrx CIDR,
    circlex CIRCLE,
    datex DATE,
    doublex DOUBLE PRECISION,
    inetx INET,
    integerx INTEGER,
    intervalx INTERVAL,
    jsonx JSON,
    jsonbx JSONB,
    linex LINE,
    lsegx LSEG,
    macaddrx MACADDR,
    macaddr8x MACADDR8,
    moneyx MONEY,
    numericx NUMERIC,
    pathx PATH,
    pg_lsnx PG_LSN,
    pg_snapshotx PG_SNAPSHOT,
    pointx POINT,
    polygonx POLYGON,
    realx REAL,
    smallintx SMALLINT,
    smallserialx SMALLSERIAL,
    serialx SERIAL,
    textx TEXT,
    timex TIME,
    timewithouttimezone TIME WITHOUT TIME ZONE,
    timestampx TIMESTAMP,
    timestampwithouttimezone TIMESTAMP WITHOUT TIME ZONE,
    tsqueryx TSQUERY,
    tsvectorx TSVECTOR,
    txid_snapshotx TXID_SNAPSHOT,
    uuidx UUID,
    xmlx XML
);

-- We need to add this for serial types otherwise the serial columns will not be recognized as nullable
-- and the insert method will always ask for a value
COMMENT ON COLUMN all_types.bigserialx IS 'serial';
COMMENT ON COLUMN all_types.smallserialx IS 'serial';
COMMENT ON COLUMN all_types.serialx IS 'serial';


INSERT INTO all_types (
    bigintx,
    bitvaryingx,
    booleanx,
    byteax,
    charactervaryingx,
    cidrx,
    circlex,
    datex,
    inetx,
    intervalx,
    jsonx,
    linex,
    macaddrx,
    macaddr8x,
    numericx,
    pathx,
    pg_snapshotx,
    pointx,
    polygonx,
    smallintx,
    textx,
    timex,
    timestampx,
    tsqueryx,
    txid_snapshotx,
    xmlx
) VALUES (
    1,                             -- bigintx (Primary Key)
    B'101',                        -- bitvaryingx
    TRUE,                          -- booleanx
    E'\\xDEADBEEF',                -- byteax
    'example',                     -- charactervaryingx
    '192.168.100.128/25',          -- cidrx
    '<(0,0),1>',                   -- circlex
    '2024-06-21',                  -- datex
    '192.168.0.1',                 -- inetx
    '1 year 2 months 3 days',      -- intervalx
    '{"key": "value"}',            -- jsonx
    '{0,1,2}',                     -- linex
    '08:00:2b:01:02:03',           -- macaddrx
    '08-00-2b-01-02-03-04-05',     -- macaddr8x
    123.45,                        -- numericx
    '((1,1),(2,2))',               -- pathx
    '10:20:10,14,15',              -- pg_snapshotx
    '(1,1)',                       -- pointx
    '((1,1),(1,0),(0,0))',         -- polygonx
    32767,                         -- smallintx
    'some text',                   -- textx
    '13:45:00',                    -- timex
    '2024-06-21 13:45:00',         -- timestampx
    'fat & rat',                   -- tsqueryx
    '1:1:',                        -- txid_snapshotx
    '<example>XML content</example>' -- xmlx
);
