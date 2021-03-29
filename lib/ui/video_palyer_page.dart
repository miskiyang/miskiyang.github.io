import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:personal_website/model/video_chapter_model.dart';
import 'package:video_player/video_player.dart';

/// 视频播放页面
class VideoPlayerPage extends StatefulWidget {
  final VideoChapterModel _videoChapterModel;

  VideoPlayerPage(this._videoChapterModel);

  @override
  _VideoPlayerPageState createState() =>
      _VideoPlayerPageState(_videoChapterModel);
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  VideoChapterModel _videoChapterModel;

  _VideoPlayerPageState(this._videoChapterModel);

  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NativeDeviceOrientationReader(
        builder: (context) {
          NativeDeviceOrientation orientationRead =
              NativeDeviceOrientationReader.orientation(context);
          print('======>$orientationRead');
          // 强制屏幕横屏
          orientation();
          return Chewie(controller: _chewieController);
        },
        useSensor: true,
      ),
    );
  }

  @override
  void initState() {
    orientation();
    // 视频widgetControls初始化
    initVideoControls();
    super.initState();
  }

  void orientation() async =>
      NativeDeviceOrientationCommunicator().orientation(useSensor: true);

  /// 初始化视频widget
  void initVideoControls() {
    // 视频widget初始化
    _videoPlayerController =
        VideoPlayerController.network(_videoChapterModel.chapterUrl);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        fullScreenByDefault: true,
        placeholder: Center(
          child: Text(
            "加载中...",
            style: TextStyle(fontSize: 16, color: Colors.red),
          ),
        ),
        autoPlay: true,
        showControlsOnInitialize: false,
        allowedScreenSleep: false,
        allowFullScreen: false,
        allowMuting: true,
        looping: false);
    _chewieController.play();
    _chewieController.addListener(() {
      print('======>addListener======>');
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    // controller的dispose会处理listener，因此不需要手动removeListener
    _chewieController.dispose();
    super.dispose();
  }
}
