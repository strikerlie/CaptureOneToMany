use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

tell application "Capture One 23"
	set indexCount to 1
	set readoutCount to count of readout of variant [1]
	repeat readoutCount times
		delete readout 1 of variant [1]
	end repeat
end tell