--
-- 01 Apr 2014 Created at 16:11
--
set pagesize 40
set linesize 80

alter session set NLS_TIMESTAMP_FORMAT = 'YYYY-MM-DD HH24:MI:SS.FF'
/
alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

variable n_group number ;

begin
  :n_group := 2 ;
end ;
/
show error

spool query3y.out

SELECT sysdate
FROM dual
/

SELECT name , dbid , database_role , db_unique_name
--, current_scn 
, created , platform_name
FROM v$database
/

SELECT instance_number , instance_name , instance_role
, startup_time , parallel , thread#
, host_name
FROM v$instance
/

print :n_group

SELECT *
FROM dba_hist_snap_error
/

SELECT group_number
, sector_size
, block_size
, allocation_unit_size
, state
, type
, total_mb
, free_mb
, hot_used_mb
, cold_used_mb
, required_mirror_free_mb
, usable_file_mb
, offline_disks
, compatibility
, database_compatibility
, voting_files
, name
FROM v$asm_diskgroup
WHERE group_number = :n_group
/

SELECT group_number
, disk_number
, name
, path
FROM v$asm_disk
WHERE group_number = :n_group
/

SELECT group_number
, operation
, state
, power
, actual
, sofar
, est_work
, est_rate
, est_minutes
, error_code
FROM v$asm_operation
WHERE group_number = :n_group
/


spool off
