--
--	See query5s.sql for v$sqltext
--	See query57.sql for get_ddl
--
connect	/ as sysdba

set pagesize 40
set linesize 80

variable vc_owner varchar2(128) ;
variable vc_obj_name varchar2(128) ;
variable vc_obj_type varchar2(12) ;


begin
 :vc_owner := 'MDSYS' ;
 :vc_obj_name := 'SDO_RELATE' ;
 :vc_obj_type := 'OPERATOR' ;
end ;
/
show error

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool query19.out

print :vc_owner
print :vc_obj_name
print :vc_obj_type

SELECT sysdate
FROM dual
/

SELECT dbid , name , db_unique_name , database_role
, created , platform_name
FROM v$database
/

SELECT startup_time, instance_number , instance_name , instance_role
, version , parallel , thread#
, host_name
FROM v$instance
/

SELECT	*
FROM	dba_objects
WHERE	owner = :vc_owner
AND	object_type = :vc_obj_type
AND	object_name = :vc_obj_name
/

set	pagesize	0
set	heading	off
set	linesize	4000

SELECT	line , text
--SELECT	text
FROM	dba_source
WHERE	owner = :vc_owner
AND	type = :vc_obj_type
AND	name = :vc_obj_name
/

set	linesize	80
set	pagesize	40
set	heading	on
spool	off
