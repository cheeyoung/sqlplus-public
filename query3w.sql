--
-- 13 Apr 2017 Updated at 16:45
-- 21 Mar 2014 Created at 17:42
--
set	pagesize	40
set	linesize	80

variable	n_scn	number	;

alter session set NLS_TIMESTAMP_FORMAT = 'YYYY-MM-DD HH24:MI:SS.FF'
/
alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

--
-- scn: 0x0cfd.790ba872 = 0x0cfd790ba872 = 14282797066354
-- scn: 0x0cfd.790ba8aa = 0x0cfd790ba8aa = 14282797066410
-- scn: 0x0d0d.fafd5d91 = 0x0d0dfafd5d91 = 14353696644497
--

begin
	:n_scn := 1643707631	;
	:n_scn := 4093762135	;
	:n_scn := 1044417	;
end	;
/
show	error

spool	query3w.out

print	:n_scn

SELECT	systimestamp
FROM	dual
/

SELECT	sysdate
FROM	dual
/

SELECT	dbid
,	name
,	db_unique_name
,	platform_name
,	current_scn
,	created
FROM	v$database
/

SELECT	startup_time
,	instance_number
,	instance_name
,	version
,	parallel
,	thread#
,	host_name
FROM	v$instance
/

SELECT	timestamp_to_scn(systimestamp)
FROM	dual
/

SELECT	scn_to_timestamp(:n_scn)
FROM	dual
/
spool	off
