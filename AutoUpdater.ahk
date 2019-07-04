fullScriptPath = %1%  ; edit with your full script path
DetectHiddenWindows, On 
WinClose, %fullScriptPath% 
UrlDownloadToFile, %2%, %1%
Run, %1%
If (FileExist("%3%"))
	Run, %comspec% /c del "%3%"
Run, %comspec% /c del "%a_scriptname%"
exit ; when I don't exit here, it don't work
if errorlevel <> 0
   msgbox, 16, , Error! File %a_scriptname% not deleted. Errorlevel: %errorlevel%
else
   msgbox, File %a_scriptname% was deleted. Errorlevel: %errorlevel%
