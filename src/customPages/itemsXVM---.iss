// © _McClayn, 2020-now XVM LITE justsherlock \\

#include "..\l10n\cm_itemsXVM.iss"

 //#ifndef TESTING
[Files]
// radio wgfm
//Source: "files\mods\WGFM\mods\{#PatchLesta}\me.poliroid.modslistapi_1.4.8.wotmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsXVMChecked('itemBaseHangarFM');
//Source: "files\mods\WGFM\mods\{#PatchLesta}\me.poliroid.netradiowot_1.2.3.wotmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsXVMChecked('itemBaseHangarFM');

//#endif

// Demo ver

[Code]
Var
 ComponentsPageXVM: TWizardPage;
 ComponentsListXVM: TNewCheckListBox;
 ComponentsPageXVMImg, ComponentsPageXVMNameImg: Longint;

Function ComponentsXVMChecked(Name: String): Boolean;
begin
  Result := _IsComponentSelected(ComponentsListXVM, Name);
end;

Procedure SetComponentsPageXVMVisibility(Value: Boolean);
begin
  ImgSetVisibility(ComponentsPageXVMImg, Value);
  ImgSetVisibility(ComponentsPageXVMNameImg, Value);
  ResetPreviewImage(Value, 6); // second parameter is number of page for individual image
  ComponentsListXVM.Visible := Value;
  //

  //
  DescriptionMemo.Visible := Value;
end;

Procedure ComponentsPageXVMOnActivate(Sender: TWizardPage);
begin
 SetComponentsPageXVMVisibility(True);
end;

Function ComponentsPageXVMOnButtonClick(Sender: TWizardPage): Boolean;
begin
 Result := True;
 SetComponentsPageXVMVisibility(False);
end;

Procedure InitializeComponentsPageXVM();
begin
  ComponentsPageXVM := CreateCustomPage(ComponentsPagePMOD.ID, '', '');  // here indicate the last Step      --SelectDirPage --ComponentsPageMain ....
  with ComponentsPageXVM do
  begin
    OnActivate := @ComponentsPageXVMOnActivate;
    OnBackButtonClick := @ComponentsPageXVMOnButtonClick;
    OnNextButtonClick := @ComponentsPageXVMOnButtonClick;
  end;

  ComponentsPageXVMImg := ImgLoad(WizardForm.Handle, 'pageComponentsXVM.png', 0, 0, WizardForm.ClientWidth, WizardForm.ClientHeight, True, True);
  ComponentsPageXVMNameImg := ImgLoad(WizardForm.Handle, Format('pageComponentsXVMName_%s.png', [ActiveLanguage()]), ScaleX(5), ScaleY(7), ScaleX(460), ScaleY(70), True, False);

  ComponentsListXVM := TNewCheckListBox.Create(ComponentsPageXVM);
  with ComponentsListXVM do
  begin
    Parent := WizardForm;
    SetBounds(ScaleX(295), ScaleY(93), ScaleX(455), ScaleY(389));
    Offset := 2;
    Name := 'ComponentsListXVM';
    Tag := 5;
    Font.Size := 9;
  end;

  SetCheckListBoxItemsInfo(ComponentsListXVM.Tag);
  SetCheckListBoxBGBMP(ComponentsListXVM);
  SetCheckListBoxEvents(ComponentsListXVM);
  SetComponentsPageXVMVisibility(False);

  // this mods
  AddCheckBoxExt(ComponentsListXVM, 'itemXVM', 0, True, [fsBold], 'Hangar.png');
    AddCheckBoxExt(ComponentsListXVM, 'itemXVMpointer', 1, True, [], 'Hangar.png');
    AddCheckBoxExt(ComponentsListXVM, 'itemXVMhpMinimap', 1, True, [], 'Hangar.png');
    AddCheckBoxExt(ComponentsListXVM, 'itemXVMindicator', 1, True, [], 'Hangar.png');
    AddCheckBoxExt(ComponentsListXVM, 'itemXVMclock', 1, True, [], 'Hangar.png');
    AddCheckBoxExt(ComponentsListXVM, 'itemXVMmarkers', 1, True, [], 'Hangar.png');
    AddCheckBoxExt(ComponentsListXVM, 'itemXVMdamageLog', 1, True, [], 'Hangar.png');
    AddCheckBoxExt(ComponentsListXVM, 'itemXVMstatisticsHangar', 1, True, [], 'Hangar.png');
  //

  InstallParams_Mods(CMD_GET, ComponentsListXVM);
end;

Procedure ConfigurateComponentsXVM();
begin

end;

Procedure RememberComponentXVMItems(CurStep: TSetupStep);
begin
 if (CurStep = ssPostInstall) and CheckBoxGetChecked(CBParamsRemember) then
  InstallParams_Mods(CMD_SET, ComponentsListXVM);
end;
