--connect / as sysdba

set pagesize 40
set linesize 80

alter session set NLS_TIMESTAMP_FORMAT = 'YYYY-MM-DD HH24:MI:SS.FF'
/
alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/
spool query6k.out

SELECT systimestamp
FROM dual
/

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

SELECT status , bytes , filename
FROM v$block_change_tracking
/

SELECT recid , stamp , set_stamp , set_count
, file# , block_size , datafile_blocks
, completion_time , blocks
, used_change_tracking , blocks_read
, used_optimization , section_size
, incremental_change# , incremental_level
, checkpoint_change# , checkpoint_time
, resetlogs_change# , resetlogs_time
, creation_change# , creation_time
FROM v$backup_datafile
/

spool off
