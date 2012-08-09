unit uParsePayments;

interface

uses
  NativeXml, FIBDatabase, pFIBDatabase;

procedure ProcessPayment(aMessageId: Integer; aTransaction: TpFIBTransaction);

implementation

uses
  Classes, SysUtils, GvStr, udmOtto, Variants, GvNativeXml,
  Dialogs, Controls, GvDtTm;

procedure ParsePaymentLine(aMessageId, LineNo: Integer; aLine: string; aTransaction: TpFIBTransaction);
var
  sl: TStringList;
  PayDate: TDateTime;
  PaymentId, OrderId: Variant;
  Xml: TNativeXml;
  ndOrder, ndOrderMoneys, ndorderMoney, ndPayment: TXmlNode;
begin
  Xml:= TNativeXml.CreateName('PAYMENT');
  ndPayment:= Xml.Root;
  ndOrder:= ndPayment.NodeNew('ORDER');
  ndOrderMoneys := ndOrder.NodeNew('ORDERMONEYS');
  sl:= TStringList.Create;
  try
    sl.Delimiter:= ';';
    sl.DelimitedText:= '"'+ReplaceAll(aLine, ';', '";"')+'"';

    PayDate:= DateTimeStrEval('DD.MM.YYYY', sl[0]);

    PaymentId:= dmOtto.GetNewObjectId('PAYMENT');
    SetXmlAttr(ndPayment, 'ID', PaymentId);
    SetXmlAttr(ndPayment, 'MESSAGE_ID', aMessageId);
    SetXmlAttr(ndPayment, 'CREATE_DT', PayDate);
    SetXmlAttrAsMoney(ndPayment, 'AMOUNT_BYR', sl[1]);
    SetXmlAttr(ndPayment, 'NOTES', sl[2]);
    SetXmlAttr(ndPayment, 'ORDER_CODE', sl[3]);
    dmOtto.ActionExecute(aTransaction, ndPayment);

    OrderId:= aTransaction.DefaultDatabase.QueryValue(
      'select order_id from orders where order_code like ''%''||:order_code',
      0, [FilterString(sl[3], '0123456789')], aTransaction);
    if OrderId <> null then
    begin
      dmOtto.ObjectGet(ndOrder, OrderId, aTransaction);
      dmOtto.OrderMoneysGet(ndOrderMoneys, OrderId, aTransaction);

      // ��������� �� ��������� ����������
      ndOrderMoney:= ChildByAttributes(ndOrderMoneys, 'AMOUNT_BYR', [sl[1]]);
      if ndorderMoney = nil then
      begin
        try
          dmOtto.ActionExecute(aTransaction, 'ACCOUNT', 'ACCOUNT_PAYMENTIN',
            XmlAttrs2Vars(ndOrder, 'ORDER_ID=ID;ID=ACCOUNT_ID',
            XmlAttrs2Vars(ndPayment, 'AMOUNT_BYR')));

          dmOtto.ActionExecute(aTransaction, ndPayment, 'ASSIGNED');
          dmOtto.Notify(aMessageId,
            '[LINE_NO]. ����� [AMOUNT_BYR] BYR ��������� �� ������ [ORDER_CODE]',
            'I',
            XmlAttrs2Vars(ndOrder, 'ORDER_CODE',
            Strings2Vars(sl, 'AMOUNT_BYR=1',
            Value2Vars(LineNo, 'LINE_NO'))));
        except
          on E: Exception do
            dmOtto.Notify(aMessageId,
              '[LINE_NO]. ����� [AMOUNT_BYR] BYR. ������ [ORDER_CODE]. [ERROR_TEXT]',
              'E',
              XmlAttrs2Vars(ndOrder, 'ORDER_CODE',
              Strings2Vars(sl, 'AMOUNT_BYR=1',
              Value2Vars(LineNo, 'LINE_NO',
              Value2Vars(E.Message, 'ERROR_TEXT')))));
        end;
      end;
    end
    else
      dmOtto.Notify(aMessageId,
        '[LINE_NO]. ����� [AMOUNT_BYR] BYR. ����������� ������ [ORDER_CODE]',
        'E',
        Strings2Vars(sl, 'ORDER_CODE=3;AMOUNT_BYR=1',
        Value2Vars(LineNo, 'LINE_NO')));

  finally
    sl.Free;
    Xml.Free;
  end;
end;

procedure ParsePayment(aMessageId: Integer; ndMessage: TXmlNode; aTransaction: TpFIBTransaction);
var
  LineNo: Integer;
  Lines: TStringList;
  MessageFileName: variant;
  ndOrders: TXmlNode;
begin
  dmOtto.ClearNotify(aMessageId);
  if not aTransaction.Active then
    aTransaction.StartTransaction;
  try
    dmOtto.ObjectGet(ndMessage, aMessageId, aTransaction);
    ndOrders:= ndMessage.NodeFindOrCreate('ORDERS');

    MessageFileName:= GetXmlAttrValue(ndMessage, 'FILE_NAME');
    dmOtto.Notify(aMessageId,
      '������ ��������� �����: [FILE_NAME]', '',
      Value2Vars(MessageFileName, 'FILE_NAME'));


    if FileExists(Path['Messages.In']+MessageFileName) then
    begin
      Lines:= TStringList.Create;
      try
        Lines.LoadFromFile(Path['Messages.In']+MessageFileName);
        For LineNo:= 0 to Lines.Count - 1 do
          ParsePaymentLine(aMessageId, LineNo, Lines[LineNo], aTransaction);
      finally
        Lines.Free;
      end;
    end
    else
      dmOtto.Notify(aMessageId,
        '���� [FILE_NAME] �� ������.', 'E',
        Value2Vars(MessageFileName, 'FILE_NAME'));

    dmOtto.Notify(aMessageId,
      '����� ��������� �����: [FILE_NAME]', '',
      Value2Vars(MessageFileName, 'FILE_NAME'));
    dmOtto.ShowProtocol(aTransaction, aMessageId);
    dmOtto.MessageCommit(aTransaction, aMessageId);
  except
    aTransaction.Rollback;
  end
end;

procedure ProcessPayment(aMessageId: Integer; aTransaction: TpFIBTransaction);
var
  aXml: TNativeXml;
begin
  aXml:= TNativeXml.CreateName('MESSAGE');
  try
    ParsePayment(aMessageId, aXml.Root, aTransaction);
  finally
    aXml.Free;
  end;
end;


end.
