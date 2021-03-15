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

  Repository _repository = Repository();

  /// 分页加载数据
  Future<ResultDto<List<CartoonModel>>> listCartoonByPage(
      String _cartoonType, int from, int count) {
    Future<BaseResponse<List<CartoonModel>>> result =
        _repository.fetchDataFromRemote("/cartoon/search/cartoonType/" +
            _cartoonType +
            "/" +
            from.toString() +
            "/" +
            count.toString());
    return result
        .then((value) => _repository.handleResult(value, from, count))
        .catchError((e) => _repository.handleError(e, from, count));
  }
}
