#SingleInstance force
#InstallKeybdHook
SetTitleMatchMode, 2
#NoEnv
SendMode Input
SetBatchLines -1
#MaxThreadsPerHotkey 2
#UseHook
FileEncoding UTF-8
#LTrim

;=============== INI FILE ====================
ININame := BuildIniName()

ifNotExist, %A_ScriptDir%\%ININame%
{
	NoPath=
	IniWrite, %NoPath%, %A_ScriptDir%\%ININame%, Settings, HMPath
	IniWrite, %NoPath%, %A_ScriptDir%\%ININame%, Settings, GaiaPath
	IniWrite, %NoPath%, %A_ScriptDir%\%ININame%, Settings, TBR13Path
	IniWrite, %NoPath%, %A_ScriptDir%\%ININame%, Settings, TBR21Path
}

IniRead, HMBuddyPath, %A_ScriptDir%\%ININame% , Settings, HMPath
IniRead, GaiaBuddyPath, %A_ScriptDir%\%ININame% , Settings, GaiaPath
IniRead, TBR13BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR13Path
IniRead, TBR21BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR21Path

;////////////////////////////////////////// GUI //////////////////////////////////////////////////////////////////
;=============== MAIN GUI ====================
Gui 99:+LabelMainBuddy
Gui, MainBuddy:Add, Button, x5 y5 w120 gGUIGaia, Gaia Loader
Gui, MainBuddy:Add, Button, x150 y5 w120 gGUIHM, HM Loader
Gui, MainBuddy:Add, Button, x5 y35 w120 gGUITBR13, TBR 1.38 Loader
Gui, MainBuddy:Add, Button, x150 y35 w120 gGUITBR21, TBR 2.1 Loader

Gui, MainBuddy:+ToolWindow
Gui, MainBuddy:Show, Center, Loader (Press CTRL + F1 to Show/Hide)

MainGUI = 1
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

Gui, GaiaBuddy:+ToolWindow
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

Gui, HMBuddy:+ToolWindow
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

Gui, TBR13Buddy:+ToolWindow
Gui, TBR13Buddy:Show, Hide Center, TBR 1.38 Buddy (Press CTRL + F1 to Show/Hide)

TBR13GUI = 0

Gui 3a:+LabelTBR13BuddyStat
Gui, TBR13BuddyStat:Add, Edit,vTBR13data ReadOnly w600, 
Gui, TBR13BuddyStat:Show, Hide Center, Retrieve content

;=============== TBR GUI 2.1 ====================
Gui 3:+LabelTBR21Buddy
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

Gui, TBR21Buddy:+ToolWindow
Gui, TBR21Buddy:Show, Hide Center, TBR 2.1 Buddy (Press CTRL + F1 to Show/Hide)

TBR21GUI = 0

Gui 3a:+LabelTBR21BuddyStat
Gui, TBR21BuddyStat:Add, Edit,vTBR21data ReadOnly w600, 
Gui, TBR21BuddyStat:Show, Hide Center, Retrieve content


return
;////////////////////////////////////////// GAIA //////////////////////////////////////////////////////////////////
;=============== GAIA CODE ====================
GaiaRefresh:
{
	; Empty Old Var
	IniRead, GaiaBuddyPath, %A_ScriptDir%\%ININame% , Settings, GaiaPath
	SetWorkingDir, %GaiaBuddyPath%
	
	Gaiacurrentclass=
	ReplacedStr=
		
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
		aFileList := {}

		Loop, Files, *.txt
		{
			current = 0
			aFileList[A_index] := SubStr(A_LoopFileName, 1, -4)
			TheIndex := aFileList[A_index]
			for i in GaiaArr
			{
				if (InStr(TheIndex, GaiaArr[i]) != 0)
				{
					name:=TheIndex
					GaiaFile.Push(name)
					GaiaClass.Push(GaiaArr[i])
				}
			}
			current++
		}
		for j in GaiaArr
		{
			for i in GaiaClass
			{
				current := GaiaFile[i]
				if (GaiaClass[i] = GaiaArr[j])
				{
					class := GaiaArr[j]
					if (!Gaiacurrentclass)
					{
						Gaiacurrentclass = %current%
					}
					else {
						Gaiacurrentclass = %current%|%Gaiacurrentclass%
					}
				}
			}
			if (Gaiacurrentclass)
			{
				ReplacedStr := sortByNumberWithin(Gaiacurrentclass,"|")
				ReplacedStr := StrReplace(ReplacedStr, "|" , " | ")
				ReplacedStr=| %ReplacedStr%
				GuiControl, GaiaBuddy:, %class%choice, %ReplacedStr%
				GuiControl, GaiaBuddy:Choose, %class%choice, 1
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
	SaveName :=  SubStr(A_GuiControl, 1, -2)
	SaveName = %SaveName%choice
	GuiControlGet, CurrentFile ,, %SaveName%, Text
	CurrentFile=%CurrentFile%
	CurrentFile = %CurrentFile%.txt
	CurrentPath = %GaiaBuddyPath%\%CurrentFile%
	if FileExist(CurrentPath)
	{		
		SetTitleMatchMode, 1
		If WinExist("Warcraft III")
		{
			FileReadLine, code, %CurrentFile%, 3
			code=%code% 
			StringTrimLeft, code, code, 25 
			StringTrimRight, code, code, 7
			
			FileReadLine, lvl, %CurrentFile%, 4
			lvl=%lvl%
			StringTrimLeft, lvl, lvl, 39
			StringTrimRight, lvl, lvl, 6
			
			WinActivate, Warcraft III
			Clipboard := "Loading : " . lvl
			ClipWait, 200
			Send {esc}{Enter}^v{Enter}
			Sleep 200
			Clipboard := "-load " . code
			ClipWait,200
			Send {esc}{Enter}^v{Enter} 
		}
		else
		{
			MsgBox, 4096, No Warcraft III, You need to open Warcraft III before loading !
		}
	}
	else
	{
		MsgBox, 4096, Invalid Save File, No Save Found !
	}
}
return
LoadGaiaVault:
{
	IniRead, GaiaBuddyPath, %A_ScriptDir%\%ININame% , Settings, GaiaPath
	SetWorkingDir, %GaiaBuddyPath%
	CurrentPath = %GaiaBuddyPath%\Vault.txt
	if FileExist(CurrentPath)
	{	
		SetTitleMatchMode, 1
		If WinExist("Warcraft III")
		{
			WinActivate, Warcraft III
			FileReadLine, code, Vault.txt, 3
			StringTrimLeft, code, code, 20
			StringTrimRight, code, code, 7
			Sleep 200
			Clipboard := "Loading : Vault"
			ClipWait, 200
			Send {esc}{Enter}^v{Enter}
			Sleep 200
			Clipboard := code
			ClipWait,200
			Send {esc}{Enter}^v{Enter}
		}
		else
		{
			MsgBox, 4096, No Warcraft III, You need to open Warcraft III before loading !
		}
		SetTitleMatchMode, 2
	}
	else
	{
		MsgBox, 4096, Invalid Save File, No Vault Found !
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
			start = 0
			Loop, 
			{
				FileReadLine, fileline, %A_LoopFileName%, A_Index
				If (A_Index = 4)
				{
					currCode = %fileline%
					StringTrimLeft, currCode, currCode, 22
					StringTrimRight, currCode, currCode, 3
					HMCodes.Push(currCode)
				}
				if InStr(fileline, "Chat Message")
				{
					start = 0
					full = | FileName: %A_LoopFileName% %full% | Code: %currCode%
					HMStats.Push(full)
					GuiControl, HMBuddy:, hmclasschoice, %ClassOption%
					GuiControl, HMBuddy:Choose, hmclasschoice, 1
					full=
					Break
				}
				if (start = 1)
				{
					currentline = %fileline%
					StringTrimLeft, currentline, currentline, 15
					StringTrimRight, currentline, currentline, 3
					currentline := StrReplace(currentline, "|" , " ")
					full = %full% | %currentline%
					if InStr(currentline, "Char:")
					{
						currChar = %fileline%
						StringTrimLeft, currChar, currChar, 21
						StringTrimRight, currChar, currChar, 3
						HMClass.Push(currChar)
						if (ClassOption)
						{
							if InStr(ClassOption, currChar)
							{
								
							}
							else
							{
								ClassOption = %ClassOption% | %currChar%
							}
						}
						else
						{
							ClassOption = | %currChar%
						}
					}
					if InStr(currentline, "Lv:")
					{
						currLvl = %fileline%
						StringTrimLeft, currLvl, currLvl, 19
						StringTrimRight, currLvl, currLvl, 3
						HMClasses.Push(currChar " Lvl " currLvl)
						HMLvl.Push(currLvl)
					}
				}
				if InStr(fileline, "Data Stats")
				{
					start = 1
				}
			}
		}
		ClassOption=
	}
}
return

HMChoice:
{
	IniRead, HMBuddyPath, %A_ScriptDir%\%ININame%, Settings, HMPath
	SetWorkingDir, %HMBuddyPath%
	GuiControlGet, HMCurrentClass,, hmclasschoice, 
	CurrentStat := []
	CurrentCodes := []
	CurrentLvls := []
	for i in HMClass
	{
		curr := HMClasses[i]
		HMCurrentClass=%HMCurrentClass%
		If InStr(curr, HMCurrentClass)
		{
			CurrStats := HMStats[i]
			CurrentStat.Push(CurrStats)
			CurrCodes := HMCodes[i]
			CurrentCodes.Push(CurrCodes)
			CurrLvls := HMLvl[i]
			CurrentLvls.Push(CurrLvls)
		}
	}
	;;;; freaking sorting issue ;;;;;;;;
	for i in CurrentLvls
	{
		newlvl := CurrentLvls[i]
		if (!lvllist)
		{
			lvllist = %newlvl%
		}
		else
		{
			lvllist = %lvllist% `n%newlvl%
		}
		newcode := CurrentCodes[i]
		if (!codelist)
		{
			codelist = %newcode%
		}
		else
		{
			codelist = %codelist% `n%newcode%
		}
		newstat := CurrentStat[i]
		if (!statlist)
		{
			statlist = %newstat%
		}
		else
		{
			statlist = %statlist% `n%newstat%
		}
	}
	Obj := [lvllist, codelist, statlist]
	lvllist=
	sortingnonsense := new GroupSort(Obj, "N R")
	HMArrLvls := StrSplit(sortingnonsense.fetch("1") , "`n")
	HMArrCodes := StrSplit(sortingnonsense.fetch("2") , "`n")
	HMArrStat := StrSplit(sortingnonsense.fetch("3") , "`n")
	for i in HMArrLvls {
		newlvlvar := HMArrLvls[i]
		if (!lvllist)
		{
			lvllist = | Level: %newlvlvar%
		}
		else
		{
			lvllist = %lvllist% | Level: %newlvlvar%
		}
	}
	DefaultStat := HMArrStat[1]
	CurrentCode := HMArrCodes[1]
	GuiControl, HMBuddy:, hmclasslist, %lvllist%
	GuiControl, HMBuddy:Choose, hmclasslist, 1
	GuiControl, HMBuddy:, hmclassinfo, %DefaultStat%
	GuiControl, HMBuddy:Choose, hmclassinfo, 1
	lvllist=
	codelist=
	statlist=
}
return

HMCharChoice:
{
	IniRead, HMBuddyPath, %A_ScriptDir%\%ININame%, Settings, HMPath
	SetWorkingDir, %HMBuddyPath%
	GuiControlGet, CurrentCharNum,, hmclasslist,
	ChosenStat := HMArrStat[CurrentCharNum]
	CurrentCode := HMArrCodes[CurrentCharNum]
	GuiControl, HMBuddy:, hmclassinfo, %ChosenStat%
	GuiControl, HMBuddy:Choose, hmclassinfo, 1
}
return

HMStatChoice:
{
	IniRead, HMBuddyPath, %A_ScriptDir%\%ININame%, Settings, HMPath
	SetWorkingDir, %HMBuddyPath%
	GuiControlGet, CurrentStatNum,, hmclassinfo,
	GuiControlGet, CurrentCharNum,, hmclasslist,
	ChosenStat := HMArrStat[CurrentCharNum]
	StringTrimLeft, ChosenStat, ChosenStat, 2
	ArrStat2 := StrSplit(ChosenStat , " | ")
	GetStat := ArrStat2[CurrentStatNum]
	GuiControl, HMBuddyStat:, data, %GetStat%
	Gui, HMBuddyStat:Show
	Gui, HMBuddyStat:+AlwaysOnTop
}
return

LoadHM:
{
	IniRead, HMBuddyPath, %A_ScriptDir%\%ININame%, Settings, HMPath
	SetWorkingDir, %HMBuddyPath%
	GuiControlGet, CurrentCharNum,, hmclasslist,
	GuiControlGet, CurrentClassName,, hmclasschoice,
	if (CurrentClassName && CurrentCharNum)
	{
		Clipboard := "Loading : " . CurrentClassName . " Level " . HMArrLvls[CurrentCharNum]
		SetTitleMatchMode, 1
		If WinExist("Warcraft III")
		{
			WinActivate, Warcraft III
			ClipWait, 200
			Send {esc}{Enter}^v{Enter}
			Sleep 200
			Send {esc}{enter}-load{enter}
			Sleep 1500
			Clipboard := CurrentCode
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
			MsgBox, 4096, No Warcraft III, You need to open Warcraft III before loading !
		}
		SetTitleMatchMode, 2
	}
	else
	{
		MsgBox, 4096, Invalid Save File, You need to choose a Save !
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
	CharList=
	
	If (TBR13BuddyPath)
	{
		Loop, Files, *.txt
		{
			TBR13CharTXT.Push(A_LoopFileName)
			FileReadLine, fileline, %A_LoopFileName%, 11
			StringTrimLeft, fileline, fileline, 9
			TBR13Char.Push(fileline)
			if (!CharList)
			{
				CharList= | %fileline%
			}
			else
			{
				CharList= %CharList% | %fileline%
			}
			GuiControl, TBR13Buddy:, tbr13classchoice, %CharList%
			GuiControl, TBR13Buddy:Choose, tbr13classchoice, 1
		}
	}
}
return
TBR13Choice:
{
	IniRead, TBR13BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR13Path
	SetWorkingDir, %TBR13BuddyPath%
	GuiControlGet, CurrentCharNum,, tbr13classchoice,
	TBR13CharStat := []
	CurrTXT := TBR13CharTXT[CurrentCharNum]
	StatList=
	Loop, 
	{
		FileReadLine, fileline, %CurrTXT%, A_Index
		If (A_Index > 10 && A_Index < 17)
		{
			StringTrimLeft, fileline, fileline, 2
			
			If (!StatList)
			{
				StatList = FileName: %CurrTXT%
				TBR13CharStat.Push(StatList)
				StatList = | FileName: %CurrTXT% | %fileline%
			}
			else
			{
				StatList = %StatList% | %fileline%
			}
			TBR13CharStat.Push(fileline)
		}
		If (A_Index > 16)
		{
			Break
		}
	}
	GuiControl, TBR13Buddy:, tbr13classinfo, %StatList%
	GuiControl, TBR13Buddy:Choose, tbr13classinfo, 1
}
return
TBR13StatChoice:
{
	IniRead, TBR13BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR13Path
	SetWorkingDir, %TBR13BuddyPath%
	GuiControlGet, CurrentStatNum,, tbr13classinfo,
	GuiControlGet, CurrentCharNum,, tbr13classchoice,
	ChosenStat := TBR13CharStat[CurrentStatNum]
	GuiControl, TBR13BuddyStat:, TBR13data, %ChosenStat%
	Gui, TBR13BuddyStat:Show
	Gui, TBR13BuddyStat:+AlwaysOnTop
}
return
LoadTBR13:
{
	IniRead, TBR13BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR13Path
	SetWorkingDir, %TBR13BuddyPath%
	GuiControlGet, CurrentCharNum,, tbr13classchoice,
	if (CurrentCharNum && TBR13CharStat)
	{
		CurrTXT := TBR13CharTXT[CurrentCharNum]
		CurrCode := TBR13CharStat[6]
		StringTrimLeft, CurrCode, CurrCode, 6
		CurrBank := TBR13CharStat[7]
		StringTrimLeft, CurrBank, CurrBank, 6
		CurrClass := TBR13CharStat[2]
		StringTrimLeft, CurrClass, CurrClass, 7
		CurrLvl := TBR13CharStat[3]
		StringTrimLeft, CurrLvl, CurrLvl, 7
		Clipboard := "Loading : " . CurrClass . " Level " . CurrLvl
		SetTitleMatchMode, 1
		If WinExist("Warcraft III")
		{
			WinActivate, Warcraft III
			ClipWait, 200
			Send {esc}{Enter}^v{Enter}
			Sleep 200
			Clipboard := CurrCode
			ClipWait, 200
			Send {esc}{Enter}^v{Enter}
			Sleep 1000
			Clipboard := CurrBank
			ClipWait, 200
			Send {esc}{Enter}^v{Enter}
			Sleep 1000
		}
		else
		{
			MsgBox, 4096, No Warcraft III, You need to open Warcraft III before loading !
		}
		SetTitleMatchMode, 2
	}
	else
	{
		MsgBox, 4096, Invalid Save File, You need to choose a Save !
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
	ClassList=
	
	If (TBR21BuddyPath)
	{
		Loop, Files, *.txt
		{
			TBR21CharTXT.Push(A_LoopFileName)
			Loop, 10
			{
				FileReadLine, fileline, %A_LoopFileName%, A_Index
				If InStr(fileline, "-load")
				{
					fileline := StrReplace(fileline, "`t" , "")
					break
				}
			}
			TBR21Code.Push(fileline)
			TBR21FileName := A_LoopFileName
			StringTrimRight, TBR21FileName, TBR21FileName, 4
			TBR21Curr := StrSplit(TBR21FileName , "; ")
			TBR21Class.Push(TBR21Curr[1])
			TBR21LvlNum := TBR21Curr[2]
			StringTrimLeft, TBR21LvlNum, TBR21LvlNum, 4
			TBR21Lvl.Push(TBR21LvlNum)
			TBR21XP.Push(TBR21Curr[3])
			currChar := TBR21Class[A_Index]
			if (ClassList)
			{
				if InStr(ClassList, currChar)
				{
					
				}
				else
				{
					ClassList = %ClassList%|%currChar%
				}
			}
			else
			{
				ClassList = |%currChar%
			}
		}
		GuiControl, TBR21Buddy:, tbr21classchoice, %ClassList%
		GuiControl, TBR21Buddy:Choose, tbr21classchoice, 1
	}
}
return
TBR21Choice:
{
	IniRead, TBR21BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR21Path
	SetWorkingDir, %TBR21BuddyPath%
	GuiControlGet, CurrentClass,, tbr21classchoice, 
	TBR21LvlCurr := []
	TBR21XPCurr := []
	TBR21CodeCurr := []
	TBR21CharTXTCurr := []
	TBR21StatCurr := []
	for i in TBR21Class
	{
		curr := TBR21Class[i]
		If(curr = CurrentClass)
		{
			CurrTXT := TBR21CharTXT[i]
			CurrLvl := TBR21Lvl[i]
			CurrXP := TBR21XP[i]
			CurrCode := TBR21Code[i]
			
			CurrentStat = | FileName: %CurrTXT% | Level: %CurrLvl% | XP: %CurrXP% | Code: %CurrCode%
			TBR21CharTXTCurr.Push(TBR21CharTXT[i])
			TBR21LvlCurr.Push(TBR21Lvl[i])
			TBR21XPCurr.Push(TBR21XP[i])
			TBR21CodeCurr.Push(TBR21Code[i])
			TBR21StatCurr.Push(CurrentStat)
		}
		else
		{
		}
	}
	;;;; freaking sorting issue ;;;;;;;;
	for i in TBR21LvlCurr
	{
		newlvl := TBR21LvlCurr[i]
		if (!lvllist)
		{
			lvllist = %newlvl%
		}
		else
		{
			lvllist = %lvllist% `n%newlvl%
		}
		newcode := TBR21CodeCurr[i]
		if (!codelist)
		{
			codelist = %newcode%
		}
		else
		{
			codelist = %codelist% `n%newcode%
		}
		newstat := TBR21StatCurr[i]
		if (!statlist)
		{
			statlist = %newstat%
		}
		else
		{
			statlist = %statlist% `n%newstat%
		}
		
		newxp := TBR21XPCurr[i]
		if (!xplist)
		{
			xplist = %newxp%
		}
		else
		{
			xplist = %xplist% `n%newxp%
		}
		newtxt := TBR21CharTXTCurr[i]
		if (!statlist)
		{
			txtlist = %newtxt%
		}
		else
		{
			txtlist = %txtlist% `n%newtxt%
		}
	}
	Obj := [lvllist, codelist, statlist, xplist, txtlist]
	lvllist=
	codelist=
	statlist=
	xplist=
	txtlist=
	sortingnonsense := new GroupSort(Obj, "N R")
	TBR21ArrLvls := StrSplit(sortingnonsense.fetch("1") , "`n")
	TBR21ArrCodes := StrSplit(sortingnonsense.fetch("2") , "`n")
	TBR21ArrStat := StrSplit(sortingnonsense.fetch("3") , "`n")
	TBR21ArrXP := StrSplit(sortingnonsense.fetch("4") , "`n")
	TBR21ArrTXT := StrSplit(sortingnonsense.fetch("5") , "`n")
	for i in TBR21ArrLvls {
		newlvlvar := TBR21ArrLvls[i]
		newxpvar := TBR21ArrXP[i]
		if (!lvllist)
		{
			lvllist = | Level: %newlvlvar% - XP: %newxpvar%
		}
		else
		{
			lvllist = %lvllist% | Level: %newlvlvar% - XP: %newxpvar%
		}
	}
	DefaultStat := TBR21ArrStat[1]
	CurrentCode := TBR21ArrCodes[1]
	GuiControl, TBR21Buddy:, tbr21classlist, %lvllist%
	GuiControl, TBR21Buddy:Choose, tbr21classlist, 1
	GuiControl, TBR21Buddy:, tbr21classinfo, %DefaultStat%
	GuiControl, TBR21Buddy:Choose, tbr21classinfo, 1
	lvllist=
}
return
TBR21CharChoice:
{
	IniRead, TBR21BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR21Path
	SetWorkingDir, %TBR21BuddyPath%
	GuiControlGet, CurrentCharNum,, tbr21classlist, 
	ChosenStat := TBR21ArrStat[CurrentCharNum]
	CurrentCode := TBR21ArrCodes[CurrentCharNum]
	GuiControl, TBR21Buddy:, tbr21classinfo, %ChosenStat%
	GuiControl, TBR21Buddy:Choose, tbr21classinfo, 1
}
return
TBR21StatChoice:
{
	IniRead, TBR21BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR21Path
	SetWorkingDir, %TBR21BuddyPath%
	GuiControlGet, CurrentStatNum,, tbr21classinfo,
	GuiControlGet, CurrentCharNum,, tbr21classlist,
	ChosenStat := TBR21ArrStat[CurrentCharNum]
	StringTrimLeft, ChosenStat, ChosenStat, 2
	ArrStat2 := StrSplit(ChosenStat , " | ")
	GetStat := ArrStat2[CurrentStatNum]
	GuiControl, TBR21BuddyStat:, TBR21data, %GetStat%
	Gui, TBR21BuddyStat:Show
	Gui, TBR21BuddyStat:+AlwaysOnTop
}
return
LoadTBR21:
{
	IniRead, TBR21BuddyPath, %A_ScriptDir%\%ININame% , Settings, TBR21Path
	SetWorkingDir, %TBR21BuddyPath%
	GuiControlGet, CurrentChar,, tbr21classchoice,
	GuiControlGet, CurrentCharNum,, tbr21classlist,
	
	if (CurrentChar && CurrentCharNum)
	{
		CurrCode := TBR21ArrCodes[CurrentCharNum]
		CurrLvl := TBR21ArrLvls[CurrentCharNum]
		CurrClass := CurrentChar
		CurrXP := TBR21ArrXP[CurrentCharNum]
		
		Clipboard := "Loading : " . CurrClass . " - Level " . CurrLvl . " - XP " . CurrXP
		SetTitleMatchMode,1
		If WinExist("Warcraft III")
		{
			WinActivate, Warcraft III
			ClipWait, 200
			Send {esc}{Enter}^v{Enter}
			Sleep 200
			Clipboard := CurrCode
			ClipWait, 200
			Send {esc}{Enter}^v{Enter}
			Sleep 200
		}
		else
		{
			MsgBox, 4096, No Warcraft III, You need to open Warcraft III before loading !
		}
		SetTitleMatchMode, 2
	}
	else
	{
		MsgBox, 4096, Invalid Save File, You need to choose a Save !
	}
}
return

;////////////////////////////////////////// OTHER ///////////////////////////////////////////////////////////////
;============== FUNCTIONS =================
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

/*
###############################################################################
GroupSort v0.1 by Avi Aryan : Sorts multiple related lists together taking any of those lists as a base
###############################################################################
SEE EXAMPLES AT - https://github.com/avi-aryan/Avis-Autohotkey-Repo/blob/master/Example_files/GroupSort-examples.ahk
MY SCRIPTS - http://avi-aryan.github.io/Autohotkey.html
*/
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

Back:
{
	MainGUI = 1
	Gui, %CurrentGUI%Buddy:Show, Hide
	%CurrentGUI%GUI = 0
	CurrentGUI = Main
	Gui, MainBuddy:Show
	Gui, MainBuddy:+AlwaysOnTop
}
return

GUIGaia:
{
	CurrentGUI = Gaia
	Gui, %CurrentGUI%Buddy:Show
	Gui, %CurrentGUI%Buddy:+AlwaysOnTop
	%CurrentGUI%GUI = 1
	Gui, MainBuddy:Show, Hide
	MainGUI = 0
	IniRead, GaiaBuddyPath, %A_ScriptDir%\%ININame%, Settings, GaiaPath
	SetWorkingDir, %GaiaBuddyPath%
	GoSub, GaiaRefresh
}
return

GUIHM:
{
	CurrentGUI = HM
	Gui, %CurrentGUI%Buddy:Show
	Gui, %CurrentGUI%Buddy:+AlwaysOnTop
	%CurrentGUI%GUI = 1
	Gui, MainBuddy:Show, Hide
	MainGUI = 0
	IniRead, HMBuddyPath, %A_ScriptDir%\%ININame%, Settings, HMPath
	SetWorkingDir, %HMBuddyPath%
	GoSub, HMRefresh
}
return

GUITBR13:
{
	CurrentGUI = TBR13
	Gui, %CurrentGUI%Buddy:Show
	Gui, %CurrentGUI%Buddy:+AlwaysOnTop
	%CurrentGUI%GUI = 1
	Gui, MainBuddy:Show, Hide
	MainGUI = 0
	IniRead, TBR13BuddyPath, %A_ScriptDir%\%ININame%, Settings, TBR13Path
	SetWorkingDir, %TBR13BuddyPath%
	GoSub, TBR13Refresh
}
return

GUITBR21:
{
	CurrentGUI = TBR21
	Gui, %CurrentGUI%Buddy:Show
	Gui, %CurrentGUI%Buddy:+AlwaysOnTop
	%CurrentGUI%GUI = 1
	Gui, MainBuddy:Show, Hide
	MainGUI = 0
	IniRead, TBR21BuddyPath, %A_ScriptDir%\%ININame%, Settings, TBR21Path
	SetWorkingDir, %TBR21BuddyPath%
	GoSub, TBR21Refresh
}
return
;============== CHANGE PATH =================
ChangeGaiaPath:
{
	Gui GaiaBuddy:+OwnDialogs
	IfExist, %A_MyDocuments%\Warcraft III\CustomMapData\GaiasRetaliation
	{
		FileSelectFolder, GaiaBuddyPath, %A_MyDocuments%\Warcraft III\CustomMapData\GaiasRetaliation\,, Choose The Folder with Gaia Saves
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
		FileSelectFolder, HMBuddyPath, %A_MyDocuments%\Warcraft III\CustomMapData\Grabiti's RPG Creator, 3, Choose The Folder with HM Saves
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
		FileSelectFolder, TBR13BuddyPath, %A_MyDocuments%\Warcraft III\CustomMapData\TBR Saves\,, Choose The Folder with TBR 1.38 Saves
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
		FileSelectFolder, TBR21BuddyPath, %A_MyDocuments%\Warcraft III\CustomMapData\Savegames\TBR 2,, Choose The Folder with TBR 2.1 Saves
	}
	else
	{
		FileSelectFolder, TBR21BuddyPath,,, Choose The Folder with TBR 2.1 Saves
	}
	IniWrite, %TBR21BuddyPath%, %A_ScriptDir%\%ININame%, Settings, TBR21Path
	GuiControl, TBR21Buddy:, TBR21PathText, %TBR21BuddyPath%
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