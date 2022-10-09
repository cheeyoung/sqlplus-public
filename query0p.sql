--
-- 30 Jan 2019 Updated at 13:36:06
-- 21 Aug 2014 Created at 11:10:42
--
set pagesize 40
set linesize 80

variable vc_owner_name varchar2(30) ;
variable vc_view_name varchar2(30) ;

begin
 :vc_owner_name := 'SEMIHR' ;
 :vc_view_name := 'GV$SEGMENT_STATISTICS' ;
end ;
/
print :vc_view_name

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool query0p.out 

SELECT sysdate
FROM dual
/
SELECT dbid , name , db_unique_name , database_role
--, current_scn
, created , platform_name
FROM v$database
/

SELECT instance_number , instance_name , instance_role
, startup_time , version , parallel , thread#
, host_name
FROM v$instance
/

set	heading	off

SELECT	*
FROM	all_objects	
WHERE owner = :vc_owner_name
AND	object_name = :vc_view_name
/

SELECT	owner
,	view_name
,	text_length
FROM	all_views
WHERE	owner = :vc_owner_name
AND	view_name = :vc_view_name
/

set	long	3673

SELECT	view_name
,	view_definition
--,	con_id
FROM	v$fixed_view_definition
WHERE	view_name = :vc_view_name
/

SELECT	text
FROM	all_views
WHERE	owner = :vc_owner_name
AND	view_name = :vc_view_name
/
spool	off

set	heading	on
