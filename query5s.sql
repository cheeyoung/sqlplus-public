--
-- See query19.sql for dba_source
--
--connect / as sysdba

set pagesize 40
set linesize 80

variable vc_sql_id varchar2(128) ;

begin
 :vc_sql_id := '9dgtchnb4nzu3' ;
end ;
/
show error

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool query5s.out

print :vc_sql_id

SELECT sysdate
FROM dual
/

SELECT name , dbid , database_role , db_unique_name
, created , platform_name
FROM v$database
/

SELECT instance_number , instance_name , instance_role
, startup_time , version , parallel , thread#
, host_name
FROM v$instance
/

SELECT sql_id
, command_type
, address
, hash_value
FROM v$sqltext
WHERE sql_id = :vc_sql_id
/

set pagesize 0
set heading off

SELECT piece
, sql_text
FROM v$sqltext
WHERE sql_id = :vc_sql_id
ORDER BY piece
/
spool off

set pagesize 40
set heading on
