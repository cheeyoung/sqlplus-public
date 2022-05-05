set pagesize 40
set linesize 80

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool query54.out

SELECT sysdate
FROM dual
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

show parameter cpu_count
show parameter parallel
show parameter PX

SELECT *
FROM v$px_session
/

SELECT *
FROM v$px_sesstat
/

SELECT *
FROM v$px_process
/

SELECT value
, statistic
FROM v$px_process_sysstat
--WHERE statistic LIKE 'Buffers%'
/

SELECT value
, name
, statistic#
FROM v$sysstat
WHERE name LIKE '%PX%'
OR name LIKE 'Parallel%'
--WHERE name = 'Parallel operations downgraded to serial'
/

select * from v$system_event where event like 'PX Deq: Slave Join Frag'
/
select * from v$session_event where event like 'PX Deq: Slave Join Frag'
/
select s.indx, d.KSLEDNAM, s.kslesevt, s.KSLESTIM_FG, s.KSLESTIM_UN,
s.KSLESTIM_BG from x$kslei s, x$ksled d where s.indx = d.indx and d.KSLEDNAM
like 'PX Deq: Slave Join Frag'
/

--SELECT *
--FROM v$sgastat
--WHERE pool = 'large pool'
--/

SELECT *
FROM v$sgastat
WHERE name LIKE 'PX %'
/ 

spool off
