--
-- 02 Feb 2015 Created at 16:04
--
set pagesize 40
set linesize 80

variable vc_sql_id varchar2(13) ;
variable n_db_id number ;

begin
 :vc_sql_id := '0w9xx2ra4jbjg' ;
 :n_db_id := 865114574 ;
end ;
/
show error

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool query3d.out

print :vc_sql_id
print :n_db_id

SELECT sysdate
FROM dual
/

SELECT dbid , name , db_unique_name , database_role
, created , platform_name
FROM v$database
/

SELECT instance_number , instance_name , instance_role
, version , parallel, thread#
, startup_time , host_name
FROM v$instance
/

SELECT sql_id
, address
, hash_value
, plan_hash_value
, version_count
, loaded_versions
, sql_text
, parsing_schema_name
, module
, action
FROM v$sqlarea
WHERE sql_id = :vc_sql_id
/

SELECT sql_id
, address
, hash_value
, plan_hash_value
FROM v$sql_plan
WHERE sql_id = :vc_sql_id
/

SELECT sql_id
, address
, hash_value
, plan_hash_value
, optimizer_env_hash_value
, version_count
, loaded_versions
, sql_text
FROM v$sqlarea_plan_hash
WHERE sql_id = :vc_sql_id
/

SELECT dbid
, sql_id
, plan_hash_value
, timestamp
, id
, operation
, options
, cost
, cardinality
, bytes
, object_node
, object_owner
, object_name
, other_tag
, partition_start
, partition_stop
, distribution
FROM dba_hist_sql_plan
WHERE dbid = :n_db_id
AND sql_id = :vc_sql_id
/
spool off
