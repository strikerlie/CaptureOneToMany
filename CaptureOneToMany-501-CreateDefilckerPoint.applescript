use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

tell application "Capture One 23"
	set theVariant to variant [1]
	tell theVariant
		make new readout with properties {horizontal position:50, vertical position:50}
		make new readout with properties {horizontal position:50, vertical position:40}
		make new readout with properties {horizontal position:50, vertical position:60}
		
		make new readout with properties {horizontal position:40, vertical position:65}
		make new readout with properties {horizontal position:40, vertical position:55}
		make new readout with properties {horizontal position:40, vertical position:45}
		make new readout with properties {horizontal position:40, vertical position:35}
		
		make new readout with properties {horizontal position:60, vertical position:65}
		make new readout with properties {horizontal position:60, vertical position:55}
		make new readout with properties {horizontal position:60, vertical position:45}
		make new readout with properties {horizontal position:60, vertical position:35}
		
		
		make new readout with properties {horizontal position:25, vertical position:25}
		make new readout with properties {horizontal position:25, vertical position:75}
		make new readout with properties {horizontal position:75, vertical position:75}
		make new readout with properties {horizontal position:75, vertical position:25}
		
		make new readout with properties {horizontal position:50, vertical position:10}
		make new readout with properties {horizontal position:50, vertical position:90}
		make new readout with properties {horizontal position:10, vertical position:50}
		make new readout with properties {horizontal position:90, vertical position:50}
		
	end tell
end tell