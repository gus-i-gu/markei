; Markei primary beta installer.
; Stable AppId: do not regenerate across compatible upgrades.

#define MyAppName "Markei"
#define MyAppVersion "0.1.0"
#define MyAppPublisher "Markei"
#define MyAppExeName "Markei.exe"
#define MyAppId "{{9F5F5C2A-43EA-4CF0-9C25-FF9E7BB57D3A}"

[Setup]
AppId={#MyAppId}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={localappdata}\Programs\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
OutputDir=..\dist\installer
OutputBaseFilename=Markei-Setup-{#MyAppVersion}-x64
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
PrivilegesRequired=lowest
Compression=lzma
SolidCompression=yes
WizardStyle=modern
UninstallDisplayName={#MyAppName}
UninstallDisplayIcon={app}\{#MyAppExeName}

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional shortcuts:"; Flags: unchecked

[Files]
Source: "..\dist\Markei\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "seed.sql,market.sqlite,*.sqlite-wal,*.sqlite-shm,*.log,__pycache__,*.pyc,tests"

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Launch {#MyAppName}"; Flags: nowait postinstall skipifsilent
