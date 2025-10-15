// © _McClayn, 2020-now LITE justsherlock Pricels \\

#include "..\l10n\cm_itemsPricels.iss"

 //#ifndef TESTING
[Files]
// radio wgfm
//Source: "files\mods\WGFM\mods\{#PatchLesta}\me.poliroid.modslistapi_1.4.8.wotmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemBaseHangarFM');
//Source: "files\mods\WGFM\mods\{#PatchLesta}\me.poliroid.netradiowot_1.2.3.wotmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemBaseHangarFM');

// pricels
// Overcross
Source: "files\mods\pricels\prikolnyj-pritsel-overcross-dlja-world MR_TEZ + Andre_V\mods\1.38.0.0\crosshair_arcade.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels1');
Source: "files\mods\pricels\prikolnyj-pritsel-overcross-dlja-world MR_TEZ + Andre_V\mods\1.38.0.0\crosshair_Controls.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels1');
Source: "files\mods\pricels\prikolnyj-pritsel-overcross-dlja-world MR_TEZ + Andre_V\mods\1.38.0.0\crosshair_sniper.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels1');
//Source: "files\mods\pricels\prikolnyj-pritsel-overcross-dlja-world MR_TEZ + Andre_V\mods\1.36.1.0\tv.protanki.sights.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels1');
Source: "files\mods\pricels\prikolnyj-pritsel-overcross-dlja-world MR_TEZ + Andre_V\mods\1.38.0.0\crosshair_strategic.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels1');
Source: "files\mods\pricels\prikolnyj-pritsel-overcross-dlja-world MR_TEZ + Andre_V\mods\1.38.0.0\crosshairs_api_1.1.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels1');
Source: "files\mods\pricels\prikolnyj-pritsel-overcross-dlja-world MR_TEZ + Andre_V\mods\configs\crosshairs\strategicCrosshair.json"; DestDir: "{app}\mods\configs\crosshairs"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels1');

// ProTanki New
Source: "files\mods\pricels\pritsel-protanki-dlya-world\Новый прицел OK\mods\1.38.0.0\crosshair_arcade.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels2_1');
Source: "files\mods\pricels\pritsel-protanki-dlya-world\Новый прицел OK\mods\1.38.0.0\crosshair_sniper.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels2_1');
Source: "files\mods\pricels\pritsel-protanki-dlya-world\Новый прицел OK\mods\1.38.0.0\crosshairs_api_1.1.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels2_1');
//Source: "files\mods\pricels\pritsel-protanki-dlya-world\Новый прицел OK\mods\{#CPatch}\tv.protanki.sights.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels2_1');

// ProTanki Old
Source: "files\mods\pricels\pritsel-protanki-dlya-world\Старый прицел Карать\mods\1.38.0.0\crosshair_arcade.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels2_2');
Source: "files\mods\pricels\pritsel-protanki-dlya-world\Старый прицел Карать\mods\1.38.0.0\crosshair_sniper.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels2_2');
Source: "files\mods\pricels\pritsel-protanki-dlya-world\Старый прицел Карать\mods\1.38.0.0\crosshairs_api_1.1.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels2_2');
//Source: "files\mods\pricels\pritsel-protanki-dlya-world\Старый прицел Карать\mods\{#CPatch}\tv.protanki.sights.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels2_2');

// BadBoy pricel                                                     
Source: "files\mods\pricels\pritsel-bedboya-dlya-world\mods\1.38.0.0\crosshair_arcade.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels3');
Source: "files\mods\pricels\pritsel-bedboya-dlya-world\mods\1.38.0.0\crosshair_sniper.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels3');
Source: "files\mods\pricels\pritsel-bedboya-dlya-world\mods\1.38.0.0\crosshair_strategic.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels3');
Source: "files\mods\pricels\pritsel-bedboya-dlya-world\mods\1.38.0.0\crosshairs_api_1.1.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels3');
//Source: "files\mods\pricels\pritsel-bedboya-dlya-world\mods\1.23.0.0\tv.protanki.sights.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels3');
Source: "files\mods\pricels\pritsel-bedboya-dlya-world\Сведение 1\crosshair_Controls.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels3_1');
Source: "files\mods\pricels\pritsel-bedboya-dlya-world\Сведение 2\crosshair_Controls.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels3_2');
Source: "files\mods\pricels\pritsel-bedboya-dlya-world\Сведение 3\crosshair_Controls.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemPricels3_3');
//Source: "files\mods\pricels\pritsel-bedboya-dlya-world\Сведение 2-2\crosshair_Controls.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsPricelsChecked('itemBaseOtherPricels5_4');


//#endif

// Demo ver

[Code]
Var
 ComponentsPagePricels: TWizardPage;
 ComponentsListPricels: TNewCheckListBox;
 ComponentsPagePricelsImg, ComponentsPagePricelsNameImg: Longint;

Function ComponentsPricelsChecked(Name: String): Boolean;
begin
  Result := _IsComponentSelected(ComponentsListPricels, Name);
end;

Procedure SetComponentsPagePricelsVisibility(Value: Boolean);
begin
  ImgSetVisibility(ComponentsPagePricelsImg, Value);
  ImgSetVisibility(ComponentsPagePricelsNameImg, Value);
  ResetPreviewImage(Value, 2); // second parameter is number of page for individual image
  ComponentsListPricels.Visible := Value;
  //

  //
  DescriptionMemo.Visible := Value;
end;

Procedure ComponentsPagePricelsOnActivate(Sender: TWizardPage);
begin
 SetComponentsPagePricelsVisibility(True);
end;

Function ComponentsPagePricelsOnButtonClick(Sender: TWizardPage): Boolean;
begin
 Result := True;
 SetComponentsPagePricelsVisibility(False);
end;

Procedure InitializeComponentsPagePricels();
begin
  ComponentsPagePricels := CreateCustomPage(ComponentsPageMain.ID, '', '');       // here indicate the last Step      --SelectDirPage --ComponentsPageMain ....
  with ComponentsPagePricels do
  begin
    OnActivate := @ComponentsPagePricelsOnActivate;
    OnBackButtonClick := @ComponentsPagePricelsOnButtonClick;
    OnNextButtonClick := @ComponentsPagePricelsOnButtonClick;
  end;

  ComponentsPagePricelsImg := ImgLoad(WizardForm.Handle, 'pageComponentsPricels.png', 0, 0, WizardForm.ClientWidth, WizardForm.ClientHeight, True, True);
  ComponentsPagePricelsNameImg := ImgLoad(WizardForm.Handle, Format('pageComponentsPricelsName_%s.png', [ActiveLanguage()]), ScaleX(5), ScaleY(7), ScaleX(460), ScaleY(70), True, False);

  ComponentsListPricels := TNewCheckListBox.Create(ComponentsPagePricels);
  with ComponentsListPricels do
  begin
    Parent := WizardForm;
    SetBounds(ScaleX(295), ScaleY(93), ScaleX(455), ScaleY(389));
    Offset := 2;
    Name := 'ComponentsListPricels';
    Tag := 1;
    Font.Size := 9;
  end;

  SetCheckListBoxItemsInfo(ComponentsListPricels.Tag);
  SetCheckListBoxBGBMP(ComponentsListPricels);
  SetCheckListBoxEvents(ComponentsListPricels);
  SetComponentsPagePricelsVisibility(False);

  // this mods
  //AddCheckBoxExt(ComponentsListPricels, 'itemPricelsCalculator', 0, True, [fsBold], 'Hangar.png');
  // pricels
  AddCheckBoxExt(ComponentsListPricels, 'itemPricelsAll', 0, True, [fsBold], 'pricels.png');
    AddRadioButtonExt(ComponentsListPricels, 'itemPricels1', 1, True, [], 'pricels3.png');
    AddRadioButtonExt(ComponentsListPricels, 'itemPricels2', 1, True, [], 'pricels.png');
      AddRadioButtonExt(ComponentsListPricels, 'itemPricels2_1', 2, True, [], 'pricels4_1.png');
      AddRadioButtonExt(ComponentsListPricels, 'itemPricels2_2', 2, True, [], 'pricels4_2.png');
    AddRadioButtonExt(ComponentsListPricels, 'itemPricels3', 1, True, [], 'pricels5.png');
      AddRadioButtonExt(ComponentsListPricels, 'itemPricels3_1', 2, True, [], 'pricels5_1.png');
      AddRadioButtonExt(ComponentsListPricels, 'itemPricels3_2', 2, True, [], 'pricels5_2.png');
      AddRadioButtonExt(ComponentsListPricels, 'itemPricels3_3', 2, True, [], 'pricels5_3.png');
    //AddRadioButtonExt(ComponentsListPricels, 'itemPricels4', 1, True, [], 'Hangar.png'); // historical pricel
  //

  InstallParams_Mods(CMD_GET, ComponentsListPricels);
end;

Procedure ConfigurateComponentsPricels();
begin

end;

Procedure RememberComponentPricelsItems(CurStep: TSetupStep);
begin
 if (CurStep = ssPostInstall) and CheckBoxGetChecked(CBParamsRemember) then
  InstallParams_Mods(CMD_SET, ComponentsListPricels);
end;
