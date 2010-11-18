unit uRecBetCity;

interface
uses
  Classes, NativeXML, ComCtrls;

const
  BetCity_Name='BetCity';
  BetCity_Id=4;

procedure RecognizeBetCityLine(Html: String; ProgressBar: TProgressBar; StatusBar: TStatusBar);

implementation

uses
  dm, GvinStr, GvHtml, SysUtils, Masks, Math, DateUtils, GvHtml2Xml,
  GvinFile, GvinMath, Forms;

function GetEventDate(St: String): TDateTime;
var
  D, M, Y: Word;
  Mns: String;
begin
  if Pos(' ', St) = 0 then
  begin
    D:= StrToInt(TakeFront5(St, ['.']));
    M:= StrToInt(TakeFront5(St, ['.']));
    Y:= StrToInt(TakeFront5(St, ['.']));
  end
  else
  begin
    D:= StrToInt(TakeFront5(St, [',', ' ']));
    Mns:= AnsiLowerCase(TakeFront5(St));
    Y:= StrToInt(TakeFront5(St));
    M:= WordNo(Mns, '������;�������;�����;������;���;����;����;�������;��������;�������;������;�������')+1;
  end;
  Result:= EncodeDate(Y, M, D)
end;

function GetEventTime(St: String): TDateTime;
var
  H, N: Word;
begin
  H:= StrToInt(TakeFront5(St, [':']));
  N:= StrToInt(St);
  result:= EncodeTime(H, N, 0, 0);
end;

procedure RecognizeHeader(ndTable: TXmlNode);
var
  th, tdh: TXmlNode;
  Caption: String;
  c: Integer;
  Titles: TStringList;
begin
  th:= ndTable.Nodes[0];
  if th=nil then Exit;
  // ���������� ���� �������
  Titles:= TStringList.Create;
  try
    Titles.CommaText:=
      '"�����='+ctEventDtTm+'",'+
      '"������� 1='+ctGamer1+'","�������1='+ctGamer1+'",'+
      '"����� 1='+ctGamer1+'","�����1='+ctGamer1+'",'+
      '"��������� 1='+ctGamer1+'","���������1='+ctGamer1+'",'+
      '"�������� 1='+ctGamer1+'","��������1='+ctGamer1+'",'+
      '"������� 2='+ctGamer2+'","�������2='+ctGamer2+'",'+
      '"����� 2='+ctGamer2+'","�����2='+ctGamer2+'",'+
      '"��������� 2='+ctGamer2+'","���������2='+ctGamer2+'",'+
      '"�������� 2='+ctGamer2+'","��������2='+ctGamer2+'",'+
      '"1='+btWin1+'","���.1='+btWin1+'",'+
      '"X='+btDraw+'","�='+btDraw+'",'+
      '"2='+btWin2+'","���.2='+btWin2+'",'+
      '"1X='+btNoLose1+'","1�='+btNoLose1+'","12='+btNoDraw+'","X2='+btNoLose2+'","�2='+btNoLose2+'",'+
      '"����=FV","��=FK","���� 1='+ctFora1V+'","����1='+ctFora1V+'",'+
      '"���� 2='+ctFora2V+'","����2='+ctFora2V+'",'+
      '"�����='+ctTotV+'","�����(�������)='+ctTotV+'","���='+btTotLo+'","���='+btTotHi+'"';
    For c:=0 to th.NodeCount-1 do
    begin
      tdh:= th.Nodes[c];
      Caption:= tdh.ValueAsString;
      if Titles.Values[Caption]<>'' then
        tdh.WriteAttributeString(attTitle, Titles.Values[Caption]);
    end;
  finally
    Titles.Free;
  end;
  tdh:= th.NodeByAttributeValue(nnTd, attTitle, 'FV');
  if tdh<>nil then
    tdh.WriteAttributeString(attTitle, ctFora1V);
  tdh:= th.NodeByAttributeValue(nnTd, attTitle, 'FK');
  if tdh<>nil then
    tdh.WriteAttributeString(attTitle, btFora1);
  tdh:= th.NodeByAttributeValue(nnTd, attTitle, 'FV');
  if tdh<>nil then
    tdh.WriteAttributeString(attTitle, ctFora2V);
  tdh:= th.NodeByAttributeValue(nnTd, attTitle, 'FK');
  if tdh<>nil then
    tdh.WriteAttributeString(attTitle, btFora2);
end;

procedure RecognizeBetCityLine(Html: String; ProgressBar: TProgressBar; StatusBar: TStatusBar);
var
  BSportName, TournirName, CountrySign: String;
  ASportId, BookerId: Integer;
  BSportId, TournirId, WaysCnt: Integer;
  EventDate: TDateTime;
  Line: TNativeXML;
  PrztT, PrztG: TStringList;

procedure ExtractLineEvent(Html: String);
var
  ndTable, tr: TXmlNode;
  iDate, iGamer1, iGamer2,
  r: Integer;
begin
  ndTable:= Line.Root;
  try
    TableHtmlToXML(html, ndTable);
    KillRowIfCol(ndTable, 0, tcaEmpty);
    RecognizeHeader(ndTable);
    CopyHeaderToAttribute(ndTable);
    KillRowIfCol(ndTable, 0, tcaEqualSt, '�����');

    tr:= ndTable.Nodes[0];
    try
      iDate:= tr.NodeByAttributeValue(nnTd, attTitle, ctEventDtTm).IndexInParent;
      iGamer1:= tr.NodeByAttributeValue(nnTd,attTitle, ctGamer1).IndexInParent;
      iGamer2:= tr.NodeByAttributeValue(nnTd,attTitle, ctGamer2).IndexInParent;

      for r:= 0 to ndTable.NodeCount-1 do
      begin
        tr:= ndTable.Nodes[r];
        dmSwim.FillEventParam(TournirId,
          EventDate+GetEventTime(tr[iDate].ValueAsString),
          PrepareGamerName(tr[iGamer1].ValueAsString, PrztG),
          PrepareGamerName(tr[iGamer2].ValueAsString, PrztG));
        try
          dmSwim.PutBet(0, btWin1, tr, WaysCnt);
          dmSwim.PutBet(1, btWin2, tr, WaysCnt);
          if WaysCnt = 3 then
          begin
            dmSwim.PutBet(2, btDraw, tr, 3);
            dmSwim.PutBet(3, btNoLose1, tr, 3);
            dmSwim.PutBet(4, btNoDraw, tr, 3);
            dmSwim.PutBet(5, btNoLose2, tr, 3);
          end;
          dmSwim.PutTotal(6, btTotLo, tr);
          dmSwim.PutTotal(7, btTotHi, tr);
          dmSwim.PutFora(8, btFora1, tr);
          dmSwim.PutFora(9, btFora2, tr);
        except
        end;
        dmSwim.PutEvent;
      end;
    except
  //    ShowMessage(tr.WriteToString);
    end;
  finally
    ndTable.Clear;
  end;
end;

procedure ExtractDate(Html: String);
var
  sl: TStringList;
  i: Integer;
  St, StDt: String;
begin
  sl:= TStringList.Create;
  try
    sl.Text:= ReplaceAll(Html, '><tbody class=date>', '>'#$D#$A'<tbody class=date>');
    for i:= 0 to sl.Count-1 do
    begin
      St:= sl[i];
      StDt:= TakeBE(St, '<tbody ', '</tbody>');
      StDt:= DeleteAllBE(StDt, '<', '>');
      EventDate:= GetEventDate(StDt);
      ExtractLineEvent(St);
    end
  finally
    sl.Free;
  end;
end;

procedure ExtractTournir(Html: String);
var
  sl: TStringList;
  St: String;
  i: Integer;
begin
  sl:= TStringList.Create;
  try
    sl.Text:= ReplaceAll(Html, '><table ', '>'#$D#$A'<table ');
    ProgressBar.Max:= sl.Count;
    For i:= 0 to sl.Count - 1 do
    begin
      Application.ProcessMessages;
      ProgressBar.StepIt;
      St:= sl[i];
      if LowerCase(Copy(St,1, 6)) <> '<table' then Continue;
      TournirName:= PrepareTournirName(TakeBE(St, '<thead>', '</thead>'), PrztT);
      BSportName:= TakeFront5(TournirName, ['.']);
      TournirName:= Trim(TournirName);
      StatusBar.SimpleText:= BSportName+'. '+TournirName;

      ASportId:= dmSwim.GetASportId_byBSportName(BookerId, BSportName, TournirName,
        CountrySign, BSportId, TournirId, WaysCnt);
      if ASportId > 0 then
      begin
        St:= DeleteAllBE(St, '<table ', '>');
        ExtractDate(St);
      end;
    end;
  finally
    sl.Free;
  end;
end;

begin
  Line:= TNativeXml.CreateName('Node');
  PrztT:= CreateParazit(Path['Parazit.Tournir']+'BetCity.txt');
  PrztG:= CreateParazit(Path['Parazit.Gamer']+'BetCity.txt');
  try
    BookerId:= Betcity_Id;
    ProgressBar.Position:= 0;
    ExtractTournir(Html);
    ProgressBar.Position:= 0;
    StatusBar.SimpleText:= '';
  finally
    Line.Free;
    PrztG.Free;
    PrztT.Free;
  end;
end;

end.
