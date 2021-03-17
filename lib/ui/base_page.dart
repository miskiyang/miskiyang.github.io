import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 基类

typedef TapEvent = void Function();

TapEvent onTap;

/// 对控件做点击事件绑定
bindTapEvent(Widget widget, {TapEvent onTap}) {
  return InkWell(
    child: widget,
    splashColor: Colors.grey.shade300,
    onTap: onTap,
  );
}
