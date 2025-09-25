// © _McClayn, 2020-now LITE justsherlock \\
#define Updater
#include "customPages\updater\compareVersion.iss"

[Files]
Source: "files\JshMp.png"; Flags: dontcopy noencryption nocompression;
Source: "files\JshMp_en.png"; Flags: dontcopy noencryption nocompression;

[Code]

var
  //CustomForm: TSetupForm;
  NewInstallerPath, NewVersionURL, ItemsBlackList: String;
  //UploadProgressBar: TNewProgressBar;

procedure LangChange(Sender : TObject);
var
i : integer;
begin
  i := SelectLanguageForm.LangCombo.ItemIndex;
  case TNewComboBox(Sender).ItemIndex of
   0: begin
    with SelectLanguageForm do begin
     SelectLabel.Caption := 'Select language, which will use at installing process:';
     CancelButton.Caption := 'Cancel';
     Caption := 'Select setup language';
    end;
   end;
   1: begin
    with SelectLanguageForm do begin
     SelectLabel.Caption := 'Выберите язык, который будет использован в процессе установки:';
     CancelButton.Caption := 'Отмена';
     Caption := 'Выберите язык установки';
    end;
   end;
  end;
end;


// splash screen
procedure ShowSplashScreen(p1:HWND;p2:AnsiString;p3,p4,p5,p6,p7:integer;p8:boolean;p9:Cardinal;p10:integer);
external 'ShowSplashScreen@files:isgsg.dll stdcall delayload';


// всплывающее окно рекламы
procedure Splash();
begin
  if ActiveLanguage() = 'en' then
    begin
      ExtractTemporaryFile('JshMp_en.png');  // JshMp.png
      ShowSplashScreen(WizardForm.Handle,ExpandConstant('{tmp}\JshMp_en.png'),1000,3000,1000,0,255,True,$FFFFFF,10);    // {tmp}\JshMp.png
    end else
    begin
      ExtractTemporaryFile('JshMp.png');  // JshMp.png
      ShowSplashScreen(WizardForm.Handle,ExpandConstant('{tmp}\JshMp.png'),1000,3000,1000,0,255,True,$FFFFFF,10);    // {tmp}\JshMp.png
    end;
end;


// MsgBox with custom buttons
function CustomMsgBox(Sender: TObject; MessageText, LabelText, FirstButton, SecondButton: String): Integer;
var
  Form: TSetupForm;
  YesButton, NoButton: TNewButton;
  MesssageLabel: TLabel;
begin
  Form := CreateCustomForm;
  Form.BorderStyle := bsDialog;
  //Form.Position := poOwnerFormCenter;
  Form.CenterInsideControl(WizardForm, False);
  Form.ClientWidth := ScaleX(400);
  Form.ClientHeight := ScaleY(140); // 130
  Form.Caption := LabelText;

  MesssageLabel := TLabel.Create(Form);
  MesssageLabel.Parent := Form;
  MesssageLabel.Left := ScaleX(16);
  MesssageLabel.Top := ScaleX(16);
  MesssageLabel.Width := Form.ClientWidth - 2*ScaleX(16);
  MesssageLabel.Height := ScaleY(64); // 32
  MesssageLabel.AutoSize := False;
  MesssageLabel.WordWrap := True;
  MesssageLabel.Caption := MessageText;

  YesButton := TNewButton.Create(Form);
  YesButton.Parent := Form;
  YesButton.Width := ScaleX(80);
  YesButton.Height := ScaleY(24);
  YesButton.Left := Form.ClientWidth - 2 * (YesButton.Width + ScaleX(8));
  YesButton.Top := Form.ClientHeight - YesButton.Height - ScaleY(8);
  YesButton.Caption := '&'+FirstButton; //'&Yes';
  YesButton.ModalResult := mrYes;

  NoButton := TNewButton.Create(Form);
  NoButton.Parent := Form;
  NoButton.Width := YesButton.Width;
  NoButton.Height := YesButton.Height;
  NoButton.Left := YesButton.Left + YesButton.Width + ScaleX(8);
  NoButton.Top := YesButton.Top;
  NoButton.Caption := '&'+SecondButton; //'&No';
  NoButton.ModalResult := mrNo;
  NoButton.Cancel := True;

  Result := Form.ShowModal;
end;


{Function UpdaterOnDownloadFinished(): Boolean;
var
  ResCode: Integer;
begin
  if (idpFilesCount() > 0) and idpFileDownloaded(NewVersionURL) then
    begin
      Result := False;
      Exec(NewInstallerPath, CMD_Updated, '', SW_SHOW, ewNoWait, ResCode);
      Application.Terminate();
    end;
end;}

Procedure DownloadClick(); // Sender: TObject
var
  ResCode: Integer;
begin
  {idpAddFile(NewVersionURL, NewInstallerPath);
  idpSetInternalOption('allowcontinue', 'yes');
  idpSetInternalOption('connecttimeout', '3000');
  IDPInitializeDownload(CustomForm, @UpdaterOnDownloadFinished);}
  Exec('cmd.exe', '/C start '+NewVersionURL, '', SW_SHOW, ewNoWait, ResCode);
  Application.Terminate();
end;

// CustomForm 
function CustomForm(Sender: TObject; NewVersionURL, NewInstallerPath: String): Integer;
var
  Form: TSetupForm;
  OkButton, CancelButton: TNewButton;
  UploadProgressBar: TNewProgressBar;
begin
  Form := CreateCustomForm;
  Form.BorderStyle := bsDialog;
  //Form.Position := poOwnerFormCenter;
  Form.CenterInsideControl(WizardForm, False);
  Form.ClientWidth := ScaleX(400);
  Form.ClientHeight := ScaleY(100); // 130
  Form.Caption := 'Downloader';

  OkButton := TNewButton.Create(Form);
  OkButton.Parent := Form;
  OkButton.Width := ScaleX(80);
  OkButton.Height := ScaleY(24);
  OkButton.Left := Form.ClientWidth - 2 * (OkButton.Width + ScaleX(8));
  OkButton.Top := Form.ClientHeight - OkButton.Height - ScaleY(8);
  OkButton.Caption := '&Yes';
  OkButton.ModalResult := mrYes;
  //OkButton.OnClick := @DownloadClick;
  //OkButton.Visible := False;

  UploadProgressBar := TNewProgressBar.Create(Form);
  with UploadProgressBar do
  begin
    Parent := Form;
    //SetBounds(UpdCheckButton.Left + UpdCheckButton.Width + ScaleX(10), ScaleY(102), ScaleX(505), ScaleY(21));
    SetBounds(ScaleX(16), ScaleY(16), Form.ClientWidth - 2*ScaleX(16), ScaleY(21));
    Min := 0;
    Max := 100;
    Position := 100;
  end;

  CancelButton := TNewButton.Create(Form);
  CancelButton.Parent := Form;
  CancelButton.Width := OkButton.Width;
  CancelButton.Height := OkButton.Height;
  CancelButton.Left := OkButton.Left + OkButton.Width + ScaleX(8);
  CancelButton.Top := OkButton.Top;
  CancelButton.Caption := '&Cancel';
  CancelButton.ModalResult := mrCancel;
  CancelButton.Cancel := True;

  Result := Form.ShowModal;
end;


Function checkUpdates(): Boolean;
var
  UpdFile, UpdFileData, UpdVersion, UpdChanges: String;
begin
  Result:= True;
  try
    UpdFile := ExpandConstant('{tmp}\updaterServer.xml');
    if idpDownloadFile('{#UpdatesURL}' + 'updaterServer.xml', UpdFile) and XMLFileReadValue(UpdFile, 'updaterServer.xml\' + '{#Type}\' + ActiveLanguage(), UpdFileData) then
    begin
      XMLStringReadValue(UpdFileData, 'version', False, UpdVersion);
      XMLStringReadValue(UpdFileData, 'downloadLink', False, NewVersionURL);
      XMLStringReadValue(UpdFileData, 'modsBlackList', False, ItemsBlackList);
      StringChange(NewVersionURL, 'ver', UpdVersion);

      case CompareVersion(Trim(UpdVersion), '{#Version}') of
        NewVersionAvailable:
          begin
            XMLStringReadValue(UpdFileData, 'changes', False, UpdChanges);
            //MsgBox(Format(CustomMessage('updInfoLabelTextVersionAvailable'), [UpdVersion]), mbInformation, MB_OK);
            NewInstallerPath := ExpandConstant('{userdesktop}\{#AppShortName}-' + UpdVersion + '.exe');
            if CustomMsgBox(WizardForm.Handle,
              Format(CustomMessage('updInfoLabelTextVersionAvailable'), [UpdVersion]),
              CustomMessage('updStatusLabelText'), CustomMessage('updDownloadButtonText'), CustomMessage('updCancelButtonText')) = mrYes then
            begin
              //CustomForm(WizardForm.Handle, NewVersionURL, NewInstallerPath);
              DownloadClick();
              Result:= False;
            end;
          end;
        BetaVersion:
          begin
            //MsgBox(Format(CustomMessage('updInfoLabelTextVersionBeta'), [UpdVersion]), mbInformation, MB_OK);
            {CustomMsgBox(WizardForm.Handle,
              Format(CustomMessage('updInfoLabelTextVersionBeta'), [UpdVersion]),
              CustomMessage('updStatusLabelText'), 'OK', CustomMessage('updCancelButtonText'));}
          end;
        VersionIsActual:
          begin
            //MsgBox(CustomMessage('updInfoLabelVersionActual'), mbInformation, MB_OK);
            {CustomMsgBox(WizardForm.Handle,
              Format(CustomMessage('updInfoLabelVersionActual'), [UpdVersion]),
              CustomMessage('updStatusLabelText'), 'Next', CustomMessage('updCancelButtonText'));}
          end;
      end;
    end else
      begin
        //MsgBox(CustomMessage('updInfoLabelServerFailText'), mbError, MB_OK);
        {CustomMsgBox(WizardForm.Handle,
          Format(CustomMessage('updInfoLabelServerFailText'), [UpdVersion]),
          CustomMessage('updStatusLabelText'), 'OK', CustomMessage('updCancelButtonText')); }
      end;
  except
    MsgBoxEx(WizardForm.Handle, GetExceptionMessage(), '{#__FILE__}: {#__LINE__}', MB_OK or MB_ICONERROR, 0 ,0);
    //MsgBox(CustomMessage('updInfoLabelVersionFailText'), mbError, MB_OK);
    {CustomMsgBox(WizardForm.Handle,
      Format(CustomMessage('updInfoLabelVersionFailText'), [UpdVersion]),
      CustomMessage('updStatusLabelText'), 'Ok', 'Cancel'); }
  end;
end;


// check for installed modpack (version)
Function checkInstalled(): Boolean;
var
  RootKey, ErrorCode, NewDisplayVersion: Integer;
  AppId, UninstallKey, exeVersion, DisplayVersion, QuietUninstallString, DisplayName, UninstallString, newExeVersion: string;
  EstimatedSizeOrig, EstimatedSize: Cardinal;
begin
  Result:= True;
  AppId := '{#SetupSetting("AppId")}';
  // Just in case there's a curly bracket in the AppId
  StringChange(AppId, '{{', '{');
  UninstallKey := 'SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\' + AppId + '_is1';
  RootKey := HKLM;
  //exeVersion := '{#Version}';
  if (RegQueryStringValue(RootKey, UninstallKey, 'DisplayVersion', DisplayVersion)
    and RegQueryStringValue(RootKey, UninstallKey, 'DisplayName', DisplayName)
    and RegQueryStringValue(RootKey, UninstallKey, 'UninstallString', UninstallString)
    and RegQueryStringValue(RootKey, UninstallKey, 'QuietUninstallString', QuietUninstallString)) then  // QuietUninstallString
  begin
    if DisplayVersion<>'{#GameShortName} 1.32.0.0' then
      begin
        exeVersion := DisplayVersion;
      end else
      begin
        exeVersion := Copy(DisplayName, Pos('(', DisplayName), Pos(')', DisplayName));
      end;

    StringChange(exeVersion, '(', '');
    StringChange(exeVersion, ')', '');

    // check for current NEW or OLD version
    newExeVersion := '{#Version}';
    StringChange(newExeVersion, '.', '');
    if StrToInt(exeVersion) <> StrToInt(newExeVersion) then
      begin
        // 'У Вас уже установлен '+DisplayName+' (ver. '+exeVersion+'). Для продолжения установки необходимо удалить предыдущую версию.'+#13#10+'Нажмите "Да", чтобы выйти из программы установки и запустить автоматическое удаление уже установленной версии модпака.'+#13#10+#13#10+'Деинсталлятор: '+UninstallString
        if MsgBox(FmtMessage(CustomMessage('checkInstalledMessage'), [DisplayName, exeVersion, UninstallString]),
          mbConfirmation, MB_YESNO) = IDYES then
          begin
            Result:= False;
            Application.Terminate();
            Exec('cmd.exe', '/C '+Copy(QuietUninstallString, 0, Pos('/', QuietUninstallString))+' /SILENT', '', SW_SHOW, ewNoWait, ErrorCode);
          end else
          begin
            Result:= False;
          end;
      end;
  end; 
end;



{exeVersion := DisplayVersion;
    StringChange(DisplayVersion, '.', '');
    try
      NewDisplayVersion := StrToInt(Trim(DisplayVersion));
    except
      exeVersion := Copy(DisplayName, Pos('(', DisplayName), Pos(')', DisplayName));
    end; }

////MsgBoxEx(0, 'Найдена установленная версия модпака ('+QuietUninstallString+'). При продолжении установки предыдущая версия будет удалена', SetupMessage(msgInformationTitle), MB_ICONINFORMATION or MB_OK, 0, 0);
    ////MsgBox('Найдена уже установленная версия ('+DisplayVersion+') модпака. Для продолжения установки необходимо удалить предыдущую версию.', mbError, MB_OK);
    //MsgBoxEx(WizardForm.Handle,
    //  'Найдена уже установленная версия модпака (ver. '+DisplayVersion+').'+#13#10+'Для продолжения установки необходимо удалить предыдущую версию. '+#13#10+#13#10+'Деинсталлятор: '+Copy(QuietUninstallString, 0, Pos('/', QuietUninstallString)),
    //  CustomMessage('warning'), MB_ICONWARNING or MB_OK, 0, 0);
    //MsgBox('У Вас уже установлена версия модпака JustSherlock - ver. '+exeVersion+'. Для продолжения установки необходимо удалить предыдущую версию.'+#13#10+'Нажмите "Да", чтобы выйти из программы установки и запустить автоматическое удаление уже установленной версии модпака.'+#13#10+#13#10+'Деинсталлятор: '+UninstallString,
    //  mbConfirmation, MB_YESNO) = IDYES


// delete old version
    //Exec('cmd.exe', '/C "D:\Tanki\JustSherlock Modpack\unins000.exe" /SILENT', '', SW_SHOW, ewNoWait, ErrorCode); // ewWaitUntilTerminated
    //ShellExec('', 'unins000.exe', '/SILENT', ExpandConstant('D:\Tanki\JustSherlock Modpack\'), SW_SHOW, ewNoWait, ErrorCode);