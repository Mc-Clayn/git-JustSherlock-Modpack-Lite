// © _McClayn, 2020-now LITE justsherlock Hangar \\

#include "..\l10n\cm_itemsHangar.iss"

 //#ifndef TESTING
[Files]

// radio wgfm
Source: "files\mods\WGFM\mods\{#PatchLesta}\me.poliroid.modslistapi_1.4.8.wotmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsHangarChecked('itemHangarRadioWGFM');
// Check: CHECK_IsLesta   or   not CHECK_IsLesta
Source: "files\mods\WGFM\mods\{#PatchLesta}\me.poliroid.netradiowot_1.2.3.wotmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsHangarChecked('itemHangarRadioWGFM');

// wot replays
Source: "files\mods\WOTREPLAYS\mods\{#PatchLesta}\me.poliroid.modslistapi_1.4.8.wotmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsHangarChecked('itemHangarReplayManager');
Source: "files\mods\WOTREPLAYS\mods\{#PatchLesta}\me.poliroid.replaysmanager_3.7.8.wotmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsHangarChecked('itemHangarReplayManager');

//#endif

// Demo ver

[Code]
Var
 ComponentsPageHangar: TWizardPage;
 ComponentsListHangar: TNewCheckListBox;
 ComponentsPageHangarImg, ComponentsPageHangarNameImg: Longint;

Function ComponentsHangarChecked(Name: String): Boolean;
begin
  Result := _IsComponentSelected(ComponentsListHangar, Name);
end;

Procedure SetComponentsPageHangarVisibility(Value: Boolean);
begin
  ImgSetVisibility(ComponentsPageHangarImg, Value);
  ImgSetVisibility(ComponentsPageHangarNameImg, Value);
  ResetPreviewImage(Value, 3); // second parameter is number of page for individual image
  ComponentsListHangar.Visible := Value;
  //

  //
  DescriptionMemo.Visible := Value;
end;

Procedure ComponentsPageHangarOnActivate(Sender: TWizardPage);
begin
 SetComponentsPageHangarVisibility(True);
end;

Function ComponentsPageHangarOnButtonClick(Sender: TWizardPage): Boolean;
begin
 Result := True;
 SetComponentsPageHangarVisibility(False);
end;

Procedure InitializeComponentsPageHangar();
begin
  ComponentsPageHangar := CreateCustomPage(ComponentsPagePricels.ID, '', '');    // here indicate the last Step      --SelectDirPage --ComponentsPageMain ....
  with ComponentsPageHangar do
  begin
    OnActivate := @ComponentsPageHangarOnActivate;
    OnBackButtonClick := @ComponentsPageHangarOnButtonClick;
    OnNextButtonClick := @ComponentsPageHangarOnButtonClick;
  end;

  ComponentsPageHangarImg := ImgLoad(WizardForm.Handle, 'pageComponentsHangar.png', 0, 0, WizardForm.ClientWidth, WizardForm.ClientHeight, True, True);
  ComponentsPageHangarNameImg := ImgLoad(WizardForm.Handle, Format('pageComponentsHangarName_%s.png', [ActiveLanguage()]), ScaleX(5), ScaleY(7), ScaleX(460), ScaleY(70), True, False);

  ComponentsListHangar := TNewCheckListBox.Create(ComponentsPageHangar);
  with ComponentsListHangar do
  begin
    Parent := WizardForm;
    SetBounds(ScaleX(295), ScaleY(93), ScaleX(455), ScaleY(389));
    Offset := 2;
    Name := 'ComponentsListHangar';
    Tag := 2;
    Font.Size := 9;
  end;

  SetCheckListBoxItemsInfo(ComponentsListHangar.Tag);
  SetCheckListBoxBGBMP(ComponentsListHangar);
  SetCheckListBoxEvents(ComponentsListHangar);
  SetComponentsPageHangarVisibility(False);

  // this mods
  //AddCheckBoxExt(ComponentsListHangar, 'itemHangar', 0, True, [fsBold], 'Hangar.png');
  AddCheckBoxExt(ComponentsListHangar, 'itemHangarManager', 0, False, [], 'Hangar.png');
  AddCheckBoxExt(ComponentsListHangar, 'itemHangarMinimalistic', 0, True, [], 'Hangar.png');
  AddCheckBoxExt(ComponentsListHangar, 'itemHangarArmorCalc', 0, True, [], 'Hangar.png');
  AddCheckBoxExt(ComponentsListHangar, 'itemHangarHits', 0, True, [], 'Hangar.png');
  AddCheckBoxExt(ComponentsListHangar, 'itemHangarReplayManager', 0, True, [], 'Hangar.png');
  AddCheckBoxExt(ComponentsListHangar, 'itemHangarRadioWGFM', 0, True, [], 'Radio2.jpg');
  //

  InstallParams_Mods(CMD_GET, ComponentsListHangar);
end;

Procedure ConfigurateComponentsHangar();
begin

end;

Procedure RememberComponentHangarItems(CurStep: TSetupStep);
begin
 if (CurStep = ssPostInstall) and CheckBoxGetChecked(CBParamsRemember) then
  InstallParams_Mods(CMD_SET, ComponentsListHangar);
end;
