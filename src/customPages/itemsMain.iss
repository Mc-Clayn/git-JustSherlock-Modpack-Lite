// © _McClayn, 2020-now LITE justsherlock itemsMain \\

#include "..\l10n\cm_itemsMain.iss"

 //#ifndef TESTING
[Files]
//Source: "files\mods\WGFM\mods\{#PatchLesta}\me.poliroid.modslistapi_1.4.8.wotmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemBaseHangarFM');
//Source: "files\mods\WGFM\mods\{#PatchLesta}\me.poliroid.netradiowot_1.2.3.wotmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemBaseHangarFM');

// wot replays manager
Source: "files\mods\WOTREPLAYS\mods\{#PatchLesta}\me.poliroid.modslistapi_1.6.01.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainReplayManager');
Source: "files\mods\WOTREPLAYS\mods\{#PatchLesta}\me.poliroid.mtreplays.mtrmanager_1.0.1.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainReplayManager');
Source: "files\mods\WOTREPLAYS\mods\{#PatchLesta}\net.openwg\net.openwg.fix.battleresultscache_1.8.1.mtmod"; DestDir: "{app}\mods\{#PatchLesta}\net.openwg"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainReplayManager');
Source: "files\mods\WOTREPLAYS\mods\{#PatchLesta}\net.openwg\net.openwg.fix.battleresultsreplays_1.0.5.mtmod"; DestDir: "{app}\mods\{#PatchLesta}\net.openwg"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainReplayManager');

// radio wgfm
//Source: "files\mods\WGFM\mods\1.38.0.0\me.poliroid.modslistapi_1.6.01.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainRadioWGFM');
//Source: "files\mods\WGFM\mods\1.38.0.0\me.poliroid.netradiowot_1.2.5.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainRadioWGFM');

// ачивки достижения в бою
Source: "files\mods\achiv\wotmod\me.poliroid.modslistapi_1.6.01.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainAchievements');
Source: "files\mods\achiv\wotmod\izeberg.modssettingsapi_1.6.4.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainAchievements');
Source: "files\mods\achiv\protanki\achivments.json"; DestDir: "{app}\mods\configs\protanki"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainAchievements');
Source: "files\mods\achiv\wotmod\tv.protanki.achivments_3.4.11.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainAchievements');

// опасный светофор
Source: "files\mods\enemyannouncer\wotmod\me.poliroid.modslistapi_1.6.01.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainTrafficLight');
Source: "files\mods\enemyannouncer\wotmod\izeberg.modssettingsapi_1.6.4.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainTrafficLight');
Source: "files\mods\enemyannouncer\protanki\enemyAnnouncer.json"; DestDir: "{app}\mods\configs\protanki"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainTrafficLight');
Source: "files\mods\enemyannouncer\wotmod\tv.protanki.enemyannouncer_3.4.08.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainTrafficLight');

// 3d styles
//Source: "files\mods\3dstyles\wotmod\me.poliroid.modslistapi_1.6.01.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMain3dStyles');
//Source: "files\mods\3dstyles\wotmod\izeberg.modssettingsapi_1.6.4.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMain3dStyles');
//Source: "files\mods\3dstyles\wotmod\tv.protanki.uniquestyles_3.0.1.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMain3dStyles');

// otmetki
Source: "files\mods\otmetki\wotmod\me.poliroid.modslistapi_1.6.01.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainThreeMarks');
Source: "files\mods\otmetki\wotmod\izeberg.modssettingsapi_1.6.4.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainThreeMarks');
Source: "files\mods\otmetki\protanki\gunMarksCalculator.json"; DestDir: "{app}\mods\configs\protanki"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainThreeMarks');
Source: "files\mods\otmetki\wotmod\tv.protanki.gunmarkscalc_6.0.00.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainThreeMarks');
Source: "files\mods\otmetki\wotmod\net.openwg\net.openwg.fix.battleresultscache_1.8.1.mtmod"; DestDir: "{app}\mods\{#PatchLesta}\net.openwg"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainThreeMarks');
Source: "files\mods\otmetki\wotmod\net.openwg\net.openwg.fix.battleresultsreplays_1.0.5.mtmod"; DestDir: "{app}\mods\{#PatchLesta}\net.openwg"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainThreeMarks');
Source: "files\mods\otmetki\wotmod\net.openwg\net.openwg.common_2.0.9.mtmod"; DestDir: "{app}\mods\{#PatchLesta}\net.openwg"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainThreeMarks');

// spinners
Source: "files\mods\SPINNERS\sh\justsherlock_spinner.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainSpinnerJSh');
Source: "files\mods\SPINNERS\dp\deadpool_spinner.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainSpinnerDP');
Source: "files\mods\SPINNERS\j\joves_spinner.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainSpinnerJove');
Source: "files\mods\SPINNERS\v\vspishka_spinner.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainSpinnerVsp');
Source: "files\mods\SPINNERS\w\witcher_spinner.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainSpinnerWitch');
Source: "files\mods\SPINNERS\h\yuliy_spinner.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainSpinnerYuli');
Source: "files\mods\SPINNERS\y\yusha_spinner.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainSpinnerYusha');

// tracks white  белые сбитые гусеницы
//Source: "files\mods\tracks\mods\wTracks.mtmod"; DestDir: "{app}\mods\{#Patch}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemBaseOtherTracks');
Source: "files\mods\clwhiteTracks\mods\mod.MCTCreator.TrackCrashTextures_2.2.4.256.251203.095554.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainWhiteCaterpillars');

// tanks white  белые уничтоженные танки
Source: "files\mods\clwhiteTanks\mods\mod.MCTCreator.TankCrashTextures_2.2.4.256.251203.095554.mtmod"; DestDir: "{app}\mods\{#PatchLesta}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsMainChecked('itemMainWhiteTanks');

//#endif

// Demo ver

[Code]
Var
 ComponentsPageMain: TWizardPage;
 ComponentsListMain: TNewCheckListBox;
 ComponentsPageMainImg, ComponentsPageMainNameImg: Longint;

Function ComponentsMainChecked(Name: String): Boolean;
begin
  Result := _IsComponentSelected(ComponentsListMain, Name);
end;

Procedure SetComponentsPageMainVisibility(Value: Boolean);
begin
  ImgSetVisibility(ComponentsPageMainImg, Value);
  ImgSetVisibility(ComponentsPageMainNameImg, Value);
  ResetPreviewImage(Value, 1);  // second parameter is number of page for individual image
  ComponentsListMain.Visible := Value;
  //

  //
  DescriptionMemo.Visible := Value;
end;

Procedure ComponentsPageMainOnActivate(Sender: TWizardPage);
begin
 SetComponentsPageMainVisibility(True);
end;

Function ComponentsPageMainOnButtonClick(Sender: TWizardPage): Boolean;
begin
 Result := True;
 SetComponentsPageMainVisibility(False);
end;

Procedure InitializeComponentsPageMain();
begin
  ComponentsPageMain := CreateCustomPage(SelectDirPage.ID, '', '');   // here indicate the last Step      --SelectDirPage --ComponentsPageMain ....
  with ComponentsPageMain do
  begin
    OnActivate := @ComponentsPageMainOnActivate;
    OnBackButtonClick := @ComponentsPageMainOnButtonClick;
    OnNextButtonClick := @ComponentsPageMainOnButtonClick;
  end;

  ComponentsPageMainImg := ImgLoad(WizardForm.Handle, 'pageComponentsMain.png', 0, 0, WizardForm.ClientWidth, WizardForm.ClientHeight, True, True);
  ComponentsPageMainNameImg := ImgLoad(WizardForm.Handle, Format('pageComponentsMainName_%s.png', [ActiveLanguage()]), ScaleX(5), ScaleY(7), ScaleX(460), ScaleY(70), True, False);

  ComponentsListMain := TNewCheckListBox.Create(ComponentsPageMain);
  with ComponentsListMain do
  begin
    Parent := WizardForm;
    SetBounds(ScaleX(295), ScaleY(93), ScaleX(455), ScaleY(389));
    Offset := 2;
    Name := 'ComponentsListMain';
    Tag := 0;
    Font.Size := 9;
  end;

  SetCheckListBoxItemsInfo(ComponentsListMain.Tag);
  SetCheckListBoxBGBMP(ComponentsListMain);
  SetCheckListBoxEvents(ComponentsListMain);
  SetComponentsPageMainVisibility(False);

  // this mods
  //AddCheckBoxExt(ComponentsListMain, 'itemMain', 0, True, [fsBold], 'Hangar.png');
  AddCheckBoxExt(ComponentsListMain, 'itemMainReplayManager', 0, True, [], 'ReplaysManager2.jpg');
  //AddCheckBoxExt(ComponentsListMain, 'itemMainRadioWGFM', 0, False, [], 'Radio2.jpg');   // this mod remove from lesta only wg - check this
  AddCheckBoxExt(ComponentsListMain, 'itemMainAchievements', 0, True, [], 'achiv.png');
  AddCheckBoxExt(ComponentsListMain, 'itemMainTrafficLight', 0, True, [], 'traffic.png');
  //AddCheckBoxExt(ComponentsListMain, 'itemMain3dStyles', 0, True, [], '3dstyles.png');  // this edit from protanki to mine
  AddCheckBoxExt(ComponentsListMain, 'itemMainThreeMarks', 0, True, [], 'otmetki.png');
  //AddCheckBoxExt(ComponentsListMain, 'itemMainDecisiveShot', 0, True, [], 'Hangar.png');
  //AddCheckBoxExt(ComponentsListMain, 'itemMainCombatCalculator', 0, True, [], 'Hangar.png');
  //AddCheckBoxExt(ComponentsListMain, 'itemMainAngles', 0, True, [], 'Hangar.png');
  AddCheckBoxExt(ComponentsListMain, 'itemMainSpinner', 0, True, [fsBold], 'spinner.png');
    AddRadioButtonExt(ComponentsListMain, 'itemMainSpinnerJSh', 1, True, [], 'spinnerSh.png');
    AddRadioButtonExt(ComponentsListMain, 'itemMainSpinnerDP', 1, True, [], 'spinnerD.png');
    AddRadioButtonExt(ComponentsListMain, 'itemMainSpinnerJove', 1, True, [], 'spinnerJ.png');
    AddRadioButtonExt(ComponentsListMain, 'itemMainSpinnerVsp', 1, True, [], 'spinnerV.png');
    AddRadioButtonExt(ComponentsListMain, 'itemMainSpinnerWitch', 1, True, [], 'spinnerW.png');
    AddRadioButtonExt(ComponentsListMain, 'itemMainSpinnerYuli', 1, True, [], 'spinnerH.png');
    AddRadioButtonExt(ComponentsListMain, 'itemMainSpinnerYusha', 1, True, [], 'spinnerY.png');
  AddCheckBoxExt(ComponentsListMain, 'itemMainWhiteCaterpillars', 0, True, [], 'tracks.png');
  AddCheckBoxExt(ComponentsListMain, 'itemMainWhiteTanks', 0, True, [], 'whiteCaterpillars.png');
  //

  InstallParams_Mods(CMD_GET, ComponentsListMain);
end;

Procedure ConfigurateComponentsMain();
begin

end;

Procedure RememberComponentMainItems(CurStep: TSetupStep);
begin
 if (CurStep = ssPostInstall) and CheckBoxGetChecked(CBParamsRemember) then
  InstallParams_Mods(CMD_SET, ComponentsListMain);
end;
