use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions
on InitProgressBar(total)
	tell application "Capture One 23"
		set progress total units to total
		set progress completed units to 0
		set progress text to "Processing Ramping KeyFrame Adjustment..."
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
		display notification "Ramping KeyFrame DONE!" with title "CaptureOne->Many" sound name "default"
		set progress total units to 0
		set progress completed units to 0
		set progress text to ""
		set progress additional text to ""
	end tell
end EndProgressBar

on RampingFunction(startIndex, endIndex, currentIndex, startValue, endValue)
	--log "startValue: " & startValue & " is missing?" & (startValue is missing value)
	--log "endValue: " & endValue & " is missing?" & (endValue is missing value)
	if startValue is missing value then
		set startValue to 0.0
	end if
	
	if endValue is missing value then
		set endValue to 0.0
	end if
	--log "startValue: " & startValue & " is missing?" & (startValue is missing value)
	--log "endValue: " & endValue & " is missing?" & (endValue is missing value)
	
	set diff to (endValue - startValue) * ((currentIndex - startIndex) / (endIndex - startIndex))
	return diff + startValue
end RampingFunction

on RampingLayerAdjustment(startIndex, endIndex)
	tell application "Capture One 23"
		try
			set startLayer to layer "KeyFrameAdjustment" of variant [startIndex]
		on error
			display alert "Looks missing KeyFrameAdjustment layer on " & name of variant [startIndex] & "! Better to check before Continue" as critical buttons {"Stop", "Continue"} default button "Stop" cancel button "Stop"
		end try
		try
			set endLayer to layer "KeyFrameAdjustment" of variant [endIndex]
		on error
			display alert "Looks missing KeyFrameAdjustment layer on " & name of variant [endIndex] & "! Better to check before Continue" as critical buttons {"Stop", "Continue"} default button "Stop" cancel button "Stop"
		end try
		
		set i to startIndex + 1
		
		repeat while i < endIndex
			
			my UpdateProgressBar(i)
			try
				set targetLayers to layer "KeyFrameAdjustment" of variant [i]
			on error
				display alert "Looks missing KeyFrameAdjustment layer on " & name of variant [i] & "! Better to check before Continue" as critical buttons {"Stop", "Continue"} default button "Stop" cancel button "Stop"
			end try
			--log "RampingLayerAdjustment start: " & startIndex & " end: " & endIndex & " i:" & i
			--log (get black recovery of adjustments of startLayer)
			--log (get black recovery of adjustments of endLayer)
			--log my RampingFunction(startIndex, endIndex, i, get black recovery of adjustments of startLayer, get black recovery of adjustments of endLayer)
			
			--	set (black and white of adjustments of targetLayers) to get black and white of adjustments of sourceLayers
			--	set (black and white blue sensitivity of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i,get black and white blue sensitivity of adjustments of sourceLayers
			--	set (black and white cyan sensitivity of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get black and white cyan sensitivity of adjustments of sourceLayers
			--	set (black and white green sensitivity of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i,get black and white green sensitivity of adjustments of sourceLayers
			--	set (black and white magenta sensitivity of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i,get black and white magenta sensitivity of adjustments of sourceLayers
			--	set (black and white red sensitivity of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i,get black and white red sensitivity of adjustments of sourceLayers
			--	set (black and white split highlight hue of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i,get black and white split highlight hue of adjustments of sourceLayers
			--	set (black and white split highlight saturation of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i,get black and white split highlight saturation of adjustments of sourceLayers
			--	set (black and white split shadow hue of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i,get black and white split shadow hue of adjustments of sourceLayers
			--	set (black and white split shadow saturation of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i,get black and white split shadow saturation of adjustments of sourceLayers
			--	set (black and white yellow sensitivity of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i,get black and white yellow sensitivity of adjustments of sourceLayers
			set (black recovery of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get black recovery of adjustments of startLayer, get black recovery of adjustments of endLayer)
			set (blue curve of adjustments of targetLayers) to get blue curve of adjustments of startLayer
			set (brightness of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get brightness of adjustments of startLayer, get brightness of adjustments of endLayer)
			set (clarity amount of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get clarity amount of adjustments of startLayer, get clarity amount of adjustments of endLayer)
			set (clarity method of adjustments of targetLayers) to get clarity method of adjustments of startLayer
			set (clarity structure of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get clarity structure of adjustments of startLayer, get clarity structure of adjustments of endLayer)
			set (color balance highlight hue of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get color balance highlight hue of adjustments of startLayer, get color balance highlight hue of adjustments of endLayer)
			set (color balance highlight lightness of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get color balance highlight lightness of adjustments of startLayer, get color balance highlight lightness of adjustments of endLayer)
			set (color balance highlight saturation of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get color balance highlight saturation of adjustments of startLayer, get color balance highlight saturation of adjustments of endLayer)
			set (color balance master hue of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get color balance master hue of adjustments of startLayer, get color balance master hue of adjustments of endLayer)
			set (color balance master saturation of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get color balance master saturation of adjustments of startLayer, get color balance master saturation of adjustments of endLayer)
			set (color balance midtone hue of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get color balance midtone hue of adjustments of startLayer, get color balance midtone hue of adjustments of endLayer)
			set (color balance midtone lightness of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get color balance midtone lightness of adjustments of startLayer, get color balance midtone lightness of adjustments of endLayer)
			set (color balance midtone saturation of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get color balance midtone saturation of adjustments of startLayer, get color balance midtone saturation of adjustments of endLayer)
			set (color balance shadow hue of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get color balance shadow hue of adjustments of startLayer, get color balance shadow hue of adjustments of endLayer)
			set (color balance shadow lightness of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get color balance shadow lightness of adjustments of startLayer, get color balance shadow lightness of adjustments of endLayer)
			set (color balance shadow saturation of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get color balance shadow saturation of adjustments of startLayer, get color balance shadow saturation of adjustments of endLayer)
			set (color editor settings of adjustments of targetLayers) to get color editor settings of adjustments of startLayer
			--	set (color profile of adjustments of targetLayers) to get color profile of adjustments of startLayer
			set (contrast of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get contrast of adjustments of startLayer, get contrast of adjustments of endLayer)
			set (dehaze amount of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get dehaze amount of adjustments of startLayer, get dehaze amount of adjustments of endLayer)
			set (dehaze color of adjustments of targetLayers) to get dehaze color of adjustments of startLayer
			set (exposure of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get exposure of adjustments of startLayer, get exposure of adjustments of endLayer)
			--set (film curve of adjustments of targetLayers) to get film curve of adjustments of sourceLayers
			--set (film grain granularity of adjustments of targetLayers) to get film grain granularity of adjustments of sourceLayers
			--set (film grain impact of adjustments of targetLayers) to get film grain impact of adjustments of sourceLayers
			--set (film grain type of adjustments of targetLayers) to get film grain type of adjustments of sourceLayers
			--set (flip of adjustments of targetLayers) to get flip of adjustments of sourceLayers
			set (green curve of adjustments of targetLayers) to get green curve of adjustments of startLayer
			set (highlight adjustment of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get highlight adjustment of adjustments of startLayer, get highlight adjustment of adjustments of endLayer)
			set (level highlight blue of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get level highlight blue of adjustments of startLayer, get level highlight blue of adjustments of endLayer)
			set (level highlight green of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get level highlight green of adjustments of startLayer, get level highlight green of adjustments of endLayer)
			set (level highlight red of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get level highlight red of adjustments of startLayer, get level highlight red of adjustments of endLayer)
			set (level highlight rgb of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get level highlight rgb of adjustments of startLayer, get level highlight rgb of adjustments of endLayer)
			set (level midtone blue of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get level midtone blue of adjustments of startLayer, get level midtone blue of adjustments of endLayer)
			set (level midtone green of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get level midtone green of adjustments of startLayer, get level midtone green of adjustments of endLayer)
			set (level midtone red of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get level midtone red of adjustments of startLayer, get level midtone red of adjustments of endLayer)
			set (level midtone rgb of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get level midtone rgb of adjustments of startLayer, get level midtone rgb of adjustments of endLayer)
			set (level shadow blue of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get level shadow blue of adjustments of startLayer, get level shadow blue of adjustments of endLayer)
			set (level shadow green of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get level shadow green of adjustments of startLayer, get level shadow green of adjustments of endLayer)
			set (level shadow red of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get level shadow red of adjustments of startLayer, get level shadow red of adjustments of endLayer)
			set (level shadow rgb of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get level shadow rgb of adjustments of startLayer, get level shadow rgb of adjustments of endLayer)
			set (level target highlight blue of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get level target highlight blue of adjustments of startLayer, get level target highlight blue of adjustments of endLayer)
			set (level target highlight green of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get level target highlight green of adjustments of startLayer, get level target highlight green of adjustments of endLayer)
			set (level target highlight red of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get level target highlight red of adjustments of startLayer, get level target highlight red of adjustments of endLayer)
			set (level target shadow blue of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get level target shadow blue of adjustments of startLayer, get level target shadow blue of adjustments of endLayer)
			set (level target shadow green of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get level target shadow green of adjustments of startLayer, get level target shadow green of adjustments of endLayer)
			set (level target shadow red of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get level target shadow red of adjustments of startLayer, get level target shadow red of adjustments of endLayer)
			set (level target shadow rgb of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get level target shadow rgb of adjustments of startLayer, get level target shadow rgb of adjustments of endLayer)
			set (luma curve of adjustments of targetLayers) to get luma curve of adjustments of startLayer
			set (moire amount of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get moire amount of adjustments of startLayer, get moire amount of adjustments of endLayer)
			try
				set (moire pattern of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get moire pattern of adjustments of startLayer, get moire pattern of adjustments of endLayer) --missing value is 4....				
			end try
			--set (noise reduction color of adjustments of targetLayers) to get noise reduction color of adjustments of sourceLayers
			set (noise reduction details of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get noise reduction details of adjustments of startLayer, get noise reduction details of adjustments of endLayer)
			set (noise reduction luminance of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get noise reduction luminance of adjustments of startLayer, get noise reduction luminance of adjustments of endLayer)
			--set (noise reduction single pixel of adjustments of targetLayers) to get noise reduction single pixel of adjustments of sourceLayers
			--set (orientation of adjustments of targetLayers) to get orientation of adjustments of sourceLayers
			set (red curve of adjustments of targetLayers) to get red curve of adjustments of startLayer
			set (rgb curve of adjustments of targetLayers) to get rgb curve of adjustments of startLayer
			--set (rotation of adjustments of targetLayers) to get rotation of adjustments of startLayer
			set (saturation of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get saturation of adjustments of startLayer, get saturation of adjustments of endLayer)
			set (shadow recovery of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get shadow recovery of adjustments of startLayer, get shadow recovery of adjustments of endLayer)
			set (sharpening amount of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get sharpening amount of adjustments of startLayer, get sharpening amount of adjustments of endLayer)
			set (sharpening halo suppression of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get sharpening halo suppression of adjustments of startLayer, get sharpening halo suppression of adjustments of endLayer)
			set (sharpening radius of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get sharpening radius of adjustments of startLayer, get sharpening radius of adjustments of endLayer)
			set (sharpening threshold of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get sharpening threshold of adjustments of startLayer, get sharpening threshold of adjustments of endLayer)
			set (temperature of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get temperature of adjustments of startLayer, get temperature of adjustments of endLayer)
			set (tint of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get tint of adjustments of startLayer, get tint of adjustments of endLayer)
			--set (vignetting amount of adjustments of targetLayers) to get vignetting amount of adjustments of startLayer
			--set (vignetting method of adjustments of targetLayers) to get vignetting method of adjustments of startLayer
			--set (white balance preset of adjustments of targetLayers) to get white balance preset of adjustments of startLayer
			set (white recovery of adjustments of targetLayers) to my RampingFunction(startIndex, endIndex, i, get white recovery of adjustments of startLayer, get white recovery of adjustments of endLayer)
			
			
			
			set i to i + 1
		end repeat
	end tell
end RampingLayerAdjustment

tell application "Capture One 23"
	tell current document
		
		my InitProgressBar(count of variants)
		-- loop all variants to match Exposure with CaptureOne Exposure Evalution
		set indexCount to 1
		set startKey to 1
		set endKey to 1
		set variantCount to count of variants
		my InitProgressBar(variantCount)
		repeat with theVariant in variants
			
			--https://stackoverflow.com/questions/1024643/applescript-equivalent-of-continue
			repeat 1 times -- # fake loop
				
				if indexCount = startKey then exit repeat -- # simulated `continue`
				if rating of theVariant is not 4 and color tag of theVariant is not 4 and variantCount is not indexCount then exit repeat -- # simulated `continue`
				
				set endKey to indexCount
				--log "start: " & startKey & " end: " & endKey
				my RampingLayerAdjustment(startKey, endKey)
				set startKey to indexCount
			end repeat
			
			set indexCount to (indexCount + 1)
		end repeat
		my EndProgressBar()
	end tell
	
end tell
