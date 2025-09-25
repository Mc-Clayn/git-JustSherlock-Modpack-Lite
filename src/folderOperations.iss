// © _McClayn, 2020-now LITE justshelrock \\

[Code]
Procedure ClientFolderOperations(CurStep: TSetupStep);
var
 ResultCode: Integer;
 WoTAppData, WoTAppDataBackup: String;
begin
 if CurStep = ssInstall then
 try
  if CheckBoxGetChecked(RBDelete) then
  begin
   InstStatusLabel.Caption := CustomMessage('instStatusLabelTextDeleting');
   InstFileNameLabel.Caption := ExpandConstant('{app}\mods|res_mods\*');

   Exec(ExpandConstant('{cmd}'), '/C RMDIR /S /Q "res_mods\'+GamePatch+'"', ExpandConstant('{app}'), SW_SHOW, ewWaitUntilTerminated, ResultCode); // {#Patch}
   Exec(ExpandConstant('{cmd}'), '/C RMDIR /S /Q "res_mods\configs\"', ExpandConstant('{app}'), SW_SHOW, ewWaitUntilTerminated, ResultCode); // {#Patch}
   Exec(ExpandConstant('{cmd}'), '/C RMDIR /S /Q "mods\'+GamePatch+'"', ExpandConstant('{app}'), SW_SHOW, ewWaitUntilTerminated, ResultCode); // {#Patch}
   Exec(ExpandConstant('{cmd}'), '/C RMDIR /S /Q "mods\configs\"', ExpandConstant('{app}'), SW_SHOW, ewWaitUntilTerminated, ResultCode); // {#Patch}
   ForceDirectories(ExpandConstant('{app}\res_mods\'+GamePatch)); // {#Patch}
   ForceDirectories(ExpandConstant('{app}\res_mods\configs\')); // {#Patch}
   ForceDirectories(ExpandConstant('{app}\mods\'+GamePatch)); // {#Patch}
   ForceDirectories(ExpandConstant('{app}\mods\configs\')); // {#Patch}
  end;
  if CheckBoxGetChecked(RBBackup) then
  begin
   InstStatusLabel.Caption := CustomMessage('instStatusLabelTextBackupping');
   InstFileNameLabel.Caption := ExpandConstant('{app}\mods|res_mods\*');

   if DirExists(ExpandConstant('{app}\backup_'+GamePatch)) then  // {#Patch}
    Exec(ExpandConstant('{cmd}'), '/C RMDIR /S /Q "backup_'+GamePatch+'"', ExpandConstant('{app}'), SW_SHOW, ewWaitUntilTerminated, ResultCode); // {#Patch}

   ForceDirectories(ExpandConstant('{app}\backup_'+GamePatch)); // {#Patch}
   Exec(ExpandConstant('{cmd}'), '/C MOVE /Y "res_mods\'+GamePatch+'" "backup_'+GamePatch+'"', ExpandConstant('{app}'), SW_SHOW, ewWaitUntilTerminated, ResultCode); // {#Patch}
   Exec(ExpandConstant('{cmd}'), '/C MOVE /Y "res_mods\configs\" "backup_'+GamePatch+'"', ExpandConstant('{app}'), SW_SHOW, ewWaitUntilTerminated, ResultCode); // {#Patch}
   Exec(ExpandConstant('{cmd}'), '/C MOVE /Y "mods\'+GamePatch+'" "backup_'+GamePatch+'"', ExpandConstant('{app}'), SW_SHOW, ewWaitUntilTerminated, ResultCode); // {#Patch}
   Exec(ExpandConstant('{cmd}'), '/C MOVE /Y "mods\configs\" "backup_'+GamePatch+'"', ExpandConstant('{app}'), SW_SHOW, ewWaitUntilTerminated, ResultCode); // {#Patch}

   ForceDirectories(ExpandConstant('{app}\res_mods\'+GamePatch)); // {#Patch}
   ForceDirectories(ExpandConstant('{app}\res_mods\configs\')); // {#Patch}
   ForceDirectories(ExpandConstant('{app}\mods\'+GamePatch)); // {#Patch}
   ForceDirectories(ExpandConstant('{app}\mods\configs\')); // {#Patch}
  end;
  if CheckBoxGetChecked(CBCleanProfile) then
  begin
   WoTAppData := ExpandConstant('{userappdata}\Lesta\Tanki\');               //   {userappdata}\Wargaming.net\WorldOfTanks\
   WoTAppDataBackup := ExpandConstant('{userappdata}\Lesta\Tanki_backup');   //   {userappdata}\Wargaming.net\WorldOfTanks_backup

   InstStatusLabel.Caption := CustomMessage('instStatusLabelTextProfileClearing');
   InstFileNameLabel.Caption := WoTAppData;

   if DirExists(WoTAppDataBackup) then
    DelTree(WoTAppDataBackup, True, True, True);
   ForceDirectories(WoTAppDataBackup);
   Exec(ExpandConstant('{cmd}'), '/C XCOPY "' + WoTAppData + '*.*" "' + WoTAppDataBackup + '\" /S /F /Y', '', SW_SHOW, ewWaitUntilTerminated, ResultCode);

   DelTree(WoTAppData + 'account_caches', True, True, True);
   DelTree(WoTAppData + 'battle_results', True, True, True);
   DelTree(WoTAppData + 'clan_cache', True, True, True);
   DelTree(WoTAppData + 'custom_data', True, True, True);
   DelTree(WoTAppData + 'dossier_cache', True, True, True);
   DelTree(WoTAppData + 'messenger_cache', True, True, True);
   DelTree(WoTAppData + 'pmod', True, True, True);
   DelTree(WoTAppData + 'profile', True, True, True);
   DelTree(WoTAppData + 'storage_cache', True, True, True);
   DelTree(WoTAppData + 'tutorial_cache', True, True, True);
   DelTree(WoTAppData + 'veh_cmp_cache', True, True, True);
   DelTree(WoTAppData + 'web_cache', True, True, True);
   DelTree(WoTAppData + 'wgfm', True, True, True);
  end;
  SaveStringToFile(ExpandConstant('{app}\res_mods\'+GamePatch+'\readme.txt'), 'This folder is used for Mir Tankov modifiers (mods).', False); // {#Patch}
  SaveStringToFile(ExpandConstant('{app}\mods\'+GamePatch+'\readme.txt'), 'This folder is used for packaged Mir Tankov modifiers (*.wotmods).', False); // {#Patch}
 except
  MsgBoxEx(WizardForm.Handle, GetExceptionMessage(), '{#__FILE__}: {#__LINE__}', MB_OK or MB_ICONERROR, 0, 0);
 end;
end;

Procedure RestoreDirectories(CurUninstallStep: TUninstallStep);
var
 ResultCode: Integer;
begin
 if CurUninstallStep = usPostUninstall then
   begin
    if DirExists(ExpandConstant('{app}\backup_'+GamePatch)) then   // {#Patch}
    begin
     DelTree(ExpandConstant('{app}\res_mods'), True, True, True);
     DelTree(ExpandConstant('{app}\mods'), True, True, True);

     Exec(ExpandConstant('{cmd}'), '/C MOVE /Y "backup_'+GamePatch+'\mods" ""', ExpandConstant('{app}'), SW_SHOW, ewWaitUntilTerminated, ResultCode); // {#Patch}
     Exec(ExpandConstant('{cmd}'), '/C MOVE /Y "backup_'+GamePatch+'\res_mods" ""', ExpandConstant('{app}'), SW_SHOW, ewWaitUntilTerminated, ResultCode); // {#Patch}

     DelTree(ExpandConstant('{app}\backup_'+GamePatch), True, True, True);
    end;

    if not DirExists(ExpandConstant('{app}\res_mods\'+GamePatch+'')) then  // {#Patch}
     ForceDirectories(ExpandConstant('{app}\res_mods\'+GamePatch+'')); // {#Patch}
    if not DirExists(ExpandConstant('{app}\mods\'+GamePatch+'')) then // {#Patch}
     ForceDirectories(ExpandConstant('{app}\mods\'+GamePatch+'')); // {#Patch}

    SaveStringToFile(ExpandConstant('{app}\res_mods\'+GamePatch+'\readme.txt'), 'This folder is used for World of Tanks modifiers (mods).', False); // {#Patch}
    SaveStringToFile(ExpandConstant('{app}\mods\'+GamePatch+'\readme.txt'), 'This folder is used for packaged World of Tanks modifiers (*.wotmods).', False); // {#Patch}
   end;
  // openwg_utils -> Procedure OPENWG_DllDelete()
  if IsUninstaller() then
    begin
        DeleteFile(ExpandConstant('{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll'));
        RemoveDir(ExpandConstant('{app}\{#OPENWGUTILS_DIR_UNINST}'));
    end
    else begin
        DeleteFile(ExpandConstant('{tmp}\openwg.utils.dll'));
        RemoveDir(ExpandConstant('{tmp}'));
    end;
end;