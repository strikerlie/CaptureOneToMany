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
		display notification "Ramping KeyFrame DONE!" with title "CaptureOne->Many" sound name "default"
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
		--	log "Average [" & itemIndex & "]startIndex: " & startIndex & " endIndex:" & endIndex & " sampleCount:" & sampleCount
		repeat sampleCount times
			set avgValue to avgValue + (item startIndex of lightnessList)
			set startIndex to startIndex
		end repeat
		set avgValue to avgValue / (sampleCount + 1)
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
			log averageLabL
			set end of lightnessList to get averageLabL
			--		set hihi to lightness of readout 1 of theVariant
			--		set test to make readout with properties {horizontal position:1, vertical position:1}
			--set diu to item 1 of hihi
			--get black of diu
			--		set OGC to lightness of test
			--	repeat with colorPicker in hihi
			--		log (get red of colorPicker)
			--		log (get horizontal position of colorPicker)
			--		log (get Lab L of colorPicker)
			--	end repeat
			--set diu to make readout of variants
			--set end of hihi to make readout --with properties {horizontal position:1, vertical position:1}
			set indexCount to (indexCount + 1)
		end repeat
		my EndProgressBar()
		
	end tell
	return lightnessList
end CalculateLightness



tell application "Capture One 23"
	--set duck to current document
	--readout 1 of variant "_DSC7019" of duck
	
	tell current document
		-- loop all variants to match Exposure with CaptureOne Exposure Evalution
		set indexCount to 1
		
		set variantCount to count of variants
		
		
		--create readout?
		--	set testing to variant 1
		--	tell testing
		--		tell readouts
		--	make readout with properties {horizontal position:11, vertical position:13}
		--		end tell
		--	end tell

		--get average Lightness value from sample point 
		set originalLightnessList to my CalculateLightness()
		
		--average 
		set averageList to my AverageFunction(originalLightnessList, 10)
		
		log originalLightnessList
		log averageList
		--2 pass?
		set averageList to my AverageFunction(averageList, 10)
		
		log averageList
		--Update exposure
		my InitProgressBar(count of variants, "Processing Deflicker Adjustment...")
		
		repeat variantCount times
			my UpdateProgressBar(indexCount)
			
			set different to (item indexCount of averageList) - (item indexCount of originalLightnessList)
			set targetLayers to layer "DeflickerAdjustment" of variant [indexCount]
			set oldValue to exposure of adjustments of targetLayers
			if oldValue is missing value then
				set oldValue to 0
			end if
			set (exposure of adjustments of targetLayers) to oldValue + (different / 20)
			set indexCount to indexCount + 1
		end repeat
		
		my EndProgressBar()
		
		log originalLightnessList
		log averageList
	end tell
	
end tell
