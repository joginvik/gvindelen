unit uFrameAdress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, PngImageList, ActnList, FIBDatabase,
  pFIBDatabase, ExtCtrls, JvExExtCtrls, JvExtComponent, JvPanel,
  TBXStatusBars, TB2Dock, TB2Toolbar, TBX, DB,
  FIBDataSet, pFIBDataSet, GridsEh, DBGridEh, JvNetscapeSplitter, StdCtrls,
  DBCtrlsEh, Mask, JvExMask, JvToolEdit, JvMaskEdit, JvExStdCtrls,
  JvGroupBox, NativeXml, uFrameBase1, DBGridEhGrouping;

type
  TFrameAdress = class(TFrameBase1)
    pnlRightOnAdress: TJvPanel;
    grBoxAdress: TJvGroupBox;
    lblPostIndex: TLabel;
    lblStreetType: TLabel;
    lblFlat: TLabel;
    lblBuilding: TLabel;
    lblHouse: TLabel;
    medPostIndex: TJvMaskEdit;
    cbStreetType: TDBComboBoxEh;
    dedStreetName: TDBEditEh;
    dedFlat: TDBEditEh;
    dedBuilding: TDBEditEh;
    dedHouse: TDBEditEh;
    grBoxPlace: TJvGroupBox;
    lbl2: TLabel;
    lblPlace: TLabel;
    lblArea: TLabel;
    lblRegion: TLabel;
    cbPlaceType: TDBComboBoxEh;
    dedPlaceName: TDBEditEh;
    cbAreaName: TDBComboBoxEh;
    dedRegionName: TDBEditEh;
    grBoxClient: TJvGroupBox;
    txtClientName: TStaticText;
    pnlCenterOnAdress: TPanel;
    grBoxgb2: TJvGroupBox;
    grdPlaces: TDBGridEh;
    qryAdresses: TpFIBDataSet;
    dsAdresses: TDataSource;
    qryPlaces: TpFIBDataSet;
    dsPlaces: TDataSource;
    split1: TJvNetscapeSplitter;
    grBoxgb1: TJvGroupBox;
    grdAdresses: TDBGridEh;
    actPlaceSearch: TAction;
    procedure cbPlaceTypeChange(Sender: TObject);
    procedure grdAdressesDblClick(Sender: TObject);
    procedure grdPlacesDblClick(Sender: TObject);
    procedure actPlaceSearchExecute(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dedPlaceNameExit(Sender: TObject);
    procedure SetKeyLayout(Sender: TObject);
  private
    function GetClientId: Integer;
    function GetOrderId: Integer;
    function GetAdressId: Integer;
    function GetPlaceId: Integer;
    { Private declarations }
  public
    { Public declarations }
    ndOrder: TXmlNode;
    ndClient: TXmlNode;
    ndAdress: TXmlNode;
    ndPlace: TXmlNode;
    procedure InitData; override;
    procedure FreeData; override;
    procedure OpenTables; override;
    procedure Read; override;
    procedure Write; override;
    procedure UpdateCaptions; override;
    property OrderId: Integer read GetOrderId;
    property ClientId: Integer read GetClientId;
    property AdressId: Integer read GetAdressId;
    property PlaceId: Integer read GetPlaceId;
  end;

var
  FrameAdress: TFrameAdress;

implementation

uses
  udmOtto, GvNativeXml, GvKbd;

{$R *.dfm}

{ TFrameAdress }

procedure TFrameAdress.FreeData;
begin
  inherited;

end;

function TFrameAdress.GetAdressId: Integer;
begin
  Result:= ndAdress.ReadAttributeInteger('ID', 0)
end;

function TFrameAdress.GetClientId: Integer;
begin
  Result:= ndClient.ReadAttributeInteger('ID', 0)
end;

function TFrameAdress.GetOrderId: Integer;
begin
  Result:= ndOrder.ReadAttributeInteger('ID', 0)
end;

function TFrameAdress.GetPlaceId: Integer;
begin
  Result:= ndPlace.ReadAttributeInteger('ID', 0)
end;

procedure TFrameAdress.InitData;
begin
  inherited;
  dmOtto.FillComboStrings(cbPlaceType.KeyItems, cbPlaceType.Items,
    'select placetype_code, placetype_sign from PlaceTypes order by placetype_sign', trnRead);
  dmOtto.FillComboStrings(cbAreaName.KeyItems, cbAreaName.Items,
    'select place_id, place_name from Places where placetype_code = 3 order by place_name', trnRead);
  dmOtto.FillComboStrings(cbStreetType.KeyItems, cbStreetType.Items,
    'select streettype_code, streettype_sign from StreetTypes order by streettype_sign', trnRead);
end;

procedure TFrameAdress.Read;
begin
  txtClientName.Caption:= GetXmlAttr(ndClient, 'LAST_NAME') +
    GetXmlAttr(ndClient, 'FIRST_NAME', ' ')+
    GetXmlAttr(ndClient, 'MID_NAME', ' ');

  XmlAttr2Combo(cbPlaceType, ndPlace, 'PLACETYPE_CODE', 'PLACETYPE_SIGN', '�');
  dedPlaceName.Text:= GetXmlAttr(ndPlace, 'PLACE_NAME');
  XmlAttr2Combo(cbAreaName, ndPlace, 'AREA_ID', 'AREA_NAME');
  dedRegionName.Text:= GetXmlAttr(ndPlace, 'REGION_NAME');

  medPostIndex.Text:= GetXmlAttr(ndAdress, 'POSTINDEX');
  XmlAttr2Combo(cbStreetType, ndAdress, 'STREETTYPE_CODE', 'STREETTYPE_SIGN', '��');
  dedStreetName.Text:= GetXmlAttr(ndAdress, 'STREET_NAME');
  dedHouse.Text:= GetXmlAttr(ndAdress, 'HOUSE');
  dedBuilding.Text:= GetXmlAttr(ndAdress, 'BUILDING');
  dedFlat.Text:= GetXmlAttr(ndAdress, 'FLAT');
end;

procedure TFrameAdress.Write;
begin
  inherited;
  Combo2XmlAttr(cbPlaceType, ndPlace, 'PLACETYPE_CODE', 'PLACETYPE_SIGN');
  SetXmlAttr(ndPlace, 'PLACE_NAME', dedPlaceName.Text);
  Combo2XmlAttr(cbAreaName, ndPlace, 'AREA_ID', 'AREA_NAME');
  SetXmlAttr(ndPlace, 'REGION_NAME', dedRegionName.Text);
  if PlaceId = 0 then
  begin
    if GetXmlAttrValue(ndPlace, 'PLACETYPE_CODE') <= 4 then
    begin
      ShowMessage('��� ���������� ������ ���� "�����" ��� ����������������. �������� �� ������������ ��� ������� ������ ��� ����������� ������.');
      Exit;
    end;
    if MessageDlg(Format('���������������� ���������� ����� %s %s %s?',
                  [cbPlaceType.Text+'.',
                   dedPlaceName.Text,
                   cbAreaName.Text]),
                  mtConfirmation, [mbYes,mbNo], 0) = mrYes then
    begin
      SetXmlAttr(ndPlace, 'ID', dmOtto.GetNewObjectId('PLACE'));
      SetXmlAttr(ndAdress, 'PLACE_ID', PlaceId);
      dmOtto.ActionExecute(trnWrite, 'PLACE_CREATE', ndPlace);
    end
    else
      Exit;
  end;
  
  SetXmlAttr(ndAdress, 'PLACE_ID', PlaceId);
  SetXmlAttr(ndAdress, 'POSTINDEX', medPostIndex.Text);
  Combo2XmlAttr(cbStreetType, ndAdress, 'STREETTYPE_CODE', 'STREETTYPE_SIGN');
  SetXmlAttr(ndAdress, 'STREET_NAME', dedStreetName.Text);
  SetXmlAttr(ndAdress, 'HOUSE', dedHouse.Text);
  SetXmlAttr(ndAdress, 'BUILDING', dedBuilding.Text);
  SetXmlAttr(ndAdress, 'FLAT', dedFlat.Text);
  if AdressId = 0 then
  begin
    if GetXmlAttrValue(ndClient, 'STATUS_SIGN') <> 'NEW' then
    begin
      if MessageDlg('���������������� ����� ����� �������?',
             mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        SetXmlAttr(ndAdress, 'ID', dmOtto.GetNewObjectId('ADRESS'))
      else
        Exit;
    end
    else
      SetXmlAttr(ndAdress, 'ID', dmOtto.GetNewObjectId('ADRESS'));
    BatchMoveFields2(ndAdress, ndOrder, 'CLIENT_ID');
    dmOtto.ActionExecute(trnWrite, 'ADRESS_CREATE', ndAdress);
  end
  else
    dmOtto.ActionExecute(trnWrite, ndAdress);
  SetXmlAttr(ndOrder, 'ADRESS_ID', AdressId);
  dmOtto.ActionExecute(trnWrite, ndOrder);

  dmOtto.ObjectGet(ndAdress, AdressId, trnWrite);
  dmOtto.ObjectGet(ndPlace, PlaceId, trnWrite);
end;

procedure TFrameAdress.cbPlaceTypeChange(Sender: TObject);
var
  NeedArea: Boolean;
begin
  NeedArea:= StrToInt(cbPlaceType.KeyItems[cbPlaceType.ItemIndex]) > 4;
  cbAreaName.Visible:= NeedArea;
end;

procedure TFrameAdress.grdAdressesDblClick(Sender: TObject);
begin
  if grBoxAdress.Enabled then
  begin
    dmOtto.AdressRead(ndAdress, qryAdresses['ADRESS_ID'], trnRead);
    UpdateCaptions;
  end;
end;

procedure TFrameAdress.grdPlacesDblClick(Sender: TObject);
begin
  if grBoxPlace.Enabled then
  begin
    dmOtto.ObjectGet(ndPlace, qryPlaces['PLACE_ID'], trnRead);
    UpdateCaptions;
  end;
end;

procedure TFrameAdress.actPlaceSearchExecute(Sender: TObject);
begin
  SetXmlAttr(ndPlace, 'PLACE_NAME', dedPlaceName.Text);
  if ndPlace.ReadAttributeString('PLACE_NAME', '') <> '' then
  begin
    qryPlaces.DisableControls;
    try
      if qryPlaces.Active then qryPlaces.Close;
      qryPlaces.OpenWP([dedPlaceName.Text]);
      if qryPlaces.RecordCount = 1 then
      begin
        grdPlaces.OnDblClick(Self);
      end;
    finally
      qryPlaces.EnableControls;
    end;
  end;
end;

procedure TFrameAdress.OpenTables;
begin
  inherited;
  qryAdresses.OpenWP([ClientId]);
  if qryAdresses.RecordCount = 1 then
    dmOtto.AdressRead(ndAdress, qryAdresses['ADRESS_ID'], trnRead);

  qryPlaces.OpenWP([GetXmlAttrValue(ndPlace, 'PLACE_NAME')]);
end;

procedure TFrameAdress.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  KeyReturn(Sender, Key, Shift);
end;

procedure TFrameAdress.dedPlaceNameExit(Sender: TObject);
begin
  actPlaceSearch.Execute;
  if qryPlaces.RecordCount = 1 then

end;

procedure TFrameAdress.SetKeyLayout(Sender: TObject);
begin
  dmOtto.SetKeyLayout(TControl(Sender).Tag);
end;

procedure TFrameAdress.UpdateCaptions;
begin
  grBoxClient.Caption:= DetectCaption(ndClient, '������');
  grBoxAdress.Caption:= DetectCaption(ndAdress, '�����');
  grBoxPlace.Caption:= DetectCaption(ndPlace, '���������� �����');
end;

end.