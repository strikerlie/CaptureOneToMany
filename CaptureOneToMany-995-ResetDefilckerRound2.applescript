use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions
on InitProgressBar(total)
	tell application "Capture One 23"
		set progress total units to total
		set progress completed units to 0
		set progress text to "Resetting Deflicker Adjustment..."
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
		display notification "Reset Deflicker DONE!" with title "CaptureOne->Many" sound name "default"
		set progress total units to 0
		set progress completed units to 0
		set progress text to ""
		set progress additional text to ""
	end tell
end EndProgressBar


tell application "Capture One 23"
	--set duck to current document
	--readout 1 of variant "_DSC7019" of duck
	
	tell current document
		set indexCount to 1
		
		set variantCount to count of variants
		
		my InitProgressBar(variantCount, "Processing Deflicker Layer2 Adjustment...")
		
		repeat variantCount times
			my UpdateProgressBar(indexCount)
			set targetLayers to layer "DeflickerAdjustment2" of variant [indexCount]
			set (exposure of adjustments of targetLayers) to 0
			set indexCount to indexCount + 1
		end repeat
		my EndProgressBar()
		
	end tell
	
end tell
