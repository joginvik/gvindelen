{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvControlActionsEngine.Pas, released on 2007-03-11.

The Initial Developer of the Original Code is Jens Fudickar [jens dott fudicker  att oratool dott de]
Portions created by Jens Fudickar are Copyright (C) 2002 Jens Fudickar.
All Rights Reserved.

Contributor(s): -

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.delphi-jedi.org

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvControlActionsEngine.pas 61 2011-05-29 02:32:53Z uschuster $

unit JvControlActionsEngine;

{$I jvcl.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  {$IFDEF MSWINDOWS}
  Windows, ActnList, ImgList, Graphics,
  {$ENDIF MSWINDOWS}
  {$IFDEF UNIX}
  QActnList, QWindows, QImgList, QGraphics,
  {$ENDIF UNIX}
  Forms, Controls, Classes, JvActionsEngine;

type
  TJvControlActionOperation = (caoCollapse, caoExpand, caoExport, caoOptimizeColumns, caoCustomize, caoPrint,
       caoCustomizeColumns);
  TJvControlActionOperations = set of TJvControlActionOperation;
  TJvControlActionEngine = class(TJvActionBaseEngine)
  protected
    function GetEngineList: TJvActionEngineList; virtual; abstract;
    function GetSupportedOperations: TJvControlActionOperations; virtual; abstract;
    property EngineList: TJvActionEngineList read GetEngineList;
  public
    constructor Create(AOwner: TComponent); override;
    function ExecuteOperation(const aOperation: TJvControlActionOperation; const aActionControl: TControl): Boolean; virtual;
    function SupportsAction(AAction: TJvActionEngineBaseAction): Boolean; override;
    property SupportedOperations: TJvControlActionOperations read GetSupportedOperations;
  end;

  TJvControlActionEngineClass = class of TJvControlActionEngine;
  TJvControlActionEngineList = class(TJvActionEngineList)
  public
    procedure RegisterEngine(AEngineClass: TJvControlActionEngineClass);
  end;

procedure RegisterControlActionEngine(AEngineClass: TJvControlActionEngineClass);

function RegisteredControlActionEngineList: TJvControlActionEngineList;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://vcstest.delphi-jedi.org:4443/svn/pulsar/trunk/jvcl/run/JvControlActionsEngine.pas $';
    Revision: '$Revision: 61 $';
    Date: '$Date: 2011-05-29 04:32:53 +0200 (dim., 29 mai 2011) $';
    LogPath: 'JVCL\run'
    );
{$ENDIF UNITVERSIONING}

implementation

uses
  SysUtils, Grids, TypInfo, StrUtils, Variants,
  Dialogs, StdCtrls, Clipbrd,
  JvControlActions;


var
  IntRegisteredActionEngineList: TJvControlActionEngineList;

procedure RegisterControlActionEngine(AEngineClass: TJvControlActionEngineClass);
begin
  if Assigned(IntRegisteredActionEngineList) then
    IntRegisteredActionEngineList.RegisterEngine(AEngineClass);
end;

function RegisteredControlActionEngineList: TJvControlActionEngineList;
begin
  Result := IntRegisteredActionEngineList;
end;

procedure CreateActionEngineList;
begin
  IntRegisteredActionEngineList := TJvControlActionEngineList.Create;
end;

procedure DestroyActionEngineList;
begin
  IntRegisteredActionEngineList.Free;
  IntRegisteredActionEngineList := nil;
end;

procedure InitActionEngineList;
begin
  CreateActionEngineList;
end;

constructor TJvControlActionEngine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TJvControlActionEngine.ExecuteOperation(const aOperation: TJvControlActionOperation; const aActionControl:
    TControl): Boolean;
begin
  Result := False;
end;

function TJvControlActionEngine.SupportsAction(AAction: TJvActionEngineBaseAction): Boolean;
begin
  Result := (AAction is TJvControlBaseAction) and
    (TJvControlBaseAction(AAction).ControlOperation in SupportedOperations);
end;


procedure TJvControlActionEngineList.RegisterEngine(AEngineClass: TJvControlActionEngineClass);
begin
  Add(AEngineClass.Create(nil));
end;


initialization
  {$IFDEF UNITVERSIONING}
  RegisterUnitVersion(HInstance, UnitVersioning);
  {$ENDIF UNITVERSIONING}
  InitActionEngineList;

finalization
  DestroyActionEngineList;
  {$IFDEF UNITVERSIONING}
  UnregisterUnitVersion(HInstance);
  {$ENDIF UNITVERSIONING}

end.
