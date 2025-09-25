// © _McClayn, 2020-2023 demo \\

[Code]
Const
 REG_ROOT = HKEY_CURRENT_USER;
 REG_KEY_ITEMS = 'SOFTWARE\_McClayn\ITEMS_%s\%s';
 REG_KEY_SETUP = 'SOFTWARE\_McClayn\SETUP';

 CMD_GET = 'GET';
 CMD_SET = 'SET';
 INSTALLED_FLAG = 1;

 LOG_FILE = '{src}\install_log.kmp';

Procedure SetInstallParam(const Param, Data: String);
begin
 RegWriteStringValue(REG_ROOT, REG_KEY_SETUP, Param, Data);
end;

Function GetInstallParam(const Param: String; Def: Boolean): Boolean;
var
 RegResult: String;
begin
 Result := False;
 if RegKeyExists(REG_ROOT, REG_KEY_SETUP) then
 begin
  case RegQueryStringValue(REG_ROOT, REG_KEY_SETUP, Param, RegResult) of
   True: Result := StrToBool(RegResult);
   False: Result := Def;
  end;
 end else
  Result := Def;
end;

Function SearchLog(FileName, sValue: AnsiString): Boolean;
var
 FileStrings: TArrayOfString;
 I: Integer;
begin
 LoadStringsFromFile(FileName, FileStrings);
 for I := 0 to GetArrayLength(FileStrings) - 1 do
 begin
  Result := Pos(sValue, FileStrings[I]) > 0;
  if Result then
   Exit;
 end;
end;

Procedure InstallParams_Mods(const Cmd: String; CheckListBox: TNewCheckListBox);
var
 I: Integer;
 RegResult: Cardinal;
 RegKey: String;
begin
 RegKey := AnsiUppercase(Format(REG_KEY_ITEMS, [ActiveLanguage(), CheckListBox.Name]));
 case Cmd of
  CMD_GET:
  if not FileExists(ExpandConstant(LOG_FILE)) then
  begin
   if RegKeyExists(REG_ROOT, RegKey) then
    for I := 0 to CheckListBox.Items.Count - 1 do
     if RegQueryDWordValue(REG_ROOT, RegKey, CheckListBox.ItemCaption[I], RegResult) then
      if CheckListBox.ItemEnabled[I] then
       CheckListBox.Checked[I] := RegResult = INSTALLED_FLAG;
  end else
  try
   for I := 0 to CheckListBox.Items.Count - 1 do
    if CheckListBox.ItemEnabled[I] then
     CheckListBox.Checked[I] := SearchLog(ExpandConstant(LOG_FILE), CheckListBox.ItemCaption[I]);
  finally
   MsgBoxEx(WizardForm.Handle, 'Params restored from log-file for: ' + #13#10 + CheckListBox.Name, '{#__FILE__}: {#__LINE__}', MB_OK or MB_ICONINFORMATION, 0, 0);
  end;
  CMD_SET:
  begin
   if RegKeyExists(REG_ROOT, RegKey) then
    RegDeleteKeyIncludingSubkeys(REG_ROOT, RegKey);
   for I := 0 to CheckListBox.Items.Count - 1 do
    if CheckListBox.Checked[I] then
     RegWriteDWordValue(REG_ROOT, RegKey, CheckListBox.ItemCaption[I], INSTALLED_FLAG);
  end;
 end;
end;
