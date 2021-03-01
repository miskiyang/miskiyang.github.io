import 'package:personal_website/core/http/Repository.dart';
import 'package:personal_website/model/fiction_model.dart';
import 'package:personal_website/model/http/BaseResponse.dart';
import 'package:personal_website/model/http/ResultDto.dart';

/// 小说数据资源中心
class FictionRepository {
  /// 单例模式
  factory FictionRepository() => _getInstance();

  static FictionRepository _instance;

  FictionRepository._internal();

  static FictionRepository _getInstance() {
    if (null == _instance) {
      _instance = FictionRepository._internal();
    }
    return _instance;
  }

  Repository _baseRepository = Repository();

  /// 分页加载数据
  Future<ResultDto<List<FictionModel>>> listStoryBookByPage(
      String fictionType, int from, int count) {
    Future<BaseResponse<List<FictionModel>>> result =
        _baseRepository.fetchDataFromRemote("/fiction/search/fictionType/" +
            fictionType +
            "/" +
            from.toString() +
            "/" +
            count.toString());
    return result
        .then((value) => ResultDto.success(
            value.code, value.msg, value.data.data, from: from, count: count))
        .catchError((e) => ResultDto<List<FictionModel>>.failure(-1, e.message,
            from: from, count: count));
  }
}
