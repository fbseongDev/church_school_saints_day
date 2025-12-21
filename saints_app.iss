#define MyAppName "2025-Saint"
#define MyAppVersion "1.0.0"
#define MyAppExeName "2025-Saint.exe"

[Setup]
AppId={{F7C2B2E3-ABCD-4A1B-9E99-123456789ABC}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher=MyFlutterApp
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
OutputBaseFilename={#MyAppName}_Setup
OutputDir=output
Compression=lzma
SolidCompression=yes
WizardStyle=modern
DisableProgramGroupPage=yes
PrivilegesRequired=admin

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
; Flutter Windows Release 전체를 복사해야 함
Source: "build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: recursesubdirs ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Launch {#MyAppName}"; Flags: nowait postinstall skipifsilent