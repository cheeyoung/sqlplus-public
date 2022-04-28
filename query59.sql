--
-- Please, see query57.sql for dba_hist_sqlstat
-- 18 Dec 2015 Created at 10:12
--
set pagesize 40
set linesize 80

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

variable n_snap_id number ;
variable n_dbid number ;
variable vc_sql_id varchar2(13) ;

begin
 :n_snap_id := 160726 ;
 :n_dbid := 1253449651 ;
 :vc_sql_id := 'cgd9042y4t8t0' ;
end ;
/
show error

spool query59.out 

SELECT sysdate
FROM dual
/

SELECT name , dbid , db_unique_name , database_role 
, created , platform_name
FROM v$database
/

SELECT instance_number , instance_name , instance_role
, version , parallel , thread#
, startup_time , host_name
FROM v$instance
/

print :n_dbid :n_snap_id :vc_sql_id

SELECT sql_id
, position
, dup_position
, datatype
, datatype_string
, character_sid
, max_length
, precision
, scale
, last_captured
, name
, value_string
FROM v$sql_bind_capture
WHERE sql_id = :vc_sql_id
/

SELECT snap_id
, dbid
, instance_number
, sql_id
, position
, dup_position
, datatype
, datatype_string
, character_sid
, max_length
, precision
, scale
, last_captured
, name
, value_string
FROM dba_hist_sqlbind
WHERE sql_id = :vc_sql_id
AND dbid = :n_dbid
AND snap_id = :n_snap_id
/
spool off
