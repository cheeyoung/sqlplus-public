set pagesize 40
set linesize 80

variable n_sid number ;
begin
 :n_sid := 1165 ;
end ;
/

ALTER SESSION set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool query09.out
-- append

print :n_sid

SELECT sysdate
FROM dual
/

SELECT startup_time
, instance_number , instance_name , instance_role
, version , parallel , thread#
, host_name
FROM v$instance
/

SELECT dbid , name , database_role , db_unique_name
, created , platform_name
--, current_scn
FROM v$database
/

SELECT *
FROM v$resource_limit
WHERE resource_name IN ('processes', 'sessions')
/

set pagesize 0

SELECT t.addr , t.xidusn , t.xidslot , t.xidsqn
, t.start_time , t.used_urec , t.used_ublk
FROM v$transaction t
/

SELECT s.sid , s.logon_time
, s.process , s.module , s.action , s.program
, s.sql_id , s.prev_sql_id
, s.event , s.p1 , s.p2 , s.p3
, s.machine
, t.addr , t.xidusn , t.xidslot , t.xidsqn
, t.start_time , t.used_urec , t.used_ublk
FROM v$transaction t
, v$session s
WHERE t.ses_addr = s.saddr
--AND s.sid = :n_sid
/

SELECT s.sid , s.logon_time
, s.process , s.module , s.action , s.program
, s.sql_id , s.prev_sql_id
, s.event , s.p1 , s.p2 , s.p3
, s.machine
FROM v$session s
--AND s.sid = :n_sid
/

set pagesize 40

SELECT p.addr , p.pid , p.spid , s.sid
FROM v$process p
, v$session s
WHERE p.addr = s.paddr
--AND s.sid = :n_sid
/

SELECT p.addr , p.pid , p.spid
, p.terminal , p.program
FROM v$process p
/

spool off
