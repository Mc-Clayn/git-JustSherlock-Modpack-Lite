// © _McClayn, 2020-2023 demo \\

[Code]
Const
 BetaVersion = -1;
 VersionIsActual = 0;
 NewVersionAvailable = 1;

{Returns "1" if This > That, "0" if This = That and a "-1" if This < That.}
Function CompareVersion(NewVersionStr, ThatVersionStr: String): Integer;
var
 NewVersionInt, ThatVersionInt: Integer;
begin
 while Pos('.', NewVersionStr) > 0 do
  Delete(NewVersionStr, Pos('.', NewVersionStr), 1);
 while Pos('.', ThatVersionStr) > 0 do
  Delete(ThatVersionStr, Pos('.', ThatVersionStr), 1);

 NewVersionInt := StrToIntDef(NewVersionStr, 0);
 ThatVersionInt := StrToIntDef(ThatVersionStr, 0);

 if NewVersionInt > ThatVersionInt then
  Result := NewVersionAvailable
 else
 if NewVersionInt = ThatVersionInt then
  Result := VersionIsActual
 else
 if NewVersionInt < ThatVersionInt then
  Result := BetaVersion;
end;