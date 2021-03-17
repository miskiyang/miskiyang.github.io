import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:personal_website/core/fiction_repository.dart';
import 'package:personal_website/model/fiction_model.dart';
import 'package:personal_website/model/http/ResultDto.dart';
import 'package:personal_website/ui/base/base_state.dart';
import 'package:personal_website/ui/global/global_image.dart';
import 'package:personal_website/ui/global/global_toast.dart';

/// 小说页面
class FictionPage extends StatefulWidget {
  final String _fictionType;

  FictionPage(this._fictionType);

  @override
  _FictionPageState createState() => _FictionPageState(_fictionType);
}

class _FictionPageState extends BaseState<FictionPage> {
  FictionRepository _fictionRepository = new FictionRepository();
  List<FictionModel> _novels = <FictionModel>[];

  /// 小说类型
  String _fictionType;

  _FictionPageState(this._fictionType);

  @override
  Widget buildBodyWidget(BuildContext buildContext) => ListView(
        children: _novels.map((e) => buildListItemView(e)).toList(),
      );

  /// 构建listItemView
  Widget buildListItemView(FictionModel item) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            CachedNetworkImage(
                placeholder: defaultPlaceHolder,
                errorWidget: defaultErrorHolder,
                imageUrl: item.cover,
                width: 90,
                height: 120,
                fit: BoxFit.cover),
            Expanded(
                child: Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    item.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                      item.descs,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  Text(
                    item.author,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    Future<ResultDto<List<FictionModel>>> result =
        _fictionRepository.listStoryBookByPage(_fictionType, 0, 10);
    result.then((value) {
      if (value.success) {
        _novels = value.data;
      } else {
        GlobalToast.toastShort(value.msg);
      }
      if (mounted) {
        setLoadStatus(true);
        setState(() {});
      }
    });
    super.initState();
  }
}
