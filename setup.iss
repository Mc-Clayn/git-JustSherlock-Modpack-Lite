// © _McClayn, 2020-now LITE justsherlock \\

[Setup]
AppId={{{#AppID}}
// {696D8295-1B09-4156-A7D1-BA71B6192B99
AppMutex={#AppMutex}
AppName={#AppFullName} ({#Version})
// {#AppFullName} ({#Version})
AppVersion={#Version}
// {#GameShortName} ({code:ggPatch})
// sgGameName(ggPatch,'short' {#GameShortName}
AppPublisher={#Author}

//====={ Ссылки }=====\\
AppPublisherURL={#URL_Tankimods}
AppSupportURL={#URL_Tankimods}
AppUpdatesURL={#URL_Tankimods}

//====={ Папка устанвки }=====\\
DefaultDirName={pf}\Tanki
AppendDefaultDirName=no
DirExistsWarning=no
DefaultGroupName={#AppFullName} (v{#Version})

DisableWelcomePage=yes
DisableProgramGroupPage=yes
DisableDirPage=yes
DisableReadyPage=yes
DisableFinishedPage=yes

//====={ Папка создания и название сетапа }=====\\
OutputDir=release

OutPutBaseFilename=modpack_justsherlock_lite

// cursor
RawDataResource=MyCursor:files\wot_cursor\wot_kden_arrow.cur

//====={ Картинки }=====\\
//SetupIconFile=files\faviconn.ico
SetupIconFile=files\logo-lesta.ico

AppComments={#Author}
VersionInfoVersion={#Version}
VersionInfoTextVersion={#Version}   
VersionInfoDescription={#AppFullName} for {#GameFullName}
AppCopyright=© {#Author} 2025
UninstallLogMode=new
UninstallDisplayIcon={app}\{#AppFullName}\unins000.exe
//{app}\{#AppFullName}\Uninstall\unins000.exe
UninstallFilesDir={app}\{#AppFullName}
//{app}\{#AppFullName}\Uninstall
UninstallDisplayName={#AppFullName} ({#Version})
UsePreviousSetupType=no
UsePreviousAppDir=yes
PrivilegesRequired=poweruser
 #ifdef Compress
//====={ Сжатие сетапа }=====\\  
Compression=lzma2

SolidCompression=no

#endif

[Languages]
Name: "en"; MessagesFile: "src\l10n\setup_en.isl";
Name: "ru"; MessagesFile: "src\l10n\setup_ru.isl";
