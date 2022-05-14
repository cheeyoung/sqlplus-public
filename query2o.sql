set	pagesize	40
set	linesize	80

connect	/ as sysdba

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool	query2o.out

SELECT	sysdate
FROM	dual
/

SELECT	dbid
,	name
,	db_unique_name
--,	current_scn
,	created
,	platform_name
FROM	v$database
/

SELECT	instance_number
,	instance_name
,	parallel
,	thread#
,	version
,	startup_time
,	host_name
FROM	v$instance
/

SELECT	endian_format
,	substr(platform_name, 1, 33) AS platform_name
--,	substr(platform_name, 1, 33)||' ('||platform_id||')'
FROM	v$db_transportable_platform
/

SELECT	endian_format
,	substr(platform_name, 1, 33)
FROM	v$transportable_platform
ORDER BY	1
,	2
/
spool	off
