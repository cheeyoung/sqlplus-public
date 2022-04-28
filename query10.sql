--
-- 2013 Dec 19 Created at 21:13
--
set	pagesize	40
set	linesize	80

variable	vc_own_name	varchar2(30)	;
variable	vc_obj_name	varchar2(30)	;
variable	vc_obj_type	varchar2(18)	;

begin
 :vc_own_name := 'ORACLE_OCM' ;
 :vc_obj_name := 'MGMT_DB_LL_METRICS' ;
 :vc_obj_type := 'PACKAGE BODY' ;
end	;
/
show	error

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool	query10.out
set	timing	on

print	:vc_own_name	:vc_obj_name	:vc_obj_type

SELECT	sysdate
FROM	dual
/

SELECT name , dbid , db_unique_name
, database_role
, created , platform_name
FROM	v$database
/

SELECT startup_time , instance_number
, instance_name , instance_role
, parallel , thread# , version
, host_name
FROM	v$instance
/

SELECT *
FROM dba_objects
WHERE owner = :vc_own_name
AND object_name = :vc_obj_name
/

prompt	Object(s) used in this object (Referenced objects)

SELECT	o.owner 
,	o.object_name 
,	o.object_type 
,	o.status
,	o.created
,	o.last_ddl_time
FROM	dba_objects	o
,	dba_dependencies	d
WHERE	o.owner = d.referenced_owner
AND	o.object_name = d.referenced_name
AND	o.object_type = d.referenced_type
AND	d.owner = :vc_own_name
AND	d.name = :vc_obj_name
AND	d.type = :vc_obj_type
/

prompt	Object(s) using this object (Dependent objects)

SELECT	o.owner 
,	o.object_name 
,	o.object_type 
,	o.status
,	o.created
,	o.last_ddl_time
FROM	dba_objects	o
,	dba_dependencies	d
WHERE	o.owner = d.owner
AND	o.object_name = d.name
AND	o.object_type = d.type
AND	d.referenced_owner = :vc_own_name
AND	d.referenced_name = :vc_obj_name
AND	d.referenced_type = :vc_obj_type
/

set	timing	off
spool	off
