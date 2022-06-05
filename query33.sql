--
-- For v$pgastat and v$workarea, See query43.sql
-- For v$sgastat, See query4c.sql
-- 18 Nov 2019 Created at 15:37
--
set pagesize 40
set linesize 80

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

column value format 999,999,999,999

spool query33.out 

SELECT sysdate
FROM dual
/

SELECT dbid , name , db_unique_name , database_role
--, current_scn
, created , platform_name
FROM v$database
/

SELECT startup_time , instance_number , instance_name , instance_role
, version , parallel , thread#
, host_name
FROM v$instance
/

show parameter pga_aggregate_target

SELECT category
, sum(used)
, sum(allocated)
FROM v$process_memory
GROUP BY category
/

SELECT HEAP_NAME
, sum(bytes)
, sum(allocation_count)
FROM v$process_memory_detail
WHERE category = 'JAVA'
GROUP BY HEAP_NAME
/

SELECT HEAP_NAME
, name
, bytes
, allocation_count
FROM v$process_memory_detail
WHERE category = 'JAVA'
/
spool off
