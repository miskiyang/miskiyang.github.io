import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:personal_website/core/cartoon_repository.dart';
import 'package:personal_website/model/cartoon_model.dart';
import 'package:personal_website/model/http/ResultDto.dart';
import 'package:personal_website/ui/base/base_state.dart';
import 'package:personal_website/ui/base_page.dart';
import 'package:personal_website/ui/global/global_image.dart';

import 'cartoon_detail_page.dart';
import 'global/global_toast.dart';

/// 漫画页面
class CartoonPage extends StatefulWidget {
  final String _cartoonType;

  CartoonPage(this._cartoonType);

  @override
  _CartoonPageState createState() => _CartoonPageState(_cartoonType);
}

class _CartoonPageState extends BaseState<CartoonPage>
    with AutomaticKeepAliveClientMixin {
  CartoonRepository _cartoonRepository = new CartoonRepository();
  List<CartoonModel> _cartoons = <CartoonModel>[];
  bool _hasMore = false;

  /// 漫画类型
  String _cartoonType;

  _CartoonPageState(this._cartoonType);

  EasyRefreshController _controller;

  int _pageSize = 10;
  int _pageIndex = 1;

  GlobalKey _globalRefreshKey = GlobalKey();

  @override
  bool get wantKeepAlive => true;

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
              .listCartoonByPage(_cartoonType, 0, _pageSize)
              .then((value) {
            if (!value.success) {
              GlobalToast.toastLong(value.msg);
            } else {
              _cartoons = value.data;
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
                  ..listCartoonByPage(_cartoonType, _pageIndex + 1, _pageSize)
                      .then((value) {
                    // 新增分页数据
                    if (!value.success) {
                      GlobalToast.toastLong(value.msg);
                    } else {
                      _pageIndex++;
                      _cartoons.addAll(value.data);
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
            itemBuilder: (context, index) =>
                buildListItemView(_cartoons[index]),
            separatorBuilder: (context, index) => Divider(
                  height: 1.0,
                  color: Colors.grey[200],
                ),
            itemCount: _cartoons.length));
  }

  /// 构建listItemView
  Widget buildListItemView(CartoonModel item) {
    return bindTapEvent(
        Padding(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Hero(
                    tag: item.cover,
                    createRectTween: _createRectTween,
                    child: CachedNetworkImage(
                        placeholder: defaultPlaceHolder,
                        errorWidget: defaultErrorHolder,
                        imageUrl: item.cover,
                        width: 90,
                        height: 120,
                        fit: BoxFit.cover)),
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
            MaterialPageRoute(builder: (context) => CartoonDetailPage(item))));
  }

  RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  @override
  void initState() {
    _controller = EasyRefreshController();
    Future<ResultDto<List<CartoonModel>>> result = _cartoonRepository
        .listCartoonByPage(_cartoonType, _pageIndex, _pageSize);
    result.then((value) {
      if (value.success) {
        _cartoons = value.data;
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
