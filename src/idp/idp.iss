#include "..\l10n\cm_idp.iss"

[Files]
Source: "src\idp\idp.dll"; Flags: dontcopy nocompression

[Code]
procedure idpAddFile(url, filename: String);                     external 'idpAddFile@files:idp.dll cdecl';
procedure idpAddFileComp(url, filename, components: String);     external 'idpAddFileComp@files:idp.dll cdecl';
procedure idpAddMirror(url, mirror: String);                     external 'idpAddMirror@files:idp.dll cdecl';
procedure idpAddFtpDir(url, mask, destdir: String; recursive: Boolean); external 'idpAddFtpDir@files:idp.dll cdecl';
procedure idpAddFtpDirComp(url, mask, destdir: String; recursive: Boolean; components: String); external 'idpAddFtpDirComp@files:idp.dll cdecl';
procedure idpClearFiles();                                       external 'idpClearFiles@files:idp.dll cdecl';
function  idpFilesCount(): Integer;                              external 'idpFilesCount@files:idp.dll cdecl';
function  idpFtpDirsCount(): Integer;                            external 'idpFtpDirsCount@files:idp.dll cdecl';
function  idpFileDownloaded(url: String): Boolean;               external 'idpFileDownloaded@files:idp.dll cdecl';
function  idpFilesDownloaded(): Boolean;                         external 'idpFilesDownloaded@files:idp.dll cdecl';
function  idpDownloadFile(url, filename: String): Boolean;       external 'idpDownloadFile@files:idp.dll cdecl';
function  idpDownloadFiles(): Boolean;                           external 'idpDownloadFiles@files:idp.dll cdecl';
function  idpDownloadFilesComp(): Boolean;                       external 'idpDownloadFilesComp@files:idp.dll cdecl';
function  idpDownloadFilesCompUi(): Boolean;                     external 'idpDownloadFilesCompUi@files:idp.dll cdecl';
procedure idpStartDownload();                                    external 'idpStartDownload@files:idp.dll cdecl';
procedure idpStopDownload();                                     external 'idpStopDownload@files:idp.dll cdecl';
procedure idpSetLogin(login, password: String);                  external 'idpSetLogin@files:idp.dll cdecl';
procedure idpSetProxyMode(mode: String);                         external 'idpSetProxyMode@files:idp.dll cdecl';
procedure idpSetProxyName(name: String);                         external 'idpSetProxyName@files:idp.dll cdecl';
procedure idpSetProxyLogin(login, password: String);             external 'idpSetProxyLogin@files:idp.dll cdecl';
procedure idpConnectControl(name: String; Handle: HWND);         external 'idpConnectControl@files:idp.dll cdecl';
procedure idpAddMessage(name, message: String);                  external 'idpAddMessage@files:idp.dll cdecl';
procedure idpSetInternalOption(name, value: String);             external 'idpSetInternalOption@files:idp.dll cdecl';
procedure idpSetDetailedMode(mode: Boolean);                     external 'idpSetDetailedMode@files:idp.dll cdecl';
procedure idpSetComponents(components: String);                  external 'idpSetComponents@files:idp.dll cdecl';
procedure idpReportError();                                      external 'idpReportError@files:idp.dll cdecl';
procedure idpTrace(text: String);                                external 'idpTrace@files:idp.dll cdecl';

procedure idpAddFileSize(url, filename: String; size: DWORD);    external 'idpAddFileSize32@files:idp.dll cdecl';
procedure idpAddFileSizeComp(url, filename: String; size: DWORD; components: String); external 'idpAddFileSize32@files:idp.dll cdecl';
function idpGetFileSize(url: String; var size: DWORD): Boolean; external 'idpGetFileSize32@files:idp.dll cdecl';
function idpGetFilesSize(var size: DWORD): Boolean;             external 'idpGetFilesSize32@files:idp.dll cdecl';

Type
 TOnDownloadFinishedFunc = function(): Boolean;

Var
 IDPOnDownloadFinished: TOnDownloadFinishedFunc;
 TotalProgressBar  : TNewProgressBar;
 FileProgressBar   : TNewProgressBar;
 TotalProgressLabel: TNewStaticText;
 CurrentFileLabel  : TNewStaticText;
 TotalDownloaded   : TNewStaticText;
 FileDownloaded    : TNewStaticText;
 FileNameLabel     : TNewStaticText;
 SpeedLabel        : TNewStaticText;
 StatusLabel       : TNewStaticText;
 ElapsedTimeLabel  : TNewStaticText;
 RemainingTimeLabel: TNewStaticText;
 FileName          : TNewStaticText;
 Speed             : TNewStaticText;
 Status            : TNewStaticText;
 ElapsedTime       : TNewStaticText;
 RemainingTime     : TNewStaticText;
 InvisibleButton   : TNewButton;

Procedure IDPSetControlsVisibility(const Value: Boolean);
begin
 TotalProgressBar.Visible   := Value;
 FileProgressBar.Visible    := Value;
 TotalProgressLabel.Visible := Value;
 CurrentFileLabel.Visible   := Value;
 TotalDownloaded.Visible    := Value;
 FileDownloaded.Visible     := Value;
 FileNameLabel.Visible      := Value;
 SpeedLabel.Visible         := Value;
 StatusLabel.Visible        := Value;
 ElapsedTimeLabel.Visible   := Value;
 RemainingTimeLabel.Visible := Value;
 FileName.Visible           := Value;
 Speed.Visible              := Value;
 Status.Visible             := Value;
 ElapsedTime.Visible        := Value;
 RemainingTime.Visible      := Value;

 if Value then
  idpSetDetailedMode(True);
end;

Procedure IDPActivate();
begin
 if CMDCheckParams('/WIZARDVERYSILENT') then
  Exit;

 idpSetInternalOption('RetryButton', '0')
 IDPSetControlsVisibility(True);
 idpStartDownload();
end;

Procedure IDPDeactivate();
begin
 IDPSetControlsVisibility(False);

 idpClearFiles();
end;

Procedure IDPOnCancelButtonClick(DownloadPage: TWizardPage; var Cancel, Confirm: Boolean);
begin
 if ExitSetupMsgBox() then
 begin
  Status.Caption := ExpandConstant('{cm:IDP_CancellingDownload}');
  WizardForm.Repaint;
  idpStopDownload();
  Cancel := True;
  Confirm := False;
 end else
  Cancel := False;
end;

Function IDPOnBackButtonClick(DownloadPage: TWizardPage): Boolean;
begin
 Result := False;
end;

Function IDPOnNextButtonClick(DownloadPage: TWizardPage): Boolean;
begin
 Result := IDPOnDownloadFinished();
end;

Procedure idpReportErrorHelper(Sender: TObject);
begin
 idpReportError(); //calling idpReportError in main thread for compatibility with VCL Styles for IS
end;

Procedure IDPInitDownloadControls(var ADownloadPage: TWizardPage);
begin
 TotalProgressBar := TNewProgressBar.Create(ADownloadPage);
 with TotalProgressBar do
 begin
  Parent := WizardForm;
  SetBounds(ScaleX(15), ScaleY(120), WizardForm.Width - ScaleX(41), ScaleY(20));
  Min := 0;
  Max := 100;
 end;

 TotalProgressLabel := TNewStaticText.Create(ADownloadPage);
 with TotalProgressLabel do
 begin
  Parent := WizardForm;
  Caption := ExpandConstant('{cm:IDP_TotalProgress}');
  SetBounds(ScaleX(15), ScaleY(104), ScaleX(200), ScaleY(15));
  AutoSize := False;
  Font.Style := [fsBold];
 end;

 CurrentFileLabel := TNewStaticText.Create(ADownloadPage);
 with CurrentFileLabel do
 begin
  Parent := WizardForm;
  Caption := ExpandConstant('{cm:IDP_CurrentFile}');
  SetBounds(ScaleX(15), ScaleY(152), ScaleX(200), ScaleY(15));
  AutoSize := False;
  Font.Style := [fsBold];
 end;

 FileProgressBar := TNewProgressBar.Create(ADownloadPage);
 with FileProgressBar do
 begin
  Parent := WizardForm;
  SetBounds(TotalProgressBar.Left, ScaleY(168), TotalProgressBar.Width, TotalProgressBar.Height);
  Min := 0;
  Max := 100;
 end;

 TotalDownloaded := TNewStaticText.Create(ADownloadPage);
 with TotalDownloaded do
 begin
  Parent := WizardForm;
  Caption := '';
  SetBounds(ScaleX(645), ScaleY(104), ScaleX(100), ScaleY(15));
  AutoSize := False;
  Font.Style := [fsBold];
 end;

 FileDownloaded := TNewStaticText.Create(ADownloadPage);
 with FileDownloaded do
 begin
  Parent := WizardForm;
  Caption := '';
  SetBounds(ScaleX(645), ScaleY(152), ScaleX(100), ScaleY(15));
  AutoSize := False;
  Font.Style := [fsBold];
 end;

 FileNameLabel := TNewStaticText.Create(ADownloadPage);
 with FileNameLabel do
 begin
  Parent := WizardForm;
  Caption := ExpandConstant('{cm:IDP_File}');
  SetBounds(ScaleX(15), ScaleY(236), ScaleX(200), ScaleY(15));
  AutoSize := False;
 end;

 SpeedLabel := TNewStaticText.Create(ADownloadPage);
 with SpeedLabel do
 begin
  Parent := WizardForm;
  Caption := ExpandConstant('{cm:IDP_Speed}');
  SetBounds(ScaleX(15), ScaleY(252), ScaleX(200), ScaleY(15));
  AutoSize := False;
 end;

 StatusLabel := TNewStaticText.Create(ADownloadPage);
 with StatusLabel do
 begin
  Parent := WizardForm;
  Caption := ExpandConstant('{cm:IDP_Status}');
  SetBounds(ScaleX(15), ScaleY(268), ScaleX(200), ScaleY(15));
  AutoSize := False;
 end;

 ElapsedTimeLabel := TNewStaticText.Create(ADownloadPage);
 with ElapsedTimeLabel do
 begin
  Parent := WizardForm;
  Caption := ExpandConstant('{cm:IDP_ElapsedTime}');
  SetBounds(ScaleX(15), ScaleY(284), ScaleX(200), ScaleY(15));
  AutoSize := False;
 end;

 RemainingTimeLabel := TNewStaticText.Create(ADownloadPage);
 with RemainingTimeLabel do
 begin
  Parent := WizardForm;
  Caption := ExpandConstant('{cm:IDP_RemainingTime}');
  SetBounds(ScaleX(15), ScaleY(300), ScaleX(200), ScaleY(15));
  AutoSize := False;
 end;

 FileName := TNewStaticText.Create(ADownloadPage);
 with FileName do
 begin
  Parent := WizardForm;
  Caption := '';
  SetBounds(ScaleX(135), ScaleY(236), ScaleX(200), ScaleY(15));
  AutoSize := False;
 end;

 Speed := TNewStaticText.Create(ADownloadPage);
 with Speed do
 begin
  Parent := WizardForm;
  Caption := '';
  SetBounds(ScaleX(135), ScaleY(252), ScaleX(200), ScaleY(15));
  AutoSize := False;
 end;

 Status := TNewStaticText.Create(ADownloadPage);
 with Status do
 begin
  Parent := WizardForm;
  Caption := '';
  SetBounds(ScaleX(135), ScaleY(268), ScaleX(200), ScaleY(15));
  AutoSize := False;
 end;

 ElapsedTime := TNewStaticText.Create(ADownloadPage);
 with ElapsedTime do
 begin
  Parent := WizardForm;
  Caption := '';
  SetBounds(ScaleX(135), ScaleY(284), ScaleX(200), ScaleY(15));
  AutoSize := False;
 end;

 RemainingTime := TNewStaticText.Create(ADownloadPage);
 with RemainingTime do
 begin
  Parent := WizardForm;
  Caption := '';
  SetBounds(ScaleX(135), ScaleY(300), ScaleX(200), ScaleY(15));
  AutoSize := False;
 end;

 InvisibleButton := TNewButton.Create(ADownloadPage);
 with InvisibleButton do
 begin
  Parent := WizardForm;
  Caption := '';
  SetBounds(ScaleX(0), ScaleY(0), ScaleX(10), ScaleY(10));
  TabOrder := 17;
  Visible := False;
  OnClick := @idpReportErrorHelper;
 end;
end;

Procedure idpConnectControls();
begin
 idpConnectControl('TotalProgressLabel', TotalProgressLabel.Handle);
 idpConnectControl('TotalProgressBar',   TotalProgressBar.Handle);
 idpConnectControl('FileProgressBar',    FileProgressBar.Handle);
 idpConnectControl('TotalDownloaded',    TotalDownloaded.Handle);
 idpConnectControl('FileDownloaded',     FileDownloaded.Handle);
 idpConnectControl('FileName',           FileName.Handle);
 idpConnectControl('Speed',              Speed.Handle);
 idpConnectControl('Status',             Status.Handle);
 idpConnectControl('ElapsedTime',        ElapsedTime.Handle);
 idpConnectControl('RemainingTime',      RemainingTime.Handle);
 idpConnectControl('InvisibleButton',    InvisibleButton.Handle);
 idpConnectControl('WizardPage',         WizardForm.Handle);
 idpConnectControl('WizardForm',         WizardForm.Handle);
 idpConnectControl('BackButton',         WizardForm.BackButton.Handle);
 idpConnectControl('NextButton',         WizardForm.NextButton.Handle);
 idpConnectControl('LabelFont',          TotalDownloaded.Font.Handle);
end;

Procedure idpInitMessages();
begin
 idpAddMessage('Total progress',              ExpandConstant('{cm:IDP_TotalProgress}'));
 idpAddMessage('KB/s',                        ExpandConstant('{cm:IDP_KBs}'));
 idpAddMessage('MB/s',                        ExpandConstant('{cm:IDP_MBs}'));
 idpAddMessage('%.2f of %.2f',                ExpandConstant('{cm:IDP_X_of_X}'));
 idpAddMessage('KB',                          ExpandConstant('{cm:IDP_KB}'));
 idpAddMessage('MB',                          ExpandConstant('{cm:IDP_MB}'));
 idpAddMessage('GB',                          ExpandConstant('{cm:IDP_GB}'));
 idpAddMessage('Initializing...',             ExpandConstant('{cm:IDP_Initializing}'));
 idpAddMessage('Getting file information...', ExpandConstant('{cm:IDP_GettingFileInformation}'));
 idpAddMessage('Starting download...',        ExpandConstant('{cm:IDP_StartingDownload}'));
 idpAddMessage('Connecting...',               ExpandConstant('{cm:IDP_Connecting}'));
 idpAddMessage('Downloading...',              ExpandConstant('{cm:IDP_Downloading}'));
 idpAddMessage('Download complete',           ExpandConstant('{cm:IDP_DownloadComplete}'));
 idpAddMessage('Download failed',             ExpandConstant('{cm:IDP_DownloadFailed}'));
 idpAddMessage('Cannot connect',              ExpandConstant('{cm:IDP_CannotConnect}'));
 idpAddMessage('Unknown',                     ExpandConstant('{cm:IDP_Unknown}'));
 idpAddMessage('Download cancelled',          ExpandConstant('{cm:IDP_DownloadCancelled}'));
 idpAddMessage('HTTP error %d',               ExpandConstant('{cm:IDP_HTTPError_X}'));
 idpAddMessage('400',                         ExpandConstant('{cm:IDP_400}'));
 idpAddMessage('401',                         ExpandConstant('{cm:IDP_401}'));
 idpAddMessage('404',                         ExpandConstant('{cm:IDP_404}'));
 idpAddMessage('407',                         ExpandConstant('{cm:IDP_407}'));
 idpAddMessage('500',                         ExpandConstant('{cm:IDP_500}'));
 idpAddMessage('502',                         ExpandConstant('{cm:IDP_502}'));
 idpAddMessage('503',                         ExpandConstant('{cm:IDP_503}'));
 idpAddMessage('Retry',                       ExpandConstant('{cm:IDP_RetryButton}'));
 idpAddMessage('Ignore',                      ExpandConstant('{cm:IDP_IgnoreButton}'));
 idpAddMessage('Cancel',                      SetupMessage(msgButtonCancel));
 idpAddMessage('The following files were not downloaded:', ExpandConstant('{cm:IDP_FilesNotDownloaded}'));
 idpAddMessage('Check your connection and click ''Retry'' to try downloading the files again, or click ''Next'' to continue installing anyway.', ExpandConstant('{cm:IDP_RetryNext}'));
 idpAddMessage('Check your connection and click ''Retry'' to try downloading the files again, or click ''Cancel'' to terminate setup.', ExpandConstant('{cm:IDP_RetryCancel}'));
end;

Procedure IDPInitializeDownload(var ADownloadPage: TWizardPage; AOnDownloadFinished: TOnDownloadFinishedFunc);
begin
 IDPInitDownloadControls(ADownloadPage);
 ADownloadPage.OnCancelButtonClick := @IDPOnCancelButtonClick;
 ADownloadPage.OnBackButtonClick := @IDPOnBackButtonClick;
 ADownloadPage.OnNextButtonClick := @IDPOnNextButtonClick;

 IDPOnDownloadFinished := AOnDownloadFinished;

 WizardForm.NextButton.Enabled := False;
 WizardForm.BackButton.Enabled := False;

 IDPActivate();

 idpConnectControls();
 idpInitMessages();
end;