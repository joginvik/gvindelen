SET SQL DIALECT 3;

SET NAMES WIN1251;

SET CLIENTLIB 'fbclient.dll';


INSERT INTO ACTIONCODES (ACTION_SIGN, ACTION_NAME, OBJECT_SIGN, PROCEDURE_NAME)
  VALUES ('ORDER_UPDATECOST', '�������� ���������', 'ORDER', NULL);


COMMIT WORK;

UPDATE ATTRS
SET FIELD_NAME = 'NAME_RUS'
WHERE (ATTR_ID = 910);

UPDATE ATTRS
SET FIELD_NAME = 'KIND_RUS'
WHERE (ATTR_ID = 911);

UPDATE ATTRS
SET FIELD_NAME = 'WEIGHT'
WHERE (ATTR_ID = 921);


COMMIT WORK;
