import 'package:novel_cartoon_video/model/cartoon_chapter_model.dart';
import 'package:novel_cartoon_video/model/cartoon_content_model.dart';
import 'package:novel_cartoon_video/model/cartoon_model.dart';
import 'package:novel_cartoon_video/model/fiction_model.dart';
import 'package:novel_cartoon_video/model/video_chapter_model.dart';
import 'package:novel_cartoon_video/model/video_model.dart';

/// 实体解析适配器

const String listFlag = "List<";

class JsonParseAdapter {
  /// 解析对象
  T convertJsonToT<T>(dynamic json) {
    String typeStr = T.toString();
    if (typeStr.startsWith(listFlag)) {
      return _convertToList(json);
    } else {
      return _convertToObject(json);
    }
  }

  /// 解析成list
  T _convertToList<T>(dynamic json) {
    if (<FictionModel>[] is T) {
      return (json as List)
          .map((element) => FictionModel.fromJson(element))
          .toList() as T;
    } else if (<CartoonModel>[] is T) {
      return (json as List)
          .map((element) => CartoonModel.fromJson(element))
          .toList() as T;
    } else if (<CartoonChapterModel>[] is T) {
      return (json as List)
          .map((element) => CartoonChapterModel.fromJson(element))
          .toList() as T;
    } else if (<VideoModel>[] is T) {
      return (json as List)
          .map((element) => VideoModel.fromJson(element))
          .toList() as T;
    } else if (<VideoChapterModel>[] is T) {
      return (json as List)
          .map((element) => VideoChapterModel.fromJson(element))
          .toList() as T;
    } else {
      throw UnimplementedError("未实现解析函数的类型$T");
    }
  }

  /// 解析成object
  T _convertToObject<T>(dynamic json) {
    if (FictionModel == T) {
      return FictionModel.fromJson(json) as T;
    } else if (CartoonModel == T) {
      return CartoonModel.fromJson(json) as T;
    } else if (CartoonChapterModel == T) {
      return CartoonChapterModel.fromJson(json) as T;
    } else if (CartoonContentModel == T) {
      return CartoonContentModel.fromJson(json) as T;
    } else if (VideoModel == T) {
      return VideoModel.fromJson(json) as T;
    } else if (VideoChapterModel == T) {
      return VideoChapterModel.fromJson(json) as T;
    } else {
      throw UnimplementedError("未实现解析函数的类型$T");
    }
  }
}
