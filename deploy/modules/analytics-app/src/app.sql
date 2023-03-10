CREATE OR REPLACE STREAM "${DESTINATION_SQL_STREAM}"
 (datetime TIMESTAMP, status INTEGER, statusCount
INTEGER);
-- Create pump to insert into output
CREATE OR REPLACE PUMP "STREAM_PUMP" AS
 INSERT INTO "${DESTINATION_SQL_STREAM}"
-- Select all columns from source stream
SELECT
 STREAM ROWTIME as datetime,
 "response" as status,
 COUNT(*) AS statusCount
 FROM "${SOURCE_SQL_STREAM_PREFIX}_001"
 GROUP BY
 "response",
 FLOOR(("${SOURCE_SQL_STREAM_PREFIX}_001".ROWTIME -TIMESTAMP
'1970-01-01 00:00:00') minute / 1 TO MINUTE);
