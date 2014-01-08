unit uExportCancellation;
interface
uses
  Classes, Controls, SysUtils, FIBDatabase, pFIBDatabase;

procedure ExportCancelRequest(aTransaction: TpFIBTransaction);

implementation

uses
  GvXml, GvXmlUtils, udmOtto, GvStr, GvFile, GvDtTm, DateUtils, Dialogs;

function ExportOrderItem(aTransaction: TpFIBTransaction;
  ndProduct, ndOrder, ndOrderItems: TGvXmlNode; aOrderItemId: integer): string;
var
  ndOrderItem: TGvXmlNode;
  Line: TStringList;
begin
  Line:= TStringList.Create;
  try
    ndOrderItem:= ndOrderItems.AddChild('ORDERITEM');
    dmOtto.ObjectGet(ndOrderItem, aOrderItemId, aTransaction);
    Line.Add(ndProduct['PARTNER_NUMBER']);
    Line.Add(CopyLast(ndOrder['ORDER_CODE'], 5));
    Line.Add('900');
    Line.Add(ndOrderItem['AUFTRAG_ID']);
    Line.Add(ndOrderItem['ORDERITEM_INDEX']);
    Line.Add(ndOrderItem['ARTICLE_CODE']);
    Line.Add(dmOtto.Recode('ORDERITEM', 'DIMENSION_ENCODE', ndOrderItem['DIMENSION']));
    Line.Add('1');
    Result:= ReplaceAll(Line.Text, #13#10, ';')+#13#10;
    ndOrderItem['NEW.STATE_SIGN']:= 'CANCELREQUESTSENT';
    dmOtto.ActionExecute(aTransaction, ndOrderItem);
  finally
    Line.Free;
  end;
end;

function ExportOrder(aTransaction: TpFIBTransaction;
  ndProduct, ndOrders: TGvXmlNode; aOrderId: integer): string;
var
  OrderItemList: string;
  ndOrder, ndOrderItems: TGvXmlNode;
  OrderItemId: Variant;
begin
  Result:= '';
  ndOrder:= ndOrders.AddChild('ORDER');
  ndOrderItems:= ndOrder.AddChild('ORDERITEMS');
  dmOtto.ObjectGet(ndOrder, aOrderId, aTransaction);
  OrderItemList:= aTransaction.DefaultDatabase.QueryValue(
    'select list(orderitem_id) from '+
    '(select oi.orderitem_id '+
    ' from orderitems oi '+
    '  inner join statuses s1 on (s1.status_id = oi.status_id and s1.status_sign = ''CANCELREQUEST'') '+
    '  left join statuses s2 on (s2.status_id = oi.state_id) '+
    ' where coalesce(s2.status_sign, '''')  <> ''CANCELREQUESTSENT'' '+
    '  and oi.order_id = :order_id '+
    'order by oi.auftrag_id, oi.orderitem_index)',
    0, [aOrderId], aTransaction);
  while OrderItemList <> '' do
  begin
    OrderItemId:= TakeFront5(OrderItemList, ',');
    result:= Result + ExportOrderItem(aTransaction, ndProduct, ndOrder, ndOrderItems, OrderItemId);
  end;
end;

procedure ExportProduct(aTransaction: TpFIBTransaction;
  ndProducts: TGvXmlNode; aProductId: integer);
var
  ndProduct, ndOrders: TGvXmlNode;
  OrderList, FileName, Text: string;
  OrderId: variant;
begin
  Text:= '';
  try
    ndProduct:= ndProducts.AddChild('PRODUCT');
    ndOrders:= ndProduct.AddChild('ORDERS');
    dmOtto.ObjectGet(ndProduct, aProductId, aTransaction);
    OrderList:= aTransaction.DefaultDatabase.QueryValue(
      'select list(distinct order_id) from ('+
      'select o.order_id, o.order_code '+
      'from orderitems oi '+
      'inner join statuses s1 on (s1.status_id = oi.status_id and s1.status_sign = ''CANCELREQUEST'') '+
      'left join statuses s2 on (s2.status_id = oi.state_id) '+
      'inner join orders o on (o.order_id = oi.order_id) '+
      'where coalesce(s2.status_sign, '''')  <> ''CANCELREQUESTSENT'' '+
      '  and o.product_id = :product_id '+
      'order by o.order_code)',
      0, [aProductId], aTransaction);
    while OrderList <> '' do
    begin
      OrderId:= TakeFront5(OrderList, ',');
      Text:= Text + ExportOrder(aTransaction, ndProduct, ndOrders, OrderId);
    end;
    ForceDirectories(Path['CancelRequests']);
    FileName:= GetNextFileName(Format('%ss%s_%.1u%%.1u.%.3d', [
      Path['CancelRequests'], ndProduct['PARTNER_NUMBER'],
      Integer(dmOtto.DealerId), DayOfTheYear(Date)]));
    SaveStringAsFile(Text, FileName);
    dmOtto.CreateAlert('������ �� ��������', Format('����������� ���� %s', [ExtractFileName(FileName)]), mtInformation, 10000);
  except
    dmOtto.CreateAlert('������ �� ��������', Format('������ ��� ������������ ����� %s', [ExtractFileName(FileName)]), mtError, 10000);
  end;
end;

procedure ExportCancelRequest(aTransaction: TpFIBTransaction);
var
  Xml: TGvXml;
  ndProducts: TGvXmlNode;
  ProductId: Variant;
  ProductList: string;
begin
  aTransaction.StartTransaction;
  try
    xml:= TGvXml.Create('PRODUCTS');
    try
      ndProducts:= Xml.Root;
      ProductList:= aTransaction.DefaultDatabase.QueryValue(
        'select list(distinct o.product_id) '+
        'from orderitems oi '+
        'inner join statuses s1 on (s1.status_id = oi.status_id and s1.status_sign = ''CANCELREQUEST'') '+
        'left join statuses s2 on (s2.status_id = oi.state_id) '+
        'inner join orders o on (o.order_id = oi.order_id)' +
        'where coalesce(s2.status_sign, '''')  <> ''CANCELREQUESTSENT''',
         0, aTransaction);
      while ProductList <> '' do
      begin
        ProductId:= TakeFront5(ProductList, ',');
        ExportProduct(aTransaction, ndProducts, ProductId);
      end;

      dmOtto.ExportCommitRequest(ndProducts, aTransaction);
    finally
      Xml.Free;
    end;
  except
    on E: Exception do
    begin
      aTransaction.Rollback;
      ShowMessage('������ ��� ������������ ������: '+e.Message);
    end;
  end;
end;

end.
