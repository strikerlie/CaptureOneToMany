use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

on SetKeyFrame(selectedVariants)
	tell application "Capture One 23"
		repeat with currentVariant in selectedVariants
			tell currentVariant
				set color tag to 4
				set rating to 4
			end tell
		end repeat
	end tell
end SetKeyFrame

tell application "Capture One 23"
	set selectedVariants to selected variants
	my SetKeyFrame(selectedVariants)
end tell
