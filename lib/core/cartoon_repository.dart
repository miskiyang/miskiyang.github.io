import 'package:novel_cartoon_video/core/http/Repository.dart';
import 'package:novel_cartoon_video/model/cartoon_chapter_model.dart';
import 'package:novel_cartoon_video/model/cartoon_content_model.dart';
import 'package:novel_cartoon_video/model/cartoon_model.dart';
import 'package:novel_cartoon_video/model/http/BaseResponse.dart';
import 'package:novel_cartoon_video/model/http/ResultDto.dart';

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
        .catchError(
            (e) => _repository.handleError<List<CartoonModel>>(e, from, count));
  }

  /// 加载动漫章节数据
  Future<ResultDto<List<CartoonChapterModel>>> listCartoonChapter(
      String _cartoonId) {
    Future<BaseResponse<List<CartoonChapterModel>>> result =
        _repository.fetchDataFromRemote("/cartoonChapter/search/" + _cartoonId);
    return result
        .then((value) => _repository.handleResult(value, 0, 0))
        .catchError(
            (e) => _repository.handleError<List<CartoonChapterModel>>(e, 0, 0));
  }

  /// 加载动漫内容数据
  Future<ResultDto<CartoonContentModel>> _getCartoonContent(
      String _cartoonChapterId) {
    Future<BaseResponse<CartoonContentModel>> result = _repository
        .fetchDataFromRemote("/cartoonContent/search/" + _cartoonChapterId);
    return result
        .then((value) => _repository.handleResult(value, 0, 0))
        .catchError(
            (e) => _repository.handleError<CartoonContentModel>(e, 0, 0));
  }

  set cartoonChapters(List<CartoonChapterModel> value) {
    _cartoonChapters = value;
  }

  /// 获取漫画章节内容数据
  Future<ResultDto<CartoonContentModel>> _loadCartoonContent(
      int _currentChapterIndex) async {
    int length = _cartoonChapters.length;
    if (length > 0) {
      // 处理无效的索引
      if (_currentChapterIndex >= length) {
        _currentChapterIndex = length - 1;
      } else if (_currentChapterIndex < 0) {
        _currentChapterIndex = 0;
      }
      // 当前的章节数据
      CartoonChapterModel cartoonChapterModel =
          _cartoonChapters[_currentChapterIndex];
      String cartoonChapterId = cartoonChapterModel.chapterId;
      CartoonContentModel cartoonContentModel =
          _cartoonContentMap[cartoonChapterId];
      if (null == cartoonContentModel) {
        // 获取远端的数据
        Future<ResultDto<CartoonContentModel>> result =
            _getCartoonContent(cartoonChapterId);
        return result.then((value) {
          if (value.success) {
            _cartoonContentMap[cartoonChapterId] = value.data;
          }
          return value;
        });
      } else {
        return ResultDto.success(0, '加载数据成功', cartoonContentModel);
      }
    } else {
      return ResultDto.failure(-1, "章节参数出错，请重新加载");
    }
  }

  /// 获取当前漫画章节内容
  Future<ResultDto<CartoonContentModel>> loadCurrentCartoonContent() async {
    return _loadCartoonContent(currentChapterIndex).then((value) {
      if (value.success) {
        _cartoonContentImages.clear();
        _cartoonContentImages.addAll(value.data.content);
      }
      return value;
    });
  }

  /// 获取下一个漫画章节内容
  Future<ResultDto<CartoonContentModel>> loadNextCartoonContent() async {
    int _nextCartoonChapterIndex = currentChapterIndex + 1;
    if (_nextCartoonChapterIndex >= _cartoonChapters.length) {
      return ResultDto.failure(-2, "已经是最后一章了");
    } else {
      print('======>nextPage======>$_nextCartoonChapterIndex');
      return _loadCartoonContent(_nextCartoonChapterIndex).then((value) {
        if (value.success) {
          _cartoonContentImages.addAll(value.data.content);
          currentChapterIndex = _nextCartoonChapterIndex;
        }
        return value;
      });
    }
  }

  /// 获取上一个漫画章节内容
  Future<ResultDto<CartoonContentModel>> loadPreCartoonContent() async {
    int _preCartoonChapterIndex = currentChapterIndex - 1;
    if (_preCartoonChapterIndex < 0) {
      print('======>loadPreCartoonContent');
      return ResultDto.failure(-2, "已经是第一章了");
    } else {
      return _loadCartoonContent(_preCartoonChapterIndex).then((value) {
        if (value.success) {
          _cartoonContentImages.insertAll(0, value.data.content);
          currentChapterIndex = _preCartoonChapterIndex;
        }
        return value;
      });
    }
  }

  /// 漫画内容相关的资源数据
  List<CartoonChapterModel> _cartoonChapters = [];
  List<String> _cartoonContentImages = [];
  Map<String, CartoonContentModel> _cartoonContentMap = Map();
  int currentChapterIndex = -1;

  set cartoonContentMap(Map<String, CartoonContentModel> value) {
    _cartoonContentMap = value;
  }

  List<String> get cartoonContentImages => _cartoonContentImages;

  /// 初始化配置信息
  void configCartoonContent(
    List<CartoonChapterModel> _cartoonChapters,
    int _cartoonChapterIndex,
  ) {
    this._cartoonChapters = _cartoonChapters;
    this.currentChapterIndex = _cartoonChapterIndex;
    // 清楚历史数据
    this._cartoonContentMap.clear();
    this._cartoonContentImages.clear();
  }
}
