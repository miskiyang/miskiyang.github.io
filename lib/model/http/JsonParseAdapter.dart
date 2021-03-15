import 'package:personal_website/model/cartoon_model.dart';
import 'package:personal_website/model/fiction_model.dart';
import 'package:personal_website/model/video_model.dart';

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
    if (List<FictionModel>() is T) {
      return (json as List)
          .map((element) => FictionModel.fromJson(element))
          .toList() as T;
    } else if (List<CartoonModel>() is T) {
      return (json as List)
          .map((element) => CartoonModel.fromJson(element))
          .toList() as T;
    } else if (List<VideoModel>() is T) {
      return (json as List)
          .map((element) => VideoModel.fromJson(element))
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
    } else if (VideoModel == T) {
      return VideoModel.fromJson(json) as T;
    } else {
      throw UnimplementedError("未实现解析函数的类型$T");
    }
  }
}
