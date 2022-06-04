--
-- For DISPLAY_CURSOR, See query6b.sql
-- 11 Feb 2020 Created at 17:19
--
variable vc_sql_id varchar2(13) ;
variable n_plan_hv number ;
variable n_db_id number ;

begin
 :vc_sql_id := '0w9xx2ra4jbjg' ;
 :n_plan_hv := 1730907399 ;
 :n_db_id := 865114574 ;
end ;
/
show error

set linesize 200
set pagesize 200

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool query6g.out

SELECT sysdate
FROM dual
/

SELECT instance_number , instance_name , instance_role
, startup_time , version , parallel , thread#
, host_name
FROM v$instance
/

print :vc_sql_id :n_plan_hv

SELECT *
FROM table(DBMS_xplan.display_awr( sql_id => :vc_sql_id, plan_hash_value => :n_plan_hv , db_id => :n_db_id , format => 'TYPICAL'))
/

spool off
set linesize 80
set pagesize 40
