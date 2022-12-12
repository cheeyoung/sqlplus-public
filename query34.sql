-- 10 Dec 2022 Updated at 18:52
-- 05 July 2013 Created at 10:36:52
set pagesize 40
set linesize 80

variable vc_ts_name VARCHAR2(30) ;

begin
  :vc_ts_name := 'SYSAUX' ;
end ;
/
show error

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool query34.out 

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

SELECT name, value
, isModified, isAdjusted
FROM v$system_parameter
WHERE name = 'recyclebin'
/

print :vc_ts_name

SELECT tablespace_name
, block_size
FROM dba_tablespaces
WHERE tablespace_name = :vc_ts_name
/

SELECT tablespace_name
, sum(blocks) AS blocks_total
FROM dba_data_files
WHERE tablespace_name = :vc_ts_name
GROUP BY tablespace_name
/

SELECT tablespace_name
, used_space AS blocks_used
FROM dba_tablespace_usage_metrics
WHERE tablespace_name = :vc_ts_name
/

SELECT tablespace_name
, sum(blocks) AS blocks_free
FROM dba_free_space
WHERE tablespace_name = :vc_ts_name
GROUP BY tablespace_name
/

spool off
