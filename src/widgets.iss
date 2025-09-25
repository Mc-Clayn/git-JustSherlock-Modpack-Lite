// © _McClayn, 2020-2023 demo \\

[Code]
Var
 YTLogoBtn: Longint;    // XVMLogoBtn  TankiModsLogoBtn, DonateLogoBtn


Procedure WidgetsOnClick(hBtn: Longint);
var
 ErrorCode: Integer;
begin
 case hBtn of
  YTLogoBtn: ShellExec('', '{#URL_Youtube}', '', '', SW_SHOW, ewNoWait, ErrorCode);
  //TankiModsLogoBtn: ShellExec('', '{#URL_Tankimods}', '', '', SW_SHOW, ewNoWait, ErrorCode);
  //DonateLogoBtn: ShellExec('', '{#URL_Donate}', '', '', SW_SHOW, ewNoWait, ErrorCode);
  //XVMLogoBtn: ShellExec('', '{#URL_Wgmods}', '', '', SW_SHOW, ewNoWait, ErrorCode);
 end;
end;

Procedure InitializeWidgets();
begin
  YTLogoBtn := BtnCreate(WizardForm.Handle, ScaleX(8), WizardForm.ClientHeight - ScaleY(44), 40, 40, 'logoBtnYt.png', 0, False);
  BtnSetCursor(YTLogoBtn, GetSysCursorHandle(OCR_HAND));
  BtnSetEvent(YTLogoBtn, BtnClickEventID, WrapBtnCallback(@WidgetsOnClick, 1));

  {TankiModsLogoBtn := BtnCreate(WizardForm.Handle, ScaleX(60), WizardForm.ClientHeight - ScaleY(41), 34, 34, 'logoBtnTankiMods.png', 0, False);
  BtnSetCursor(TankiModsLogoBtn, GetSysCursorHandle(OCR_HAND));
  BtnSetEvent(TankiModsLogoBtn, BtnClickEventID, WrapBtnCallback(@WidgetsOnClick, 1));  }

  {DonateLogoBtn := BtnCreate(WizardForm.Handle, ScaleX(104), WizardForm.ClientHeight - ScaleY(42), 40, 40, 'logoBtnDonate.png', 0, False);
  BtnSetCursor(DonateLogoBtn, GetSysCursorHandle(OCR_HAND));
  BtnSetEvent(DonateLogoBtn, BtnClickEventID, WrapBtnCallback(@WidgetsOnClick, 1)); }

//  XVMLogoBtn := BtnCreate(WizardForm.Handle, ScaleX(151), WizardForm.ClientHeight - ScaleY(41), 34, 34, 'logoBtnXVM.png', 0, False);
//  BtnSetCursor(XVMLogoBtn, GetSysCursorHandle(OCR_HAND));
//  BtnSetEvent(XVMLogoBtn, BtnClickEventID, WrapBtnCallback(@WidgetsOnClick, 1));
end;