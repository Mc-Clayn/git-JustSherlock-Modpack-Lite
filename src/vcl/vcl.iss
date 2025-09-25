// 2020-now justsherlock modpack DEV

#define VCL "mt_modpack"
//"Windows10Dark"
#define VCLStylesSkinPath "{localappdata}\VCLStylesSkin"

[Files]
Source: "src\vcl\VCLStylesInno.dll"; DestDir: {#VCLStylesSkinPath}; Flags: uninsneveruninstall
Source: "src\vcl\{#VCL}.vsf"; DestDir: {#VCLStylesSkinPath}; Flags: uninsneveruninstall

[Code]
Procedure LoadVCLStyle(VClStyleFile: String); external 'LoadVCLStyleW@files:VCLStylesInno.dll stdcall setuponly';
Procedure UnLoadVCLStyles(); external 'UnLoadVCLStyles@files:VCLStylesInno.dll stdcall setuponly';
// Import the UnLoadVCLStyles function for uninstall
Procedure LoadVCLStyle_UnInstall(VClStyleFile: String); external 'LoadVCLStyleW@{#VCLStylesSkinPath}\VCLStylesInno.dll stdcall uninstallonly';
Procedure UnLoadVCLStyles_UnInstall; external 'UnLoadVCLStyles@{#VCLStylesSkinPath}\VCLStylesInno.dll stdcall uninstallonly';

Procedure InitializeVCL();
begin
 ExtractTemporaryFile('{#VCL}.vsf');
 LoadVCLStyle(ExpandConstant('{tmp}\{#VCL}.vsf'));
end;
