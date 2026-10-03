; Flutter installer. This AppId is distinct from the legacy Python application.
; Keep it stable for all compatible Flutter upgrades.
#ifndef ReleaseDir
  #error ReleaseDir must point to a complete Flutter Windows release bundle.
#endif
#ifndef OutputPath
  #error OutputPath is required.
#endif
#ifndef AppVersion
  #error AppVersion is required.
#endif
#ifndef BuildNumber
  #error BuildNumber is required.
#endif
#ifndef VCRuntimeDir
  #error VCRuntimeDir is required.
#endif

[Setup]
AppId={{EB8DD373-1439-4980-9EB4-10552B31C774}
AppName=Marc
AppVersion={#AppVersion}
AppPublisher=Marc
VersionInfoVersion={#AppVersion}.{#BuildNumber}
DefaultDirName={localappdata}\Programs\Markei Flutter
DefaultGroupName=Markei Flutter
DisableProgramGroupPage=yes
OutputDir={#OutputPath}
OutputBaseFilename=Markei-Flutter-Setup-{#AppVersion}-{#BuildNumber}-x64
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
MinVersion=10.0
PrivilegesRequired=lowest
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
SetupIconFile=..\clients\markei_flutter\windows\runner\resources\app_icon.ico
UninstallDisplayName=Marc
UninstallDisplayIcon={app}\markei.exe
CloseApplications=yes
RestartApplications=no
SetupMutex=MarkeiFlutterSetup

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional shortcuts:"; Flags: unchecked

[Files]
Source: "{#ReleaseDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pdb,*.log,*.sqlite,*.sqlite-wal,*.sqlite-shm"
Source: "{#VCRuntimeDir}\*.dll"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\Marc"; Filename: "{app}\markei.exe"
Name: "{autodesktop}\Marc"; Filename: "{app}\markei.exe"; Tasks: desktopicon

[Registry]
Root: HKCU; Subkey: "Software\Classes\auth0flutter"; ValueType: string; ValueName: ""; ValueData: "URL:Marc sign-in"
Root: HKCU; Subkey: "Software\Classes\auth0flutter"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""
Root: HKCU; Subkey: "Software\Classes\auth0flutter\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\markei.exe"" ""%1"""

[Run]
Filename: "{app}\markei.exe"; Description: "Launch Marc"; Flags: nowait postinstall skipifsilent

[Code]
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  Command: String;
begin
  if CurUninstallStep = usUninstall then
  begin
    if RegQueryStringValue(HKCU, 'Software\Classes\auth0flutter\shell\open\command', '', Command) then
      if CompareText(Command, '"' + ExpandConstant('{app}\markei.exe') + '" "%1"') = 0 then
        RegDeleteKeyIncludingSubkeys(HKCU, 'Software\Classes\auth0flutter');
  end;
end;
