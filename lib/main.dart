// @dart = 2.9
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:novel_cartoon_video/ui/main_page.dart';
import 'package:novel_cartoon_video/util/system_util.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.red, brightness: Brightness.light),
    home: MainPage(),
  ));
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUtil.setStatusBarTransparent();
  }
}
