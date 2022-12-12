use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions
on InitProgressBar(total)
	tell application "Capture One 23"
		set progress total units to total
		set progress completed units to 0
		set progress text to "Processing Initialize Images..."
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
		display notification "Initialize DONE!" with title "CaptureOne->Many" sound name "default"
		set progress total units to 0
		set progress completed units to 0
		set progress text to ""
		set progress additional text to ""
	end tell
end EndProgressBar


tell application "Capture One 23"
	tell current document
		--Copy Base Characteristics, Lens Correction to all variants
		set baseSource to get item 1 of variants
		--https://developer.apple.com/library/archive/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/DisplayDialogsandAlerts.html
		set theDialogText to "Initialize will clear ALL ADJUSTMENT of " & (count of variants) & " Photo in current collection(" & name of current collection & ")!
Then will copy " & (name of baseSource) & "'s Base Characteristics, Len Correction to other image"
		try
			display dialog theDialogText with icon caution buttons {"STOP!", "Initialize"} default button "Initialize" cancel button "STOP!"
		on error errText number errNum
			--https://stackoverflow.com/questions/15170180/how-can-i-handle-applescript-dialog-response
			if errNum is -128 then -- or you can say: if errNum is -128
				return
			end if
		end try
		
		my InitProgressBar(count of variants)
		
		--Copy adjustment
		--Base Characteristics 
		copy color profile of adjustments of baseSource to baseColorProfile
		copy film curve of adjustments of baseSource to baseFileCurve
		--Lens Correction
		copy lens profile of lens correction of baseSource to baseLensProfile
		copy aperture of lens correction of baseSource to baseAperture
		copy chromatic aberration of lens correction of baseSource to baseChromaticAberration --not so work.....
		copy custom chromatic aberration of lens correction of baseSource to baseCustomChromaticAberration --not so work.....
		copy diffraction correction of lens correction of baseSource to baseDiffractionCorrection
		copy distortion of lens correction of baseSource to baseDistortion
		copy focal length of lens correction of baseSource to baseFocalLength
		copy hide distorted areas of lens correction of baseSource to baseHideDistortedAreas
		copy light falloff of lens correction of baseSource to baseLightFalloff
		copy sharpness falloff of lens correction of baseSource to baseSharpnessFalloff
		--Movment get shift x y is not working
		
		--Reset other setting
		reset adjustments baseSource
		
		--Paste adjustment
		--Base Characteristics 
		set color profile of adjustments of baseSource to baseColorProfile
		set film curve of adjustments of baseSource to baseFileCurve
		--Lens Correction
		
		set lens profile of lens correction of baseSource to baseLensProfile
		set aperture of lens correction of baseSource to baseAperture
		set chromatic aberration of lens correction of baseSource to baseChromaticAberration --not so work.....
		set custom chromatic aberration of lens correction of baseSource to baseCustomChromaticAberration --not so work.....
		set diffraction correction of lens correction of baseSource to baseDiffractionCorrection
		set distortion of lens correction of baseSource to baseDistortion
		set focal length of lens correction of baseSource to baseFocalLength
		set hide distorted areas of lens correction of baseSource to baseHideDistortedAreas
		set light falloff of lens correction of baseSource to baseLightFalloff
		set sharpness falloff of lens correction of baseSource to baseSharpnessFalloff
		
		tell baseSource
			tell layers of baseSource
				-- Create Layer for Timelapse automation processing
				set basicNormalize to make new layer with properties {name:"BasicNormalize", kind:adjustment, opacity:100} at end
				tell basicNormalize
					fill mask
				end tell
				set keyFrameAdjustment to make new layer with properties {name:"KeyFrameAdjustment", kind:adjustment, opacity:100} at end
				tell keyFrameAdjustment
					fill mask
				end tell
				--		set deflickerAdjustment to make new layer with properties {name:"DeflickerAdjustment", kind:adjustment, opacity:100} at end
				--		tell deflickerAdjustment
				--			fill mask
				--		end tell
			end tell
			
		end tell
		
		--Copy Reference Variant setting
		copy adjustments baseSource
		-- loop all variants to Paste Reference Variant setting
		set indexCount to 0
		repeat with theVariant in (variants whose id is not id of baseSource)
			
			reset adjustments theVariant
			apply adjustments theVariant
			my UpdateProgressBar(indexCount)
			set indexCount to (indexCount + 1)
		end repeat
		my EndProgressBar()
	end tell
end tell
