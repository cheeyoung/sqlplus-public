set	pagesize 40
set	linesize 80

variable	n_ts	number	;
variable	n_rfn	number	;
variable	n_afn	number	;
variable	n_block	number	;
variable	n_block_1	number	;
variable	n_block_2	number	;

begin
	:n_ts := 5	;
	:n_rfn := 34	;
	:n_afn := 17	;
	:n_block := 479385 ;
	:n_block_1 := 462708 	;
	:n_block_2 := 345778 	;
end	;
/
--print	:n_rfn	:n_afn	:n_block

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool	query01.out
--	append

SELECT	sysdate
FROM	dual
/

SELECT dbid , name , db_unique_name , database_role
, created , platform_name
FROM v$database
/

SELECT instance_number , instance_name , instance_role
, version , startup_time , parallel , thread#
, host_name
FROM v$instance
/

SELECT	ts#
,	name
FROM	v$tablespace
--WHERE	ts# = :n_ts
/

SELECT	file#
,	rfile#
,	ts#
,	block_size
,	blocks
,	status
,	name
FROM	v$datafile
WHERE	rfile# = :n_rfn
/

SELECT	file#
,	rfile#
,	ts#
,	block_size
,	blocks
,	status
,	name
FROM	v$datafile
WHERE	file# = :n_afn
/

SELECT	file_id
,	block_id
,	blocks
,	owner
,	segment_name
,	segment_type
,	partition_name
,	extent_id
,	tablespace_name
FROM	dba_extents
WHERE	relative_fno = :n_rfn
AND	:n_block	BETWEEN	block_id AND block_id + blocks - 1
/

SELECT	file_id
,	block_id
,	blocks
,	owner
,	segment_name
,	segment_type
,	partition_name
,	extent_id
,	tablespace_name
FROM	dba_extents
WHERE	file_id = :n_afn
AND	:n_block	BETWEEN	block_id AND block_id + blocks - 1
/
spool	off
