// ModPack LITE justsherlock


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
//Source: "src\customPages\selectDir\findwot.dll"; Flags: dontcopy;
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
//** WOTList **//
//
Var
  //WOTList: TComboBox;
  //WOTList: TNewComboBox;
  DirBrowseButton: TButton;
  FindWOTBuff: String;

Procedure WOTListAddClient(List: TNewComboBox; ClientPath: String);
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
  //WOTListUpdate();
  WotList_Update(List);
  WOTList.ItemIndex := Index;
 end else
 begin
  MsgBoxEx(WizardForm.Handle, CustomMessage('applicationNotFound'), CustomMessage('warning'), MB_ICONWARNING or MB_OK, 0, 0);
  if WOTList.Items.Strings[0] <> SetupMessage(msgWizardSelectDir) then
    WOTList.ItemIndex := 0;
 end;
end;


Procedure WOTListOnChange(Sender: TObject); // from openwg_utils
var
  Combobox: TNewComboBox;
begin
  {case Sender of
    DirBrowseButton:
      begin
        WizardForm.DirBrowseButton.OnClick(nil);
        // try to add client
        WOTListAddClient(Combobox, WizardForm.DirEdit.Text);

        // fallback to the previous client in case of failure
        //if ((Combobox.ItemIndex < 0) or (Combobox.Text = SetupMessage(msgWizardSelectDir))) and (Combobox.Items.Count > 1) then
        //  Combobox.ItemIndex := wotlist_prev_idx;
      end;
    TNewComboBox:
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

        //WizardForm.DirEdit.Text := WOT_GetClientPathW(Combobox.ItemIndex);
      end;
  end;
  WizardForm.DirEdit.Text := WOT_GetClientPathW(Combobox.ItemIndex);  }
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
end;

{
Procedure WOTListOnChange(Sender: TObject);
begin
 case Sender of
  DirBrowseButton:
  begin
   WizardForm.DirBrowseButton.OnClick(nil);
   WOTListAddClient(WizardForm.DirEdit.Text);
  end;
  WOTList:
  begin
   if WOTList.Text = SetupMessage(msgWizardSelectDir) then
   begin
    WizardForm.DirBrowseButton.OnClick(nil);
    WOTListAddClient(WizardForm.DirEdit.Text);
   end;
  end;
 end;
 WOT_GetClientPathW(FindWOTBuff, 1024, WOTList.ItemIndex);
 WizardForm.DirEdit.Text := FindWOTBuff;
end;
}

Procedure InitializeFindWOT();
begin
  SetLength(FindWOTBuff, 1024);
  WotList_Update(WOTList);

  //if WOTList.ItemIndex = -1 then
  //  WOTList.ItemIndex := 0;
  //WOTList.OnChange(nil);
  WOTList.ItemIndex := WOT_ClientFind(WizardForm.DirEdit.Text);

  if (WOTList.ItemIndex = -1) and (WOTList.Items.Count > 1) then
    WOTList.ItemIndex := 0;
  WOTList.OnChange(WOTList);
end;



//
// Checks
//
function CHECK_IsLesta(): Boolean;
var
  Vendor: Integer;
begin
  Vendor := WotList_Selected_Record(WOTList).Vendor;
  Result := Vendor = 2;
  //Flavour := WotList_Selected_Record(WotList).LauncherFlavour;
  //Result := Flavour = 4;
end;


//
// Placeholders
//
function PH_Client_Version(s: String): String;
begin
  Result := WotList_Selected_Record(WOTList).Version;
end;

function PH_Folder_Mods(s: String): String;
begin
  Result := WotList_Selected_Record(WOTList).PathMods;
end;

function PH_Folder_Resmods(s: String): String;
begin
  Result := WotList_Selected_Record(WOTList).PathResmods;
end;

