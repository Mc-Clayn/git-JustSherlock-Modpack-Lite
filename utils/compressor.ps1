Pause

& ".\iCatalyst\iCatalyst.bat" /png:2 /jpg:2 "/outdir:false" "..\files\previews\*"

if (Test-Path -Path "..\mods\xvm\tank_icons") {
    & ".\iCatalyst\iCatalyst.bat" /png:2 "/outdir:false" "..\mods\xvm\tank_icons\*"
}

if (Test-Path -Path "..\mods\hangar\gold_prem_tanks\res") {
    & ".\iCatalyst\iCatalyst.bat" /png:2 "/outdir:false" "..\mods\hangar\gold_prem_tanks\res\*"
}

Write-Host ""
Pause
