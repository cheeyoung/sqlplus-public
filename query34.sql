--connect	/ as sysdba

set	pagesize	40
set	linesize	80

variable	vc_ts_name	varchar2(30)	;

begin
	:vc_ts_name := 'TEMP'	;
end	;
/
show	error

SELECT	file_id
,	block_id
,	blocks
FROM	dba_free_space
WHERE	tablespace_name = :vc_ts_name
/
