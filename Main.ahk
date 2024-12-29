#Requires AutoHotkey v2.0

#Include "%A_ScriptDir%\Lib\FindText.ahk"
#Include "%A_ScriptDir%\Lib\Helpers.ahk"
#Include "%A_ScriptDir%\Lib\FindText_Pic.ahk"

SendMode "Event"
CoordMode("Mouse", "Window")
Roblox := "ahk_exe RobloxPlayerBeta.exe"

global WinX := 0
global WinY := 0
global WinWidthX := 0
global WinWidthY := 0

^Esc:: ExitApp

F1:: Start_Macro()

Start_Macro()
{
    ;Lobby Walk
    Roblox_Screen()

    Click(405, 40)

    global WinX, WinY, WinWidthX, WinWidthY

    WinGetPos(&WinX, &WinY, &WinWidthX, &WinWidthY, Roblox)
    ; CameraAngleDown()

    ; CaptchaBeat()
    Lobby_Check()
}

Lobby_Check()
{
    sleep 1000
    if (ok := FindText(&X, &Y, (WinX + 68), WinY + 302, WinX + 120, WinY + 350, 10, 10, PlayButton))
    {
        Lobby_Walk(X - WinX, Y - WinY)
    }
}

Lobby_Walk(X, Y)
{
    ; Click Play button
    sleep 500
    Click(X, Y)
    sleep 50
    Click(405, 40)
    Sleep 1000
    SendInput("{a down}")
    sleep 5000
    SendInput("{a up}")
    sleep 50
    KeyWait "a"

    if (ok := FindText(&X, &Y, (WinX + 315), (WinY + 245), (WinX + 560), (WinY + 290), 10, 10, MatchMaking))
    {
        sleep 500
        Click(470, 350)
        CaptchaBeat()
        Load_Stage()
    }
    else
    {
        Lobby_Check()
    }
}

CaptchaBeat()
{
    sleep 500
    if (ok := FindText(&X, &Y, (WinX + 340), (WinY + 225), (WinX + 473), (WinY + 254), 0, 0, Captcha))
    {
        Run("SnippingTool.exe")
        WinWait("ahk_exe SnippingTool.exe")
        Sleep 2000

        CoordMode("Mouse", "Screen")
        Sleep 500
        WinMove(985, 165, 516, 239, "ahk_exe SnippingTool.exe")
        sleep 100
        Click(1036, 220)
        sleep 500
        MouseClickDrag("L", 410, 410, 762, 465, 15)
        Sleep 2000
        WinMove(985, 165, 516, 239, "ahk_exe SnippingTool.exe")
        sleep 500
        Click(1310, 460)
        sleep 3000
        Click(1150, 275)
        sleep 2000
        Click(560, 175)
        sleep 50
        CoordMode("Mouse", "Window")
        sleep 50
        Click(406, 370)
        sleep 50
        Click(406, 370)
        sleep 500
        A_Clipboard := StrReplace(A_Clipboard, " ", "") ; Chatgpt Goes BRRRR
        sleep 100
        SendInput("{Ctrl down}v{Ctrl up}")
        WinClose("ahk_exe SnippingTool.exe")
        sleep 1000
        Click(310, 415)
    }

    sleep 100
    if (ok := FindText(&X, &Y, (WinX + 170), (WinY + 460), (WinX + 300), (WinY + 505), 0, 0, IncorrectCaptcha)) {
        MsgBox("detected")
        Sleep 40000
        Lobby_Check()
    }
}

Load_Stage()
{
    loop
    {

        if (ok := FindText(&X, &Y, (WinX + 315), (WinY + 245), (WinX + 560), (WinY + 290), 10, 10, VoteStart))
        {
            Click(360, 135)
            break
        }
        else
        {
            sleep 500
        }
    }
    Set_Up()
}

Set_Up()
{
    LastPressed := A_TickCount
    loop
    {
        if (A_TickCount - LastPressed >= 300000)
        {
            Send("{Space}")

            LastPressed := A_TickCount
        }

        if (ok := FindText(&X, &Y, (WinX + 270), (WinY + 405), (WinX + 385), (WinY + 445), 0, 0, Next))
        {
            Click(360, 135)
            sleep 1000
            Click(295, 145)
            break
        }

        Lobby_Check()
        sleep 100
    }
}