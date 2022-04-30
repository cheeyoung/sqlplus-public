--
--	for v$sqlarea, See query2a.sql
--
set pagesize 40
set linesize 80

--connect / as sysdba

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

variable vc_sql_id varchar2(13) ;
variable vc_sql_text varchar2(1000) ;

begin
 :vc_sql_id := 'dbj5v9wmp4wkt' ;
end ;
/
show error

column dbid format 9999999999999

spool query69.out

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
FROM v$sql
WHERE sql_text = 'SELECT COUNT(*) FROM NKRDM201 WHERE RSCHR_REG_NO = :B1'
/

SELECT sql_id
, sharable_mem
, persistent_mem
, runtime_mem
, loaded_versions
, open_versions
, users_opening
, executions , px_servers_executions
, command_type
, parsing_user_id , parsing_schema_id , parsing_schema_name
, service , module , action 
, sql_text
, address , hash_value , child_address
FROM v$sql
WHERE sql_id = :vc_sql_id
/

set long 10000

SELECT sql_id
, sql_fulltext
FROM v$sql
WHERE sql_id = :vc_sql_id
/

set long 80

SELECT *
FROM v$sql_shared_cursor
WHERE sql_id = :vc_sql_id
/
spool off
