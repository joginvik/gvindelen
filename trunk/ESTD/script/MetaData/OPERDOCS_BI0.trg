CREATE OR ALTER TRIGGER OPERDOCS_BI0 FOR OPERDOCS
ACTIVE BEFORE INSERT POSITION 0
AS
begin
  new.operdoc_id = gen_id(s_operobj, 1);
end
^