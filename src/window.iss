// © _McClayn, 2020-2023 demo \\

[Files]
Source: "files\gui\*"; Flags: dontcopy;
;image size 320х23
Source: "files\gui\button_next.bmp"; DestDir: {tmp}; Flags: dontcopy

[Code]
Function GetDeviceCaps(hDC, nIndex: Integer): Integer; external 'GetDeviceCaps@GDI32 stdcall';
Function GetDC(HWND: DWord): DWord; external 'GetDC@user32.dll stdcall';

Const
 SCALE_100 = 96;
 SCALE_125 = 120;
 SCALE_150 = 144;
 SCALE_175 = 168;

Var
 ScaleFactor: Integer;
 BotvaFont: TFont;
 Background: Longint;
 // custom buttoms
 MyNextButton: TNewButton;
 MyPrevButton: TNewButton;
 ButtonPanel: TPanel;
 ButtonImage: TBitmapImage;
 ButtonLabel: TLabel;


Procedure InitializeWindow();
begin
 with WizardForm do
 begin
  ClientWidth := ScaleX(760);
  ClientHeight := ScaleY(545);
  OuterNotebook.Hide;
  InnerNotebook.Hide;
  Bevel.Hide;

  BackButton.SetBounds(ClientWidth - ScaleX(295), ClientHeight - ScaleY(38), BackButton.Width + ScaleX(5), BackButton.Height + ScaleY(3));
  NextButton.SetBounds(ClientWidth - ScaleX(195), ClientHeight - ScaleY(38), NextButton.Width + ScaleX(5), NextButton.Height + ScaleY(3));
  CancelButton.SetBounds(ClientWidth - ScaleX(95), ClientHeight - ScaleY(38), CancelButton.Width + ScaleX(5), CancelButton.Height + ScaleY(3));

  // create my custom buttons
  //HBackButton:= EffectTextureButton(WizardForm.Handle, WizardForm.BackButton, ExpandConstant('{tmp}\button_prev.bmp'), 0, nil, nil, nil);   // button_next
  //HNextButton:= EffectTextureButton(WizardForm.Handle, WizardForm.NextButton, ExpandConstant('{tmp}\button_prev.bmp'), 0, nil, nil, nil);   // button_next
  //HCancelButton:= EffectTextureButton(WizardForm.Handle, WizardForm.CancelButton, ExpandConstant('{tmp}\button_prev.bmp'), 0, nil, nil, nil); // button_prev
  ////HDirBrowseButton:= EffectTextureButton(WizardForm.Handle, WizardForm.DirBrowseButton, ExpandConstant('{tmp}\Button.png'), 18, nil, nil, nil)
  ////HGroupBrowseButton:= EffectTextureButton(WizardForm.Handle, WizardForm.GroupBrowseButton, ExpandConstant('{tmp}\Button.png'), 18, nil, nil, nil)

  Center();
 end;

 case GetDeviceCaps(GetDC(0), 88) of
  SCALE_100: ScaleFactor := 100;
  SCALE_125: ScaleFactor := 125;
  SCALE_150: ScaleFactor := 150;
  SCALE_175: ScaleFactor := 175;
 else
  ScaleFactor := 0;
 end;

 BotvaFont := TFont.Create();
 with BotvaFont do
 begin
  Name := 'Warhelios-Bold_Web'; // Tahoma
  Size := 10;
  Style := [];
 end;

 Background := ImgLoad(WizardForm.Handle, 'background.jpg', 0, 0, WizardForm.ClientWidth, WizardForm.ClientHeight, True, True);
 ImgSetVisibility(Background, True);
end;
