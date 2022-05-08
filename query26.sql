/*
 v$_sequences
 seq$
*/
set linesize 80
set pagesize 40

--connect / as sysdba

variable n_obj number ;

begin
  :n_obj := 16860911 ;
end ;
/
show error

spool query26.out

print :n_obj

SELECT name , dbid , database_role , db_unique_name
, created ,  platform_name
FROM v$database
/

SELECT instance_number , instance_name , instance_role
, startup_time , version , parallel , thread#
, host_name
FROM v$instance
/

--SELECT cache_size
--, highwater
--, object#
--, sequence_owner
--, sequence_name
SELECT *
FROM v$_sequences
--WHERE sequence_owner = 'USER01'
--AND sequence_name = 'SEQ01'
WHERE object# = :n_obj
/

SELECT *
FROM seq$
WHERE obj# = :n_obj
/

spool off
