--
-- 15 Oct 2014 Created at 16:51
--
set	pagesize	40
set	linesize	80

variable	vc_column_name	varchar2(30)	;
variable	vc_index_name	varchar2(30)	;
variable	vc_table_name	varchar2(30)	;
variable	vc_c_type	varchar2(1)	;
variable	vc_view_name	varchar2(30)	;
variable	vc_owner_name	varchar2(30)	;

begin
  :vc_column_name := 'CERT_SERIAL_NO_NN1' ;
  :vc_index_name := '' ;
  :vc_table_name := 'PS_SALETRAN_DTL' ;
  :vc_owner_name := 'POS' ;
end	;
/
show	error

print	:vc_owner_name :vc_table_name :vc_c_type

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/
spool	query4i.out	

SELECT sysdate
FROM dual
/
SELECT dbid , name , db_unique_name
--, current_scn
, created , platform_name
FROM v$database
/
SELECT startup_time, instance_number , instance_name
, version , parallel , thread#
, host_name
FROM v$instance
/

--show	parameter	event

SELECT owner
, table_name
, column_name
, nullable
, data_type
, hidden_column
, data_default
FROM dba_tab_cols
WHERE owner = :vc_owner_name
AND table_name = :vc_table_name
AND column_name = :vc_column_name
/

SELECT	owner
,	table_name
,	constraint_name
,	constraint_type
,	status
,	validated
,	invalid
,	deferrable
,	deferred
,	last_change
,	generated
--,	r_owner
,	index_owner
,	index_name
FROM	dba_constraints
--WHERE	constraint_type = :vc_c_type
--WHERE	index_name = :vc_index_name
WHERE	owner = :vc_owner_name
AND	table_name = :vc_table_name
/
spool	off
