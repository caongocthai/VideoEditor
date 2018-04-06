#### NOTE: Sorry, I built this project in one week when I first started learning iOS and I had stopped supporting it. The project contains a lot of bugs. Please help yourself when reviewing it.

# VideoEditor
VideoEditor is an app that lets users edit their videos (it works like how it sounds)<br />

The app is written in Swift using AVFoundation framework, AVKit framework, MobileCoreServices framework and Photos framework.

##### I am an "anti-storyboard" person. Therefore, all the UI were designed programmatically using auto layout (adding constraints) technique. 

Its functionalities:

    - Implemented  functionalities:
	1. Merge 2 videos
	2. Rearrange a video around a pivot
	3. Trim a part of a video
	4. Change speed of a video
	5. Add effects to a video
	6. Add text overlay to a video
	7. Add stickers overlay to a video

    - Haven’t implemented functionalities:
	1. Reverse a video
	2. Change sound texture of a video
	3. Send or upload to a server

Note: The "haven’t implemented functionalities", however, are designed. Selecting these tools (functionalities) will result in an alert telling user that the tools have not been implemented yet.

## NOTE:
1. When users edit a video, after apply one editing tool, the new edited video is automatically saved.
2. When users are done editing, they tap action and then save. Which will add a watermark to the corner of the video.

