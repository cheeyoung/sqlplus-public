--
-- 04 Jan 2016 Updated at 15:53:34
-- 
--
set	pagesize	40
set	linesize	80

variable	vc_sql_id	varchar2(13)	;

begin
  :vc_sql_id := '0vwm0tan12qkp' ;
end	;
/
show	error

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool	query0n.out

print	:vc_sql_id

SELECT	sysdate
FROM	dual
/

SELECT	name
,	dbid
,	db_unique_name
,	created
,	platform_name
FROM	v$database
/

SELECT	instance_number
,	instance_name
,	parallel
,	thread#
,	host_name
FROM	v$instance
/
show	parameter	cursor

SELECT	c.sid
,	c.user_name
,	c.sql_id
,	c.cursor_type
--,	c.sql_text
FROM	v$open_cursor	c
WHERE	c.cursor_type = 'SESSION CURSOR CACHED'
AND	sql_id = :vc_sql_id
/
spool 	off
