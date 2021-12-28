/*
	retention_(type|value) columns are available from 11.2.0.2
*/
set	pagesize 40
set	linesize 80

variable	vc_own_name	varchar2(30)	;
variable	vc_tab_name	varchar2(30)	;
variable	vc_col_name	varchar2(4000)	;
variable	vc_seg_name	varchar2(30)	;

begin
 :vc_own_name := 'SFM_MGR' ;
 :vc_tab_name := 'LIB_DATA' ;
 :vc_seg_name := 'SL_ALL_TLGM' ;
end	;
/
print	:vc_own_name	:vc_seg_name

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool	query3x.out

SELECT	sysdate
FROM	dual
/

SELECT name , dbid , db_unique_name , database_role
--, current_scn
, created , platform_name
FROM v$database
/

show parameter undo

--desc LIB_DATA

SELECT owner
, table_name
, column_name
, tablespace_name
, chunk
, pctversion
, retention
, cache
, logging
, encrypt
, compression
, deduplication
, in_row
, securefile
, segment_created
, segment_name
, index_name
, partitioned
, format
, freepools
, retention_type
, retention_value
FROM dba_lobs
WHERE owner = :vc_own_name
--AND	segment_name = :vc_seg_name
AND	table_name = :vc_tab_name
/


SELECT table_owner
, table_name
, column_name
, tablespace_name
, chunk
, pctversion
, retention
, cache
, logging
, encrypt
, compression
, deduplication
, in_row
, securefile
, segment_created
FROM dba_lob_partitions
WHERE table_owner = :vc_own_name
--AND	segment_name = :vc_seg_name
AND	table_name = :vc_tab_name
/

spool	off
