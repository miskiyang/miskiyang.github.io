import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:novel_cartoon_video/widget/ball_pulse_fix_indicator.dart';

/// 加载中的widget
Widget loadingWidget(String text) {
  if (null == text || text.isEmpty) {
    return Container(
      alignment: Alignment.center,
      child: Loading(
          indicator: BallPulseFixIndicator(),
          size: 50.0,
          color: Colors.redAccent),
    );
  } else {
    return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
            ),
            Loading(
                indicator: BallPulseFixIndicator(),
                size: 50.0,
                color: Colors.redAccent),
          ],
        ));
  }
}
