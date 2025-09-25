// © _McClayn, 2020-2023 demo \\

[Files]
Source: "src\ConfigEditor.dll"; Flags: dontcopy;

[Code]
Const
 _CP_UTF8 = 65001;
 _CP_ACP = 0; {ANSI}

 EDGE = '{app}\mods\configs\EdgeDetectLite';
 UPDATER = '{app}\mods\configs\updater';

Function EditorAddConfigW(AFilePath, AOldValue, ANewValue: String; AEncoding: Integer; WriteBOM: Boolean): Integer; external 'EditorAddConfigW@files:ConfigEditor.dll stdcall';
Function EditorInitialize(): Boolean; external 'EditorInitialize@files:ConfigEditor.dll stdcall';
Procedure EditorShowConfigs(Handle: Longint); external 'EditorShowConfigs@files:ConfigEditor.dll stdcall';

//Procedure ConfigurateComponents(); forward;
// add this from page mods
Procedure ConfigurateComponentsMain(); forward;
Procedure ConfigurateComponentsPricels(); forward;
//Procedure ConfigurateComponentsHangar(); forward;
Procedure ConfigurateComponentsVoiceover(); forward;
//Procedure ConfigurateComponentsPMOD(); forward;
//Procedure ConfigurateComponentsXVM(); forward;
Procedure ConfigurateComponentsTweaker(); forward;


Procedure ConfigEdit(WriteBOM: Boolean; DefPath, ConfigFile: String; IsComponents: Boolean; OldValue, NewValue: String);
var
 ConfigPath: String;
begin
 ConfigPath := ExpandConstant(AddBackslash(DefPath) + ConfigFile);
 if IsComponents and FileExists(ConfigPath) then
  EditorAddConfigW(ConfigPath, OldValue, NewValue, _CP_UTF8, WriteBOM);
end;

Procedure ConfigsEdit(WriteBOM: Boolean; DefPath: String; ConfigFiles: Array of String; IsComponents: Boolean; OldValue, NewValue: String);
var
 I: Integer;
 ConfigPath: String;
begin
 for I := 0 to GetArrayLength(ConfigFiles) - 1 do
 begin
  ConfigPath := ExpandConstant(AddBackslash(DefPath) + ConfigFiles[I]);
  if IsComponents and FileExists(ConfigPath) then
   EditorAddConfigW(ConfigPath, OldValue, NewValue, _CP_UTF8, WriteBOM);
 end;
end;

Procedure StartConfigurator(CurStep: TSetupStep);
begin
 if CurStep = ssPostInstall then
 begin
  //ConfigurateComponents();
  // add this from page mods
  ConfigurateComponentsMain();
  ConfigurateComponentsPricels();
  //ConfigurateComponentsHangar();
  ConfigurateComponentsVoiceover();
  //ConfigurateComponentsPMOD();
  //ConfigurateComponentsXVM();
  //
  ConfigurateComponentsTweaker();

  EditorInitialize();
 end;
end;