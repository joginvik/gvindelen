unit uFormWizardReturn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormWizardBase, fib, FIBDatabase, pFIBDatabase, ActnList,
  JvExControls, JvWizard, uFrameOrderItems, uFrameReturn, NativeXml,
  StdCtrls, ExtCtrls, JvExStdCtrls, JvGroupBox, pFIBErrorHandler;

type
  TFormWizardReturn = class(TFormWizardBase)
    wzIPageOrderItems: TJvWizardInteriorPage;
    wzIPageMoneyBackKind: TJvWizardInteriorPage;
    wzWPage: TJvWizardWelcomePage;
    errHandler: TpFibErrorHandler;
    procedure FormCreate(Sender: TObject);
    procedure wzFormActivePageChanging(Sender: TObject;
      var ToPage: TJvWizardCustomPage);
    procedure wzFormFinishButtonClick(Sender: TObject);
    procedure errHandlerFIBErrorEvent(Sender: TObject;
      ErrorValue: EFIBError; KindIBError: TKindIBError;
      var DoRaise: Boolean);
  private
    { Private declarations }
    ndOrder: TXmlNode;
    ndOrderItems: TXmlNode;
    ndOrderItem: TXmlNode;
    ndArticle: TXmlNode;
    ndAdress: TXmlNode;
    ndPlace: TXmlNode;
    ndClient: TXmlNode;
    ndOrderTaxs: TXmlNode;
    ndOrderTax: TXmlNode;
    ndAccount: TXmlNode;
    frmOrderItems: TFrameOrderItems;
    frmMoneyBack: TFrameMoneyBack;
//    frmClient: TFrameClient;
//    frmAdress: TFrameAdress;
//    frmOrderSummary: TFrameOrderSummary;
    function GetObjectId: integer;
    procedure SetObjectId(const Value: integer);
  public
    { Public declarations }
    procedure BuildXml; override;
    procedure ReadFromDB(aObjectId: Integer); override;
    property OrderId: integer read GetObjectId write SetObjectId;
  end;

var
  FormWizardReturn: TFormWizardReturn;

implementation

uses
  udmOtto, GvStr, GvNativeXml;

{$R *.dfm}

{ TFormWizardReturn }

function TFormWizardReturn.GetObjectId: integer;
begin
  result:= ObjectId;
end;

procedure TFormWizardReturn.SetObjectId(const Value: integer);
begin
  ObjectId:= Value;
end;

procedure TFormWizardReturn.BuildXml;
begin
  inherited;
  Root.Name:= 'ORDER';
  ndOrder:= Root;
  ndAdress:= ndOrder.NodeFindOrCreate('ADRESS');
  ndPlace:= ndAdress.NodeFindOrCreate('PLACE');
  ndClient:= ndOrder.NodeFindOrCreate('CLIENT');
  ndOrderItems:= ndOrder.NodeFindOrCreate('ORDERITEMS');
  ndOrderTaxs:= ndOrder.NodeFindOrCreate('ORDERTAXS');
  ndAccount:= ndClient.NodeFindOrCreate('ACCOUNT');
end;

procedure TFormWizardReturn.ReadFromDB(aObjectId: Integer);
begin
  inherited;
  dmOtto.ObjectGet(ndOrder, aObjectId, trnRead);
  dmOtto.OrderItemsGet(ndOrderItems, aObjectId, trnRead);
  dmOtto.OrderTaxsGet(ndOrderTaxs, aObjectId, trnRead);
  dmOtto.ObjectGet(ndClient, GetXmlAttrValue(ndOrder, 'CLIENT_ID'), trnRead);
  dmOtto.ObjectGet(ndAccount, GetXmlAttrValue(ndClient, 'ACCOUNT_ID'), trnRead);
  dmOtto.ObjectGet(ndAdress, GetXmlAttrValue(ndOrder, 'ADRESS_ID'), trnRead);
  dmOtto.ObjectGet(ndPlace, GetXmlAttrValue(ndAdress, 'PLACE_ID'), trnRead);
end;


procedure TFormWizardReturn.FormCreate(Sender: TObject);
begin
  inherited;

  Tag:= 1;

  try
    // FrameOrderItems
    frmOrderItems:= TFrameOrderItems.Create(self);
    frmOrderItems.ndOrder:= ndOrder;
    frmOrderItems.ndOrderItems:= ndOrderItems;
    IncludeForm(wzIPageOrderItems, frmOrderItems);

    // FrameMoneyBack
    frmMoneyBack:= TFrameMoneyBack.Create(Self);
    frmMoneyBack.ndOrder:= ndOrder;
    frmMoneyBack.ndClient:= ndClient;
    IncludeForm(wzIPageMoneyBackKind, frmMoneyBack);

    wzForm.ActivePageIndex:= 0;
  finally
    Tag := 0;
  end;
end;

procedure TFormWizardReturn.wzFormActivePageChanging(Sender: TObject;
  var ToPage: TJvWizardCustomPage);
begin
  inherited;
  if wzForm.ActivePage = wzIPageOrderItems then
    frmOrderItems.Write
  else
  if wzForm.ActivePage = wzIPageMoneyBackKind then
    frmMoneyBack.Write;
end;

procedure TFormWizardReturn.wzFormFinishButtonClick(Sender: TObject);
begin
  inherited;
  try
    SetXmlAttr(ndOrder, 'NEW.STATUS_SIGN', 'HAVERETURN');
    XmlData.XmlFormat:= xfReadable;
    XmlData.SaveToFile('Order.xml');
    dmOtto.ActionExecute(trnWrite, ndOrder);
    dmOtto.ObjectGet(ndOrder, ObjectId, trnWrite);
    trnWrite.Commit;
    ShowMessage('������� ��������');
  except
    trnWrite.Rollback;
  end;
end;

procedure TFormWizardReturn.errHandlerFIBErrorEvent(Sender: TObject;
  ErrorValue: EFIBError; KindIBError: TKindIBError; var DoRaise: Boolean);
begin
  inherited;
  ShowMessage('ErrorValue='+ErrorValue.);
  DoRaise:= True;

end;

end.
