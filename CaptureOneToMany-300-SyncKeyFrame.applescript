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
		
		
		--copy (get blue curve of adjustments of source) to blue curve of adjustments of target
		--copy 1 to clarity amount of adjustments of target
		
		--	set (black and white of adjustments of targetLayers) to get black and white of adjustments of sourceLayers
		--	set (black and white blue sensitivity of adjustments of targetLayers) to get black and white blue sensitivity of adjustments of sourceLayers
		--	set (black and white cyan sensitivity of adjustments of targetLayers) to get black and white cyan sensitivity of adjustments of sourceLayers
		--	set (black and white green sensitivity of adjustments of targetLayers) to get black and white green sensitivity of adjustments of sourceLayers
		--	set (black and white magenta sensitivity of adjustments of targetLayers) to get black and white magenta sensitivity of adjustments of sourceLayers
		--	set (black and white red sensitivity of adjustments of targetLayers) to get black and white red sensitivity of adjustments of sourceLayers
		--	set (black and white split highlight hue of adjustments of targetLayers) to get black and white split highlight hue of adjustments of sourceLayers
		--	set (black and white split highlight saturation of adjustments of targetLayers) to get black and white split highlight saturation of adjustments of sourceLayers
		--	set (black and white split shadow hue of adjustments of targetLayers) to get black and white split shadow hue of adjustments of sourceLayers
		--	set (black and white split shadow saturation of adjustments of targetLayers) to get black and white split shadow saturation of adjustments of sourceLayers
		--	set (black and white yellow sensitivity of adjustments of targetLayers) to get black and white yellow sensitivity of adjustments of sourceLayers
		try
			set (black recovery of adjustments of targetLayers) to get black recovery of adjustments of sourceLayers
		end try
		try
			set (blue curve of adjustments of targetLayers) to get blue curve of adjustments of sourceLayers
		end try
		try
			set (brightness of adjustments of targetLayers) to get brightness of adjustments of sourceLayers
		end try
		try
			--set (clarity amount of adjustments of targetLayers) to get clarity amount of adjustments of sourceLayers
			set (clarity method of adjustments of targetLayers) to get clarity method of adjustments of sourceLayers
		end try
		try
			--set (clarity structure of adjustments of targetLayers) to get clarity structure of adjustments of sourceLayers
			set (color balance highlight hue of adjustments of targetLayers) to get color balance highlight hue of adjustments of sourceLayers
		end try
		try
			set (color balance highlight lightness of adjustments of targetLayers) to get color balance highlight lightness of adjustments of sourceLayers
		end try
		try
			set (color balance highlight saturation of adjustments of targetLayers) to get color balance highlight saturation of adjustments of sourceLayers
		end try
		try
			set (color balance master hue of adjustments of targetLayers) to get color balance master hue of adjustments of sourceLayers
		end try
		try
			set (color balance master saturation of adjustments of targetLayers) to get color balance master saturation of adjustments of sourceLayers
		end try
		try
			set (color balance midtone hue of adjustments of targetLayers) to get color balance midtone hue of adjustments of sourceLayers
		end try
		try
			set (color balance midtone lightness of adjustments of targetLayers) to get color balance midtone lightness of adjustments of sourceLayers
		end try
		try
			set (color balance midtone saturation of adjustments of targetLayers) to get color balance midtone saturation of adjustments of sourceLayers
		end try
		try
			set (color balance shadow hue of adjustments of targetLayers) to get color balance shadow hue of adjustments of sourceLayers
		end try
		try
			set (color balance shadow lightness of adjustments of targetLayers) to get color balance shadow lightness of adjustments of sourceLayers
		end try
		try
			set (color balance shadow saturation of adjustments of targetLayers) to get color balance shadow saturation of adjustments of sourceLayers
		end try
		try
			set (color editor settings of adjustments of targetLayers) to get color editor settings of adjustments of sourceLayers
			--	set (color profile of adjustments of targetLayers) to get color profile of adjustments of sourceLayers
		end try
		try
			set (contrast of adjustments of targetLayers) to get contrast of adjustments of sourceLayers
		end try
		try
			--set (dehaze amount of adjustments of targetLayers) to get dehaze amount of adjustments of sourceLayers
			set (dehaze color of adjustments of targetLayers) to get dehaze color of adjustments of sourceLayers
		end try
		try
			set (exposure of adjustments of targetLayers) to get exposure of adjustments of sourceLayers
		end try
		try
			--set (film curve of adjustments of targetLayers) to get film curve of adjustments of sourceLayers
			--set (film grain granularity of adjustments of targetLayers) to get film grain granularity of adjustments of sourceLayers
			--set (film grain impact of adjustments of targetLayers) to get film grain impact of adjustments of sourceLayers
			--set (film grain type of adjustments of targetLayers) to get film grain type of adjustments of sourceLayers
			--set (flip of adjustments of targetLayers) to get flip of adjustments of sourceLayers
		end try
		try
			set (green curve of adjustments of targetLayers) to get green curve of adjustments of sourceLayers
		end try
		try
			set (highlight adjustment of adjustments of targetLayers) to get highlight adjustment of adjustments of sourceLayers
		end try
		try
			set (level highlight blue of adjustments of targetLayers) to get level highlight blue of adjustments of sourceLayers
		end try
		try
			set (level highlight green of adjustments of targetLayers) to get level highlight green of adjustments of sourceLayers
		end try
		try
			set (level highlight red of adjustments of targetLayers) to get level highlight red of adjustments of sourceLayers
		end try
		try
			set (level highlight rgb of adjustments of targetLayers) to get level highlight rgb of adjustments of sourceLayers
		end try
		try
			set (level midtone blue of adjustments of targetLayers) to get level midtone blue of adjustments of sourceLayers
		end try
		try
			set (level midtone green of adjustments of targetLayers) to get level midtone green of adjustments of sourceLayers
		end try
		try
			set (level midtone red of adjustments of targetLayers) to get level midtone red of adjustments of sourceLayers
		end try
		try
			set (level midtone rgb of adjustments of targetLayers) to get level midtone rgb of adjustments of sourceLayers
		end try
		try
			set (level shadow blue of adjustments of targetLayers) to get level shadow blue of adjustments of sourceLayers
		end try
		try
			set (level shadow green of adjustments of targetLayers) to get level shadow green of adjustments of sourceLayers
		end try
		try
			set (level shadow red of adjustments of targetLayers) to get level shadow red of adjustments of sourceLayers
		end try
		try
			set (level shadow rgb of adjustments of targetLayers) to get level shadow rgb of adjustments of sourceLayers
		end try
		try
			set (level target highlight blue of adjustments of targetLayers) to get level target highlight blue of adjustments of sourceLayers
		end try
		try
			set (level target highlight green of adjustments of targetLayers) to get level target highlight green of adjustments of sourceLayers
		end try
		try
			set (level target highlight red of adjustments of targetLayers) to get level target highlight red of adjustments of sourceLayers
		end try
		try
			set (level target shadow blue of adjustments of targetLayers) to get level target shadow blue of adjustments of sourceLayers
		end try
		try
			set (level target shadow green of adjustments of targetLayers) to get level target shadow green of adjustments of sourceLayers
		end try
		try
			set (level target shadow red of adjustments of targetLayers) to get level target shadow red of adjustments of sourceLayers
		end try
		try
			set (level target shadow rgb of adjustments of targetLayers) to get level target shadow rgb of adjustments of sourceLayers
		end try
		try
			set (luma curve of adjustments of targetLayers) to get luma curve of adjustments of sourceLayers
			--set (moire amount of adjustments of targetLayers) to get moire amount of adjustments of sourceLayers
			--set (moire pattern of adjustments of targetLayers) to get moire pattern of adjustments of sourceLayers
			--set (noise reduction color of adjustments of targetLayers) to get noise reduction color of adjustments of sourceLayers
			--set (noise reduction details of adjustments of targetLayers) to get noise reduction details of adjustments of sourceLayers
			--set (noise reduction luminance of adjustments of targetLayers) to get noise reduction luminance of adjustments of sourceLayers
			--set (noise reduction single pixel of adjustments of targetLayers) to get noise reduction single pixel of adjustments of sourceLayers
			--set (orientation of adjustments of targetLayers) to get orientation of adjustments of sourceLayers
		end try
		try
			set (red curve of adjustments of targetLayers) to get red curve of adjustments of sourceLayers
		end try
		try
			set (rgb curve of adjustments of targetLayers) to get rgb curve of adjustments of sourceLayers
			--set (rotation of adjustments of targetLayers) to get rotation of adjustments of sourceLayers
		end try
		try
			set (saturation of adjustments of targetLayers) to get saturation of adjustments of sourceLayers
		end try
		try
			set (shadow recovery of adjustments of targetLayers) to get shadow recovery of adjustments of sourceLayers
			--set (sharpening amount of adjustments of targetLayers) to get sharpening amount of adjustments of sourceLayers
		end try
		try
			set (sharpening halo suppression of adjustments of targetLayers) to get sharpening halo suppression of adjustments of sourceLayers
		end try
		try
			set (sharpening radius of adjustments of targetLayers) to get sharpening radius of adjustments of sourceLayers
		end try
		try
			set (sharpening threshold of adjustments of targetLayers) to get sharpening threshold of adjustments of sourceLayers
		end try
		try
			set (temperature of adjustments of targetLayers) to get temperature of adjustments of sourceLayers
		end try
		try
			set (tint of adjustments of targetLayers) to get tint of adjustments of sourceLayers
			--set (vignetting amount of adjustments of targetLayers) to get vignetting amount of adjustments of sourceLayers
			--set (vignetting method of adjustments of targetLayers) to get vignetting method of adjustments of sourceLayers
			--set (white balance preset of adjustments of targetLayers) to get white balance preset of adjustments of sourceLayers
		end try
		try
			set (white recovery of adjustments of targetLayers) to get white recovery of adjustments of sourceLayers
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
