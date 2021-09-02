import 'package:flutter/material.dart';
import 'package:novel_cartoon_video/ui/global/global_widget.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  bool _status = false;
  Widget _loadingWidget;

  @protected
  Widget buildContent(BuildContext context) {
    if (_status) {
      // 数据已经加载成功
      return buildBodyWidget(context);
    } else {
      if (_loadingWidget == null) {
        _loadingWidget = loadingWidget(null);
      }
      return _loadingWidget;
    }
  }

  Widget buildBodyWidget(BuildContext buildContext);

  setLoadStatus(bool status) {
    this._status = status;
  }
}
