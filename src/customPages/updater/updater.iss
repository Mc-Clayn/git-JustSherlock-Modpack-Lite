// © _McClayn, 2020-2023 demo \\

#define Updater
#include "compareVersion.iss"

[Files]
Source: "files\changelog_*.txt"; Flags: dontcopy;

[Code]
Var
 UpdaterPage: TWizardPage;
 UpdPageImg, UpdPageNameImg: Longint;
 UpdProgressBar: TNewProgressBar;
 UpdText, UpdStatus, UpdInfo: TLabel;
 UpdRTF: TRichEditViewer;
 UpdCheckButton, UpdDownloadButton: TNewButton;
 ChangelogText: String;

 NewInstallerPath, NewVersionURL, ItemsBlackList: String;

Procedure UpdCheckButtonClick(Sender: TObject);
var
 UpdFile, UpdFileData, UpdVersion, UpdChanges: String;
begin
 UpdDownloadButton.Enabled := False;
 UpdProgressBar.Position := 0;
 UpdRTF.Clear();
 try
  UpdFile := ExpandConstant('{tmp}\updaterServer.xml');
  if idpDownloadFile('{#UpdatesURL}' + 'updaterServer.xml', UpdFile) and XMLFileReadValue(UpdFile, 'updaterServer.xml\' + ActiveLanguage(), UpdFileData) then
  begin
   XMLStringReadValue(UpdFileData, 'version', False, UpdVersion);
   XMLStringReadValue(UpdFileData, 'downloadLink', False, NewVersionURL);
   XMLStringReadValue(UpdFileData, 'modsBlackList', False, ItemsBlackList);
   StringChange(NewVersionURL, 'ver', UpdVersion);
   case CompareVersion(Trim(UpdVersion), '{#Version}') of
    NewVersionAvailable:
    begin
     XMLStringReadValue(UpdFileData, 'changes', False, UpdChanges);
     UpdRTF.RTFText := ' ' + Trim(UpdChanges) + CustomMessage('UpdRTFPrevChangesText') + ChangelogText;

     UpdDownloadButton.Enabled := True;
     UpdInfo.Caption := Format(CustomMessage('updInfoLabelTextVersionAvailable'), [UpdVersion]);
     UpdText.Caption := CustomMessage('updTextLabelVersionAvailable');
     NewInstallerPath := ExpandConstant('{userdesktop}\{#AppShortName}-' + UpdVersion + '.exe');
    end;
    BetaVersion:
    begin
     UpdRTF.RTFText := ChangelogText;
     UpdInfo.Caption := Format(CustomMessage('updInfoLabelTextVersionBeta'), [UpdVersion]);
     UpdText.Caption := CustomMessage('updTextLabelVersionBeta');
    end;
    VersionIsActual:
    begin
     UpdRTF.RTFText := ChangelogText;
     UpdInfo.Caption := CustomMessage('updInfoLabelVersionActual');
     UpdText.Caption := CustomMessage('updTextLabelDefault');
    end;
   end;
  end else
  begin
   UpdInfo.Caption := CustomMessage('updInfoLabelServerFailText');
   UpdRTF.RTFText := ChangelogText;
  end;
 except
  MsgBoxEx(WizardForm.Handle, GetExceptionMessage(), '{#__FILE__}: {#__LINE__}', MB_OK or MB_ICONERROR, 0 ,0);
  UpdCheckButton.Enabled := False;
  UpdInfo.Caption := CustomMessage('updInfoLabelVersionFailText')
  UpdRTF.RTFText := ChangelogText;
 end;
 UpdProgressBar.Position := 100;
end;

Function UpdaterOnDownloadFinished(): Boolean;
var
 ResCode: Integer;
begin
 if (idpFilesCount() > 0) and idpFileDownloaded(NewVersionURL) then
 begin
  Result := False;
  Exec(NewInstallerPath, CMD_Updated, '', SW_SHOW, ewNoWait, ResCode);
  Application.Terminate();
 end;
end;

///

Procedure SetUpdaterPageVisibility(Value, ImgValue: Boolean);
begin
 ImgSetVisibility(UpdPageImg, ImgValue);
 ImgSetVisibility(UpdPageNameImg, ImgValue);

 UpdCheckButton.Visible := Value;
 UpdProgressBar.Visible := Value;
 UpdDownloadButton.Visible := Value;
 UpdStatus.Visible := Value;
 UpdInfo.Visible := Value;
 UpdText.Visible := Value;
 UpdRTF.Visible := Value;
end;

Procedure UpdDownloadButtonClick(Sender: TObject);
begin
 idpAddFile(NewVersionURL, NewInstallerPath);
 idpSetInternalOption('allowcontinue', 'yes');
 idpSetInternalOption('connecttimeout', '3000');
 IDPInitializeDownload(UpdaterPage, @UpdaterOnDownloadFinished);
 SetUpdaterPageVisibility(False, True);
end;

Procedure UpdaterPageOnActivate(Sender: TWizardPage);
begin
 SetUpdaterPageVisibility(True, True);
end;

Function UpdatePageOnBackButtonClick(Sender: TWizardPage): Boolean;
begin
 Result := True;
 SetUpdaterPageVisibility(False, False);
end;

Function UpdatePageOnNextButtonClick(Sender: TWizardPage): Boolean;
begin
 Result := True;
 SetUpdaterPageVisibility(False, False);
end;

Procedure InitializeUpdaterPage();
var
 ChangelogFilename: String;
 ChangelogTextAnsi: AnsiString;
begin
 UpdaterPage := CreateCustomPage(WelcomePage.ID, '', '');
 with UpdaterPage do
 begin
  OnActivate := @UpdaterPageOnActivate;
  OnBackButtonClick := @UpdatePageOnBackButtonClick;
  OnNextButtonClick := @UpdatePageOnNextButtonClick;
 end;

 UpdPageImg := ImgLoad(WizardForm.Handle, 'pageUpdates.png', 0, 0, WizardForm.ClientWidth, WizardForm.ClientHeight, True, True);
 UpdPageNameImg := ImgLoad(WizardForm.Handle, Format('pageUpdatesName_%s.png', [ActiveLanguage()]), ScaleX(5), ScaleY(7), ScaleX(460), ScaleY(70), True, False);

 UpdCheckButton := TNewButton.Create(UpdaterPage);
 with UpdCheckButton do
 begin
  Parent := WizardForm;
  SetBounds(ScaleX(19), ScaleY(100), ScaleX(100), ScaleY(25));
  Caption := CustomMessage('updCheckButtonText');
  Font.Style := [fsBold];
  OnClick := @UpdCheckButtonClick;
 end;

 UpdProgressBar := TNewProgressBar.Create(UpdaterPage);
 with UpdProgressBar do
 begin
  Parent := WizardForm;
  SetBounds(UpdCheckButton.Left + UpdCheckButton.Width + ScaleX(10), ScaleY(102), ScaleX(505), ScaleY(21));
  Min := 0;
  Max := 100;
  Position := 0;
 end;

 UpdDownloadButton := TNewButton.Create(UpdaterPage);
 with UpdDownloadButton do
 begin
  Parent := WizardForm;
  SetBounds(UpdProgressBar.Left + UpdProgressBar.Width + ScaleX(10), ScaleY(100), ScaleX(100), ScaleY(25));
  Caption := CustomMessage('updDownloadButtonText');
  Font.Style := [fsBold];
  Enabled := False;
  OnClick := @UpdDownloadButtonClick;
 end;

 UpdStatus := TLabel.Create(UpdaterPage);
 with UpdStatus do
 begin
  Parent := WizardForm;
  SetBounds(ScaleX(50), ScaleY(140), 0, 0);
  AutoSize := True;
  Transparent := True;
  Caption := CustomMessage('updStatusLabelText');
  Font.Size := 11;
  Font.Style := [fsBold];
 end;

 UpdInfo := TLabel.Create(UpdaterPage);
 with UpdInfo do
 begin
  Parent := WizardForm;
  SetBounds(ScaleX(60), ScaleY(165), WizardForm.ClientWidth, ScaleY(50));
  AutoSize := False;
  WordWrap := True;
  Transparent := True;
  Font.Size := 9;
  Caption := CustomMessage('updInfoLabelTextDefault');
 end;

 UpdText := TLabel.Create(UpdaterPage);
 with UpdText do
 begin
  Parent := WizardForm;
  SetBounds(ScaleX(18), UpdInfo.Top + UpdInfo.Height + ScaleY(15), 0, 0);
  AutoSize := True;
  Transparent := True;
  Caption := CustomMessage('updTextLabelDefault');
  Font.Style := [fsBold];
  Font.Size := 11;
 end;

 UpdRTF := TRichEditViewer.Create(UpdaterPage);
 with UpdRTF do
 begin
  Parent := WizardForm;
  SetBounds(ScaleX(18), UpdText.Top + ScaleY(25), WizardForm.ClientWidth - ScaleX(37), ScaleY(225));
  ScrollBars := ssVertical;
  ReadOnly := True;
  Font.Size := 10;
 end;

 ChangelogFilename := Format('changelog_%s.txt', [ActiveLanguage()]);
 ExtractTemporaryFile(ChangelogFilename);
 LoadStringFromFile(ExpandConstant('{tmp}\' + ChangelogFilename), ChangelogTextAnsi);
 ChangelogText := ' ' + Utf8ToAnsi(ChangelogTextAnsi);

 SetUpdaterPageVisibility(False, False);

 if not CMDCheckParams(CMD_Silent) or not CMDCheckParams(CMD_Updated) then
  UpdCheckButtonClick(nil);
end;
