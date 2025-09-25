// © _McClayn, 2020-now LITE justsherlock \\

[Icons]
Name: "{app}\{#AppFullName}\{cm:UninstallProgram,{#AppShortName}}"; Filename: "{uninstallexe}"; WorkingDir: "{app}\{#AppFullName}"; Comment: "{cm:UninstallProgram,{#AppFullName}}."; IconFilename: "{uninstallexe}";

[Code]
Var
 FinishedPage: TWizardPage;
 FinishedPageTasks: TLabel;
 FinishedPageImg, FinishedPageNameImg, CBBrowserYT, CBGameLaunch: Longint;

Procedure LaunchGame();
var
 ErrorCode: Integer;
begin
 if CheckBoxGetChecked(CBGameLaunch) then
  ShellExec('', 'Tanki.exe', '', ExpandConstant('{app}'), SW_SHOW, ewNoWait, ErrorCode);       //   'WorldOfTanks.exe'   Tanki.exe
end;


Procedure BrowserYT(Sender: TObject);
var
 ResCode: Integer;
 ErrorCode: Integer;
begin
 if CheckBoxGetChecked(CBBrowserYT) then
    Exec('cmd.exe', '/C start {#URL_Youtube}', '', SW_SHOW, ewNoWait, ResCode);
    Exec('cmd.exe', '/C exit', '', SW_SHOW, ewNoWait, ResCode);
    //ShellExec('open', 'https://justsherlock.ru/', '', '', SW_SHOWNORMAL, ewNoWait, ResCode);
    //ShellExec('open', 'https://www.youtube.com/', '', '', SW_SHOWNORMAL, ewNoWait, ResCode);
    //ShellExecAsOriginalUser('open', 'https://tankimods,net/', '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
end;



Procedure SetFinishedPageVisibility(Value: Boolean);
begin
 ImgSetVisibility(FinishedPageImg, Value);
 ImgSetVisibility(FinishedPageNameImg, Value);
 CheckBoxSetVisibility(CBBrowserYT, Value);
 CheckBoxSetVisibility(CBGameLaunch, Value);
 FinishedPageTasks.Visible := Value;
 if Value then
 begin
  WizardForm.BackButton.Visible := False;
  WizardForm.NextButton.Caption := SetupMessage(msgButtonFinish);
  WizardForm.CancelButton.Visible := False;
 end;
end;

Procedure FinishedPageOnActivate(Sender: TWizardPage);
begin
 SetInstallingPageVisibility(False);
 SetFinishedPageVisibility(True);
end;

Function FinishedPageOnNextButtonClick(Sender: TWizardPage): Boolean;
begin
 Result := False;
 Application.Terminate();
end;

Procedure InitializeFinishedPage();
begin
 FinishedPage := CreateCustomPage(wpInstalling, '', '');
 with FinishedPage do
 begin
  OnActivate := @FinishedPageOnActivate;
  OnNextButtonClick := @FinishedPageOnNextButtonClick;
 end;

 //FinishedPageImg := ImgLoad(WizardForm.Handle, 'pageFinished.png', 0, 0, WizardForm.ClientWidth, WizardForm.ClientHeight, True, True);
 FinishedPageImg := ImgLoad(WizardForm.Handle, Format('pageFinished_%s.png', [ActiveLanguage()]), 0, 0, WizardForm.ClientWidth, WizardForm.ClientHeight, True, True);
 FinishedPageNameImg := ImgLoad(WizardForm.Handle, Format('pageFinishedName_%s.png', [ActiveLanguage()]), ScaleX(5), ScaleY(7), ScaleX(460), ScaleY(70), True, False);

 FinishedPageTasks := TLabel.Create(WizardForm);
 with FinishedPageTasks do
 begin
  Parent := WizardForm;
  SetBounds(ScaleX(15), ScaleY(380), 0, 0);
  Font.Size := 11;
  Font.Style := [fsBold];
  Caption := CustomMessage('finishedPageTasksText');
 end;



 CBBrowserYT := CheckBoxCreate(WizardForm.Handle, ScaleX(22), ScaleY(405), ScaleX(445), ScaleY(22), 'checkBox.png', 0, 2);    // 445
  CheckBoxSetText(CBBrowserYT, CustomMessage('browserYTButtonText'));
  CheckBoxSetFont(CBBrowserYT, BotvaFont.Handle);
  CheckBoxSetFontColor(CBBrowserYT, clWhite, $CCCCCC, $D9D9D9, clGray);


 CBGameLaunch := CheckBoxCreate(WizardForm.Handle, ScaleX(22), ScaleY(430), ScaleX(500), ScaleY(22), 'checkBox.png', 0, 2);     // 445
  CheckBoxSetText(CBGameLaunch, CustomMessage('launchGameButtonText'));
  CheckBoxSetFont(CBGameLaunch, BotvaFont.Handle);
  CheckBoxSetFontColor(CBGameLaunch, clWhite, $CCCCCC, $D9D9D9, clGray);

 SetFinishedPageVisibility(False);
end;