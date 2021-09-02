import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:novel_cartoon_video/core/video_repository.dart';
import 'package:novel_cartoon_video/model/http/ResultDto.dart';
import 'package:novel_cartoon_video/model/video_model.dart';
import 'package:novel_cartoon_video/ui/base/base_state.dart';
import 'package:novel_cartoon_video/ui/base_page.dart';
import 'package:novel_cartoon_video/ui/global/global_image.dart';
import 'package:novel_cartoon_video/ui/video_detail_page.dart';

import 'global/global_toast.dart';

/// 视频页面
class VideoPage extends StatefulWidget {
  final String _videoType;

  VideoPage(this._videoType);

  @override
  _VideoPageState createState() => _VideoPageState(_videoType);
}

class _VideoPageState extends BaseState<VideoPage>
    with AutomaticKeepAliveClientMixin {
  VideoRepository _cartoonRepository = new VideoRepository();

  List<VideoModel> _videos = <VideoModel>[];

  /// 视频类型
  String _videoType;

  _VideoPageState(this._videoType);

  @override
  bool get wantKeepAlive => true;

  EasyRefreshController _controller;

  int _pageSize = 10;
  int _pageIndex = 1;
  bool _hasMore = false;

  GlobalKey _globalRefreshKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildContent(context);
  }

  @override
  Widget buildBodyWidget(BuildContext buildContext) {
    return EasyRefresh(
        key: _globalRefreshKey,
        controller: _controller,
        enableControlFinishLoad: true,
        header: ClassicalHeader(
          refreshText: '下拉刷新',
          refreshReadyText: '松开刷新',
          refreshingText: '正在加载数据',
          refreshedText: '加载完成',
          infoText: '更新于%T',
          showInfo: true,
          bgColor: Colors.transparent,
          textColor: Colors.red.shade500,
          infoColor: Colors.red.shade500,
        ),
        footer: ClassicalFooter(
          loadText: '上拉加载更多漫画',
          loadReadyText: '松开加载更多漫画',
          loadingText: '正在加载更多漫画',
          loadedText: '加载完成',
          noMoreText: '没有更多了',
          infoText: '更新于%T',
          showInfo: true,
          bgColor: Colors.transparent,
          textColor: Colors.red.shade600,
          infoColor: Colors.red.shade600,
        ),
        onRefresh: () async {
          _cartoonRepository
              .listVideoByPage(_videoType, 0, _pageSize)
              .then((value) {
            if (!value.success) {
              GlobalToast.toastLong(value.msg);
            } else {
              _videos = value.data;
              // 重置刷新的索引值
              _pageIndex = 1;
            }
          }).whenComplete(() {
            if (mounted) {
              _globalRefreshKey.currentState.setState(() {});
            }
          });
        },
        onLoad: _hasMore
            ? () async {
                _cartoonRepository
                  ..listVideoByPage(_videoType, _pageIndex + 1, _pageSize)
                      .then((value) {
                    // 新增分页数据
                    if (!value.success) {
                      GlobalToast.toastLong(value.msg);
                    } else {
                      _pageIndex++;
                      _videos.addAll(value.data);
                      if (value.data.length < _pageSize) {
                        // 没有更多数据
                        _hasMore = false;
                      } else {
                        _hasMore = true;
                      }
                    }
                  }).whenComplete(() {
                    if (mounted) {
                      _controller.finishLoad(success: true, noMore: !_hasMore);
                      setState(() {});
                    }
                  });
              }
            : null,
        child: ListView.separated(
            physics: BouncingScrollPhysics(), // 回弹效果的scroll
            itemBuilder: (context, index) => buildListItemView(_videos[index]),
            separatorBuilder: (context, index) => Divider(
                  height: 1.0,
                  color: Colors.grey[200],
                ),
            itemCount: _videos.length));
  }

  /// 构建listItemView
  Widget buildListItemView(VideoModel item) {
    return bindTapEvent(
        Padding(
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
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey.shade500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => VideoDetailPage(item))));
  }

  RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  @override
  void initState() {
    _controller = EasyRefreshController();
    Future<ResultDto<List<VideoModel>>> result =
        _cartoonRepository.listVideoByPage(_videoType, _pageIndex, _pageSize);
    result.then((value) {
      if (value.success) {
        _videos = value.data;
        if (value.data.length < _pageSize) {
          // 没有更多数据
          _hasMore = false;
        } else {
          _hasMore = true;
        }
      } else {
        GlobalToast.toastShort(value.msg);
      }
      if (mounted) {
        setLoadStatus(true);
        setState(() {});
      }
    });
    super.initState();
  }
}
