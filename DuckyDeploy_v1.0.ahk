#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;AHK Auto loader GUI for USB Rubber Ducky
;    Compile and install DUCK scripts for custom firmware versions.
;
; 0703.xxxx Changelog
;    .0831 Implemented keyboard layout changer
;    .0934 Added ducky icon experiment... it kinda worked... have to change many may icons though...
;
;
;    Wishlist
;        -    Custom layout chooser
;        -    Overwrite all checkbox
;            -    Overwrite all checkbox works... kinda... deletes all of the files before continuing... lololol
;        -    Include the ability to change your encoder?/specify one?
;
;
;    MegaWish
;        -    Verify that a drive and not a folder is selected
;        -    Verify that the compiler finished
;
; Copyright July, 2014
; By fiveseven808
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#NoTrayIcon
#SingleInstance,force
;Variable Initialization
scriptfile1 = None
scriptfile2 = None
scriptfile3 = None
scriptfile4 = None
TestVarON = 0

;Initialize variables for testing purposes
LoadTestVariables:
If TestVarON = 1
{
    PathLetter = C
    scriptpath1 = C:\Users\OMITTED\Desktop\ducky\DuckEncoder_2_6_3\ccs.duck
    scriptpath2 = C:\Users\OMITTED\Desktop\ducky\DuckEncoder_2_6_3\ccs_2.duck
    scriptpath3 = C:\Users\OMITTED\Desktop\ducky\DuckEncoder_2_6_3\ccs_3.duck
    scriptpath4 = C:\Users\OMITTED\Desktop\ducky\DuckEncoder_2_6_3\ccs_4.duck
}

;Ask the user for an output path upon bootup
Querypath:
{
    Gui, Add, Text,, Ducky SD Card Drive Letter:
    Gui, Add, Edit, vPathLetter ym  
    Gui, Add, Button, default, OK  
    Gui, Show,, Initial Config
    Return  
}

;After the user submits the form, check to see if path is empty or not (located in Main routine after GUI is created)
ButtonOK:
Gui, Submit

;Main GUI routine
Main:
Gui,Destroy
Gui,Add,Checkbox,x261 y41 w70 h13 gChkChange vNL1,NumLock
Gui,Add,Checkbox,x350 y41 w70 h13 gChkChange vCL1,CapsLock
Gui,Add,Checkbox,x172 y41 w70 h13 gChkChange vOB1,On Boot
Gui,Add,Checkbox,x439 y41 w75 h13 gChkChange vSL1,ScrollLock
Gui,Add,Checkbox,x529 y41 w90 h13 gChkChange vSS1,Single Script
Gui,Add,Checkbox,x261 y76 w70 h13 gChkChange vNL2,NumLock
Gui,Add,Checkbox,x350 y76 w70 h13 gChkChange vCL2,CapsLock
Gui,Add,Checkbox,x172 y76 w70 h13 gChkChange vOB2,On Boot
Gui,Add,Checkbox,x439 y76 w75 h13 gChkChange vSL2,ScrollLock
Gui,Add,Checkbox,x529 y76 w90 h13 gChkChange vSS2,Single Script
Gui,Add,Checkbox,x261 y111 w70 h13 gChkChange vNL3,NumLock
Gui,Add,Checkbox,x350 y111 w70 h13 gChkChange vCL3,CapsLock
Gui,Add,Checkbox,x172 y111 w70 h13 gChkChange vOB3,On Boot
Gui,Add,Checkbox,x439 y111 w75 h13 gChkChange vSL3,ScrollLock
Gui,Add,Checkbox,x529 y111 w90 h13 gChkChange vSS3,Single Script
Gui,Add,Checkbox,x261 y147 w70 h13 gChkChange vNL4,NumLock
Gui,Add,Checkbox,x350 y147 w70 h13 gChkChange vCL4,CapsLock
Gui,Add,Checkbox,x172 y147 w70 h13 gChkChange vOB4,On Boot
Gui,Add,Checkbox,x439 y147 w75 h13 gChkChange vSL4,ScrollLock
Gui,Add,Checkbox,x529 y147 w90 h13 gChkChange vSS4,Single Script
Gui,Add,Text,x59 y10 w60 h13,Script Name
Gui,Add,Text,x187 y23 w400 h13,-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Gui,Add,Text,x40 y23 w100 h13,-------------------------------------
Gui,Add,Text,x326 y11 w120 h13,Script Activation Control
Gui,Add,Button,x21 y36 w43 h23 gBrowseFile1 Default, Browse    
Gui,Add,Button,x21 y72 w43 h23 gBrowseFile2, Browse
Gui,Add,Button,x21 y108 w43 h23 gBrowseFile3, Browse
Gui,Add,Button,x21 y144 w43 h23 gBrowseFile4, Browse
Gui,Add,Text,x73 y42 w70 vScriptnames1,%scriptfile1%
Gui,Add,Text,x73 y77 w70 vScriptnames2,%scriptfile2%
Gui,Add,Text,x73 y112 w70 vScriptnames3,%scriptfile3%
Gui,Add,Text,x73 y148 w70 vScriptnames4,%scriptfile4%
Gui,Add,Text,x400 y180 w150 vUpdatePath, Files will be written to %PathLetter%:\ Drive
Gui,Add,Text,x422 y205 w150, Compile and Load Scripts!
Gui,Add,Checkbox,x25 y185 h13 vEAC,&Eject Drive After Compiling
Gui,Add,Checkbox,x25 y205 h13 vOAS,&Delete all files before Compiling
Gui,Add,ComboBox,x25 y225 w40 vKeyboardLayout, us||be|ca|ch|de|dk|es|fr|gb|it|no|pt|ru|se|sv|uk
Gui,Add,Text,x72 y228,Keyboard Layout
Gui,Add,Button,x550 y175 w70 h23 ,Change &Path
Gui,Add,Button,x550 y200 w49 h23 ,&Compile
Gosub CheckOPath
;Gui,Show,x232 y276 w661 h187 ,
Gui,Show, , Ducky Deploy: The USB Rubber Ducky Helper
WinActivate, Ducky Deploy: The USB Rubber Ducky Helper
return  

CheckOPath:
{
    If PathLetter =
    {
        Msgbox, 48,WARNING, WARNING `nYou didn't specify an initial output path
        GuiControl,,Updatepath,WARNING! No Drive Selected
        Gui, Font, cRed
        GuiControl,Font,UpdatePath
    }
    Return
}

;When the user wants to change the output path, this subroutine will change it then update the GUI
ButtonChangePath:
{
    FileSelectFolder, PathLetter
    PathLetter := RegExReplace(PathLetter, ":\\$")
    GuiControl,,Updatepath, Files will be written to %PathLetter%:\ Drive
    Gui, Font, cNorm
    GuiControl,Font,UpdatePath
    Gosub CheckOPath
    return
}

;The Next 4 subroutines connect to a button and correspondingly select a file and update the gui.
BrowseFile1:
{
    scriptfile1 := BrowseFilefunc(scriptpath1)
    GuiControl,,Scriptnames1,%scriptfile1%
    return
}
BrowseFile2:
{
    scriptfile2 := BrowseFilefunc(scriptpath2)
    GuiControl,,Scriptnames2,%scriptfile2%
    return
}
BrowseFile3:
{
    scriptfile3 := BrowseFilefunc(scriptpath3)
    GuiControl,,Scriptnames3,%scriptfile3%
    return
}
BrowseFile4:
{
    scriptfile4 := BrowseFilefunc(scriptpath4)
    GuiControl,,Scriptnames4,%scriptfile4%
    return
}

;When a checkbox is checked off, this subroutine will go and run a function to determine what boxes it should disable.
ChkChange:
{
    tftemp = 0
    ResetChkVar = 0
    ChkChangeFcn("NL",0,0)
    ChkChangeFcn("CL",0,0)
    ChkChangeFcn("SL",0,0)
    ChkChangeFcn("OB",0,0)
    ChkChangeFcn("SS",0,0)
    SSactive := CheckSSActivated()
    Return
}

; This function disables all boxes and returns "1" if an SS is checked
CheckSSActivated()
{
    Loop, 4
    {
        GuiControlGet, CheckBoxState,,SS%A_Index%
        If (CheckBoxState = 1)
        {
            ChkChangeFcn("NL",1,0)
            ChkChangeFcn("CL",1,0)
            ChkChangeFcn("SL",1,0)
            ChkChangeFcn("OB",1,0)
            tftemp = 1
        }
    }
    return %tftemp%
}

;This function is called by the ChkChange subroutine and disables checkboxes that make sense
ChkChangeFcn(BoxType,KillAll,SaveLCN)
{
    Loop, 4
    {
        GuiControlGet, CheckBoxState,,%BoxType%%A_Index%
        If (CheckBoxState = 1 AND KillAll = 0)
        {
            GuiControl, Enable, %BoxType%%A_Index%
            If (SaveLCN = 1)
            {
                scripttoloadtemp = % scriptpath%A_Index%
            }
        }
        Else
        {
           GuiControl, Disable, %BoxType%%A_Index%
           ResetChkVar++
        }
    }
    If (ResetChkVar = 4 AND KillAll = 0)
    {
        Loop, 4
        {
            GuiControl, Enable, %BoxType%%A_Index%
        }
    }
    Return %scripttoloadtemp%
}

;This subroutine is called when the browse button for a ducky file is pushed.
BrowseFileFunc(ByRef ScriptFullPath)
{
    FileSelectFile, ScriptFullPath, 3, Filename, Open a file, Ducky Scripts (*.duck)
    If ScriptFullPath =
        MsgBox, You didn't select anything.
    Else
        SplitPath, ScriptFullPath, ScriptFilenameOnly
    Return ScriptFilenameOnly
}    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ButtonCompile:
{
    Gui, Submit, NoHide
    Gosub CheckOPath
    Gosub LoadallScripts
    Gosub CheckOverwrite
    Gosub CompileScripts
    Gosub CheckandEject
Return
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Subroutines in ButtonCompile
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LoadallScripts:
{
    If (SSactive = 1)
    {
        scripttoload1 := ChkChangeFcn("SS",0,1)
        scripttoload2 := ChkChangeFcn("SS",0,1)
        scripttoload3 := ChkChangeFcn("SS",0,1)
        scripttoload4 := ChkChangeFcn("SS",0,1)
    }
    Else
    {
        scripttoload1 := ChkChangeFcn("OB",0,1)
        scripttoload2 := ChkChangeFcn("NL",0,1)
        scripttoload3 := ChkChangeFcn("CL",0,1)
        scripttoload4 := ChkChangeFcn("SL",0,1)
    }
    MsgBox, Scripts to be run `n`nOnBoot Script = `n%scripttoload1% `nNumLock Script = `n%scripttoload2% `nCapsLock Script = `n%scripttoload3% `nScrollLock Script = `n%scripttoload4%
    Return
}

CheckOverwrite:
{
GuiControlGet, OASBoxState,,OAS
    If OASBoxState = 1
    {
        msgbox, deleting all files lol
        Loop 4
        {
            If A_Index = 1
            {
                FileDelete %PathLetter%:\inject.bin
            }
            IfExist, %PathLetter%:\inject%A_index%.bin
            {
                FileDelete %PathLetter%:\inject%A_Index%.bin
            }
        }
    }
    Loop 4
    {
        If A_Index = 1
        {
            IfExist, %PathLetter%:\inject.bin
            {
                Msgbox, 3, Delete?, The script for On Boot already exists. Delete before Overwriting?
                IfMsgbox Yes
                {
                    Omitt1 = 0
                    FileDelete %PathLetter%:\inject.bin
                }
                Else IfMsgbox No
                {
                    Omitt1 = 1
                }
                Else IfMsgbox Cancel
                {
                    return
                }
            }
        }
        IfExist, %PathLetter%:\inject%A_index%.bin
        {
            Msgbox, 3, Delete?, The inject%A_Index%.bin already exists. Delete before Overwriting?
            IfMsgbox Yes
            {
                Omitt%A_Index% = 0
                FileDelete %PathLetter%:\inject%A_Index%.bin
            }
            Else IfMsgbox No
            {
                Omitt%A_Index% = 1
                Continue
            }
            Else IfMsgbox Cancel
            {
                return
            }
        }
    }
    Return
}

CompileScripts:
{
    Loop 4,
    {
        Omitttempvar := Omitt%A_index%
        If Omitttempvar = 1
        {
            Continue
        }
        Else
        {
            If A_Index = 1
            {
                tempscriptvar := scripttoload%A_Index%
                Run java -jar "DuckEncoder_2_6_3\encoder.jar" -i "%tempscriptvar%" -o %PathLetter%:\inject.bin -l %KeyboardLayout%
            }
            Else
            {
                tempscriptvar := scripttoload%A_Index%
                Run java -jar "DuckEncoder_2_6_3\encoder.jar" -i "%tempscriptvar%" -o %PathLetter%:\inject%A_Index%.bin -l %KeyboardLayout%
            }
        }
    }
    MsgBox, Compiling Complete!
    Return
}

CheckandEject:
{
    GuiControlGet, CheckBoxState,,EAC
    If (CheckBoxState = 1)
    {
        EjectDrive(PathLetter)
    }
    Return
}

EjectDrive(DriveL)
{
    Driveletter = %DriveL%:  ; Set this to the drive letter you wish to eject.

    hVolume := DllCall("CreateFile"
        , Str, "\\.\" . Driveletter
        , UInt, 0x80000000 | 0x40000000  ; GENERIC_READ | GENERIC_WRITE
        , UInt, 0x1 | 0x2  ; FILE_SHARE_READ | FILE_SHARE_WRITE
        , UInt, 0
        , UInt, 0x3  ; OPEN_EXISTING
        , UInt, 0, UInt, 0)
    if hVolume <> -1
    {
        DllCall("DeviceIoControl"
            , UInt, hVolume
            , UInt, 0x2D4808   ; IOCTL_STORAGE_EJECT_MEDIA
            , UInt, 0, UInt, 0, UInt, 0, UInt, 0
            , UIntP, dwBytesReturned  ; Unused.
            , UInt, 0)
        DllCall("CloseHandle", UInt, hVolume)
    }
return
}


Esc::
GuiClose:
ExitApp