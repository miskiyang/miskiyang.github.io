import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:personal_website/core/video_repository.dart';
import 'package:personal_website/model/http/ResultDto.dart';
import 'package:personal_website/model/video_model.dart';
import 'package:personal_website/ui/global/global_image.dart';

import 'global/global_toast.dart';

/// 视频页面
class VideoPage extends StatefulWidget {
  final String _videoType;

  VideoPage(this._videoType);

  @override
  _VideoPageState createState() => _VideoPageState(_videoType);
}

class _VideoPageState extends State<VideoPage> {
  VideoRepository _cartoonRepository = new VideoRepository();
  List<VideoModel> _videos = <VideoModel>[];

  /// 视频类型
  String _videoType;

  _VideoPageState(this._videoType);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _videos.map((e) => buildListItemView(e)).toList(),
    );
  }

  /// 构建listItemView
  Widget buildListItemView(VideoModel item) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            CachedNetworkImage(
                placeholder: defaultPlaceHolder,
                errorWidget: defaultErrorHolder,
                imageUrl: item.cover,
                width: 90,
                height: 120,
                fit: BoxFit.cover),
            Expanded(
                child: Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    item.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                      item.descs,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  Text(
                    item.author,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    Future<ResultDto<List<VideoModel>>> result =
        _cartoonRepository.listVideoByPage(_videoType, 1, 10);
    result.then((value) {
      if (value.success) {
        _videos = value.data;
      } else {
        GlobalToast.toastShort(value.msg);
      }
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }
}
