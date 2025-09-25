// © _McClayn, 2020-now LITE justsherlock \\

[Code]
Var
 InstStatusLabel, InstProgressLabel, InstFilenameLabel, InstLabel: TLabel;
 InstallingPageImg, InstallingPageNameImg: Longint;

Procedure SetInstallingPageVisibility(const Value: Boolean);
begin
 ImgSetVisibility(InstallingPageImg, Value);
 ImgSetVisibility(InstallingPageNameImg, Value);
 InstStatusLabel.Visible := Value;
 InstProgressLabel.Visible := Value;
 WizardForm.ProgressGauge.Visible := Value;
 InstFilenameLabel.Visible := Value;
 InstLabel.Visible := Value;
end;

Procedure ShowInstallingPage();
begin
 SetInstallingPageVisibility(True);
end;

Procedure SetInstallStatus(const Status: String);
begin
 InstStatusLabel.Caption := CustomMessage(Status);
 InstFilenameLabel.Caption := ExpandConstant(CurrentFilename());
 InstProgressLabel.Caption := Format(CustomMessage('instProgressLabelText'), [(WizardForm.ProgressGauge.Position * 100) / WizardForm.ProgressGauge.Max]);
end;

Procedure InitializeInstallingPage();
begin
 InstallingPageImg := ImgLoad(WizardForm.Handle, 'pageInstalling.png', 0, 0, WizardForm.ClientWidth, WizardForm.ClientHeight, True, True);
 InstallingPageNameImg := ImgLoad(WizardForm.Handle, Format('pageInstallingName_%s.png', [ActiveLanguage()]), ScaleX(5), ScaleY(7), ScaleX(460), ScaleY(70), True, False);

 InstStatusLabel := TLabel.Create(WizardForm);
 with InstStatusLabel do
 begin
  Parent := WizardForm;
  SetBounds(ScaleX(15), ScaleY(93), 0, 0);
  AutoSize := True;
  Transparent := True;
  Font.Size := 11;
  Font.Style := [fsBold];
  Caption := WizardForm.StatusLabel.Caption;
 end;

 InstProgressLabel := TLabel.Create(WizardForm);
 with InstProgressLabel do
 begin
  Parent := WizardForm;
  SetBounds(WizardForm.ClientWidth - ScaleX(150), InstStatusLabel.Top, 0, 0);
  AutoSize := True;
  Transparent := True;
  Font.Size := 11;
  Font.Style := [fsBold];
 end;

 with WizardForm.ProgressGauge do
 begin
  Parent := WizardForm;
  SetBounds(ScaleX(15), InstStatusLabel.Top + InstStatusLabel.Height + ScaleY(10), WizardForm.ClientWidth - ScaleX(30), ScaleY(30));
 end;

 InstFilenameLabel := TLabel.Create(WizardForm);
 with InstFilenameLabel do
 begin
  Parent := WizardForm;
  SetBounds(InstStatusLabel.Left, WizardForm.ProgressGauge.Top + WizardForm.ProgressGauge.Height + ScaleY(10), WizardForm.ClientWidth - ScaleX(35), ScaleY(15));
  AutoSize := False;
  Transparent := True;
  Font.Size := 9;
  Font.Style := [fsBold];
  Caption := WizardForm.FilenameLabel.Caption;
 end;

 InstLabel := TLabel.Create(WizardForm);
 with InstLabel do
 begin
  Parent := WizardForm;
  SetBounds(InstFilenameLabel.Left, InstFilenameLabel.Top + InstFilenameLabel.Height + ScaleY(16), 0, 0);
  AutoSize := True;
  Transparent := True;
  Font.Size := 10;
  Font.Style := [fsBold];
  Caption := CustomMessage('instLabelText');
 end;

 SetInstallingPageVisibility(False);
end;
