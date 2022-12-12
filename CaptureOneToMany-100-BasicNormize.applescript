use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions
on InitProgressBar(total)
	tell application "Capture One 23"
		set progress total units to total
		set progress completed units to 0
		set progress text to "Processing Normalize Images..."
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
		display notification "Normalize DONE!" with title "CaptureOne->Many" sound name "default"
		set progress total units to 0
		set progress completed units to 0
		set progress text to ""
		set progress additional text to ""
	end tell
end EndProgressBar

tell application "Capture One 23"
	tell current document
		
		my InitProgressBar(count of variants)
		-- loop all variants to match Exposure with CaptureOne Exposure Evalution
		set indexCount to 0
		repeat with theVariant in variants
			tell theVariant
				-- get the EV different by CaptureOne Exposure Evalution, this is not corrent, but for refernce
				set evDiff to exposure meter
				tell layers of theVariant
					set BasicNormalize to layer "BasicNormalize" of theVariant
					tell adjustments of BasicNormalize
						set exposure to -evDiff
					end tell
				end tell
				
			end tell
			my UpdateProgressBar(indexCount)
			set indexCount to (indexCount + 1)
		end repeat
		my EndProgressBar()
	end tell
end tell
