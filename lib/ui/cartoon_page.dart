import 'package:flutter/material.dart';
import 'package:personal_website/core/CartoonRepository.dart';
import 'package:personal_website/model/cartoon_model.dart';
import 'package:personal_website/model/http/ResultDto.dart';

/// 漫画页面
class CartoonPage extends StatefulWidget {
  final String _cartoonType;

  CartoonPage(this._cartoonType);

  @override
  _CartoonPageState createState() => _CartoonPageState(_cartoonType);
}

class _CartoonPageState extends State<CartoonPage> {
  CartoonRepository _cartoonRepository = new CartoonRepository();
  List<CartoonModel> _cartoons = <CartoonModel>[];

  /// 漫画类型
  String _cartoonType;
  _CartoonPageState(this._cartoonType);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _cartoons.map((e) => buildListItemView(e)).toList(),
    );
  }

  /// 构建listItemView
  Widget buildListItemView(CartoonModel item) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.network(item.cover, width: 90, height: 120, fit: BoxFit.fill),
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
    Future<ResultDto<List<CartoonModel>>> result =
        _cartoonRepository.listCartoonByPage(_cartoonType, 0, 10);
    result.then((value) {
      _cartoons = value.data;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }
}
