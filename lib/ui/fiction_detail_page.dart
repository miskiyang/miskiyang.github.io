import 'package:flutter/material.dart';
import 'package:personal_website/model/fiction_model.dart';

class FictionDetailPage extends StatefulWidget {
  final FictionModel _fictionModel;

  FictionDetailPage(this._fictionModel);

  @override
  _FictionDetailPageState createState() =>
      _FictionDetailPageState(_fictionModel);
}

class _FictionDetailPageState extends State<FictionDetailPage> {
  FictionModel _fictionModel;

  _FictionDetailPageState(this._fictionModel);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
