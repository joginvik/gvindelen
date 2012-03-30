object dmOtto: TdmOtto
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 553
  Top = 239
  Height = 405
  Width = 624
  object dbOtto: TpFIBDatabase
    Connected = True
    DBName = 'localhost:D:\otto\Data\otto_ppz.fdb'
    DBParams.Strings = (
      'lc_ctype=CYRL'
      'user_name=sysdba'
      'password=masterkey')
    DefaultTransaction = trnAutonomouse
    DefaultUpdateTransaction = trnAutonomouse
    SQLDialect = 3
    Timeout = 0
    UseLoginPrompt = True
    DesignDBOptions = [ddoIsDefaultDatabase, ddoStoreConnected]
    UseRepositories = []
    LibraryName = 'fbclient.dll'
    GeneratorsCache.GeneratorList = <>
    AliasName = 'Otto'
    WaitForRestoreConnect = 0
    AfterConnect = dbOttoAfterConnect
    Left = 24
    Top = 16
  end
  object spTemp: TpFIBStoredProc
    Database = dbOtto
    Left = 88
    Top = 64
  end
  object qryParams: TpFIBQuery
    Database = dbOtto
    SQL.Strings = (
      'SELECT'
      '    PARAM_NAME,'
      '    PARAM_VALUE'
      'FROM'
      '    PARAMS '
      'WHERE PARAM_ID = :PARAM_ID')
    Left = 152
    Top = 64
  end
  object qryTempRead: TpFIBQuery
    Database = dbOtto
    Left = 24
    Top = 112
  end
  object qryReadObject: TpFIBQuery
    Database = dbOtto
    SQL.Strings = (
      'SELECT'
      '    O_PARAM_NAME,'
      '    O_PARAM_VALUE'
      'FROM'
      '    OBJECT_READ(:OBJECT_SIGN, :OBJECT_ID) ')
    Left = 168
    Top = 112
  end
  object qryObjectList: TpFIBQuery
    Database = dbOtto
    Left = 104
    Top = 112
  end
  object tblTemp: TpFIBDataSet
    Database = dbOtto
    Left = 24
    Top = 160
  end
  object spObjectSearch: TpFIBStoredProc
    Database = dbOtto
    SQL.Strings = (
      
        'EXECUTE PROCEDURE SEARCH (?I_VALUE, ?I_FROM_CLAUSE, ?I_FIELDNAME' +
        '_ID, ?I_FIELDNAME_NAME, ?I_WHERE_CLAUSE, ?I_THRESHOLD)')
    StoredProcName = 'SEARCH'
    Left = 152
    Top = 168
    qoTrimCharFields = True
  end
  object spTaxRateCalc: TpFIBStoredProc
    Database = dbOtto
    SQL.Strings = (
      'EXECUTE PROCEDURE TAXRATE_CALC (?I_PARAM_ID)')
    StoredProcName = 'TAXRATE_CALC'
    Left = 208
    Top = 64
    qoAutoCommit = True
    qoStartTransaction = True
  end
  object spParamUnparse: TpFIBStoredProc
    Database = dbOtto
    SQL.Strings = (
      'EXECUTE PROCEDURE PARAM_UNPARSE (?I_PARAM_ID, ?I_PARAMS)')
    StoredProcName = 'PARAM_UNPARSE'
    Left = 240
    Top = 112
  end
  object spParamsCreate: TpFIBStoredProc
    Database = dbOtto
    SQL.Strings = (
      
        'EXECUTE PROCEDURE PARAM_CREATE (?I_OBJECT_SIGN, ?I_OBJECT_ID, ?I' +
        '_ACTION_ID)')
    StoredProcName = 'PARAM_CREATE'
    Left = 240
    Top = 176
  end
  object trnAutonomouse: TpFIBTransaction
    Active = True
    DefaultDatabase = dbOtto
    TimeoutAction = TARollback
    TRParams.Strings = (
      'write'
      'nowait'
      'concurrency')
    MDTTransactionRole = mtrAutoDefine
    TPBMode = tpbDefault
    Left = 232
    Top = 16
  end
  object qryTempUpd: TpFIBQuery
    Database = dbOtto
    Left = 336
    Top = 96
  end
  object spActionExecute: TpFIBStoredProc
    Database = dbOtto
    SQL.Strings = (
      
        'EXECUTE PROCEDURE ACTION_EXECUTE (?I_OBJECT_SIGN, ?I_PARAMS, ?I_' +
        'ACTION_SIGN, ?I_OBJECT_ID)')
    StoredProcName = 'ACTION_EXECUTE'
    Left = 360
    Top = 176
  end
  object spMessage: TpFIBStoredProc
    Transaction = trnAutonomouse
    Database = dbOtto
    Left = 408
    Top = 96
    qoAutoCommit = True
    qoStartTransaction = True
  end
  object mtblControlSets: TMemTableEh
    Active = True
    FieldDefs = <
      item
        Name = 'TAG'
        DataType = ftInteger
      end
      item
        Name = 'KEYLANG'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'CAPS'
        DataType = ftBoolean
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 288
    Top = 64
    object fldControlSets_TAG: TIntegerField
      DisplayWidth = 10
      FieldName = 'TAG'
    end
    object fldControlSets_KEYLANG: TStringField
      DisplayWidth = 3
      FieldName = 'KEYLANG'
      Size = 3
    end
    object fldControlSets_CAPS: TBooleanField
      DisplayWidth = 5
      FieldName = 'CAPS'
    end
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object TAG: TMTNumericDataFieldEh
          FieldName = 'TAG'
          NumericDataType = fdtIntegerEh
          Alignment = taLeftJustify
          DisplayWidth = 0
          Required = False
          Visible = False
          currency = False
          Precision = 0
        end
        object KEYLANG: TMTStringDataFieldEh
          FieldName = 'KEYLANG'
          StringDataType = fdtStringEh
          Alignment = taLeftJustify
          DisplayWidth = 0
          Required = False
          Visible = False
          Size = 3
          Transliterate = False
        end
        object CAPS: TMTBooleanDataFieldEh
          FieldName = 'CAPS'
          Alignment = taLeftJustify
          DisplayWidth = 0
          Required = False
          Visible = False
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            1
            'ENG'
            True)
          (
            2
            'ENG'
            False)
          (
            3
            'RUS'
            True)
          (
            4
            'RUS'
            False))
      end
    end
  end
  object spArticleGoC: TpFIBStoredProc
    Database = dbOtto
    SQL.Strings = (
      
        'EXECUTE PROCEDURE ARTICLE_GOC (?I_MAGAZINE_ID, ?I_ARTICLE_CODE, ' +
        '?I_COLOR, ?I_DIMENSION, ?I_PRICE_EUR, ?I_WEIGHT, ?I_DESCRIPTION,' +
        ' ?I_IMAGE_URL)')
    StoredProcName = 'ARTICLE_GOC'
    Left = 352
    Top = 16
  end
  object fibBackup: TpFIBBackupService
    LibraryName = 'fbclient.dll'
    Protocol = TCP
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    BlockingFactor = 0
    Options = [ConvertExtTables]
    Left = 456
    Top = 128
  end
  object fibRestore: TpFIBRestoreService
    LibraryName = 'fbclient.dll'
    Protocol = TCP
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    PageBuffers = 0
    Options = [Replace, CreateNewDB, ValidationCheck, FixFssMetadata, FixFssData]
    Left = 456
    Top = 176
  end
  object AlertStock: TJvDesktopAlertStack
    Left = 24
    Top = 216
  end
  object dbfCons: TDbf
    IndexDefs = <>
    TableLevel = 4
    Left = 144
    Top = 224
  end
  object errHandler: TpFibErrorHandler
    OnFIBErrorEvent = errHandlerFIBErrorEvent
    Options = [oeException, oeForeignKey, oeLostConnect, oeCheck, oeUniqueViolation]
    Left = 240
    Top = 224
  end
  object frxProtocol: TfrxReport
    Version = '4.9.64'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.MDIChild = True
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40998.100363171300000000
    ReportOptions.LastChange = 40998.137294224540000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      
        'procedure qryNotifiesNOTIFY_TEXTOnBeforePrint(Sender: TfrxCompon' +
        'ent);'
      'begin'
      '  case <qryNotifies."NOTIFY_CLASS"> of'
      '    '#39'I'#39': TMemo(Sender).Color := $0080FF80;     '
      '    '#39'W'#39': TMemo(Sender).Color := $0098FFFF;           '
      '    '#39'E'#39': TMemo(Sender).Color := $008080FF;'
      '  end;                  '
      'end;'
      ''
      'begin'
      
        '  if <MessageId> = null then set('#39'MessageId'#39', '#39'71134'#39');         ' +
        '                                                                ' +
        '                                       '
      'end.')
    Left = 344
    Top = 248
    Datasets = <
      item
        DataSet = frxProtocol.qryNotifies
        DataSetName = 'qryNotifies'
      end>
    Variables = <
      item
        Name = ' User'
        Value = Null
      end
      item
        Name = 'MessageId'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
      object qryNotifies: TfrxFIBQuery
        UserName = 'qryNotifies'
        CloseDataSource = True
        BCDToCurrency = False
        IgnoreDupParams = False
        Params = <
          item
            Name = 'MessageId'
            DataType = ftInteger
            Expression = '<MessageId>'
          end>
        SQL.Strings = (
          'SELECT * '
          '  FROM NOTIFIES '
          '  WHERE MESSAGE_ID = :MessageId                          '
          '  ORDER BY NOTIFY_ID')
        pLeft = 192
        pTop = 68
        Parameters = <
          item
            Name = 'MessageId'
            DataType = ftInteger
            Expression = '<MessageId>'
          end>
      end
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        Height = 22.677180000000000000
        Top = 102.047310000000000000
        Width = 718.110700000000000000
        DataSet = frxProtocol.qryNotifies
        DataSetName = 'qryNotifies'
        RowCount = 0
        Stretched = True
        object qryNotifiesNOTIFY_CLASS: TfrxMemoView
          Width = 18.897650000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'qryNotifiesNOTIFY_TEXTOnBeforePrint'
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'NOTIFY_CLASS'
          DataSet = frxProtocol.qryNotifies
          DataSetName = 'qryNotifies'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '[qryNotifies."NOTIFY_CLASS"]')
          ParentFont = False
        end
        object qryNotifiesNOTIFY_TEXT: TfrxMemoView
          Left = 18.897650000000000000
          Width = 699.213050000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frxProtocol.qryNotifies
          DataSetName = 'qryNotifies'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Memo.UTF8 = (
            '[qryNotifies."NOTIFY_TEXT"]')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object qryNotifiesNOTIFY_DTM: TfrxMemoView
          Width = 377.953000000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = frxProtocol.qryNotifies
          DataSetName = 'qryNotifies'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[qryNotifies."NOTIFY_DTM"]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 623.622450000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            #1057#1027#1057#8218#1057#1026'. [Page#] '#1056#1105#1056#183' [TotalPages#]')
          ParentFont = False
        end
      end
    end
  end
  object frxFIBComponents1: TfrxFIBComponents
    DefaultDatabase = dbOtto
    Left = 432
    Top = 248
  end
  object frxExportPDF: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    Left = 352
    Top = 312
  end
  object frxExportXLS: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    ExportEMF = True
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = True
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 432
    Top = 312
  end
end
