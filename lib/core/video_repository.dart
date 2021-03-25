import 'package:personal_website/core/http/Repository.dart';
import 'package:personal_website/model/http/BaseResponse.dart';
import 'package:personal_website/model/http/ResultDto.dart';
import 'package:personal_website/model/video_chapter_model.dart';
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

  Repository _repository = Repository();

  /// 分页加载数据
  Future<ResultDto<List<VideoModel>>> listVideoByPage(
      String videoType, int from, int count) {
    Future<BaseResponse<List<VideoModel>>> result =
        _repository.fetchDataFromRemote("/video/search/videoType/" +
            videoType +
            "/" +
            from.toString() +
            "/" +
            count.toString());
    return result
        .then((value) => _repository.handleResult(value, from, count))
        .catchError(
            (e) => _repository.handleError<List<VideoModel>>(e, from, count));
  }

  /// 获取视频章节
  Future<ResultDto<List<VideoChapterModel>>> listVideoChapter(String videoId) {
    Future<BaseResponse<List<VideoChapterModel>>> result =
        _repository.fetchDataFromRemote("/videoChapter/search/" + videoId);
    return result
        .then((value) => _repository.handleResult(value, 0, 0))
        .catchError(
            (e) => _repository.handleError<List<VideoChapterModel>>(e, 0, 0));
  }
}
