set	pagesize	40
set	linesize	80

--connect	/ as sysdba

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool	query3r.out
--	append

SELECT	sysdate
FROM	dual
/

SELECT name , dbid , db_unique_name , database_role
, created , platform_name
FROM v$database
/

SELECT instance_number , instance_name , instance_role
, parallel , thread# , version
, startup_time , host_name
FROM v$instance
/

show	parameter	cpu
show	parameter	sga
show	parameter	shared
show	parameter	memory

SELECT	*
FROM	v$sgastat
--WHERE	pool = 'shared pool'
ORDER BY	pool
--,	bytes
/

SELECT	*
FROM	v$resource_limit
WHERE	resource_name IN ( 'sessions' , 'processes' )
/

SELECT *
FROM	DBA_HIST_WR_CONTROL
/

SELECT	snap_id
,	dbid
,	instance_number
,	substr(name, 1, 30)
,	pool
,	bytes
FROM	dba_hist_sgastat
--WHERE	pool = 'shared pool'
/

spool	off
