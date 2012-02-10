unit uFormTableOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBaseNSIForm, DBGridEhGrouping, FIBDatabase, pFIBDatabase,
  ImgList, PngImageList, ActnList, DB, FIBDataSet, pFIBDataSet, GridsEh,
  DBGridEh, StdCtrls, JvExStdCtrls, JvGroupBox, ExtCtrls, JvExExtCtrls,
  JvExtComponent, JvPanel, TB2Item, TBX, TB2Dock, TB2Toolbar, ComCtrls,
  NativeXml, GvNativeXml, EhLibFIB;

type
  TFormTableOrders = class(TBaseNSIForm)
    pcDetailInfo: TPageControl;
    tsOrderAttrs: TTabSheet;
    tsOrderItems: TTabSheet;
    tsOrderTaxs: TTabSheet;
    qryOrderAttrs: TpFIBDataSet;
    dsOrderAttrs: TDataSource;
    grdOrderProperties: TDBGridEh;
    grdOrderItems: TDBGridEh;
    qryOrderItems: TpFIBDataSet;
    qryOrderTaxs: TpFIBDataSet;
    dsOrderItems: TDataSource;
    dsOrderTaxs: TDataSource;
    grdOrderTaxs: TDBGridEh;
    actSendOrders: TAction;
    actFilterApproved: TAction;
    actFilterAcceptRequest: TAction;
    ts1: TTabSheet;
    qryStatuses: TpFIBDataSet;
    grdAccountMovements: TDBGridEh;
    qryAccountMovements: TpFIBDataSet;
    dsAccountMovements: TDataSource;
    tsHistory: TTabSheet;
    grdHistory: TDBGridEh;
    qryHistory: TpFIBDataSet;
    dsHistory: TDataSource;
    actMakeInvoice: TAction;
    btnMakeInvoice: TTBXItem;
    actAssignPayment: TAction;
    btnAssignPayment: TTBXItem;
    subSetStatuses: TTBXSubmenuItem;
    qryNextStatus: TpFIBDataSet;
    actSetStatus: TAction;
    procedure actFilterApprovedExecute(Sender: TObject);
    procedure actFilterAcceptRequestExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
    procedure actMakeInvoiceExecute(Sender: TObject);
    procedure actAssignPaymentExecute(Sender: TObject);
    procedure qryMainAfterScroll(DataSet: TDataSet);
    procedure actSetStatusExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure ApplyFilter(aStatusSign: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTableOrders: TFormTableOrders;

implementation

uses
  udmOtto, GvStr, uFormWizardOrder, uMain, uDlgPayment;

{$R *.dfm}

procedure TFormTableOrders.ApplyFilter(aStatusSign: string);
var
  StatusName: string;
  Column: TColumnEh;
begin
  StatusName:= qryStatuses.Lookup('OBJECT_SIGN;STATUS_SIGN',VarArrayOf(['ORDER', aStatusSign]), 'STATUS_NAME');
  Column:= grdMain.FieldColumns['STATUS_NAME'];
  Column.STFilter.ExpressionStr:= '='+StatusName;
  grdMain.ApplyFilter;
end;

procedure TFormTableOrders.actFilterApprovedExecute(Sender: TObject);
begin
  ApplyFilter('APPROVED');
end;

procedure TFormTableOrders.actFilterAcceptRequestExecute(Sender: TObject);
begin
  ApplyFilter('ACCEPTREQUEST');
end;

procedure TFormTableOrders.FormCreate(Sender: TObject);
begin
  inherited;
  trnNSI.StartTransaction;
  qryMain.Open;
  qryOrderAttrs.Open;
  qryOrderItems.Open;
  qryOrderTaxs.Open;
  qryStatuses.Open;
  qryAccountMovements.Open;
  qryHistory.Open;
  qryNextStatus.Open;
end;

procedure TFormTableOrders.grdMainDblClick(Sender: TObject);
begin
  TFormWizardOrder.CreateDB(Self, qryMain['order_id']).Show;
end;

procedure TFormTableOrders.actMakeInvoiceExecute(Sender: TObject);
begin
  MainForm.PrintInvoice(trnWrite, qryMain['ORDER_ID']);
end;

procedure TFormTableOrders.actAssignPaymentExecute(Sender: TObject);
var
  AccountId: Integer;
  Amount_BYR: Double;
  Byr2Eur: Integer;
  Xml: TNativeXml;
  ndOrder, ndClient: TXmlNode;
  DlgManualPayment: TDlgManualPayment;
begin
  DlgManualPayment:= TDlgManualPayment.Create(self);
  Xml:= TNativeXml.CreateName('ORDER');
  ndOrder:= Xml.Root;
  try
    dmOtto.ObjectGet(ndOrder, qryMain['ORDER_ID'], trnNSI);
    ndClient:= ndOrder.NodeNew('CLIENT');
    dmOtto.ObjectGet(ndClient, qryMain['CLIENT_ID'], trnNSI);

    DlgManualPayment.Caption:= '������ ���������� �� ������';
    DlgManualPayment.lblAmountEur.Caption:= '�����, BYR';
    DlgManualPayment.edtAmountEur.DecimalPlaces:= 0;
    DlgManualPayment.edtAmountEur.DisplayFormat:= '### ### ##0';
    DlgManualPayment.edtByr2Eur.Value:= GetXmlAttrValue(ndOrder, 'BYR2EUR');
    if DlgManualPayment.ShowModal = mrOk then
    begin
      Amount_BYR:= DlgManualPayment.edtAmountEur.Value;
      Byr2Eur:= DlgManualPayment.edtByr2Eur.Value;
      trnWrite.StartTransaction;
      try
        if GetXmlAttrValue(ndClient, 'ACCOUNT_ID') = null then
        begin
          // ������� ����
          AccountId:= dmOtto.GetNewObjectId('ACCOUNT');
          dmOtto.ActionExecute(trnWrite, 'ACCOUNT', 'ACCOUNT_CREATE', '', AccountId);
          SetXmlAttr(ndClient, 'ACCOUNT_ID', AccountId);
          dmOtto.ActionExecute(trnWrite, ndClient);
          SetXmlAttr(ndOrder, 'ACCOUNT_ID', AccountId);
          dmOtto.ActionExecute(trnWrite, ndOrder);
        end;
        dmOtto.ActionExecute(trnWrite, 'ACCOUNT', 'ACCOUNT_PAYMENTIN',
          XmlAttrs2Vars(ndOrder, 'ORDER_ID=ID;ID=ACCOUNT_ID',
          Value2Vars(Amount_BYR, 'AMOUNT_BYR')));
        trnWrite.Commit;
      except
        on E:Exception do
          begin
            trnWrite.Rollback;
            ShowMessage(E.Message);
          end
      end;
    end;
    qryMain.CloseOpen(True);
    qryAccountMovements.CloseOpen(True);
    qryOrderItems.CloseOpen(True);
    qryOrderTaxs.CloseOpen(True);
    qryOrderAttrs.CloseOpen(True);
  finally
    Xml.Free;
    DlgManualPayment.Free;
  end;
end;

procedure TFormTableOrders.qryMainAfterScroll(DataSet: TDataSet);
var
  btnSetStatus: TTBXItem;
  CompName: string;
  i: Integer;
begin
  for i:= 0 to subSetStatuses.Count - 1 do
    subSetStatuses.Items[i].Visible:= False;
  if qryNextStatus.Active then
  begin
    qryNextStatus.First;
    while not qryNextStatus.Eof do
    begin
      CompName:= Format('btnSetStatus_%s', [qryNextStatus['STATUS_SIGN']]);
      btnSetStatus:= TTBXItem(subSetStatuses.FindComponent(CompName));
      if btnSetStatus = nil then
      begin
        btnSetStatus:= TTBXItem.Create(subSetStatuses);
        btnSetStatus.Action:= actSetStatus;
        btnSetStatus.Name:= CompName;
        btnSetStatus.Tag:= qryNextStatus['STATUS_ID'];
        btnSetStatus.Caption:= qryNextStatus['STATUS_NAME'];
        subSetStatuses.Add(btnSetStatus);
      end
      else
        btnSetStatus.Visible:= True;
      qryNextStatus.Next;
    end;
  end;
end;

procedure TFormTableOrders.actSetStatusExecute(Sender: TObject);
var
  StatusId: Integer;
  StatusSign: String;
  OrderId: variant;
begin
  OrderId:= qryMain['ORDER_ID'];
  try
    StatusId:= TAction(Sender).ActionComponent.Tag;
    StatusSign:= qryStatuses.Lookup('STATUS_ID', StatusId, 'STATUS_SIGN');
    dmOtto.ActionExecute(trnWrite, 'ORDER', '', Value2Vars(StatusSign, 'NEW.STATUS_SIGN'), OrderId);
  finally
    qryMain.CloseOpen(true);
  end
end;

procedure TFormTableOrders.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if trnWrite.Active then trnWrite.Commit;
end;

end.