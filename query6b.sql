--
-- 11 Feb 2020 Updated at 17:55
-- 24 Jan 2019 Created at 18:58
--
variable vc_sql_id varchar2(13) ;
variable n_child_num number ;

begin
 :vc_sql_id := '0w9xx2ra4jbjg' ;
 :n_child_num := 0 ;
end ;
/
show error

set linesize 200
set pagesize 200

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool query6b.out

SELECT sysdate
FROM dual
/

SELECT instance_number , instance_name , instance_role
, startup_time , version , parallel , thread#
, host_name
FROM v$instance
/

print :vc_sql_id :n_child_num

SELECT *
--FROM table(DBMS_xplan.display_cursor( sql_id => :vc_sql_id ))
--FROM table(DBMS_xplan.display_cursor( sql_id => :vc_sql_id, format => 'TYPICAL'))
FROM table(DBMS_xplan.display_cursor( sql_id => :vc_sql_id, cursor_child_no => :n_child_num , format => 'TYPICAL'))
/

spool off
set linesize 80
set pagesize 40
