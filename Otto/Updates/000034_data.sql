SET SQL DIALECT 3;

SET NAMES WIN1251;

SET CLIENTLIB 'fbclient.dll';


INSERT INTO ATTRS (ATTR_ID, OBJECT_SIGN, ATTR_SIGN, ATTR_NAME, FIELD_NAME, DIRECTION)
  VALUES (926, 'ORDERITEM', 'ORDERITEM_INDEX', '������� � ������', 'ORDERITEM_INDEX', NULL);



INSERT INTO FLAGS2STATUSES (STATUS_ID, FLAG_SIGN)
  VALUES (207, 'APPENDABLE');



INSERT INTO PLACETYPES (PLACETYPE_CODE, PLACETYPE_NAME, ADRTYPE_SHORT, PLACETYPE_SIGN)
  VALUES (9, '������� �������', '��', '��');



INSERT INTO STREETTYPES (STREETTYPE_CODE, STREETTYPE_NAME, STREETTYPE_SHORT, IS_DEFAULT, STREETTYPE_SIGN)
  VALUES (11, '�������', '��-�', NULL, '��-�');

INSERT INTO STREETTYPES (STREETTYPE_CODE, STREETTYPE_NAME, STREETTYPE_SHORT, IS_DEFAULT, STREETTYPE_SIGN)
  VALUES (12, '���', '���', NULL, '���');

INSERT INTO STREETTYPES (STREETTYPE_CODE, STREETTYPE_NAME, STREETTYPE_SHORT, IS_DEFAULT, STREETTYPE_SIGN)
  VALUES (13, '�������', '��', NULL, '��');


