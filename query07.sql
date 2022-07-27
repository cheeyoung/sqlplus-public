--
-- 22 Sep 2014 Updated at 12:54:16
-- 09 May 2014 Created at 15:40:06
--
set	pagesize	40
set	linesize	80

--SELECT  substr(schema_name, 1, 30)
--,       space_usage_kbytes
--,       occupant_name
--,       occupant_desc
--FROM    v$sysaux_occupants
--ORDER BY        space_usage_kbytes
--/

variable	vc_own_name	varchar2(30)	;
variable	vc_seg_name	varchar2(80)	;
variable	vc_seg_type	varchar2(18)	;
variable	n_unf_blocks	number	;
variable	n_unf_bytes	number	;
variable	n_fs1_blocks	number	;
variable	n_fs1_bytes	number	;
variable	n_fs2_blocks	number	;
variable	n_fs2_bytes	number	;
variable	n_fs3_blocks	number	;
variable	n_fs3_bytes	number	;
variable	n_fs4_blocks	number	;
variable	n_fs4_bytes	number	;
variable	n_full_blocks	number	;
variable	n_full_bytes	number	;

begin
	:vc_own_name := 'ORAIMSADMIN'	;
	:vc_seg_name := 'TBI_AGE_FM03_FRESULT_ALL2'	;
	:vc_seg_type := 'TABLE'	;
end	;
/
show	error

print	:vc_own_name	:vc_seg_name	:vc_seg_type

begin
	dbms_space.space_usage( segment_owner => :vc_own_name , segment_name => :vc_seg_name , segment_type => :vc_seg_type , unformatted_blocks => :n_unf_blocks , unformatted_bytes => :n_unf_bytes , fs1_blocks => :n_fs1_blocks , fs1_bytes => :n_fs1_bytes , fs2_blocks => :n_fs2_blocks , fs2_bytes => :n_fs2_bytes , fs3_blocks => :n_fs3_blocks , fs3_bytes => :n_fs3_bytes , fs4_blocks => :n_fs4_blocks , fs4_bytes => :n_fs4_bytes , full_blocks => :n_full_blocks , full_bytes => :n_full_bytes , partition_name => NULL )	;

end	;
/
show	error

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'
/

spool	query07.out	append

SELECT	sysdate
FROM	dual
/

print	:vc_own_name	:vc_seg_name	:vc_seg_type

print	:n_unf_blocks	:n_unf_bytes
print	:n_fs1_blocks	:n_fs1_bytes
print	:n_fs2_blocks	:n_fs2_bytes
print	:n_fs3_blocks	:n_fs3_bytes
print	:n_fs4_blocks	:n_fs4_bytes
print	:n_full_blocks	:n_full_bytes

spool	off
