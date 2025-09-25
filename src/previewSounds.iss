// © _McClayn, 2020-now \\
// "PlaySound" author: Sherogat \\

[Files]
Source: "files\sounds\*.mp3"; Flags: dontcopy;
Source: "src\bass.dll"; Flags: dontcopy;

[Code]
Const
 LB_ITEMFROMPOINT = $01A9;
 BASS_ATTRIB_VOL = 2;
 BASS_DEFAULT_DEVICE = -1;

Type
 TComponentSound = record
  SoundName: String;
  Index: Integer;
 end;

Var
 CompSounds: Array of TComponentSound;
 BassVolumeTrackBar: TTrackBar;
 BassVolumeLbl: TLabel;
 LastResult: Integer;
 BASS_Handle: DWORD;

Function GetCursorPos(var lpPoint: TPoint): BOOL; external 'GetCursorPos@user32.dll stdcall';
Function MapWindowPoints(hWndFrom, hWndTo: HWND; var lpPoints: TPoint; cPoints: UINT): Integer; external 'MapWindowPoints@user32.dll stdcall';

Function BASS_Init(Device: Integer; Freq, Flags: DWORD; Win: HWND; CLSID: Integer): Boolean; external 'BASS_Init@files:BASS.dll stdcall';
Function BASS_StreamCreateFile(Mem: BOOL; Filename: PAnsiChar; Offset1, Offset2, Length1, Length2, Flags: DWORD): Longword; external 'BASS_StreamCreateFile@files:BASS.dll stdcall';
Function BASS_StreamFree(Handle: Longword): BOOL; external 'BASS_StreamFree@files:BASS.dll stdcall';
Function BASS_ChannelPlay(Handle: DWORD; Restart: BOOL): Boolean; external 'BASS_ChannelPlay@files:BASS.dll stdcall';
function BASS_ChannelSetAttribute(Handle, Flags: DWORD; Value: Single): Boolean; external 'BASS_ChannelSetAttribute@files:BASS.dll stdcall';
Function BASS_Start(): Boolean; external 'BASS_Start@files:BASS.dll stdcall';
Function BASS_Stop(): Boolean; external 'BASS_Stop@files:BASS.dll stdcall';
Function BASS_Free(): Boolean; external 'BASS_Free@files:BASS.dll stdcall';

Procedure BassPlaySound(Filename: AnsiString);
begin
 if BASS_Handle <> -1 then
 begin
  BASS_Stop();
  BASS_StreamFree(BASS_Handle);
  BASS_Handle := -1;
 end;
 BASS_Handle := BASS_StreamCreateFile(False, PAnsiChar(Filename), 0, 0, 0, 0, 0);
 BASS_ChannelSetAttribute(BASS_Handle, BASS_ATTRIB_VOL, (BassVolumeTrackBar.Position / 100.0));
 BASS_Start();
 BASS_ChannelPlay(BASS_Handle, False);
end;

Procedure PlaySound(Sender: TObject);
var
 Point: TPoint;
 I, F, Index: Integer;
 CheckListBox: TNewCheckListBox;
begin
 GetCursorPos(Point);
 CheckListBox := TNewCheckListBox(Sender);
 MapWindowPoints(0, CheckListBox.Handle, Point, 1);

 I := SendMessage(CheckListBox.Handle, LB_ITEMFROMPOINT, 0, (Point.X or (Point.Y shl 16)));
 if ((I shr 16) = 1) or ((I and $FFFF) < 0) then
  Exit
 else
  I := I and $FFFF;
 if (I < 0) or (I >= CheckListBox.ItemCount) then
  Exit;

 F := 0;
 while F < I do
  if F >= CheckListBox.ItemCount then
   Break
  else
   F := F + 1;

 Index := I;

 F := -1;
 for I := 0 to GetArrayLength(CompSounds) - 1 do
  if Index = CompSounds[I].Index then
  begin
   F := I;
   Break;
  end;

 if F >= 0 then
 begin
  if LastResult <> IDOK then
   LastResult := MsgBoxEx(WizardForm.Handle, CustomMessage('soundPreviewVolumeWarning'), CustomMessage('soundPreview'), MB_OK or MB_ICONINFORMATION, 0, 0);
  if LastResult = IDOK then
   if CheckListBox.Checked[CompSounds[F].Index] then
    if FileExists(CompSounds[F].SoundName) then
    begin
     BassPlaySound(CompSounds[F].SoundName);
     BassVolumeTrackBar.Enabled := True;
    end;
 end;
end;

Procedure AddItemSound(CheckListBox: TNewCheckListBox; ItemName, Filename: String);     // Filename: String
var
  I: Integer;
begin
  ExtractTemporaryFile(Filename); // Filename

  I := GetArrayLength(CompSounds);
  SetArrayLength(CompSounds, I + 1);
  CompSounds[I].Index := CheckListBox.Items.IndexOf(CustomMessage(ItemName));
  CompSounds[I].SoundName := ExpandConstant('{tmp}\' + Filename); // Filename
  CheckListBox.OnClick := @PlaySound;
end;

Procedure BassVolumeTrackBarOnChange(Sender: TObject);
begin
 BASS_ChannelSetAttribute(BASS_Handle, BASS_ATTRIB_VOL, (BassVolumeTrackBar.Position / 100.0));
 BassVolumeLbl.Caption := Format(CustomMessage('soundPreviewVolume'), [BassVolumeTrackBar.Position]);
end;

Procedure InitializeSounds();
begin
 BassVolumeTrackBar := TTrackBar.Create(WizardForm);
 with BassVolumeTrackBar do
 begin
  Parent := WizardForm;
  SetBounds(ScaleX(300), WizardForm.BackButton.Top + ScaleY(2), ScaleX(120), ScaleY(32));
  Orientation := trHorizontal;
  Min := 0;
  Max := 100;
  Position := 10;
  SelStart := 10;
  SelEnd := 55;
  OnChange := @BassVolumeTrackBarOnChange;
  Enabled := False;
 end;

 BassVolumeLbl := TLabel.Create(WizardForm);
 with BassVolumeLbl do
 begin
  Parent := WizardForm;
  SetBounds(BassVolumeTrackBar.Left + ScaleX(5), BassVolumeTrackBar.Top - ScaleY(12), 0, 0);
  AutoSize := True;
  WordWrap := False;
  Caption := Format(CustomMessage('soundPreviewVolume'), [BassVolumeTrackBar.Position]);
 end;

 BASS_Init(BASS_DEFAULT_DEVICE, 44100, 0, 0, 0);
 BASS_Handle := -1;
end;

Procedure DeinitializeSounds();
begin
 BASS_Stop();
 BASS_Free();
end;