CREATE OR ALTER TRIGGER OPERDOCATTRS_BI0 FOR OPERDOCATTRS
ACTIVE BEFORE INSERT POSITION 0
AS
begin
  new.attr_id = gen_id(s_operdocattrs, 1);
end
^