// ModPack Lite


// This file is part of the Findwot project.
//
// Copyright (c) 2016-2017 Findwot contributors.
//
// Findwot is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as
// published by the Free Software Foundation, version 3.
//
// Findwot is distributed in the hope that it will be useful, but
// WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
// Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.


// This code _McClayn Edit with open_wg_utils


// default buffer size for path, should be between 250 .. 32767
#ifndef OPENWGUTILS_BUF_SIZE
#define OPENWGUTILS_BUF_SIZE 1024
#endif


[Files]
Source: "src\customPages\selectDir\findwot.dll"; Flags: dontcopy;
// FROM open_wg_utils
Source: "{#OPENWGUTILS_DIR_SRC}\openwg.utils.x86_32.dll"; DestName: openwg.utils.dll; Flags: ignoreversion dontcopy noencryption;
Source: "{#OPENWGUTILS_DIR_SRC}\openwg.utils.x86_32.dll"; DestDir: {app}\{#OPENWGUTILS_DIR_UNINST}; DestName: openwg.utils.dll; Flags: ignoreversion noencryption;

[Custom Messages]
en.openwg_unknown=Unknown
ru.openwg_unknown=Неизвестно
en.openwg_client_not_found=The game client was not detected in the specified folder.
ru.openwg_client_not_found=В указанной папке клиент игры не был обнаружен.
en.openwg_branch_release=Release
ru.openwg_branch_release=Релиз
en.openwg_branch_ct=Common Test
ru.openwg_branch_ct=Общий тест
en.openwg_branch_st=Super Test
ru.openwg_branch_st=Супертест
en.openwg_branch_sb=Sandbox
ru.openwg_branch_sb=Песочница


[Code]

//
// Typedefs
//

type
  ClientRecord = Record
    Index: Integer;
    Branch: Integer;
    LauncherFlavour: Integer;
    Locale: String;
    Path: String;
    PathMods: String;
    PathResmods: String;
    Realm: String;
    ContentType: Integer;
    Version: String;
    VersionExe: String;
  end;


// start of Wargaming GameCenter
Procedure WGC_GetInstallPathW(Buffer: String; BufferSize: Integer);
external 'WGC_GetInstallPathW@files:findwot.dll cdecl';

Function WGC_IsInstalled(): Boolean;
external 'WGC_IsInstalled@files:findwot.dll cdecl';
// end of Wargaming GameCenter

// WOT/AddClientW
function WOT_AddClientW_I(ClientPath: String): Integer;
external 'WOT_AddClientW@files:openwg.utils.dll cdecl setuponly';

function WOT_AddClientW_U(ClientPath: String): Integer;
external 'WOT_AddClientW@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_AddClientW(ClientPath: String): Integer;
begin
    if IsUninstaller() then
        Result := WOT_AddClientW_U(ClientPath)
    else
        Result := WOT_AddClientW_I(ClientPath)
end;

// WOT/LauncherGetPreferredClient
function WOT_LauncherGetPreferredClient_I(LauncherFlavour: Integer): Integer;
external 'WOT_LauncherGetPreferredClient@files:openwg.utils.dll cdecl setuponly';

function WOT_LauncherGetPreferredClient_U(LauncherFlavour: Integer): Integer;
external 'WOT_LauncherGetPreferredClient@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_LauncherGetPreferredClient(LauncherFlavour: Integer): Integer;
begin
    if IsUninstaller() then
        Result := WOT_LauncherGetPreferredClient_U(LauncherFlavour)
    else
        Result := WOT_LauncherGetPreferredClient_I(LauncherFlavour)
end;

// WOT/LauncherRescan
function WOT_LauncherRescan_I(): Integer;
external 'WOT_LauncherRescan@files:openwg.utils.dll cdecl setuponly';

function WOT_LauncherRescan_U(): Integer;
external 'WOT_LauncherRescan@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_LauncherRescan(): Integer;
begin
    if IsUninstaller() then
        Result := WOT_LauncherRescan_U()
    else
        Result := WOT_LauncherRescan_I()
end;


// WOT/LauncherSetDefault
function WOT_LauncherSetDefault_I(LauncherFlavour: Integer): Integer;
external 'WOT_LauncherSetDefault@files:openwg.utils.dll cdecl setuponly';

function WOT_LauncherSetDefault_U(LauncherFlavour: Integer): Integer;
external 'WOT_LauncherSetDefault@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_LauncherSetDefault(LauncherFlavour: Integer): Integer;
begin
    if IsUninstaller() then
        Result := WOT_LauncherSetDefault_U(LauncherFlavour)
    else
        Result := WOT_LauncherSetDefault_I(LauncherFlavour)
end;


// WOT/ClientFind
function WOT_ClientFind_I(Path: String): Integer;
external 'WOT_ClientFind@files:openwg.utils.dll cdecl setuponly';

function WOT_ClientFind_U(Path: String): Integer;
external 'WOT_ClientFind@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_ClientFind(Path: String): Integer;
begin
    if IsUninstaller() then
        Result := WOT_ClientFind_U(Path)
    else
        Result := WOT_ClientFind_I(Path)
end;


// WOT/ClientIsStarted
function WOT_ClientIsStarted_I(ClientIndex: Integer): Integer;
external 'WOT_ClientIsStarted@files:openwg.utils.dll cdecl setuponly';

function WOT_ClientIsStarted_U(ClientIndex: Integer): Integer;
external 'WOT_ClientIsStarted@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_ClientIsStarted(ClientIndex: Integer): Boolean;
begin
    if IsUninstaller() then
        Result := WOT_ClientIsStarted_U(ClientIndex) = 1
    else
        Result := WOT_ClientIsStarted_I(ClientIndex) = 1
end;


// WOT/ClientIsVersionMatch
function WOT_ClientIsVersionMatch_I(ClientIndex: Integer; VersionPattern: String): Integer;
external 'WOT_ClientIsVersionMatch@files:openwg.utils.dll cdecl setuponly';

function WOT_ClientIsVersionMatch_U(ClientIndex: Integer; VersionPattern: String): Integer;
external 'WOT_ClientIsVersionMatch@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_ClientIsVersionMatch(ClientIndex: Integer; VersionPattern: String): Boolean;
begin
    if IsUninstaller() then
        Result := WOT_ClientIsVersionMatch_U(ClientIndex, VersionPattern) = 1
    else
        Result := WOT_ClientIsVersionMatch_I(ClientIndex, VersionPattern) = 1
end;


// WOT/ClientTerminate
function WOT_ClientTerminate_I(ClientIndex: Integer): Integer;
external 'WOT_ClientTerminate@files:openwg.utils.dll cdecl setuponly';

function WOT_ClientTerminate_U(ClientIndex: Integer): Integer;
external 'WOT_ClientTerminate@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_ClientTerminate(ClientIndex: Integer): Boolean;
begin
    if IsUninstaller() then
        Result := WOT_ClientTerminate_U(ClientIndex) = 1
    else
        Result := WOT_ClientTerminate_I(ClientIndex) = 1
end;


// WOT/GetClientsCount
function WOT_GetClientsCount_I(): Integer;
external 'WOT_GetClientsCount@files:openwg.utils.dll cdecl setuponly';

function WOT_GetClientsCount_U(): Integer;
external 'WOT_GetClientsCount@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_GetClientsCount(): Integer;
begin
    if IsUninstaller() then
        Result := WOT_GetClientsCount_U()
    else
        Result := WOT_GetClientsCount_I()
end;


// WOT/GetClientBranch
function WOT_GetClientBranch_I(ClientIndex: Integer): Integer;
external 'WOT_GetClientBranch@files:openwg.utils.dll cdecl setuponly';

function WOT_GetClientBranch_U(ClientIndex: Integer): Integer;
external 'WOT_GetClientBranch@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_GetClientBranch(ClientIndex: Integer): Integer;
begin
    if IsUninstaller() then
        Result := WOT_GetClientBranch_U(ClientIndex)
    else
        Result := WOT_GetClientBranch_I(ClientIndex)
end;


// WOT/GetClientLauncherFlavour
function WOT_GetClientLauncherFlavour_I(ClientIndex: Integer): Integer;
external 'WOT_GetClientLauncherFlavour@files:openwg.utils.dll cdecl setuponly';

function WOT_GetClientLauncherFlavour_U(ClientIndex: Integer): Integer;
external 'WOT_GetClientLauncherFlavour@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_GetClientLauncherFlavour(ClientIndex: Integer): Integer;
begin
    if IsUninstaller() then
        Result := WOT_GetClientLauncherFlavour_U(ClientIndex)
    else
        Result := WOT_GetClientLauncherFlavour_I(ClientIndex)
end;


// WOT/GetClientLocale
procedure WOT_GetClientLocaleW_I(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientLocaleW@files:openwg.utils.dll cdecl setuponly';

procedure WOT_GetClientLocaleW_U(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientLocaleW@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_GetClientLocaleW(ClientIndex: Integer): String;
var
    Buffer: String;
begin
    SetLength(Buffer, {#OPENWGUTILS_BUF_SIZE});

    if IsUninstaller() then
        WOT_GetClientLocaleW_U(Buffer, {#OPENWGUTILS_BUF_SIZE}, ClientIndex)
    else
        WOT_GetClientLocaleW_I(Buffer, {#OPENWGUTILS_BUF_SIZE}, ClientIndex);

    Result := Copy(Buffer, 1, Pos(#0, Buffer)-1);
end;


// WOT/GetClientPathW
procedure WOT_GetClientPathW_I(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientPathW@files:openwg.utils.dll cdecl setuponly';

procedure WOT_GetClientPathW_U(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientPathW@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_GetClientPathW(ClientIndex: Integer): String;
var
    Buffer: String;
begin
    SetLength(Buffer, {#OPENWGUTILS_BUF_SIZE});

    if IsUninstaller() then
        WOT_GetClientPathW_U(Buffer, {#OPENWGUTILS_BUF_SIZE}, ClientIndex)
    else
        WOT_GetClientPathW_I(Buffer, {#OPENWGUTILS_BUF_SIZE}, ClientIndex);

    Result := Copy(Buffer, 1, Pos(#0, Buffer)-1);
end;


// WOT/GetClientPathModsW
procedure WOT_GetClientPathModsW_I(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientPathModsW@files:openwg.utils.dll cdecl setuponly';

procedure WOT_GetClientPathModsW_U(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientPathModsW@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_GetClientPathModsW(ClientIndex: Integer): String;
var
    Buffer: String;
begin
    SetLength(Buffer, {#OPENWGUTILS_BUF_SIZE});

    if IsUninstaller() then
        WOT_GetClientPathModsW_U(Buffer, {#OPENWGUTILS_BUF_SIZE}, ClientIndex)
    else
        WOT_GetClientPathModsW_I(Buffer, {#OPENWGUTILS_BUF_SIZE}, ClientIndex);

    Result := Copy(Buffer, 1, Pos(#0, Buffer)-1);
end;


// WOT/GetClientPathResmodsW
procedure WOT_GetClientPathResmodsW_I(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientPathResmodsW@files:openwg.utils.dll cdecl setuponly';

procedure WOT_GetClientPathResmodsW_U(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientPathResmodsW@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_GetClientPathResmodsW(ClientIndex: Integer): String;
var
    Buffer: String;
begin
    SetLength(Buffer, {#OPENWGUTILS_BUF_SIZE});

    if IsUninstaller() then
        WOT_GetClientPathResmodsW_U(Buffer, {#OPENWGUTILS_BUF_SIZE}, ClientIndex)
    else
        WOT_GetClientPathResmodsW_I(Buffer, {#OPENWGUTILS_BUF_SIZE}, ClientIndex);

    Result := Copy(Buffer, 1, Pos(#0, Buffer)-1);
end;


// WOT/GetClientRealmW
procedure WOT_GetClientRealmW_I(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientRealmW@files:openwg.utils.dll cdecl setuponly';

procedure WOT_GetClientRealmW_U(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientRealmW@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_GetClientRealmW(ClientIndex: Integer): String;
var
    Buffer: String;
begin
    SetLength(Buffer, {#OPENWGUTILS_BUF_SIZE});

    if IsUninstaller() then
        WOT_GetClientRealmW_U(Buffer, {#OPENWGUTILS_BUF_SIZE}, ClientIndex)
    else
        WOT_GetClientRealmW_I(Buffer, {#OPENWGUTILS_BUF_SIZE}, ClientIndex);

    Result := Copy(Buffer, 1, Pos(#0, Buffer)-1);
end;


// WOT/GetClientType
function WOT_GetClientType_I(ClientIndex: Integer): Integer;
external 'WOT_GetClientType@files:openwg.utils.dll cdecl setuponly';

function WOT_GetClientType_U(ClientIndex: Integer): Integer;
external 'WOT_GetClientType@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_GetClientType(ClientIndex: Integer): Integer;
begin
    if IsUninstaller() then
        Result := WOT_GetClientType_U(ClientIndex)
    else
        Result := WOT_GetClientType_I(ClientIndex)
end;


// WOT/GetClientVersionW
procedure WOT_GetClientVersionW_I(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientVersionW@files:openwg.utils.dll cdecl setuponly';

procedure WOT_GetClientVersionW_U(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientVersionW@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_GetClientVersionW(ClientIndex: Integer): String;
var
    Buffer: String;
begin
    SetLength(Buffer, {#OPENWGUTILS_BUF_SIZE});

    if IsUninstaller() then
        WOT_GetClientVersionW_U(Buffer, {#OPENWGUTILS_BUF_SIZE}, ClientIndex)
    else
        WOT_GetClientVersionW_I(Buffer, {#OPENWGUTILS_BUF_SIZE}, ClientIndex);

    Result := Copy(Buffer, 1, Pos(#0, Buffer)-1);
end;


// WOT/GetClientExeVersionW
procedure WOT_GetClientExeVersionW_I(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientExeVersionW@files:openwg.utils.dll cdecl setuponly';

procedure WOT_GetClientExeVersionW_U(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientExeVersionW@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_GetClientExeVersionW(ClientIndex: Integer): String;
var
    Buffer: String;
begin
    SetLength(Buffer, {#OPENWGUTILS_BUF_SIZE});

    if IsUninstaller() then
        WOT_GetClientExeVersionW_U(Buffer, {#OPENWGUTILS_BUF_SIZE}, ClientIndex)
    else
        WOT_GetClientExeVersionW_I(Buffer, {#OPENWGUTILS_BUF_SIZE}, ClientIndex);

    Result := Copy(Buffer, 1, Pos(#0, Buffer)-1);
end;


procedure OPENWG_DllDelete();
begin
    if IsUninstaller() then
    begin
        DeleteFile(ExpandConstant('{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll'));
        RemoveDir(ExpandConstant('{app}\{#OPENWGUTILS_DIR_UNINST}'));
    end
    else begin
        DeleteFile(ExpandConstant('{tmp}\openwg.utils.dll'));
        RemoveDir(ExpandConstant('{tmp}'));
    end;
end;


procedure OPENWG_DllUnload();
begin
    if IsUninstaller() then
        UnloadDLL(ExpandConstant('{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll'))
    else
        UnloadDLL(ExpandConstant('{tmp}\openwg.utils.dll'));
end;



// this functions from openwg_utils
function CLIENT_GetRecord(Index: Integer): ClientRecord;
begin
  Result.Index := Index;
  Result.Branch := WOT_GetClientBranch(Index);
  Result.LauncherFlavour := WOT_GetClientLauncherFlavour(Index);
  Result.Locale :=  WOT_GetClientLocaleW(Index);
  Result.Path := WOT_GetClientPathW(Index);
  Result.PathMods :=  WOT_GetClientPathModsW(Index);
  Result.PathResmods := WOT_GetClientPathResmodsW(Index);
  Result.Realm :=  WOT_GetClientRealmW(Index);
  Result.ContentType := WOT_GetClientType(Index);
  Result.Version := WOT_GetClientVersionW(Index);
  Result.VersionExe := WOT_GetClientExeVersionW(Index);
end;


function CLIENT_FormatString(Client: ClientRecord): String;
begin
  Result := Client.Version;
  Result := Result + ' [';

  case Client.LauncherFlavour of
     0: Result := Result + ExpandConstant('{cm:openwg_unknown}');
     1: Result := Result + 'WG';
     2: Result := Result + '360';
     3: Result := Result + 'Steam';
     4: Result := Result + 'Lesta';
     5: Result := Result + 'Standalone';
  end;

  case Client.Branch of
     0: Result := Result + ExpandConstant('/{cm:openwg_unknown}');
     1: begin
          if Client.LauncherFlavour = 1 then
          begin
            Result := Result + '/' + Client.Realm;
          end;
        end;
     2: Result := Result + ExpandConstant('/{cm:openwg_branch_ct}');
     3: Result := Result + ExpandConstant('/{cm:openwg_branch_st}');
     4: Result := Result + ExpandConstant('/{cm:openwg_branch_sb}');
  end;

  Result := Result + '] - ' + Client.Path;
end;


//
//** WOTList **//
//
Var
  //WOTList: TComboBox;
  WOTList: TNewComboBox;
  DirBrowseButton: TButton;
  FindWOTBuff: String;
  wotlist_prev_idx: Integer;

// no used
Procedure WOTListUpdate();
var
 ClientsCount, Index, ListIndex: Integer;
 Str: String;
 Client: ClientRecord; // add this
begin
 ListIndex := WOTList.ItemIndex;
 ClientsCount := WOT_LauncherSetDefault(4); //WOT_GetClientsCount();

 WOTList.Items.Clear();

 if ClientsCount > 0 then
 begin
  for Index := 0 to ClientsCount - 1 do
    begin
      Client := CLIENT_GetRecord(Index);

      Str := CLIENT_FormatString(Client);
      WOTList.Items.Add(Str);
    end;
 end;

 WOTList.Items.Add(SetupMessage(msgWizardSelectDir));
 WOTList.ItemIndex := ListIndex;
end;


procedure WotList_Update(List: TNewComboBox);   // from openwg_utils
var
  Buffer: String;
  ClientsCount, Index, ListIndex: Integer;
  Str: String;
  Client: ClientRecord;
begin
  SetLength(Buffer, 1024);

  ListIndex := List.ItemIndex;
  ClientsCount := WOT_LauncherSetDefault(4); //WOT_GetClientsCount();

  List.Items.Clear();

  if ClientsCount > 0 then
  begin
    for Index := 0 to ClientsCount - 1 do
    begin
      Client := CLIENT_GetRecord(Index);
      Str := CLIENT_FormatString(Client);
      List.Items.Add(Str);
    end;
  end;

  List.Items.Add(SetupMessage(msgWizardSelectDir));
  List.ItemIndex := ListIndex;
end;

// no used
Procedure WOTListAddClient(ClientPath: String); 
var
 Index: Integer;
begin
 if Length(ClientPath) = 0 then
 begin
  WOTList.ItemIndex := -1;
  Exit;
 end;

 Index := WOT_AddClientW(ClientPath);
 if Index >= 0 then
 begin
  WOTListUpdate();
  WOTList.ItemIndex := Index;
 end else
 begin
  MsgBoxEx(WizardForm.Handle, CustomMessage('applicationNotFound'), CustomMessage('warning'), MB_ICONWARNING or MB_OK, 0, 0);
  if WOTList.Items.Strings[0] <> SetupMessage(msgWizardSelectDir) then
   WOTList.ItemIndex := 0;
 end;
end;


procedure WotList_AddClient(List: TNewComboBox; ClientPath: String);  // from openwg_utils
var
  Index: Integer;
begin
  // do nothing in case of empty string
  if Length(ClientPath) = 0 then Exit;

  // try to add client
  Index := WOT_AddClientW(ClientPath);
  if Index >= 0 then
    begin
      WotList_Update(List);
      List.ItemIndex := Index;
    end
  else
    begin
      MsgBox(ExpandConstant('{cm:openwg_client_not_found}'), mbError, MB_OK);
      List.ItemIndex := -1;
    end;
end;


Procedure WOTListOnChange(Sender: TObject); // from openwg_utils
var
  Combobox: TNewComboBox;
begin
  if Sender is TNewComboBox then
  begin
    Combobox := Sender as TNewComboBox;

    if Combobox.Text = SetupMessage(msgWizardSelectDir) then
    begin
      // call folder browser
      WizardForm.DirEdit.Text := '';
      WizardForm.DirBrowseButton.OnClick(nil);

      // try to add client
      WotList_AddClient(Combobox, WizardForm.DirEdit.Text);

      // fallback to the previous client in case of failure
      if ((Combobox.ItemIndex < 0) or (Combobox.Text = SetupMessage(msgWizardSelectDir))) and (Combobox.Items.Count > 1) then
        Combobox.ItemIndex := wotlist_prev_idx;
    end
    else
      wotlist_prev_idx := Combobox.ItemIndex;

    WizardForm.DirEdit.Text := WOT_GetClientPathW(Combobox.ItemIndex);
  end;
//begin
// case Sender of
//  DirBrowseButton:
//    begin
//     WizardForm.DirBrowseButton.OnClick(nil);
//     WOTListAddClient(WizardForm.DirEdit.Text);
//    end;
//  WOTList:
//    begin
//     if WOTList.Text = SetupMessage(msgWizardSelectDir) then
//       begin
//        // call folder browser
//        WizardForm.DirEdit.Text := '';
//        WizardForm.DirBrowseButton.OnClick(nil);
//
//        // try to add client
//        WOTListAddClient(WizardForm.DirEdit.Text);
//       end;
//    end;
// end;
// WizardForm.DirEdit.Text := WOT_GetClientPathW(WOTList.ItemIndex); // add this
end;


Procedure InitializeFindWOT();
begin
  SetLength(FindWOTBuff, 1024);
  //WOTListUpdate(); // no used
  WotList_Update(WOTList);

  if WOTList.ItemIndex = -1 then
    WOTList.ItemIndex := 0;
  WOTList.OnChange(nil);
end;


function WotList_Selected_Record(List: TNewComboBox): ClientRecord;
begin;
  Result := CLIENT_GetRecord(List.ItemIndex);
end;


//function WotList_Create(parent: TWinControl; pos_left, pos_top, pos_width, pos_height: Integer): TNewComboBox;
//begin;
//  Result := TNewComboBox.Create(WizardForm);
//  Result.Parent := parent;
//  Result.Style := csDropDownList;
//  Result.OnChange := @WOTListOnChange;
//  //Result.SetBounds(pos_left, pos_top, pos_left + pos_width, pos_height);
//  Result.SetBounds(pos_left, pos_top, pos_width, pos_height);
//  WOTListUpdate(Result);
//end;


//
// Checks
//
function CHECK_IsLesta(): Boolean;
var
  Flavour: Integer;
begin
  //Flavour := WotList_Selected_Record(WotList).LauncherFlavour;
  //Result := Flavour = 4;
end;


//
// Placeholders
//
//function PH_Client_Version(s: String): String;
//begin
//  Result := WotList_Selected_Record(WotList).Version;
//end;
//
//function PH_Folder_Mods(s: String): String;
//begin
//  Result := WotList_Selected_Record(WotList).PathMods;
//end;
//
//function PH_Folder_Resmods(s: String): String;
//begin
//  Result := WotList_Selected_Record(WotList).PathResmods;
//end;







//
// start of Wargaming GameCenter
//Procedure WGC_GetInstallPathW(Buffer: String; BufferSize: Integer);
//external 'WGC_GetInstallPathW@files:findwot.dll cdecl';

//Function WGC_IsInstalled(): Boolean;
//external 'WGC_IsInstalled@files:findwot.dll cdecl';
// end of Wargaming GameCenter

// There is functions we GET from open_wg_utils
//Function WOT_AddClientW(ClientPath: String): Integer;
//external 'WOT_AddClientW@files:findwot.dll cdecl';

//Procedure WOT_GetPreferredClientPathW(Buffer: String; BufferSize: Integer);
//external 'WOT_GetPreferredClientPathW@files:findwot.dll cdecl';

// There is functions we GET from open_wg_utils
//Function WOT_GetClientsCount(): Integer;
//external 'WOT_GetClientsCount@files:findwot.dll cdecl';

// There is functions we GET from open_wg_utils
//Function WOT_GetClientBranch(ClientIndex: Integer): Integer;
//external 'WOT_GetClientBranch@files:findwot.dll cdecl';
//
//// There is functions we GET from open_wg_utils
//Function WOT_GetClientType(ClientIndex: Integer): Integer;
//external 'WOT_GetClientType@files:findwot.dll cdecl';
//
//// There is functions we GET from open_wg_utils
//Procedure WOT_GetClientLocaleW(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
//external 'WOT_GetClientLocaleW@files:findwot.dll cdecl';
//
//// There is functions we GET from open_wg_utils
//Procedure WOT_GetClientPathW(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
//external 'WOT_GetClientPathW@files:findwot.dll cdecl';
//
//// There is functions we GET from open_wg_utils
//Procedure WOT_GetClientVersionW(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
//external 'WOT_GetClientVersionW@files:findwot.dll cdecl';
//
//// There is functions we GET from open_wg_utils
//Procedure WOT_GetClientExeVersionW(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
//external 'WOT_GetClientExeVersionW@files:findwot.dll cdecl';