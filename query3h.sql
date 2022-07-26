--
-- 25 Feb 2019 Updated at 13:38:46
-- 18 Oct 2013 Created at 16:22:02
-- ORA-600 [25027]
-- 

set pagesize 40
set linesize 80

variable n_ts number ;
variable vc_ts_name varchar2(30) ;
variable n_rfile number ;

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

begin
 :n_ts := 42 ;
 :vc_ts_name := 'USERS' ;
 :n_rfile := 4 ;
end ;
/
show error


spool query3h.out

print :n_ts :n_rfile

SELECT sysdate
FROM dual
/

SELECT name , dbid , db_unique_name , database_role
--, current_scn
, created , platform_name
FROM v$database
/

set pagesize 100

--SELECT ts#
--, name
--, INCLUDED_IN_DATABASE_BACKUP
SELECT *
FROM v$tablespace
/

SELECT *
FROM dba_tablespaces
/

SELECT *
FROM ts$
/

SELECT file#
, rfile#
, ts#
, status
, last_change#
, last_time
, unrecoverable_change#
, unrecoverable_time
, checkpoint_change#
, checkpoint_time
, creation_change#
, creation_time
, block1_offset
, name
FROM v$datafile
--WHERE ts# = :n_ts
--OR rfile# = :n_rfile
/

SELECT file_id
, relative_fno
, tablespace_name
, status
, online_status
, file_name
FROM dba_data_files
--WHERE relative_fno = :n_rfile
WHERE tablespace_name = :vc_ts_name
/

set pagesize 40

spool off
