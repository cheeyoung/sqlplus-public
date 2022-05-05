--
-- 10 July 2013 Updated at 17:55
--
set linesize 80
set pagesize 40

variable vc_own_name varchar2(30) ;
variable vc_tab_name varchar2(30) ;

begin
  :vc_own_name := 'MSPS' ;
  :vc_tab_name := 'PS_SALETRAN_DTL' ;
end ;
/
show error

print :vc_own_name :vc_tab_name

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool query02.out 

SELECT sysdate
FROM dual
/

SELECT dbid , name , db_unique_name , database_role
--, current_scn
, created , platform_name
FROM v$database
/

SELECT instance_number , instance_name , instance_role
, parallel , thread# , version
, startup_time , host_name
FROM v$instance
/

--desc MSPS.PS_SALETRAN_DTL

SELECT *
FROM dba_objects
WHERE owner = :vc_own_name
AND object_name = :vc_tab_name
/


SELECT owner , table_name
, last_analyzed , cache , buffer_pool
, compression , compress_for
--, inmemory
--, inmemory_priority
--, inmemory_distribute
--, inmemory_compression
--, inmemory_duplicate
FROM dba_tables
WHERE owner = :vc_own_name
AND table_name = :vc_tab_name
/

SELECT *
FROM all_tab_modifications
WHERE table_owner = :vc_own_name
AND table_name = :vc_tab_name
/

-- See query4i for constraints

SELECT owner , index_name , index_type
, uniqueness , last_analyzed , compression
, table_owner , table_name , table_type
FROM all_indexes
WHERE table_name = :vc_tab_name
AND owner = :vc_own_name
/

SELECT index_name , table_name , column_name , column_position
FROM all_ind_columns
WHERE table_name = :vc_tab_name
AND table_owner = :vc_own_name
ORDER BY index_name
, column_position
, column_name
/
spool off
