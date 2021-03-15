import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 漫画详情页面
class CartoonDetailPage extends StatefulWidget {
  final String _cartoonId;

  @override
  _CartoonDetailPageState createState() => _CartoonDetailPageState();
}

class _CartoonDetailPageState extends State<CartoonDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "漫画详情",
        style: TextStyle(fontSize: 18, color: Colors.white),
      )),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Text('漫画详情');
  }
}
