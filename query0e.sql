--
-- 17 July 2013 Created at 13:56
--
set	pagesize	40
set	linesize	80

alter session set NLS_TIMESTAMP_FORMAT = 'YYYY-MM-DD HH24:MI:SS.FF'
/
alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool	query0e.out

SELECT	sysdate
FROM	dual
/
SELECT dbid , name , db_unique_name , database_role
--, current_scn
, created , platform_name
FROM	v$database
/

SELECT startup_time , instance_number , instance_name , instance_role
, version , parallel , thread# , host_name
FROM v$instance
/

SELECT	comp_id
,	substr(comp_name, 1, 30) "component"
,	version
,	status
--SELECT	*
FROM	dba_registry
/

SELECT	*
FROM	dba_registry_history
/

SELECT	comp_id
,	req_comp_id
FROM	dba_registry_dependencies
/

SELECT	*
FROM	dba_feature_usage_statistics
/

SELECT	*
FROM	dba_objects
WHERE	status = 'INVALID'
/

set	pagesize	40
spool	off
