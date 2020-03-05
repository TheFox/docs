# Record Android (Google Pixel XL) Screen using ADB

## Under macOS

Install ADB.

```bash
brew install ffmpeg mplayer
brew cask install android-sdk
PATH="${HOME}/Library/Android/sdk/platform-tools:$PATH"
```

Share screen using mplayer.

```bash
adb shell screenrecord --output-format=h264 --size 1440x2560 - | mplayer -framedrop -fps 6000 -cache 512 -demuxer h264es -
```

Record screen and convert to .mp4 file.

```bash
adb shell screenrecord --output-format=h264 --size 1440x2560 - > ./screenrecord.raw
ffmpeg -vcodec h264 -i ./screenrecord.raw -vcodec copy -acodec copy ./screenrecord.mp4
```
