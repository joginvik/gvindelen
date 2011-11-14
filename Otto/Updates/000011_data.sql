SET SQL DIALECT 3;

SET NAMES WIN1251;

INSERT INTO ACTIONCODES (ACTION_SIGN, ACTION_NAME, OBJECT_SIGN, PROCEDURE_NAME)
  VALUES ('INVOICE_PAYSENT', '������� ���������', 'INVOICE', 'INVOICE_STORE');


INSERT INTO ACTIONCODE_CRITERIAS (ACTIONCODE_SIGN, PARAM_NAME, PARAM_KIND, PARAM_ACTION, PARAM_VALUE_1, PARAM_VALUE_2)
  VALUES ('ACCOUNT_STORE', 'ACCOUNT_ID', 'N', 'IS', 'NULL', NULL);


UPDATE ACTIONTREE
SET CHILD_ACTION = 'ACCOUNT_CREATE'
WHERE (ACTIONTREEITEM_ID = 1);

INSERT INTO ACTIONTREE (ACTIONTREEITEM_ID, ACTION_SIGN, ORDER_NO, CHILD_ACTION)
  VALUES (9, 'CLIENT_STORE', 1, 'ACCOUNT_CREATE');


INSERT INTO ATTRS (ATTR_ID, OBJECT_SIGN, ATTR_SIGN, ATTR_NAME, FIELD_NAME, DIRECTION)
  VALUES (208, 'ADRESS', 'POSTINDEX', '������� ������', 'POSTINDEX', NULL);


INSERT INTO STATUSES (STATUS_ID, STATUS_NAME, OBJECT_SIGN, IS_DEFAULT, STATUS_SIGN, ACTION_SIGN, FLAG_SIGN_LIST, STORE_DATE)
  VALUES (236, '������ ����������', 'INVOICE', NULL, 'PAYSENT', NULL, NULL, NULL);


INSERT INTO STATUS_RULES (OLD_STATUS_ID, NEW_STATUS_ID, ACTION_SIGN)
  VALUES (235, 236, 'INVOICE_PAYSENT');


