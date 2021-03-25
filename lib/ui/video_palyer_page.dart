import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:personal_website/model/video_chapter_model.dart';
import 'package:personal_website/ui/global/global_widget.dart';
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
    return Container();
  }

  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.network(_videoChapterModel.chapterUrl);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        fullScreenByDefault: true,
        placeholder: loadingWidget('加载中...'),
        autoPlay: true,
        looping: false);
    _chewieController.play();
    _chewieController.addListener(() {
      print('======>addListener======>');
    });
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    // controller的dispose会处理listener，因此不需要手动removeListener
    _chewieController.dispose();
    super.dispose();
  }
}
