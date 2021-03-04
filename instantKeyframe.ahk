;--------------------------------------------
; This script is meant to just create a new keyframe exactly where the current time scrub is at.
;--------------------------------------------

SetWorkingDir, C:\AHK\AutoAfterEffects\img
; Sets the reference directory for your image files.

#NoEnv
;Menu, Tray, Icon, shell32.dll, 283 ; this changes the tray icon to a little keyboard!
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input 
#SingleInstance force ;only one instance of this script may run at a time!
#MaxHotkeysPerInterval 2000
#WinActivateForce ;https://autohotkey.com/docs/commands/_WinActivateForce.htm

; The following line checks to make sure the active window is Adobe After Effects, this avoids causing key conflict
#IfWinActive ahk_exe AfterFX.exe
F4::nkf(1)

nkf(open := 1)
{

BlockInput, on
BlockInput, MouseMove

CoordMode Pixel, window 
CoordMode Mouse, window

MouseGetPos xPos, yPos
rightedge = 200 ;250 for 150% UI
expanseUp = 13  ;32 for 150% UI
expanseDown = 13 ;10 for 150% UI

CoordMode Pixel, window 
CoordMode Mouse, window

If open = 1
	{
	ImageSearch, FoundX, FoundY, 0, yPos-expanseUp, rightedge, yPos+expanseDown, %A_WorkingDir%\iv_nkframe1.png

	if ErrorLevel = 1 ;if that was unable to find it, try again with another image
		ImageSearch, FoundX, FoundY, 0, yPos-expanseUp, rightedge, yPos+expanseDown, *2 %A_WorkingDir%\iv_nkframe2.png
	if ErrorLevel = 1 ;if that was unable to find it, try again with another image
		ImageSearch, FoundX, FoundY, 0, yPos-expanseUp, rightedge, yPos+expanseDown, *2 %A_WorkingDir%\iv_nkframe3.png

	if ErrorLevel = 0
		{
		;tooltip, The icon was found at %FoundX%x%FoundY%.
		;msgbox, The icon was found at %FoundX%x%FoundY%.
		MouseMove, FoundX+16, FoundY+8, 0
		sleep 5
		click left
		sleep 5
		goto resetloop
		}
	}
tooltip, FAIL`, ErrorLevel is %ErrorLevel%
;msgbox, , , num enter, 0.5;msgbox, , , num enter, 0.5
resetloop:
;;MouseMove, xPos-8, yPos-8, 0
MouseMove, xPos+0, yPos+0, 0 
blockinput, off
blockinput, MouseMoveOff
sleep 20
tooltip,
}