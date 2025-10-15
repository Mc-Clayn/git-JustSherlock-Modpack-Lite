// © _McClayn, 2020-now JustSherlock Modpack \\

#ifdef IS_ENHANCED
  #if (Pos('ee', IS_Ver_Str) >= 1)
    #define IS_Version_ee
  #endif
#else
  #error Enhanced edition of Inno Setup (restools) is required to compile this script
#endif

// ДОДЕЛАТЬ ВОЗМОЖНОСТЬ ИСПОЛЬЗОВАТЬ МОДПАК ДАЖЕ ЕСЛИ ВЕРСИЯ ИГРЫ БЫЛА 1.28.0.0 А СТАЛА 1.28.0.1 (ЗАМЕНАНА СИМВОЛ '*')
// for Lesta
#define GameVersionLesta "1.38.0"                             ;  1.37.0  1.36.1  1.34  1.33  1.32  1.28  1.22  1.21.1   1.21
#define PatchLesta "1.38.0.0"                                 ;  1.37.0.0  1.36.1.0  1.34.0.0  1.33.0.0  1.32.0.0  1.28.0.0  1.21.1.0  1.16.1.0  1.16.0.0  1.15.0.3  1.15.0.3  1.15.0.2  1.15.0.1   1.15.0.0  1.14.1.4  1.14.1.3  1.14.1.2  1.14.1.1   1.14.1.0  1.12.1.1   1.14.0.1    1.14.0.2    1.14.0.3  1.14.0.4  1.14.0.5                   1.11.0.0
// for WG
#define GameVersionWG "1.27.1"                                ;  1.27.1  1.22  1.21.1   1.21
#define PatchWG "1.27.1.0"                                    ;  1.27.1.0  1.21.1.0  1.16.1.0  1.16.0.0  1.15.0.3  1.15.0.3  1.15.0.2  1.15.0.1   1.15.0.0  1.14.1.4  1.14.1.3  1.14.1.2  1.14.1.1   1.14.1.0  1.12.1.1   1.14.0.1    1.14.0.2    1.14.0.3  1.14.0.4  1.14.0.5                   1.11.0.0

#define GameVersion '[Lesta] '+GameVersionLesta+' | '+'[WG]'+GameVersionWG   ;  1.22  1.21.1   1.21
#define Patch

//#define SPatch "1.10.1.4"
#define CPatch "1.22.0.0"                                    ; dlya rapotosposobnsti ozvuchek

#define Version "1.38.01"                                        ;  2.2.01   2.1.03  2.1.02  2.1.01  2.0  1.0   8.0   7.0  6.0  5.0  4.0  3.0  2.0  1.0  4.0  3.0  2.0  1.0  1.0  2.0  8.0  7.0  6.0  5.0  4.0  3.0  2.0  1.0  2.0


#if FindFirst("mods\updater", faDirectory) == 0
  #define TESTING
#endif

#define Compress
#define CheckForGameFiles
#define CheckForGameRun

#include "defines.iss"
#include "setup.iss"
#include "src\l10n\cm.iss"
#include "src\utils.iss"
#include "src\botva2\botva2.iss"
#include "src\customButtons.iss"
#include "src\xml.iss"
#include "src\idp\idp.iss"                                  ; скачивание новой версии установщика
#include "src\functions.iss"


#include "src\vcl\vcl.iss"                                  ; стиль установщика Windows10Dark

// OpenWGUtils Mixaill XVM
#define OPENWGUTILS_DIR_SRC    "bin"
#define APP_DIR_UNINST  "modpack_utils"
#define OPENWGUTILS_DIR_UNINST APP_DIR_UNINST
#include "utils\openwg.utils.iss"


#include "src\window.iss"                                   ; окно установщика
#include "src\widgets.iss"                                  ; внизу слева установщика иконки с ссылками на сайт
#include "src\paramsRememberer.iss"
#include "src\customPages\welcome.iss"                      ; страница приветствия

#include "src\customPages\selectDir\selectDir.iss"          ; страница выбора папки с игрой
#include "src\configEditor.iss"
#include "src\previewSounds.iss"                            ; предпрослушивание аудио

#include "src\checkListBoxSrc.iss"                          ; preview images pos
#include "src\customPages\itemsMain.iss"                    ; основные модификации
#include "src\customPages\itemsPricels.iss"                 ; прицелы
//#include "src\customPages\itemsHangar.iss"                  ; ангарные моды
#include "src\customPages\itemsVoiceover.iss"               ; озвучки экипажа
//#include "src\customPages\itemsBattle.iss"                  ; боевой интерфейс
//#include "src\customPages\itemsPMOD.iss"                    ; пмод
//#include "src\customPages\itemsXVM.iss"                     ; хвм
//
#include "src\customPages\itemsTweaker.iss"
//

//
#include "src\customPages\ready\ready.iss"                  ;
#include "src\customPages\preparing.iss"
#include "src\customPages\installing.iss"

#include "src\customPages\finished.iss"
#include "src\folderOperations.iss"


[Files]
Source: "files\console\*"; DestDir: "{app}\{#AppFullName}"; Flags: ignoreversion;
// cursor
Source: "files\wot_cursor\wot_kden_arrow.cur"; Flags: dontcopy noencryption;
// font
Source: "files\Russo_One.ttf"; Flags: dontcopy noencryption;
Source: "files\Warhelios-Bold_Web.ttf"; Flags: dontcopy noencryption;
// reklama     Splash.png
// files\JshMp.png;
//Source: "files\JshMp.png"; Flags: dontcopy noencryption nocompression;
//Source: "files\JshMp_en.png"; Flags: dontcopy noencryption nocompression;
// dll for reklama
Source: "src\isgsg.dll"; Flags: dontcopy noencryption nocompression;


[InstallDelete]
Type: filesandordirs; Name: "{app}\{#AppFullName}";
Type: filesandordirs; Name: "{app}\{#OPENWGUTILS_DIR_UNINST}";
Type: filesandordirs; Name: "{app}\win32\Reports_XFW";
Type: filesandordirs; Name: "{app}\replays\replays_manager";
//
Type: files; Name: "{app}\*.log";

[UninstallDelete]
Type: filesandordirs; Name: "{app}\{#AppFullName}";
Type: filesandordirs; Name: "{app}\{#OPENWGUTILS_DIR_UNINST}";

Type: files; Name: "{app}\*.log";
Type: filesandordirs; Name: "{app}\win32\Reports_XFW";
Type: filesandordirs; Name: "{app}\mods\temp";
Type: filesandordirs; Name: "{app}\mods\configs";
Type: filesandordirs; Name: "{app}\mods\{code:ggPatch}\com.modxvm.xfw";
Type: filesandordirs; Name: "{app}\res_mods\mods\{code:ggPatch}";
Type: filesandordirs; Name: "{app}\res_mods\configs";
Type: filesandordirs; Name: "{app}\res_mods\{code:ggPatch}\audioww";
Type: filesandordirs; Name: "{app}\res_mods\{code:ggPatch}\scripts";
Type: filesandordirs; Name: "{app}\replays\replays_manager";

[Run]
// просмотр вебсайта по галочке в конце установки
//Filename: {#URL_Tankimods}; Description: "{cm:open_website}"; Verb: "open"; Flags: postinstall nowait shellexec;



[Code]

// удалить кнопки свернуть, развернуть из окна инсталлятора
const
  GWL_STYLE = -16;

  WS_MINIMIZEBOX = $20000;
  WS_MAXIMIZEBOX = $10000;

//function SetWindowLong(Wnd: HWnd; Index: Integer; NewLong: Longint): Longint; external 'SetWindowLongA@user32.dll stdcall';  // duplicate
//function GetWindowLong(hWnd: HWND; nIndex: Integer): Longint; external 'GetWindowLongA@user32.dll stdcall';  // duplicate
//

const
FR_PRIVATE = $10;

function AddFontResource(lpszFilename: String; fl, pdv: DWORD): Integer; external 'AddFontResourceEx{#A}@gdi32.dll stdcall';
function RemoveFontResource(lpFilename: String; fl, pdv: DWORD): BOOL; external 'RemoveFontResourceEx{#A}@gdi32.dll stdcall';

// cursor
#ifdef IS_Version_ee
function LoadCursorFromFile(FileName: String): Cardinal; external 'LoadCursorFromFile{#A}@user32 stdcall';
function DeleteObject(p1: Longword): BOOL; external 'DeleteObject@gdi32.dll stdcall';

const
  MyCursor = 101;
#endif

const
  RT_RCDATA = 10;
var
  hcur: Cardinal;



function InitializeLanguageDialog(): Boolean;
begin

  #ifdef VCL
  InitializeVCL();
  #endif

  //ExtractTemporaryFile('button_prev.bmp');

  with SelectLanguageForm do
  begin
    ClientHeight := ScaleY(110);
    ClientWidth := SelectLabel.Width + ScaleX(20);
    SelectLabel.Left := ScaleX(10);
    LangCombo.SetBounds(SelectLabel.Left, SelectLabel.Top + SelectLabel.Height, SelectLabel.Width, LangCombo.Height);
    LangCombo.OnChange := @LangChange;
    OKButton.SetBounds(SelectLabel.Left, LangCombo.Top + LangCombo.Height + ScaleY(5), ScaleX(110), OKButton.Height);
    CancelButton.SetBounds(LangCombo.Width - OKButton.Width + ScaleX(10), OKButton.Top, ScaleX(110), CancelButton.Height);

    // not worked
    //HOKButtonLang := EffectTextureButton(SelectLanguageForm.Handle, SelectLanguageForm.OKButton, ExpandConstant('{tmp}\button_prev.bmp'), 0, nil, nil, nil);
    //HCancelButtonLang := EffectTextureButton(SelectLanguageForm.Handle, SelectLanguageForm.CancelButton, ExpandConstant('{tmp}\button_prev.bmp'), 0, nil, nil, nil);

    IconBitmapImage.Hide;
  end;

  Result := True;
end;



Function InitializeSetup(): Boolean;
begin

 if ActiveLanguage() = 'en' then
  MsgBoxEx(0, CustomMessage('languageIsNotFullySupports'), SetupMessage(msgInformationTitle), MB_ICONINFORMATION or MB_OK, 0, 0);

 Result := True;
  #ifdef VCL
 InitializeVCL();
 #endif
 // set filter
  WOT_LauncherSetDefault(2, 2);
 // cursor
 //if not FileExists(ExpandConstant('{tmp}\wot_kden_arrow.cur')) then ExtractTemporaryFile('wot_kden_arrow.cur');
 Result := True;
end;

Procedure InitializeWizard();
var
  ResStream: TResourceStream;
begin

  // удалить кнопки свернуть, развернуть из окна инсталлятора
  SetWindowLong(WizardForm.handle, GWL_STYLE, GetWindowLong(WizardForm.handle, GWL_STYLE)and(not WS_MINIMIZEBOX)and(not WS_MAXIMIZEBOX));

  //                                          //  _IS_MYCURSOR
  #ifdef IS_Version_ee
  ResStream := TResourceStream.Create(HInstance, '_IS_MYCURSOR', RT_RCDATA);
  try
    ResStream.SaveToFile(ExpandConstant('{tmp}\wot_kden_arrow.cur'));
    hcur := LoadCursorFromFile(ExpandConstant('{tmp}\wot_kden_arrow.cur'));
    Screen.Cursors[MyCursor] := hcur;
  finally
    ResStream.Free;
  end;
  #endif

  #ifdef IS_Version_ee
    WizardForm.Cursor := MyCursor;;
  #endif


  // texture for custom buttons
  ExtractTemporaryFile('button_next.bmp');
  ExtractTemporaryFile('button_prev.bmp');


  // font russo one
  if FontExists('Russo One') then
  begin
    ExtractTemporaryFile('Russo_One.ttf');
    AddFontResource(ExpandConstant('{tmp}\Russo_One.ttf'), FR_PRIVATE, 0);
  end;
  // font Warhelios-Bold_Web
  if FontExists('Warhelios-Bold_Web') then
  begin
    ExtractTemporaryFile('Warhelios-Bold_Web.ttf');
    AddFontResource(ExpandConstant('{tmp}\Warhelios-Bold_Web.ttf'), FR_PRIVATE, 0);
  end;
  WizardForm.Font.Name := 'Warhelios-Bold_Web';


 if not CMDCheckParams(CMD_NoCheckForMutex) then
  CreateMutex('{#AppMutex}');
 InitializeWindow();
 InitializeWidgets();
 InitializeWelcomePage();
  #ifdef Updater
 //InitializeUpdaterPage();
 #endif
 InitializeSelectDirPage();
 InitializeComponentsInfo();

 // loading page with mods
 InitializeComponentsPageMain();
 InitializeComponentsPagePricels();
 //InitializeComponentsPageHangar();
 InitializeSounds();
 InitializeComponentsPageVoiceover();
 //InitializeComponentsPagePMOD();
 //InitializeComponentsPageXVM();
 // end loading modspage
 //
 InitializeComponentsPageTweaker();
 //
////////////////////////////////////////////////////////////////
 //
 InitializeReadyPage();
 InitializeInstallingPage();
 InitializeFinishedPage();

  // splash screen
  Splash();

  checkUpdates();

end;

Function ShouldSkipPage(CurPageID: Integer): Boolean;
begin
 Result := False;
 case CurPageID of
  wpSelectDir: Result := SelectDirShouldSkipPage();
  wpPreparing: Result := PreparingShouldSkipPage();
 end;
end;

Procedure CurPageChanged(CurPageID: Integer);
begin
 // for custom buttons
 UpdateButtons();

 case CurPageID of
  wpInstalling: ShowInstallingPage();
 end;
 ImgApplyChanges(WizardForm.Handle);
end;

Procedure CurStepChanged(CurStep: TSetupStep);
begin
 ClientFolderOperations(CurStep);
  //#ifndef TESTING
 StartConfigurator(CurStep);
 //#endif
 RememberComponentMainItems(CurStep);
 RememberComponentPricelsItems(CurStep);
 //RememberComponentHangarItems(CurStep);
 RememberComponentVoiceoverItems(CurStep);
 //RememberComponentPMODItems(CurStep);
 //RememberComponentXVMItems(CurStep);
 //
 RememberComponentTweakerItems(CurStep);
 SaveReadyMemoToLog(CurStep);
end;

Procedure DeinitializeSetup();
begin
 LaunchGame();


 gdipShutdown();
  #ifdef VCL
 UnLoadVCLStyles();
 #endif
 DelTree(ExpandConstant('{tmp}'), True, True, True);
 // cursor
 #ifdef IS_Version_ee
 DeleteObject(hcur);
 #endif
end;

Function InitializeUninstall(): Boolean;
begin
  Result := True;
  LoadVCLStyle_UnInstall(ExpandConstant('{#VCLStylesSkinPath}\{#VCL}.vsf'));

  #ifdef CheckForGameRun
    Result := CheckForGameRun(0);
  #endif
end;

Procedure DeinitializeUninstall();
begin
  UnLoadVCLStyles_UnInstall;
end;

procedure CurUninstallStepChanged_usUninstall();
begin
  OPENWG_DllUnload();
  OPENWG_DllDelete();
end;


Procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  RestoreDirectories(CurUninstallStep);
  // deinstall openwg_utils
  case CurUninstallStep of
    usUninstall: CurUninstallStepChanged_usUninstall();
  end
end;
