set pagesize 40
set linesize 80

variable n_group number ;

begin
 :n_group := 6 ;
end ;
/
show error

alter session set NLS_TIMESTAMP_FORMAT = 'YYYY-MM-DD HH24:MI:SS.FF'
/

spool query3v.out

SELECT systimestamp
FROM dual
/

SELECT instance_number, instance_name, instance_role, instance_mode
, startup_time , parallel, thread#
, host_name
FROM v$instance
/

print :n_group

SELECT group_number , operation
, state
, power
, actual
, sofar
, est_work , est_rate , est_minutes
, error_code
FROM v$asm_operation
/

--set timing on

SELECT group_number , disk_number
, os_mb , total_mb , free_mb 
, hot_used_mb , cold_used_mb
, name
FROM v$asm_disk
--WHERE group_number = :n_group
/

SELECT *
FROM v$asm_disk_iostat
--WHERE group_number = :n_group
/

--SELECT group_number
--, disk_number
--FROM v$asm_disk
--WHERE group_number = 2
--/

--set timing off
spool off
