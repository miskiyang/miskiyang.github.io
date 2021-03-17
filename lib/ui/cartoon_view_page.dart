import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:personal_website/core/cartoon_repository.dart';
import 'package:personal_website/model/cartoon_chapter_model.dart';
import 'package:personal_website/ui/base/base_state.dart';
import 'package:personal_website/util/system_util.dart';

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

  @override
  Widget buildBodyWidget(BuildContext buildContext) {
    return Scaffold(
      body: Stack(
        children: _buildBody(),
      ),
    );
  }

  List<Widget> _buildBody() {
    if (null == _contentView) {
      _contentView = MediaQuery.removePadding(
        context: context,
        child: NotificationListener(
          child: EasyRefresh(
            onLoad: () async => _cartoonRepository.loadNextCartoonContent(),
            onRefresh: () async {},
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: CachedNetworkImage(
                    imageUrl: _cartoonRepository.cartoonContentImages[index],
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
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
    }
    if (null == _appBar) {
      _appBar = AppBar(
        title: Text(_cartoonTitle),
      );
    }
    if (_showAppBar) {
      // 显示状态栏和导航栏
      SystemUtil.showStatusBarAndNavigationBar();
      return [
        _contentView,
        Container(
          height: kToolbarHeight + kTextTabBarHeight, //appbar高度+状态栏高度
          child: _appBar,
        ),
      ];
    } else {
      // 隐藏状态栏和导航栏
      SystemUtil.hideStatusBarAndNavigationBar();
      return [_contentView];
    }
  }

  @override
  void initState() {
    _controller = EasyRefreshController();
    _cartoonRepository.loadCurrentCartoonContent().then((value) {
      setLoadStatus(true);
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
