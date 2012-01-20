unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ImgList, TB2Item, TBX, TB2Dock, TB2Toolbar,
  TBXStatusBars, GvVars, PngImageList, DB, FIBDataSet, pFIBDataSet, NativeXml,
  StdCtrls, JvComponentBase, JvFormAutoSize, TBXDkPanels, Menus, StdActns,
  FIBDatabase, pFIBDatabase, JvDSADialogs, frxClass, frxExportPDF,
  frxFIBComponents, ExtCtrls, DBGridEhGrouping, GridsEh, DBGridEh,
  JvEmbeddedForms, JvExControls, JvProgressComponent, frxRich, pFIBScripter,
  JvDialogs, JvBaseDlg, IB_Services, pngimage,
  gsFileVersionInfo, JvLogFile, JvThread, JvProgressDialog, dbf,
  frxExportXML, frxExportHTML, frxExportXLS, uFrameBase1, uFrameOrderItems,
  ComCtrls;

type
  TMainForm = class(TForm)
    dckTop: TTBXDock;
    sbMain: TTBXStatusBar;
    tbrMain: TTBXToolbar;
    alMain: TActionList;
    actImportMessages: TAction;
    actParseOrder: TAction;
    btnParseOrder: TTBXItem;
    imgListMainMenu: TPngImageList;
    actArticleUpdate: TAction;
    actOrderCreate: TAction;
    btnOrderCreate: TTBXItem;
    actParseOrderXml: TAction;
    btnParseOrderXml: TTBXItem;
    actImportArticles: TAction;
    btnImportMagazine: TTBXItem;
    tbSubMenuNSI: TTBXSubmenuItem;
    actNSICatalogs: TAction;
    btnCatalogs: TTBXItem;
    actNSISettings: TAction;
    btnSettings: TTBXItem;
    tbSubMenuTables: TTBXSubmenuItem;
    btnTableClients: TTBXItem;
    imgListTables: TPngImageList;
    imgListNSI: TPngImageList;
    actTableClients: TAction;
    actTableOrders: TAction;
    btn1: TTBXItem;
    sMenu1: TTBXSubmenuItem;
    mm1: TMainMenu;
    File1: TMenuItem;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileCloseItem: TMenuItem;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    Edit1: TMenuItem;
    CutItem: TMenuItem;
    CopyItem: TMenuItem;
    PasteItem: TMenuItem;
    Window1: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowTileItem: TMenuItem;
    WindowTileItem2: TMenuItem;
    WindowMinimizeItem: TMenuItem;
    WindowArrangeItem: TMenuItem;
    Help1: TMenuItem;
    HelpAboutItem: TMenuItem;
    actList1: TActionList;
    actFileNew1: TAction;
    actFileOpen1: TAction;
    wndwclsFileClose1: TWindowClose;
    actFileSave1: TAction;
    actFileSaveAs1: TAction;
    actFileExit1: TAction;
    edtct1: TEditCut;
    edtcpy1: TEditCopy;
    edtpst1: TEditPaste;
    wndwcscd1: TWindowCascade;
    wndwtlhrzntl1: TWindowTileHorizontal;
    wndwtlvrtcl1: TWindowTileVertical;
    wndwmnmzl1: TWindowMinimizeAll;
    wndwrngAll: TWindowArrange;
    actHelpAbout1: TAction;
    trnWrite: TpFIBTransaction;
    actProcessMessages: TAction;
    sMenu2: TTBXSubmenuItem;
    btn4: TTBXItem;
    btn5: TTBXItem;
    btn6: TTBXItem;
    actProcessProtocol: TAction;
    actProcessLiefer: TAction;
    actProcessPackList: TAction;
    actProcessConsignment: TAction;
    btn7: TTBXItem;
    actPrintInvoices: TAction;
    btn3: TTBXItem;
    trnRead: TpFIBTransaction;
    frxPDFExport: TfrxPDFExport;
    actImportPayments: TAction;
    btn8: TTBXItem;
    actPaymentAssign: TAction;
    btn9: TTBXItem;
    tmrImportMessages: TTimer;
    frxReport: TfrxReport;
    actInstallPatch: TAction;
    scrptUpdate: TpFIBScripter;
    btn10: TTBXItem;
    actExportOrders: TAction;
    btn11: TTBXItem;
    actSetByr2Eur: TAction;
    verInfo: TgsFileVersionInfo;
    log1: TJvLogFile;
    imgListAlerts: TPngImageList;
    actExportSMSRejected: TAction;
    btn12: TTBXItem;
    actExportCancellation: TAction;
    btn13: TTBXItem;
    actExportPayment: TAction;
    btn14: TTBXItem;
    actExportPackList: TAction;
    btn15: TTBXItem;
    actBackup: TAction;
    actRestore: TAction;
    subMenuSystem: TTBXSubmenuItem;
    btnBackup: TTBXItem;
    btnRestore: TTBXItem;
    btnPatch: TTBXItem;
    dlgOpenRestore: TOpenDialog;
    actProcessArtN: TAction;
    btn2: TTBXItem;
    btnCancellation: TTBXItem;
    actProcessCancellation: TAction;
    frxFIBComponents1: TfrxFIBComponents;
    frxExportXLS: TfrxXMLExport;
    pbMain: TProgressBar;
    actReturn: TAction;
    btnReturn: TTBXItem;
    procedure actParseOrderXmlExecute(Sender: TObject);
    procedure actOrderCreateExecute(Sender: TObject);
    procedure actImportArticlesExecute(Sender: TObject);
    procedure actNSICatalogsExecute(Sender: TObject);
    procedure actNSISettingsExecute(Sender: TObject);
    procedure actTableOrdersExecute(Sender: TObject);
    procedure actTableClientsExecute(Sender: TObject);
    procedure actProcessProtocolExecute(Sender: TObject);
    procedure actProcessLieferExecute(Sender: TObject);
    procedure actProcessConsignmentExecute(Sender: TObject);
    procedure actProcessPackListExecute(Sender: TObject);
    procedure actPrintInvoicesExecute(Sender: TObject);
    procedure actExportSMSRejectedExecute(Sender: TObject);
    procedure actExportCancellationExecute(Sender: TObject);
    procedure actImportPaymentsExecute(Sender: TObject);
    procedure tmrImportMessagesTimer(Sender: TObject);
    procedure actExportOrdersExecute(Sender: TObject);
    procedure actSetByr2EurExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actInstallPatchExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure scrptUpdateExecuteError(Sender: TObject; StatementNo,
      Line: Integer; Statement: TStrings; SQLCode: Integer;
      const Msg: string; var doRollBack, Stop: Boolean);
    procedure actExportPaymentExecute(Sender: TObject);
    procedure actExportPackListExecute(Sender: TObject);
    procedure actBackupExecute(Sender: TObject);
    procedure actRestoreExecute(Sender: TObject);
    procedure actProcessArtNExecute(Sender: TObject);
    procedure actProcessCancellationExecute(Sender: TObject);
    procedure alMainUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure btnReturnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PrintInvoice(aTransaction: TpFIBTransaction; OrderId: Integer);
    procedure PrintPackList(aTransaction: TpFIBTransaction; Packlist_No: Integer;
      aFileName: String);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}
uses
  GvFile, IniFiles, GvStr, udmOtto, FIBQuery, uParseOrder,
  uOttoArticleUpdate, DateUtils, uWzrdArticles, uBaseNSIForm,
  uFormTableOrder, uFormTableClients, uParseProtocol, uParseLiefer,
  uParseConsignment, uFormProtocol, GvNativeXml, pFIBQuery, uParsePayments,
  uFormWizardOrder, uExportOrders, uSetByr2Eur, uExportSMSReject,
  uExportCancellation, uExportOrder, uExportInvoices, uExportPackList, 
  uParseArtN, uParseCancellation, uFormWizardReturn;

procedure TMainForm.actParseOrderXmlExecute(Sender: TObject);
var
  MessageId: integer;
begin
  MessageId := dmOtto.MessageBusy(1);
  if MessageId = 0 then
    exit;
  TFormWizardOrder.CreateMessage(self, MessageId).Show;
end;

procedure TMainForm.actOrderCreateExecute(Sender: TObject);
begin
  TFormWizardOrder.CreateBlank(Self).Show;
end;

procedure TMainForm.actImportArticlesExecute(Sender: TObject);

begin
  with TWzArticlesOtto.Create(self, 'MAGAZINE') do
    Show;
end;

procedure TMainForm.actNSICatalogsExecute(Sender: TObject);
begin
  with TBaseNSIForm.Create(self) do
  begin
    qryMain.SelectSQL.Text := 'select * from catalogs order by catalog_id';
    qryMain.Open;
    Show;
  end;
end;

procedure TMainForm.actNSISettingsExecute(Sender: TObject);
begin
  with TBaseNSIForm.Create(self) do
  begin
    qryMain.SelectSQL.Text := 'select * from settings order by 1';
    qryMain.Open;
    Show;
  end;
end;

procedure TMainForm.actTableOrdersExecute(Sender: TObject);
begin
  with TFormTableOrders.Create(Self) do
    Show;
end;

procedure TMainForm.actTableClientsExecute(Sender: TObject);
begin
  with TFormTableClients.Create(Self) do
    Show;
end;

procedure TMainForm.actProcessProtocolExecute(Sender: TObject);
var
  vMessageId: Integer;
begin
  repeat
    vMessageId := dmOtto.MessageBusy(3);
    if vMessageId > 0 then
    begin
      ProcessProtocol(vMessageId, trnWrite);
      with TFormProtocol.Create(Self, vMessageId) do
        Show;
      Application.ProcessMessages;
    end
  until vMessageId = 0;
end;

procedure TMainForm.actProcessLieferExecute(Sender: TObject);
var
  vMessageId: Integer;
begin
  repeat
    vMessageId := dmOtto.MessageBusy(4);
    if vMessageId > 0 then
    begin
      ProcessLiefer(vMessageId, trnWrite);
      with TFormProtocol.Create(Self, vMessageId) do
        Show;
      Application.ProcessMessages;
    end;
  until vMessageId = 0;
end;

procedure TMainForm.actProcessConsignmentExecute(Sender: TObject);
var
  vMessageId: Integer;
begin
  repeat
    vMessageId := dmOtto.MessageBusy(6);
    if vMessageId > 0 then
    begin
      ProcessConsignment(vMessageId, trnWrite);
      with TFormProtocol.Create(Self, vMessageId) do
        Show;
      Application.ProcessMessages;
    end;
  until vMessageId = 0;
end;

procedure TMainForm.actProcessPackListExecute(Sender: TObject);
begin
  //  repeat
  //    MessageId:= dmOtto.MessageBusy(5);
  //    if MessageId > 0 then
  //      ProcessPacklist(MessageId, trnMain);
  //  until MessageId = 0;
end;


procedure TMainForm.PrintInvoice(aTransaction: TpFIBTransaction; OrderId: Integer);
var
  InvFileName: string;
  OrderCode: Variant;
begin
  OrderCode:= aTransaction.DefaultDatabase.QueryValue(
    'select order_code from orders where order_id = :order_id',
    0, [OrderId], aTransaction);
  InvFileName:= Format('inv_%s.pdf', [OrderCode]);
  ForceDirectories(Path['Invoices']);
  frxPDFExport.FileName:= Path['Invoices']+invFileName;
  frxReport.LoadFromFile(Path['FastReport'] + 'invoice.fr3');
  frxReport.Variables.Variables['OrderId']:= Format('''%u''', [OrderId]);
  frxReport.PrepareReport(true);
  frxReport.Export(frxPDFExport);
  frxReport.ShowPreparedReport;
end;

procedure TMainForm.PrintPackList(aTransaction: TpFIBTransaction;
  Packlist_No: Integer; aFileName: string);
begin
  frxExportXLS.DefaultPath:= Path['DbfPackLists'];
  frxExportXLS.FileName:= aFileName;
  frxReport.LoadFromFile(Path['FastReport'] + 'packlistpi3.fr3');
  frxReport.Variables.Variables['PackList_No']:= Format('''%u''', [Packlist_No]);
  frxReport.PrepareReport(true);
  frxReport.Export(frxExportXLS);
end;


procedure TMainForm.actPrintInvoicesExecute(Sender: TObject);
var
  OrderIdArr: array of variant;
  i: Integer;
begin
  trnWrite.StartTransaction;
  with dmOtto.qryTempRead do
  begin
    Transaction := trnWrite;
    SQL.Text := 'select order_id from v_order_invoiceable order by order_id';
    ExecQuery;
    try
      while not Eof do
      begin
        dmOtto.ActionExecute(trnWrite, 'ORDER', 'ORDER_INVOICE', '', Fields[0].AsInteger);
        PrintInvoice(trnWrite, Fields[0].AsInteger);
        Next;
      end;
    finally
      Close;
    end;
    trnWrite.Commit;
  end;
end;

procedure TMainForm.actImportPaymentsExecute(Sender: TObject);
var
  vMessageId: Integer;
begin
  repeat
    vMessageId := dmOtto.MessageBusy(7);
    if vMessageId > 0 then
    begin
      ProcessPayment(vMessageId, trnWrite);
      with TFormProtocol.Create(Self, vMessageId) do
        Show;
      Application.ProcessMessages;
    end;
  until vMessageId = 0;
end;

procedure TMainForm.actProcessArtNExecute(Sender: TObject);
var
  vMessageId: Integer;
begin
  repeat
    vMessageId := dmOtto.MessageBusy(9);
    if vMessageId > 0 then
    begin
      ProcessArtN(vMessageId, trnWrite);
      with TFormProtocol.Create(Self, vMessageId) do
        Show;
      Application.ProcessMessages;
    end;
  until vMessageId = 0;
end;

procedure TMainForm.actProcessCancellationExecute(Sender: TObject);
var
  vMessageId: Integer;
begin
  repeat
    vMessageId := dmOtto.MessageBusy(8);
    if vMessageId > 0 then
    begin
      ProcessCancellation(vMessageId, trnWrite);
      with TFormProtocol.Create(Self, vMessageId) do
        Show;
    end;
  until vMessageId = 0;
end;



procedure TMainForm.tmrImportMessagesTimer(Sender: TObject);
var
  sl: TStringList;
  i: Integer;
  MessageCount: integer;
  MessageId: Variant;
  StatusSign, FileName: string;
begin
  sl := TStringList.Create;
  trnWrite.StartTransaction;
  try
    ListFileName(sl, Path['Messages.In'] + '*.*', true);
    with dmOtto.spTemp do
    begin
      Transaction := trnWrite;
      StoredProcName := 'MESSAGE_CREATE';
      Params.ClearValues;
      MessageCount := 0;
      for i := 0 to sl.Count - 1 do
      begin
        // ��������� ��������������� �� ����
        MessageId:= trnWrite.DefaultDatabase.QueryValue(
          'select m.message_id from messages m where m.file_name = :file_name',
          0, [ExtractFileName(sl[i])], trnWrite);
        // ���� ���������������, ��������� ������ ���������
        if MessageId <> null then
        begin
          StatusSign:= trnWrite.DefaultDatabase.QueryValue(
            'select s.status_sign from messages m'+
            ' inner join statuses s on (s.status_id = m.status_id)'+
            ' where m.message_id = :message_id',
            0, [MessageId], trnWrite);
          if StatusSign = 'SUCCESS' then
            GvFile.MoveFile(sl[i], Path['Messages.Processed'] + FormatDateTime('YYYY.MM.DD\', Date));
        end
        else
        begin
          try
            trnWrite.SetSavePoint('CreateMessage');
            FileName := AnsiToUtf8(Copy(sl[i], Length(Path['Messages.In']) + 1,
              Length(sl[i])));
            ParamByName('I_FILE_NAME').Value:= AnsiLowerCaseFileName(FileName);
            ParamByName('I_FILE_SIZE').Value:= GetFileSize(sl[i]);
            ParamByName('I_FILE_DTM').AsDateTime:= FileDateToDateTime(fileAge(sl[i]));
            ExecProc;
            if VarIsNull(ParamValue('O_MESSAGE_ID')) then
            begin
              trnWrite.RollBackToSavePoint('CreateMessage');
            end
            else
              Inc(MessageCount);
          except
            trnWrite.RollBackToSavePoint('CreateMessage');
            ForceDirectories(Path['Messages.Unknown']);
            GvFile.MoveFile(sl[i], Path['Messages.Unknown']);
          end;
        end;
      end;
    end;
    trnWrite.Commit;
    sbMain.SimpleText := Format('%u ��������� ����������������',
      [MessageCount]);
  finally
    sl.Free;
  end
end;

procedure TMainForm.actExportOrdersExecute(Sender: TObject);
var
  ProductXml: TNativeXml;
  p: Integer;
  FileName: string;
begin
  if MessageDlg('������������ ���� � ��������?', mtConfirmation, mbOkCancel, 0) = mrOk then
    ExportApprovedOrder(trnWrite);
end;

procedure TMainForm.actSetByr2EurExecute(Sender: TObject);
begin
  with TFormSetByr2Eur.Create(Self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TMainForm.FormShow(Sender: TObject);
var
  Byr2EurDate: variant;
begin
  tmrImportMessages.OnTimer(Self);
  if not trnRead.Active then
    trnRead.StartTransaction;
  Byr2EurDate := trnRead.DefaultDatabase.QueryValue(
    'select cast(s.valid_dtm as date) from settings s ' +
    'where s.setting_sign = ''BYR2EUR'' ' +
    'and cast(s.valid_dtm as date) = current_date ', 0, trnRead);
  if Byr2EurDate = null then
    actSetByr2Eur.Execute;
end;

procedure TMainForm.actInstallPatchExecute(Sender: TObject);
const
  HeaderText = '��������� ����������';
var
  BeforeBackupFileName: string;
  AfterBackupFileName: string;
  ScriptMeta, ScriptData: string;
  NewBuild: string;
begin
  NewBuild := FillFront(IntToStr(dmOtto.Build + 1), 6, '0');
  dmOtto.CreateAlert(HeaderText, Format('��������� ����� %s ...', [NewBuild]),
    mtInformation, 10000);
  if dmOtto.dbOtto.Connected then
    dmOtto.dbOtto.Close;
  BeforeBackupFileName := Format('%s%s_%s_Before.fbk',
    [Path['Backup'], FormatDateTime('YYYYMMDD', Date), NewBuild]);
  ScriptMeta := Format('%s%s_meta.sql',
    [Path['Updates'], NewBuild]);
  ScriptData := Format('%s%s_data.sql',
    [Path['Updates'], NewBuild]);
  AfterBackupFileName := Format('%s%s_%s_After.fbk',
    [Path['Backup'], FormatDateTime('YYYYMMDD', Date), NewBuild]);
  try
    try
      dmOtto.BackupDatabase(BeforeBackupFileName);
    except
      on E: Exception do
      begin
        dmOtto.CreateAlert(HeaderText,
          Format('������ �������� ��������� ����� "%s" (%s)',
          [BeforeBackupFileName, E.Message]), mtError);
        raise;
      end;
    end;
    dmOtto.dbOtto.Open;
    trnWrite.StartTransaction;
    try
      try
        scrptUpdate.ExecuteFromFile(ScriptMeta);
      except
        on E: Exception do
        begin
          dmOtto.CreateAlert(HeaderText,
            Format('������ ��� ��������� ������� "%s" (%s)',
            [ScriptMeta, E.Message]), mtError);
          raise;
        end;
      end;
      try
        scrptUpdate.ExecuteFromFile(ScriptData);
      except
        on E: Exception do
        begin
          dmOtto.CreateAlert(HeaderText,
            Format('������ ��� ��������� ������� "%s" (%s)',
            [ScriptData, E.Message]), mtError);
          raise;
        end;
      end;
      if trnWrite.Active = False then
        trnWrite.StartTransaction;
      trnWrite.ExecSQLImmediate(Format(
        'insert into builds (build) values (%s)',
        [NewBuild]));
      trnWrite.Commit;
    except
      trnWrite.Rollback;
      raise;
    end;
    dmOtto.dbOtto.Close;
    try
      dmOtto.BackupDatabase(AfterBackupFileName);
      dmOtto.CreateAlert(HeaderText, Format('������ %s �����������',
        [NewBuild]), mtInformation);
    except
      on E: Exception do
      begin
        dmOtto.CreateAlert(HeaderText,
          Format('������ �������� ��������� ����� "%s" (%s)',
          [BeforeBackupFileName, E.Message]), mtError);
        raise;
      end;
    end;
    dmOtto.dbOtto.Open(true);
  except
    NewBuild := FillFront(IntToStr(dmOtto.Build), 6, '0');
    try
      dmOtto.RestoreDatabase(BeforeBackupFileName);
      dmOtto.CreateAlert(HeaderText, Format('������ %s �������������', [NewBuild]),
        mtWarning);
      dmOtto.dbOtto.Open(true);
    except
      on E: Exception do
        dmOtto.CreateAlert(HeaderText,
          Format('������ ��� �������������� ���c�� "%s". ������������ ���� �� ��������� ����� �������. (%s)',
          [NewBuild, E.Message]), mtError);
    end;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  verInfo.Filename := ParamStr(0);
  Caption:= Format('PPZ2 Build:%s %s', [verInfo.GetBuildOnly, dmOtto.UserName]);
end;

procedure TMainForm.scrptUpdateExecuteError(Sender: TObject; StatementNo,
  Line: Integer; Statement: TStrings; SQLCode: Integer; const Msg: string;
  var doRollBack, Stop: Boolean);
begin
  Log1.Add(FormatDateTime('DD-MM-YYYY HH:NN', Now), IntToStr(Line) + ' ' +
    Statement.Text + Msg);
  log1.ShowLog('aaa');
end;

procedure TMainForm.actExportSMSRejectedExecute(Sender: TObject);
begin
  ExportSMSRejected(trnWrite);
end;

procedure TMainForm.actExportCancellationExecute(Sender: TObject);
begin
  ExportCancelRequest(trnWrite);
end;

procedure TMainForm.actExportPaymentExecute(Sender: TObject);
begin
  ExportInvoices(trnWrite);
end;

procedure TMainForm.actExportPackListExecute(Sender: TObject);
begin
  ExportPackList(trnWrite);
end;

procedure TMainForm.actBackupExecute(Sender: TObject);
const
  HeaderText = '�������� �����';
var
  Build, FileName: string;
begin
  Build := FillFront(IntToStr(dmOtto.Build), 6, '0');
  dmOtto.CreateAlert(HeaderText, Format('�������� ����� %s ...', [Build]),
    mtInformation, 10000);
  FileName:= GetNextFileName(Format('%s%s_%s_%%u.fbk',
    [Path['Backup'], FormatDateTime('YYYYMMDD', Date), Build]), 1);
  try
    if dmOtto.dbOtto.Connected then
      dmOtto.dbOtto.Close;
    dmOtto.BackupDatabase(FileName);
    dmOtto.CreateAlert(HeaderText, Format('�������� ����� %s �������',
       [ExtractFileNameOnly(FileName)]), mtInformation);
  finally
    dmOtto.dbOtto.Open;
  end;
end;

procedure TMainForm.actRestoreExecute(Sender: TObject);
const
  HeaderText = '�������� �����';
var
  Build, BeforeBackupFileName: string;
begin
  dlgOpenRestore.InitialDir:= Path['Backup'];
  if dlgOpenRestore.Execute then
  begin
    Build:= FillFront(IntToStr(dmOtto.Build), 6, '0');
    dmOtto.CreateAlert(HeaderText, Format('�������� ����� %s ...', [Build]),
      mtInformation, 10000);
    BeforeBackupFileName:= Format('%s%s_%s_prerestore.fbk',
      [Path['Backup'], FormatDateTime('YYYYMMDD', Date), Build]);
    if dmOtto.dbOtto.Connected then
      dmOtto.dbOtto.Close;
    try
      dmOtto.CreateAlert(HeaderText, Format('�������������� ����� %s ...',
        [ExtractFileNameOnly(dlgOpenRestore.FileName)]),
        mtInformation, 10000);
      dmOtto.RestoreDatabase(dlgOpenRestore.FileName);
      dmOtto.CreateAlert(HeaderText, Format('������������� �� ����� %s ...',
        [ExtractFileNameOnly(dlgOpenRestore.FileName)]),
        mtInformation);
    except
      try
        dmOtto.RestoreDatabase(BeforeBackupFileName);
        dmOtto.CreateAlert(HeaderText, Format('������ %s �������������', [Build]),
          mtWarning);
      except
        on E: Exception do
          dmOtto.CreateAlert(HeaderText,
            Format('������ ��� �������������� ���c�� "%s". ������������ ���� �� ��������� ����� �������. (%s)',
            [Build, E.Message]), mtError);
      end;
    end;
    dmOtto.dbOtto.Open(true);
  end
  else
  begin
    dmOtto.CreateAlert(HeaderText, '�������������� �� ����� ��������',
      mtInformation, 10000);
    Exit;
  end;
end;

procedure TMainForm.alMainUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  actInstallPatch.Enabled := verInfo.GetBuildOnly > dmOtto.Build;
  if actInstallPatch.Enabled then
    subMenuSystem.ImageIndex:= actInstallPatch.ImageIndex;
end;


procedure TMainForm.btnReturnClick(Sender: TObject);
begin
  TFormWizardReturn.CreateBlank(Self).Show;
end;

end.
