#SingleInstance force
SetTitleMatchMode, 2
#NoEnv
SendMode Input
SetBatchLines -1
#MaxThreadsPerHotkey 2
FileEncoding UTF-8

;=============== GLOBAL VAR ==================
Global currentversion := "1.7"
Global URLDownloadUpdaterAHK := "https://github.com/wawawawawawawa/WC3_Loader/raw/master/AutoUpdater.ahk"
Global URLDownloadUpdaterEXE := "https://github.com/wawawawawawawa/WC3_Loader/raw/master/AutoUpdater.exe"
Global URLDownloadAHK := "https://github.com/wawawawawawawa/WC3_Loader/raw/master/WC3 RPG Loader.ahk"
Global URLDownloadEXE := "https://github.com/wawawawawawawa/WC3_Loader/raw/master/WC3 RPG Loader.exe"
Global URLDownloadTrayIcon := "https://github.com/wawawawawawawa/WC3_Loader/raw/master/WC3 RPG Loader.ico"
SplitPath, A_ScriptName, OutFileName, OutDir, Extension, OutNameNoExt, OutDrive
Global URLCurrentLoader := A_ScriptDir . "\" . OutNameNoExt
Global URLCurrentUpdaterAHK := A_ScriptDir . "\AutoUpdater.ahk"
Global URLCurrentUpdaterEXE := A_ScriptDir . "\AutoUpdater.exe"
Global ININame := BuildIniName()
Global TrayIcon := "0"
RegRead, AHKInstallPath, HKLM, SOFTWARE\AutoHotkey, InstallDir ; AHK Installation Path

;=============== INI FILE ====================
ifNotExist, %A_ScriptDir%\%ININame%
{
	NoPath=
	IniWrite, %NoPath%, %A_ScriptDir%\%ININame%, Settings, HMPath
	IniWrite, %NoPath%, %A_ScriptDir%\%ININame%, Settings, GaiaPath
	IniWrite, %NoPath%, %A_ScriptDir%\%ININame%, Settings, TBR13Path
	IniWrite, %NoPath%, %A_ScriptDir%\%ININame%, Settings, TBR21Path
	IniWrite, %NoPath%, %A_ScriptDir%\%ININame%, Settings, TEVEPath
	IniWrite, 1, %A_ScriptDir%\%ININame%, Loader, RetrieveContent
	IniWrite, 1, %A_ScriptDir%\%ININame%, Loader, CheckUpdates
	IniWrite, Default, %A_ScriptDir%\%ININame%, Loader, GUIColor
	IniWrite, 0, %A_ScriptDir%\%ININame%, Loader, TrayOption
	IniWrite, %NoPath%, %A_ScriptDir%\%ININame%, Loader, WC3Path
}
IniRead, HMBuddyPath, %A_ScriptDir%\%ININame% , Settings, HMPath
IniRead, GaiaBuddyPath, %A_ScriptDir%\%ININame% , Settings, GaiaPath
IniRead, TBR13BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR13Path
IniRead, TBR21BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR21Path
IniRead, TEVEBuddyPath, %A_ScriptDir%\%ININame% , Settings, TEVEPath
IniRead, RetrieveContent, %A_ScriptDir%\%ININame% , Loader, RetrieveContent
IniRead, CheckUpdates, %A_ScriptDir%\%ININame% , Loader, CheckUpdates
IniRead, GUIColor, %A_ScriptDir%\%ININame% , Loader, GUIColor
IniRead, TrayOption, %A_ScriptDir%\%ININame% , Loader, TrayOption
IniRead, WC3Path, %A_ScriptDir%\%ININame% , Loader, WC3Path

If (GUIColor == "ERROR") {
	GUIColor := "Default"
	IniWrite, Default, %A_ScriptDir%\%ININame%, Loader, GUIColor
}
If (CheckUpdates == "ERROR") {
	CheckUpdates := "1"
	IniWrite, 1, %A_ScriptDir%\%ININame%, Loader, CheckUpdates
}
If (RetrieveContent == "ERROR") {
	RetrieveContent := "1"
	IniWrite, 1, %A_ScriptDir%\%ININame%, Loader, RetrieveContent
}
If (TrayOption == "ERROR") {
	TrayOption := "0"
	IniWrite, 0, %A_ScriptDir%\%ININame%, Loader, TrayOption
}
;////////////////////////////////////////// GUI //////////////////////////////////////////////////////////////////
;=============== MAIN GUI ====================
Gui 99:+LabelMainBuddy
Gui, MainBuddy:Font, cBlack s12
Gui, MainBuddy:Add, Tab3, vMainTab, Loaders|Backup|Settings
Gui, MainBuddy:Tab, 1
Gui, MainBuddy:Add, GroupBox, section h120 w265, Loaders : 
Gui, MainBuddy:Font, 
Gui, MainBuddy:Add, Button, xp10 yp25 w120 gGUIGaia, Gaia Loader
Gui, MainBuddy:Add, Button, xp125 w120 gGUIHM, HM Loader
Gui, MainBuddy:Add, Button, xp-125 yp30 w120 gGUITBR13, TBR 1.38 Loader
Gui, MainBuddy:Add, Button, xp125 w120 gGUITBR21, TBR 2.1 Loader
Gui, MainBuddy:Add, Button, xp-125 yp30 w120 gGUITEVE, TeveF Loader

Gui, MainBuddy:Tab, 2
Gui, MainBuddy:Font, cBlack s12
Gui, MainBuddy:Add, GroupBox, section h120 w265, Backup : 
Gui, MainBuddy:Font, 
Gui, MainBuddy:Add, Button, xp10 yp25 w120 gCreateBackup, Create Backup
Gui, MainBuddy:Add, Button, xp125 w120 gRestoreBackup, Restore Backup

Gui, MainBuddy:Tab, 3
Gui, MainBuddy:Font, cBlack s12
Gui, MainBuddy:Add, GroupBox, section h120 w265, Settings : 
Gui, MainBuddy:Font, 
Gui, MainBuddy:Add, CheckBox, xp10 yp25 vGetContentBox gContentSetting Checked%RetrieveContent%, Allow Retrieve Content (Char Information Panel)
Gui, MainBuddy:Add, CheckBox, yp20 vCheckUpdatesBox gUpdateSetting Checked%CheckUpdates%, Check for updates on launch
Gui, MainBuddy:Add, CheckBox, yp20 vCheckTrayBox gTraySetting Checked%TrayOption%, Enable Launch Wc3 (Taskbar)
Gui, MainBuddy:Add, Button, x+5 yp-5 vSetPathButton gSetWC3Path Checked%TrayOption%, Set WC3 Path
Gui, MainBuddy:Add, Text, xs+10 yp30 , GUI Theme :
Gui, MainBuddy:Add, DropDownList, yp-4 x+5 w100 gChangeColor vColorChoice, Default||White|Silver|Gray|Teal|Green|Olive|Maroon|Purple|Fuchsia


Gui, MainBuddy:Tab, 
Gui, MainBuddy:Add, Button, xs-10 yp200 gUpdate, Check for updates
Gui, MainBuddy:Add, Link, xp180 yp5, Created by <a href="https://github.com/wawawawawawawa/WC3_Loader">Wawawa</a>
Gui, MainBuddy:+AlwaysOnTop

MainGUI = 1
CurrentGUI = Main
;=============== UPDATE GUI ====================
Gui 98:+LabelUpdateBuddy
Gui, UpdateBuddy:Font, cBlue bold s10
Gui, UpdateBuddy:Add, GroupBox, w220 h110 section, Version Information :
Gui, UpdateBuddy:Font,
Gui, UpdateBuddy:Add, Text, xp10 yp25, Current Version :
Gui, UpdateBuddy:Font, bold 
Gui, UpdateBuddy:Add, Text, xp90, %currentversion%
Gui, UpdateBuddy:Font,
Gui, UpdateBuddy:Add, Text, yp25 xp-90, Latest Version : 
Gui, UpdateBuddy:Font, bold 
Gui, UpdateBuddy:Add, Text, xp90 vLoaderLastVer, Not Updated
Gui, UpdateBuddy:Font,
Gui, UpdateBuddy:Add, Button, gManualDownload xs+10 yp25 , Manual Download
Gui, UpdateBuddy:Add, Button, gAutoUpdate x+15 vGreyedButton, Automatic Install
Gui, UpdateBuddy:Add, Button, xs yp40 w50 h30 gBack, Back
Gui, UpdateBuddy:Add, Button, xp158 h30 gChangelog, Changelog
;=============== GAIA GUI ====================
Gui 1:+LabelGaiaBuddy
Gui, GaiaBuddy:Add, DropDownList, x5 y5 w120 vThiefchoice AltSubmit, |Thief
Gui, GaiaBuddy:Add, Button, x125 y4 w10 vThiefgo gLoadGaia, Go
Gui, GaiaBuddy:Add, DropDownList, x160 y5 w120 vBardchoice AltSubmit, |Bard
Gui, GaiaBuddy:Add, Button, x280 y4 w10 vBardgo gLoadGaia, Go
Gui, GaiaBuddy:Add, DropDownList, x315 y5 w120 vAssassinchoice AltSubmit, |Assassin
Gui, GaiaBuddy:Add, Button, x435 y4 w10 vAssassingo gLoadGaia, Go
Gui, GaiaBuddy:Add, DropDownList, x5 y35 w120 vClericchoice AltSubmit, |Cleric
Gui, GaiaBuddy:Add, Button, x125 y34 w10 vClericgo gLoadGaia, Go
Gui, GaiaBuddy:Add, DropDownList, x160 y35 w120 vBishopchoice AltSubmit, |Bishop
Gui, GaiaBuddy:Add, Button, x280 y34 w10 vBishopgo gLoadGaia, Go
Gui, GaiaBuddy:Add, DropDownList, x315 y35 w120 vMonkchoice AltSubmit, |Monk
Gui, GaiaBuddy:Add, Button, x435 y34 w10 vMonkgo gLoadGaia, Go
Gui, GaiaBuddy:Add, DropDownList, x5 y65 w120 vMagicianchoice AltSubmit, |Magician
Gui, GaiaBuddy:Add, Button, x125 y64 w10 vMagiciango gLoadGaia, Go
Gui, GaiaBuddy:Add, DropDownList, x160 y65 w120 vSorcererchoice AltSubmit, |Sorcerer
Gui, GaiaBuddy:Add, Button, x280 y64 w10 vSorcerergo gLoadGaia, Go
Gui, GaiaBuddy:Add, DropDownList, x315 y65 w120 vNecromancerchoice AltSubmit, |Necromancer
Gui, GaiaBuddy:Add, Button, x435 y64 w10 vNecromancergo gLoadGaia, Go
Gui, GaiaBuddy:Add, DropDownList, x5 y95 w120 vSquirechoice AltSubmit, |Squire
Gui, GaiaBuddy:Add, Button, x125 y94 w10 vSquirego gLoadGaia, Go
Gui, GaiaBuddy:Add, DropDownList, x160 y95 w120 vCrusaderchoice AltSubmit, |Crusader
Gui, GaiaBuddy:Add, Button, x280 y94 w10 vCrusadergo gLoadGaia, Go
Gui, GaiaBuddy:Add, DropDownList, x315 y95 w120 vBerserkerchoice AltSubmit, |Berserker
Gui, GaiaBuddy:Add, Button, x435 y94 w10 vBerserkergo gLoadGaia, Go
Gui, GaiaBuddy:Add, DropDownList, x5 y125 w120 vRangerchoice AltSubmit, |Ranger
Gui, GaiaBuddy:Add, Button, x125 y124 w10 vRangergo gLoadGaia, Go
Gui, GaiaBuddy:Add, DropDownList, x160 y125 w120 vDruidchoice AltSubmit, |Druid
Gui, GaiaBuddy:Add, Button, x280 y124 w10 vDruidgo gLoadGaia, Go
Gui, GaiaBuddy:Add, DropDownList, x315 y125 w120 vHunterchoice AltSubmit, |Hunter
Gui, GaiaBuddy:Add, Button, x435 y124 w10 vHuntergo gLoadGaia, Go
Gui, GaiaBuddy:Add, DropDownList, x5 y155 w120 vMysticchoice AltSubmit, |Mystic
Gui, GaiaBuddy:Add, Button, x125 y154 w10 vMysticgo gLoadGaia, Go
Gui, GaiaBuddy:Add, DropDownList, x160 y155 w120 vPsionchoice AltSubmit, |Psion
Gui, GaiaBuddy:Add, Button, x280 y154 w10 vPsiongo gLoadGaia, Go
Gui, GaiaBuddy:Add, DropDownList, x315 y155 w120 vHexbladechoice AltSubmit, |Hexblade
Gui, GaiaBuddy:Add, Button, x435 y154 w10 vHexbladego gLoadGaia, Go
Gui, GaiaBuddy:Add, DropDownList, x160 y185 w120 vValkyriechoice AltSubmit, |Valkyrie
Gui, GaiaBuddy:Add, Button, x280 y184 w10 vValkyriego gLoadGaia, Go
Gui, GaiaBuddy:Add, Button, x5 y215 w50 h40 gBack, Back
Gui, GaiaBuddy:Add, Button, x140 y215 w130 h40 gGaiaRefresh, Refresh
Gui, GaiaBuddy:Add, Button, x330 y215 w130 h40 gLoadGaiaVault, Vault
Gui, GaiaBuddy:Add, Button, x5 y265 h40 gChangeGaiaPath, Change Save Folder
Gui, GaiaBuddy:Add, Edit, x155 y265 w300 h40 vGaiaPathText ReadOnly, %GaiaBuddyPath%
Gui, GaiaBuddy:Show, Hide Center, Gaia Buddy (Press CTRL + F1 to Show/Hide)

GaiaGUI = 0
;=============== HM GUI ====================
Gui 2:+LabelHMBuddy
Gui, HMBuddy:Add, Text, x40 y5, Class Selection :
Gui, HMBuddy:Add, Text, x205 y5, Characters Available :
Gui, HMBuddy:Add, Text, x500 y5, Character Information :
Gui, HMBuddy:Add, ListBox, x5 y20 w150 h300 vhmclasschoice gHMChoice , 
Gui, HMBuddy:Add, ListBox, x160 y20 w200 h300 vhmclasslist gHMCharChoice AltSubmit, 
Gui, HMBuddy:Add, ListBox, x365 y20 w400 h300 vhmclassinfo gHMStatChoice AltSubmit, 
Gui, HMBuddy:Add, Button, x5 y320 w50 h40 gBack, Back
Gui, HMBuddy:Add, Button, x300 y320 w130 h40 gHMRefresh, Refresh
Gui, HMBuddy:Add, Button, x630 y320 w130 h40 gLoadHM, Load
Gui, HMBuddy:Add, Button, x5 y370 h40 gChangeHMPath, Change Save Folder
Gui, HMBuddy:Add, Edit, x155 y370 w300 h40 vHMPathText ReadOnly, %HMBuddyPath%
Gui, HMBuddy:Show, Hide Center, HM Buddy (Press CTRL + F1 to Show/Hide)

HMGUI = 0

Gui 2a:+LabelHMBuddyStat
Gui, HMBuddyStat:Add, Edit,vdata ReadOnly w600, 
Gui, HMBuddyStat:Show, Hide Center, Retrieve content
;=============== TBR GUI 1.38 ====================
Gui 3:+LabelTBR13Buddy
Gui, TBR13Buddy:Add, Text, x40 y5, Class Selection :
Gui, TBR13Buddy:Add, Text, x300 y5, Character Information :
Gui, TBR13Buddy:Add, ListBox, x5 y20 w150 h300 vtbr13classchoice gTBR13Choice AltSubmit, 
Gui, TBR13Buddy:Add, ListBox, x160 y20 w400 h300 vtbr13classinfo gTBR13StatChoice AltSubmit, 
Gui, TBR13Buddy:Add, Button, x5 y320 w50 h40 gBack, Back
Gui, TBR13Buddy:Add, Button, x159 y320 w130 h40 gTBR13Refresh, Refresh
Gui, TBR13Buddy:Add, Button, x431 y320 w130 h40 gLoadTBR13, Load
Gui, TBR13Buddy:Add, Button, x5 y370 h40 gChangeTBR13Path, Change Save Folder
Gui, TBR13Buddy:Add, Edit, x155 y370 w300 h40 vTBR13PathText ReadOnly, %TBR13BuddyPath%
Gui, TBR13Buddy:Show, Hide Center, TBR 1.38 Buddy (Press CTRL + F1 to Show/Hide)

TBR13GUI = 0

Gui 3a:+LabelTBR13BuddyStat
Gui, TBR13BuddyStat:Add, Edit,vTBR13data ReadOnly w600, 
Gui, TBR13BuddyStat:Show, Hide Center, Retrieve content
;=============== TBR GUI 2.1 ====================
Gui 4:+LabelTBR21Buddy
Gui, TBR21Buddy:Add, Text, x40 y5, Class Selection :
Gui, TBR21Buddy:Add, Text, x205 y5, Characters Available :
Gui, TBR21Buddy:Add, Text, x500 y5, Character Information :
Gui, TBR21Buddy:Add, ListBox, x5 y20 w150 h300 vtbr21classchoice gTBR21Choice , 
Gui, TBR21Buddy:Add, ListBox, x160 y20 w200 h300 vtbr21classlist gTBR21CharChoice AltSubmit, 
Gui, TBR21Buddy:Add, ListBox, x365 y20 w400 h300 vtbr21classinfo gTBR21StatChoice AltSubmit, 
Gui, TBR21Buddy:Add, Button, x5 y320 w50 h40 gBack, Back
Gui, TBR21Buddy:Add, Button, x275 y320 w130 h40 gTBR21Refresh, Refresh
Gui, TBR21Buddy:Add, Button, x636 y320 w130 h40 gLoadTBR21, Load
Gui, TBR21Buddy:Add, Button, x5 y370 h40 gChangeTBR21Path, Change Save Folder
Gui, TBR21Buddy:Add, Edit, x155 y370 w300 h40 vTBR21PathText ReadOnly, %TBR21BuddyPath%
Gui, TBR21Buddy:Show, Hide Center, TBR 2.1 Buddy (Press CTRL + F1 to Show/Hide)

TBR21GUI = 0

Gui 4a:+LabelTBR21BuddyStat
Gui, TBR21BuddyStat:Add, Edit,vTBR21data ReadOnly w600, 
Gui, TBR21BuddyStat:Show, Hide Center, Retrieve content
;=============== TEVE GUI ====================
Gui 5:+LabelTEVEBuddy
Gui, TEVEBuddy:Add, Text, x40 y5, Class Selection :
Gui, TEVEBuddy:Add, Text, x205 y5, Characters Available :
Gui, TEVEBuddy:Add, Text, x500 y5, Character Information :
Gui, TEVEBuddy:Add, ListBox, x5 y20 w150 h300 vteveclasschoice gTEVEChoice , 
Gui, TEVEBuddy:Add, ListBox, x160 y20 w200 h300 vteveclasslist gTEVECharChoice AltSubmit, 
Gui, TEVEBuddy:Add, ListBox, x365 y20 w400 h300 vteveclassinfo gTEVEStatChoice AltSubmit, 
Gui, TEVEBuddy:Add, Button, x5 y320 w50 h40 gBack, Back
Gui, TEVEBuddy:Add, Button, x275 y320 w130 h40 gTEVERefresh, Refresh
Gui, TEVEBuddy:Add, Button, x636 y320 w130 h40 gLoadTEVE, Load
Gui, TEVEBuddy:Add, Button, x5 y370 h40 gChangeTEVEPath, Change Save Folder
Gui, TEVEBuddy:Add, Edit, x155 y370 w300 h40 vTEVEPathText ReadOnly, %TEVEBuddyPath%
Gui, TEVEBuddy:Show, Hide Center, TeveF Buddy (Press CTRL + F1 to Show/Hide)

TEVEGUI = 0

Gui 5a:+LabelTEVEBuddyStat
Gui, TEVEBuddyStat:Add, Edit,vTEVEdata ReadOnly w600, 
Gui, TEVEBuddyStat:Show, Hide Center, Retrieve content

;=============== TRAY ICON ====================
Menu, TrayMenu, Add, Gaia Loader, GUIGaia
Menu, TrayMenu, Add, HM Loader, GUIHM
Menu, TrayMenu, Add, TBR 1.38 Loader, GUITBR13
Menu, TrayMenu, Add, TBR 2.1 Loader, GUITBR21
Menu, TrayMenu, Add, TeveF Loader, GUITEVE

Menu, Tray, Nostandard
Menu, Tray, Add, Show WC3 RPG Loader, ^F1
Menu, Tray, Default, Show WC3 RPG Loader
Menu, Tray, Add
Menu, Tray, Add, Loaders, :TrayMenu
Menu, Tray, Add
Menu, Tray, Add, Launch Warcraft III, GameLaunch
Menu, Tray, Add
Menu, Tray, Add, Reload Script, ReloadScript
Menu, Tray, Standard
Menu, Tray, Click, 1

;=============== STARTUP ====================
If FileExist("WC3 RPG Loader.ico")
{
	Menu, Tray, Icon , WC3 RPG Loader.ico
	TrayIcon := "1"
}
UpdateDone = 0
Gui, MainBuddy:Color, %GUIColor%
Gui, UpdateBuddy:Color, %GUIColor%
Gui, GaiaBuddy:Color, %GUIColor%
Gui, HMBuddy:Color, %GUIColor%
Gui, TBR13Buddy:Color, %GUIColor%
Gui, TBR21Buddy:Color, %GUIColor%
Gui, TEVEBuddy:Color, %GUIColor%
GuiControl, MainBuddy:ChooseString, ColorChoice, %GUIColor%

Gui, MainBuddy:Show, Center, Loader %currentversion% (Press CTRL + F1 to Show/Hide)
If (CheckUpdates = 1)
{
	GoSub, Update
}
If (TrayOption = 0)
{
	Menu, Tray, Disable, Launch Warcraft III
	GuiControl, MainBuddy:Disable, SetPathButton
}

return

;////////////////////////////////////////// UPDATER //////////////////////////////////////////////////////////////////
AutoUpdate:
{
	Gui UpdateBuddy:+OwnDialogs
	If (TrayIcon == "0")
	{
		MsgBox, 4, Optional Download, Do you want to a new shiny tray icon as well?
		IfMsgBox, Yes
		{
			UrlDownloadToFile, %URLDownloadTrayIcon%, %A_ScriptDir%\%OutNameNoExt%.ico
		}
	}
	If (Extension == "exe")
	{
		MsgBox, 4, Warning!, My .exe files are detected as Trojans by virustotal! (2/68, welp).`nDo you want to use the .ahk files instead? (0/68 from virustotal)`nYou can also easily look at the source code with Notepad on the ahk files (NotePad++ is even better :p)
		IfMsgBox, Yes
		{
			If (AHKInstallPath)
			{
				Progress, , , Downloading AutoUpdater..., AutoUpdater.ahk Download
				Sleep, 500
				UrlDownloadToFile, %URLDownloadUpdaterAHK%, %URLCurrentUpdaterAHK%
				Progress, 100 , ,Download Completed. Launching..., AutoUpdater.ahk Download Completed
				Sleep, 500
				Progress, Off
				NewLoaderURL = %URLCurrentLoader%.ahk
				DeleteOldEXE = %URLCurrentLoader%.exe
				
				Run %URLCurrentUpdaterAHK% "%NewLoaderURL%" "%URLDownloadAHK%" "%DeleteOldEXE%"
				ExitApp
			}
			Else
			{
				MsgBox, 4, Autohotkey Required, The ahk files requires Autohotkey to be installed.`nDo you want to download it?
				IfMsgBox, Yes
				{
					Progress, , , Downloading AutoHotkey..., AutoHotkey Download
					UrlDownloadToFile, http://www.autohotkey.com/download/AutoHotkeyInstall.exe, %A_Temp%\AutoHotkeyInstall.exe
					Progress, 100 , ,Download Completed. Launching..., AutoHotkey Download Completed
					Sleep, 200
					MsgBox, 4096,, WC3 RPG Loader will now minimize during the installation of AutoHotkey.
					Progress, Off
					Gui, MainBuddy:Show , Minimize
					Gui, UpdateBuddy:Show , Minimize
					RunWait, %A_Temp%\AutoHotkeyInstall.exe
					Gui, MainBuddy:Show , Restore
					Gui, UpdateBuddy:Show , Restore
					RegRead, AHKInstallPath, HKLM, SOFTWARE\AutoHotkey, InstallDir ; AHK Installation Path
					If (!AHKInstallPath)
					{
						Msgbox, 4096, ERROR, I can't find AutoHotkey Installation Path`nPlease use the Manual Download
					}
					Else
					{
						Msgbox, 4096, Installation, AutoHotkey Installed, now running the Auto Updater
						Progress, , , Downloading AutoUpdater..., AutoUpdater.ahk Download
						Sleep, 500
						UrlDownloadToFile, %URLDownloadUpdaterAHK%, %URLCurrentUpdaterAHK%
						Progress, 100 , ,Download Completed. Launching..., AutoUpdater.ahk Download Completed
						Sleep, 500
						Progress, Off
						NewLoaderURL = %URLCurrentLoader%.ahk
						DeleteOldEXE = %URLCurrentLoader%.exe
						
						Run %URLCurrentUpdaterAHK% "%NewLoaderURL%" "%URLDownloadAHK%" "%DeleteOldEXE%"
						ExitApp
					}
				}
			}
		}
		Else
		{
			MsgBox, 4, Optional Download, Do you want to download the .ahk file as well?
			IfMsgBox, Yes
			{
				UrlDownloadToFile, %URLDownloadAHK%, %A_ScriptDir%\%OutNameNoExt%.ahk
			}
			Progress, , , Downloading AutoUpdater..., AutoUpdater.exe Download
			Sleep, 500
			UrlDownloadToFile, %URLDownloadUpdaterEXE%, %URLCurrentUpdaterEXE%
			Progress, 100 , ,Download Completed. Launching..., AutoUpdater.exe Download Completed
			Sleep, 500
			Progress, Off
			NewLoaderURL = %URLCurrentLoader%.exe
			
			Run %URLCurrentUpdaterEXE% "%NewLoaderURL%" "%URLDownloadEXE%"
			ExitApp
		}
	}
	Else If (Extension == "ahk")
	{
		Progress, , , Downloading AutoUpdater..., AutoUpdater.ahk Download
		Sleep, 500
		UrlDownloadToFile, %URLDownloadUpdaterAHK%, %URLCurrentUpdaterAHK%
		Progress, 100 , ,Download Completed. Launching..., AutoUpdater.ahk Download Completed
		Sleep, 500
		Progress, Off
		NewLoaderURL = %URLCurrentLoader%.ahk
		
		Run %URLCurrentUpdaterAHK% "%NewLoaderURL%" "%URLDownloadAHK%"
		ExitApp
	}
}
return

ManualDownload:
{
	Run, https://github.com/wawawawawawawa/WC3_Loader/
}
return

Update:
{
	Gui MainBuddy:+OwnDialogs
	Gui, UpdateBuddy:+OwnerMainBuddy
	CheckInternetVar:= % IsInternetConnected()
	if (CheckInternetVar == 0)
	{
		If (UpdateDone == 1)
		{
			msgbox, 262208,No Network,Internet is NOT connected !
		}
	}
	else
	{
		CurrentGUI = Update
		GuiHideAllBut(CurrentGUI)
		url=https://raw.githubusercontent.com/wawawawawawawa/WC3_Loader/master/version.txt
		version := StrReplace(URLDownloadToVar(url), "`n", "")
		GuiControl, UpdateBuddy:, LoaderLastVer, %version%
		If (version != currentversion)
		{
			GuiControl, UpdateBuddy:Enable, GreyedButton
			Gui, UpdateBuddy:Show, Center, Update Available
			Gui, UpdateBuddy:+AlwaysOnTop
		}
		Else
		{
			If (UpdateDone == 1)
			{
				GuiControl, UpdateBuddy:Disable, GreyedButton				
				Gui, UpdateBuddy:Show, Center, Up To Date
				Gui, UpdateBuddy:+AlwaysOnTop
			}
		}
	}
	UpdateDone = 1
}
return

Changelog:
{
	url=https://raw.githubusercontent.com/wawawawawawawa/WC3_Loader/master/changelog.txt
	changelogtext := URLDownloadToVar(url)
	MsgBox, 4096, Changelog, %changelogtext%
}
return

;////////////////////////////////////////// GAIA //////////////////////////////////////////////////////////////////
;=============== GAIA CODE ====================
GaiaRefresh:
{
	; Empty Old Var
	IniRead, GaiaBuddyPath, %A_ScriptDir%\%ININame% , Settings, GaiaPath
	SetWorkingDir, %GaiaBuddyPath%
	
	Gaiacurrentclass=
	GaiaReplacedStr=
		
	GaiaArr := ["Cleric", "Magician", "Ranger", "Squire", "Thief", "Mystic", "Assassin", "Bard", "Berserker", "Bishop", "Crusader", "Druid", "Hunter", "Monk", "Necromancer", "Sorcerer", "Hexblade", "Psion", "Valkyrie", "Vault"]
	GaiaFile := {}
	GaiaClass := {}
	
	For i in GaiaArr
	{
		class := GaiaArr[i]
		GuiControl, GaiaBuddy:, %class%choice, |%class%
		GuiControl, GaiaBuddy:Choose, %class%choice, 1
	}
	
	If (GaiaBuddyPath)
	{
		GaiaFileList := {}

		Loop, Files, *.txt
		{
			GaiaFileList[A_index] := SubStr(A_LoopFileName, 1, -4)
			TheIndex := GaiaFileList[A_index]
			for i in GaiaArr
			{
				if (InStr(TheIndex, GaiaArr[i]) != 0)
				{
					Gaianame:=TheIndex
					GaiaFile.Push(Gaianame)
					GaiaClass.Push(GaiaArr[i])
				}
			}
		}
		
		for j in GaiaArr
		{
			for i in GaiaClass
			{
				Gaiacurrent := GaiaFile[i]
				if (GaiaClass[i] = GaiaArr[j])
				{
					classGaia := GaiaArr[j]
					if (!Gaiacurrentclass)
					{
						Gaiacurrentclass = %Gaiacurrent%
					}
					else {
						Gaiacurrentclass = %Gaiacurrent%|%Gaiacurrentclass%
					}
				}
			}
			if (Gaiacurrentclass)
			{
				GaiaReplacedStr := sortByNumberWithin(Gaiacurrentclass,"|")
				GaiaReplacedStr := StrReplace(GaiaReplacedStr, "|" , " | ")
				GaiaReplacedStr=| %GaiaReplacedStr%
				GuiControl, GaiaBuddy:, %classGaia%choice, %GaiaReplacedStr%
				GuiControl, GaiaBuddy:Choose, %classGaia%choice, 1
			}
			Gaiacurrentclass=
		}
	}
}
return

LoadGaia:
{
	IniRead, GaiaBuddyPath, %A_ScriptDir%\%ININame% , Settings, GaiaPath
	SetWorkingDir, %GaiaBuddyPath%
	GaiaSaveName :=  SubStr(A_GuiControl, 1, -2)
	GaiaSaveName = %GaiaSaveName%choice
	GuiControlGet, GaiaCurrentFile ,, %GaiaSaveName%, Text
	GaiaCurrentFile=%GaiaCurrentFile%
	GaiaCurrentFile = %GaiaCurrentFile%.txt
	GaiaCurrentPath = %GaiaBuddyPath%\%GaiaCurrentFile%
	if FileExist(GaiaCurrentPath)
	{		
		SetTitleMatchMode, 1
		If WinExist("Warcraft III")
		{
			FileReadLine, Gaiacode, %GaiaCurrentFile%, 3
			Gaiacode=%Gaiacode% 
			StringTrimLeft, Gaiacode, Gaiacode, 25 
			StringTrimRight, Gaiacode, Gaiacode, 7
			
			FileReadLine, Gaialvl, %GaiaCurrentFile%, 4
			Gaialvl=%Gaialvl%
			StringTrimLeft, Gaialvl, Gaialvl, 39
			StringTrimRight, Gaialvl, Gaialvl, 6
			
			WinActivate, Warcraft III
			Clipboard := "Loading : " . Gaialvl
			ClipWait, 200
			Send {esc}{Enter}^v{Enter}
			Sleep 200
			Clipboard := "-load " . Gaiacode
			ClipWait,200
			Send {esc}{Enter}^v{Enter} 
		}
		else
		{
			MsgBox, 262208, No Warcraft III, You need to open Warcraft III before loading !
		}
	}
	else
	{
		MsgBox, 262208, Invalid Save File, No Save Found !
	}
}
return
LoadGaiaVault:
{
	IniRead, GaiaBuddyPath, %A_ScriptDir%\%ININame% , Settings, GaiaPath
	SetWorkingDir, %GaiaBuddyPath%
	GaiaCurrentPath = %GaiaBuddyPath%\Vault.txt
	if FileExist(GaiaCurrentPath)
	{	
		SetTitleMatchMode, 1
		If WinExist("Warcraft III")
		{
			WinActivate, Warcraft III
			FileReadLine, Gaiacode, Vault.txt, 3
			StringTrimLeft, Gaiacode, Gaiacode, 20
			StringTrimRight, Gaiacode, Gaiacode, 7
			Sleep 200
			Clipboard := "Loading : Vault"
			ClipWait, 200
			Send {esc}{Enter}^v{Enter}
			Sleep 200
			Clipboard := Gaiacode
			ClipWait,200
			Send {esc}{Enter}^v{Enter}
		}
		else
		{
			MsgBox, 262208, No Warcraft III, You need to open Warcraft III before loading !
		}
		SetTitleMatchMode, 2
	}
	else
	{
		MsgBox, 262208, Invalid Save File, No Vault Found !
	}
}
return

;////////////////////////////////////////// HM //////////////////////////////////////////////////////////////////
;=============== HM CODE ====================
HMRefresh:
{
	; Empty Old Var
	IniRead, HMBuddyPath, %A_ScriptDir%\%ININame%, Settings, HMPath
	SetWorkingDir, %HMBuddyPath%
	GuiControl, HMBuddy:, hmclassinfo, |
	GuiControl, HMBuddy:, hmclasslist, |
	GuiControl, HMBuddy:, hmclasschoice, |
	
	HMClass := []
	HMClasses := []
	HMCodes := []
	HMStats := []
	HMLvl := []
	
	If (HMBuddyPath)
	{
		Loop, Files, *.txt
		{
			HMstart = 0
			Loop, 50
			{
				FileReadLine, HMfileline, %A_LoopFileName%, A_Index
				If (A_Index = 4)
				{
					HMcurrCode = %HMfileline%
					StringTrimLeft, HMcurrCode, HMcurrCode, 22
					StringTrimRight, HMcurrCode, HMcurrCode, 3
					HMCodes.Push(HMcurrCode)
				}
				if InStr(HMfileline, "Chat Message")
				{
					HMstart = 0
					HMfull = | FileName: %A_LoopFileName% %HMfull% | Code: %HMcurrCode%
					HMStats.Push(HMfull)
					GuiControl, HMBuddy:, hmclasschoice, %HMClassOption%
					GuiControl, HMBuddy:Choose, hmclasschoice, 1
					HMfull=
					Break
				}
				if (HMstart = 1)
				{
					HMcurrentline = %HMfileline%
					StringTrimLeft, HMcurrentline, HMcurrentline, 15
					StringTrimRight, HMcurrentline, HMcurrentline, 3
					HMcurrentline := StrReplace(HMcurrentline, "|" , " ")
					HMfull = %HMfull% | %HMcurrentline%
					if InStr(HMcurrentline, "Char:")
					{
						HMcurrChar = %HMfileline%
						StringTrimLeft, HMcurrChar, HMcurrChar, 21
						StringTrimRight, HMcurrChar, HMcurrChar, 3
						HMClass.Push(HMcurrChar)
						if (HMClassOption)
						{
							if InStr(HMClassOption, HMcurrChar)
							{
								
							}
							else
							{
								HMClassOption = %HMClassOption% | %HMcurrChar%
							}
						}
						else
						{
							HMClassOption = | %HMcurrChar%
						}
					}
					if InStr(HMcurrentline, "Lv:")
					{
						HMcurrLvl = %HMfileline%
						StringTrimLeft, HMcurrLvl, HMcurrLvl, 19
						StringTrimRight, HMcurrLvl, HMcurrLvl, 3
						HMClasses.Push(HMcurrChar " Lvl " HMcurrLvl)
						HMLvl.Push(HMcurrLvl)
					}
				}
				if InStr(HMfileline, "Data Stats")
				{
					HMstart = 1
				}
			}
		}
		HMClassOption=
	}
}
return

HMChoice:
{
	IniRead, HMBuddyPath, %A_ScriptDir%\%ININame%, Settings, HMPath
	SetWorkingDir, %HMBuddyPath%
	GuiControlGet, HMCurrentClass,, hmclasschoice, 
	HMCurrentStat := []
	HMCurrentCodes := []
	HMCurrentLvls := []
	for i in HMClass
	{
		HMcurr := HMClasses[i]
		HMCurrentClass=%HMCurrentClass%
		If InStr(HMcurr, HMCurrentClass)
		{
			HMCurrStats := HMStats[i]
			HMCurrentStat.Push(HMCurrStats)
			HMCurrCodes := HMCodes[i]
			HMCurrentCodes.Push(HMCurrCodes)
			HMCurrLvls := HMLvl[i]
			HMCurrentLvls.Push(HMCurrLvls)
		}
	}
	;;;; freaking sorting issue ;;;;;;;;
	for i in HMCurrentLvls
	{
		HMnewlvl := HMCurrentLvls[i]
		if (!HMlvllist)
		{
			HMlvllist = %HMnewlvl%
		}
		else
		{
			HMlvllist = %HMlvllist% `n%HMnewlvl%
		}
		HMnewcode := HMCurrentCodes[i]
		if (!HMcodelist)
		{
			HMcodelist = %HMnewcode%
		}
		else
		{
			HMcodelist = %HMcodelist% `n%HMnewcode%
		}
		HMnewstat := HMCurrentStat[i]
		if (!HMstatlist)
		{
			HMstatlist = %HMnewstat%
		}
		else
		{
			HMstatlist = %HMstatlist% `n%HMnewstat%
		}
	}
	HMObj := [HMlvllist, HMcodelist, HMstatlist]
	HMlvllist=
	HMsortingnonsense := new GroupSort(HMObj, "N R")
	HMArrLvls := StrSplit(HMsortingnonsense.fetch("1") , "`n")
	HMArrCodes := StrSplit(HMsortingnonsense.fetch("2") , "`n")
	HMArrStat := StrSplit(HMsortingnonsense.fetch("3") , "`n")
	for i in HMArrLvls {
		HMnewlvlvar := HMArrLvls[i]
		if (!HMlvllist)
		{
			HMlvllist = | Level: %HMnewlvlvar%
		}
		else
		{
			HMlvllist = %HMlvllist% | Level: %HMnewlvlvar%
		}
	}
	HMDefaultStat := HMArrStat[1]
	HMCurrentCode := HMArrCodes[1]
	GuiControl, HMBuddy:, hmclasslist, %HMlvllist%
	GuiControl, HMBuddy:Choose, hmclasslist, 1
	GuiControl, HMBuddy:, hmclassinfo, %HMDefaultStat%
	GuiControl, HMBuddy:Choose, hmclassinfo, 1
	HMlvllist=
	HMcodelist=
	HMstatlist=
}
return

HMCharChoice:
{
	IniRead, HMBuddyPath, %A_ScriptDir%\%ININame%, Settings, HMPath
	SetWorkingDir, %HMBuddyPath%
	GuiControlGet, HMCurrentCharNum,, hmclasslist,
	HMChosenStat := HMArrStat[HMCurrentCharNum]
	HMCurrentCode := HMArrCodes[HMCurrentCharNum]
	GuiControl, HMBuddy:, hmclassinfo, %HMChosenStat%
	GuiControl, HMBuddy:Choose, hmclassinfo, 1
}
return

HMStatChoice:
{
	If (RetrieveContent == 1)
	{
		IniRead, HMBuddyPath, %A_ScriptDir%\%ININame%, Settings, HMPath
		SetWorkingDir, %HMBuddyPath%
		GuiControlGet, HMCurrentStatNum,, hmclassinfo,
		GuiControlGet, HMCurrentCharNum,, hmclasslist,
		HMChosenStat := HMArrStat[HMCurrentCharNum]
		StringTrimLeft, HMChosenStat, HMChosenStat, 2
		HMArrStat2 := StrSplit(HMChosenStat , " | ")
		HMGetStat := HMArrStat2[HMCurrentStatNum]
		GuiControl, HMBuddyStat:, data, %HMGetStat%
		Gui, HMBuddyStat:Show
		Gui, HMBuddyStat:+AlwaysOnTop
	}
}
return

LoadHM:
{
	IniRead, HMBuddyPath, %A_ScriptDir%\%ININame%, Settings, HMPath
	SetWorkingDir, %HMBuddyPath%
	GuiControlGet, HMCurrentCharNum,, hmclasslist,
	GuiControlGet, HMCurrentClassName,, hmclasschoice,
	if (HMCurrentClassName && HMCurrentCharNum)
	{
		Clipboard := "Loading : " . HMCurrentClassName . " Level " . HMArrLvls[HMCurrentCharNum]
		SetTitleMatchMode, 1
		If WinExist("Warcraft III")
		{
			WinActivate, Warcraft III
			ClipWait, 200
			Send {esc}{Enter}^v{Enter}
			Sleep 200
			Send {esc}{enter}-load{enter}
			Sleep 1500
			Clipboard := HMCurrentCode
			ClipWait, 200
			Send {esc}{Enter}^v{Enter}
			Sleep 1500
			Send {enter}-cam 180{enter}
			Sleep 500
			Send {esc}{Enter}-c{Enter}
			Sleep 500
			Send {esc}{Enter}-b{Enter}
			Sleep 500
			Send {esc}{Enter}-a{Enter}
			Sleep 500
			Send {esc}{Enter}-e{Enter}
			Sleep 500
		}
		else
		{
			MsgBox, 262208, No Warcraft III, You need to open Warcraft III before loading !
		}
		SetTitleMatchMode, 2
	}
	else
	{
		MsgBox, 262208, Invalid Save File, You need to choose a Save !
	}
}
return

;////////////////////////////////////////// TBR 1.38 //////////////////////////////////////////////////////////////////
;=============== TBR 1.38 CODE ====================
TBR13Refresh:
{
	; Empty Old Var
	IniRead, TBR13BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR13Path
	SetWorkingDir, %TBR13BuddyPath%
	GuiControl, TBR13Buddy:, tbr13classinfo, |
	GuiControl, TBR13Buddy:, tbr13classchoice, |
	
	TBR13Char := []
	TBR13CharTXT := []
	TBR13CharList=
	
	If (TBR13BuddyPath)
	{
		Loop, Files, *.txt
		{
			TBR13CharTXT.Push(A_LoopFileName)
			FileReadLine, TBR13fileline, %A_LoopFileName%, 11
			StringTrimLeft, TBR13fileline, TBR13fileline, 9
			TBR13Char.Push(TBR13fileline)
			if (!TBR13CharList)
			{
				TBR13CharList= | %TBR13fileline%
			}
			else
			{
				TBR13CharList= %TBR13CharList% | %TBR13fileline%
			}
			GuiControl, TBR13Buddy:, tbr13classchoice, %TBR13CharList%
			GuiControl, TBR13Buddy:Choose, tbr13classchoice, 1
		}
	}
}
return
TBR13Choice:
{
	IniRead, TBR13BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR13Path
	SetWorkingDir, %TBR13BuddyPath%
	GuiControlGet, TBR13CurrentCharNum,, tbr13classchoice,
	TBR13CharStat := []
	TBR13CurrTXT := TBR13CharTXT[TBR13CurrentCharNum]
	TBR13StatList=
	Loop, 
	{
		FileReadLine, TBR13fileline, %TBR13CurrTXT%, A_Index
		If (A_Index > 10 && A_Index < 17)
		{
			StringTrimLeft, TBR13fileline, TBR13fileline, 2
			
			If (!TBR13StatList)
			{
				TBR13StatList = FileName: %TBR13CurrTXT%
				TBR13CharStat.Push(TBR13StatList)
				TBR13StatList = | FileName: %TBR13CurrTXT% | %TBR13fileline%
			}
			else
			{
				TBR13StatList = %TBR13StatList% | %TBR13fileline%
			}
			TBR13CharStat.Push(TBR13fileline)
		}
		If (A_Index > 16)
		{
			Break
		}
	}
	GuiControl, TBR13Buddy:, tbr13classinfo, %TBR13StatList%
	GuiControl, TBR13Buddy:Choose, tbr13classinfo, 1
}
return
TBR13StatChoice:
{
	If (RetrieveContent == 1)
	{
		IniRead, TBR13BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR13Path
		SetWorkingDir, %TBR13BuddyPath%
		GuiControlGet, TBR13CurrentStatNum,, tbr13classinfo,
		GuiControlGet, TBR13CurrentCharNum,, tbr13classchoice,
		TBR13ChosenStat := TBR13CharStat[TBR13CurrentStatNum]
		GuiControl, TBR13BuddyStat:, TBR13data, %TBR13ChosenStat%
		Gui, TBR13BuddyStat:Show
		Gui, TBR13BuddyStat:+AlwaysOnTop
	}
}
return
LoadTBR13:
{
	IniRead, TBR13BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR13Path
	SetWorkingDir, %TBR13BuddyPath%
	GuiControlGet, TBR13CurrentCharNum,, tbr13classchoice,
	if (TBR13CurrentCharNum && TBR13CharStat)
	{
		TBR13CurrTXT := TBR13CharTXT[TBR13CurrentCharNum]
		TBR13CurrCode := TBR13CharStat[6]
		StringTrimLeft, TBR13CurrCode, TBR13CurrCode, 6
		TBR13CurrBank := TBR13CharStat[7]
		StringTrimLeft, TBR13CurrBank, TBR13CurrBank, 6
		TBR13CurrClass := TBR13CharStat[2]
		StringTrimLeft, TBR13CurrClass, TBR13CurrClass, 7
		TBR13CurrLvl := TBR13CharStat[3]
		StringTrimLeft, TBR13CurrLvl, TBR13CurrLvl, 7
		Clipboard := "Loading : " . TBR13CurrClass . " Level " . TBR13CurrLvl
		SetTitleMatchMode, 1
		If WinExist("Warcraft III")
		{
			WinActivate, Warcraft III
			ClipWait, 200
			Send {esc}{Enter}^v{Enter}
			Sleep 200
			Clipboard := TBR13CurrCode
			ClipWait, 200
			Send {esc}{Enter}^v{Enter}
			Sleep 1000
			Clipboard := TBR13CurrBank
			ClipWait, 200
			Send {esc}{Enter}^v{Enter}
			Sleep 1000
		}
		else
		{
			MsgBox, 262208, No Warcraft III, You need to open Warcraft III before loading !
		}
		SetTitleMatchMode, 2
	}
	else
	{
		MsgBox, 262208, Invalid Save File, You need to choose a Save !
	}
}
return

;////////////////////////////////////////// TBR 2.1//////////////////////////////////////////////////////////////////
;=============== TBR 2.1 CODE ====================
TBR21Refresh:
{
	; Empty Old Var
	IniRead, TBR21BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR21Path
	SetWorkingDir, %TBR21BuddyPath%
	GuiControl, TBR21Buddy:, tbr21classinfo, |
	GuiControl, TBR21Buddy:, tbr21classlist, |
	GuiControl, TBR21Buddy:, tbr21classchoice, |
	
	TBR21Class := []
	TBR21Lvl := []
	TBR21XP := []
	TBR21Code := []
	TBR21CharTXT := []
	TBR21ClassList=
	
	If (TBR21BuddyPath)
	{
		Loop, Files, *.txt
		{
			TBR21CharTXT.Push(A_LoopFileName)
			Loop, 10
			{
				FileReadLine, TBR21fileline, %A_LoopFileName%, A_Index
				If InStr(TBR21fileline, "-load")
				{
					TBR21fileline := StrReplace(TBR21fileline, "`t" , "")
					break
				}
			}
			TBR21Code.Push(TBR21fileline)
			TBR21FileName := A_LoopFileName
			StringTrimRight, TBR21FileName, TBR21FileName, 4
			TBR21Curr := StrSplit(TBR21FileName , "; ")
			TBR21Class.Push(TBR21Curr[1])
			TBR21LvlNum := TBR21Curr[2]
			StringTrimLeft, TBR21LvlNum, TBR21LvlNum, 4
			TBR21Lvl.Push(TBR21LvlNum)
			TBR21TrueXP := TBR21Curr[3]
			If (StrLen(TBR21Curr[3]) < 7)
			{
				TBR21XPNUM := 7 - StrLen(TBR21Curr[3])
				Loop, %TBR21XPNUM%
				{
					TBR21TrueXP = 0%TBR21TrueXP%
				}
			}
			TBR21XP.Push(TBR21TrueXP)
			TBR21currChar := TBR21Class[A_Index]
			if (TBR21ClassList)
			{
				if InStr(TBR21ClassList, TBR21currChar)
				{
					
				}
				else
				{
					TBR21ClassList = %TBR21ClassList%|%TBR21currChar%
				}
			}
			else
			{
				TBR21ClassList = |%TBR21currChar%
			}
		}
		GuiControl, TBR21Buddy:, tbr21classchoice, %TBR21ClassList%
		GuiControl, TBR21Buddy:Choose, tbr21classchoice, 1
	}
}
return
TBR21Choice:
{
	IniRead, TBR21BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR21Path
	SetWorkingDir, %TBR21BuddyPath%
	GuiControlGet, TBR21CurrentClass,, tbr21classchoice, 
	TBR21LvlCurr := []
	TBR21XPCurr := []
	TBR21CodeCurr := []
	TBR21CharTXTCurr := []
	TBR21StatCurr := []
	for i in TBR21Class
	{
		TBR21curr := TBR21Class[i]
		If(TBR21curr = TBR21CurrentClass)
		{
			TBR21CurrTXT := TBR21CharTXT[i]
			TBR21CurrLvl := TBR21Lvl[i]
			TBR21CurrXP := TBR21XP[i]
			TBR21CurrCode := TBR21Code[i]
			TBR21CurrentStat = | FileName: %TBR21CurrTXT% | Level: %TBR21CurrLvl% | XP: %TBR21CurrXP% | Code: %TBR21CurrCode%
			TBR21CharTXTCurr.Push(TBR21CharTXT[i])
			TBR21LvlCurr.Push(TBR21Lvl[i])
			TBR21XPCurr.Push(TBR21XP[i])
			TBR21CodeCurr.Push(TBR21Code[i])
			TBR21StatCurr.Push(TBR21CurrentStat)
		}
	}
	;;;; freaking sorting issue ;;;;;;;;
	for i in TBR21XPCurr
	{
		TBR21newlvl := TBR21LvlCurr[i]
		if (!TBR21lvllist)
		{
			TBR21lvllist = %TBR21newlvl%
		}
		else
		{
			TBR21lvllist = %TBR21lvllist% `n%TBR21newlvl%
		}
		TBR21newcode := TBR21CodeCurr[i]
		if (!TBR21codelist)
		{
			TBR21codelist = %TBR21newcode%
		}
		else
		{
			TBR21codelist = %TBR21codelist% `n%TBR21newcode%
		}
		TBR21newstat := TBR21StatCurr[i]
		if (!TBR21statlist)
		{
			TBR21statlist = %TBR21newstat%
		}
		else
		{
			TBR21statlist = %TBR21statlist% `n%TBR21newstat%
		}
		
		TBR21newxp := TBR21XPCurr[i]
		if (!TBR21xplist)
		{
			TBR21xplist = %TBR21newxp%
		}
		else
		{
			TBR21xplist = %TBR21xplist% `n%TBR21newxp%
		}
		TBR21newtxt := TBR21CharTXTCurr[i]
		if (!TBR21txtlist)
		{
			TBR21txtlist = %TBR21newtxt%
		}
		else
		{
			TBR21txtlist = %TBR21txtlist% `n%TBR21newtxt%
		}
	}
	TBR21Obj := [TBR21xplist, TBR21codelist, TBR21statlist, TBR21lvllist, TBR21txtlist]
	TBR21lvllist=
	TBR21codelist=
	TBR21statlist=
	TBR21xplist=
	TBR21txtlist=
	TBR21sortingnonsense := new GroupSort(TBR21Obj, "N R")
	TBR21ArrXP := StrSplit(TBR21sortingnonsense.fetch("1") , "`n")
	TBR21ArrCodes := StrSplit(TBR21sortingnonsense.fetch("2") , "`n")
	TBR21ArrStat := StrSplit(TBR21sortingnonsense.fetch("3") , "`n")
	TBR21ArrLvls := StrSplit(TBR21sortingnonsense.fetch("4") , "`n")
	TBR21ArrTXT := StrSplit(TBR21sortingnonsense.fetch("5") , "`n")
	for i in TBR21ArrLvls {
		TBR21newlvlvar := TBR21ArrLvls[i]
		TBR21newxpvar := TBR21ArrXP[i]
		if (!TBR21lvllist)
		{
			TBR21lvllist = | Level: %TBR21newlvlvar% - XP: %TBR21newxpvar%
		}
		else
		{
			TBR21lvllist = %TBR21lvllist% | Level: %TBR21newlvlvar% - XP: %TBR21newxpvar%
		}
	}
	TBR21DefaultStat := TBR21ArrStat[1]
	TBR21CurrentCode := TBR21ArrCodes[1]
	GuiControl, TBR21Buddy:, tbr21classlist, %TBR21lvllist%
	GuiControl, TBR21Buddy:Choose, tbr21classlist, 1
	GuiControl, TBR21Buddy:, tbr21classinfo, %TBR21DefaultStat%
	GuiControl, TBR21Buddy:Choose, tbr21classinfo, 1
	TBR21lvllist=
}
return
TBR21CharChoice:
{
	IniRead, TBR21BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR21Path
	SetWorkingDir, %TBR21BuddyPath%
	GuiControlGet, TBR21CurrentCharNum,, tbr21classlist, 
	TBR21ChosenStat := TBR21ArrStat[TBR21CurrentCharNum]
	TBR21CurrentCode := TBR21ArrCodes[TBR21CurrentCharNum]
	GuiControl, TBR21Buddy:, tbr21classinfo, %TBR21ChosenStat%
	GuiControl, TBR21Buddy:Choose, tbr21classinfo, 1
}
return
TBR21StatChoice:
{
	If (RetrieveContent == 1)
	{
		IniRead, TBR21BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR21Path
		SetWorkingDir, %TBR21BuddyPath%
		GuiControlGet, TBR21CurrentStatNum,, tbr21classinfo,
		GuiControlGet, TBR21CurrentCharNum,, tbr21classlist,
		TBR21ChosenStat := TBR21ArrStat[TBR21CurrentCharNum]
		StringTrimLeft, TBR21ChosenStat, TBR21ChosenStat, 2
		TBR21ArrStat2 := StrSplit(TBR21ChosenStat , " | ")
		TBR21GetStat := TBR21ArrStat2[TBR21CurrentStatNum]
		GuiControl, TBR21BuddyStat:, TBR21data, %TBR21GetStat%
		Gui, TBR21BuddyStat:Show
		Gui, TBR21BuddyStat:+AlwaysOnTop
	}
}
return
LoadTBR21:
{
	IniRead, TBR21BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR21Path
	SetWorkingDir, %TBR21BuddyPath%
	GuiControlGet, TBR21CurrentChar,, tbr21classchoice,
	GuiControlGet, TBR21CurrentCharNum,, tbr21classlist,
	
	if (TBR21CurrentChar && TBR21CurrentCharNum)
	{
		TBR21CurrCode := TBR21ArrCodes[TBR21CurrentCharNum]
		TBR21CurrLvl := TBR21ArrLvls[TBR21CurrentCharNum]
		TBR21CurrClass := TBR21CurrentChar
		TBR21CurrXP := TBR21ArrXP[TBR21CurrentCharNum]
		Clipboard := "Loading : " . TBR21CurrClass . " - Level " . TBR21CurrLvl . " - XP " . TBR21CurrXP
		SetTitleMatchMode,1
		If WinExist("Warcraft III")
		{
			WinActivate, Warcraft III
			ClipWait, 200
			Send {esc}{Enter}^v{Enter}
			Sleep 200
			Clipboard := TBR21CurrCode
			ClipWait, 200
			Send {esc}{Enter}^v{Enter}
			Sleep 200
		}
		else
		{
			MsgBox, 262208, No Warcraft III, You need to open Warcraft III before loading !
		}
		SetTitleMatchMode, 2
	}
	else
	{
		MsgBox, 262208, Invalid Save File, You need to choose a Save !
	}
}
return

;////////////////////////////////////////// TeveF //////////////////////////////////////////////////////////////////
;=============== TeveF ====================
TEVERefresh:
{
	; Empty Old Var
	IniRead, TEVEBuddyPath, %A_ScriptDir%\%ININame% , Settings, TEVEPath
	SetWorkingDir, %TEVEBuddyPath%
	GuiControl, TEVEBuddy:, teveclassinfo, |
	GuiControl, TEVEBuddy:, teveclasslist, |
	GuiControl, TEVEBuddy:, teveclasschoice, |
	TEVEClasses := []
	TEVEFilePath := []
	TEVEFileName := []
	TEVEStats := []
	TEVECodes1 := []
	TEVECodes2 := []
	TEVEClassList=
	
	If (TEVEBuddyPath)
	{
		Loop, Files, *, D
		{
			TEVECurrClass := A_LoopFileName
			TEVEClassList = %TEVEClassList%|%A_LoopFileName%
			Loop, Files, %A_LoopFileLongPath%\*.txt
			{
				TEVEFilePath.Push(A_LoopFileLongPath)
				TEVEFileName.Push(A_LoopFileName)
				TEVEClasses.Push(TEVECurrClass)
				Loop, 35
				{
					FileReadLine, TEVEfileline, %A_LoopFileLongPath%, A_Index
					If InStr(TEVEfileline, "call Preload(")
					{
						TEVEcurrentline = %TEVEfileline%
						StringTrimLeft, TEVEcurrentline, TEVEcurrentline, 15
						StringTrimRight, TEVEcurrentline, TEVEcurrentline, 3
						TEVEcurrentline := StrReplace(TEVEcurrentline, "|" , " ")
						If InStr(TEVEcurrentline, "-load ")
						{
							TEVECodes1.Push(TEVEcurrentline)
						}
						If InStr(TEVEcurrentline, "-load2 ")
						{
							TEVECodes2.Push(TEVEcurrentline)
						}
						If (TEVEcurrentline != "        ")
						{
							TEVEfull = %TEVEfull% | %TEVEcurrentline%
						}
						Else
						{
							TEVEfull = | FileName: %A_LoopFileName% %TEVEfull%
							TEVEStats.Push(TEVEfull)
							TEVEfull=
							Break
						}
					}
				}
			}
		}
		GuiControl, TEVEBuddy:, teveclasschoice, %TEVEClassList%
		GuiControl, TEVEBuddy:Choose, teveclasschoice, 1
	}
}
return
TEVEChoice:
{
	IniRead, TEVEBuddyPath, %A_ScriptDir%\%ININame% , Settings, TEVEPath
	SetWorkingDir, %TEVEBuddyPath%
	GuiControlGet, TEVECurrentClass,, teveclasschoice, 
	TEVEStatCurr := []
	TEVECurrName=
	TEVECurrPath=
	TEVELvlCurr := []
	TEVECurrentCode1 := []
	TEVECurrentCode2 := []
	
	for i in TEVEClasses
	{
		TEVEcurr := TEVEClasses[i]
		TEVECurrentClass=%TEVECurrentClass%
		If InStr(TEVEcurr, TEVECurrentClass)
		{
			TEVECurrStats := TEVEStats[i]
			TEVEStatCurr.Push(TEVECurrStats)
			TEVECurrName := TEVEFileName[i]
			TEVELvlCurr.Push(SubStr(TEVECurrName, 5 , 3))
			TEVECurrCode1 := TEVECodes1[i]
			TEVECurrentCode1.Push(TEVECurrCode1)
			TEVECurrCode2 := TEVECodes2[i]
			TEVECurrentCode2.Push(TEVECurrCode2)
		}
	}
	
	;;;; freaking sorting issue ;;;;;;;;
	for i in TEVELvlCurr
	{
		TEVEnewlvl := TEVELvlCurr[i]
		if (!TEVElvllist)
		{
			TEVElvllist = %TEVEnewlvl%
		}
		else
		{
			TEVElvllist = %TEVElvllist% `n%TEVEnewlvl%
		}
		TEVEnewstat := TEVEStatCurr[i]
		if (!TEVEstatlist)
		{
			TEVEstatlist = %TEVEnewstat%
		}
		else
		{
			TEVEstatlist = %TEVEstatlist% `n%TEVEnewstat%
		}
		TEVEnewcode1 := TEVECurrentCode1[i]
		if (!TEVEcode1list)
		{
			TEVEcode1list = %TEVEnewcode1%
		}
		else
		{
			TEVEcode1list = %TEVEcode1list% `n%TEVEnewcode1%
		}
		TEVEnewcode2 := TEVECurrentCode2[i]
		if (!TEVEcode2list)
		{
			TEVEcode2list = %TEVEnewcode2%
		}
		else
		{
			TEVEcode2list = %TEVEcode2list% `n%TEVEnewcode2%
		}
	}
	TEVEObj := [TEVElvllist, TEVEstatlist, TEVEcode1list, TEVEcode2list]
	TEVElvllist=
	TEVEstatlist=
	TEVEcode1list=
	TEVEcode2list=
	TEVEsortingnonsense := new GroupSort(TEVEObj, "N R")
	TEVEArrLvls := StrSplit(TEVEsortingnonsense.fetch("1") , "`n")
	TEVEArrStat := StrSplit(TEVEsortingnonsense.fetch("2") , "`n")
	TEVEArrCode1 := StrSplit(TEVEsortingnonsense.fetch("3") , "`n")
	TEVEArrCode2 := StrSplit(TEVEsortingnonsense.fetch("4") , "`n")
	for i in TEVEArrLvls 
	{
		TEVEnewlvlvar := TEVEArrLvls[i]
		if (!TEVElvllist)
		{
			TEVElvllist = | Lv.%TEVEnewlvlvar%
		}
		else
		{
			TEVElvllist = %TEVElvllist% | Lv.%TEVEnewlvlvar%
		}
	}
	
	TEVEDefaultStat := TEVEArrStat[1]
	TEVECurrentCode1 := TEVEArrCode1[1]
	TEVECurrentCode2 := TEVEArrCode2[1]
	GuiControl, TEVEBuddy:, teveclasslist, %TEVElvllist%
	GuiControl, TEVEBuddy:Choose, teveclasslist, 1
	GuiControl, TEVEBuddy:, teveclassinfo, %TEVEDefaultStat%
	GuiControl, TEVEBuddy:Choose, teveclassinfo, 1
	TEVElvllist=
	TEVEstatlist=
	TEVEcode1list=
	TEVEcode2list=
}
return
TEVECharChoice:
{
	IniRead, TEVEBuddyPath, %A_ScriptDir%\%ININame% , Settings, TEVEPath
	SetWorkingDir, %TEVEBuddyPath%
	GuiControlGet, TEVECurrentCharNum,, teveclasslist, 
	TEVEChosenStat := TEVEArrStat[TEVECurrentCharNum]
	TEVECurrentCode1 := TEVEArrCode1[TEVECurrentCharNum]
	TEVECurrentCode2 := TEVEArrCode2[TEVECurrentCharNum]
	GuiControl, TEVEBuddy:, teveclassinfo, %TEVEChosenStat%
	GuiControl, TEVEBuddy:Choose, teveclassinfo, 1
}
return
TEVEStatChoice:
{
	If (RetrieveContent == 1)
	{
		IniRead, TEVEBuddyPath, %A_ScriptDir%\%ININame% , Settings, TEVEPath
		SetWorkingDir, %TEVEBuddyPath%
		GuiControlGet, TEVECurrentStatNum,, teveclassinfo,
		GuiControlGet, TEVECurrentCharNum,, teveclasslist,
		TEVEChosenStat := TEVEArrStat[TEVECurrentCharNum]
		StringTrimLeft, TEVEChosenStat, TEVEChosenStat, 2
		TEVEArrStat2 := StrSplit(TEVEChosenStat , " | ")
		TEVEGetStat := TEVEArrStat2[TEVECurrentStatNum]
		GuiControl, TEVEBuddyStat:, TEVEdata, %TEVEGetStat%
		Gui, TEVEBuddyStat:Show
		Gui, TEVEBuddyStat:+AlwaysOnTop
	}
}
return
LoadTEVE:
{
	IniRead, TEVEBuddyPath, %A_ScriptDir%\%ININame% , Settings, TEVEPath
	SetWorkingDir, %TEVEBuddyPath%
	GuiControlGet, TEVECurrentChar,, teveclasschoice,
	GuiControlGet, TEVECurrentCharNum,, teveclasslist,
	
	if (TEVECurrentChar && TEVECurrentCharNum)
	{
		TEVECurrCode1 := TEVEArrCode1[TEVECurrentCharNum]
		TEVECurrCode2 := TEVEArrCode2[TEVECurrentCharNum]
		TEVECurrLvl := TEVEArrLvls[TEVECurrentCharNum]
		TEVECurrClass := TEVECurrentChar
		Clipboard := "Loading : " . TEVECurrClass . " - Level " . TEVECurrLvl
		SetTitleMatchMode,1
		If WinExist("Warcraft III")
		{
			WinActivate, Warcraft III
			ClipWait, 200
			Send {esc}{Enter}^v{Enter}
			Sleep 200
			Clipboard := TEVECurrCode1
			ClipWait, 200
			Send {esc}{Enter}^v{Enter}
			Sleep 200
			Send {esc}{Enter}Loading Items :{Enter}
			Sleep 200
			Clipboard := TEVECurrCode2
			ClipWait, 200
			Send {esc}{Enter}^v{Enter}
			Sleep 200
		}
		else
		{
			MsgBox, 262208, No Warcraft III, You need to open Warcraft III before loading !
		}
		SetTitleMatchMode, 2
	}
	else
	{
		MsgBox, 262208, Invalid Save File, You need to choose a Save !
	}
}
return

;////////////////////////////////////////// UPDATER FUNCTIONS ///////////////////////////////////////////////////////////////
;https://autohotkey.com/board/topic/80587-how-to-find-internet-connection-status/page-2
;- Should be compatible with Win XP or higher, 32/64 bit, Unicode or ANSI, latest version.
IsInternetConnected()
{
	static sz := A_IsUnicode ? 408 : 204, addrToStr := "Ws2_32\WSAAddressToString" (A_IsUnicode ? "W" : "A")
	VarSetCapacity(wsaData, 408)
	if DllCall("Ws2_32\WSAStartup", "UShort", 0x0202, "Ptr", &wsaData)
	{
		return false
	}
	if DllCall("Ws2_32\GetAddrInfoW", "wstr", "dns.msftncsi.com", "wstr", "http", "ptr", 0, "ptr*", results)
	{
		DllCall("Ws2_32\WSACleanup")
		return false
	}
	ai_family   := NumGet(results+4, 0, "int")               ;- address family (ipv4 or ipv6)
	ai_addr     := Numget(results+16, 2*A_PtrSize, "ptr")      ;- binary ip address
	ai_addrlen  := Numget(results+16, 0, "ptr")             ;- length of ip
	DllCall(addrToStr, "ptr", ai_addr, "uint", ai_addrlen, "ptr", 0, "str", wsaData, "uint*", 204)
	DllCall("Ws2_32\FreeAddrInfoW", "ptr", results)
	DllCall("Ws2_32\WSACleanup")

	xxx := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	F1:="http://www.msftncsi.com/ncsi.txt"
	F2:="http://ipv6.msftncsi.com/ncsi.txt"
	xxx.SetTimeouts(500,500,500,500)
	try 
	{
		if (ai_family = 2 && wsaData = "131.107.255.255:80")
		xxx.Open("GET",F1)
		else if (ai_family = 23 && wsaData = "[fd3e:4f5a:5b81::1]:80")
		xxx.Open("GET",F2)
		else
		return false
		xxx.Send()
		return (xxx.ResponseText = "Microsoft NCSI")           ;-ncsi.txt will contain exactly this text otherwise=0
	} 
	catch e 
	{
		return false
	}
	return
}
return

URLDownloadToVar(url)
{
	obj:=ComObjCreate("WinHttp.WinHttpRequest.5.1"),obj.Open("GET",url),obj.Send()
	return obj.status=200?obj.ResponseText:""
}
return

;////////////////////////////////////////// SORTING FUNCTIONS ///////////////////////////////////////////////////////////////
;https://autohotkey.com/board/topic/32830-func-sort-by-numbers-within-a-string/
sortByNumberWithin(str,del)
{
  x=`````````````````

  loop,parse,str,%del%
  {
	RegExMatch( a_loopfield,"(\D*)(-?\d*)(.*)",nbr )
	nl.=strlen(nbr1) . ","
  }
  Sort nl,R N D,  
  StringSplit, mL,nl,`,  
  ml:=ml1

  astr=
  loop,parse,str,%del%
  {
	RegExMatch( a_loopfield,"([a-zA-Z]+|\D*)-?\d+",nbr ) ;([a-zA-Z]+)-?\d+ 
	sal:=ml-strlen(nbr1)+1
	sa:=substr(x,1,sal)
	astr.=sa . a_loopfield . ","
  }

  start:=ml+2 
  Sort astr,P%start% N D,  
  StringReplace, astr,astr,``,,all 
  StringReplace, astr,astr,`,,%del%,all 
  StringTrimRight, astr, astr, 1 
  return astr
}

;https://autohotkey.com/board/topic/95429-groupsort-sort-arrange-multiple-inter-related-lists-together/
class GroupSort
{
	;------------------------------------------
	;New GroupSort()
	;	object - The lists stored in a single object such that the host (parent) object occupies Index 1 and all others 2,3,4.....
	;	options - The options used for Sorting. For details, see the Sort command in Autohotkey help
	__New(object, options="")
	{
		if !Isobject(object)
			return -1

		m_item := object[1]
		m_delim := Substr(options, ( delim_isp := Instr(options, "D") )+1, 1) , m_delim := delim_isp ? m_delim : "`n"
		str_obj := {}

		loop % object.MaxIndex()-1 			;Adding alternative data to objects
		{
			temp := object[A_index+1] , tempobj := {}
			loop, parse, temp,% m_delim
				tempobj[A_index] := A_LoopField
			str_obj[A_index] := tempobj
		}

		length := 0	, len_obj := {}		;Get max m_item length
		loop, parse, m_item,% m_delim
			length := ( temp := StrLen(A_LoopField) ) > length ? temp : length , len_obj[A_index] := temp

		loop, parse, m_item,% m_delim		;Add tabs
			m_item2 .= A_LoopField this.Genitem("`t", length-len_obj[A_index]) A_space A_index m_delim 		;A_space is a security factor
		m_item2 := Substr(m_item2, 1, -Strlen(m_delim))

		Sort, m_item2,% options 		;Sort

		str_obj_ind := str_obj.MaxIndex()		;RE-ARRANGING ALL DATA

		loop, parse, m_item2,% m_delim
		{
			temp_ind := Substr(A_LoopField, Instr(A_LoopField, " ", 0, 0)+1)		
			temp_length := length - len_obj[temp_ind]
			m_item3 .= Substr(A_LoopField, 1, -temp_length-1-Strlen(temp_ind)) m_delim

			loop % str_obj_ind
				temp_obj := str_obj[A_index] , str_item%A_index% .= temp_obj[temp_ind] m_delim 		;str_item1,2,3... contains changed data
		}

		m_item3 := Rtrim(m_item3, m_delim) 		;Creating return object

		this.retobj := {}
		this.retobj[1] := m_item3

		loop % str_obj_ind
			this.retobj[A_index+1] := Rtrim(str_item%A_index%, m_delim)

		this.m_delim := m_delim 	;Used below
	}
	;-------------------------------------------------------
	;Sort()
	;	returns Sorted data in object format
	;	If columns=0, all the columns (LISTS) are returned in Object format with the parent list occupying Index 1 of the Object
	;	If columns is a CSV, then the matched coulums are returned such that the parent list is Column 1
	Sort(Columns=0) 		;Add many columns in CSV format
	{
		if !Columns
			return this.retobj
		else
		{
			retobj2 := {}
			loop, parse, Columns, `,,%A_space%%A_tab%
				this.retobj2[A_index] := this.retobj[A_LoopField]
			return this.retobj2
		}
	}
	;-------------------------------------------------------
	;Fetch()
	;	returns data in string format
	;	Columns = <same as in .Sort()>
	;	whitespaces = separation between different columns
	;	wh_item = the item that is repeated <whitespaces> times to give the separation
	Fetch(Columns=0, whitespaces=2, wh_item="`n")
	{
		delim := this.Genitem(wh_item, whitespaces)

		if !Columns
			loop % this.retobj.MaxIndex()
				toret .= this.retobj[A_Index] delim
		else
			loop, parse, Columns, `,
				toret .= this.retobj[A_LoopField] delim

		return Substr(toret, 1, -Strlen(delim))
	}
	;---------------------------------------------------------
	;HelpeR Functions
	Genitem(item, N){
		loop % N
			t .= item
		return t
	}
}
;============== HOTKEYS ===================
^F1::
If (%CurrentGUI%GUI = 1)
{
    Gui, %CurrentGUI%Buddy:Show, Hide
	%CurrentGUI%GUI = 0
}
Else 
{
	Gui, %CurrentGUI%Buddy:Show
	%CurrentGUI%GUI = 1
}
Return

;============== GUI ===================
GuiHideAllBut(ThisOne)
{
	GuiList := ["Main", "Gaia", "HM", "TBR13", "TBR21", "TEVE", "Update"]
	For i in GuiList
	{
		GUICurrent := GuiList[i]
		If (ThisOne != GUICurrent)
		{
			Gui, %GUICurrent%Buddy:Show, Hide
			%GUICurrent%GUI = 0
		}
		Else
		{
			Gui, %ThisOne%Buddy:Show
			Gui, %CurrentGUI%Buddy:+AlwaysOnTop
			%ThisOne%GUI = 1
		}
	}
}
return

Back:
{
	CurrentGUI = Main
	GuiHideAllBut(CurrentGUI)
}
return

GUIGaia:
{
	CurrentGUI = Gaia
	GuiHideAllBut(CurrentGUI)
	IniRead, GaiaBuddyPath, %A_ScriptDir%\%ININame%, Settings, GaiaPath
	SetWorkingDir, %GaiaBuddyPath%
	GoSub, GaiaRefresh
}
return

GUIHM:
{
	CurrentGUI = HM
	GuiHideAllBut(CurrentGUI)
	IniRead, HMBuddyPath, %A_ScriptDir%\%ININame%, Settings, HMPath
	SetWorkingDir, %HMBuddyPath%
	GoSub, HMRefresh
}
return

GUITBR13:
{
	CurrentGUI = TBR13
	GuiHideAllBut(CurrentGUI)
	IniRead, TBR13BuddyPath, %A_ScriptDir%\%ININame%, Settings, TBR13Path
	SetWorkingDir, %TBR13BuddyPath%
	GoSub, TBR13Refresh
}
return

GUITBR21:
{
	CurrentGUI = TBR21
	GuiHideAllBut(CurrentGUI)
	IniRead, TBR21BuddyPath, %A_ScriptDir%\%ININame%, Settings, TBR21Path
	SetWorkingDir, %TBR21BuddyPath%
	GoSub, TBR21Refresh
}
return

GUITEVE:
{
	CurrentGUI = TEVE
	GuiHideAllBut(CurrentGUI)
	IniRead, TEVEBuddyPath, %A_ScriptDir%\%ININame%, Settings, TEVEPath
	SetWorkingDir, %TEVEBuddyPath%
	GoSub, TEVERefresh
}
return

MainBuddyGuiClose:
{
	%CurrentGUI%GUI = 0
	Gui, %CurrentGUI%Buddy:Show, Hide
}
return

GaiaBuddyGuiClose:
{
	%CurrentGUI%GUI = 0
	Gui, %CurrentGUI%Buddy:Show, Hide
}
return

HMBuddyGuiClose:
{
	%CurrentGUI%GUI = 0
	Gui, %CurrentGUI%Buddy:Show, Hide
}
return

TBR13BuddyGuiClose:
{
	%CurrentGUI%GUI = 0
	Gui, %CurrentGUI%Buddy:Show, Hide
}
return

TBR21BuddyGuiClose:
{
	%CurrentGUI%GUI = 0
	Gui, %CurrentGUI%Buddy:Show, Hide
}
return

TEVEBuddyGuiClose:
{
	%CurrentGUI%GUI = 0
	Gui, %CurrentGUI%Buddy:Show, Hide
}
return

UpdateBuddyGuiClose:
{
	%CurrentGUI%GUI = 0
	Gui, %CurrentGUI%Buddy:Show, Hide
}
return

ReloadScript:
{
	Reload
}
return

;=============== BACKUP ====================
RestoreBackup:
{
	Gui MainBuddy:+OwnDialogs
	FileSelectFile, BackupPath,,, Choose the Backup.ini to Restore, *.ini
	If (BackupPath)
	{
		FileSelectFolder, RestorePath, 3,, Where do you want your Restored Saves to be? (Press Cancel to Skip)
	}
	GaiaRestorePath = %RestorePath%\Gaia Restored
	HMRestorePath = %RestorePath%\HM Restored
	TBR13RestorePath = %RestorePath%\TBR13 Restored
	TBR21RestorePath = %RestorePath%\TBR21 Restored
	TEVERestorePath = %RestorePath%\TEVE Restored
	
	If (RestorePath)
	{		
		name = Gaia
		IniRead, GaiaNum, %BackupPath%, Gaia, Count
		Loop, %GaiaNum%
		{
			IniRead, GaiaFile, %BackupPath%, Gaia, File%A_Index%
			IniRead, GaiaTxt, %BackupPath%, Gaia, Txt%A_Index%
			IniRead, GaiaSubPath, %BackupPath%, Gaia, SubPath%A_Index%
			GaiaTxt := StrReplace(GaiaTxt, "LINEBREAK" , "`n")
			GaiaTxt := StrReplace(GaiaTxt, "TABBREAK" , "`t")
			FileCreateDir, %GaiaRestorePath%%GaiaSubPath%
			FileDelete, %GaiaRestorePath%%GaiaSubPath%\%GaiaFile%
			FileAppend, %GaiaTxt%, %GaiaRestorePath%%GaiaSubPath%\%GaiaFile%
			Gaiaperc := (A_Index / %name%Num) * 100
			Progress, %Gaiaperc%, %GaiaFile%, Restoring %name% Backup..., %name% Backup
		}
		Progress, Off
	
		name = HM
		IniRead, HMNum, %BackupPath%, HM, Count
		Loop, %HMNum%
		{
			IniRead, HMFile, %BackupPath%, HM, File%A_Index%
			IniRead, HMTxt, %BackupPath%, HM, Txt%A_Index%
			IniRead, HMSubPath, %BackupPath%, HM, SubPath%A_Index%
			HMTxt := StrReplace(HMTxt, "LINEBREAK" , "`n")
			HMTxt := StrReplace(HMTxt, "TABBREAK" , "`t")
			FileCreateDir, %HMRestorePath%%HMSubPath%
			FileDelete, %HMRestorePath%%HMSubPath%\%HMFile%
			FileAppend, %HMTxt%, %HMRestorePath%%HMSubPath%\%HMFile%
			HMperc := (A_Index / %name%Num) * 100
			Progress, %HMperc%, %HMFile%, Restoring %name% Backup..., %name% Backup
		}
		Progress, Off
	
		name = TBR13
		IniRead, TBR13Num, %BackupPath%, TBR13, Count
		Loop, %TBR13Num%
		{
			IniRead, TBR13File, %BackupPath%, TBR13, File%A_Index%
			IniRead, TBR13Txt, %BackupPath%, TBR13, Txt%A_Index%
			IniRead, TBR13SubPath, %BackupPath%, TBR13, SubPath%A_Index%
			TBR13Txt := StrReplace(TBR13Txt, "LINEBREAK" , "`n")
			TBR13Txt := StrReplace(TBR13Txt, "TABBREAK" , "`t")
			FileCreateDir, %TBR13RestorePath%%TBR13SubPath%
			FileDelete, %TBR13RestorePath%%TBR13SubPath%\%TBR13File%
			FileAppend, %TBR13Txt%, %TBR13RestorePath%%TBR13SubPath%\%TBR13File%
			TBR13perc := (A_Index / %name%Num) * 100
			Progress, %TBR13perc%, %TBR13File%, Restoring %name% Backup..., %name% Backup
		}
		Progress, Off
		
		name = TBR21
		IniRead, TBR21Num, %BackupPath%, TBR21, Count
		Loop, %TBR21Num%
		{
			IniRead, TBR21File, %BackupPath%, TBR21, File%A_Index%
			IniRead, TBR21Txt, %BackupPath%, TBR21, Txt%A_Index%
			IniRead, TBR21SubPath, %BackupPath%, TBR21, SubPath%A_Index%
			TBR21Txt := StrReplace(TBR21Txt, "LINEBREAK" , "`n")
			TBR21Txt := StrReplace(TBR21Txt, "TABBREAK" , "`t")
			FileCreateDir, %TBR21RestorePath%%TBR21SubPath%
			FileDelete, %TBR21RestorePath%%TBR21SubPath%\%TBR21File%
			FileAppend, %TBR21Txt%, %TBR21RestorePath%%TBR21SubPath%\%TBR21File%
			TBR21perc := (A_Index / %name%Num) * 100
			Progress, %TBR21perc%, %TBR21File%, Restoring %name% Backup..., %name% Backup
		}
		Progress, Off
		
		name = TEVE
		IniRead, TEVENum, %BackupPath%, TEVE, Count
		
		Loop, %TEVENum%
		{
			IniRead, TEVEFile, %BackupPath%, TEVE, File%A_Index%
			IniRead, TEVETxt, %BackupPath%, TEVE, Txt%A_Index%
			IniRead, TEVESubPath, %BackupPath%, TEVE, SubPath%A_Index%
			TEVETxt := StrReplace(TEVETxt, "LINEBREAK" , "`n")
			TEVETxt := StrReplace(TEVETxt, "TABBREAK" , "`t")
			FileCreateDir, %TEVERestorePath%%TEVESubPath%
			FileDelete, %TEVERestorePath%%TEVESubPath%\%TEVEFile%
			FileAppend, %TEVETxt%, %TEVERestorePath%%TEVESubPath%\%TEVEFile%
			TEVEperc := (A_Index / %name%Num) * 100
			Progress, %TEVEperc%, %TEVEFile%, Restoring %name% Backup..., %name% Backup
		}
		Progress, Off
		
		MsgBox, 262208, Restoration Done, Backup Restored at %RestorePath%\
	}
}
return
CreateBackup:
{
	Gui MainBuddy:+OwnDialogs
	IniRead, GaiaBuddyPath, %A_ScriptDir%\%ININame% , Settings, GaiaPath
	IniRead, HMBuddyPath, %A_ScriptDir%\%ININame% , Settings, HMPath
	IniRead, TBR13BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR13Path
	IniRead, TBR21BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR21Path
	CreateBackupPath=
	FileSelectFolder, CreateBackupPath, 3,, Where do you want your Backup.ini to be created?
	If (CreateBackupPath)
	{
		FileDelete, %CreateBackupPath%\Backup.ini
		FileAppend,, %CreateBackupPath%\Backup.ini
		
		If (GaiaBuddyPath)
		{
			name = Gaia
			SetWorkingDir, %GaiaBuddyPath%
			Gaiacurrent := 0
			Gaiamax := 0
			Loop, Files, *.txt, D F R
			{
				Gaiamax++
			}
			Loop, Files, *.txt, D F R
			{
				Gaiacurrent++
				FileRead, GaiacurrBackup, %A_LoopFileLongPath%
				GaiacurrBackup := StrReplace(GaiacurrBackup, "`r`n" , "LINEBREAK")
				GaiacurrBackup := StrReplace(GaiacurrBackup, "`t" , "TABBREAK")
				GaiacurrBackup := StrReplace(GaiacurrBackup, "`n" , "LINEBREAK")
				GaiacurrBackup := StrReplace(GaiacurrBackup, "`r" , "LINEBREAK")
				GaiacurrSubPath := StrReplace(A_LoopFileLongPath, GaiaBuddyPath, "")
				GaiacurrSubPath := StrReplace(GaiacurrSubPath, A_LoopFileName, "")
				IniWrite, %GaiacurrSubPath%, %CreateBackupPath%\Backup.ini, %name%, SubPath%Gaiacurrent%
				IniWrite, %A_LoopFileName%, %CreateBackupPath%\Backup.ini, %name%, File%Gaiacurrent%
				IniWrite, %GaiacurrBackup%, %CreateBackupPath%\Backup.ini, %name%, Txt%Gaiacurrent%
				Gaiaperc := (A_Index / Gaiamax) * 100
				Progress, %Gaiaperc%, %A_LoopFileName%, Creating %name% Backup..., %name% Backup
			}
			IniWrite, %Gaiacurrent%, %CreateBackupPath%\Backup.ini, %name%, Count
			Progress, Off
		}
		If (HMBuddyPath)
		{		
			name = HM
			SetWorkingDir, %HMBuddyPath%
			HMcurrent := 0
			HMmax := 0
			Loop, Files, *.txt, D F R
			{
				HMmax++
			}
			Loop, Files, *.txt, D F R
			{
				HMcurrent++
				FileRead, HMcurrBackup, %A_LoopFileLongPath%
				HMcurrBackup := StrReplace(HMcurrBackup, "`r`n" , "LINEBREAK")
				HMcurrBackup := StrReplace(HMcurrBackup, "`t" , "TABBREAK")
				HMcurrBackup := StrReplace(HMcurrBackup, "`n" , "LINEBREAK")
				HMcurrBackup := StrReplace(HMcurrBackup, "`r" , "LINEBREAK")
				HMcurrSubPath := StrReplace(A_LoopFileLongPath, HMBuddyPath, "")
				HMcurrSubPath := StrReplace(HMcurrSubPath, A_LoopFileName, "")
				IniWrite, %HMcurrSubPath%, %CreateBackupPath%\Backup.ini, %name%, SubPath%HMcurrent%
				IniWrite, %A_LoopFileName%, %CreateBackupPath%\Backup.ini, %name%, File%HMcurrent%
				IniWrite, %HMcurrBackup%, %CreateBackupPath%\Backup.ini, %name%, Txt%HMcurrent%
				HMperc := (A_Index / HMmax) * 100
				Progress, %HMperc%, %A_LoopFileName%, Creating %name% Backup..., %name% Backup
			}
			IniWrite, %HMcurrent%, %CreateBackupPath%\Backup.ini, %name%, Count
			Progress, Off
		}
		If (TBR13BuddyPath)
		{
			name = TBR13
			SetWorkingDir, %TBR13BuddyPath%
			TBR13current := 0
			TBR13max := 0
			Loop, Files, *.txt, D F R
			{
				TBR13max++
			}
			Loop, Files, *.txt, D F R
			{
				TBR13current++
				FileRead, TBR13currBackup, %A_LoopFileLongPath%
				TBR13currBackup := StrReplace(TBR13currBackup, "`r`n" , "LINEBREAK")
				TBR13currBackup := StrReplace(TBR13currBackup, "`t" , "TABBREAK")
				TBR13currBackup := StrReplace(TBR13currBackup, "`n" , "LINEBREAK")
				TBR13currBackup := StrReplace(TBR13currBackup, "`r" , "LINEBREAK")
				TBR13currSubPath := StrReplace(A_LoopFileLongPath, TBR13BuddyPath, "")
				TBR13currSubPath := StrReplace(TBR13currSubPath, A_LoopFileName, "")
				IniWrite, %TBR13currSubPath%, %CreateBackupPath%\Backup.ini, %name%, SubPath%TBR13current%
				IniWrite, %A_LoopFileName%, %CreateBackupPath%\Backup.ini, %name%, File%TBR13current%
				IniWrite, %TBR13currBackup%, %CreateBackupPath%\Backup.ini, %name%, Txt%TBR13current%
				TBR13perc := (A_Index / TBR13max) * 100
				Progress, %TBR13perc%, %A_LoopFileName%, Creating %name% Backup..., %name% Backup
			}
			IniWrite, %TBR13current%, %CreateBackupPath%\Backup.ini, %name%, Count
			Progress, Off
		}
		If (TBR21BuddyPath)
		{
			name = TBR21
			SetWorkingDir, %TBR21BuddyPath%
			TBR21current := 0
			TBR21max := 0
			Loop, Files, *.txt, D F R
			{
				TBR21max++
			}
			Loop, Files, *.txt, D F R
			{
				TBR21current++
				FileRead, TBR21currBackup, %A_LoopFileLongPath%
				TBR21currBackup := StrReplace(TBR21currBackup, "`r`n" , "LINEBREAK")
				TBR21currBackup := StrReplace(TBR21currBackup, "`t" , "TABBREAK")
				TBR21currBackup := StrReplace(TBR21currBackup, "`n" , "LINEBREAK")
				TBR21currBackup := StrReplace(TBR21currBackup, "`r" , "LINEBREAK")
				TBR21currSubPath := StrReplace(A_LoopFileLongPath, TBR21BuddyPath, "")
				TBR21currSubPath := StrReplace(TBR21currSubPath, A_LoopFileName, "")
				IniWrite, %TBR21currSubPath%, %CreateBackupPath%\Backup.ini, %name%, SubPath%TBR21current%
				IniWrite, %A_LoopFileName%, %CreateBackupPath%\Backup.ini, %name%, File%TBR21current%
				IniWrite, %TBR21currBackup%, %CreateBackupPath%\Backup.ini, %name%, Txt%TBR21current%
				TBR21perc := (A_Index / TBR21max) * 100
				Progress, %TBR21perc%, %A_LoopFileName%, Creating %name% Backup..., %name% Backup
			}
			IniWrite, %TBR21current%, %CreateBackupPath%\Backup.ini, %name%, Count
			Progress, Off
		}
		If (TEVEBuddyPath)
		{
			name = TEVE
			SetWorkingDir, %TEVEBuddyPath%
			TEVEcurrent := 0
			TEVEmax := 0
			Loop, Files, *.txt, D F R
			{
				TEVEmax++
			}
			Loop, Files, *.txt, D F R
			{
				TEVEcurrent++
				FileRead, TEVEcurrBackup, %A_LoopFileLongPath%
				TEVEcurrBackup := StrReplace(TEVEcurrBackup, "`r`n" , "LINEBREAK")
				TEVEcurrBackup := StrReplace(TEVEcurrBackup, "`t" , "TABBREAK")
				TEVEcurrBackup := StrReplace(TEVEcurrBackup, "`n" , "LINEBREAK")
				TEVEcurrBackup := StrReplace(TEVEcurrBackup, "`r" , "LINEBREAK")
				TEVEcurrSubPath := StrReplace(A_LoopFileLongPath, TEVEBuddyPath, "")
				TEVEcurrSubPath := StrReplace(TEVEcurrSubPath, A_LoopFileName, "")
				IniWrite, %TEVEcurrSubPath%, %CreateBackupPath%\Backup.ini, %name%, SubPath%TEVEcurrent%
				IniWrite, %A_LoopFileName%, %CreateBackupPath%\Backup.ini, %name%, File%TEVEcurrent%
				IniWrite, %TEVEcurrBackup%, %CreateBackupPath%\Backup.ini, %name%, Txt%TEVEcurrent%
				TEVEperc := (A_Index / TEVEmax) * 100
				Progress, %TEVEperc%, %A_LoopFileName%, Creating %name% Backup..., %name% Backup
			}
			IniWrite, %TEVEcurrent%, %CreateBackupPath%\Backup.ini, %name%, Count
			Progress, Off
		}
		MsgBox, 262208, Backup Done, Backup Saved at %CreateBackupPath%\Backup.ini
	}
}
return

;============== CHANGE PATH =================
ChangeGaiaPath:
{
	Gui GaiaBuddy:+OwnDialogs
	IfExist, %A_MyDocuments%\Warcraft III\CustomMapData\GaiasRetaliation
	{
		FileSelectFolder, GaiaBuddyPath, *%A_MyDocuments%\Warcraft III\CustomMapData\GaiasRetaliation\,, Choose The Folder with Gaia Saves
	}
	else
	{
		FileSelectFolder, GaiaBuddyPath,,, Choose The Folder with Gaia Saves
	}
	IniWrite, %GaiaBuddyPath%, %A_ScriptDir%\%ININame%, Settings, GaiaPath
	GuiControl, GaiaBuddy:, GaiaPathText, %GaiaBuddyPath%
}
return

ChangeHMPath:
{
	Gui HMBuddy:+OwnDialogs
	IfExist, %A_MyDocuments%\Warcraft III\CustomMapData\Grabiti's RPG Creator
	{
		FileSelectFolder, HMBuddyPath, *%A_MyDocuments%\Warcraft III\CustomMapData\Grabiti's RPG Creator, 3, Choose The Folder with HM Saves
	}
	else
	{
		FileSelectFolder, HMBuddyPath, , 3, Choose The Folder with HM Saves
	}
	IniWrite, %HMBuddyPath%, %A_ScriptDir%\%ININame%, Settings, HMPath
	GuiControl, HMBuddy:, HMPathText, %HMBuddyPath%
}
return

ChangeTBR13Path:
{
	Gui TBR13Buddy:+OwnDialogs
	IfExist, %A_MyDocuments%\Warcraft III\CustomMapData\TBR Saves\
	{
		FileSelectFolder, TBR13BuddyPath, *%A_MyDocuments%\Warcraft III\CustomMapData\TBR Saves\,, Choose The Folder with TBR 1.38 Saves
	}
	else
	{
		FileSelectFolder, TBR13BuddyPath,,, Choose The Folder with TBR 1.38 Saves
	}
	IniWrite, %TBR13BuddyPath%, %A_ScriptDir%\%ININame%, Settings, TBR13Path
	GuiControl, TBR13Buddy:, TBR13PathText, %TBR13BuddyPath%
}
return

ChangeTBR21Path:
{
	Gui TBR21Buddy:+OwnDialogs
	IfExist, %A_MyDocuments%\Warcraft III\CustomMapData\Savegames\TBR 2
	{
		FileSelectFolder, TBR21BuddyPath, *%A_MyDocuments%\Warcraft III\CustomMapData\Savegames\TBR 2\,, Choose The Folder with TBR 2.1 Saves
	}
	else
	{
		FileSelectFolder, TBR21BuddyPath,,, Choose The Folder with TBR 2.1 Saves
	}
	IniWrite, %TBR21BuddyPath%, %A_ScriptDir%\%ININame%, Settings, TBR21Path
	GuiControl, TBR21Buddy:, TBR21PathText, %TBR21BuddyPath%
}
return

ChangeTEVEPath:
{
	Gui TEVEBuddy:+OwnDialogs
	IfExist, %A_MyDocuments%\Warcraft III\CustomMapData\TeveF_R4\
	{
		FileSelectFolder, TEVEBuddyPath, *%A_MyDocuments%\Warcraft III\CustomMapData\TeveF_R4\,, Choose The Folder with TeveF Saves
	}
	else
	{
		FileSelectFolder, TEVEBuddyPath,,, Choose The Folder with TeveF Saves
	}
	IniWrite, %TEVEBuddyPath%, %A_ScriptDir%\%ININame%, Settings, TEVEPath
	GuiControl, TEVEBuddy:, TEVEPathText, %TEVEBuddyPath%
}
return

;============== SETTINGS =================
ChangeColor:
{
	GuiControlGet, color,, ColorChoice
	Gui, MainBuddy:Color, %color%
	Gui, UpdateBuddy:Color, %color%
	Gui, GaiaBuddy:Color, %color%
	Gui, HMBuddy:Color, %color%
	Gui, TBR13Buddy:Color, %color%
	Gui, TBR21Buddy:Color, %color%
	Gui, TEVEBuddy:Color, %color%
	IniWrite, %color%, %A_ScriptDir%\%ININame%, Loader, GUIColor
}
return

ContentSetting:
{
	GuiControlGet, CheckContent,, GetContentBox
	IniWrite, %CheckContent%, %A_ScriptDir%\%ININame%, Loader, RetrieveContent
	IniRead, RetrieveContent, %A_ScriptDir%\%ININame% , Loader, RetrieveContent
}
return

UpdateSetting:
{
	GuiControlGet, UpdateOption,, CheckUpdatesBox
	IniWrite, %UpdateOption%, %A_ScriptDir%\%ININame%, Loader, CheckUpdates
}
return

GameLaunch:
{
	If(WC3Path && TrayOption = 1)
	{
		Run, %WC3Path%
	}
}
return

TraySetting:
{
	GuiControlGet, CurrentTrayOption ,, CheckTrayBox
	IniWrite, %CurrentTrayOption%, %A_ScriptDir%\%ININame%, Loader, TrayOption
	IniRead, TrayOption, %A_ScriptDir%\%ININame% , Loader, TrayOption
	If (TrayOption = 1)
	{
		Menu, Tray, Enable, Launch Warcraft III
		GuiControl, MainBuddy:Enable, SetPathButton
	}
	Else
	{
		Menu, Tray, Disable, Launch Warcraft III
		GuiControl, MainBuddy:Disable, SetPathButton
	}
}
return

SetWC3Path:
{
	IfExist, %ProgramFiles%\Warcraft III\
	{
		FileSelectFile, WC3Path, *%ProgramFiles%\Warcraft III\, 3, Show your Warcraft3.exe location
	}
	else
	{
		FileSelectFile, WC3Path, , 3, Show your Warcraft3.exe location
	}
	IniWrite, %WC3Path%, %A_ScriptDir%\%ININame%, Loader, WC3Path
	IniRead, WC3Path, %A_ScriptDir%\%ININame%, Loader, WC3Path
}
return

;============== BUILD INI =================
; Takes the start of the file name (before .ini or .exe and replaces it with .ini)
BuildIniName(){
tmp := A_Scriptname
Stringsplit, tmp, tmp,.
ini_nameini_name := ""
last := ""
Loop, % tmp0
{
	; build the string up to the last period (.)
	if (last != ""){
		if (ini_name != ""){
			ini_name := ini_name "."
		}
		ini_name := ini_name last
	}
	last := tmp%A_Index%
}
return ini_name ".ini"
}
