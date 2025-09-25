// © _McClayn, 2020-now \\

[Code]
Const
 CMD_NoSearchGameFiles = '/NOSEARCHGAMEFILES';
 CMD_NoCheckForMutex = '/NOCHECKFORMUTEX';
 CMD_NoCheckForRun = '/NOCHECKFORRUN';
 CMD_Updated = '/UPDATED';
 CMD_Silent = '/SILENT';
 CMD_CreateItemsLog = '/ITEMSLOG';
 CMD_ForceNightlyXVM = '/FORCENIGHTLYXVM';

Function CMDCheckParams(Param: String): Boolean;
var
 I: Integer;
begin
 for I := 1 to ParamCount do
 begin
  Result := Uppercase(ParamStr(I)) = Param;
  if Result then
   Exit;
 end;
end;


// this code nver used, because openwg_utils use
Function CheckForGameRun(const AHandle: THandle): Boolean;
var
 ResultCode: Integer;
begin
 Result := False;
 if CMDCheckParams(CMD_NoCheckForRun) then
 begin
  Result := True;
  Exit;
 end;
 if (FindWindowByWindowName('Mir Tankov (Online Game)') <> 0) or (FindWindowByWindowName('WoT Client') <> 0) then    //     'World of Tanks (Online Game)'     'WoT Client'
 begin
  if MsgBoxEx(AHandle, FmtMessage(CustomMessage('runningApplicationFound'), ['sgGameName(GamePatch,'')']), CustomMessage('warning'), MB_YESNO + MB_DEFBUTTON1 or MB_ICONWARNING, 0, 0) = IDYES then  // CustomMessage('runningApplicationFound')
  begin
   Exec(ExpandConstant('{cmd}'), '/C TASKKILL /F /IM "Tanki.exe" /IM "WoTLauncher.exe"', '', SW_SHOW, ewWaitUntilTerminated, ResultCode);     //  "WorldOfTanks.exe" /IM "WoTLauncher.exe"
   case ResultCode of
    0: Result := True;
    128: Result := True;
   end;
  end;
 end else
  Result := True;
end;


Procedure DeleteValsFromString(var S: String; FromStr: Array of String);
var
 I: Integer;
begin
 for I := 0 to GetArrayLength(FromStr) - 1 do
  StringChange(S, FromStr[I], '');
end;


Function FilesExists(Files: Array of String): Boolean;
var
 I: Integer;
begin
 Result := False;
 for I := 0 to GetArrayLength(Files) - 1 do
  if not FileExists(ExpandConstant(Files[I])) then
   Exit;
 Result := True;
end;


Function BoolToStr(const Bln: Boolean): String;
begin
 case Bln of
  True: Result := 'True';
  False: Result := 'False';
 end;
end;


Function StrToBool(const Str: String): Boolean;
begin
 case AnsiLowercase(Str) of
  'true': Result := True;
  'false': Result := False;
 end;
end;


Function GetSpaceByLength(ASpace: String; const ALength: Integer): String;
var
 I: Integer;
begin
 Result := '';

 if ALength < 1 then
  Exit;

 SetLength(ASpace, Length(ASpace) / 2);
 for I := 0 to ALength do
  Result := Result + ASpace;
end;


Function GetPatchVersionIncreased(_: String): String;
var
 LastSegmentStr: String;
 VerLength, LastSegmentInt: Integer;
begin
 Result := GamePatch; // '{#Patch}'
 VerLength := Length(Result);
 LastSegmentStr := Result[VerLength];
 LastSegmentInt := StrToInt(LastSegmentStr) + 1;
 Delete(Result, VerLength, 1);
 Insert(IntToStr(LastSegmentInt), Result, VerLength);
end;
