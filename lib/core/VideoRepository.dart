import 'package:personal_website/core/http/Repository.dart';
import 'package:personal_website/model/http/BaseResponse.dart';
import 'package:personal_website/model/http/ResultDto.dart';
import 'package:personal_website/model/video_model.dart';

/// 视频数据资源中心
class VideoRepository {
  /// 单例模式
  factory VideoRepository() => _getInstance();

  static VideoRepository _instance;

  VideoRepository._internal();

  static VideoRepository _getInstance() {
    if (null == _instance) {
      _instance = VideoRepository._internal();
    }
    return _instance;
  }

  Repository _baseRepository = Repository();

  /// 分页加载数据
  Future<ResultDto<List<VideoModel>>> listVideoByPage(
      String videoType, int from, int count) {
    Future<BaseResponse<List<VideoModel>>> result =
        _baseRepository.fetchDataFromRemote("/video/search/videoType/" +
            videoType +
            "/" +
            from.toString() +
            "/" +
            count.toString());
    return result
        .then((value) => ResultDto.success(
            value.code, value.msg, value.data.data, from: from, count: count))
        .catchError((e) => ResultDto<List<VideoModel>>.failure(-1, e.message,
            from: from, count: count));
  }
}
