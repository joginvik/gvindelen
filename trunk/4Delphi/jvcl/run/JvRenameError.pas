{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvRenameError.PAS, released on 2001-02-28.

The Initial Developer of the Original Code is S�bastien Buysse [sbuysse att buypin dott com]
Portions created by S�bastien Buysse are Copyright (C) 2001 S�bastien Buysse.
All Rights Reserved.

Contributor(s): Michael Beck [mbeck att bigfoot dott com].

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.delphi-jedi.org

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvRenameError.pas 197 2011-08-16 12:59:53Z obones $

unit JvRenameError;

{$I jvcl.inc}
{$I windowsonly.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Windows, SysUtils, Classes,
  JvCommonDialogD, JvTypes;

type
  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF RTL230_UP}
  TJvRenameError = class(TJvCommonDialogD)
  private
    FWin32ErrorCode: Integer;
    FStyle: TJvDeleteStyles;
    FDestFile: string;
    FSourceFile: string;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property SourceFile: string read FSourceFile write FSourceFile;
    property DestFile: string read FDestFile write FDestFile;
    property Win32ErrorCode: Integer read FWin32ErrorCode write FWin32ErrorCode default 0;
    property Style: TJvDeleteStyles read FStyle write FStyle default [];
    function Execute: TJvDiskRes; override;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://vcstest.delphi-jedi.org:4443/svn/pulsar/trunk/jvcl/run/JvRenameError.pas $';
    Revision: '$Revision: 197 $';
    Date: '$Date: 2011-08-16 14:59:53 +0200 (mar., 16 août 2011) $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

uses
  SetupApi,
  JclSysUtils;

constructor TJvRenameError.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FStyle := [];
  FWin32ErrorCode := 0;
  FDestFile := '';
  FSourceFile := '';
end;

function TJvRenameError.Execute: TJvDiskRes;
var
  Sty: DWORD;
begin
  Sty := 0;
  if idNoBeep in Style then
    Sty := Sty or IDF_NOBEEP;
  if idNoForeground in Style then
    Sty := Sty or IDF_NOFOREGROUND;

  case SetupRenameError(OwnerWindow, PCharOrNil(Title), PChar(FSourceFile),
    PChar(FDestFile), FWin32ErrorCode, Sty) of
    DPROMPT_SUCCESS:
      Result := dsSuccess;
    DPROMPT_CANCEL:
      Result := dsCancel;
    DPROMPT_SKIPFILE:
      Result := dsSkipfile;
  else
    Result := dsError;
  end;
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.
