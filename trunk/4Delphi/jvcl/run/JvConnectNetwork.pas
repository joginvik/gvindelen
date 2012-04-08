{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvConnectNetwork.PAS, released on 2001-02-28.

The Initial Developer of the Original Code is S�bastien Buysse [sbuysse att buypin dott com]
Portions created by S�bastien Buysse are Copyright (C) 2001 S�bastien Buysse.
All Rights Reserved.

Contributor(s): Michael Beck [mbeck att bigfoot dott com].

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.delphi-jedi.org

Known Issues:
-----------------------------------------------------------------------------}
// $Id: JvConnectNetwork.pas 200 2011-08-16 13:29:27Z obones $

unit JvConnectNetwork;

{$I jvcl.inc}
{$I windowsonly.inc}

interface

uses
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  Windows, Classes,
  JvBaseDlg;

type
  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF RTL230_UP}
  TJvConnectNetwork = class(TJvCommonDialog)
  published
    function Execute: Boolean; override;
  end;

  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF RTL230_UP}
  TJvDisconnectNetwork = class(TJvCommonDialog)
  published
    function Execute: Boolean; override;
  end;

  TJvNetworkConnect = class(TJvCommonDialog)
  private
    FConnect: Boolean;
  published
    property Connect: Boolean read FConnect write FConnect;
    function Execute: Boolean; override;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://vcstest.delphi-jedi.org:4443/svn/pulsar/trunk/jvcl/run/JvConnectNetwork.pas $';
    Revision: '$Revision: 200 $';
    Date: '$Date: 2011-08-16 15:29:27 +0200 (mar., 16 août 2011) $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation


function TJvConnectNetwork.Execute: Boolean;
begin
  Result := WNetConnectionDialog(GetForegroundWindow, RESOURCETYPE_DISK) = NO_ERROR;
end;

function TJvDisconnectNetwork.Execute: Boolean;
begin
  Result := WNetDisconnectDialog(GetForegroundWindow, RESOURCETYPE_DISK) = NO_ERROR;
end;

function TJvNetworkConnect.Execute: Boolean;
begin
  if FConnect then
    Result := WNetConnectionDialog(GetForegroundWindow, RESOURCETYPE_DISK) = NO_ERROR
  else
    Result := WNetDisconnectDialog(GetForegroundWindow, RESOURCETYPE_DISK) = NO_ERROR;
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.
