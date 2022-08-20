--
-- Created on 21 Aug 2022
--
set pagesize 40
set linesize 80

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool query1a.out

SELECT sysdate
FROM dual
/

SELECT dbid , name , db_unique_name , database_role
, created , platform_name
FROM v$database
/

SELECT startup_time, instance_number , instance_name , instance_role
, version , parallel , thread#
, host_name
FROM v$instance
/

set timing on

SELECT owner , name 
, db_link , kept 
, status , timestamp
FROM v$db_object_cache
WHERE namespace = 'TABLE/PROCEDURE' 
AND type = 'TABLE'
/

set timing off
spool off
