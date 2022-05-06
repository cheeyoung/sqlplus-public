--connect / as sysdba

set pagesize 40
set linesize 80

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/
spool query17.out

SELECT sysdate
FROM dual
/
SELECT dbid , name , db_unique_name , database_role
--, current_scn
, created , platform_name
FROM v$database
/
SELECT startup_time , instance_number , instance_name , instance_role
, parallel , thread# , version
, host_name
FROM v$instance
/
SELECT *
FROM v$resource_limit
WHERE resource_name IN ('processes', 'sessions')
/
show parameter undo
show parameter _smu_debug_mode

SELECT *
FROM v$undostat 
/
SELECT *
FROM v$tempundostat 
/
spool off
