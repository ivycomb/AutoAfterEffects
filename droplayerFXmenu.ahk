;--------------------------------------------
; This script was originally made by @TaranVH and I updated documentation for it.
; This script is called by F1 and F2, which open and close variable rows in compositions (by default)
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
F1::twirlAE(0)
F2::twirlAE(1)

twirlAE(open := 1)
{
;Each track is 26 pixels high on my screen. I think.

BlockInput, on
BlockInput, MouseMove

CoordMode Pixel, window 
CoordMode Mouse, window
; https://www.autohotkey.com/docs/commands/CoordMode.htm

MouseGetPos xPos, yPos
;I currently work on a 4k, 100% UI scaled screen. You might have to change these  values to fit your own screen, if you use a different UI.
rightedge = 200 ;250 for 150% UI
expanseUp = 13  ;32 for 150% UI
expanseDown = 13 ;10 for 150% UI

CoordMode Pixel, window 
CoordMode Mouse, window

;you might need to take your own screenshot (look at mine to see what is needed) and save as .png.

If open = 1
	{
	ImageSearch, FoundX, FoundY, 0, yPos-expanseUp, rightedge, yPos+expanseDown, %A_WorkingDir%\AE_down.png

	if ErrorLevel = 1 ;if that was unable to find it, try again with another image
		ImageSearch, FoundX, FoundY, 0, yPos-expanseUp, rightedge, yPos+expanseDown, *2 %A_WorkingDir%\AE_down2.png
	if ErrorLevel = 1 ;if that was unable to find it, try again with another image
		ImageSearch, FoundX, FoundY, 0, yPos-expanseUp, rightedge, yPos+expanseDown, *5 %A_WorkingDir%\AE_down3.png

	if ErrorLevel = 0
		{
		;tooltip, The icon was found at %FoundX%x%FoundY%.
		;msgbox, The icon was found at %FoundX%x%FoundY%.
		MouseMove, FoundX+8, FoundY+8, 0
		sleep 5
		click left
		sleep 5
		goto resettwirl
		}
	}
else if open = 0
	{

	ImageSearch, FoundX, FoundY, 0, yPos-expanseUp, rightedge, yPos+expanseDown, %A_WorkingDir%\AE_right.png

	if ErrorLevel = 1 ;if that was unable to find it, try again with another image
		ImageSearch, FoundX, FoundY, 0, yPos-expanseUp, rightedge, yPos+expanseDown, *2 %A_WorkingDir%\AE_right2.png
	if ErrorLevel = 1 ;if that was unable to find it, try again with another image
		ImageSearch, FoundX, FoundY, 0, yPos-expanseUp, rightedge, yPos+expanseDown, *5 %A_WorkingDir%\AE_right3.png
		
	if ErrorLevel = 0
		{
		;msgbox, The icon was found at %FoundX%x%FoundY%.
		MouseMove, FoundX+8, FoundY+8, 0
		sleep 5
		click left
		sleep 5
		goto resettwirl
		}
	}
tooltip, FAIL`, ErrorLevel is %ErrorLevel%
;msgbox, , , num enter, 0.5;msgbox, , , num enter, 0.5
resettwirl:
;;MouseMove, xPos-8, yPos-8, 0 ;IDK why, but if I don't subtract a few pixels, the cursor ends up in a slightly wrong spot...
MouseMove, xPos+0, yPos+0, 0 ;oh, it's what happens if after effects isn't full screen. hmm.
blockinput, off
blockinput, MouseMoveOff
sleep 20
tooltip,
}