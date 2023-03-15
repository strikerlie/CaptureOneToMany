use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions
on InitProgressBar(total, message)
	tell application "Capture One 23"
		set progress total units to total
		set progress completed units to 0
		set progress text to message
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
		display notification "Deflicker DONE!" with title "CaptureOne->Many" sound name "default"
		set progress total units to 0
		set progress completed units to 0
		set progress text to ""
		set progress additional text to ""
	end tell
end EndProgressBar
on GetIndex(current, endIndex)
	if current < 1 then
		return 1
	else if current > endIndex then
		return endIndex
	else
		return current
	end if
end GetIndex

on AverageFunction(lightnessList, interval) -- looks average not working as expected
	set itemCount to count of lightnessList
	set returnList to {}
	set itemIndex to 1
	repeat itemCount times
		set startIndex to GetIndex(itemIndex - interval, itemCount)
		set endIndex to GetIndex(itemIndex + interval, itemCount)
		set sampleCount to endIndex - startIndex + 1
		set avgValue to 0
		--log "Average [" & itemIndex & "]startIndex: " & startIndex & " endIndex:" & endIndex & " sampleCount:" & sampleCount
		repeat sampleCount times
			--	log "   Lightness [" & startIndex & "]:" & (item startIndex of lightnessList)
			set avgValue to avgValue + (item startIndex of lightnessList)
			set startIndex to startIndex + 1
		end repeat
		--log "  SUM:" & avgValue
		set avgValue to avgValue / (sampleCount)
		--log "  AVG:" & avgValue
		set end of returnList to avgValue
		set itemIndex to itemIndex + 1
	end repeat
	
	
	return returnList
end AverageFunction

on CalculateLightness()
	set lightnessList to {}
	tell application "Capture One 23"
		set indexCount to 1
		
		set readoutCount to count of readout of variant [1]
		my InitProgressBar(count of variants, "Calculate Lumance Value...")
		set rgbMode to false
		if Lab L of readout readoutCount of variant [1] is missing value then
			set rgbMode to true
		end if
		
		repeat with theVariant in variants
			my UpdateProgressBar(indexCount)
			set averageLabL to 0
			set readoutIndex to 1
			repeat readoutCount times
				if rgbMode then
					set thisLightness to get lightness of readout readoutIndex of theVariant
				else
					set thisLightness to get Lab L of readout readoutIndex of theVariant
				end if
				set averageLabL to averageLabL + thisLightness
				set readoutIndex to readoutIndex + 1
			end repeat
			set averageLabL to averageLabL / readoutCount
			--	log averageLabL
			set end of lightnessList to get averageLabL
			set indexCount to (indexCount + 1)
		end repeat
		my EndProgressBar()
		
	end tell
	return lightnessList
end CalculateLightness



tell application "Capture One 23"	
	tell current document
		-- loop all variants to match Exposure with CaptureOne Exposure Evalution
		
		set variantCount to count of variants
		
		--get average Lightness value from sample point 
		set originalLightnessList to my CalculateLightness()
		
		--average 
		set averageList to my AverageFunction(originalLightnessList, 10)
		
		--log originalLightnessList
		--log averageList
		--2 pass?
		set averageList to my AverageFunction(averageList, 10)
		
		--log averageList
		--Update exposure
		my InitProgressBar(count of variants, "Processing Deflicker Round2 Adjustment...")
		
		set indexCount to 1
		repeat variantCount times
			my UpdateProgressBar(indexCount)
			set different to (item indexCount of averageList) - (item indexCount of originalLightnessList)
			set differentRatio to different / (item indexCount of originalLightnessList)
			--log "index[" & indexCount & "] Original=" & (item indexCount of originalLightnessList) & "Target=" & (item indexCount of averageList) & " different=" & different & " different/Original=" & differentRatio
			
			set targetLayers to layer "DeflickerAdjustment2" of variant [indexCount]
			set oldValue to exposure of adjustments of targetLayers
			if oldValue is missing value then
				set oldValue to 0
			end if
			set (exposure of adjustments of targetLayers) to oldValue + differentRatio
			set indexCount to indexCount + 1
		end repeat
		
		my EndProgressBar()
		
		--log originalLightnessList
		--log averageList
	end tell
	
end tell
