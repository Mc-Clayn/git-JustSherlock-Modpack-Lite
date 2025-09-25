// © _McClayn, 2020-2023 demo \\

[Files]
;image size 320х23
Source: "files\gui\button_next.bmp"; DestDir: {tmp}; Flags: dontcopy
Source: "files\gui\button_prev.bmp"; DestDir: {tmp}; Flags: dontcopy
Source: "src\botva2\botva2.dll"; DestDir: {tmp}; Flags: dontcopy
Source: "src\botva2\innocallback.dll"; DestDir: {tmp}; Flags: dontcopy

[Code]

type
  TButtonInfo = record ButtonName: array of TButton; Handle: array of HWND; Count: Integer; end;

var
  ButtonsBuff: TButtonInfo;
  HCancelButton, HNextButton, HBackButton, HDirBrowseButton, HGroupBrowseButton: HWND;

// all other files from botva2.iss here not has

procedure UpdateButtons();
var I: integer;
begin
  for I:=0 to (ButtonsBuff.Count-1) do
  begin
    BtnSetEnabled(ButtonsBuff.Handle[I], ButtonsBuff.ButtonName[I].Enabled)
    BtnSetVisibility(ButtonsBuff.Handle[I], ButtonsBuff.ButtonName[I].Visible)
    BtnSetText(ButtonsBuff.Handle[I], ButtonsBuff.ButtonName[I].Caption)
    BtnRefresh(ButtonsBuff.Handle[I])
  end;
end;

procedure ButtonOnClick(hBtn: HWND);
var Btn: TButton; I: Integer;
begin
  for I:=0 to (ButtonsBuff.Count-1) do begin
  if hBtn = ButtonsBuff.Handle[I] then Btn:= ButtonsBuff.ButtonName[I];
  end;
  Btn.OnClick(Btn)
  UpdateButtons;
end;

Function EffectTextureButton(Handle: HWND; Button: TButton; ImageName: PAnsiChar; ShadowWidth: Integer; EnterEvent, MoveEvent, LeaveEvent: TbtnEventProc): HWND;
begin
  //Result:=_BtnCreate(Handle, Button.Left-8, Button.Top-8, Button.Width+16, Button.Height+16, ImageName, ShadowWidth, False) //Размеры подобраны для текущей текстуры
  Result := _BtnCreate(Handle, Button.Left, Button.Top, Button.Width, Button.Height, ImageName, ShadowWidth, False);
  BtnSetEvent(Result, BtnClickEventID, WrapBtnCallback(@ButtonOnClick, 1))
  if EnterEvent <> nil then BtnSetEvent(Result, BtnMouseEnterEventID, WrapBtnCallback(EnterEvent, 1));
  if MoveEvent <> nil then BtnSetEvent(Result, BtnMouseMoveEventID, WrapBtnCallback(MoveEvent, 1));
  if LeaveEvent <> nil then BtnSetEvent(Result, BtnMouseLeaveEventID, WrapBtnCallback(LeaveEvent, 1));
  BtnSetFont(Result, Button.Font.Handle); 
  BtnSetText(Result, Button.Caption);
  BtnSetVisibility(Result, Button.Visible);
  BtnSetFontColor(Result,clWhite,clWhite,clWhite,clGray); // Result,clBlack,clBlack,clBlack,clGray
  BtnSetCursor(Result,GetSysCursorHandle(32649));
  Button.Width:=0; Button.Height:= 0;
  SetArrayLength(ButtonsBuff.Handle, ButtonsBuff.Count+1); SetArrayLength(ButtonsBuff.ButtonName, ButtonsBuff.Count+1);
  ButtonsBuff.ButtonName[ButtonsBuff.Count]:= Button; ButtonsBuff.Handle[ButtonsBuff.Count]:= Result;
  ButtonsBuff.Count:= ButtonsBuff.Count+1;
end;

Procedure ButtonChangeFont(ButtonHandle: HWND; Font: TFont; NormalColor, FocusedColor, PressedColor, DisabledColor: Cardinal);
begin
  if Font <> nil then BtnSetFont(ButtonHandle, Font.Handle);
  BtnSetFontColor(ButtonHandle, NormalColor, FocusedColor, PressedColor, DisabledColor)
end;

