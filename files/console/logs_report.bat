@Echo off

Set ReportFile=kmp_logs.zip

TaskKill /T /F /IM WorldOfTanks.exe
If EXIST %ReportFile% (DEL %ReportFile%)

@Echo .Set Cabinet=ON>>make.ddf
@Echo .Set CabinetNameTemplate=%ReportFile%>make.ddf
@Echo .Set Compress=ON>>make.ddf
@Echo .Set CompressionType=MSZIP>>make.ddf
@Echo .Set DiskDirectoryTemplate=".">>make.ddf
@Echo .Set MaxCabinetSize=2500000>>make.ddf

If EXIST ".\install_log.kmp"   (@Echo ".\install_log.kmp">>make.ddf)
If EXIST "..\win32\python.log" (@Echo "..\win32\python.log">>make.ddf)
If EXIST "..\win32\xvm.log"    (@Echo "..\win32\xvm.log">>make.ddf)
If EXIST "..\win32\pmod.log"   (@Echo "..\win32\pmod.log">>make.ddf)

MakeCab /F make.ddf

Del "make.ddf"
Del "setup.inf"
Del "setup.rpt"
