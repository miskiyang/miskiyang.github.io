import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:personal_website/core/video_repository.dart';
import 'package:personal_website/model/video_chapter_model.dart';
import 'package:personal_website/model/video_model.dart';
import 'package:personal_website/ui/global/global_image.dart';
import 'package:personal_website/ui/global/global_toast.dart';

import 'global/global_widget.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel _videoModel;

  VideoDetailPage(this._videoModel);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState(_videoModel);
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  VideoRepository _videoRepository = VideoRepository();
  VideoModel _videoModel;
  List<VideoChapterModel> _videoChapters = [];
  bool _getChapterDataSuccess = false;

  _VideoDetailPageState(this._videoModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            leading: Builder(
                builder: (BuildContext context) => IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )),
            centerTitle: true,
            floating: false,
            pinned: true,
            snap: false,
            expandedHeight: 260,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 20, bottom: 16),
              title: Text(
                _videoModel.title,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                      placeholder: transparentPlaceHolder,
                      errorWidget: transparentErrorHolder,
                      imageUrl: _videoModel.cover,
                      width: 90,
                      height: 120,
                      fit: BoxFit.cover),
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: Text(
                      "作者：" + _videoModel.author,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFF8344E),
                      ),
                    ),
                  )
                ],
              ),
              collapseMode: CollapseMode.pin,
            ),
          ),
          _buildVideoDescriptionTitle(),
          _buildVideoDescription(),
          _buildVideoCategoriesTitle(),
          _buildVideoCategories(),
        ],
      ),
    );
  }

  RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  /// 构建漫画描述标题
  Widget _buildVideoDescriptionTitle() {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      sliver: SliverToBoxAdapter(
        child: Text(
          "描述",
          style: TextStyle(
              fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  /// 构建漫画描述
  Widget _buildVideoDescription() {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      sliver: SliverToBoxAdapter(
        child: Text(
          _videoModel.descs,
          style: TextStyle(fontSize: 16, height: 1.6, color: Colors.black54),
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }

  /// 构建漫画目录标题
  Widget _buildVideoCategoriesTitle() {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      sliver: SliverToBoxAdapter(
        child: Text(
          "目录",
          style: TextStyle(
              fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  /// 构建视频播放区域
  Widget _buildVideoCategories() {
    if (_getChapterDataSuccess) {
      // 展示动漫目录
      return SliverPadding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => Ink(
                          child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        onTap: () {
                          // 跳转视频播放
                        },
                        splashColor: Colors.grey.shade300,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1.0,
                                style: BorderStyle.solid),
                            shape: BoxShape.rectangle,
                          ),
                          child: Text(
                            (index + 1).toString() +
                                "." +
                                _videoChapters[index].title,
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey.shade600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )),
                  childCount: _videoChapters.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 6,
                childAspectRatio: 4,
              )));
    } else {
      // 展示加载中
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
            child: loadingWidget("加载目录中..."),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    _videoRepository.listVideoChapter(_videoModel.videoId).then((value) {
      if (value.success) {
        this._videoChapters = value.data;
      } else {
        GlobalToast.toastShort(value.msg);
      }
      _getChapterDataSuccess = true;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }
}
