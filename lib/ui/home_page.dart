import 'package:flutter/material.dart';

/// 首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Text(
        '首页',
        style: TextStyle(color: Colors.brown),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
