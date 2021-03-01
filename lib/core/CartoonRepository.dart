import 'package:personal_website/core/http/Repository.dart';
import 'package:personal_website/model/cartoon_model.dart';
import 'package:personal_website/model/http/BaseResponse.dart';
import 'package:personal_website/model/http/ResultDto.dart';

/// 漫画数据资源中心
class CartoonRepository {
  /// 单例模式
  factory CartoonRepository() => _getInstance();

  static CartoonRepository _instance;

  CartoonRepository._internal();

  static CartoonRepository _getInstance() {
    if (null == _instance) {
      _instance = CartoonRepository._internal();
    }
    return _instance;
  }

  Repository _baseRepository = Repository();

  /// 分页加载数据
  Future<ResultDto<List<CartoonModel>>> listCartoonByPage(
      String fictionType, int from, int count) {
    Future<BaseResponse<List<CartoonModel>>> result =
        _baseRepository.fetchDataFromRemote("/cartoon/search/cartoonType/" +
            fictionType +
            "/" +
            from.toString() +
            "/" +
            count.toString());
    return result
        .then((value) => ResultDto.success(
            value.code, value.msg, value.data.data, from: from, count: count))
        .catchError((e) => ResultDto<List<CartoonModel>>.failure(-1, e.message,
            from: from, count: count));
  }
}
