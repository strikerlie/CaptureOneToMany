use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions
on InitProgressBar(total)
	tell application "Capture One 23"
		set progress total units to total
		set progress completed units to 0
		set progress text to "Processing Sync KeyFrame Adjustment Images..."
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
		display notification "Sync KeyFrame DONE!" with title "CaptureOne->Many" sound name "default"
		set progress total units to 0
		set progress completed units to 0
		set progress text to ""
		set progress additional text to ""
	end tell
end EndProgressBar


on CopyLayerAdjustment(source, target)
	tell application "Capture One 23"
		try
			set sourceLayers to layer "KeyFrameAdjustment" of source
		on error
			display alert "Looks missing KeyFrameAdjustment layer on " & name of source & "! Better to check before Continue" as critical buttons {"Stop", "Continue"} default button "Stop" cancel button "Stop"
		end try
		try
			set targetLayers to layer "KeyFrameAdjustment" of target
		on error
			display alert "Looks missing KeyFrameAdjustment layer on " & name of target & "! Better to check before Continue" as critical buttons {"Stop", "Continue"} default button "Stop" cancel button "Stop"
		end try
		
		set srcLayerAdj to adjustments of sourceLayers
		set targetLayersAdj to adjustments of targetLayers
		
		--copy (get blue curve of adjustments of source) to blue curve of adjustments of target
		--copy 1 to clarity amount of adjustments of target
		
		--	set (black and white of targetLayersAdj) to get black and white of srcLayerAdj
		--	set (black and white blue sensitivity of targetLayersAdj) to get black and white blue sensitivity of srcLayerAdj
		--	set (black and white cyan sensitivity of targetLayersAdj) to get black and white cyan sensitivity of srcLayerAdj
		--	set (black and white green sensitivity of targetLayersAdj) to get black and white green sensitivity of srcLayerAdj
		--	set (black and white magenta sensitivity of targetLayersAdj) to get black and white magenta sensitivity of srcLayerAdj
		--	set (black and white red sensitivity of targetLayersAdj) to get black and white red sensitivity of srcLayerAdj
		--	set (black and white split highlight hue of targetLayersAdj) to get black and white split highlight hue of srcLayerAdj
		--	set (black and white split highlight saturation of targetLayersAdj) to get black and white split highlight saturation of srcLayerAdj
		--	set (black and white split shadow hue of targetLayersAdj) to get black and white split shadow hue of srcLayerAdj
		--	set (black and white split shadow saturation of targetLayersAdj) to get black and white split shadow saturation of srcLayerAdj
		--	set (black and white yellow sensitivity of targetLayersAdj) to get black and white yellow sensitivity of srcLayerAdj
		try
			set (black recovery of targetLayersAdj) to get black recovery of srcLayerAdj
		end try
		try
			set (blue curve of targetLayersAdj) to get blue curve of srcLayerAdj
		end try
		try
			set (brightness of targetLayersAdj) to get brightness of srcLayerAdj
		end try
		try
			set (clarity amount of targetLayersAdj) to get clarity amount of srcLayerAdj
		end try
		try
			set (clarity method of targetLayersAdj) to get clarity method of srcLayerAdj
		end try
		try
			set (clarity structure of targetLayersAdj) to get clarity structure of srcLayerAdj
		end try
		try
			set (color balance highlight hue of targetLayersAdj) to get color balance highlight hue of srcLayerAdj
		end try
		try
			set (color balance highlight lightness of targetLayersAdj) to get color balance highlight lightness of srcLayerAdj
		end try
		try
			set (color balance highlight saturation of targetLayersAdj) to get color balance highlight saturation of srcLayerAdj
		end try
		try
			set (color balance master hue of targetLayersAdj) to get color balance master hue of srcLayerAdj
		end try
		try
			set (color balance master saturation of targetLayersAdj) to get color balance master saturation of srcLayerAdj
		end try
		try
			set (color balance midtone hue of targetLayersAdj) to get color balance midtone hue of srcLayerAdj
		end try
		try
			set (color balance midtone lightness of targetLayersAdj) to get color balance midtone lightness of srcLayerAdj
		end try
		try
			set (color balance midtone saturation of targetLayersAdj) to get color balance midtone saturation of srcLayerAdj
		end try
		try
			set (color balance shadow hue of targetLayersAdj) to get color balance shadow hue of srcLayerAdj
		end try
		try
			set (color balance shadow lightness of targetLayersAdj) to get color balance shadow lightness of srcLayerAdj
		end try
		try
			set (color balance shadow saturation of targetLayersAdj) to get color balance shadow saturation of srcLayerAdj
		end try
		try
			set (color editor settings of targetLayersAdj) to get color editor settings of srcLayerAdj
		end try
		--	set (color profile of targetLayersAdj) to get color profile of srcLayerAdj
		try
			set (contrast of targetLayersAdj) to get contrast of srcLayerAdj
		end try
		try
			set (dehaze amount of targetLayersAdj) to get dehaze amount of srcLayerAdj
		end try
		try
			set (dehaze color of targetLayersAdj) to get dehaze color of srcLayerAdj
		end try
		try
			set (exposure of targetLayersAdj) to get exposure of srcLayerAdj
		end try
		try
			--set (film curve of targetLayersAdj) to get film curve of srcLayerAdj
			--set (film grain granularity of targetLayersAdj) to get film grain granularity of srcLayerAdj
			--set (film grain impact of targetLayersAdj) to get film grain impact of srcLayerAdj
			--set (film grain type of targetLayersAdj) to get film grain type of srcLayerAdj
			--set (flip of targetLayersAdj) to get flip of srcLayerAdj
		end try
		try
			set (green curve of targetLayersAdj) to get green curve of srcLayerAdj
		end try
		try
			set (highlight adjustment of targetLayersAdj) to get highlight adjustment of srcLayerAdj
		end try
		try
			set (level highlight blue of targetLayersAdj) to get level highlight blue of srcLayerAdj
		end try
		try
			set (level highlight green of targetLayersAdj) to get level highlight green of srcLayerAdj
		end try
		try
			set (level highlight red of targetLayersAdj) to get level highlight red of srcLayerAdj
		end try
		try
			set (level highlight rgb of targetLayersAdj) to get level highlight rgb of srcLayerAdj
		end try
		try
			set (level midtone blue of targetLayersAdj) to get level midtone blue of srcLayerAdj
		end try
		try
			set (level midtone green of targetLayersAdj) to get level midtone green of srcLayerAdj
		end try
		try
			set (level midtone red of targetLayersAdj) to get level midtone red of srcLayerAdj
		end try
		try
			set (level midtone rgb of targetLayersAdj) to get level midtone rgb of srcLayerAdj
		end try
		try
			set (level shadow blue of targetLayersAdj) to get level shadow blue of srcLayerAdj
		end try
		try
			set (level shadow green of targetLayersAdj) to get level shadow green of srcLayerAdj
		end try
		try
			set (level shadow red of targetLayersAdj) to get level shadow red of srcLayerAdj
		end try
		try
			set (level shadow rgb of targetLayersAdj) to get level shadow rgb of srcLayerAdj
		end try
		try
			set (level target highlight blue of targetLayersAdj) to get level target highlight blue of srcLayerAdj
		end try
		try
			set (level target highlight green of targetLayersAdj) to get level target highlight green of srcLayerAdj
		end try
		try
			set (level target highlight red of targetLayersAdj) to get level target highlight red of srcLayerAdj
		end try
		try
			set (level target shadow blue of targetLayersAdj) to get level target shadow blue of srcLayerAdj
		end try
		try
			set (level target shadow green of targetLayersAdj) to get level target shadow green of srcLayerAdj
		end try
		try
			set (level target shadow red of targetLayersAdj) to get level target shadow red of srcLayerAdj
		end try
		try
			set (level target shadow rgb of targetLayersAdj) to get level target shadow rgb of srcLayerAdj
		end try
		try
			set (moire amount of targetLayersAdj) to get moire amount of srcLayerAdj
		end try
		try
			set (moire pattern of targetLayersAdj) to get moire pattern of srcLayerAdj
		end try
		--set (noise reduction color of targetLayersAdj) to get noise reduction color of srcLayerAdj
		try
			set (noise reduction details of targetLayersAdj) to get noise reduction details of srcLayerAdj
		end try
		try
			set (noise reduction luminance of targetLayersAdj) to get noise reduction luminance of srcLayerAdj
		end try
		--set (noise reduction single pixel of targetLayersAdj) to get noise reduction single pixel of srcLayerAdj
		
		try
			set (luma curve of targetLayersAdj) to get luma curve of srcLayerAdj
			--set (orientation of targetLayersAdj) to get orientation of srcLayerAdj
		end try
		try
			set (red curve of targetLayersAdj) to get red curve of srcLayerAdj
		end try
		try
			set (rgb curve of targetLayersAdj) to get rgb curve of srcLayerAdj
			--set (rotation of targetLayersAdj) to get rotation of srcLayerAdj
		end try
		try
			set (saturation of targetLayersAdj) to get saturation of srcLayerAdj
		end try
		try
			set (shadow recovery of targetLayersAdj) to get shadow recovery of srcLayerAdj
		end try
		try
			set (sharpening amount of targetLayersAdj) to get sharpening amount of srcLayerAdj
		end try
		try
			set (sharpening halo suppression of targetLayersAdj) to get sharpening halo suppression of srcLayerAdj
		end try
		try
			set (sharpening radius of targetLayersAdj) to get sharpening radius of srcLayerAdj
		end try
		try
			set (sharpening threshold of targetLayersAdj) to get sharpening threshold of srcLayerAdj
		end try
		try
			set (temperature of targetLayersAdj) to get temperature of srcLayerAdj
		end try
		try
			set (tint of targetLayersAdj) to get tint of srcLayerAdj
			--set (vignetting amount of targetLayersAdj) to get vignetting amount of srcLayerAdj
			--set (vignetting method of targetLayersAdj) to get vignetting method of srcLayerAdj
			--set (white balance preset of targetLayersAdj) to get white balance preset of srcLayerAdj
		end try
		try
			set (white recovery of targetLayersAdj) to get white recovery of srcLayerAdj
		end try
	end tell
end CopyLayerAdjustment

tell application "Capture One 23"
	set cloneSource to primary variant
	set selectedVariants to selected variants
	tell current document
		
		my InitProgressBar(count of selectedVariants)
		-- loop all variants to match Exposure with CaptureOne Exposure Evalution
		set indexCount to 0
		
		repeat with theVariant in selectedVariants
			--not clone myself
			if id of theVariant is not id of cloneSource then
				--check keyframe
				if rating of theVariant = 4 and color tag of theVariant = 4 then
					my CopyLayerAdjustment(cloneSource, theVariant)
				end if
			end if
			my UpdateProgressBar(indexCount)
			set indexCount to (indexCount + 1)
		end repeat
		my EndProgressBar()
	end tell
	
end tell
