// © _McClayn, 2020-now justsherlock LITE \\

[Code]
Var
 WelcomePage: TWizardPage;
 WelcomePageTextPatchLesta, WelcomePageTextGame: TLabel;          // WelcomePageTextPatchWG
 WelcomePageImg, WelcomePageNameImg: Longint;

Procedure SetWelcomePageVisibility(Value: Boolean);
begin
 ImgSetVisibility(WelcomePageImg, Value);
 ImgSetVisibility(WelcomePageNameImg, Value);
 WizardForm.BackButton.Visible := not Value;
 WelcomePageTextPatchLesta.Visible := Value;
 //WelcomePageTextPatchWG.Visible := Value;
 WelcomePageTextGame.Visible := Value; // False
end;

Procedure WelcomePageOnActivate(Sender: TWizardPage);
begin
 SetWelcomePageVisibility(True);
end;

Function WelcomePageOnNextButtonClick(Sender: TWizardPage): Boolean;
begin
  // check for installed modpack
  //checkInstalled();
  {if checkUpdates() = False then
    begin
      Result := False;
    end else
    begin
      Result := checkInstalled(); // check for game running moved in DirPage
      if Result then
        SetWelcomePageVisibility(False);
    end;}
  //Result := {#ifdef CheckForGameRun}CheckForGameRun(WizardForm.Handle){#else}True{#endif};
  Result := checkInstalled(); // check for game running moved in DirPage
    if Result then
      SetWelcomePageVisibility(False);
end;

Procedure InitializeWelcomePage();
var
hcur: Cardinal;
begin
 WelcomePage := CreateCustomPage(wpWelcome, '', '');
 with WelcomePage do
 begin
  OnActivate := @WelcomePageOnActivate;
  OnNextButtonClick := @WelcomePageOnNextButtonClick;
 end;

 //WelcomePageImg := ImgLoad(WizardForm.Handle, 'pageWelcome.png', 0, 0, WizardForm.ClientWidth, WizardForm.ClientHeight, True, True);
 WelcomePageImg := ImgLoad(WizardForm.Handle, Format('pageWelcome_%s.png', [ActiveLanguage()]), 0, 0, WizardForm.ClientWidth, WizardForm.ClientHeight, True, True);
 WelcomePageNameImg := ImgLoad(WizardForm.Handle, Format('pageWelcomeName_%s.png', [ActiveLanguage()]), ScaleX(5), ScaleY(7), ScaleX(460), ScaleY(70), True, False);

 // text in page
 WelcomePageTextGame := TLabel.Create(WizardForm);
 with WelcomePageTextGame do
 begin
  Parent := WizardForm;
  SetBounds(ScaleX(117), ScaleY(338), 0, 0);
  Font.Name := 'Russo One';
  Font.Size := 50;
  Font.Style := [fsBold];
  Font.Color := $DCDCDB;
  Caption := CustomMessage('welcomePageTextGame');  // version game 1.22  1.23  1.24  2.10
 end;
 WelcomePageTextPatchLesta := TLabel.Create(WizardForm);
 with WelcomePageTextPatchLesta do
 begin
  Parent := WizardForm;
  SetBounds(ScaleX(506), ScaleY(326), 0, 0);  // 561   327
  Font.Name := 'Russo One';
  Font.Size := 16;
  Font.Style := [fsBold];
  Font.Color := $DCDCDB;
  Caption := CustomMessage('welcomePageTextPatchLesta');  // patch version 1.22.0.0  1.22.1.0  1.23.3.0
 end;
 {with WelcomePageTextGame do
 begin
  Parent := WizardForm;
  SetBounds(ScaleX(491), ScaleY(18), 0, 0);  //    ScaleX(80), ScaleY(340), 0, 0    SetBounds(ScaleX(134), ScaleY(340), 0, 0);
  Font.Name := 'Warhelios-Bold_Web';
  Font.Size := 20;                            // Font.Size := 46;
  Font.Style := [fsBold];
  Font.Color := $DCDCDB;
  Caption := CustomMessage('welcomePageTextGame');  // version game 1.22  1.23  1.24  2.10
 end;
 WelcomePageTextPatchLesta := TLabel.Create(WizardForm);
 with WelcomePageTextPatchLesta do
 begin
  Parent := WizardForm;
  SetBounds(ScaleX(514), ScaleY(296), 0, 0);
  Font.Name := 'Warhelios-Bold_Web';  // Russo One
  Font.Size := 20;
  Font.Style := [fsBold];
  Font.Color := $DCDCDB;
  Caption := CustomMessage('welcomePageTextPatchLesta');  // patch version 1.22.0.0  1.22.1.0  1.23.3.0
 end; }
 {WelcomePageTextPatchWG := TLabel.Create(WizardForm);
 with WelcomePageTextPatchWG do
 begin
  Parent := WizardForm;
  SetBounds(ScaleX(514), ScaleY(334), 0, 0);
  Font.Name := 'Warhelios-Bold_Web';  // Russo One
  Font.Size := 20;
  Font.Style := [fsBold];
  Font.Color := $DCDCDB;
  Caption := CustomMessage('welcomePageTextPatchWG');  // patch version 1.22.0.0  1.22.1.0  1.23.3.0
 end;  }
 

 SetWelcomePageVisibility(False);
end;