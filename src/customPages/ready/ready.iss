// © _McClayn, 2020-now LITE justsherlock \\

#include "readyMemo.iss"

[Code]
Var
 ReadyPage: TWizardPage;
 ReadyPageImg, ReadyPageNameImg: Longint;
 ReadyLabel: TLabel;
 ReadyMemo: TNewMemo;

Procedure SaveReadyMemoToLog(const CurStep: TSetupStep);
var
 FileName: String;
begin
 if CurStep = ssPostInstall then
 begin
  FileName := ExpandConstant('{app}\{#AppFullName}\install_log.rtf');
  ReadyMemo.Lines.SaveToFile(FileName);
  SaveStringToFile(FileName, #13#10 +
   //'   Информер в ангаре об обновлениях модпака' + #13#10#13#10 +
   '-- {#AppFullName} для '+ sgGameName(GamePatch,'') + ' v' + GamePatch + #13#10 +
   '-- v{#Version} - сборка от {#CreateDate}' + #13#10 +
   '-- Install Log at - ' + GetDateTimeString('dd/mm/yyyy hh:nn:ss', '.', ':'), True);    // {#GameFullName}
 end;
end;

Procedure SetReadyPageVisibility(Value: Boolean);
begin
 ImgSetVisibility(ReadyPageImg, Value);
 ImgSetVisibility(ReadyPageNameImg, Value);
 ReadyLabel.Visible := Value;
 ReadyMemo.Visible := Value;
end;

Procedure ReadyPageOnActivate(Sender: TWizardPage);
begin
  SetReadyPageVisibility(True);
  ReadyMemo.Text := GetReadyMemoFormat();
  WizardForm.NextButton.Caption := SetupMessage(msgButtonInstall);
  WizardForm.NextButton.Enabled := ComponentsMainChecked('CheckForChecked')
                                or ComponentsPricelsChecked('CheckForChecked')
                                //or ComponentsHangarChecked('CheckForChecked')
                                or ComponentsVoiceoverChecked('CheckForChecked')
                                //or ComponentsPMODChecked('CheckForChecked')
                                //or ComponentsXVMChecked('CheckForChecked')
                                or ComponentsTweakerChecked('CheckForChecked');
end;

Function ReadyPageOnButtonClick(Sender: TWizardPage): Boolean;
begin
 Result := True;
 SetReadyPageVisibility(False);
 WizardForm.NextButton.Caption := SetupMessage(msgButtonNext);
end;

Procedure InitializeReadyPage();
begin
 ReadyPage := CreateCustomPage(ComponentsPageTweaker.ID, '', '');                     //     TweakerPage.ID
 with ReadyPage do
 begin
  OnActivate := @ReadyPageOnActivate;
  OnBackButtonClick := @ReadyPageOnButtonClick;
  OnNextButtonClick := @ReadyPageOnButtonClick;
 end;

 ReadyLabel := TLabel.Create(ReadyPage);
 with ReadyLabel do
 begin
  Parent := WizardForm;
  SetBounds(ScaleX(15), ScaleY(94), 0, 0);
  AutoSize := True;
  Transparent := True;
  WordWrap := False;
  Font.Size := 11;
  Font.Style := [fsBold];
  Caption := CustomMessage('readyLabelText');
 end;

 ReadyMemo := TNewMemo.Create(ReadyPage);
 with ReadyMemo do
 begin
  Parent := WizardForm;
  SetBounds(ScaleX(10), ScaleY(130), WizardForm.ClientWidth - ScaleX(20), ScaleY(360));
  ScrollBars := ssVertical;
  ReadOnly := True;
  Font.Size := 9;
 end;

 ReadyPageImg := ImgLoad(WizardForm.Handle, 'pageReady.png', 0, 0, WizardForm.ClientWidth, WizardForm.ClientHeight, True, True);
 ReadyPageNameImg := ImgLoad(WizardForm.Handle, Format('pageReadyName_%s.png', [ActiveLanguage()]), ScaleX(5), ScaleY(7), ScaleX(460), ScaleY(70), True, False);

 SetReadyPageVisibility(False);
end;