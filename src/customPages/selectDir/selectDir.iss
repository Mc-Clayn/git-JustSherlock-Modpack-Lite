// © _McClayn, 2020-now LITE justsherlock \\

#include "findwot.iss"

[Code]
Var
 SelectDirPage: TWizardPage;
 DiskSpaceLabel, ClientGALabel, BackupHeaderLabel: TLabel;
 SelectDirPageImg, SelectDirPageNameImg, RBDelete, RBBackup, RBNone, CBCleanProfile, CBParamsRemember, CBClientGA: Longint;

Procedure SetSelectDirPageVisibility(Value: Boolean);
begin
 ImgSetVisibility(SelectDirPageImg, Value);
 ImgSetVisibility(SelectDirPageNameImg, Value);
 DiskSpaceLabel.Visible := Value;
 CheckBoxSetVisibility(CBClientGA, Value);
 ClientGALabel.Visible := Value
 WOTList.Visible := Value;
 DirBrowseButton.Visible := False; // Value - show off because this button not work
 BackupHeaderLabel.Visible := Value;
 CheckBoxSetVisibility(RBDelete, Value);
 CheckBoxSetVisibility(RBBackup, Value);
 CheckBoxSetVisibility(RBNone, Value);
 CheckBoxSetVisibility(CBCleanProfile, Value);
 CheckBoxSetVisibility(CBParamsRemember, Value);
end;

Procedure SelectDirPageOnActivate(Sender: TWizardPage);
begin
 InitializeFindWOT();
 SetSelectDirPageVisibility(True);
end;

Function SelectDirPageOnBackButtonClick(Sender: TWizardPage): Boolean;
begin
 Result := True;
 SetSelectDirPageVisibility(False);
end;

Function SelectDirPageOnNextButtonClick(Sender: TWizardPage): Boolean;
 #ifdef CheckForGameFiles
var
 PatchVersion, AppType: String;
 IsLesta: Boolean; // add this
 ItemCaption: String;
#endif
begin
 Result := True;
  #ifdef CheckForGameFiles
 if CMDCheckParams(CMD_NoSearchGameFiles) then
 begin
  SetSelectDirPageVisibility(False);
  Exit;
 end;
 if not FilesExists([WizardDirValue() + '\Tanki.exe', WizardDirValue() + '\version.xml', WizardDirValue() + '\app_type.xml']) then      // '\Tanki.exe'
   begin
    MsgBoxEx(WizardForm.Handle, CustomMessage('applicationWrongDir'), CustomMessage('warning'), MB_OK or MB_ICONWARNING, 0, 0);
    Result := False;
   end
 else
 begin
  XMLFileReadValue(WizardDirValue() + '\app_type.xml', 'protocol\app_type', AppType);
  Result := AppType <> 'incomplete';
  if not Result then
   MsgBoxEx(WizardForm.Handle, CustomMessage('applicationIncompleteType'), CustomMessage('warning'), MB_ICONWARNING or MB_OK, 0, 0)
  else
    begin
      XMLFileReadValue(WizardDirValue() + '\version.xml', 'version.xml\version', PatchVersion);
      Delete(PatchVersion, Pos('v', PatchVersion), 2);
      Delete(PatchVersion, Pos('#', PatchVersion) - 1, 10);

      // check for Client gameVersion
      // if in Dir choose Game Lesta we get PatchLesta, if choose WG - PatchWG
      ItemCaption := WOTList.Text;
      IsLesta := CHECK_IsLesta();

      // проверка что юзер не подделал путь к игре
//      if ((pos('Lesta', ItemCaption) <> 0) and not IsLesta) or ((pos('WG', ItemCaption) <> 0) and IsLesta) then
//        begin
//          MsgBoxEx(WizardForm.Handle, CustomMessage('applicationWrongDir'), CustomMessage('warning'), MB_OK or MB_ICONWARNING, 0, 0);
//          Result := False;
//        end;
      // New from openwg_utils v09.27
      // check for version Lesta
      if CHECK_IsLesta() and not WotList_Selected_VersionMatch(WotList, '{#PatchLesta}') then   // #PatchLesta
      begin
        Result := False;
        MsgBox(CustomMessage('version_not_match_lesta'), mbError, MB_OK);
        Exit;
      end;
      // check for version WG
      if not CHECK_IsLesta() and not WotList_Selected_VersionMatch(WotList, '{#PatchWG}') then   // #PatchWG
      begin
        Result := False;
        MsgBox(CustomMessage('version_not_match_wg'), mbError, MB_OK);
        Exit;
      end;

      // check for running client
      if WotList_Selected_IsStarted(WotList) then
      begin
        if (MsgBox(CustomMessage('client_started'), mbConfirmation, MB_YESNO) = IDYES) then
          WotList_Selected_Terminate(WotList)
        else
          Result := False;
      end;

      // set const Patch
      if ((pos('LGC', ItemCaption) <> 0) and IsLesta) then
        ggPatch('{#PatchLesta}') // this set GamePatch
      else
        ggPatch('{#PatchWG}'); // this set GamePatch

      Result := CompareStr(PatchVersion, GamePatch) = 0; // '{#Patch}'
      if not Result then
        MsgBoxEx(WizardForm.Handle, Format(CustomMessage('applicationPatchUnapplyable'), [PatchVersion, GamePatch]), CustomMessage('warning'), MB_OK or MB_ICONWARNING, 0, 0);
    end;
 end;
 #endif
 if Result then
  SetSelectDirPageVisibility(False);
end;

Function SelectDirShouldSkipPage(): Boolean;
begin
 Result := True;
end;

Procedure CBsOnClick(hBtn: Longint);
begin
 case hBtn of
  CBClientGA: SetInstallParam('CheckBox_ClientGoogleAnalytics', BoolToStr(CheckBoxGetChecked(CBClientGA)));
 end;
end;

Procedure InitializeSelectDirPage();
begin
 SelectDirPage := CreateCustomPage(WelcomePage.ID, '', '');

 with SelectDirPage do
 begin
  OnActivate := @SelectDirPageOnActivate;
  OnBackButtonClick := @SelectDirPageOnBackButtonClick;
  OnNextButtonClick := @SelectDirPageOnNextButtonClick;
 end;

 SelectDirPageImg := ImgLoad(WizardForm.Handle, 'pageSelectDir.png', 0, 0, WizardForm.ClientWidth, WizardForm.ClientHeight, True, True);
 SelectDirPageNameImg := ImgLoad(WizardForm.Handle, Format('pageSelectDirName_%s.png', [ActiveLanguage()]), ScaleX(5), ScaleY(7), ScaleX(460), ScaleY(70), True, False);

 DiskSpaceLabel := TLabel.Create(SelectDirPage);
 with DiskSpaceLabel do
 begin
  Parent := WizardForm;
  SetBounds(ScaleX(155), ScaleY(125), 0, 0);
  AutoSize := True;
  Transparent := True;
  Font.Size := 10;
  Caption := WizardForm.DiskSpaceLabel.Caption;
 end;

//FindWOT
//** Old code
// WOTList := TNewComboBox.Create(SelectDirPage);//TComboBox.Create(SelectDirPage);
// with WOTList do
// begin
//  Parent := WizardForm;
//  SetBounds(DiskSpaceLabel.Left, DiskSpaceLabel.Top + DiskSpaceLabel.Height + ScaleY(20), ScaleX(480), WizardForm.DirEdit.Height + ScaleY(5));
//  Font.Size := 9;
//  OnChange := @WOTListOnChange;
// end;
//** New code
  {WOTList := WotList_Create(WizardForm,
    DiskSpaceLabel.Left,
    DiskSpaceLabel.Top + DiskSpaceLabel.Height + ScaleY(20),
    ScaleX(480),
    WizardForm.DirEdit.Height + ScaleY(5));
  WOTList.ItemIndex := WOT_ClientFind(WizardForm.DirEdit.Text);

  if (WOTList.ItemIndex = -1) and (WOTList.Items.Count > 1) then
    WOTList.ItemIndex := 0;
  WOTList.OnChange(WOTList);  }
  WOTList := WotList_Create(WizardForm,
      DiskSpaceLabel.Left,
      DiskSpaceLabel.Top + DiskSpaceLabel.Height + ScaleY(20),
      ScaleX(340),
      WizardForm.DirEdit.Height + ScaleY(5)
  );
  WOTList.ItemIndex := WOT_ClientFind(WizardForm.DirEdit.Text);

  if (WOTList.ItemIndex = -1) and (WOTList.Items.Count > 1) then
    WOTList.ItemIndex := 0;
  WOTList.OnChange(WOTList);


 DirBrowseButton := TButton.Create(SelectDirPage);
 with DirBrowseButton do
 begin
  Parent := WizardForm;
  SetBounds(WOTList.Left + WOTList.Width + ScaleX(10), WOTList.Top, ScaleX(85), WizardForm.DirBrowseButton.Height);
  Caption := WizardForm.DirBrowseButton.Caption;
  OnClick := @WOTListOnChange;
 end;

 //HDirBrowseButton:= EffectTextureButton(WizardForm.Handle, WizardForm.DirBrowseButton, ExpandConstant('{tmp}\button_next.bmp'), 0, nil, nil, nil);

//FindWOT



 ClientGALabel := TLabel.Create(SelectDirPage);
 with ClientGALabel do
 begin
  Parent := WizardForm;
  SetBounds(ScaleX(160), ScaleY(220), 0, 0);
  AutoSize := True;
  Transparent := True;
  Font.Size := 10;
  Caption := CustomMessage('googleAnalyticsDescription');            // 
 end;

 BackupHeaderLabel := TLabel.Create(SelectDirPage);
 with BackupHeaderLabel do
 begin
  Parent := WizardForm;
  SetBounds(ScaleX(18), ScaleY(330), 0, 0);
  AutoSize := True;
  Transparent := True;
  Font.Size := 10;
  Caption := CustomMessage('backupHeaderText');
  Alignment := taCenter;
 end;

 RBDelete := CheckBoxCreate(WizardForm.Handle, ScaleX(22), BackupHeaderLabel.Top + BackupHeaderLabel.Height + ScaleY(5), ScaleX(520), ScaleY(20), 'radioButton.png', 1, 2);  // 425
  CheckBoxSetText(RBDelete, CustomMessage('deleteButtonText'));
  CheckBoxSetFont(RBDelete, BotvaFont.Handle);
  CheckBoxSetFontColor(RBDelete, clWhite, $CCCCCC, $D9D9D9, clGray);
  CheckBoxSetChecked(RBDelete, True);
 RBBackup := CheckBoxCreate(WizardForm.Handle, ScaleX(22), BackupHeaderLabel.Top + BackupHeaderLabel.Height + ScaleY(30), ScaleX(570), ScaleY(20), 'radioButton.png', 1, 2);  // 475
  CheckBoxSetText(RBBackup, CustomMessage('backupButtonText'));
  CheckBoxSetFont(RBBackup, BotvaFont.Handle);
  CheckBoxSetFontColor(RBBackup, clWhite, $CCCCCC, $D9D9D9, clGray);
 RBNone := CheckBoxCreate(WizardForm.Handle, ScaleX(22), BackupHeaderLabel.Top + BackupHeaderLabel.Height + ScaleY(55), ScaleX(610), ScaleY(20), 'radioButton.png', 1, 2);    // 535
  CheckBoxSetText(RBNone, CustomMessage('noneButtonText'));
  CheckBoxSetFont(RBNone, BotvaFont.Handle);
  CheckBoxSetFontColor(RBNone, clWhite, $CCCCCC, $D9D9D9, clGray);

 CBCleanProfile := CheckBoxCreate(WizardForm.Handle, ScaleX(22), BackupHeaderLabel.Top + BackupHeaderLabel.Height + ScaleY(85), ScaleX(590), ScaleY(22), 'checkBox.png', 0, 2);  // 495
  CheckBoxSetText(CBCleanProfile, CustomMessage('cleanProfileButtonText'));
  CheckBoxSetFont(CBCleanProfile, BotvaFont.Handle);
  CheckBoxSetFontColor(CBCleanProfile, clWhite, $CCCCCC, $D9D9D9, clGray);
 CBParamsRemember := CheckBoxCreate(WizardForm.Handle, ScaleX(22), BackupHeaderLabel.Top + BackupHeaderLabel.Height + ScaleY(110), ScaleX(570), ScaleY(22), 'checkBox.png', 0, 2);  // 455
  CheckBoxSetText(CBParamsRemember, CustomMessage('paramsRememberButtonText'));
  CheckBoxSetFont(CBParamsRemember,  BotvaFont.Handle);
  CheckBoxSetFontColor(CBParamsRemember, clWhite, $CCCCCC, $D9D9D9, clGray);
  CheckBoxSetChecked(CBParamsRemember, not FileExists(ExpandConstant(LOG_FILE)));

 SetSelectDirPageVisibility(False);
end;