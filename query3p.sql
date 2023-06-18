set	pagesize	40
set	linesize	80

--connect	/ as sysdba

alter session set NLS_TIMESTAMP_TZ_FORMAT = 'YYYY-MM-DD HH24:MI:SS.FF TZH:TZM'
/
alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool	query3p.out	append

SELECT	sysdate
FROM	dual
/

SELECT	dbid
,	name
,	db_unique_name
,	created
,	platform_name
FROM	v$database
/

SELECT	host_name
,	instance_number
,	instance_name
FROM	v$instance
/

SELECT	stats_update_time
,	owner
,	table_name
,	partition_name
FROM	dba_tab_stats_history
ORDER BY	stats_update_time
/
spool	off
