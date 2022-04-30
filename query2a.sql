--
-- For v$sql, Please, see query69.sql
-- 21 Oct 2015 Created at 15:06
--
set pagesize 40
set linesize 80

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

variable vc_sql_id varchar2(13) ;
variable vc_sql_text varchar2(1000) ;

begin
 :vc_sql_id := '520mkxqpf15q8' ;
end ;
/
show error

column dbid format 9999999999999

spool query2a.out

print :vc_sql_id :vc_sql_text

SELECT sysdate
FROM dual
/

SELECT name , dbid, db_unique_name , database_role 
, created , platform_name
FROM v$database
/

SELECT instance_number , instance_name , instance_role
, version , parallel , thread#
, startup_time , host_name
FROM v$instance
/

SELECT sql_id
, sql_text
FROM v$sqlarea
WHERE sql_text LIKE '%WRK_RCP_NO%'
/

SELECT sql_id
, sharable_mem
, persistent_mem
, runtime_mem
, version_count
, loaded_versions
, open_versions
, users_opening
, executions , px_servers_executions
, command_type
, parsing_user_id , parsing_schema_id , parsing_schema_name
, module , action 
, sql_text
FROM v$sqlarea
WHERE sql_id = :vc_sql_id
/

set long 10000

SELECT sql_id
, sql_fulltext
FROM v$sqlarea
WHERE sql_id = :vc_sql_id
/

set long 80

SELECT *
FROM v$sql_shared_cursor
WHERE sql_id = :vc_sql_id
/
spool off
