#It`s necessarry to have environment variable "InnoSetupEx551U", "ZIP", "CURL", "BitbucketUserLogin", "BitbucketUserPassword"
#which contains full path to Compil32Ex.exe, 7z.exe, curl.exe applications and bitbucket-user login info

$outputFilename = "Kotyarko_O`s ModPack.zip"
$innoSetupEx551U = "$env:InnoSetupEx551U"
$zip = "$env:ZIP"
$curl = "$env:CURL"
$bitbucketUserLogin = "$env:BitbucketUserLogin"
$bitbucketUserPassword = "$env:BitbucketUserPassword"

Function PrepareBuild {
    Write-Host "Step: Prepairing..." -ForegroundColor Yellow
    
    Push-Location ".\MCTCreator"
    & ".\makeTextures.ps1"
    Pop-Location
    
    Push-Location "..\release"
    Remove-Item -Path ".\*.exe"
    if (Test-Path -Path ".\$outputFilename") {
        Remove-Item -Path ".\$outputFilename"
    }

    Write-Host ""
    Build
}

Function Build {
    Write-Host "Step: Building..." -ForegroundColor Yellow
    
    & "$innoSetupEx551U" -cc "..\main.iss"
        
    Write-Host ""
    AssembleArchive
}

Function AssembleArhive {
    Write-Host "Step: Archivating..." -ForegroundColor Yellow
    
    & "$zip" a -tzip "$outputFilename" ".\*.exe"
    
    Write-Host ""
	
}

Function ReleaseBuild {
    Write-Host "Step: Releasing build..." -ForegroundColor Yellow

    & "$curl" -s -u "$bitbucketUserLogin":"$bitbucketUserPassword" -X POST "https://api.bitbucket.org/2.0/repositories/Kotyarko_O/kmp/downloads" -F files=@".\$outputFilename",".\KMPServerUpd.xml",".\updaterServer.xml"

    Write-Host ""
}

PrepareBuild
Pause
