import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 全局图片相关的配置
/// placeholder
Widget defaultPlaceHolder(context, url) => Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Text(
        '正在加载...',
        style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade400,
            fontStyle: FontStyle.italic),
      ),
    );

Widget defaultErrorHolder(context, url, e) => Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Text(
        '加载失败',
        style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade400,
            fontStyle: FontStyle.italic),
      ),
    );
