CREATE TABLE all_types (
    bigintx BIGINT PRIMARY KEY,
    bigserialx BIGSERIAL NOT NULL,
    bitx BIT(1) NOT NULL,
    bitvaryingx BIT VARYING NULL,
    booleanx BOOLEAN NULL,
    boxx BOX NOT NULL,
    byteax BYTEA NULL,
    characterx CHARACTER(1) NOT NULL,
    charactervaryingx CHARACTER VARYING NULL,
    cidrx CIDR NULL,
    circlex CIRCLE NOT NULL,
    datex DATE NULL,
    doublex DOUBLE PRECISION NOT NULL,
    inetx INET NULL,
    integerx INTEGER NOT NULL,
    intervalx INTERVAL NULL,
    jsonx JSON NULL,
    jsonbx JSONB NOT NULL,
    linex LINE NULL,
    lsegx LSEG NOT NULL,
    macaddrx MACADDR NULL,
    macaddr8x MACADDR8 NULL,
    moneyx MONEY NOT NULL,
    numericx NUMERIC NULL,
    pathx PATH NOT NULL,
    pg_lsnx PG_LSN NOT NULL,
    pg_snapshotx PG_SNAPSHOT NULL,
    pointx POINT NOT NULL,
    polygonx POLYGON NULL,
    realx REAL NOT NULL,
    smallintx SMALLINT NULL,
    smallserialx SMALLSERIAL NOT NULL,
    serialx SERIAL NOT NULL,
    textx TEXT NULL,
    timex TIME NULL,
    timewithouttimezone TIME WITHOUT TIME ZONE NOT NULL,
    timestampx TIMESTAMP NULL,
    timestampwithouttimezone TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    tsqueryx TSQUERY NULL,
    tsvectorx TSVECTOR NOT NULL,
    txid_snapshotx TXID_SNAPSHOT NULL,
    uuidx UUID NOT NULL,
    xmlx XML NULL
);


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
    'snapshot:1:2:',               -- pg_snapshotx
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
