SET SQL DIALECT 3;

SET NAMES WIN1251;

SET CLIENTLIB 'fbclient.dll';


INSERT INTO ACTIONCODES (ACTION_SIGN, ACTION_NAME, OBJECT_SIGN, PROCEDURE_NAME)
  VALUES ('ORDERITEM_ANULLED', '����������� �������', 'ORDERITEM', 'ORDERITEM_STORE');



INSERT INTO ACTIONCODE_PARAMS (ACTION_SIGN, PARAM_NAME, PARAM_KIND, PARAM_VALUE)
  VALUES ('ORDERITEM_ANULLED', 'ID', 'I', NULL);

INSERT INTO ACTIONCODE_PARAMS (ACTION_SIGN, PARAM_NAME, PARAM_KIND, PARAM_VALUE)
  VALUES ('ORDERITEM_ANULLED', 'NEW.STATUS_SIGN', 'V', 'ANULLED');



UPDATE RECODES
SET RECODED_VALUE = 'ANULLED'
WHERE (OBJECT_SIGN = 'ORDERITEM') AND (ATTR_SIGN = 'DELIVERY_CODE_TIME') AND (ORIGINAL_VALUE = '5');



UPDATE STATUS_RULES
SET ACTION_SIGN = 'ORDERITEM_ANULLED'
WHERE (OLD_STATUS_ID = 180) AND (NEW_STATUS_ID = 181);

INSERT INTO STATUS_RULES (OLD_STATUS_ID, NEW_STATUS_ID, ACTION_SIGN)
  VALUES (184, 181, 'ORDERITEM_ANULLED');


