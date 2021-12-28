--
--	$ORACLE_HOME/rdbms/admin/utldtree
--	115767.1
--	2014 Oct 02 Created at 17:53
--

variable	vc_type	varchar2(19)	;
variable	vc_schema	varchar2(30)	;
variable	vc_name	varchar2(128)	;

begin
	:vc_type := 'PACKAGE'	;
	:vc_schema := 'SYS'	;
	:vc_name := 'DBMS_RANDOM'	;
end	;
/
show	error

set	linesize	92
set	pagesize	40
set	serveroutput	on

spool	query1b.out

execute	deptree_fill ( type => :vc_type , schema => :vc_schema , name => :vc_name )	;

select	*
from	deptree
order by	seq#
/

execute	dbms_utility.get_dependency ( type => :vc_type , schema => :vc_schema , name => :vc_name )	;

spool	off
