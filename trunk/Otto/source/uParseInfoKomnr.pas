unit uParseInfoKomnr;

interface

uses
  GvXml, FIBDatabase, pFIBDatabase;

procedure ProcessInfoKomnR(aMessageId: Integer; aTransaction: TpFIBTransaction);

implementation

uses
  Classes, SysUtils, GvStr, udmOtto, Variants, GvXmlUtils,
  Dialogs, Controls, GvFile, GvDtTm;

procedure ParseInfoKomnrLine(aMessageId, LineNo: Integer; aLine: string;
  ndProduct: TGvXmlNode; aTransaction: TpFIBTransaction);
var
  sl: TStringList;
begin
  sl:= TStringList.Create;
  try
    sl.Delimiter:= ' ';
    sl.DelimitedText:= aLine;

    try
      aTransaction.ExecSQLImmediate(Format(
        'execute procedure packlist_upsert(%s, %s)', [sl[1], sl[2]]));
      dmOtto.Notify(aMessageId,
        '[LINE_NO]. ������� [PACKLIST_NO]. ��� [PACKLIST_CODE]',
        'I',
        Strings2Attr(sl, 'PACKLIST_NO=1;PACKLIST_CODE=2',
        Value2Attr(LineNo, 'LINE_NO')));
    except
      on E: Exception do
        dmOtto.Notify(aMessageId,
          '[LINE_NO]. ������� [PACKLIST_NO]. ��� [PACKLIST_CODE]. ������ ([ERROR_TEXT])',
          'E',
          Strings2Attr(sl, 'PACKLIST_NO=1;PACKLIST_CODE=2',
          Value2Attr(DeleteChars(E.Message, #10#13), 'ERROR_TEXT',
          Value2Attr(LineNo, 'LINE_NO'))));
    end;
    dmOtto.AllDealersNotify(aMessageId, aLine, aTransaction);
  finally
    sl.Free;
  end;
end;

procedure ParseInfoKomnr(aMessageId: Integer; ndMessage: TGvXmlNode;
  aTransaction: TpFIBTransaction);
var
  LineNo: Integer;
  Lines: TStringList;
  MessageFileName: String;
  ndProduct: TGvXmlNode;
begin
  dmOtto.ClearNotify(aMessageId);
  aTransaction.StartTransaction;
  try
    dmOtto.ObjectGet(ndMessage, aMessageId, aTransaction);
    ndProduct:= ndMessage.FindOrCreate('PRODUCT');
    dmOtto.ObjectGet(ndProduct, dmOtto.DetectProductId(ndMessage, aTransaction), aTransaction);

    MessageFileName:= ndMessage['FILE_NAME'];
    dmOtto.Notify(aMessageId,
      '������ ��������� �����: [FILE_NAME]', '',
      Value2Attr(MessageFileName, 'FILE_NAME'));

    Lines:= TStringList.Create;
    try
      if FileExists(Path['Messages.In']+MessageFileName) then
      begin
        Lines.LoadFromFile(Path['Messages.In']+MessageFileName);
        Lines.Text:= ReplaceAll(Lines.Text, #13#13#10, #13#10);
        dmOtto.InitProgress(Lines.Count, Format('��������� ����� %s ...', [MessageFileName]));
        For LineNo:= 1 to Lines.Count - 1 do
        begin
          if Lines[LineNo] <> '' then
            ParseInfoKomnrLine(aMessageId, LineNo, Lines[LineNo], ndProduct, aTransaction);
          dmOtto.StepProgress;
        end;
      end
      else
        dmOtto.Notify(aMessageId,
          '���� [FILE_NAME] �� ������.', 'E',
          Value2Attr(MessageFileName, 'FILE_NAME'));
    finally
      dmOtto.InitProgress;
      dmOtto.Notify(aMessageId,
        '����� ��������� �����: [FILE_NAME]', '',
        Value2Attr(MessageFileName, 'FILE_NAME'));
      Lines.Free;
    end;
    dmOtto.ShowProtocol(aTransaction, aMessageId);
    dmOtto.MessageCommit(aTransaction, aMessageId);
  except
    aTransaction.Rollback;
  end;
end;

procedure ProcessInfoKomnr(aMessageId: Integer; aTransaction: TpFIBTransaction);
var
  aXml: TGvXml;
begin
  aXml:= TGvXml.Create('MESSAGE');
  try
    ParseInfoKomnr(aMessageId, aXml.Root, aTransaction);
  finally
    aXml.Free;
  end;
end;


end.