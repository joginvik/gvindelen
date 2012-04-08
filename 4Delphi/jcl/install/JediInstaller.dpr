{**************************************************************************************************}
{                                                                                                  }
{ Last modified: $Date:: 2010-10-20 21:02:31 +0200 (mer., 20 oct. 2010)                          $ }
{ Revision:      $Rev:: 3379                                                                     $ }
{ Author:        $Author:: outchy                                                                $ }
{                                                                                                  }
{**************************************************************************************************}

program JediInstaller;

{$I jcl.inc}

uses
  Forms,
  JclInstall in 'JclInstall.pas',
  JediInstall in 'JediInstall.pas',
  JediInstallConfigIni in 'JediInstallConfigIni.pas',
  JclIDEUtils in '..\source\common\JclIDEUtils.pas',
  JclResources in '..\source\common\JclResources.pas',
  JediRegInfo in 'JediRegInfo.pas',
  JclDotNet in '..\source\windows\JclDotNet.pas',
  FrmCompile in 'VclGui\FrmCompile.pas' {FormCompile},
  JediGUIText in 'VclGui\JediGUIText.pas' {TextFrame: TFrame},
  JediGUIInstall in 'VclGui\JediGUIInstall.pas' {InstallFrame: TFrame},
  JediGUIMain in 'VclGui\JediGUIMain.pas' {MainForm},
  JediGUIProfiles in 'VclGui\JediGUIProfiles.pas' {ProfilesFrame: TFrame},
  JediProfiles in 'JediProfiles.pas',
  JclInstallResources in 'JclInstallResources.pas',
  JediInstallResources in 'JediInstallResources.pas';

{$R *.res}
{$R ..\source\windows\JclCommCtrlAsInvoker.res}

begin
  Application.Initialize;
  Application.Title := 'JEDI Installer';
  InstallCore.Execute;
end.
