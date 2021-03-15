import 'package:flutter/cupertino.dart';

/// 基类

typedef TapEvent = void Function();

TapEvent onTap;

/// 对控件做点击事件绑定
bindTapEvent(Widget widget, {TapEvent onTap}) {
  return GestureDetector(
    child: widget,
    onTap: onTap,
  );
}
