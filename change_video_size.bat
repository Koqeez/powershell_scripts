::Variables
set /A desired_filesize=19800000*8 
::The file size that ffmpeg will aim for 
set audio_bitrate=96000
set video_length=49 
::In seconds

set /A video_bitrate=desired_filesize/video_length-audio_bitrate

set input="big video.mp4" 
::Name of video file
set output="Email Friendly Video.mp4" 
::Name of desired video file

set codec=-c:v libx264 
::Compressing software

ffmpeg -y -i %input% %codec% -preset veryslow -b:v %video_bitrate% -c:a aac -b:a %audio_bitrate% %output%
::Command