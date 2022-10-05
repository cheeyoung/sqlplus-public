--
-- Created at 06:19:12 on 05 Oct 2022, 21.3
--
set linesize 80
set pagesize 40

variable vc_own_name VARCHAR2(30) ;

BEGIN
  :vc_own_name := 'HR' ;
END ;
/
show error

alter session set NLS_DATE_FORMAT = 'YYYY-MON-DD HH24:MI:SS'
/

spool query05.out
print :vc_own_name

SELECT sysdate
FROM dual
/
SELECT dbid , name , db_unique_name , database_role
, created , platform_name
FROM v$database
/
SELECT instance_number , instance_name , instance_role
, parallel , thread# , version
, startup_time , host_name
FROM v$instance
/

SELECT substr(p.table_name, 1, 30) AS "Parent Table"
, substr(p.owner, 1, 30)||'.'||substr(p.constraint_name, 1, 30)||' ('||p.constraint_type||')' AS "Constraint"
, substr(b.table_name, 1, 30) AS "Base Table"
, substr(b.owner, 1, 30)||'.'||substr(b.constraint_name, 1, 30)||' ('||b.constraint_type||')' AS "Constraint"
FROM all_constraints b
, all_constraints p
WHERE b.r_owner = p.owner
AND b.r_constraint_name = p.constraint_name
AND b.owner = :vc_own_name
ORDER BY 1
/

SELECT substr(con.owner, 1, 30)||'.'||substr(con.constraint_name, 1, 30)||' ('||con.constraint_type||')'||' '||substr(col.owner, 1, 30)||'.'||substr(col.table_name, 1, 30)||'.'||substr(col.column_name, 1, 30) AS "Referential constraint for Base table"
, substr(con.r_owner, 1, 30)||'.'||substr(con.r_constraint_name, 1, 30)||', '||con.delete_rule AS "Unique constraint for Referenced table"
, last_change, status, validated
FROM all_constraints con
, all_cons_columns col
WHERE con.owner = col.owner
AND con.constraint_name = col.constraint_name
AND con.constraint_type in ( 'R' )
AND con.owner = :vc_own_name
/

SELECT substr(con.owner, 1, 30)||'.'||substr(con.constraint_name, 1, 30)||' ('||con.constraint_type||')'||' '||substr(col.owner, 1, 30)||'.'||substr(col.table_name, 1, 30)||'.'||substr(col.column_name, 1, 30) AS "Unique or Primary Key(s)"
, con.last_change, con.status, con.validated
, substr(con.index_owner, 1, 30)||'.'||substr(con.index_name, 1, 30) As "index"
FROM all_constraints con
, all_cons_columns col
WHERE con.owner = col.owner
AND con.constraint_name = col.constraint_name
AND con.constraint_type in ( 'P', 'U' )
AND con.owner = :vc_own_name
/

set pagesize 40
spool off
