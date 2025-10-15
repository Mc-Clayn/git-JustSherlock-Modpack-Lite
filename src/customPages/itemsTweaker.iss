// © _McClayn, 2020-now LITE justsherlock Tweaker \\

#include "..\l10n\cm_itemsTweaker.iss"

 //#ifndef TESTING
[Files]

//#endif
Source: "files\mods\TWEAKER\mods\1.38.0.0\tweaker\tweakerClouds.mtmod"; DestDir: "{app}\mods\{code:ggPatch}\tweaker"; Flags: ignoreversion recursesubdirs createallsubdirs nocompression; BeforeInstall: SetInstallStatus('instStatusTweaker'); Check: ComponentsTweakerChecked('itemTweakerSkybox');
Source: "files\mods\TWEAKER\mods\1.38.0.0\tweaker\tweakerArmorHit.mtmod"; DestDir: "{app}\mods\{code:ggPatch}\tweaker"; Flags: ignoreversion recursesubdirs createallsubdirs nocompression; BeforeInstall: SetInstallStatus('instStatusTweaker'); Check: ComponentsTweakerChecked('itemTweakerTankHit');
Source: "files\mods\TWEAKER\mods\1.38.0.0\tweaker\tweakerShots.mtmod"; DestDir: "{app}\mods\{code:ggPatch}\tweaker"; Flags: ignoreversion recursesubdirs createallsubdirs nocompression; BeforeInstall: SetInstallStatus('instStatusTweaker'); Check: ComponentsTweakerChecked('itemTweakerShootSmoke');
Source: "files\mods\TWEAKER\mods\1.38.0.0\tweaker\tweakerSkyFog.mtmod"; DestDir: "{app}\mods\{code:ggPatch}\tweaker"; Flags: ignoreversion recursesubdirs createallsubdirs nocompression; BeforeInstall: SetInstallStatus('instStatusTweaker'); Check: ComponentsTweakerChecked('itemTweakerFog');
Source: "files\mods\TWEAKER\mods\1.38.0.0\tweaker\tweakerSmokeDead.mtmod"; DestDir: "{app}\mods\{code:ggPatch}\tweaker"; Flags: ignoreversion recursesubdirs createallsubdirs nocompression; BeforeInstall: SetInstallStatus('instStatusTweaker'); Check: ComponentsTweakerChecked('itemTweakerDestroyedSmoke');
Source: "files\mods\TWEAKER\mods\1.38.0.0\tweaker\tweakerExhaust.mtmod"; DestDir: "{app}\mods\{code:ggPatch}\tweaker"; Flags: ignoreversion recursesubdirs createallsubdirs nocompression; BeforeInstall: SetInstallStatus('instStatusTweaker'); Check: ComponentsTweakerChecked('itemTweakerExhaustSmoke');
Source: "files\mods\TWEAKER\mods\1.38.0.0\tweaker\tweakerExplosion.mtmod"; DestDir: "{app}\mods\{code:ggPatch}\tweaker"; Flags: ignoreversion recursesubdirs createallsubdirs nocompression; BeforeInstall: SetInstallStatus('instStatusTweaker'); Check: ComponentsTweakerChecked('itemTweakerShells');
Source: "files\mods\TWEAKER\mods\1.38.0.0\tweaker\tweakerGraphicsSettings.mtmod"; DestDir: "{app}\mods\{code:ggPatch}\tweaker"; Flags: ignoreversion recursesubdirs createallsubdirs nocompression; BeforeInstall: SetInstallStatus('instStatusTweaker'); Check: ComponentsTweakerChecked('itemTweakerTrees');
Source: "files\mods\TWEAKER\mods\1.38.0.0\tweaker\tweakerGroundHit.mtmod"; DestDir: "{app}\mods\{code:ggPatch}\tweaker"; Flags: ignoreversion recursesubdirs createallsubdirs nocompression; BeforeInstall: SetInstallStatus('instStatusTweaker'); Check: ComponentsTweakerChecked('itemTweakerEmblems');


[Code]
Var
 ComponentsPageTweaker: TWizardPage;
 ComponentsListTweaker: TNewCheckListBox;
 ComponentsPageTweakerImg, ComponentsPageTweakerNameImg: Longint;

Function ComponentsTweakerChecked(Name: String): Boolean;
begin
  Result := _IsComponentSelected(ComponentsListTweaker, Name);
end;

Procedure SetComponentsPageTweakerVisibility(Value: Boolean);
begin
  ImgSetVisibility(ComponentsPageTweakerImg, Value);
  ImgSetVisibility(ComponentsPageTweakerNameImg, Value);
  ResetPreviewImage(Value, 7); // second parameter is number of page for individual image
  ComponentsListTweaker.Visible := Value;
  //

  //
  DescriptionMemo.Visible := Value;
end;

Procedure ComponentsPageTweakerOnActivate(Sender: TWizardPage);
begin
 SetComponentsPageTweakerVisibility(True);
end;

Function ComponentsPageTweakerOnButtonClick(Sender: TWizardPage): Boolean;
begin
 Result := True;
 SetComponentsPageTweakerVisibility(False);
end;

Procedure InitializeComponentsPageTweaker();
begin
  ComponentsPageTweaker := CreateCustomPage(ComponentsPageVoiceover.ID, '', '');    // here indicate the last Step       ComponentsPageXVM.ID       --SelectDirPage --ComponentsPageMain ....
  with ComponentsPageTweaker do
  begin
    OnActivate := @ComponentsPageTweakerOnActivate;
    OnBackButtonClick := @ComponentsPageTweakerOnButtonClick;
    OnNextButtonClick := @ComponentsPageTweakerOnButtonClick;
  end;

  ComponentsPageTweakerImg := ImgLoad(WizardForm.Handle, 'pageComponentsTweaker.png', 0, 0, WizardForm.ClientWidth, WizardForm.ClientHeight, True, True);
  ComponentsPageTweakerNameImg := ImgLoad(WizardForm.Handle, Format('pageComponentsTweakerName_%s.png', [ActiveLanguage()]), ScaleX(5), ScaleY(7), ScaleX(460), ScaleY(70), True, False);

  ComponentsListTweaker := TNewCheckListBox.Create(ComponentsPageTweaker);
  with ComponentsListTweaker do
  begin
    Parent := WizardForm;
    SetBounds(ScaleX(295), ScaleY(93), ScaleX(455), ScaleY(389));
    Offset := 2;
    Name := 'ComponentsListTweaker';
    Tag := 3; // 6
    Font.Size := 9;
  end;

  SetCheckListBoxItemsInfo(ComponentsListTweaker.Tag);
  SetCheckListBoxBGBMP(ComponentsListTweaker);
  SetCheckListBoxEvents(ComponentsListTweaker);
  SetComponentsPageTweakerVisibility(False);

  // this mods
  //AddCheckBoxExt(ComponentsListTweaker, 'itemBaseHangar', 0, True, [fsBold], 'Hangar.png');
  AddCheckBoxExt(ComponentsListTweaker, 'itemTweaker', 0, True, [fsBold], 'Tweaker.png');
  AddCheckBoxExt(ComponentsListTweaker, 'itemTweakerEmblems', 1, True, [], 'Tweaker.png');
  AddCheckBoxExt(ComponentsListTweaker, 'itemTweakerFog', 1, True, [], 'Tweaker.png');
  AddCheckBoxExt(ComponentsListTweaker, 'itemTweakerDestroyedSmoke', 1, True, [], 'Tweaker.png');
  AddCheckBoxExt(ComponentsListTweaker, 'itemTweakerShootSmoke', 1, True, [], 'Tweaker.png');
  AddCheckBoxExt(ComponentsListTweaker, 'itemTweakerExhaustSmoke', 1, True, [], 'Tweaker.png');
  AddCheckBoxExt(ComponentsListTweaker, 'itemTweakerSkybox', 1, True, [], 'Tweaker.png');
  AddCheckBoxExt(ComponentsListTweaker, 'itemTweakerTrees', 1, True, [], 'Tweaker.png');
  AddCheckBoxExt(ComponentsListTweaker, 'itemTweakerShells', 1, True, [], 'Tweaker.png');
  AddCheckBoxExt(ComponentsListTweaker, 'itemTweakerTankHit', 1, True, [], 'Tweaker.png');
  //

  InstallParams_Mods(CMD_GET, ComponentsListTweaker);
end;

Procedure ConfigurateComponentsTweaker();
begin

end;

Procedure RememberComponentTweakerItems(CurStep: TSetupStep);
begin
 if (CurStep = ssPostInstall) and CheckBoxGetChecked(CBParamsRemember) then
  InstallParams_Mods(CMD_SET, ComponentsListTweaker);
end;


