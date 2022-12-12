use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions
on InitProgressBar(total)
	tell application "Capture One 23"
		set progress total units to total
		set progress completed units to 0
		set progress text to "Processing Reset Images..."
		set progress additional text to "Progress: 0 of " & total & " processed"
	end tell
end InitProgressBar

on UpdateProgressBar(thisCounter)
	tell application "Capture One 23"
		set progress completed units to thisCounter
		set progress additional text to "Progress: " & thisCounter & " of " & (get progress total units) & " processed"
	end tell
end UpdateProgressBar

on EndProgressBar()
	tell application "Capture One 23"
		--https://developer.apple.com/library/archive/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/DisplayNotifications.html
		display notification "Full Reset DONE!" with title "CaptureOne->Many" sound name "default"
		set progress total units to 0
		set progress completed units to 0
		set progress text to ""
		set progress additional text to ""
	end tell
end EndProgressBar


tell application "Capture One 23"
	tell current document
		--https://developer.apple.com/library/archive/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/DisplayDialogsandAlerts.html
		set theDialogText to "Reset will clear ALL ADJUSTMENT, RATING, COLOR TAG of " & (count of variants) & " Photo in current collection(" & name of current collection & ")!"
		try
			display dialog theDialogText with icon caution buttons {"STOP!", "Reset"} default button "Reset" cancel button "STOP!"
		on error errText number errNum
			--https://stackoverflow.com/questions/15170180/how-can-i-handle-applescript-dialog-response
			if errNum is -128 then
				return
			end if
		end try
		
		my InitProgressBar(count of variants)
		-- loop all variants to reset setting and rating
		set indexCount to 0
		repeat with theVariant in (variants)
			reset adjustments theVariant
			set rating of theVariant to 0
			set color tag of theVariant to 0
			my UpdateProgressBar(indexCount)
			set indexCount to (indexCount + 1)
		end repeat
		my EndProgressBar()
	end tell
end tell
