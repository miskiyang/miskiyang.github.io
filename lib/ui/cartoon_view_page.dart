import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:novel_cartoon_video/core/cartoon_repository.dart';
import 'package:novel_cartoon_video/model/cartoon_chapter_model.dart';
import 'package:novel_cartoon_video/ui/base/base_state.dart';
import 'package:novel_cartoon_video/ui/global/global_toast.dart';

/// 查看漫画
class CartoonViewPage extends StatefulWidget {
  final List<CartoonChapterModel> _cartoonChapters;
  final int _cartoonChapterIndex;
  final String _cartoonTitle;

  CartoonViewPage(
      this._cartoonChapters, this._cartoonChapterIndex, this._cartoonTitle);

  @override
  _CartoonViewPageState createState() => _CartoonViewPageState(
      _cartoonChapters, _cartoonChapterIndex, _cartoonTitle);
}

class _CartoonViewPageState extends BaseState<CartoonViewPage> {
  CartoonRepository _cartoonRepository = new CartoonRepository();
  bool _showAppBar = false;
  EasyRefreshController _controller;
  String _cartoonTitle;

  _CartoonViewPageState(List<CartoonChapterModel> _cartoonChapters,
      int _cartoonChapterIndex, this._cartoonTitle) {
    // 初始化数据
    _cartoonRepository.configCartoonContent(
        _cartoonChapters, _cartoonChapterIndex);
  }

  Widget _contentView;
  AppBar _appBar;
  bool _hasMore = false;
  GlobalKey _globalRefreshKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return buildContent(context);
  }

  @override
  Widget buildBodyWidget(BuildContext buildContext) {
    return Container(
      color: Color(0xFF80532F),
      child: Stack(
        children: _buildBody(),
      ),
    );
  }

  List<Widget> _buildBody() {
    _contentView = MediaQuery.removePadding(
      context: context,
      child: NotificationListener(
        child: EasyRefresh(
          key: _globalRefreshKey,
          enableControlFinishLoad: true,
          header: ClassicalHeader(
            refreshText: '下拉加载上一章',
            refreshReadyText: '松开加载上一章',
            refreshingText: '正在加载上一章',
            refreshedText: '加载完成',
            noMoreText: '已经是第一章了',
            infoText: '更新于%T',
            showInfo: true,
            bgColor: Colors.transparent,
            textColor: Colors.grey.shade200,
            infoColor: Colors.black26,
          ),
          footer: ClassicalFooter(
            loadText: '上拉加载下一章',
            loadReadyText: '松开加载下一章',
            loadingText: '正在加载下一章',
            loadedText: '加载完成',
            noMoreText: '已经是最后一章了',
            infoText: '更新于%T',
            showInfo: true,
            bgColor: Colors.transparent,
            textColor: Colors.grey.shade200,
            infoColor: Colors.black26,
          ),
          onLoad: _hasMore
              ? () async {
                  _cartoonRepository.loadNextCartoonContent().then((value) {
                    if (!value.success) {
                      if (value.code == -2) {
                        _hasMore = false;
                      }
                      GlobalToast.toastLong(value.msg);
                    }
                  }).whenComplete(() {
                    if (mounted) {
                      setState(() {
                        _controller.finishLoad(
                            success: true, noMore: !_hasMore);
                      });
                    }
                  });
                }
              : null,
          onRefresh: () async =>
              _cartoonRepository.loadPreCartoonContent().then((value) {
            if (!value.success) {
              GlobalToast.toastLong(value.msg);
            }
          }).whenComplete(() {
            if (mounted) {
              setState(() {});
            }
          }),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                child: CachedNetworkImage(
                  imageUrl:
                      _cartoonRepository.cartoonContentImages[index].trim(),
                  fit: BoxFit.cover,
                ),
                onTapUp: (d) {
                  // 这里使用up事件是避免onTap和onScroll事件冲突
                  setState(() {
                    _showAppBar = !_showAppBar;
                  });
                },
              );
            },
            itemCount: _cartoonRepository.cartoonContentImages.length,
          ),
          controller: _controller,
        ),
        onNotification: (ScrollNotification note) {
          // 收到滚动事件
          if (_showAppBar) {
            setState(() {
              _showAppBar = false;
            });
          } else {
            // 如果不需要全局刷新，需要更新左下角索引ui
          }
          return false;
        },
      ),
      removeTop: true,
      removeBottom: true,
    );
    if (null == _appBar) {
      _appBar = AppBar(
        primary: true,
        title: Text(_cartoonTitle),
      );
    }
    // 构建章节tip
    Widget _chapterTip = Positioned(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.grey.shade600,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(topRight: Radius.circular(6))),
        child: Padding(
          padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: Text(
            "第 ${_cartoonRepository.currentChapterIndex + 1} 章",
            style: TextStyle(
              color: Colors.grey.shade300,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      left: 0,
      bottom: 0,
    );
    if (_showAppBar) {
      return [
        _contentView,
        Container(
          height: kToolbarHeight + kTextTabBarHeight, //appbar高度+状态栏高度
          child: _appBar,
        ),
        _chapterTip,
      ];
    } else {
      return [
        _contentView,
        _chapterTip,
      ];
    }
  }

  @override
  void initState() {
    _controller = EasyRefreshController();
    _cartoonRepository.loadCurrentCartoonContent().then((value) {
      setLoadStatus(true);
      if (value.code == 0) {
        _hasMore = true;
      }
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
