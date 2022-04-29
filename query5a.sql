set pagesize 40
set linesize 80

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/
spool query5a.out
-- append

SELECT sysdate
FROM dual
/

SELECT dbid
, name
, db_unique_name
, database_role
, primary_db_unique_name
--, current_scn
, controlfile_type
, open_mode
, protection_mode
, protection_level
, log_mode
, switchover_status
, dataguard_broker
, guard_status
, created
, platform_name
FROM v$database
/

SELECT startup_time
, instance_number , instance_name , instance_role
, parallel , thread#
, version , host_name
FROM v$instance
/

SELECT pid
, process
, status
, client_pid
, client_process
, client_dbid
, group#
, thread#
, sequence#
, known_agents
, active_agents
FROM v$managed_standby
/
spool off
