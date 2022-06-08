/*	315631.1
*/
--connect	/ as sysdba

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/
set pagesize 40
set linesize 80

spool query03.out
-- append

SELECT	sysdate
FROM	dual
/
SELECT dbid , name , db_unique_name
--, current_scn
, database_role , created , platform_name
FROM v$database
/
SELECT instance_number , instance_name , instance_role
, parallel , thread# , startup_time, version
, host_name
FROM v$instance
/

show	parameter	event
show	parameter	db_lost_write_protect

SELECT	x.ksppinm
,	y.ksppstvl
,	x.ksppdesc
--, x.ksppiflg
--,	decode(bitand(x.ksppiflg/256,1),1,'TRUE','FALSE') IS_SESSION_MODIFIABLE
--,	decode(bitand(x.ksppiflg/65536,3),1,'IMMEDIATE',2,'DEFERRED',3,'IMMEDIATE','FALSE') IS_SYSTEM_MODIFIABLE
FROM	x$ksppi	x
--,	x$ksppcv	y	-- session values
,	x$ksppsv	y	-- system values
WHERE	x.indx = y.indx
AND	x.ksppinm = '_highthreshold_undoretention'
--ORDER BY	x.ksppinm
/
spool	off
