--
-- Updated at 10:52:36 on 19 November 2018
--
set	linesize	80
set	pagesize	40

variable	vc_own_name	varchar2(30)	;
variable	vc_tab_name	varchar2(30)	;

begin
  :vc_own_name := 'DVSYS'	;
  :vc_tab_name := 'POLICY_OWNER$' ;
end	;
/
show	error

print	:vc_own_name	:vc_tab_name

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool	query63.out	

SELECT	sysdate
FROM	dual
/

SELECT dbid , name , db_unique_name , database_role
--, current_scn
, created , platform_name
FROM v$database
/

SELECT instance_number , instance_name , instance_role
, parallel , thread# , version
, startup_time , host_name
FROM v$instance
/

--desc	table

SELECT	owner
,	table_name
,	last_analyzed
,	cache
,	buffer_pool
--,	compression
--,	compress_for
,	monitoring
FROM	dba_tables
WHERE	owner = :vc_own_name
AND	table_name = :vc_tab_name
AND	monitoring = 'YES'
/

SELECT	*
FROM	all_tab_modifications
WHERE	table_owner = :vc_own_name
AND	table_name = :vc_tab_name
/

--	See query4i for constraints

SELECT	owner
,	table_name
,	column_name
,	endpoint_number
,	endpoint_value
,	endpoint_actual_value
--,	endpoint_repeat_count
--,	scope
FROM	dba_tab_histograms
WHERE	owner = :vc_own_name
AND	table_name = :vc_tab_name
/
spool	off
