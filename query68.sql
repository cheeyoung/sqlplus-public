set pagesize 40
set linesize 80
--set numwidth 14

connect / as sysdba

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/
spool query68.out

SELECT sysdate
FROM dual
/

column controlfile_change# format 999,999,999,999,999
column archivelog_change# format 999,999,999,999,999

SELECT name , dbid , db_unique_name , database_role
--, current_scn
, created --, platform_name
, checkpoint_change# , archivelog_change#
, controlfile_change# , controlfile_sequence#
FROM v$database
/

SELECT instance_number , instance_name , instance_role
, startup_time , version , parallel , thread#
, host_name
FROM v$instance
/

column first_change# format 999,999,999,999,999

SELECT group#
, thread#
, sequence#
, first_change#
, first_time
FROM v$log
/

SELECT *
FROM v$archive_gap
/

SELECT *
FROM v$dataguard_stats
/

SELECT recid
, thread#
, sequence#
, first_change#
, first_time
, archived
, applied , registrar
, creator , completion_time
, name
FROM v$archived_log
/

column checkpoint_change# format 999,999,999,999,999

SELECT file#
, checkpoint_change#
, checkpoint_time
, tablespace_name
FROM v$datafile_header
/
spool off
