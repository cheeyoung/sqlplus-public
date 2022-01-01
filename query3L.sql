--
-- 2013 Nov 07 Created at 21:13
--
set pagesize 40
set linesize 80

variable vc_own_name varchar2(30) ;
variable vc_tab_name varchar2(30) ;
variable vc_part_name varchar2(30) ;
variable vc_col_name varchar2(4000) ;

begin
 :vc_own_name := '' ;
 :vc_tab_name := '' ;
 :vc_col_name := '' ;
end ;
/
show error

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool query3L.out

SELECT sysdate
FROM dual
/

print :vc_own_name :vc_tab_name
print :vc_part_name :vc_col_name

SELECT name , dbid , database_role , db_unique_name
, created , platform_name
FROM v$database
/

SELECT instance_number , instance_name , instance_role
, startup_time , version , parallel , thread#
, host_name
FROM v$instance
/

set pagesize 100

SELECT owner
, table_name
, column_name
, num_distinct
, num_buckets
, histogram
FROM dba_tab_col_statistics
WHERE owner = :vc_own_name
AND table_name = :vc_tab_name
AND column_name = :vc_col_name
/

--execute dbms_stats.gather_table_stats( ownname => 'SH' , tabname => 'COUNTRIES' , method_opt => 'FOR COLUMNS COUNTRY_SUBREGION_ID' ) ;

SELECT owner
, table_name
, column_name
, endpoint_number
, endpoint_value
, endpoint_actual_value
FROM dba_tab_histograms
WHERE owner = :vc_own_name
AND table_name = :vc_tab_name
AND column_name = :vc_col_name
/

SELECT owner
, table_name
, partition_name
, column_name
, last_analyzed
, num_distinct
, num_buckets
, low_value
, high_value
FROM dba_part_col_statistics
WHERE owner = :vc_own_name
AND table_name = :vc_tab_name
AND partition_name = :vc_part_name
/

set pagesize 40
spool off
