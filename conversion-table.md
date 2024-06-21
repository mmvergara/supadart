### Conversion Table
| Supabase Identifier | Format                      | JSON Type | Dart Type            | Runtime Tested |
| ------------------- | --------------------------- | --------- | -------------------- | -------------- |
| # int2              | smallint                    | integer   | int                  | ✅             |
| # int4              | integer                     | integer   | int                  | ✅             |
| # int8              | bigint                      | integer   | BigInt               | ✅             |
| # float4            | real                        | number    | double               | ✅             |
| # float8            | double precision            | number    | double               | ✅             |
| # numeric           | numeric                     | number    | num                  | ✅             |
| {} json             | json                        | -         | Map<String, dynamic> | ✅             |
| {} jsonb            | jsonb                       | -         | Map<String, dynamic> | ✅             |
| T text              | text                        | string    | String               | ✅             |
| T varchar           | character varying           | string    | String               | ✅             |
| T uuid              | uuid                        | string    | String               | ✅             |
| 🗓️ date             | date                        | string    | DateTime             | ✅             |
| 🗓️ time             | time without time zone      | string    | DateTime             | ✅             |
| 🗓️timetz            | time with time zone         | string    | DateTime             | ✅             |
| 🗓️ timestamp        | timestamp without time zone | string    | DateTime             | ✅             |
| 🗓️ timestamptz      | timestamp with time zone    | string    | DateTime             | ✅             |
| 💡 bool             | boolean                     | boolean   | bool                 | ✅             |

---

### Other Types

These are valid types in Postgres but is not present in the supabase table editor

| Supabase Identifier | Format        | JSON Type | Dart Type                                                   | Runtime Tested |
| ------------------- | ------------- | --------- | ----------------------------------------------------------- | -------------- |
|                     | character     | string    | String                                                      | ✅             |
|                     | varchar       | string    | String                                                      |                |
|                     | interval      | string    | Duration                                                    |                |
|                     | bytea         | string    | String (Preferably to be a type of Uint8List needparser⚠ ️) |                |
|                     | inet          | string    | String                                                      |                |
|                     | cidr          | string    | String                                                      |                |
|                     | macaddr       | string    | String                                                      |                |
|                     | macaddr8      | string    | String                                                      |                |
|                     | point         | string    | String                                                      |                |
|                     | line          | string    | String                                                      |                |
|                     | lseg          | string    | String                                                      |                |
|                     | box           | string    | String                                                      |                |
|                     | path          | string    | String                                                      |                |
|                     | polygon       | string    | String                                                      |                |
|                     | circle        | string    | String                                                      |                |
|                     | bit           | string    | String                                                      | ✅             |
|                     | bit varying   | string    | String                                                      |                |
|                     | money         | string    | double                                                      |                |
|                     | tsquery       | string    | String                                                      |                |
|                     | tsvector      | string    | String                                                      |                |
|                     | xml           | string    | String                                                      |                |
|                     | pg_lsn        | string    | String                                                      |                |
|                     | pg_snapshot   | string    | String                                                      |                |
|                     | txid_snapshot | string    | String                                                      |                |
