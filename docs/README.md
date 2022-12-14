Capture One To Many
=======

A tools for CaptureOne Ramping Timelapse adjustment on RAW file by AppleScript

## TL;DR
---
Just put those file in CaptureOne Script folder, run it one by one. Edit the key frame. Ramping the In between Frame. Then you should be fine.

## Requirement
---
* macOS(a.k.a. MacOSX) which CaptureOne support
* CaptureOne
    - Tested on CaptureOne 22 and 23, but it should work on older release too.

## Install
---
Copy the script file to CaptureOne Script folder

You can open it in CaptureOne Menu Bar (Menu->Scripts->Open Scripts Folder)

Default Path as follow
```
~/Library/Scripts/Capture\ One\ Scripts\
```

## Usage/Workflow
---
### Script usage

* CaptureOneToMany-000-Initialize.applescript
    - Initialize all Image in the current Collection
    - Reset setting other then Base Characteristics and Lens Correction
    - Create "BasicNormalize" Layer for Basic Normalize process
    - Create "KeyFrameAdjustment" Layer for Key Frame Adjustment and Ramping process
    - ~~(Disabled) Create "DeflickerAdjustment" Layer for Deflicker~~
    - Safest method to Initialize the Collection, but slow
* CaptureOneToMany-010-InitializeFirstOnly.applescript
    - Initialize only the Frist Image in the current Collection, you need to copy ALL adjustment/Layer in clipboard and paste to ALL other image in Collection
    - Copy process faster then CaptureOneToMany-000-Initialize.applescript, But you need to be care what you are doing
* CaptureOneToMany-100-BasicNormize.applescript
    - Adjust Exposure value by CaptureOne's Exposure Evaluation value
    - You may not need it if your Exposure is very stable
    - It can't fix flickering, you can check the reference link to know why
* CaptureOneToMany-200-SetKeyFrame.applescript
    - Set Ranking 4 star(HotKey 4) and Green Color Tag(HotKey +) to the selected image
    - The following Script check Ranking 4+Green Color Tag as reference
    - Just a fail-save design to set 2 differnt marking(you may hit 4/+ key accidentally)
* CaptureOneToMany-300-SyncKeyFrame.applescript
    - Copy Key Frame adjustment to selected Key Frame
    - Supported adjustment in the table below
* CaptureOneToMany-400-RampingKeyFrame.applescript
    - Ramping all image adjustment between Key Frame
    - Supported adjustment in the table below
* ~~CaptureOneToMany-500-Defilcker.applescript~~
    - ~~Calculate Lumance value of each image then calculate average value and adjust the different to match Lightness in "DeflickerAdjustment"~~ 
* ~~CaptureOneToMany-996-ResetDefilcker.applescript~~
    - ~~Reset "DeflickerAdjustment" Layer adjustment~~
* CaptureOneToMany-997-ResetDefilckerPoint.applescript
    - Clear Color Reaout points
* CaptureOneToMany-998-ResetBasicNormalize.applescript
    - Reset "BasicNormalize" Layer adjustment
* CaptureOneToMany-999-FullReset.applescript
    - Reset All adjustment

### Suggested Workflow
1. Edit **Base Characteristics** and **Lens Correction** at the *first* image in the collection
    - If you use [ColorChecker](https://calibrite.com/us/product-category/capture-solutions/), please apple the ICC profile to the first image at this point
1. Run CaptureOneToMany-000-Initialize.applescript or CaptureOneToMany-010-InitializeFirstOnly.applescript
    - For Performance, use InitializeFirstOnly and copy the adjustment to all other image. You can try Initialize first and see how it works.
1. If you want to apply [LCC](https://support.captureone.com/hc/en-us/articles/360002583678-The-LCC-tool) to the image. You can create the LCC in another collection and copy the LCC adjustment to the current collection images now.
1. If you find that your iamge exposure is not consistent. You may try to apply CaptureOneToMany-100-BasicNormize.applescript.
    - It do not help defilcker!
    - It can be reset by CaptureOneToMany-998-ResetBasicNormalize.applescript
1. Select the Key Frame you wanted and run CaptureOneToMany-200-SetKeyFrame.applescript
1. Edit the Key Frame **in "KeyFrameAdjustment" Layer** and run CaptureOneToMany-300-SyncKeyFrame.applescript. Then the Script will help you sync the selected Key Frame "KeyFrameAdjustment" Layer adjustment to other Key Frame
1. Run CaptureOneToMany-400-RampingKeyFrame.applescript to automatic calculate and set the ramping value of in between frame 
    - For safe, The first and last image will be Key Frame even you did not mark it as Key Frame.
1. Export low resolution JPEG image to preview result
    - Long Edge 640~1024px is a ok value
    - You can Merge it by FFmpeg
1. If not ok, repeat Step 5-7 until you feel good
1. It you want to Redo it again, you can run CaptureOneToMany-999-FullReset.applescript
    - Reminder: It will **DELETE ALL LAYER** and **RESET ALL** config for **ALL IMAGE** in current collection
1. Export ALL image in Full size JPEG into a new folder
    - Easier for merging it to Video
1. If needed, you can use 3rd party Deflicker tools 
1. Merge the Full size JPEG to video

## Supported List
---
```
Ramping:
    - Adjustment support ramping and will be automatic updated by Script(Most of them in "KeyFrameAdjustment" Layer)

Copy:
    - Adjustment will copy from First image to last image(Most can done by Initalize process, some need to manually copy)

Not Support:
    - Not supported due to API limition or software bug(or maybe my fault +_+)

```
### Base Characteristics
| Adjustment  | Ramping | Copy | Not Support |
| ------------- | ------------- | ------------- | ------------- |
|Color Profile| | Support | |
|Film Curve| | Support | |

### Lens Correction
| Adjustment  | Ramping | Copy | Not Support |
| ------------- | ------------- | ------------- | ------------- |
| Lens Profile | | Support |  |
| Lens Aperture | | Support |  |
| Chromatic Aberration | |  | No, It default set to false after copy |
| Diffraction Correction | | Support |  |
| Distortion | | Support |  |
| Focal Length | | Support |  |
| Hide Distorted Areas | | Support |  |
| Light Falloff | | Support |  |
| Sharpness Falloff | | Support |  |
| Shift x | |  | No, AppleScript return error when get this field |
| Shift y | |  | No, AppleScript return error when get this field |

### White Balance
| Adjustment  | Ramping | Copy | Not Support |
| ------------- | ------------- | ------------- | ------------- |
| Kelvin | Support|  | |
| Tint  | Support  |  |  |

### Exposure
| Adjustment  | Ramping | Copy | Not Support |
| ------------- | ------------- | ------------- | ------------- |
| Exposure | Support|  | |
| Contrast  | Support  |  |  |
| Brindness  | Support  |  |  |
| Saturation  | Support  |  |  |


### High Dynamic Range
| Adjustment  | Ramping | Copy | Not Support |
| ------------- | ------------- | ------------- | ------------- |
| Highlight | Support|  | |
| Shadow  | Support  |  |  |
| White  | Support  |  |  |
| Black  | Support  |  |  |


### Clarity
| Adjustment  | Ramping | Copy | Not Support |
| ------------- | ------------- | ------------- | ------------- |
| Method | | Support | |
| Clarity  | Support  |  |  |
| Structure  | Support  |  |  |

### Dehaze
| Adjustment  | Ramping | Copy | Not Support |
| ------------- | ------------- | ------------- | ------------- |
| Amount | Support |  |  |
| Shadow Tone  |  | Support | |


### Levels
| Adjustment  | Ramping | Copy | Not Support |
| ------------- | ------------- | ------------- | ------------- |
| RGB | Support | | |
| Red | Support | | |
| Green | Support | | |
| Blue | Support | | |

### Curve
| Adjustment  | Ramping | Copy | Not Support |
| ------------- | ------------- | ------------- | ------------- |
| RGB | |Support | |
| Luma | | Support | |
| Red | | Support | |
| Green | | Support | |
| Blue | | Support | |


### Vignetting
| Adjustment  | Ramping | Copy | Not Support |
| ------------- | ------------- | ------------- | ------------- |
| Amount | |  | No, Not editable in Layer|
| Method | |  | No, Not editable in Layer|

### Sharpening
| Adjustment  | Ramping | Copy | Not Support |
| ------------- | ------------- | ------------- | ------------- |
| Amount | Support | | |
| Radius | Support | | |
| Threshold | Support | | |
| Halo Suppression | Support | | |


### Noise Reduction
| Adjustment  | Ramping | Copy | Not Support |
| ------------- | ------------- | ------------- | ------------- |
| Luminance | Support | | |
| Details | Support | | |
| Color | |  | No, Not editable in Layer |
| Single Pixel | |  | No, Not editable in Layer |


### Film Grain
| Adjustment  | Ramping | Copy | Not Support |
| ------------- | ------------- | ------------- | ------------- |
| Type | |  | No, Not editable in Layer |
| Impact | |  | No, Not editable in Layer |
| Granularity| |  | No, Not editable in Layer |


### Sport Removel
| Adjustment  | Ramping | Copy | Not Support |
| ------------- | ------------- | ------------- | ------------- |
| Spot | |  | No, AppleScript API not support |
| Radius | |  | No, AppleScript API not support |
| Type| |  | No, AppleScript API not support |


### Moire
| Adjustment  | Ramping | Copy | Not Support |
| ------------- | ------------- | ------------- | ------------- |
| Amount | Support | | |
| Pattern| Support | | |

### Color Editor
| Adjustment  | Ramping | Copy | Not Support |
| ------------- | ------------- | ------------- | ------------- |
| Basic | | Support | |
| Advanced | | Support | |
| Skin Tone | | Support | |


### Color Balance
| Adjustment  | Ramping | Copy | Not Support |
| ------------- | ------------- | ------------- | ------------- |
| Master | Support | | |
| Shadow | Support | | |
| Midtone | Support | | |
| Highlight | Support | | |

### Black & White
| Adjustment  | Ramping | Copy | Not Support |
| ------------- | ------------- | ------------- | ------------- |
| Enable Black & White | |  | No, Not editable in Layer |
| Red | |  | No, Not editable in Layer |
| Yellow | |  | No, Not editable in Layer |
| Green | |  | No, Not editable in Layer |
| Cyan | |  | No, Not editable in Layer |
| Blue | |  | No, Not editable in Layer |
| Magenta | |  | No, Not editable in Layer |
| Highlight Hue | |  | No, Not editable in Layer |
| Highlight Saturation | |  | No, Not editable in Layer |
| Shadows Hue | |  | No, Not editable in Layer |
| Shadows Saturation | |  | No, Not editable in Layer |


## Missing Feature
---
* Layer Mask Ramping
    - Due to missing API for get/draw gradient layer mask

* Deflicker
    - I already created a Script for Deficker, but due to Color Readout bug in CaptureOne(or maybe my coding issue?) , need to wait CaptureOne fix.
    - You can try CaptureOneToMany-500-Defilcker.applescript, but color readout value is not match the image.

* Adjustment not edit in Layer
    - My fault, I still thinking Pros&Cons. Should I do it?

* Curve Ramping
    - My fault, I still thinking how to do it....
    - if there has 2 point curve ramp to 3 point curve....no idea...

* Render timelapse video in CaptureOne
    - I don't think it is possable....
    - FFmpeg is your friend

## Workaround
---
### Deflicker
* Use 3rd party tools to deflicker
    - [timelapse-deflicker.pl Script](https://github.com/cyberang3l/timelapse-deflicker)
        - On macOS, easiest way is install it in [Ubuntu Multipass](https://multipass.run/)
### Render Video
* Use [FFmpeg](https://ffmpeg.org/)
    
    Example
    #### H264
    ```
    ```
    #### H265 a.k.a. HEVC
    ```
    ```
    ##### 24FPS 10bit 422 ProRES:
    ```
    ffmpeg -framerate 24 -pattern_type glob -i "*.jpg" -c:v prores -profile:v 3 -pix_fmt yuv422p10 output.mov
    ```

## FAQ
---
### Why create it?

* In the market, there has many tools for TimeLapse photography which only support Adobe Lightroom Classic. They are great, if you are using Lightroom, you should try them. But I am CaptureOne user, I can't find any TimeLapse tools for CaptureOne still alive in the market. On the other hand, I am a software developer, why I can't create my own tools if it do not exist? So I write this tools and opensource it. Hope 

### Why no Windows support?

* At the beginning, I tried to read the CaptureOne SDK manual(for both Windows and macOS. Yes! they are different!). But seems there is not providing enough API to to image adjustment. So I use AppleScript which provide more posibility for image adjustment. But it is macOS only. Sorry Windows user....


### Why it sucks!

* This is my first AppleScript and CaptureOne related project. So it may have bug. If you find there has a bug, please help to report it. If you are developer, you can Fork() it or help to improve it. It is why I opensource this project.

### Why so many layer?

* Yes, It is over engineered. But It is much more easier to reset adjustment by different tools.



## TODO
---

## Special Thanks and Reference
---
* [AlexOnRAW](https://alexonraw.com/)
    * A good place to learn CaptureOne's feature.
* [CaptureOne Forum - Development and Automation Workflows - Scripting](https://support.captureone.com/hc/en-us/community/topics/360000616838-Development-and-Automation-Workflows-Scripting)
    * CaptureOne offical AppleScript forum.
* [DT CODING SERIES](https://dtculturalheritage.com/dt-coding-series/)
    * An introduction series by DT Cultural Heritage. Mainly focus on automation on CaptureOne. Good introduction series.
* [Patrick Cheung@PowerUpTimelapse](https://www.youtube.com/@PowerUpTimelapse/about) 
    * Timelapse and Hyperlapse Creator, Nikon Hong Kong Ambassador. His works are amazing. He provide several advice and suggestion to my works.
* [Shoot Machine Co. Blog](https://shootmachine.co/)
    * A blog related to AppleScript and CaptureOne. He has a good blog post explain why CaptureOne Normalise tool is not that work for matching exposure and created his own solution. Nice to have a look!
* [timelapse-deflicker](https://github.com/cyberang3l/timelapse-deflicker)
    * A opensource tools for deflickering.