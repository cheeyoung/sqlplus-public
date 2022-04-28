--
-- 24 Apr 2014 Created at 10:37
--
set pagesize 40
set linesize 80

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

column value format 999,999,999,999

spool query43.out 

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
show parameter workarea_size_policy
show parameter _area_size

SELECT *
FROM dba_hist_wr_control
/

SELECT *
FROM v$sql_workarea_histogram
/

SELECT *
FROM v$sql_workarea
/

SELECT *
FROM v$pgastat
/

SELECT dbid
, instance_number
, snap_id
, value
, name
FROM dba_hist_pgastat
ORDER BY dbid
, instance_number
, snap_id
/
spool off
