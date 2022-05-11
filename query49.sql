--
-- 14 July 2014 Created at 17:51
--
set	pagesize	40
set	linesize	80

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool	query49.out

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
,	startup_time
,	parallel
,	thread#
,	host_name
FROM	v$instance
/

show 	parameter	db_recovery_file_dest

--alter session set events '10046 trace name context forever, level 8'
--/

SELECT	space_limit
,	space_used
,	space_reclaimable
,	number_of_files
,	substr(name, 1, 80)
FROM	v$recovery_file_dest
/

--alter session set events '10046 trace name context off'
--/
--oradebug setmypid
--oradebug tracefile_name

SELECT	file_type
,	percent_space_used	AS percent_used
,	percent_space_reclaimable	AS percent_reclaimable
,	number_of_files
FROM	v$recovery_area_usage
/

SELECT	*
FROM	v$flashback_database_log
/

SELECT	log#
,	thread#
,	sequence#
,	bytes
,	first_change#
,	first_time
,	type
,	substr(name, 1, 80)
FROM	v$flashback_database_logfile
/

spool	off
