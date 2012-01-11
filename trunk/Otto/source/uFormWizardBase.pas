unit uFormWizardBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvWizard, JvWizardRouteMapNodes, JvExControls, StdCtrls,
  Buttons, ActnList, NativeXml, FIBDatabase, pFIBDatabase;

type
  TSourceFlag = (sfBlank, sfMessage, sfDatabase, sfXml);

  TFormWizardBase = class(TForm)
    wzForm: TJvWizard;
    actListWzrdBtn: TActionList;
    trnWrite: TpFIBTransaction;
    trnRead: TpFIBTransaction;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure wzFormCancelButtonClick(Sender: TObject);
  private
    { Private declarations }
  protected
    ObjectId: Integer;
    MessageId: Integer;
    XmlData: TNativeXml;
    SourceFlag: TSourceFlag;
//    property ObjectId: Integer read FObjectId write FObjectId;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    constructor CreateBlank(AOwner: TComponent); virtual;
    constructor CreateDB(AOwner: TComponent;aObjectId: Integer); virtual;
    constructor CreateXml(AOwner: TComponent;aXml: TNativeXml); virtual;
    constructor CreateMessage(AOwner: TComponent; aMessageId: integer); virtual;
    destructor Destroy; override;
    procedure IncludeForm(aWinControl: TWinControl; aForm: TWinControl);
    procedure InitFrames; virtual;
    function Root: TXmlNode;
    procedure BuildXml; virtual;
    procedure ParseMessage(aFileName: string); virtual; abstract;
    procedure UpdateCaptions; virtual;
    procedure UpdateControls(aPage: TJvWizardCustomPage); virtual;
    procedure UpdateXml(aPage: TJvWizardCustomPage); virtual;
  end;

implementation

uses
  udmOtto, uFrameBase1, uFrameBase0;

{$R *.dfm}

{ TfBaseWizardForm }

constructor TFormWizardBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  trnRead.StartTransaction;
  XmlData:= TNativeXml.Create;
  BuildXml;
end;

constructor TFormWizardBase.CreateBlank(AOwner: TComponent);
begin
  Create(AOwner);
  SourceFlag:= sfBlank;
  trnWrite.StartTransaction;
end;


procedure TFormWizardBase.BuildXml;
begin

end;

destructor TFormWizardBase.Destroy;
begin
  XmlData.Free;
  if trnWrite.Active then trnWrite.Rollback;
  if trnRead.Active then trnRead.Commit;
  inherited;
end;

function TFormWizardBase.Root: TXmlNode;
begin
  Result:= XmlData.Root;
end;

constructor TFormWizardBase.CreateDB(AOwner: TComponent;
  aObjectId: Integer);
begin
  Create(AOwner);
  SourceFlag:= sfDatabase;
  ObjectId:= aObjectId;
end;

constructor TFormWizardBase.CreateXml(AOwner: TComponent;
  aXml: TNativeXml);
var
  St: string;
begin
  inherited Create(AOwner);
  SourceFlag:= sfXml;
  XmlData:= TNativeXml.Create;
  XmlData.Assign(aXml);
  BuildXml;
end;

procedure TFormWizardBase.UpdateCaptions;
begin

end;

procedure TFormWizardBase.UpdateControls;
begin

end;

procedure TFormWizardBase.UpdateXml;
begin

end;

procedure TFormWizardBase.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TFormWizardBase.wzFormCancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TFormWizardBase.InitFrames;
begin

end;

procedure TFormWizardBase.IncludeForm(aWinControl: TWinControl;
  AForm: TWinControl);
var
  ClassRef: TClass;
  Parents: string;
begin
  Parents:= ',';
  ClassRef:= aForm.ClassType;
  while ClassRef <> nil do
  begin
    Parents:= Parents+ClassRef.ClassName+',';
    ClassRef := ClassRef.ClassParent;
  end;

  AForm.Parent:= aWinControl;
  if Pos(',TCustomForm,', Parents) > 0 then
    TCustomForm(AForm).BorderStyle:= bsNone;
  AForm.Align:= alClient;
  AForm.Show;
end;

constructor TFormWizardBase.CreateMessage(AOwner: TComponent;
  aMessageId: integer);
var
  SourceFileName: string;
begin
  Create(AOwner);
  SourceFlag:= sfMessage;
  SourceFileName:= trnRead.DefaultDatabase.QueryValue(
    'select m.file_name from messages m where m.message_id = :message_id', 0,
    [aMessageId]);
  MessageId:= aMessageId;
  trnWrite.StartTransaction;
  ParseMessage(SourceFileName);
end;

end.