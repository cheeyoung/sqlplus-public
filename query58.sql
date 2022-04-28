--
-- 11 Nov 2015 Created at 16:09
--
set pagesize 40
set linesize 80

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

variable n_dbid number ;
variable vc_sql_id varchar2(13) ;

begin
 :n_dbid := 28516294 ;
 :vc_sql_id := 'fg0ujtab6ruqy' ;
end ;
/
show error

spool query58.out 

SELECT sysdate
FROM dual
/

SELECT name , dbid , database_role , db_unique_name
, created , platform_name
FROM v$database
/
SELECT instance_number , instance_name , instance_role
, parallel , thread# , startup_time , version
, host_name
FROM v$instance
/

print :n_dbid :vc_sql_id

SELECT sql_id
, version_count
, elapsed_time
FROM v$sqlstats
WHERE sql_id = :vc_sql_id
/

SELECT snap_id
, dbid
, instance_number
, sql_id
, version_count
, executions_total
, executions_delta
, elapsed_time_total
, elapsed_time_delta
, module
, action
FROM dba_hist_sqlstat
WHERE sql_id = :vc_sql_id
AND dbid = :n_dbid
/
spool off
