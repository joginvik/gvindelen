7.0.0
  1. ��������� RefreshFromQuery
  2. ���������� BCDField ��� ������� ������.  
  3. ������ ��� ��������� ��������� ������� �������� (����������� ��������� ������� � �������� ��������)
  4. ������ AutoUpdateOptions (�� ����������� ��������� � ������ ��������� ����� ������� �������� ��������)
  5. ��������� ��������� ���������� ���� SQL_NULL ��� ��25
  6. ������������ ����������, ���������� ��� ������������� ������� TFIBDataSet.SaveToFile, TFIBDataSet.LoadFromFile � ������ ��� 2009-2010
 7.  ������ ��� ������������� protectedEdit. ���������� �������������� ������� ������ ��� �����������.
 8. ������ ���������� ��� ������������� �������� Filter   ��� ��������� ����� ���  D2010
 9. ��������� ����������� �������� ���� ����� ������ ������� ����� ����� AsWideString
10. ������ � pFIBScripter  ��� ��������� ��������� �������� ��� ������������� SET TERM
11. ��������� pFIBDBSchema - ���������� ���������� � ����������, � ������� ������, ��� �� ��������� �������� ��� � �� ���� � �����
12. ������ ��� ������ � ����������� � ������� ��������
13. ���������� ����� DataSet.AutoUpdateOptions.UseRowsClause
14. 2009-2010 ������ � ������� 

    procedure BatchInputRawFile(const FileName:string);
    procedure BatchOutputRawFile(const FileName:string;Version:integer=1);

15. ������ � ������ TFIBXSQLVAR.IsRealType
16. � ��������� ������� ���������� ����� ���������� ���������� (gds32)
17. ��������� ������ pFIBDatabase.ShutDown  � pFIBDatabase.Online (ShutDown ����� ������������ ����� �� FB2 
 isc_dpb_shut_multi,isc_dpb_shut_single,isc_dpb_shut_full
)
18. � ����� 
         procedure SaveToFile(const FileName: string; AddInfo:Ansistring='');
     AddInfo - ����������� ��������� �������������� ����������

    procedure LoadFromFile(const FileName: string; var AddInfo:Ansistring); overload;
    �������� � ���������� AddInfo ����� ����������� ��� ����������

19. ����� 
    procedure TpFIBDataSet.RefreshFromDataSet(RefreshDataSet:TDataSet;const KeyFields:string;
     IsDeletedRecords:boolean=False
    );

   ����� �������������� � �������� ��������� ��� ������� ������� ����������
20. ���������� ���������� ��������� ����� ��������� ������� BeforeFetchRecord
21. �������������� ����� ��2 isc_dpb_no_db_triggers,isc_dpb_utf8_filename
22. ����� ������� ��� 2.5 isc_spb_res_fix_fss_metadata,isc_spb_res_fix_fss_data
23. ����� �������� poDontCloseAfterEndTransaction
24. ��������  �� ����������� ������������ �����������

6.9.9
 1. ������ ��� �������������  AutoUpdateOptions.UseExecuteBlock
 2. ��� AutoUpdateOptions.UseExecuteBlock  ����� ������ ����������� ����� Transaction.ExecSQLImmediate
 3. TFIBStringField.Value  ��� 2009 ��� ��������� ���������
 4. �� �������� ����� qoTrimCharFields  ��� �������� FIBQuery.Fields.AsWideString
 5. ������ ��� ������� ������������ TWideStringField � �������� ���� ����
 6. ������ ��� ������ ������� �������� ���������� ����
 7. ������ ������ � ������������� �����������
 8. ������ ��� ������������� ������ ��� 2009 (� ������ poAllowCommandText)
 9. ������ ��� ������������� �������� � ���������� ���������� ��� 2009 
10. ������ ��� �������������� �������� ����� �� ���������  ��� 2009
11. ������ �������� DataSet.FieldValues  ��� ������ � ���������� ������ ��� 2009. 
12. ���������� ������ � ����������-���� ������ ��� �����-������������ �2009. 
13. ������ TFIBXSQLVAR.LoadFromFile,TFIBXSQLVAR.SaveToFile  ������ �� ������ �������� 
    ����������� ����� � ������, � ����� ����� �� ����� � ���� (�� ���� � ����). 
    ��������� ��� ������ � �������� ���� �������.
14. ������������� �� ������� 2010.
15. � ��������� ��������� ������� SET CLIENTLIB.
16. ��� 2009-2010 �� ��������� ��������� ���� ������ ����������� �� TFIBWideStringField.
    ������� � �������������� ���������� ��������� TStringField  � ����� �����������

 serg_vostrikov (15:53:06 10/11/2009)
17. �������� �� ����������� EXECUTE BLOCK � ������ ���� ������������ �������� ';'
18. � ������ protected edit  ������ �� ������ ������������� �������� (�.�. �������� 
  Edit;Post; Commit; Edit; // �� ������   Edit ���������� ����������� �� ������
)
19 ������ �������� AsGuid  � ������ TFIBGuidField.
20. ������ ��������� ����� �����
21. ����� DataSet.RefreshFromQuery
22. ������ ��������� SQLEditor ��� D2009-2010   � ������ ������������� �B ���� 2.1
23. Database.AutoReconnect:boolean



6.9.6
1. �� ����������� ����� �������� poFreeHandlesAfterClose � ����� qoFreeHandleAfterExecute
2. ��� �2009 ������ ��� ������ � IB  � FB ������ ������ 2. ����������� ��� �������
{$DEFINE UNICODE_TO_STRING_FIELDS}
3. ��������� ������� FIBDatabase
   TOnIdleConnect=procedure (Sender:TFIBDatabase; IdleTicks:Cardinal; var Action:TActionOnIdle) of object;
  ��� TActionOnIdle=(aiCloseConnect,aiKeepLiveConnect);
  ��������� ��� "������� ����������" � ������ ���� �������� TimeOut <>0. 
4. ������� Timer. ����������� �� VCL  ��������  ������������������
5. ������ � ������ TpFIBScripter.ExecuteFromFile. ����������� �� ��������� ��������
6. ������ � ������ Locate  ��� �2009. ����������� ���  ������ ������
Locate('FIELD', searchstr, [loCaseInsensitive, loPartialKey])
7. ������� ��� ������ � �������. ����������� ������ ��� FB2.5  � ������ ���� ����������� �������� ��������,� ����� ����� ����� ���������.
8. ��� 2009 ������ Malformed string ��� ������� �������� ��������� ����-���� ��� ��������� ���������.
9  �� ���������� ����� TpFIBTransaction. SetSavePoint  ��� 2009
10. ����� ������� �������� OnReadBlobField :TOnBlobFieldProcessing
                                             OnWriteBlobField :TOnBlobFieldProcessing
��� TOnBlobFieldProcessing= procedure (Field:TBlobField;BlobSize:integer;Progress:integer;var Stop:boolean)
11. ��������� ���� ����� ������������ � TClientDataSet.
12  ������������� ������������� GUID  ����� � ������  TClientDataSet
13. D2009  ������ ��� ������� ��  GUID   �����
14. pFIBClientDataSet. ������ Commit,RollBack
15. ������ ��� �������� ���������� � ����� ����������� ��� �2009
16. AutoUpdateOptions.UseReturningFields -��������� ������������ �� ��� ��������� UpdateSQL,InsertSQL  ������ RETURNING, ��� ��������� ����� ���������� ��������������� ������� �������� ���������� ������ ��� ���������� ������ Refresh.  (�������� ������� � �������� 2.0)  ����� ��� ��������� ��������. 
 rfAll - �������� � ������ RETURNING  ��� ����
 rfKeyFields - �������� � ������ RETURNING  ������ �������� ����
 rfBlobFields- �������� � ������ RETURNING  ���� ����. 



6.9.5
1. ���������� pFIBDataSet.OnLockSQLText. ��������� �������� ��������� ���-������� �����.
2. ������������� TTimer  �������� �� ������-����������. ������� �� ����.
3. � ��������� ������ ��� ��������� ����������� ����-�����
4. ������ ��� ������ ��������� ����� �� ���������� FIBStringField
5. ������ � ������ Locate  ��� ������ �� ���� �����, ���� �������� ����� ����������� ���� �����

6.8.588
   1. ������ � �������, ��������� � ������������ ������������� RefreshSQL  � ��������� �������
    www.devrace.com/bitrix/admin/ticket_edit.php?ID=10095
   2. ������ 'Can't read Buffer.Incorrect RecordNo.' 
      ��� ������������� ����� ������ Locate
   3. ������������� ������ ������ ��� ������������� ��������
   4. � ��������� �� �������������� ������� SET STATISTICS INDEX, ���������
   5. ������ ��� ������������� ������
   6. ������ � ������� AsWideString  ��� ����� � �������� NONE
   7. ������ ��� ��������� �������  ���������� ������� 
   8. ������ LockRecord
   9.  ������ � ����� (�������) ������������� ������ Locate
   10. ��������� AV  � �������� 
   11. ������ FIBDatabase
   
    a) procedure CancelOperationFB21(ConnectForCancel:TFIBDatabase=nil);
       ��������� ������������� �������. (�������� ������ ��� FB21 � ����)
    �) 

   procedure RaiseCancelOperations;
   procedure EnableCancelOperations;
   procedure DisableCancelOperations;
������ ��� ���������� ������������� �������� ��� FB2.5
   12. �������� ������� UseSelectForLock   �� �������� Preference Dataset � ������
   13. ������ ��� ������  � ���� ������ ��� ������� �������� ��������� � ���������

6.8.500
   1. ������� ��� ������ �� �������� ����� FIBQuery
   2. ������ ��� ������ � ����������� �� ��������� ����������. (������ ����������� ��� ������������ 
      ���������� ) 
   3.  ������ ��� ������� � ���������� �� �� ���������. 
   4. ������ ��� ������ �   TFIBLargeIntField.Value
   5. ������ � TpFIBScripter ��� ������ � ��������� 
    COMMENT ON COLUMN ... IS

   6. 2PC  ����������  � ������� ����������� ����������
   7. ����� �������� CacheModelOptions.BlobCacheLimit
   8.  ������ � TpFIBScripter ��� ������� ������� �� � ����� ������� ������� � �����.
   9. ������ � ������ � CsMonitor. 
  10. ������ � ������ �������� VisibleRecordCount (����������� � ���������� �������� ��������� ������)

6.8.423
 1. ��������� CsMonitor. (������� ��� ����������) ���������� �������� � 
    FIBPlus.inc    
 2. ��������� ����� procedure TFIBDatabase.ClearQueryCacheList;
 3. ���������� ������ � ������ CloneRecord. ����������� ��� ������� � �������� 
    ��������� �������
 4. ���������� ������������ ���������������� ������� ������ ����� ������� 
    ��������� ��� ���������� ����� poRefreshDeleted
 5. ���������� ��������� ���������� ���������� � ������ ���������� ��21
 6. � ����� TFIBDataTimeField, TFIBTimeField  ��������� �������� 
    ShowMsec:boolean. ��� ��������� � ����������� ����� ������������  ��������
    � ��������������
 7. ����������� �������� ����� Locate. (����� ��������� ����� ��������� �������� ������
    {$DEFINE FAST_LOCATE} � ����� FIBPlus.inc    
)
 8. ����� LookUp  ����� ��� ������ ������ �������� 
    ������������ ���������� � �������� ���� ��� ������������
 9. ��� ��2.1 �����, � ���� ���� ����� ����������� � ��� Select from procedure  ���� ��� ��������
     ��������� ����� ��� - ��������������� �����.
10. �������  - ���������� ��������������� �������� � ��������. �� ����������� ����� ������� � 
     �������� ����� �� ������ ������
11. ��������� ����� 
      procedure TFIBLargeIntField.SetVarValue(const Value: Variant);
      ����������� ������� ���� �� ����� ���� ���� ��������

6.8.411
 1. �������� ��������� TpFIBScripter
 2. � ������ CachedUpdates ��� ��������� ������� ��� CancelUpdates ����������������� �������� �����
     ������� ���� ��������������� � ������ ��������. �.�. ���� ������ ������� ��������������� � �����
    ��������� �� ��� ������ ��������� �� �������� �� ����������� �������� ������ � ����������.
 3. ���������� ������ 

    TFIBDataSet
    procedure DisableMasterSource;
    procedure EnableMasterSource;
    function  MasterSourceDisabled:boolean;

   ������ ��� ���������� ���������� ������ ������-������.  ��������

   DetailDataSet.DisableMasterSource;
   try
     MasterDataSet.Edit;
     MasterDataSet.FieldByName('ID').asInteger:=NewValue;
     MasterDataSet.Post;
     ChangeDetailDataSetLinkField(NewValue);
   finally
    DetailDataSet.EnableMasterSource;
   end
  ��� ���� ������ ������� �� ���������������. 
 4. �������� DetailDataSet.AutoUpdateOptions.UseExecuteBlock:boolean
    �������� ������ ��� CachedUpdates=True.  ���� �������� UseExecuteBlock, �� ��� ApplyUpdates,ApplyUpdToBase
    ����� ���������� ������� ���� EXECUTE BLOCK. �.�. ��������� ����� ���������� � ���� �� ��� ������
    ������ ��������, � ������� �� 255 �������. 
 5. ����������  ������ � UTF8  ������ ��� ��2007

71.302
  1.������ ������ ��� ������������� CachedUpdates � ������������ �������������� ����� � ��� �� ������
 2. ������������ ������ ��� ���������� Date ��������� ����� Value.
 3. ������ ���� ���������� �� ������ IS NULL ������ ���������� ���������������     ����� ����������� �������. �.�. ���� ������������ ������� ������ Prepare �� ������������� ������ ���������������� ������ ��� ������ �����, �������� �� �� ��� ��������� ��������� ����� NULL ��������
 4. ���������� ������ � DDL ��������� ��� FB21 � ������ ODS11. (����������� ������������ � �������)

51.301
1. ������ � TFIBGuidField. ����������� ���������� ��������� ��������. �������� ��������
 {00000000-0000-0000-0000-000000000000}
2. ������ ��� ������ ������ IsEmpty ��� ������������� �������� 
 DataSet.CacheModelOptions.CacheModelKind= cmkLimitedBufferSize.
3. ������ � ��������� Sort (unit fibDataset) c DisableScrollEvents. ����������� ����  � �������� ������� �� ����� �����.
4. ������ � ������  function TpFIBDataSet.PSGetParams: TParams;(������� Danny Van den Wouwer )

5. ��������� pFIBClientDataSet. �� ������� � ���������� ������ ��� ���2006

6. ������� ����� procedure TFIBXSQLVAR.SetAsVariant(Value: Variant);
     ������ �� �����  �������� � � OleVariant  (������� Danny Van den Wouwer )
7. ������  � ������ TFIBQuery.DoAfterExecute 
     ��������� � ������������ ������������������ ������ �������� �� SQLMonitor
(������� Danny Van den Wouwer )

 8. ������ ��� ����� ���������� ���������� � ��������.
 9. ��������� �������� SUPPORT_KOI8_CHARSET
     ������ � FIBPlus.inc {$DEFINE SUPPORT_KOI8_CHARSET}
 10. ��������� ��2007
     �) ����������� ������ � FIBPlus.inc {$DEFINE SUPPORT_IB2007} 
     �) ����� FIBdatabase.IsIB2007Connect:boolean;
     �) �������� InstanceName  � ConnectParams
 11. ������ � ������       TFIBXSQLVAR.GetAsDateTime. ����������� ��� ����� ������� ��������� ��.
 12. ������ � ������ WhereClause ����������� �������������� ����������� � ����� �� (--)
 13. ������ ��� ��������� �������� c "with" ������� ��� FB2.1
 14. �� �������� TGUIDFields  � TFIBClientDataSet

+++++++++++++++++++++++++++


274. 1. ������ ��� ���������� DDL  �������� � ��������� ��������. 
        (��������� ����������� ��������� �� �� ���������� �����)   
  
272
 1. ���������� ����� poUseSelectForLock � TpFIBDataSet.Options. 
    ��������� ��� ���������� poProtectedEdit. � ������ ��������� ���� �����, 
    ������������ ������ ����� ������������� �� "�������� ��������" � ������������
    
    Select * from TABLE1 WHERE ... for update with lock
    (�������� ������ ��� ��)
 2. ����� FIBQuery.ExecuteImmediate. ���������� ��������� ������ ��� ��������������� 
    ����������. (��. ������������ �� �� ��� ������� isc_dsql_execute_immediate)
 3. ���������� DDL �������� ������ ������������ �����  ExecuteImmediate

270  
 1. � ��������� ������� ������� �����������  ���������� � ������������� ��
 2. � ��������� CopyFieldsProperties ��������� ����������� ������� 
  AutoGenerateValue, ConstraintErrorMessage, CustomConstraint, Tag � Index 
 3. ������ � TpFIBCustomService.GenerateSPB. ����������� ��� ������ ��������� Params
 4. ��� ����� ��������  Filter  �� ���������� ��������� ����������� ����������� �������.
 5. ������ � ������ Locate  ��� ������� ������ �������� �������� � ���������� �����.
 6. SQLMonitor ���� ���������� ����� ������� ��� ����� ���������� �������� � ���������� 
 7. ������� OnFillClientBlob ������ ����������  �� ������ ��� ������ ���������� ������, 
    �� � ����� �� ����������� 
 8. �������� pFIBDataSet.ReceiveEvents � ������� pFIBDataSet.OnUserEvent ����������� ���������� � ��������� �� ��������� ����.
    ��� ��� ��� �� ���������� ���, ����� ��������������� � �������� 
USE_DEPRECATE_METHODS2 � ����� FIBplus.inc
 9. ���������� ������ SQLMonitor ��� ����������� ���������. (������ ��������� � ���������)
10. SQL �������� �������� ����������, ��� ���������� ������ � ��������� � ������� ���� � 
    �� �� ������� ������ �� ��������� ���.    (�������� ������ ��� ��2)
 
269. �� ��� ������������ ��� ftSmallInt  ��� ������������ ����������� ����� 
     � TFIBCustomDataSet.RecordFieldValue

268. ������������ ��������� ����� � �������� UTF8  � ��������� �������� �� 
��������������.

267.
 1. ��� ����������� ��� ���� ��������� � shutdown ������� ������������� �����������,
    ����� ������������ ��������� ������ �������� (��� ������������� pFibErrorHandler)
 2. ������ �  ���������� ��������. �� ����������� ��� ����, ��� ����� DOUBLE PRECISION
266.
 1. ��������� ������ ������ ��� ������ � ����-����������� � ��������� �������
 2. ������ ��� ������ (Locate) unicode-������ � ���� varchar(unicode_fss) ��� 
    ���������� ����� poTrimCharFields 

265
 1. ���������� ������� 
    function  InvertOrderClause(const OrderText:string):string;
    (�� ������������ ����� ��� � ������������� NULLS FIRST, ��� ��������� ��� ��������� 
    � ������������ ������ ������ ������������� ���� ��� ����� ��������)
254
 1. ���������� ������ TpFIBDataSet.PSInTransaction, PSStartTransaction,PSEndTransaction


253
 1. ����� ���������� ��������� �������� "COMMIT" "ROLLBACK".
 2. ���������  �������� ����������� ������. ����������� ������� ��� ������ 
    "Unique Indices"
 3. ���������� ������ � ������ FIBDataSet.RecordFieldValue(Field:TField;aBookmark:TBookmark):Variant; 
251

1.���� ������� ����� ������ PLAN � ������� TpFIBDataSet.SelectSQL ���������� ������� JOIN (�.�. 
  ���������� �� �� ����� JOIN, � �� ������), �� ������������ �������� TpFIBDataSet.PlanClause ������ �������� ����� 
  ����������� ������ � �������� ������� PLAN (� �� ������������ �������� ������ ����� ����� PLAN).
  ����������
2. TpFibErrorHandler �������� ��������� ��������� � ���������������� ��������� ��� ��2.
   (� ������ ���������� � ���� ������ PSQL Stack Trace) 
3. ������ ������  � ������ FIBQuery.PrepareArraySqlVar 
4. ����������� ��������� ������ �������� ��� ������ ����� ������������ ������� ��� 
   ��������������

250.
  1. TFIBCustomDataSet.RecordFieldValue �������������� ��������� BOOLEAN ����� 
     �� ��7
  2. ��������� ��������� ����� ������� UTF8 ��� ��1.5 � ��2
  3. ��� ��������� ���������� ��������
      property UseBlrToTextFilter :boolean 
     �������� ��������� ��������� ���� ����� � ��������� Blr (2), Acl(3)
     (��������� ����. ������ 2 ����������� ������� ������ ���������� �� �� ����������)

248.
   CloneCurRecord: error with boolean field in record (IB7)
247
 1.������ � LocateNext. ���� ��������� ������ �������� ������������� ������� ������,
   � ����� ���������� � ���, �� LocateNext ��������� True
 2.������������ ������ �������  LocateXXX � ��������� � ����������� �� 
   ����������� �����. ����������� � ������ ���� Locate ���������� �� ������������� 
   ����� � ���������� �� �����������

 3. ������  FIBDatabase.QueryValueAsStr ����� ���������� ������ ������ � ������ 
    �����  ������, ������������ � ������� ������ �� ���������� ��� ������������ ���� Null,

 4. ���� ���������� � �������� CachedUpdates=True � ��������� � OnUpdateError "UpdateAction:=uaAbort;", 
    �� ����� ��������� OnUpdateError �������� EAccessViolation.

245
 1.� �������� �������� ����������
 TOnApplyFieldRepository=procedure(DataSet:TDataSet;Field:TField;FieldInfo:TpFIBFieldInfo) of object;
 2.� DSContainer �������� ���������� ����������� �1
 3.� DSContainer ��������� �������� IsGlobal:boolean. ��� ��������� �� � True 
   �������� ���������� �������� ���������������� �� ��� ��������  ����������.

������������ �1-3 ��������� ������������ ����� ������������ ���� ����������� ��������� �
����������� �����. ��� ������. ���� ������� ����������� �������� EditMask, �� ���������
� ������� ����������� ����  EDIT_MASK, � ���������� ������ ���������, ������ ��� ����������
� �����������  OnApplyFieldRepository �����:

procedure TForm1.DataSetsContainer1ApplyFieldRepository(DataSet: TDataSet;
  Field: TField; FieldInfo: TpFIBFieldInfo);
begin
 Field.EditMask:=FieldInfo.OtherInfo.Values['EDIT_MASK'];
end;

243
 1. ������ � SQLEditor ��� ������� ������ � ��.
 2. ������ ��� ��������� RefreshSQL ���� ����� ������� ���������� � �������������� "AS"
 
242
 1. ������ ��� ���������� ��������� execute block
 2. ������ ��� ��������� ������ �������� � ������ ���� ���������� ��������� ��������� � ������ �����

241
 1. ��� ����� LargeInt  �������� Filter ����������������
 2. ��������� �� ��� ��������� � DoTrim ����� � �������� ��������� ������������ ������ ������
 


240
1.LocateNext �������� �����������, ���� �� ��� ������ ������� � ��� 
2.ExtLocate ��� �������� ������ �� �������������� ��������, ��� ������� ���������� ���������� 
  �� ������� ����� �������, ������ ��������� �� ������ ��������� ������, � ���������

234
 BCD ���� �� ����� �������������� � �������� ��������
232
 1. AV ��� �������� BDS2006  � CBuilder ��������
 2. ��������� �������� � SQLNavigator �� FIBPlusTools.
��� �������� ���� SQL Navigator ��� �������������� �������� ���������� (File->New->Application; FibPlus->SQL Navigator:) 
����������� ������������ �� ������� ������, ���������� �� ��������� (Unit1.pas).
 3. ������ ������ ��� ������ � ������ SQL � SQLEditor

231
1. �������� ���������� TFIBDataSet.
    property AfterUpdateRecord: TFIBAfterUpdateRecordEvent read FAfterUpdateRecord
     write FAfterUpdateRecord
���  


  TFIBAfterUpdateRecordEvent = procedure(DataSet: TDataSet; UpdateKind: TUpdateKind;
    var Resume:boolean) of object;

���������� �� ApplyUpdates,ApplyUpdToBase ��� ������ ������ ����������� ������� 
������������ �� ������. ���������� ��������������� ����� ���� ��� ������� �������� 
������ �� ���������.
2. ������ ��� Locate: ���� � �������� ������ ���� �������, � ����� ����� ��� ������ 
   Locate �������� �������� ��� �������������
3. ������ ��� ��������� Field.DisplayFormat  ���� 
"#,##0.00;-#,##0.00; ;"
4. ������������ ������  SQL editor ��� ������������� ������ "Use Selected Fiedls Only"
5. ������������ ������  SQL editor ��� ��������� �������, ��� ����������� � ������ 
   SelectSQL ������������������� ������

230
 1.������������ ������ ����� dcForceMasterRefresh
 2.������ � poKeepSorting ��� ������� ��������� ������ ������ �������� 
 3.���������� ��� ������������� poKeepSorting  
 4.������ ��� ���������� poProtectedEdit .������� ������� ������ ���������
 5. ������ ��� BDS2006  ����������. � ���������� ������ ��� �� �������� ��� 
   ������� ������������� � CBuilder �����������
 6. � ������ �������� Preferences  ��������� ������� poUseLargeIntField � 
    PrepareOptions � ���������� DateTimeDisplay � DefaultFormats



225-226
 ����� ��� D2006

224
 ������ ��� D2006
214
1. ������ ������ ����������� E5912. ����������� ��� ������� �������������� 
   ������ FIBBCDField.Value:=1;

2. ������ ��� ������ � ������� � TFIBStringField. ����������� ����� ���� ����
   ������� ��� ��������, � � �������� ������� ����� SQL ����� �������, ��� �����
   ���� ���������� � ������� �������.  
 
                                                      
213
���������� ����� �������� poRefreshAfterDelete. ���� ��������, �� ����� 
DataSet.Delete ������������ ������� ������� ������ ��� ��������� ������. 
���� ������� �������� (�.�. ������ ��������� �� ���� �������), �� ������ �� 
�����  ���������� � ���� ��� ��������� � ��������� �������.