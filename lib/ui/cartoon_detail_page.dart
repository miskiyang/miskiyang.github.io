import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:personal_website/core/cartoon_repository.dart';
import 'package:personal_website/model/cartoon_chapter_model.dart';
import 'package:personal_website/model/cartoon_model.dart';
import 'package:personal_website/ui/cartoon_view_page.dart';
import 'package:personal_website/ui/global/global_image.dart';
import 'package:personal_website/ui/global/global_toast.dart';
import 'package:personal_website/ui/global/global_widget.dart';

/// 漫画详情页面
class CartoonDetailPage extends StatefulWidget {
  final CartoonModel _cartoon;

  CartoonDetailPage(this._cartoon);

  @override
  _CartoonDetailPageState createState() => _CartoonDetailPageState(_cartoon);
}

class _CartoonDetailPageState extends State<CartoonDetailPage> {
  CartoonRepository _cartoonRepository = new CartoonRepository();
  CartoonModel _cartoon;
  List<CartoonChapterModel> _cartoonChapters = List();
  bool _getChapterDataSuccess = false;

  _CartoonDetailPageState(this._cartoon);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.red),
        home: Scaffold(
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
                brightness: Brightness.dark,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                floating: false,
                pinned: true,
                snap: false,
                expandedHeight: 260,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(left: 20, bottom: 16),
                  title: Text(
                    _cartoon.title,
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
                          imageUrl: _cartoon.cover,
                          width: 90,
                          height: 120,
                          fit: BoxFit.cover),
                      Positioned(
                        right: 16,
                        bottom: 16,
                        child: Text(
                          "作者：" + _cartoon.author,
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
              _buildCartoonDescriptionTitle(),
              _buildCartoonDescription(),
              _buildCartoonCategoriesTitle(),
              _buildCartoonCategories(),
            ],
          ),
        ));
  }

  RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  /// 构建漫画描述标题
  Widget _buildCartoonDescriptionTitle() {
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
  Widget _buildCartoonDescription() {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      sliver: SliverToBoxAdapter(
        child: Text(
          _cartoon.descs,
          style: TextStyle(fontSize: 16, height: 1.6, color: Colors.black54),
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }

  /// 构建漫画目录标题
  Widget _buildCartoonCategoriesTitle() {
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

  /// 构建漫画目录
  Widget _buildCartoonCategories() {
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
                          // 跳转漫画预览
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CartoonViewPage(
                                  _cartoonChapters, index, _cartoon.title)));
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
                                _cartoonChapters[index].title,
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey.shade600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )),
                  childCount: _cartoonChapters.length),
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
    _cartoonRepository.listCartoonChapter(_cartoon.cartoonId).then((value) {
      if (value.success) {
        this._cartoonChapters = value.data;
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
