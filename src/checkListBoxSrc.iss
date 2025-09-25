// © _McClayn, 2020-2023 demo \\

[Files]
Source: "files\previews\*"; Excludes: "*.psd"; Flags: recursesubdirs dontcopy;

[Code]
Const
 GWL_EXSTYLE = -20;
 WS_EX_COMPOSITED = $02000000;

Type
 TPreviewImagePos = record
  Top, Left, Width, Height: Integer;
 end;

 TItemInfo = record
  Image: String;
  Desc: String;
 end;

 TListsItemsInfo = Array of Array of TItemInfo;

Var
 DescriptionMemo: TMemo;
 PreviewImage: Longint;
 PreviewImagePos: TPreviewImagePos;
 ListsItemsInfo: TListsItemsInfo;
 //
 //SetWindowLong: TSetWindowLong;
 //

// 796x600
Function GetWindowLong(hWnd: HWND; nIndex: Integer): Longint; external 'GetWindowLongW@user32.dll stdcall';
Function SetWindowLong(hWnd: HWND; nIndex: Integer; dwNewLong: Longint): Longint; external 'SetWindowLongW@user32.dll stdcall';

Function IsItemInBlackList(const ItemName: String): Boolean;
begin
 Result := False;
  #ifdef Updater
 if Pos(ItemName, ItemsBlackList) > 0 then
  Result := True;
 #endif
end;

Procedure SetCheckListBoxItemsInfo(const CheckListBoxTag: Integer);
begin
 SetArrayLength(ListsItemsInfo, GetArrayLength(ListsItemsInfo) + 1);
end;

Procedure SetItemInfo(const CheckListBoxTag: Integer; const AItemName, ImageName: String);
var
 DescName: String;
 Idx: Integer;
begin
 Idx := GetArrayLength(ListsItemsInfo[CheckListBoxTag]);
 SetArrayLength(ListsItemsInfo[CheckListBoxTag], Idx + 1);
 ListsItemsInfo[CheckListBoxTag][Idx].Image := ImageName;
 DescName := AItemName;
 StringChange(DescName, 'item', 'desc');
 ListsItemsInfo[CheckListBoxTag][Idx].Desc := CustomMessage(DescName);
end;

Function AddCheckBoxExt(CheckListBox: TNewCheckListBox; ItemName: String; Level: Integer; Enabled: Boolean; FontStyle: TFontStyles; ImageName: String): Integer;
begin
 Result := CheckListBox.AddCheckBox(CustomMessage(ItemName), '', Level, False, not IsItemInBlackList(ItemName) and Enabled, True, True, nil);
 CheckListBox.ItemFontStyle[Result] := FontStyle;

 SetItemInfo(CheckListBox.Tag, ItemName, ImageName);

 if CMDCheckParams(CMD_CreateItemsLog) and Enabled then
  SaveStringToFile(ExpandConstant('{src}\items_log.txt'), GetSpaceByLength('  ', Level) + CustomMessage(ItemName) + #13#10, True);
end;

Function AddRadioButtonExt(CheckListBox: TNewCheckListBox; ItemName: String; Level: Integer; Enabled: Boolean; FontStyle: TFontStyles; ImageName: String): Integer;
begin
 Result := CheckListBox.AddRadioButton(CustomMessage(ItemName), '', Level, False, not IsItemInBlackList(ItemName) and Enabled, nil);
 CheckListBox.ItemFontStyle[Result] := FontStyle;

 SetItemInfo(CheckListBox.Tag, ItemName, ImageName);

 if CMDCheckParams(CMD_CreateItemsLog) and Enabled then
  SaveStringToFile(ExpandConstant('{src}\items_log.txt'), GetSpaceByLength('  ', Level) + CustomMessage(ItemName) + #13#10, True);
end;

Procedure SetCheckListBoxBGBMP(CheckListBox: TNewCheckListBox);
var
 ListsBGBMP: TBitmap;
 BGFile: String;
begin
 if ScaleFactor = 0 then //scale factor is custom or undefined
  Exit;

 BGFile := 'ListsBackground' + IntToStr(ScaleFactor) + '.bmp';
 ExtractTemporaryFile(BGFile);
 ListsBGBMP := TBitmap.Create();
 with ListsBGBMP do
 begin
  LoadFromFile(ExpandConstant('{tmp}\' + BGFile));
  //
  //Left := ScaleX(475);
  //
  Height := ScaleX(1000);
  Width := ScaleY(1000);
 end;
 //CheckListBox.LoadBGBmpFromBitmap(ListsBGBMP, 475, 0);
 CheckListBox.LoadBGBmpFromBitmap(ListsBGBMP, 0, 0);
 SetWindowLong(CheckListBox.Handle, GWL_EXSTYLE, GetWindowLong(CheckListBox.Handle, GWL_EXSTYLE) or WS_EX_COMPOSITED);
end;

////

Procedure InitializeComponentsInfo();
begin
 with PreviewImagePos do
 begin
  Left := ScaleX(10);
  //Left := ScaleX(475); // отступ слева
  Top := ScaleY(92); // отступ сверху
  Width := ScaleX(275);
  Height := ScaleY(295);
 end;

 DescriptionMemo := TMemo.Create(WizardForm);
 with DescriptionMemo do
 begin
  Parent := WizardForm;
  SetBounds(PreviewImagePos.Left - ScaleX(1), PreviewImagePos.Top + PreviewImagePos.Height + ScaleY(2), PreviewImagePos.Width + ScaleX(2), ScaleY(92));
  ReadOnly := True;
  HideSelection := True;
  Text := CustomMessage('descriptionMemoDefaultText');
  Font.Color := clWhite;
  Font.Size := 9;
  DragMode := dmAutomatic;
 end;
end;

Procedure SetPreviewImage(const ImageName: String; const IsRelease: Boolean);
begin
 if IsRelease then
  ImgRelease(PreviewImage);
 PreviewImage := ImgLoad(WizardForm.Handle, ImageName, PreviewImagePos.Left, PreviewImagePos.Top, PreviewImagePos.Width, PreviewImagePos.Height, True, False);
end;

{ Преобразовывает значение типа Integer в строку }

Procedure ResetPreviewImage(const Value: Boolean; const Page: Integer);     // second parameter is number of page for using individual image
begin
  if Value then
    SetPreviewImage('KMP_p'+IntToStr(Page)+'_ru.png', False);
//  if Value then
//    SetPreviewImage('KMP.png', False);
  ImgSetVisibility(PreviewImage, Value);
end;

Procedure _OnItemMouseMove(Sender: TObject; X, Y, Index: Integer; Area: TItemArea);
var
 ItemInfo: TItemInfo;
begin
 if Index = -1 then
  Exit;

 ItemInfo := ListsItemsInfo[TNewCheckListBox(Sender).Tag][Index];
 SetPreviewImage(ItemInfo.Image, True);
 DescriptionMemo.Text := ItemInfo.Desc;
 if not TNewCheckListBox(Sender).ItemEnabled[Index] then
  DescriptionMemo.Text := DescriptionMemo.Text + CustomMessage('descriptionMemoItemUnavailable');
 ImgApplyChanges(WizardForm.Handle);
end;

Procedure _OnMouseLeave(Sender: TObject);
begin
 //SetPreviewImage('KMP.png', True);
 //SetPreviewImage('KMP_p'+IntToStr(Page)+'_ru.png', True);
 SetPreviewImage('KMP_p'+IntToStr(1)+'_ru.png', True);
 DescriptionMemo.Text := CustomMessage('descriptionMemoDefaultText');
 ImgApplyChanges(WizardForm.Handle);
end;

{Procedure _OnMouseLeave(Sender: TObject);
begin
 SetPreviewImage('KMP.png', True);
 //SetPreviewImage('KMP_p'+IntToStr(Page)+'_ru.png', True);
 DescriptionMemo.Text := CustomMessage('descriptionMemoDefaultText');
 ImgApplyChanges(WizardForm.Handle);
end;}

Procedure SetCheckListBoxEvents(CheckListBox: TNewCheckListBox);
begin
 CheckListBox.OnItemMouseMove := @_OnItemMouseMove;
 CheckListBox.OnMouseLeave := @_OnMouseLeave;
end;

////

Function _IsComponentSelected(const CheckListBox: TNewCheckListBox; Name: String): Boolean;
var
 I, Idx: Integer;
begin
 Result := False;
 try
  if Name = 'CheckForChecked' then
  begin
   for I := 0 to CheckListBox.ItemCount - 1 do
   begin
    Result := CheckListBox.Checked[I];
    if Result then
     Exit;
   end;
  end else
  begin
   Idx := CheckListBox.Items.IndexOf(CustomMessage(Name));
   if Idx = -1 then
   begin
    MsgBoxEx(WizardForm.Handle, 'There is no such item:' + #13#10 + CustomMessage(Name) + #13#10 + 'In the: ' + CheckListBox.Name, 'Item not found:', MB_ICONWARNING or MB_OK, 0, 0);
    Exit;
   end else
    Result := CheckListBox.Checked[Idx];
  end;
 except
  MsgBoxEx(WizardForm.Handle, GetExceptionMessage(), '{#__FILE__}: {#__LINE__}', MB_ICONERROR or MB_OK, 0, 0);
 end;
end;