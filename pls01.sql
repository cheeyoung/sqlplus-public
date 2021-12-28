--
-- 20110510 Created at 19:33, A2030 Tru64
--
variable        vc_str  varchar2(4000 byte)     ;
variable        n_base  number  ;
variable        n_size  number  ;

begin
        :vc_str := 'dbms_utility.get_has_value' ;
        :n_base := 1000 ;
        :n_size := 2048 ;
end     ;
/

print   :vc_str :n_base :n_size

SELECT  dbms_utility.get_hash_value
        (       :vc_str
        ,       :n_base
        ,       :n_size
        )       "Hash value"
FROM    dual
/
