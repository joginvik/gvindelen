{***************************************************************}
{ FIBPlus - component library for direct access to Firebird and }
{ Interbase databases                                           }
{                                                               }
{    FIBPlus is based in part on the product                    }
{    Free IB Components, written by Gregory H. Deatz for        }
{    Hoagland, Longo, Moran, Dunst & Doukas Company.            }
{    mailto:gdeatz@hlmdd.com                                    }
{                                                               }
{    Copyright (c) 1998-2001 Serge Buzadzhy                     }
{    Contact: buzz@devrace.com                                  }
{                                                               }
{ ------------------------------------------------------------- }
{    FIBPlus home page      : http://www.fibplus.net/           }
{    FIBPlus support e-mail : fibplus@devrace.com               }
{ ------------------------------------------------------------- }
{                                                               }
{  Please see the file License.txt for full license information }
{***************************************************************}

unit fraConditionsEdit;

interface

{$I FIBPlus.inc}
uses
  Windows, Messages, SysUtils,
  Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, pFIBProps
  {$IFDEF LINUX}
    ,VKCodes
  {$ENDIF}
  ;

type
  TfraEdConditions = class(TFrame)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    Splitter1: TSplitter;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    GroupBox2: TGroupBox;
    GroupBox1: TGroupBox;
    Panel3: TPanel;
    Memo1: TMemo;
    Panel4: TPanel;
    ListView1: TListView;
    btnEdit: TButton;
    procedure Memo1Exit(Sender: TObject);
    procedure ListView1Resize(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ListView1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ListView1Click(Sender: TObject);
    procedure ListView1Change(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure FormCreate(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
  private
    FTexts     :TStrings;
    FConditions:TConditions;
    procedure   DeleteListSelected;
    procedure   InsertToList;
  public
    constructor Create(AOwner:TComponent); override;
    destructor  Destroy; override;
    procedure   PrepareFrame(Value:TConditions);
    procedure   ApplyChanges;
  end;




implementation
uses StrUtil, FIBConsts;

{$R *.dfm}



procedure TfraEdConditions.Memo1Exit(Sender: TObject);
begin
   if ListView1.Selected<>nil then
   begin
    FTexts[ListView1.Selected.Index]:=Memo1.Lines.Text;
   end;
end;

procedure TfraEdConditions.ListView1Resize(Sender: TObject);
begin
  ListView1.Columns[0].Width:= ListView1.Width-20
end;

procedure TfraEdConditions.Button3Click(Sender: TObject);
begin
  DeleteListSelected;
end;

procedure TfraEdConditions.ListView1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
   VK_DELETE:    if not (ssCtrl in Shift) then DeleteListSelected;
   VK_F2    :
   begin
    if Assigned(ListView1.Selected) then
    {$IFNDEF LINUX}
     ListView1.Selected.EditCaption;
    {$ELSE}
     ListView1.Selected.EditText;
    {$ENDIF}
   end;
  end;
end;

procedure TfraEdConditions.DeleteListSelected;
var i:integer;
begin
  if ListView1.Selected<>nil then
  begin
    i:=ListView1.Selected.Index;
    ListView1.Items.Delete(i);
    if (i=ListView1.Items.Count) then
     if ListView1.Items.Count=0 then
     begin
      Memo1.Lines.Clear; Exit;
     end
     else
      i:=ListView1.Items.Count-1;
   ListView1.Selected:=ListView1.Items[i];
   ListView1Change(ListView1, ListView1.Items[i],ctState);
  end;
end;

procedure TfraEdConditions.InsertToList;
begin
  FTexts.Add('');
  ListView1.Selected:=ListView1.Items.Add;
  Memo1.Lines.Clear;
  Memo1.SetFocus;
end;

procedure TfraEdConditions.Button4Click(Sender: TObject);
begin
 InsertToList;
end;

procedure TfraEdConditions.Button5Click(Sender: TObject);
begin
 ListView1.Items.Clear;
 Memo1.Lines.Clear;
end;

procedure TfraEdConditions.ListView1Click(Sender: TObject);
begin
   if ListView1.Selected<>nil then
   begin
    Memo1.Lines.Text:= FTexts[ListView1.Selected.Index];
   end;
end;

procedure TfraEdConditions.ListView1Change(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
   if ListView1.Selected<>nil then
   begin
    Memo1.Lines.Text:= FTexts[ListView1.Selected.Index];
   end;
end;

constructor TfraEdConditions.Create(AOwner: TComponent);
begin
  FTexts    :=TStringList.Create;
  inherited Create(AOwner);
end;

destructor TfraEdConditions.Destroy;
begin
  FTexts.Free;
  inherited;
end;

procedure TfraEdConditions.FormCreate(Sender: TObject);
begin
  Caption := FPConditionsCaption;
  GroupBox2.Caption := FPConditionsText;
  GroupBox1.Caption := FPConditionsNames;
  ListView1.Columns[0].Caption := FPConditionsColumnConditions;
  Button3.Caption := FPConditionsDelete;
  Button4.Caption := FPConditionsAdd;
  Button5.Caption := FPConditionsClear;

  Button1.Caption := SOKButton;
  Button2.Caption := SCancelButton;
end;

procedure TfraEdConditions.btnEditClick(Sender: TObject);
begin
  if Assigned(ListView1.Selected) then
    {$IFNDEF LINUX}
     ListView1.Selected.EditCaption;
    {$ELSE}
     ListView1.Selected.EditText;
    {$ENDIF}
end;

procedure TfraEdConditions.PrepareFrame(Value:TConditions);
var
      i: integer;
     li: TListItem;
begin
  FConditions:=Value;
  GroupBox2.Caption := FPConditionsText;
  GroupBox1.Caption := FPConditionsNames;
  ListView1.Columns[0].Caption := FPConditionsColumnConditions;
  Button3.Caption := FPConditionsDelete;
  Button4.Caption := FPConditionsAdd;
  Button5.Caption := FPConditionsClear;

  Button1.Caption := SOKButton;
  Button2.Caption := SCancelButton;
  FTexts.Clear;
  ListView1.Items.Clear;
  for i:=0 to Pred(Value.Count) do
  begin
   li:=ListView1.Items.Add;
   li.Caption:=Value.Names[i];
   FTexts.Add(Value.Condition[i].Value);
   if Value[i].Enabled then
    li.Checked:=True;
  end;
  if Value.Count>0 then
  begin
   Memo1.Lines.Text:=Value[0].Value;
   ListView1.Selected:=ListView1.Items[0];
  end
  else
   Memo1.Lines.Clear
end;

procedure TfraEdConditions.ApplyChanges;
var
      i: integer;
begin
   if Assigned(FConditions) then
   begin
    FConditions.Clear;
    for i:=0 to Pred(ListView1.Items.Count) do
    begin
     FConditions.AddCondition(ListView1.Items[i].Caption,FTexts[i],ListView1.Items[i].Checked)
    end;
   end; 
end;

end.
