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

  Repository _repository = Repository();

  /// 分页加载数据
  Future<ResultDto<List<FictionModel>>> listFictionByPage(
      String fictionType, int pageIndex, int pageSize) {
    Future<BaseResponse<List<FictionModel>>> result =
        _repository.fetchDataFromRemote("/fiction/search/fictionType/" +
            fictionType +
            "/" +
            pageIndex.toString() +
            "/" +
            pageSize.toString());

    return result
        .then((value) => _repository.handleResult(value, pageIndex, pageSize))
        .catchError((e) => _repository.handleError<List<FictionModel>>(
            e, pageIndex, pageSize));
  }
}
