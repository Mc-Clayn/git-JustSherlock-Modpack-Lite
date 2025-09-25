// © _McClayn, 2020-now LITE justsherlock PMOD \\

#include "..\l10n\cm_itemsPMOD.iss"

 //#ifndef TESTING
[Files]
// radio wgfm
//Source: "files\mods\WGFM\mods\{#PatchLesta}\me.poliroid.modslistapi_1.4.8.wotmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPMODChecked('itemBaseHangarFM');
//Source: "files\mods\WGFM\mods\{#PatchLesta}\me.poliroid.netradiowot_1.2.3.wotmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPMODChecked('itemBaseHangarFM');

//#endif

// Demo ver

[Code]
Var
 ComponentsPagePMOD: TWizardPage;
 ComponentsListPMOD: TNewCheckListBox;
 ComponentsPagePMODImg, ComponentsPagePMODNameImg: Longint;

Function ComponentsPMODChecked(Name: String): Boolean;
begin
  Result := _IsComponentSelected(ComponentsListPMOD, Name);
end;

Procedure SetComponentsPagePMODVisibility(Value: Boolean);
begin
  ImgSetVisibility(ComponentsPagePMODImg, Value);
  ImgSetVisibility(ComponentsPagePMODNameImg, Value);
  ResetPreviewImage(Value, 5); // second parameter is number of page for individual image
  ComponentsListPMOD.Visible := Value;
  //

  //
  DescriptionMemo.Visible := Value;
end;

Procedure ComponentsPagePMODOnActivate(Sender: TWizardPage);
begin
 SetComponentsPagePMODVisibility(True);
end;

Function ComponentsPagePMODOnButtonClick(Sender: TWizardPage): Boolean;
begin
 Result := True;
 SetComponentsPagePMODVisibility(False);
end;

Procedure InitializeComponentsPagePMOD();
begin
  ComponentsPagePMOD := CreateCustomPage(ComponentsPageVoiceover.ID, '', '');   // here indicate the last Step      --SelectDirPage --ComponentsPageMain ....
  with ComponentsPagePMOD do
  begin
    OnActivate := @ComponentsPagePMODOnActivate;
    OnBackButtonClick := @ComponentsPagePMODOnButtonClick;
    OnNextButtonClick := @ComponentsPagePMODOnButtonClick;
  end;

  ComponentsPagePMODImg := ImgLoad(WizardForm.Handle, 'pageComponentsPMOD.png', 0, 0, WizardForm.ClientWidth, WizardForm.ClientHeight, True, True);
  ComponentsPagePMODNameImg := ImgLoad(WizardForm.Handle, Format('pageComponentsPMODName_%s.png', [ActiveLanguage()]), ScaleX(5), ScaleY(7), ScaleX(460), ScaleY(70), True, False);

  ComponentsListPMOD := TNewCheckListBox.Create(ComponentsPagePMOD);
  with ComponentsListPMOD do
  begin
    Parent := WizardForm;
    SetBounds(ScaleX(295), ScaleY(93), ScaleX(455), ScaleY(389));
    Offset := 2;
    Name := 'ComponentsListPMOD';
    Tag := 4;
    Font.Size := 9;
  end;

  SetCheckListBoxItemsInfo(ComponentsListPMOD.Tag);
  SetCheckListBoxBGBMP(ComponentsListPMOD);
  SetCheckListBoxEvents(ComponentsListPMOD);
  SetComponentsPagePMODVisibility(False);

  // this mods
  AddCheckBoxExt(ComponentsListPMOD, 'itemPMOD', 0, True, [fsBold], 'Hangar.png');
    AddCheckBoxExt(ComponentsListPMOD, 'itemPMODcrewCamera', 1, True, [], 'Hangar.png');
    AddCheckBoxExt(ComponentsListPMOD, 'itemPMODtokens', 1, True, [], 'Hangar.png');
    AddCheckBoxExt(ComponentsListPMOD, 'itemPMODstabilization', 1, True, [], 'Hangar.png');
    AddCheckBoxExt(ComponentsListPMOD, 'itemPMODzoom', 1, True, [], 'Hangar.png');
    AddCheckBoxExt(ComponentsListPMOD, 'itemPMODdisabledFilter', 1, True, [], 'Hangar.png');
    AddCheckBoxExt(ComponentsListPMOD, 'itemPMODfreeCamera', 1, True, [], 'Hangar.png');
  //

  InstallParams_Mods(CMD_GET, ComponentsListPMOD);
end;

Procedure ConfigurateComponentsPMOD();
begin

end;

Procedure RememberComponentPMODItems(CurStep: TSetupStep);
begin
 if (CurStep = ssPostInstall) and CheckBoxGetChecked(CBParamsRemember) then
  InstallParams_Mods(CMD_SET, ComponentsListPMOD);
end;
