// © _McClayn, 2020-now LITE Voiceover \\

#include "..\l10n\cm_itemsVoiceover.iss"

 //#ifndef TESTING
[Files]
// radio wgfm
//Source: "files\mods\WGFM\mods\{#PatchLesta}\me.poliroid.modslistapi_1.4.8.wotmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsVoiceoverChecked('itemVoiceoverBrainDit');
//Source: "files\mods\WGFM\mods\{#PatchLesta}\me.poliroid.netradiowot_1.2.3.wotmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsVoiceoverChecked('itemVoiceoverBrainDit');

//#endif

// украинская
Source: "files\mods\SOUNDPACK\ukrainskaya-ozvuchka-new\mods\1.23.0.0\voiceover.mtmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsVoiceoverChecked('itemVoiceoverUkraine');
Source: "files\mods\SOUNDPACK\ukrainskaya-ozvuchka-new\res_mods\1.23.0.0\audioww\audio_mods.xml"; DestDir: "{app}\res_mods\{code:ggPatch}\audioww"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsVoiceoverChecked('itemVoiceoverUkraine');

// серб сергей буртаковский
Source: "files\mods\SOUNDPACK\ozvuchka-serb\mods\1.10.1.4\voiceover.mtmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsVoiceoverChecked('itemVoiceoverSerb');

// восстание машин
Source: "files\mods\SOUNDPACK\ozvuchka-vosstanie-machine\mods\1.23.0.0\voiceover.mtmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsVoiceoverChecked('itemVoiceoverComentante');
Source: "files\mods\SOUNDPACK\ozvuchka-vosstanie-machine\res_mods\1.23.0.0\audioww\audio_mods.xml"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsVoiceoverChecked('itemVoiceoverComentante');

// белорусская
Source: "files\mods\SOUNDPACK\ozvuchka-belorusskaya\mods\1.23.0.0\voiceover.mtmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsVoiceoverChecked('itemVoiceoverBelarus');

// эль коментанте
Source: "files\mods\SOUNDPACK\ozvuchka-el-comentante\mods\1.23.0.0\voiceover.mtmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs ; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsVoiceoverChecked('itemVoiceoverComentante');

// _Aktep
Source: "files\mods\SOUNDPACK\ozvuchka-aktep\mods\1.32.0.0\voiceover.mtmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsVoiceoverChecked('itemVoiceoverAktep');

// олег брейн
Source: "files\mods\SOUNDPACK\ozvuchka-mcclayn-braindit\mods\1.10.1.4\voiceover.mtmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsVoiceoverChecked('itemVoiceoverBrainDit');

// chuck norris
Source: "files\mods\SOUNDPACK\ozvuchka-mcclayn-chucknorris\mods\1.23.0.0\voiceover.mtmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsVoiceoverChecked('itemVoiceoverNorris');

// joker the dark knight
Source: "files\mods\SOUNDPACK\ozvuchka-mcclayn-joker\mods\1.10.1.4\voiceover.mtmod"; DestDir: "{app}\mods\{code:ggPatch}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: SetInstallStatus('instStatusBase'); Check: ComponentsVoiceoverChecked('itemVoiceoverJoker');


// Demo ver

[Code]
Var
 ComponentsPageVoiceover: TWizardPage;
 ComponentsListVoiceover: TNewCheckListBox;
 ComponentsPageVoiceoverImg, ComponentsPageVoiceoverNameImg: Longint;

Function ComponentsVoiceoverChecked(Name: String): Boolean;
begin
  Result := _IsComponentSelected(ComponentsListVoiceover, Name);
end;

Procedure SetComponentsPageVoiceoverVisibility(Value: Boolean);
begin
  ImgSetVisibility(ComponentsPageVoiceoverImg, Value);
  ImgSetVisibility(ComponentsPageVoiceoverNameImg, Value);
  ResetPreviewImage(Value, 4); // second parameter is number of page for individual image
  ComponentsListVoiceover.Visible := Value;
  //
  BassVolumeTrackBar.Visible := Value;
  BassVolumeLbl.Visible := Value; // text Volume = 10%
  //
  DescriptionMemo.Visible := Value;
end;

Procedure ComponentsPageVoiceoverOnActivate(Sender: TWizardPage);
begin
 SetComponentsPageVoiceoverVisibility(True);
end;

Function ComponentsPageVoiceoverOnButtonClick(Sender: TWizardPage): Boolean;
begin
 Result := True;
 SetComponentsPageVoiceoverVisibility(False);
end;

Procedure InitializeComponentsPageVoiceover();
begin
  ComponentsPageVoiceover := CreateCustomPage(ComponentsPagePricels.ID, '', '');   // here indicate the last Step        ComponentsPageHangar.ID             --SelectDirPage --ComponentsPageMain ....
  with ComponentsPageVoiceover do                                       
  begin
    OnActivate := @ComponentsPageVoiceoverOnActivate;
    OnBackButtonClick := @ComponentsPageVoiceoverOnButtonClick;
    OnNextButtonClick := @ComponentsPageVoiceoverOnButtonClick;
  end;

  ComponentsPageVoiceoverImg := ImgLoad(WizardForm.Handle, 'pageComponentsVoiceover.png', 0, 0, WizardForm.ClientWidth, WizardForm.ClientHeight, True, True);
  ComponentsPageVoiceoverNameImg := ImgLoad(WizardForm.Handle, Format('pageComponentsVoiceoverName_%s.png', [ActiveLanguage()]), ScaleX(5), ScaleY(7), ScaleX(460), ScaleY(70), True, False);

  ComponentsListVoiceover := TNewCheckListBox.Create(ComponentsPageVoiceover);
  with ComponentsListVoiceover do
  begin
    Parent := WizardForm;
    SetBounds(ScaleX(295), ScaleY(93), ScaleX(455), ScaleY(389));
    Offset := 2;
    Name := 'ComponentsListVoiceover';
    Tag := 2; // 3
    Font.Size := 9;
  end;

  SetCheckListBoxItemsInfo(ComponentsListVoiceover.Tag);
  SetCheckListBoxBGBMP(ComponentsListVoiceover);
  SetCheckListBoxEvents(ComponentsListVoiceover);
  SetComponentsPageVoiceoverVisibility(False);

  // this mods
  AddCheckBoxExt(ComponentsListVoiceover, 'itemVoiceover', 0, True, [fsBold], 'Hangar.png');
    AddRadioButtonExt(ComponentsListVoiceover, 'itemVoiceoverUkraine', 1, True, [], 'ukrain.png');
    AddRadioButtonExt(ComponentsListVoiceover, 'itemVoiceoverSerb', 1, True, [], 'serb.png');
    AddRadioButtonExt(ComponentsListVoiceover, 'itemVoiceoverRise', 1, True, [], 'vosstaniemachine.png');
    AddRadioButtonExt(ComponentsListVoiceover, 'itemVoiceoverBelarus', 1, True, [], 'belaruskaya.png');
    AddRadioButtonExt(ComponentsListVoiceover, 'itemVoiceoverComentante', 1, True, [], 'elcomentante.png');
    AddRadioButtonExt(ComponentsListVoiceover, 'itemVoiceoverAktep', 1, True, [], '_aktep.png');
    AddRadioButtonExt(ComponentsListVoiceover, 'itemVoiceoverBrainDit', 1, True, [], 'logo_voiceover_thebraindit_1.jpg');
    AddRadioButtonExt(ComponentsListVoiceover, 'itemVoiceoverNorris', 1, True, [], 'chucknorris.png');
    AddRadioButtonExt(ComponentsListVoiceover, 'itemVoiceoverJoker', 1, True, [], 'joker.png');
  //

  AddItemSound(ComponentsListVoiceover, 'itemVoiceoverUkraine', 'ukrainskaya.mp3');
  AddItemSound(ComponentsListVoiceover, 'itemVoiceoverSerb', 'serb.mp3');
  AddItemSound(ComponentsListVoiceover, 'itemVoiceoverRise', 'vosstaniemachine.mp3');
  AddItemSound(ComponentsListVoiceover, 'itemVoiceoverBelarus', 'rezervatsiya.mp3');
  AddItemSound(ComponentsListVoiceover, 'itemVoiceoverComentante', 'elcomentante.mp3');
  AddItemSound(ComponentsListVoiceover, 'itemVoiceoverAktep', 'aktep_100795461.mp3'); // 'aktep_100795461.mp3'
  AddItemSound(ComponentsListVoiceover, 'itemVoiceoverBrainDit', 'olegbrain.mp3');
  AddItemSound(ComponentsListVoiceover, 'itemVoiceoverNorris', 'chucknorris.mp3');
  AddItemSound(ComponentsListVoiceover, 'itemVoiceoverJoker', 'joker.mp3');

  InstallParams_Mods(CMD_GET, ComponentsListVoiceover);
end;

Procedure ConfigurateComponentsVoiceover();
begin

end;

Procedure RememberComponentVoiceoverItems(CurStep: TSetupStep);
begin
 if (CurStep = ssPostInstall) and CheckBoxGetChecked(CBParamsRemember) then
  InstallParams_Mods(CMD_SET, ComponentsListVoiceover);
end;
