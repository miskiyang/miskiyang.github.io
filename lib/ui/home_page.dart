import 'package:flutter/material.dart';

/// 首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '首页',
        style: TextStyle(color: Colors.brown),
      ),
    );
  }
}