CREATE OR ALTER TRIGGER OPERHALFS_BI0 FOR OPERHALFS
ACTIVE BEFORE INSERT POSITION 0
AS
begin
  new.operhalf_id = gen_id(s_operobj, 1);
end
^