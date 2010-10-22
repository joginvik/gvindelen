CREATE OR ALTER PROCEDURE BLOCK_13_GEN (
    I_DOCFORM TYPE OF SIGN_DOCFORM NOT NULL,
    I_DOCUMENT_ID TYPE OF ID_OBJECT NOT NULL,
    I_BLOCK_SIGN TYPE OF SIGN_BLOCK NOT NULL)
AS
declare variable V_BLOCK_ID type of ID_BLOCK;
declare variable V_OPER_ID type of ID_OPER;
declare variable V_OPEROBJ_ID type of ID_OPEROBJ;
begin
  execute procedure param_get('Oper_Id') returning_values :v_oper_id;

  select first 1 oo.opermat_id
    from opermats oo
    where oo.oper_id = :v_oper_id
    into :v_operobj_id;
  if (row_count = 0) then
    exit;

  execute procedure block_new(trim(:i_docform), :i_document_id, :i_block_sign)
    returning_values :v_block_id;
  for select oo.opermat_id
        from opermats oo
          inner join objects o on (o.obj_id = oo.material_id)
        where oo.oper_id = :v_oper_id
        order by o.objtype, o.obj_label
        into :v_operobj_id do
  begin
    execute procedure param_set('OperObj_Id', :v_operobj_id);
    execute procedure bands_gen(trim(:i_docform), :i_document_id, :i_block_sign, :v_block_id);

--    execute procedure blocks_gen(:i_OBJTYPE, :i_document_id, :i_block_sign);
  end
end