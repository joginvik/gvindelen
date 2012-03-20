SET SQL DIALECT 3;

SET NAMES WIN1251;

SET CLIENTLIB 'fbclient.dll';



INSERT INTO OBJECTS (OBJECT_SIGN, OBJECT_NAME, TABLE_NAME, IDFIELD_NAME, ATTR_TABLE_NAME, PROCEDURE_READ)
  VALUES ('WAY', '����������� ������������ ������', 'WAYS', 'WAY_ID', NULL, NULL);



INSERT INTO ACTIONCODES (ACTION_SIGN, ACTION_NAME, OBJECT_SIGN, PROCEDURE_NAME)
  VALUES ('ORDERITEM_PREPACK', '��������������� �������', 'ORDERITEM', 'ORDERITEM_STORE');

INSERT INTO ACTIONCODES (ACTION_SIGN, ACTION_NAME, OBJECT_SIGN, PROCEDURE_NAME)
  VALUES ('ORDER_PREPACKED', '� ��������', 'ORDER', 'ORDER_STORE');



INSERT INTO ACTIONCODE_PARAMS (ACTION_SIGN, PARAM_NAME, PARAM_KIND, PARAM_VALUE)
  VALUES ('ORDERITEM_PREPACK', 'ID', 'I', NULL);

INSERT INTO ACTIONCODE_PARAMS (ACTION_SIGN, PARAM_NAME, PARAM_KIND, PARAM_VALUE)
  VALUES ('ORDERITEM_PREPACK', 'NEW.STATUS_SIGN', 'V', 'PREPACKED');

INSERT INTO ACTIONCODE_PARAMS (ACTION_SIGN, PARAM_NAME, PARAM_KIND, PARAM_VALUE)
  VALUES ('ORDER_PREPACKED', 'ID', 'I', NULL);

INSERT INTO ACTIONCODE_PARAMS (ACTION_SIGN, PARAM_NAME, PARAM_KIND, PARAM_VALUE)
  VALUES ('ORDER_PREPACKED', 'NEW.STATUS_SIGN', 'V', 'PREPACKED');



INSERT INTO ATTRS (ATTR_ID, OBJECT_SIGN, ATTR_SIGN, ATTR_NAME, FIELD_NAME, DIRECTION)
  VALUES (1906, 'ORDERMONEY', 'AMOUNT_BYR', '����� ������� � BYR', 'AMOUNT_BYR', NULL);



INSERT INTO STATUSES (STATUS_ID, STATUS_NAME, OBJECT_SIGN, IS_DEFAULT, STATUS_SIGN, ACTION_SIGN, FLAG_SIGN_LIST, STORE_DATE, ISSTATE)
  VALUES (72, '�������� � ������������', 'WAY', NULL, 'IN_COPY', NULL, ',INBOUND,', NULL, NULL);

INSERT INTO STATUSES (STATUS_ID, STATUS_NAME, OBJECT_SIGN, IS_DEFAULT, STATUS_SIGN, ACTION_SIGN, FLAG_SIGN_LIST, STORE_DATE, ISSTATE)
  VALUES (73, '�������� � ������������', 'WAY', NULL, 'IN_MOVE', NULL, ',DELETE,INBOUND,', NULL, NULL);

INSERT INTO STATUSES (STATUS_ID, STATUS_NAME, OBJECT_SIGN, IS_DEFAULT, STATUS_SIGN, ACTION_SIGN, FLAG_SIGN_LIST, STORE_DATE, ISSTATE)
  VALUES (74, '��������� � ������������', 'WAY', NULL, 'OUT_COPY', NULL, ',OUTBOUND,', NULL, NULL);

INSERT INTO STATUSES (STATUS_ID, STATUS_NAME, OBJECT_SIGN, IS_DEFAULT, STATUS_SIGN, ACTION_SIGN, FLAG_SIGN_LIST, STORE_DATE, ISSTATE)
  VALUES (75, '�������� � ������������', 'WAY', NULL, 'OUT_MOVE', NULL, ',DELETE,OUTBOUND,', NULL, NULL);

INSERT INTO STATUSES (STATUS_ID, STATUS_NAME, OBJECT_SIGN, IS_DEFAULT, STATUS_SIGN, ACTION_SIGN, FLAG_SIGN_LIST, STORE_DATE, ISSTATE)
  VALUES (281, '������� ���������', 'ORDER', NULL, 'PREPACKSENT', NULL, NULL, NULL, 1);

INSERT INTO STATUSES (STATUS_ID, STATUS_NAME, OBJECT_SIGN, IS_DEFAULT, STATUS_SIGN, ACTION_SIGN, FLAG_SIGN_LIST, STORE_DATE, ISSTATE)
  VALUES (282, '��������� ������������', 'ORDER', NULL, 'INVOICED', NULL, NULL, NULL, 1);

INSERT INTO STATUSES (STATUS_ID, STATUS_NAME, OBJECT_SIGN, IS_DEFAULT, STATUS_SIGN, ACTION_SIGN, FLAG_SIGN_LIST, STORE_DATE, ISSTATE)
  VALUES (283, '��������� ����������', 'ORDER', NULL, 'INVOICEPRINTED', NULL, NULL, NULL, 1);



INSERT INTO FLAGS (FLAG_SIGN, FLAG_NAME, GROUP_NO)
  VALUES ('DELETE', '�������', NULL);

INSERT INTO FLAGS (FLAG_SIGN, FLAG_NAME, GROUP_NO)
  VALUES ('INBOUND', '��������', NULL);

INSERT INTO FLAGS (FLAG_SIGN, FLAG_NAME, GROUP_NO)
  VALUES ('OUTBOUND', '���������', NULL);



INSERT INTO FLAGS2STATUSES (STATUS_ID, FLAG_SIGN)
  VALUES (72, 'INBOUND');

INSERT INTO FLAGS2STATUSES (STATUS_ID, FLAG_SIGN)
  VALUES (73, 'DELETE');

INSERT INTO FLAGS2STATUSES (STATUS_ID, FLAG_SIGN)
  VALUES (73, 'INBOUND');

INSERT INTO FLAGS2STATUSES (STATUS_ID, FLAG_SIGN)
  VALUES (74, 'OUTBOUND');

INSERT INTO FLAGS2STATUSES (STATUS_ID, FLAG_SIGN)
  VALUES (75, 'DELETE');

INSERT INTO FLAGS2STATUSES (STATUS_ID, FLAG_SIGN)
  VALUES (75, 'OUTBOUND');

INSERT INTO FLAGS2STATUSES (STATUS_ID, FLAG_SIGN)
  VALUES (173, 'DELETEABLE');

INSERT INTO FLAGS2STATUSES (STATUS_ID, FLAG_SIGN)
  VALUES (189, 'AVAILABLE');

INSERT INTO FLAGS2STATUSES (STATUS_ID, FLAG_SIGN)
  VALUES (189, 'CREDIT');



INSERT INTO PORTS (PORT_ID, PORT_NAME, PORT_ADRESS)
  VALUES (1, 'FTP www.otto-moda.by', 'ftp://otto-moda:HW78wTAO@myweb02.bn.by:21');

INSERT INTO PORTS (PORT_ID, PORT_NAME, PORT_ADRESS)
  VALUES (2, 'FTP www.otto.by', 'ftp://ottoby:R3H6vJnajc@ottoby.delink-hosting.net:21');

INSERT INTO PORTS (PORT_ID, PORT_NAME, PORT_ADRESS)
  VALUES (3, '��������� ����� �� ������', 'ftp://n2CJ2KXY6u:UcuxmdLGGL@ftpex.app.schwab.de:21');

INSERT INTO PORTS (PORT_ID, PORT_NAME, PORT_ADRESS)
  VALUES (4, 'FTP �������������� ����� otto', 'ftp://nastya:12345678@by111.atservers.net:21');



UPDATE TEMPLATES
SET FILENAME_MASK = 'liefau[[:ALNUM :]]{2}_[[:DIGIT:]]{8}.[[:DIGIT:]]{3}'
WHERE (TEMPLATE_ID = 4);

INSERT INTO TEMPLATES (TEMPLATE_ID, FILENAME_MASK, PLUGIN_NAME)
  VALUES (10, 'info_[[:DIGIT:]]{8}_[[:DIGIT:]]{5,6}_2pay_[[:DIGIT:]]{3}.txt', 'Info2Pay');



INSERT INTO STATUS_RULES (OLD_STATUS_ID, NEW_STATUS_ID, ACTION_SIGN)
  VALUES (180, 189, 'ORDERITEM_PREPACK');

INSERT INTO STATUS_RULES (OLD_STATUS_ID, NEW_STATUS_ID, ACTION_SIGN)
  VALUES (184, 189, 'ORDERITEM_PREPACK');

INSERT INTO STATUS_RULES (OLD_STATUS_ID, NEW_STATUS_ID, ACTION_SIGN)
  VALUES (205, 213, 'ORDER_PREPACKED');



INSERT INTO WAYS (WAY_ID, PORT_ID, PORT_PATH, LOCAL_PATH, FILE_MASK, STATUS_ID)
  VALUES (1, 1, 'httpdocs/orders/73105061', 'Messages/In', '*.*', 73);

INSERT INTO WAYS (WAY_ID, PORT_ID, PORT_PATH, LOCAL_PATH, FILE_MASK, STATUS_ID)
  VALUES (2, 1, 'httpdocs/orders/73105050', 'Messages/In', '*.*', 73);

INSERT INTO WAYS (WAY_ID, PORT_ID, PORT_PATH, LOCAL_PATH, FILE_MASK, STATUS_ID)
  VALUES (3, 2, 'htdocs/orders/73105061', 'Messages/In', '*.*', 73);

INSERT INTO WAYS (WAY_ID, PORT_ID, PORT_PATH, LOCAL_PATH, FILE_MASK, STATUS_ID)
  VALUES (4, 2, 'htdocs/orders/73105050', 'Messages/In', '*.*', 73);

INSERT INTO WAYS (WAY_ID, PORT_ID, PORT_PATH, LOCAL_PATH, FILE_MASK, STATUS_ID)
  VALUES (5, 3, 'out', 'Messages/In', 'n-a*.*', 72);

INSERT INTO WAYS (WAY_ID, PORT_ID, PORT_PATH, LOCAL_PATH, FILE_MASK, STATUS_ID)
  VALUES (6, 3, 'out', 'Messages/In', 'n-s*.*', 72);

INSERT INTO WAYS (WAY_ID, PORT_ID, PORT_PATH, LOCAL_PATH, FILE_MASK, STATUS_ID)
  VALUES (7, 3, 'out', 'Messages/In', 'liefau??_*.*', 72);

INSERT INTO WAYS (WAY_ID, PORT_ID, PORT_PATH, LOCAL_PATH, FILE_MASK, STATUS_ID)
  VALUES (8, 3, 'out', 'Messages/In', 't-cons*.*', 72);

INSERT INTO WAYS (WAY_ID, PORT_ID, PORT_PATH, LOCAL_PATH, FILE_MASK, STATUS_ID)
  VALUES (9, 3, 'out', 'Messages/In', 'info_*_artn*.txt', 72);

INSERT INTO WAYS (WAY_ID, PORT_ID, PORT_PATH, LOCAL_PATH, FILE_MASK, STATUS_ID)
  VALUES (10, 3, 'out', 'Messages/In', 'info_*_2pay*.txt', 72);


