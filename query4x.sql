set pagesize 40
set linesize 80

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool query4x.out

SELECT dbid , name , db_unique_name , database_role
, created , platform_name
FROM v$database
/
SELECT startup_time
, instance_number , instance_name , instance_role
, version , parallel , thread#
, host_name
FROM v$instance
/

SELECT	timestamp
,	last_ddl_time
,	created
,	status
,	dbms_java.longname(object_name)
FROM	dba_objects
WHERE	object_type IN ('JAVA CLASS','JAVA SOURCE','JAVA RESOURCE','JAVA DATA')
/

spool	off
