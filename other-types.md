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
