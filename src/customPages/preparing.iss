// © _McClayn, 2020-now LITE justsherlock \\

[Code]
Function PreparingShouldSkipPage(): Boolean;
var
 ResultCode: Integer;
begin
 Exec(ExpandConstant('{cmd}'), 'taskkill /IM Tanki.exe', '', SW_SHOW, ewWaitUntilTerminated, ResultCode);    //   WorldOfTanks.exe   Tanki.exe

 Result := True;
end;
