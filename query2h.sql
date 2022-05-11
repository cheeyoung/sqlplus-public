set pagesize 40
set linesize 80

--connect 

variable vc_own_name varchar2(30) ;
variable vc_obj_name varchar2(128) ;
variable vc_obj_name_1 varchar2(128) ;
variable vc_obj_name_2 varchar2(128) ;
variable n_obj_id number ;
variable n_data_obj_id number ;

begin
 :vc_own_name := 'LCSMGR' ;
 :vc_obj_name := 'DBMS_FLASHBACK' ;
end ;
/
show error

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/
spool	query2h.out
--	append

print	:vc_own_name	:vc_obj_name
--print	:n_obj_id	:n_data_obj_id

SELECT	sysdate
FROM	dual
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

--SELECT	object_id
--,	data_object_id
--,	object_type
--,	object_name
SELECT	*
FROM	dba_objects
WHERE	owner = :vc_own_name
AND	data_object_id IN ( 418939 , 18431 )
/

--SELECT	substr(comp_name, 1, 34) AS comp_name
--,	substr(version, 1, 15) AS version
--,	status
--,	modified
--,	control
--,	schema
--,	procedure
--,	comp_id
--,	parent_id
--FROM	dba_registry
--/

spool	off
