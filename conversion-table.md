| Format                      | JSON Type | Dart Type                                                   |
| --------------------------- | --------- | ----------------------------------------------------------- |
| character varying           | string    | String                                                      |
| character                   | string    | String                                                      |
| text                        | string    | String                                                      |
| varchar                     | string    | String                                                      |
| integer                     | integer   | int                                                         |
| smallint                    | integer   | int                                                         |
| bigint                      | integer   | int                                                         |
| numeric                     | number    | double                                                      |
| real                        | number    | double                                                      |
| double precision            | number    | double                                                      |
| boolean                     | boolean   | bool                                                        |
| date                        | string    | DateTime                                                    |
| timestamp without time zone | string    | DateTime                                                    |
| time without time zone      | string    | DateTime                                                    |
| interval                    | string    | Duration                                                    |
| json                        | -         | Map<String, dynamic>                                        |
| jsonb                       | -         | Map<String, dynamic>                                        |
| bytea                       | string    | String (Preferably to be a type of Uint8List needparser ⚠️) |
| inet                        | string    | String                                                      |
| cidr                        | string    | String                                                      |
| macaddr                     | string    | String                                                      |
| macaddr8                    | string    | String                                                      |
| point                       | string    | String                                                      |
| line                        | string    | String                                                      |
| lseg                        | string    | String                                                      |
| box                         | string    | String                                                      |
| path                        | string    | String                                                      |
| polygon                     | string    | String                                                      |
| circle                      | string    | String                                                      |
| uuid                        | string    | String                                                      |
| bit                         | string    | String                                                      |
| bit varying                 | string    | String                                                      |
| money                       | string    | double                                                      |
| tsquery                     | string    | String                                                      |
| tsvector                    | string    | String                                                      |
| xml                         | string    | String                                                      |
| pg_lsn                      | string    | String                                                      |
| pg_snapshot                 | string    | String                                                      |
| txid_snapshot               | string    | String                                                      |
