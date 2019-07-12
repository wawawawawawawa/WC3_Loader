#SingleInstance force
SetTitleMatchMode, 2
#NoEnv
SendMode Input
SetBatchLines -1
#MaxThreadsPerHotkey 2
FileEncoding UTF-8

;=============== GLOBAL VAR ==================
Global currentversion := "2.2"
Global URLDownloadUpdaterAHK := "https://github.com/wawawawawawawa/WC3_Loader/raw/master/AutoUpdater.ahk"
Global URLDownloadUpdaterEXE := "https://github.com/wawawawawawawa/WC3_Loader/raw/master/AutoUpdater.exe"
Global URLDownloadAHK := "https://github.com/wawawawawawawa/WC3_Loader/raw/master/WC3 RPG Loader.ahk"
Global URLDownloadEXE := "https://github.com/wawawawawawawa/WC3_Loader/raw/master/WC3 RPG Loader.exe"
Global URLDownloadTrayIcon := "https://github.com/wawawawawawawa/WC3_Loader/raw/master/WC3 RPG Loader.ico"
SplitPath, A_ScriptName, OutFileName, OutDir, Extension, OutNameNoExt, OutDrive
Global URLCurrentLoader := A_ScriptDir . "\" . OutNameNoExt
Global URLCurrentUpdaterAHK := A_ScriptDir . "\AutoUpdater.ahk"
Global URLCurrentUpdaterEXE := A_ScriptDir . "\AutoUpdater.exe"
Global URLDownloadHoop := "https://github.com/wawawawawawawa/WC3_Loader/raw/master/Color/Hoop.png"
Global URLDownloadColor := "https://github.com/wawawawawawawa/WC3_Loader/raw/master/Color/"
Global ININame := BuildIniName()
Global TrayIcon := "0"
Global switch := "1"
Global GuiList := ["Main", "Gaia", "HM", "TBR13", "TBR21", "TEVE", "GOH", "Update", "CP"]

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
	IniWrite, %NoPath%, %A_ScriptDir%\%ININame%, Settings, GOHPath
	IniWrite, 1, %A_ScriptDir%\%ININame%, Loader, RetrieveContent
	IniWrite, 1, %A_ScriptDir%\%ININame%, Loader, CheckUpdates
	IniWrite, Default, %A_ScriptDir%\%ININame%, Loader, GUIColor
	IniWrite, 0, %A_ScriptDir%\%ININame%, Loader, TrayOption
	IniWrite, %NoPath%, %A_ScriptDir%\%ININame%, Loader, WC3Path
	IniWrite, Level, %A_ScriptDir%\%ININame%, Settings, HMSort
	IniWrite, Level, %A_ScriptDir%\%ININame%, Settings, TBR21Sort
	IniWrite, Level, %A_ScriptDir%\%ININame%, Settings, TEVESort
	IniWrite, Level, %A_ScriptDir%\%ININame%, Settings, GOHSort
}
IniRead, HMBuddyPath, %A_ScriptDir%\%ININame% , Settings, HMPath
IniRead, GaiaBuddyPath, %A_ScriptDir%\%ININame% , Settings, GaiaPath
IniRead, TBR13BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR13Path
IniRead, TBR21BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR21Path
IniRead, TEVEBuddyPath, %A_ScriptDir%\%ININame% , Settings, TEVEPath
IniRead, GOHBuddyPath, %A_ScriptDir%\%ININame% , Settings, GOHPath
IniRead, RetrieveContent, %A_ScriptDir%\%ININame% , Loader, RetrieveContent, 1
IniRead, CheckUpdates, %A_ScriptDir%\%ININame% , Loader, CheckUpdates, 1
IniRead, GUIColor, %A_ScriptDir%\%ININame% , Loader, GUIColor, Default
IniRead, TrayOption, %A_ScriptDir%\%ININame% , Loader, TrayOption, 0
IniRead, WC3Path, %A_ScriptDir%\%ININame% , Loader, WC3Path
IniRead, HMSortVar, %A_ScriptDir%\%ININame% , Settings, HMSort
IniRead, TBR21SortVar, %A_ScriptDir%\%ININame% , Settings, TBR21Sort
IniRead, TEVESortVar, %A_ScriptDir%\%ININame% , Settings, TEVESort
IniRead, GOHSortVar, %A_ScriptDir%\%ININame% , Settings, GOHSort
IniRead, GOHC1, %A_ScriptDir%\%ININame% , Settings, GOHC1
IniRead, GOHC2, %A_ScriptDir%\%ININame% , Settings, GOHC2
IniRead, GOHC3, %A_ScriptDir%\%ININame% , Settings, GOHC3
IniRead, GOHC4, %A_ScriptDir%\%ININame% , Settings, GOHC4
IniRead, HMC1, %A_ScriptDir%\%ININame% , Settings, HMC1
IniRead, HMC2, %A_ScriptDir%\%ININame% , Settings, HMC2
IniRead, HMC3, %A_ScriptDir%\%ININame% , Settings, HMC3
IniRead, HMC4, %A_ScriptDir%\%ININame% , Settings, HMC4
IniRead, HMC5, %A_ScriptDir%\%ININame% , Settings, HMC5

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
Gui, MainBuddy:Add, Button, xp125 w120 gGUIGOH, GoH Loader

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
Gui, MainBuddy:Add, Button, yp-4 x+5 w100 gChangeColor vColorChoice, Choose Color


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
Gui, HMBuddy:Add, Button, x275 y320 w130 h40 gHMRefresh, Refresh
Gui, HMBuddy:Add, Button, x410 y320 w130 h40 vHMSortChoice gHMSort, Sorting : %HMSortVar%
Gui, HMBuddy:Add, Button, x630 y320 w130 h40 gLoadHM, Load
Gui, HMBuddy:Add, Button, x5 y370 h40 gChangeHMPath, Change Save Folder
Gui, HMBuddy:Add, Edit, x155 y370 w300 h40 vHMPathText ReadOnly, %HMBuddyPath%
Gui, HMBuddy:Add, Checkbox, x460 y370 vHMC1 Checked%HMC1% gCheckBoxOptions, -cam 180
Gui, HMBuddy:Add, Checkbox, x460 y385 vHMC2 Checked%HMC2% gCheckBoxOptions, -c
Gui, HMBuddy:Add, Checkbox, x460 y400 vHMC3 Checked%HMC3% gCheckBoxOptions, -b
Gui, HMBuddy:Add, Checkbox, x560 y370 vHMC4 Checked%HMC4% gCheckBoxOptions, -a
Gui, HMBuddy:Add, Checkbox, x560 y385 vHMC5 Checked%HMC5% gCheckBoxOptions, -e
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
Gui, TBR21Buddy:Add, Button, x410 y320 w130 h40 vTBR21SortChoice gTBR21Sort, Sorting : %TBR21SortVar%
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
Gui, TEVEBuddy:Add, Button, x410 y320 w130 h40 vTEVESortChoice gTEVESort, Sorting : %TEVESortVar%
Gui, TEVEBuddy:Add, Button, x636 y320 w130 h40 gLoadTEVE, Load
Gui, TEVEBuddy:Add, Button, x5 y370 h40 gChangeTEVEPath, Change Save Folder
Gui, TEVEBuddy:Add, Edit, x155 y370 w300 h40 vTEVEPathText ReadOnly, %TEVEBuddyPath%
Gui, TEVEBuddy:Show, Hide Center, TeveF Buddy (Press CTRL + F1 to Show/Hide)

TEVEGUI = 0

Gui 5a:+LabelTEVEBuddyStat
Gui, TEVEBuddyStat:Add, Edit,vTEVEdata ReadOnly w600, 
Gui, TEVEBuddyStat:Show, Hide Center, Retrieve content

;=============== GOH GUI ====================
Gui 6:+LabelGOHBuddy
Gui, GOHBuddy:Add, Text, x40 y5, Class Selection :
Gui, GOHBuddy:Add, Text, x205 y5, Characters Available :
Gui, GOHBuddy:Add, Text, x500 y5, Character Information :
Gui, GOHBuddy:Add, ListBox, x5 y20 w150 h300 vGOHclasschoice gGOHChoice , 
Gui, GOHBuddy:Add, ListBox, x160 y20 w200 h300 vgohclasslist gGOHCharChoice AltSubmit, 
Gui, GOHBuddy:Add, ListBox, x365 y20 w400 h300 vgohclassinfo gGOHStatChoice AltSubmit, 
Gui, GOHBuddy:Add, Button, x5 y320 w50 h40 gBack, Back
Gui, GOHBuddy:Add, Button, x275 y320 w130 h40 gGOHRefresh, Refresh
Gui, GOHBuddy:Add, Button, x410 y320 w130 h40 vGOHSortChoice gGOHSort, Sorting : %GOHSortVar%
Gui, GOHBuddy:Add, Button, x636 y320 w130 h40 gLoadGOH, Load
Gui, GOHBuddy:Add, Button, x5 y370 h40 gChangeGOHPath, Change Save Folder
Gui, GOHBuddy:Add, Edit, x155 y370 w300 h40 vGOHPathText ReadOnly, %GOHBuddyPath%
Gui, GOHBuddy:Add, Checkbox, x460 y370 vGOHC1 Checked%GOHC1% gCheckBoxOptions, -new
Gui, GOHBuddy:Add, Checkbox, x460 y385 vGOHC2 Checked%GOHC2% gCheckBoxOptions, -autoselect off
Gui, GOHBuddy:Add, Checkbox, x460 y400 vGOHC3 Checked%GOHC3% gCheckBoxOptions, -farcam on
Gui, GOHBuddy:Add, Checkbox, x560 y370 vGOHC4 Checked%GOHC4% gCheckBoxOptions, -questmessages off
Gui, GOHBuddy:Show, Hide Center, GoH Buddy (Press CTRL + F1 to Show/Hide)

GOHGUI = 0

Gui 6a:+LabelGOHBuddyStat
Gui, GOHBuddyStat:Add, Edit,vGOHdata ReadOnly w600, 
Gui, GOHBuddyStat:Show, Hide Center, Retrieve content
;=============== GUI COLOR PICKER ====================
DPI := getDPImultiplier()
FontScaler := 2/DPI

eight := Floor(8*FontScaler)
twelve := Floor(12*FontScaler)

cY = 610	; Used to position the saved colors
cH = 30
cW = 55
cG = 5
cX = 22

; To load the saved variables
IniRead, vSlider, %A_ScriptDir%\%ININame%, Loader, vSlider, 100
IniRead, sColor, %A_ScriptDir%\%ININame%, Loader, sColor, 000000
IniRead, GUIColorX, %A_ScriptDir%\%ININame%, Loader, GUIColorX, 620
IniRead, GUIColorY, %A_ScriptDir%\%ININame%, Loader, GUIColorY, 443

; Create the Halo
Gui Halo: -DPIScale
Gui Halo: Color, AE29AD
Gui Halo: -caption -Border +ToolWindow +LastFound +AlwaysOnTop 
WinSet, TransColor, AE29AD
Gui Halo:Add, Picture, w20 h-1, Color/Hoop.png

; Create the Color Picker Window and set colors
Gui CPBuddy:Font, cDDDDDD s%eight% q5
Gui CPBuddy:Add, Button, x20 y440 w80 h50 gBack, Back
Gui CPBuddy:+caption Border  -DPIScale
Gui CPBuddy:Font, cDDDDDD s%twelve% q5
Gui CPBuddy:Color, 222222, DDDDDD
Gui CPBuddy:Add, Text, x180 y440, Saturation: 
Gui CPBuddy:Add, Picture, x20 y20 w600 h-1 Border vColorPallet, Color\%vSlider%.png
Gui CPBuddy:Add, Text, x340 y440 w75 Center ReadOnly gCP_SatEdit vSatEdit, %vSlider%`%
Gui CPBuddy:Add, Slider, x175 y480 w240 Range0-100 AltSubmit Line5 page25 Thick17 NoTicks gCP_Slider vvSlider, %vSlider%
Gui CPBuddy:Add, TreeView, x502 y435 w120 h60 ReadOnly Background%sColor% vCP_Top

;=============== TRAY ICON ====================
Menu, TrayMenu, Add, Gaia Loader, GUIGaia
Menu, TrayMenu, Add, HM Loader, GUIHM
Menu, TrayMenu, Add, TBR 1.38 Loader, GUITBR13
Menu, TrayMenu, Add, TBR 2.1 Loader, GUITBR21
Menu, TrayMenu, Add, TeveF Loader, GUITEVE

Menu, Tray, Nostandard
Menu, Tray, Add, Hide WC3 RPG Loader, ^F1
Menu, Tray, Default, Hide WC3 RPG Loader
Menu, Tray, Add
Menu, Tray, Add, Loaders, :TrayMenu
Menu, Tray, Add
Menu, Tray, Add, Launch Warcraft III, GameLaunch
Menu, Tray, Add
Menu, Tray, Add, Hide Warcraft III, GameShowHide
Menu, Tray, Add
Menu, Tray, Add, Reload Script, ReloadScript
Menu, Tray, Standard
Menu, Tray, Click, 1

;=============== STARTUP ====================
SetWorkingDir, %A_ScriptDir%
If FileExist("WC3 RPG Loader.ico")
{
	Menu, Tray, Icon , WC3 RPG Loader.ico
	TrayIcon := "1"
}
UpdateDone = 0
For i in GUIList
{
	GuiName := GUIList[i]
	Gui, %GuiName%Buddy:Color, %GUIColor%
}
Gui, MainBuddy:Show, Center, Loader %currentversion% (Press CTRL + F1 to Show/Hide)
If (CheckUpdates = 1)
{
	GoSub, Update
}
UpdateDone = 1
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
		url=https://raw.githubusercontent.com/wawawawawawawa/WC3_Loader/master/version.txt
		version := StrReplace(URLDownloadToVar(url), "`n", "")
		GuiControl, UpdateBuddy:, LoaderLastVer, %version%
		If (version != currentversion)
		{
			CurrentGUI = Update
			GuiControl, UpdateBuddy:Enable, GreyedButton
			Gui, UpdateBuddy:Show, Center, Update Available
			GuiHideAllBut(CurrentGUI)
		}
		Else
		{
			If (UpdateDone == 1)
			{
				CurrentGUI = Update
				GuiControl, UpdateBuddy:Disable, GreyedButton				
				Gui, UpdateBuddy:Show, Center, Up To Date
				GuiHideAllBut(CurrentGUI)
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
				GaiaReplacedStr := StrReplace(GaiaReplacedStr, "|" , "| ")
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
HMSort:
{
	GuiControlGet, HMCurrentSort,, HMSortChoice,
	If (HMCurrentSort = "Sorting : Last Time Modified")
	{
		GuiControl, HMBuddy:, HMSortChoice, Sorting : Level
		HMSortVar := "Level"
		IniWrite, %HMSortVar%, %A_ScriptDir%\%ININame%, Settings, HMSort
		GoSub, HMChoice
	}
	else if (HMCurrentSort = "Sorting : Level")
	{
		GuiControl, HMBuddy:, HMSortChoice, Sorting : Creation Time
		HMSortVar := "Creation Time"
		IniWrite, %HMSortVar%, %A_ScriptDir%\%ININame%, Settings, HMSort
		GoSub, HMChoice
	}	
	else
	{
		GuiControl, HMBuddy:, HMSortChoice, Sorting : Last Time Modified
		HMSortVar := "Last Time Modified"
		IniWrite, %HMSortVar%, %A_ScriptDir%\%ININame%, Settings, HMSort
		GoSub, HMChoice
	}
}
return
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
	HMTime := []
	HMCreatTime := []
	
	If (HMBuddyPath)
	{
		Loop, Files, *.txt
		{
			HMCreat=%A_LoopFileTimeCreated%
			HMCreatTime.Push(HMCreat)
			FormatTime, HMCreatTimeFormat, %A_LoopFileTimeCreated%
			HMLastModif=%A_LoopFileTimeModified%
			HMTime.Push(HMLastModif)
			FormatTime, HMTimeFormat, %A_LoopFileTimeModified%
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
					HMfull = | FileName: %A_LoopFileName% | CreationTime: %HMCreatTimeFormat% | LastModified: %HMTimeFormat% %HMfull% | Code: %HMcurrCode%
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
	HMCurrentTime := []
	HMCurrentCreatTime := []
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
			HMCurrTime := HMTime[i]
			HMCurrentTime.Push(HMCurrTime)
			HMCurrCreatTime := HMCreatTime[i]
			HMCurrentCreatTime.Push(HMCurrCreatTime)
		}
	}
	;;;; freaking sorting issue ;;;;;;;;
	for i in HMCurrentLvls
	{
		HMnewlvl := HMCurrentLvls[i]
		if (!HMlvllist)
		{
			HMlvllist=%HMnewlvl%
		}
		else
		{
			HMlvllist=%HMlvllist%`n%HMnewlvl%
		}
		HMnewcode := HMCurrentCodes[i]
		if (!HMcodelist)
		{
			HMcodelist=%HMnewcode%
		}
		else
		{
			HMcodelist=%HMcodelist%`n%HMnewcode%
		}
		HMnewstat := HMCurrentStat[i]
		if (!HMstatlist)
		{
			HMstatlist=%HMnewstat%
		}
		else
		{
			HMstatlist=%HMstatlist%`n%HMnewstat%
		}
		HMnewtime := HMCurrentTime[i]
		if (!HMtimelist)
		{
			HMtimelist=%HMnewtime%
		}
		else
		{
			HMtimelist=%HMtimelist%`n%HMnewtime%
		}
		HMnewcreattime := HMCurrentCreatTime[i]
		if (!HMcreattimelist)
		{
			HMcreattimelist=%HMnewcreattime%
		}
		else
		{
			HMcreattimelist=%HMcreattimelist%`n%HMnewcreattime%
		}
	}
	If (HMSortVar = "Level")
	{
		HMObj := [HMlvllist, HMcodelist, HMstatlist]
		HMlvllist=
		HMsortingnonsense := new GroupSort(HMObj, "N R")
		HMArrLvls := StrSplit(HMsortingnonsense.fetch("1") , "`n")
		HMArrCodes := StrSplit(HMsortingnonsense.fetch("2") , "`n")
		HMArrStat := StrSplit(HMsortingnonsense.fetch("3") , "`n")
	}
	else
	{
		if (HMSortVar = "Last Time Modified")
		{
			HMObj := [HMtimelist, HMlvllist, HMcodelist, HMstatlist]
		}
		else
		{
			HMObj := [HMcreattimelist, HMlvllist, HMcodelist, HMstatlist]
		}
		HMlvllist=
		HMsortingnonsense := new GroupSort(HMObj, "R")
		HMArrLvls := StrSplit(HMsortingnonsense.fetch("2") , "`n")
		HMArrCodes := StrSplit(HMsortingnonsense.fetch("3") , "`n")
		HMArrStat := StrSplit(HMsortingnonsense.fetch("4") , "`n")
	}
	for i in HMArrLvls {
		HMnewlvlvar := HMArrLvls[i]
		HMnewtimevar := HMArrTime[i]
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
	HMtimelist=
	HMcreattimelist=
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
			if (HMC1 = 1)
			{
				Send {enter}-cam 180{enter}
				Sleep 500
			}
			if (HMC2 = 1)
			{
				Send {esc}{Enter}-c{Enter}
				Sleep 500
			}
			if (HMC3 = 1)
			{
				Send {esc}{Enter}-b{Enter}
				Sleep 500
			}
			if (HMC4 = 1)
			{
				Send {esc}{Enter}-a{Enter}
				Sleep 500
			}
			if (HMC5 = 1)
			{
				Send {esc}{Enter}-e{Enter}
				Sleep 500
			}
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
TBR21Sort:
{
	GuiControlGet, TBR21CurrentSort,, TBR21SortChoice,
	If (TBR21CurrentSort = "Sorting : Last Time Modified")
	{
		GuiControl, TBR21Buddy:, TBR21SortChoice, Sorting : Level
		TBR21SortVar := "Level"
		IniWrite, %TBR21SortVar%, %A_ScriptDir%\%ININame%, Settings, TBR21Sort
		GoSub, TBR21Choice
	}
	else if (TBR21CurrentSort = "Sorting : Level")
	{
		GuiControl, TBR21Buddy:, TBR21SortChoice, Sorting : Creation Time
		TBR21SortVar := "Creation Time"
		IniWrite, %TBR21SortVar%, %A_ScriptDir%\%ININame%, Settings, TBR21Sort
		GoSub, TBR21Choice
	}	
	else
	{
		GuiControl, TBR21Buddy:, TBR21SortChoice, Sorting : Last Time Modified
		TBR21SortVar := "Last Time Modified"
		IniWrite, %TBR21SortVar%, %A_ScriptDir%\%ININame%, Settings, TBR21Sort
		GoSub, TBR21Choice
	}
}
return
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
	TBR21Time := []
	TBR21CreatTime := []
	
	If (TBR21BuddyPath)
	{
		Loop, Files, *.txt
		{
			TBR21Creat=%A_LoopFileTimeCreated%
			TBR21CreatTime.Push(TBR21Creat)
			FormatTime, TBR21CreatTimeFormat, %A_LoopFileTimeCreated%
			TBR21LastModif=%A_LoopFileTimeModified%
			TBR21Time.Push(TBR21LastModif)
			FormatTime, TBR21TimeFormat, %A_LoopFileTimeModified%
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
	TBR21TimeCurr := []
	TBR21CreatTimeCurr := []
	for i in TBR21Class
	{
		TBR21curr := TBR21Class[i]
		If(TBR21curr = TBR21CurrentClass)
		{
			TBR21CurrTime := TBR21Time[i]
			TBR21CurrCreatTime := TBR21CreatTime[i]
			TBR21CurrTXT := TBR21CharTXT[i]
			TBR21CurrLvl := TBR21Lvl[i]
			TBR21CurrXP := TBR21XP[i]
			TBR21CurrCode := TBR21Code[i]
			TBR21CurrentStat = | FileName: %TBR21CurrTXT% | CreationTime: %TBR21CreatTimeFormat% | LastModified: %TBR21TimeFormat% | Level: %TBR21CurrLvl% | XP: %TBR21CurrXP% | Code: %TBR21CurrCode%
			TBR21CharTXTCurr.Push(TBR21CharTXT[i])
			TBR21LvlCurr.Push(TBR21Lvl[i])
			TBR21XPCurr.Push(TBR21XP[i])
			TBR21CodeCurr.Push(TBR21Code[i])
			TBR21StatCurr.Push(TBR21CurrentStat)
			TBR21TimeCurr.Push(TBR21CurrTime)
			TBR21CreatTimeCurr.Push(TBR21CurrCreatTime)
		}
	}
	;;;; freaking sorting issue ;;;;;;;;
	for i in TBR21XPCurr
	{
		TBR21newlvl := TBR21LvlCurr[i]
		if (!TBR21lvllist)
		{
			TBR21lvllist=%TBR21newlvl%
		}
		else
		{
			TBR21lvllist=%TBR21lvllist%`n%TBR21newlvl%
		}
		TBR21newcode := TBR21CodeCurr[i]
		if (!TBR21codelist)
		{
			TBR21codelist=%TBR21newcode%
		}
		else
		{
			TBR21codelist=%TBR21codelist%`n%TBR21newcode%
		}
		TBR21newstat := TBR21StatCurr[i]
		if (!TBR21statlist)
		{
			TBR21statlist=%TBR21newstat%
		}
		else
		{
			TBR21statlist=%TBR21statlist%`n%TBR21newstat%
		}
		
		TBR21newxp := TBR21XPCurr[i]
		if (!TBR21xplist)
		{
			TBR21xplist=%TBR21newxp%
		}
		else
		{
			TBR21xplist=%TBR21xplist%`n%TBR21newxp%
		}
		TBR21newtxt := TBR21CharTXTCurr[i]
		if (!TBR21txtlist)
		{
			TBR21txtlist=%TBR21newtxt%
		}
		else
		{
			TBR21txtlist=%TBR21txtlist%`n%TBR21newtxt%
		}
		TBR21newtime := TBR21TimeCurr[i]
		if (!TBR21timelist)
		{
			TBR21timelist=%TBR21newtime%
		}
		else
		{
			TBR21timelist=%TBR21timelist%`n%TBR21newtime%
		}
		TBR21newcreattime := TBR21CreatTimeCurr[i]
		if (!TBR21creattimelist)
		{
			TBR21creattimelist=%TBR21newcreattime%
		}
		else
		{
			TBR21creattimelist=%TBR21creattimelist%`n%TBR21newcreattime%
		}
	}
	If (TBR21SortVar = "Level")
	{
		TBR21Obj := [TBR21xplist, TBR21codelist, TBR21statlist, TBR21lvllist, TBR21txtlist]
	}
	else If (TBR21SortVar = "Last Time Modified")
	{
		TBR21Obj := [TBR21timelist, TBR21xplist, TBR21codelist, TBR21statlist, TBR21lvllist, TBR21txtlist]
	}
	else 
	{
		TBR21Obj := [TBR21creattimelist, TBR21xplist, TBR21codelist, TBR21statlist, TBR21lvllist, TBR21txtlist]
	}
	TBR21lvllist=
	TBR21codelist=
	TBR21statlist=
	TBR21xplist=
	TBR21txtlist=
	TBR21timelist=
	TBR21creattimelist=
	If (TBR21SortVar = "Level")
	{
		TBR21sortingnonsense := new GroupSort(TBR21Obj, "N R")
		TBR21ArrXP := StrSplit(TBR21sortingnonsense.fetch("1") , "`n")
		TBR21ArrCodes := StrSplit(TBR21sortingnonsense.fetch("2") , "`n")
		TBR21ArrStat := StrSplit(TBR21sortingnonsense.fetch("3") , "`n")
		TBR21ArrLvls := StrSplit(TBR21sortingnonsense.fetch("4") , "`n")
		TBR21ArrTXT := StrSplit(TBR21sortingnonsense.fetch("5") , "`n")
	}
	else 
	{
		TBR21sortingnonsense := new GroupSort(TBR21Obj, "R")
		TBR21ArrXP := StrSplit(TBR21sortingnonsense.fetch("2") , "`n")
		TBR21ArrCodes := StrSplit(TBR21sortingnonsense.fetch("3") , "`n")
		TBR21ArrStat := StrSplit(TBR21sortingnonsense.fetch("4") , "`n")
		TBR21ArrLvls := StrSplit(TBR21sortingnonsense.fetch("5") , "`n")
		TBR21ArrTXT := StrSplit(TBR21sortingnonsense.fetch("6") , "`n")
	}
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
	TBR21timelist=
	TBR21creattimelist=
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
TEVESort:
{
	GuiControlGet, TEVECurrentSort,, TEVESortChoice,
	If (TEVECurrentSort = "Sorting : Last Time Modified")
	{
		GuiControl, TEVEBuddy:, TEVESortChoice, Sorting : Level
		TEVESortVar := "Level"
		IniWrite, %TEVESortVar%, %A_ScriptDir%\%ININame%, Settings, TEVESort
		GoSub, TEVEChoice
	}
	else if (TEVECurrentSort = "Sorting : Level")
	{
		GuiControl, TEVEBuddy:, TEVESortChoice, Sorting : Creation Time
		TEVESortVar := "Creation Time"
		IniWrite, %TEVESortVar%, %A_ScriptDir%\%ININame%, Settings, TEVESort
		GoSub, TEVEChoice
	}	
	else
	{
		GuiControl, TEVEBuddy:, TEVESortChoice, Sorting : Last Time Modified
		TEVESortVar := "Last Time Modified"
		IniWrite, %TEVESortVar%, %A_ScriptDir%\%ININame%, Settings, TEVESort
		GoSub, TEVEChoice
	}
}
return
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
	TEVETime := []
	TEVECreatTime := []
	
	If (TEVEBuddyPath)
	{
		Loop, Files, *, D
		{
			if (A_LoopFileName = "backups")
			{
				continue
			}
			TEVECurrClass := A_LoopFileName
			TEVEClassList = %TEVEClassList%|%A_LoopFileName%
			Loop, Files, %A_LoopFileLongPath%\*.txt
			{
				TEVECreat=%A_LoopFileTimeCreated%
				TEVECreatTime.Push(TEVECreat)
				FormatTime, TEVECreatTimeFormat, %A_LoopFileTimeCreated%
				TEVELastModif=%A_LoopFileTimeModified%
				TEVETime.Push(TEVELastModif)
				FormatTime, TEVETimeFormat, %A_LoopFileTimeModified%
				TEVEFilePath.Push(A_LoopFileLongPath)
				TEVEFileName.Push(A_LoopFileName)
				TEVEClasses.Push(TEVECurrClass)
				Loop, 35
				{
					FileReadLine, TEVEfileline, %A_LoopFileLongPath%, A_Index
					If InStr(TEVEfileline, "call Preload")
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
						If (InStr(TEVEfileline, "call PreloadEnd(") = 0)
						{
							TEVEfull = %TEVEfull% | %TEVEcurrentline%
						}
						If (InStr(TEVEfileline, "call PreloadEnd("))
						{
							TEVEfull = | FileName: %A_LoopFileName% | CreationTime: %TEVECreatTimeFormat% | LastModified: %TEVETimeFormat% %TEVEfull%
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
	TEVECurrentTime := []
	TEVECurrentCreatTime := []
	
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
			TEVETimeChar := TEVETime[i]
			TEVECurrentTime.Push(TEVETimeChar)
			TEVECreatTimeChar := TEVECreatTime[i]
			TEVECurrentCreatTime.Push(TEVECreatTimeChar)
		}
	}
	
	;;;; freaking sorting issue ;;;;;;;;
	for i in TEVELvlCurr
	{
		TEVEnewlvl := TEVELvlCurr[i]
		if (!TEVElvllist)
		{
			TEVElvllist=%TEVEnewlvl%
		}
		else
		{
			TEVElvllist=%TEVElvllist%`n%TEVEnewlvl%
		}
		TEVEnewstat := TEVEStatCurr[i]
		if (!TEVEstatlist)
		{
			TEVEstatlist=%TEVEnewstat%
		}
		else
		{
			TEVEstatlist=%TEVEstatlist%`n%TEVEnewstat%
		}
		TEVEnewcode1 := TEVECurrentCode1[i]
		if (!TEVEcode1list)
		{
			TEVEcode1list=%TEVEnewcode1%
		}
		else
		{
			TEVEcode1list=%TEVEcode1list%`n%TEVEnewcode1%
		}
		TEVEnewcode2 := TEVECurrentCode2[i]
		if (!TEVEcode2list)
		{
			TEVEcode2list=%TEVEnewcode2%
		}
		else
		{
			TEVEcode2list=%TEVEcode2list%`n%TEVEnewcode2%
		}
		TEVEnewtime := TEVECurrentTime[i]
		if (!TEVEtimelist)
		{
			TEVEtimelist=%TEVEnewtime%
		}
		else
		{
			TEVEtimelist=%TEVEtimelist%`n%TEVEnewtime%
		}
		TEVEnewcreattime := TEVECurrentCreatTime[i]
		if (!TEVEcreattimelist)
		{
			TEVEcreattimelist=%TEVEnewcreattime%
		}
		else
		{
			TEVEcreattimelist=%TEVEcreattimelist%`n%TEVEnewcreattime%
		}
	}
	If (TEVESortVar = "Level")
	{
		TEVEObj := [TEVElvllist, TEVEstatlist, TEVEcode1list, TEVEcode2list]
	}
	else if (TEVESortVar = "Last Time Modified")
	{
		TEVEObj := [TEVEtimelist, TEVElvllist, TEVEstatlist, TEVEcode1list, TEVEcode2list]
	}
	else 
	{
		TEVEObj := [TEVEcreattimelist, TEVElvllist, TEVEstatlist, TEVEcode1list, TEVEcode2list]
	}
	TEVElvllist=
	TEVEstatlist=
	TEVEcode1list=
	TEVEcode2list=
	TEVEtimelist=
	TEVEcreattimelist=
	If (TEVESortVar = "Level")
	{
		TEVEsortingnonsense := new GroupSort(TEVEObj, "N R")
		TEVEArrLvls := StrSplit(TEVEsortingnonsense.fetch("1") , "`n")
		TEVEArrStat := StrSplit(TEVEsortingnonsense.fetch("2") , "`n")
		TEVEArrCode1 := StrSplit(TEVEsortingnonsense.fetch("3") , "`n")
		TEVEArrCode2 := StrSplit(TEVEsortingnonsense.fetch("4") , "`n")
	}
	else
	{
		TEVEsortingnonsense := new GroupSort(TEVEObj, "R")
		TEVEArrLvls := StrSplit(TEVEsortingnonsense.fetch("2") , "`n")
		TEVEArrStat := StrSplit(TEVEsortingnonsense.fetch("3") , "`n")
		TEVEArrCode1 := StrSplit(TEVEsortingnonsense.fetch("4") , "`n")
		TEVEArrCode2 := StrSplit(TEVEsortingnonsense.fetch("5") , "`n")
	}
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
	TEVEtimelist=
	TEVEcreattimelist=
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
		SetTitleMatchMode, 1
		If WinExist("Warcraft III")
		{
			Clipboard := "Loading : " . TEVECurrentChar . " - Level " . TEVECurrLvl
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
;////////////////////////////////////////// GoH //////////////////////////////////////////////////////////////////
;=============== GoH ====================
GOHSort:
{
	GuiControlGet, GOHCurrentSort,, GOHSortChoice,
	If (GOHCurrentSort = "Sorting : Last Time Modified")
	{
		GuiControl, GOHBuddy:, GOHSortChoice, Sorting : Level
		GOHSortVar := "Level"
		IniWrite, %GOHSortVar%, %A_ScriptDir%\%ININame%, Settings, GOHSort
		GoSub, GOHChoice
	}
	else if (GOHCurrentSort = "Sorting : Level")
	{
		GuiControl, GOHBuddy:, GOHSortChoice, Sorting : Creation Time
		GOHSortVar := "Creation Time"
		IniWrite, %GOHSortVar%, %A_ScriptDir%\%ININame%, Settings, GOHSort
		GoSub, GOHChoice
	}	
	else 
	{
		GuiControl, GOHBuddy:, GOHSortChoice, Sorting : Last Time Modified
		GOHSortVar := "Last Time Modified"
		IniWrite, %GOHSortVar%, %A_ScriptDir%\%ININame%, Settings, GOHSort
		GoSub, GOHChoice
	}
}
return
GOHRefresh:
{
	; Empty Old Var
	IniRead, GOHBuddyPath, %A_ScriptDir%\%ININame% , Settings, GOHPath
	SetWorkingDir, %GOHBuddyPath%
	GuiControl, GOHBuddy:, gohclassinfo, |
	GuiControl, GOHBuddy:, gohclasslist, |
	GuiControl, GOHBuddy:, gohclasschoice, |
	GOHClasses := []
	GOHLvl := []
	GOHCode := []
	GOHStats := []
	GOHClassList=
	GOHTime := []
	GOHCreatTime := []
	
	If (GOHBuddyPath)
	{
		Loop, Files, *.txt
		{
			GOHCreat=%A_LoopFileTimeCreated%
			GOHCreatTime.Push(GOHCreat)
			FormatTime, GOHCreatTimeFormat, %A_LoopFileTimeCreated%
			GOHLastModif=%A_LoopFileTimeModified%
			GOHTime.Push(GOHLastModif)
			FormatTime, GOHTimeFormat, %A_LoopFileTimeModified%
			FileReadLine, GOHfileline, %A_LoopFileLongPath%, 4
			StringTrimLeft, GOHfileline, GOHfileline, 2
			GOHCode.Push(GOHfileline)
			GOHcurrChar := StrSplit(A_LoopFileName , ["(", ")"])
			GOHcurrClass := GOHcurrChar[1]
			GOHcurrLvl := GOHcurrChar[2]
			GOHcurrStat := GOHcurrChar[3]
			StringTrimRight, GOHcurrClass, GOHcurrClass, 1
			StringTrimLeft, GOHcurrStat, GOHcurrStat, 3
			StringTrimRight, GOHcurrStat, GOHcurrStat, 4
			If (SubStr(GOHcurrLvl, 1 , 2) == "MP")
			{
				GOHcurrLvl = Lv.60 - %GOHcurrLvl%
			}
			GOHcurrStat = | FileName: %A_LoopFileName% | CreationTime: %GOHCreatTimeFormat% | LastModified: %GOHTimeFormat% | TimePlayed: %GOHcurrStat% | Code: %GOHfileline%
			GOHClasses.Push(GOHcurrClass)
			GOHStats.Push(GOHcurrStat)
			GOHLvl.Push(GOHcurrLvl)
			
			if (GOHClassList)
			{
				if InStr(GOHClassList, GOHcurrClass)
				{
					
				}
				else
				{
					GOHClassList = %GOHClassList%|%GOHcurrClass%
				}
			}
			else
			{
				GOHClassList = |%GOHcurrClass%
			}
		}
		GuiControl, GOHBuddy:, gohclasschoice, %GOHClassList%
		GuiControl, GOHBuddy:Choose, gohclasschoice, 1
	}
}
return
GOHChoice:
{	
	IniRead, GOHBuddyPath, %A_ScriptDir%\%ININame% , Settings, GOHPath
	SetWorkingDir, %GOHBuddyPath%
	GuiControlGet, GOHCurrentClass,, gohclasschoice, 
	for i in GOHClasses
	{
		GOHcurr := GOHClasses[i]
		If(GOHcurr = GOHCurrentClass)
		{
			GOHLvlChar := GOHLvl[i]
			GOHCodeChar := GOHCode[i]
			GOHStatChar := GOHStats[i]
			GOHTimeChar := GOHTime[i]
			GOHCreatTimeChar := GOHCreatTime[i]
			If (GOHSortVar = "Level")
			{
				If InStr(GOHLvlChar, "MP")
				{
					if (!GOHLvlCharMaxList)
					{
						GOHLvlCharMaxList=%GOHLvlChar%
						GOHStatCharMaxList=%GOHStatChar%
						StringTrimLeft, GOHLvlChar, GOHLvlChar, 11
						GOHLvlCharMaxNum=%GOHLvlChar%
						GOHCodeCharMaxList=%GOHCodeChar%
					}
					else
					{
						GOHLvlCharMaxList=%GOHLvlCharMaxList%`n%GOHLvlChar%
						GOHStatCharMaxList=%GOHStatCharMaxList%`n%GOHStatChar%
						StringTrimLeft, GOHLvlChar, GOHLvlChar, 11
						GOHLvlCharMaxNum=%GOHLvlCharMaxNum%`n%GOHLvlChar%
						GOHCodeCharMaxList=%GOHCodeCharMaxList%`n%GOHCodeChar%
					}
				}
				else
				{
					if (!GOHLvlCharLvlList)
					{
						GOHLvlCharLvlList=%GOHLvlChar%
						GOHStatCharLvlList=%GOHStatChar%
						StringTrimLeft, GOHLvlChar, GOHLvlChar, 3
						GOHLvlCharLvlNum=%GOHLvlChar%
						GOHCodeCharLvlList=%GOHCodeChar%
					}
					else
					{
						GOHLvlCharLvlList=%GOHLvlCharLvlList%`n%GOHLvlChar%
						GOHStatCharLvlList=%GOHStatCharLvlList%`n%GOHStatChar%
						StringTrimLeft, GOHLvlChar, GOHLvlChar, 3
						GOHLvlCharLvlNum=%GOHLvlCharLvlNum%`n%GOHLvlChar%
						GOHCodeCharLvlList=%GOHCodeCharLvlList%`n%GOHCodeChar%
					}
				}
			}
			else
			{
				if (!GOHTimeList)
				{
					GOHLvlCharMaxList=%GOHLvlChar%
					GOHStatCharMaxList=%GOHStatChar%
					GOHLvlCharMaxNum=%GOHLvlChar%
					GOHCodeCharMaxList=%GOHCodeChar%
					GOHTimeList=%GOHTimeChar%
					GOHCreatTimeList=%GOHCreatTimeChar%
				}
				else
				{
					GOHLvlCharMaxList=%GOHLvlCharMaxList%`n%GOHLvlChar%
					GOHStatCharMaxList=%GOHStatCharMaxList%`n%GOHStatChar%
					GOHLvlCharMaxNum=%GOHLvlCharMaxNum%`n%GOHLvlChar%
					GOHCodeCharMaxList=%GOHCodeCharMaxList%`n%GOHCodeChar%
					GOHTimeList=%GOHTimeList%`n%GOHTimeChar%
					GOHCreatTimeList=%GOHCreatTimeList%`n%GOHCreatTimeChar%
				}
			}
		}
	}
	If (GOHSortVar = "Level")
	{
		GOHLvlObj := [GOHLvlCharLvlNum, GOHLvlCharLvlList, GOHStatCharLvlList, GOHCodeCharLvlList]
		GOHMaxObj := [GOHLvlCharMaxNum, GOHLvlCharMaxList, GOHStatCharMaxList, GOHCodeCharMaxList]
	}
	else if (GOHSortVar = "Last Time Modified")
	{
		GOHMaxObj := [GOHTimeList, GOHLvlCharMaxList, GOHStatCharMaxList, GOHCodeCharMaxList]
	}
	else
	{
		GOHMaxObj := [GOHCreatTimeList, GOHLvlCharMaxList, GOHStatCharMaxList, GOHCodeCharMaxList]
	}
	GOHLvlCharLvlList=
	GOHStatCharLvlList=
	GOHLvlCharLvlNum=
	GOHCodeCharLvlList=
	GOHLvlCharMaxList=
	GOHStatCharMaxList=
	GOHLvlCharMaxNum=
	GOHCodeCharMaxList=
	GOHTimeList=
	GOHCreatTimeList=
	
	If (GOHSortVar = "Level")
	{
		GOHsortingnonsenseLvl := new GroupSort(GOHLvlObj, "N R")
		GOHArrLvlLvl := StrSplit(GOHsortingnonsenseLvl.fetch("2") , "`n")
		GOHArrStatLvl := StrSplit(GOHsortingnonsenseLvl.fetch("3") , "`n")
		GOHArrCodeLvl := StrSplit(GOHsortingnonsenseLvl.fetch("4") , "`n")
		
		GOHsortingnonsenseMax := new GroupSort(GOHMaxObj, "N R")
	}
	else
	{
		GOHsortingnonsenseMax := new GroupSort(GOHMaxObj, "R")
	}
	GOHArrLvlMax := StrSplit(GOHsortingnonsenseMax.fetch("2") , "`n")
	GOHArrStatMax := StrSplit(GOHsortingnonsenseMax.fetch("3") , "`n")
	GOHArrCodeMax := StrSplit(GOHsortingnonsenseMax.fetch("4") , "`n")
	GOHArrTimeMax := StrSplit(GOHsortingnonsenseMax.fetch("1") , "`n")
	
	If (GOHSortVar = "Level")
	{
		For i in GOHArrLvlLvl
		{
			GOHNewLvl := GOHArrLvlLvl[i]
			GOHArrLvlMax.Push(GOHNewLvl)
			GOHNewStat := GOHArrStatLvl[i]
			GOHArrStatMax.Push(GOHNewStat)
			GOHNewCode := GOHArrCodeLvl[i]
			GOHArrCodeMax.Push(GOHNewCode)
		}
	}
	
	For i in GOHArrLvlMax
	{
		GOHThisLvl := GOHArrLvlMax[i]
		GOHThisTime := GOHArrTimeMax[i]
		 If (GOHlvllist)
		{
			GOHlvllist=%GOHlvllist%| %GOHThisLvl%
		}
		else
		{
			GOHlvllist=| %GOHThisLvl%
		}
	}	
	
	GOHDefaultStat := GOHArrStatMax[1]
	GOHCurrentCode := GOHArrCodeMax[1]
	GuiControl, GOHBuddy:, gohclasslist, %GOHlvllist%
	GuiControl, GOHBuddy:Choose, gohclasslist, 1
	GuiControl, GOHBuddy:, gohclassinfo, %GOHDefaultStat%
	GuiControl, GOHBuddy:Choose, gohclassinfo, 1
	GOHlvllist=
	GOHstatlist=
}
return
GOHCharChoice:
{
	IniRead, GOHBuddyPath, %A_ScriptDir%\%ININame% , Settings, GOHPath
	SetWorkingDir, %GOHBuddyPath%
	GuiControlGet, GOHCurrentCharNum,, gohclasslist, 
	GOHChosenStat := GOHArrStatMax[GOHCurrentCharNum]
	GOHCurrentCode := GOHArrCodeMax[GOHCurrentCharNum]
	GuiControl, GOHBuddy:, gohclassinfo, %GOHChosenStat%
	GuiControl, GOHBuddy:Choose, gohclassinfo, 1
}
return
GOHStatChoice:
{
	If (RetrieveContent == 1)
	{
		IniRead, GOHBuddyPath, %A_ScriptDir%\%ININame% , Settings, GOHPath
		SetWorkingDir, %GOHBuddyPath%
		GuiControlGet, GOHCurrentStatNum,, gohclassinfo,
		GuiControlGet, GOHCurrentCharNum,, gohclasslist,
		GOHChosenStat := GOHArrStatMax[GOHCurrentCharNum]
		StringTrimLeft, GOHChosenStat, GOHChosenStat, 2
		GOHArrStat2 := StrSplit(GOHChosenStat , " | ")
		GOHGetStat := GOHArrStat2[GOHCurrentStatNum]
		GuiControl, GOHBuddyStat:, GOHdata, %GOHGetStat%
		Gui, GOHBuddyStat:Show
		Gui, GOHBuddyStat:+AlwaysOnTop
	}
}
return
LoadGOH:
{
	IniRead, GOHBuddyPath, %A_ScriptDir%\%ININame% , Settings, GOHPath
	SetWorkingDir, %GOHBuddyPath%
	GuiControlGet, GOHCurrentClass,, gohclasschoice, 
	GuiControlGet, GOHCurrentCharNum,, gohclasslist,
	if (GOHCurrentClass && GOHCurrentCharNum)
	{
		GOHCurrCode := GOHArrCodeMax[GOHCurrentCharNum]
		GOHCurrLvl := GOHArrLvlMax[GOHCurrentCharNum]
		If WinExist("Warcraft III")
		{
			Clipboard := "Loading : " . GOHCurrentClass . " - Level " . GOHCurrLvl
			WinActivate, Warcraft III
			ClipWait, 500
			Send {esc}{Enter}^v{Enter}
			Sleep 500
			if (GOHC1 = 1)
			{
				Send {esc}{Enter}-new{Enter}
				Sleep 500
			}
			Clipboard := GOHCurrCode
			ClipWait, 500
			Send {esc}{Enter}^v{Enter}
			Sleep 500
			if (GOHC3 = 1)
			{
				Send {esc}{Enter}-farcam on{Enter}
				Sleep 500
			}
			if (GOHC2 = 1)
			{
				Send {esc}{Enter}-autoselect off{Enter}
				Sleep 500
			}
			if (GOHC4 = 1)
			{
				Send {esc}{Enter}-questmessages off{Enter}
				Sleep 500
			}
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

;=============== BACKUP ====================
RestoreBackup:
{
	Gui MainBuddy:+OwnDialogs
	FileSelectFile, BackupPath,,, Choose the Backup.ini to Restore, INI (*.ini)
	If (BackupPath)
	{
		FileSelectFolder, RestorePath, 3,, Where do you want your Restored Saves to be? (Press Cancel to Skip)
	}
	GaiaRestorePath = %RestorePath%\Gaia Restored
	HMRestorePath = %RestorePath%\HM Restored
	TBR13RestorePath = %RestorePath%\TBR13 Restored
	TBR21RestorePath = %RestorePath%\TBR21 Restored
	TEVERestorePath = %RestorePath%\TEVE Restored
	GOHRestorePath = %RestorePath%\GOH Restored
	
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
		
		name = GOH
		IniRead, GOHNum, %BackupPath%, GOH, Count
		
		Loop, %GOHNum%
		{
			IniRead, GOHFile, %BackupPath%, GOH, File%A_Index%
			IniRead, GOHTxt, %BackupPath%, GOH, Txt%A_Index%
			IniRead, GOHSubPath, %BackupPath%, GOH, SubPath%A_Index%
			GOHTxt := StrReplace(GOHTxt, "LINEBREAK" , "`n")
			GOHTxt := StrReplace(GOHTxt, "TABBREAK" , "`t")
			FileCreateDir, %GOHRestorePath%%GOHSubPath%
			FileDelete, %GOHRestorePath%%GOHSubPath%\%GOHFile%
			FileAppend, %GOHTxt%, %GOHRestorePath%%GOHSubPath%\%GOHFile%
			GOHperc := (A_Index / %name%Num) * 100
			Progress, %GOHperc%, %GOHFile%, Restoring %name% Backup..., %name% Backup
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
		If (GOHBuddyPath)
		{
			name = GOH
			SetWorkingDir, %GOHBuddyPath%
			GOHcurrent := 0
			GOHmax := 0
			Loop, Files, *.txt, D F R
			{
				GOHmax++
			}
			Loop, Files, *.txt, D F R
			{
				GOHcurrent++
				FileRead, GOHcurrBackup, %A_LoopFileLongPath%
				GOHcurrBackup := StrReplace(GOHcurrBackup, "`r`n" , "LINEBREAK")
				GOHcurrBackup := StrReplace(GOHcurrBackup, "`t" , "TABBREAK")
				GOHcurrBackup := StrReplace(GOHcurrBackup, "`n" , "LINEBREAK")
				GOHcurrBackup := StrReplace(GOHcurrBackup, "`r" , "LINEBREAK")
				GOHcurrSubPath := StrReplace(A_LoopFileLongPath, GOHBuddyPath, "")
				GOHcurrSubPath := StrReplace(GOHcurrSubPath, A_LoopFileName, "")
				IniWrite, %GOHcurrSubPath%, %CreateBackupPath%\Backup.ini, %name%, SubPath%GOHcurrent%
				IniWrite, %A_LoopFileName%, %CreateBackupPath%\Backup.ini, %name%, File%GOHcurrent%
				IniWrite, %GOHcurrBackup%, %CreateBackupPath%\Backup.ini, %name%, Txt%GOHcurrent%
				GOHperc := (A_Index / GOHmax) * 100
				Progress, %GOHperc%, %A_LoopFileName%, Creating %name% Backup..., %name% Backup
			}
			IniWrite, %GOHcurrent%, %CreateBackupPath%\Backup.ini, %name%, Count
			Progress, Off
		}
		MsgBox, 262208, Backup Done, Backup Saved at %CreateBackupPath%\Backup.ini
	}
}
return

;============== GUI COLOR PICKER =================
CP_Slider:
GuiControlGet, vSlider 	; Gets and sets the Saturation 
vSlider := SliderRound(vSlider)	; from slider to edit box
GuiControl, CPBuddy:, SatEdit, %vSlider%`% 	
if (mod(vSlider, 5) = 0) {	; Makes sure the number is dividable by 5
	GuiControl, CPBuddy:, ColorPallet, Color\%vSlider%.png
	if (vLoading = "No") {
		vColor := GetColor(GUIColorX, GUIColorY)
		SetColor(vColor, "Top")	; Updates the color under the halo
	}
}
IniWrite, %vSlider%, %A_ScriptDir%\%ININame%, Loader, vSlider
return

CP_SatEdit:	; Gets and sets the Saturation 
GuiControlGet, SatEdit 	; from edit box to slider	
GuiControl, CPBuddy:, vSlider, %SatEdit% 
if (mod(SatEdit, 5) = 0) {	; Makes sure the number is dividable by 5
	GuiControl, CPBuddy:, ColorPallet, Color\%SatEdit%.png
	vColor := GetColor(GUIColorX, GUIColorY)
	SetColor(vColor, "Top")	; Updates the color under the halo
}
return

SliderRound(vSlider) {				; Makes sure the slider stops on
	ModuloSlider := Mod(vSlider,5)
	if (vSlider = "")				; the closest 5 as that is the 
		vSlider = 100 				; only color image saved
	if (ModuloSlider = 0)
		return vSlider
	else if (ModuloSlider == 1 || ModuloSlider == 6)
		return vSlider - 1
	else if (ModuloSlider == 2 || ModuloSlider == 7)
		return vSlider - 2
	else if (ModuloSlider == 3 || ModuloSlider == 8)
		return vSlider + 2
	else if (ModuloSlider == 4 || ModuloSlider == 9)
		return vSlider + 1
}

HaloMove(vX="Hide", vY="Hide", wID="") {	; Function to position the halo correctly
	if (vX != "Hide") OR (vY != "Hide") {
		WinGetPos, wX, wY,,, ahk_id %wID%
		if(wX && wY)
		{
			wX := (wX + vX - 19)
			wY := (wY + vY - 15)
			Gui Halo:Show, x%wX% y%wY% NoActivate
		}
	} else
		Gui Halo:Show, Hide
	return
}

GetColor(X, Y) { ; Gets the pixel color under the mouse cursor
	PixelGetColor vColor, X, Y, RGB
	StringRight, vColor, vColor, 6
	return vColor
}

SetColor(vColor, Which) { ; Sets vColor to Which box
	GuiControl, CPBuddy: +Background%vColor%, CP_%Which%
}
return
CP_PickTimer:	; Timer that runs constantly to get color 
IfWinActive, ahk_id %wID%	; So it only works when the window is active
{
	if (DoOnlyOnce = 1)
		HaloMove(GUIColorX, GUIColorY, wID) ; Position the halo into saved position
	DoOnlyOnce = 0
	CoordMode, Mouse, Relative
	MouseGetPos X, Y
	if (x < 14) OR (x > 631) OR (y < 37) OR (y > 455) {
		if (DoMe = "Yes") { ;  Makes sure this is not run more than once
			SetColor(sColor, "Top")	; Set top box color
			HaloMove(GUIColorX, GUIColorY, wID) ; Position the halo into saved position
			DoMe := "No"
		}
		return
	}
	DoMe := "Yes"
	if (x < 24) 	; Makes sure the halo stays in the confines
		x = 24
	else if (x > 621) 
		x = 621
	if (y < 47) 
		y = 47
	else if (y > 445)
		y = 445 
	vColor := GetColor(X, Y) ; Get the color under the halo
	SetColor(vColor, "Top")	; Set top box color
	HaloMove(X, Y, wID)	; Position the halo
} else if (DoOnlyOnce = 0) {	; Do this is Color Picker loses focus
	HaloMove() ; Hide the halo as it would show over other windows otherwise
	DoOnlyOnce = 1
}
return

; Saves the color left clicked under the halo
~Lbutton::
IfWinActive ahk_id %wID%	; Only when the window is active will this run
{
	MouseGetPos X, Y ; To be sure it is within the Color Pallet	
	if (x > 14) && (x < 631) && (y > 37) && (y < 455) {
		if (x < 24) 	; Makes sure the halo stays in the confines
			x = 24
		else if (x > 621) 
			x = 621
		if (y < 47) 
			y = 47
		else if (y > 445)
			y = 445 
		; Save variables to to be used when reopening the Color Pallet
		IniWrite, %vColor%, %A_ScriptDir%\%ININame%, Loader, GUIColor
		IniWrite, %X%, %A_ScriptDir%\%ININame%, Loader, GUIColorX
		IniWrite, %Y%, %A_ScriptDir%\%ININame%, Loader, GUIColorY
		sColor := vColor
		GUIColorX := X
		GUIColorY := Y
		if (StrLen(sColor) = 8) ; Trim the 0x from the beginning if its there
			StringTrimLeft, sColor, sColor, 2
		For i in GUIList
		{
			GuiName := GUIList[i]
			Gui, %GuiName%Buddy:Color, %sColor%
		}
		GuiControl, CPBuddy:Focus, vSlider
	}
}
return

getDPImultiplier()
{
		RegRead, DPI_value, HKEY_CURRENT_USER, Control Panel\Desktop\WindowMetrics, AppliedDPI
		if errorlevel=1 ; the reg key was not found - it means default settings
		   return 1
		if DPI_value=96 ; 96 is the default font size setting
		   return 1
		if DPI_value>96 ; A higher value should mean LARGE font size setting
		   return DPI_value/96
}

ChangeColor:
{
	
	ColorDir := A_ScriptDir "\Color"
	if !FileExist(ColorDir)
	{
		FileCreateDir, %ColorDir%
		Progress, , , Downloading Required Colors..., Colors Download
		Sleep, 100
		UrlDownloadToFile, %URLDownloadHoop%, %ColorDir%\Hoop.png
		ColorArray := ["0", "5", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55", "60", "65", "70", "75", "80", "85", "90", "95", "100"]
		For i in ColorArray
		{
			CurrColor := ColorArray[i]
			UrlDownloadToFile, %URLDownloadColor%%CurrColor%.png, %ColorDir%\%CurrColor%.png
			Progress, %CurrColor%, , Downloading Required Colors..., Colors Download
		}
		Progress, 100 , ,Colors Download Completed. , Colors Download Completed
		Sleep, 500
		Progress, Off
		Reload
	}
	IniRead, GUIColorX, %A_ScriptDir%\%ININame%, Loader, GUIColorX, 620
	IniRead, GUIColorY, %A_ScriptDir%\%ININame%, Loader, GUIColorY, 443
	CurrentGUI = CP
	%CurrentGUI%GUI = 1
	GuiHideAllBut(CurrentGUI)
	Gui CPBuddy:Show, Center w640 h520, Color Picker ; Shows the Color Picker {x60 y40}
	Gui, Halo:+OwnerCPBuddy
	Gui CPBuddy:+AlwaysOnTop
	WinGet wID, ID, A ; Gets Color Picker ID for ease of use later on
	HaloMove(GUIColorX, GUIColorY, wID) ; Set halo to saved color
	SetTimer, CP_PickTimer, 10 ; Start Color Picker timer
}
return

;============== HOTKEYS ===================
^F1::
If (%CurrentGUI%GUI = 1)
{
    Gui, %CurrentGUI%Buddy:Show, Hide
	%CurrentGUI%GUI = 0
	Menu, Tray, Rename, Hide WC3 RPG Loader, Show WC3 RPG Loader
}
Else 
{
	Gui, %CurrentGUI%Buddy:Show
	%CurrentGUI%GUI = 1
	Menu, Tray, Rename, Show WC3 RPG Loader, Hide WC3 RPG Loader
}
Return

;============== GUI ===================
GuiHideAllBut(ThisOne)
{
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


CheckBoxOptions:
{
	GuiControlGet, IniOption , , %A_GuiControl%, 
	IniWrite, %IniOption%, %A_ScriptDir%\%ININame%, Settings, %A_GuiControl%
	IniRead, %A_GuiControl%, %A_ScriptDir%\%ININame%, Settings, %A_GuiControl%
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

GUIGOH:
{
	CurrentGUI = GOH
	GuiHideAllBut(CurrentGUI)
	IniRead, GOHBuddyPath, %A_ScriptDir%\%ININame%, Settings, GOHPath
	SetWorkingDir, %GOHBuddyPath%
	GoSub, GOHRefresh
}
return

MainBuddyGuiClose:
{
	%CurrentGUI%GUI = 0
	Gui, %CurrentGUI%Buddy:Show, Hide
	Menu, Tray, Rename, Hide WC3 RPG Loader, Show WC3 RPG Loader
}
return

GaiaBuddyGuiClose:
{
	%CurrentGUI%GUI = 0
	Gui, %CurrentGUI%Buddy:Show, Hide
	Menu, Tray, Rename, Hide WC3 RPG Loader, Show WC3 RPG Loader
}
return

HMBuddyGuiClose:
{
	%CurrentGUI%GUI = 0
	Gui, %CurrentGUI%Buddy:Show, Hide
	Menu, Tray, Rename, Hide WC3 RPG Loader, Show WC3 RPG Loader
}
return

TBR13BuddyGuiClose:
{
	%CurrentGUI%GUI = 0
	Gui, %CurrentGUI%Buddy:Show, Hide
	Menu, Tray, Rename, Hide WC3 RPG Loader, Show WC3 RPG Loader
}
return

TBR21BuddyGuiClose:
{
	%CurrentGUI%GUI = 0
	Gui, %CurrentGUI%Buddy:Show, Hide
	Menu, Tray, Rename, Hide WC3 RPG Loader, Show WC3 RPG Loader
}
return

TEVEBuddyGuiClose:
{
	%CurrentGUI%GUI = 0
	Gui, %CurrentGUI%Buddy:Show, Hide
	Menu, Tray, Rename, Hide WC3 RPG Loader, Show WC3 RPG Loader
}
return

GOHBuddyGuiClose:
{
	%CurrentGUI%GUI = 0
	Gui, %CurrentGUI%Buddy:Show, Hide
	Menu, Tray, Rename, Hide WC3 RPG Loader, Show WC3 RPG Loader
}
return

UpdateBuddyGuiClose:
{
	%CurrentGUI%GUI = 0
	Gui, %CurrentGUI%Buddy:Show, Hide
	Menu, Tray, Rename, Hide WC3 RPG Loader, Show WC3 RPG Loader
}
return

CPBuddyGuiClose:
{
	%CurrentGUI%GUI = 0
	Gui, %CurrentGUI%Buddy:Show, Hide
	Menu, Tray, Rename, Hide WC3 RPG Loader, Show WC3 RPG Loader
}
return

ReloadScript:
{
	Reload
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
	GoSub, GaiaRefresh
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
	GoSub, HMRefresh
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
	GoSub, TBR13Refresh
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
	GoSub, TBR21Refresh
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
	GoSub, TEVERefresh
}
return

ChangeGOHPath:
{
	Gui GOHBuddy:+OwnDialogs
	IfExist, %A_MyDocuments%\Warcraft III\CustomMapData\Savegames\GoH RPG\
	{
		FileSelectFolder, GOHBuddyPath, *%A_MyDocuments%\Warcraft III\CustomMapData\Savegames\GoH RPG\,, Choose The Folder with GoH Saves
	}
	else
	{
		FileSelectFolder, GOHBuddyPath,,, Choose The Folder with GoH Saves
	}
	IniWrite, %GOHBuddyPath%, %A_ScriptDir%\%ININame%, Settings, GOHPath
	GuiControl, GOHBuddy:, GOHPathText, %GOHBuddyPath%
	GoSub, GOHRefresh
}
return

;============== SETTINGS =================
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

GameShowHide:
{
	If WinExist("Warcraft III")
	{
		switch *= -1
		If (switch = 1)
		{
			WinRestore, Warcraft III
			Menu, Tray, Rename, Show Warcraft III, Hide Warcraft III
		}
		Else
		{
			WinMinimize, Warcraft III
			Menu, Tray, Rename, Hide Warcraft III, Show Warcraft III
		}
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
		FileSelectFile, WC3Path,, *%ProgramFiles%\Warcraft III\, Show your Warcraft3.exe location, EXE (*.exe)
	}
	else
	{
		FileSelectFile, WC3Path,, , Show your Warcraft3.exe location, EXE (*.exe)
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
;============== HOTSTRING =================
#IfWinActive Warcraft III
:B0:-save::
If (CurrentGUI != "Main" && CurrentGUI != "Update")
{
	Sleep, 5000
	IniRead, %CurrentGUI%BuddyPath, %A_ScriptDir%\%ININame%, Settings, %CurrentGUI%Path
	ActivePath := CurrentGUI "BuddyPath"
	SetWorkingDir, %ActivePath%
	GoSub, %CurrentGUI%Refresh
}
return