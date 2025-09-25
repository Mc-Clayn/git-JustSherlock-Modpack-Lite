// © _McClayn, 2020-now LITE justsherlock \\

[Code]
Const
 SPACE = '   ';
 NEW_LINE = #13#10;
 LINE_SPACE = NEW_LINE + SPACE;

Function CheckListBoxToReadyMemo(const CheckListBox: TNewCheckListBox): String;
var
 I: Integer;
begin
 if _IsComponentSelected(CheckListBox, 'CheckForChecked') then
 begin
  Result := Result + NEW_LINE;
  with CheckListBox do
   for I := 0 to Items.Count - 1 do
    if Checked[I] then
     Result := Result + NEW_LINE + SPACE + GetSpaceByLength(SPACE, ItemLevel[I]) + ItemCaption[I];
 end;
end;

Function GetReadyMemoFormat(): String;
begin
 if CheckBoxGetChecked(RBDelete) or CheckBoxGetChecked(RBBackup) or CheckBoxGetChecked(RBNone) or CheckBoxGetChecked(CBCleanProfile) then
  Result := Result + CustomMessage('readyMemoExtFunctions');
 if CheckBoxGetChecked(RBDelete) then
  Result := Result + LINE_SPACE + CheckBoxGetText(RBDelete);
 if CheckBoxGetChecked(RBBackup) then
  Result := Result + LINE_SPACE + CheckBoxGetText(RBBackup);
 if CheckBoxGetChecked(RBNone) then
  Result := Result + LINE_SPACE + CheckBoxGetText(RBNone);
 if CheckBoxGetChecked(CBCleanProfile) then
  Result := Result + LINE_SPACE + CheckBoxGetText(CBCleanProfile);
  
 if CheckBoxGetChecked(CBParamsRemember) or CheckBoxGetChecked(CBClientGA) then
  Result := Result + NEW_LINE + NEW_LINE + CustomMessage('readyMemoExtOptions');
 if CheckBoxGetChecked(CBParamsRemember) then
  Result := Result + LINE_SPACE + CheckBoxGetText(CBParamsRemember);
 if CheckBoxGetChecked(CBClientGA) then
  Result := Result + LINE_SPACE + CheckBoxGetText(CBClientGA);

 Result := Result + NEW_LINE + NEW_LINE;
 Result := Result + CustomMessage('readyMemoInstallDir') + LINE_SPACE + WizardDirValue() + NEW_LINE + NEW_LINE;
 Result := Result + CustomMessage('readyMemoSelectedItems');

 // page mods
 Result := Result + CheckListBoxToReadyMemo(ComponentsListMain);
 Result := Result + CheckListBoxToReadyMemo(ComponentsListPricels);
 //Result := Result + CheckListBoxToReadyMemo(ComponentsListHangar);
 Result := Result + CheckListBoxToReadyMemo(ComponentsListVoiceover);
 //Result := Result + CheckListBoxToReadyMemo(ComponentsListPMOD);
 //Result := Result + CheckListBoxToReadyMemo(ComponentsListXVM);
 Result := Result + CheckListBoxToReadyMemo(ComponentsListTweaker);
 //
end;