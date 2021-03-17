import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 系统工具类
class SystemUtil {
  /// 隐藏状态栏，保留底部按钮栏
  static hideStatusBar() =>
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

  /// 显示状态栏，隐藏底部按钮栏
  static hideNavigationBar() =>
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);

  /// 隐藏状态栏和底部按钮栏
  static hideStatusBarAndNavigationBar() =>
      SystemChrome.setEnabledSystemUIOverlays([]);

  /// 显示状态栏和底部按钮栏
  static showStatusBarAndNavigationBar() =>
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

  /// 设置状态栏透明
  static setStatusBarTransparent() =>
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ));
}
