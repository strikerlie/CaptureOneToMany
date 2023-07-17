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
		
		set startLayerAdj to adjustments of startLayer
		set endLayerAdj to adjustments of endLayer
		set i to startIndex + 1
		
		repeat while i < endIndex
			
			my UpdateProgressBar(i)
			try
				set targetLayers to layer "KeyFrameAdjustment" of variant [i]
			on error
				display alert "Looks missing KeyFrameAdjustment layer on " & name of variant [i] & "! Better to check before Continue" as critical buttons {"Stop", "Continue"} default button "Stop" cancel button "Stop"
			end try
			set targetLayersAdj to adjustments of targetLayers
			--log "RampingLayerAdjustment start: " & startIndex & " end: " & endIndex & " i:" & i
			--log (get black recovery  of startLayerAdj)
			--log (get black recovery of endLayerAdj)
			--log my RampingFunction(startIndex, endIndex, i, get black recovery  of startLayerAdj, get black recovery of endLayerAdj)
			
			--	set (black and white of targetLayersAdj) to get black and white of adjustments of sourceLayers
			--	set (black and white blue sensitivity of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i,get black and white blue sensitivity of adjustments of sourceLayers
			--	set (black and white cyan sensitivity of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get black and white cyan sensitivity of adjustments of sourceLayers
			--	set (black and white green sensitivity of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i,get black and white green sensitivity of adjustments of sourceLayers
			--	set (black and white magenta sensitivity of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i,get black and white magenta sensitivity of adjustments of sourceLayers
			--	set (black and white red sensitivity of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i,get black and white red sensitivity of adjustments of sourceLayers
			--	set (black and white split highlight hue of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i,get black and white split highlight hue of adjustments of sourceLayers
			--	set (black and white split highlight saturation of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i,get black and white split highlight saturation of adjustments of sourceLayers
			--	set (black and white split shadow hue of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i,get black and white split shadow hue of adjustments of sourceLayers
			--	set (black and white split shadow saturation of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i,get black and white split shadow saturation of adjustments of sourceLayers
			--	set (black and white yellow sensitivity of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i,get black and white yellow sensitivity of adjustments of sourceLayers
			set (black recovery of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get black recovery of startLayerAdj, get black recovery of endLayerAdj)
			set (blue curve of targetLayersAdj) to get blue curve of startLayerAdj
			set (brightness of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get brightness of startLayerAdj, get brightness of endLayerAdj)
			set (clarity amount of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get clarity amount of startLayerAdj, get clarity amount of endLayerAdj)
			set (clarity method of targetLayersAdj) to get clarity method of startLayerAdj
			set (clarity structure of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get clarity structure of startLayerAdj, get clarity structure of endLayerAdj)
			set (color balance highlight hue of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get color balance highlight hue of startLayerAdj, get color balance highlight hue of endLayerAdj)
			set (color balance highlight lightness of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get color balance highlight lightness of startLayerAdj, get color balance highlight lightness of endLayerAdj)
			set (color balance highlight saturation of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get color balance highlight saturation of startLayerAdj, get color balance highlight saturation of endLayerAdj)
			set (color balance master hue of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get color balance master hue of startLayerAdj, get color balance master hue of endLayerAdj)
			set (color balance master saturation of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get color balance master saturation of startLayerAdj, get color balance master saturation of endLayerAdj)
			set (color balance midtone hue of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get color balance midtone hue of startLayerAdj, get color balance midtone hue of endLayerAdj)
			set (color balance midtone lightness of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get color balance midtone lightness of startLayerAdj, get color balance midtone lightness of endLayerAdj)
			set (color balance midtone saturation of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get color balance midtone saturation of startLayerAdj, get color balance midtone saturation of endLayerAdj)
			set (color balance shadow hue of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get color balance shadow hue of startLayerAdj, get color balance shadow hue of endLayerAdj)
			set (color balance shadow lightness of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get color balance shadow lightness of startLayerAdj, get color balance shadow lightness of endLayerAdj)
			set (color balance shadow saturation of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get color balance shadow saturation of startLayerAdj, get color balance shadow saturation of endLayerAdj)
			set (color editor settings of targetLayersAdj) to get color editor settings of startLayerAdj
			--	set (color profile of targetLayersAdj) to get color profile  of startLayerAdj
			set (contrast of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get contrast of startLayerAdj, get contrast of endLayerAdj)
			set (dehaze amount of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get dehaze amount of startLayerAdj, get dehaze amount of endLayerAdj)
			set (dehaze color of targetLayersAdj) to get dehaze color of startLayerAdj
			set (exposure of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get exposure of startLayerAdj, get exposure of endLayerAdj)
			--set (film curve of targetLayersAdj) to get film curve of adjustments of sourceLayers
			--set (film grain granularity of targetLayersAdj) to get film grain granularity of adjustments of sourceLayers
			--set (film grain impact of targetLayersAdj) to get film grain impact of adjustments of sourceLayers
			--set (film grain type of targetLayersAdj) to get film grain type of adjustments of sourceLayers
			--set (flip of targetLayersAdj) to get flip of adjustments of sourceLayers
			set (green curve of targetLayersAdj) to get green curve of startLayerAdj
			set (highlight adjustment of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get highlight adjustment of startLayerAdj, get highlight adjustment of endLayerAdj)
			set (level highlight blue of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get level highlight blue of startLayerAdj, get level highlight blue of endLayerAdj)
			set (level highlight green of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get level highlight green of startLayerAdj, get level highlight green of endLayerAdj)
			set (level highlight red of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get level highlight red of startLayerAdj, get level highlight red of endLayerAdj)
			set (level highlight rgb of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get level highlight rgb of startLayerAdj, get level highlight rgb of endLayerAdj)
			set (level midtone blue of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get level midtone blue of startLayerAdj, get level midtone blue of endLayerAdj)
			set (level midtone green of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get level midtone green of startLayerAdj, get level midtone green of endLayerAdj)
			set (level midtone red of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get level midtone red of startLayerAdj, get level midtone red of endLayerAdj)
			set (level midtone rgb of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get level midtone rgb of startLayerAdj, get level midtone rgb of endLayerAdj)
			set (level shadow blue of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get level shadow blue of startLayerAdj, get level shadow blue of endLayerAdj)
			set (level shadow green of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get level shadow green of startLayerAdj, get level shadow green of endLayerAdj)
			set (level shadow red of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get level shadow red of startLayerAdj, get level shadow red of endLayerAdj)
			set (level shadow rgb of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get level shadow rgb of startLayerAdj, get level shadow rgb of endLayerAdj)
			set (level target highlight blue of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get level target highlight blue of startLayerAdj, get level target highlight blue of endLayerAdj)
			set (level target highlight green of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get level target highlight green of startLayerAdj, get level target highlight green of endLayerAdj)
			set (level target highlight red of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get level target highlight red of startLayerAdj, get level target highlight red of endLayerAdj)
			set (level target shadow blue of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get level target shadow blue of startLayerAdj, get level target shadow blue of endLayerAdj)
			set (level target shadow green of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get level target shadow green of startLayerAdj, get level target shadow green of endLayerAdj)
			set (level target shadow red of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get level target shadow red of startLayerAdj, get level target shadow red of endLayerAdj)
			set (level target shadow rgb of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get level target shadow rgb of startLayerAdj, get level target shadow rgb of endLayerAdj)
			set (luma curve of targetLayersAdj) to get luma curve of startLayerAdj
			set (moire amount of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get moire amount of startLayerAdj, get moire amount of endLayerAdj)
			try
				set (moire pattern of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get moire pattern of startLayerAdj, get moire pattern of endLayerAdj) --missing value is 4....				
			end try
			--set (noise reduction color of targetLayersAdj) to get noise reduction color of adjustments of sourceLayers
			set (noise reduction details of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get noise reduction details of startLayerAdj, get noise reduction details of endLayerAdj)
			set (noise reduction luminance of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get noise reduction luminance of startLayerAdj, get noise reduction luminance of endLayerAdj)
			--set (noise reduction single pixel of targetLayersAdj) to get noise reduction single pixel of adjustments of sourceLayers
			--set (orientation of targetLayersAdj) to get orientation of adjustments of sourceLayers
			set (red curve of targetLayersAdj) to get red curve of startLayerAdj
			set (rgb curve of targetLayersAdj) to get rgb curve of startLayerAdj
			--set (rotation of targetLayersAdj) to get rotation  of startLayerAdj
			set (saturation of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get saturation of startLayerAdj, get saturation of endLayerAdj)
			set (shadow recovery of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get shadow recovery of startLayerAdj, get shadow recovery of endLayerAdj)
			set (sharpening amount of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get sharpening amount of startLayerAdj, get sharpening amount of endLayerAdj)
			set (sharpening halo suppression of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get sharpening halo suppression of startLayerAdj, get sharpening halo suppression of endLayerAdj)
			set (sharpening radius of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get sharpening radius of startLayerAdj, get sharpening radius of endLayerAdj)
			set (sharpening threshold of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get sharpening threshold of startLayerAdj, get sharpening threshold of endLayerAdj)
			set (temperature of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get temperature of startLayerAdj, get temperature of endLayerAdj)
			set (tint of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get tint of startLayerAdj, get tint of endLayerAdj)
			--set (vignetting amount of targetLayersAdj) to get vignetting amount  of startLayerAdj
			--set (vignetting method of targetLayersAdj) to get vignetting method  of startLayerAdj
			--set (white balance preset of targetLayersAdj) to get white balance preset  of startLayerAdj
			set (white recovery of targetLayersAdj) to my RampingFunction(startIndex, endIndex, i, get white recovery of startLayerAdj, get white recovery of endLayerAdj)
			
			
			
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
