CREATE OR ALTER TRIGGER OPERORGUNITS_BI0 FOR OPERORGUNITS
ACTIVE BEFORE INSERT POSITION 0
AS
begin
  new.operorgunit_id = gen_id(s_operobj, 1);
end
^