--
-- 19 June 2019 Updated at 15:47:38
-- Created from query2p.sql
--
set pagesize 40
set linesize 80

variable n_stat_num number ;
variable vc_stat_name varchar2(64) ;

begin
 :n_stat_num := 262 ;
 :vc_stat_name := 'redo buffer allocation retries' ;
end ;
/
show error

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool query4c.out 
--append

print :n_stat_num :vc_stat_name

SELECT sysdate
FROM dual
/

SELECT name , dbid , database_role , db_unique_name
--, current_scn
, created , platform_name
FROM v$database
/

SELECT instance_number , instance_name , instance_role
, startup_time , version , parallel , thread#
, host_name
FROM v$instance
/

SELECT statistic#
, name
FROM v$statname
WHERE name = 'redo buffer allocation retries'
/

column value format 999,999,999,999

SELECT s.value
, substr(n.name, 1, 40)
FROM v$statname n
, v$sysstat s
WHERE s.statistic# = n.statistic#
--AND stat.statistic# = :n_stat_num
AND n.name = :vc_stat_name
--AND value > 0
/

SELECT stat.sid
, stat.value
, substr(n.name, 1, 40)
FROM v$statname n
, v$sesstat stat
WHERE stat.statistic# = n.statistic#
AND n.name = :vc_stat_name
--AND value > 0
ORDER BY sid
/

spool off
