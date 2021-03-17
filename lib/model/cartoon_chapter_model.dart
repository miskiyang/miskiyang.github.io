/// id : 438331
/// title : "1.姐姐1"
/// chapterId : "2316518"
/// cartoonId : "2yirenzhixia"
/// creationTime : "2020-12-26T17:22:21.000+00:00"
/// cartoonVariableId : 2
/// 漫画章节
class CartoonChapterModel {
  int _id;
  String _title;
  String _chapterId;
  String _cartoonId;
  String _creationTime;
  int _cartoonVariableId;

  int get id => _id;

  String get title => _title;

  String get chapterId => _chapterId;

  String get cartoonId => _cartoonId;

  String get creationTime => _creationTime;

  int get cartoonVariableId => _cartoonVariableId;

  CartoonChapterModel(
      {int id,
      String title,
      String chapterId,
      String cartoonId,
      String creationTime,
      int cartoonVariableId}) {
    _id = id;
    _title = title;
    _chapterId = chapterId;
    _cartoonId = cartoonId;
    _creationTime = creationTime;
    _cartoonVariableId = cartoonVariableId;
  }

  CartoonChapterModel.fromJson(dynamic json) {
    _id = json["id"];
    _title = json["title"];
    _chapterId = json["chapterId"];
    _cartoonId = json["cartoonId"];
    _creationTime = json["creationTime"];
    _cartoonVariableId = json["cartoonVariableId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["title"] = _title;
    map["chapterId"] = _chapterId;
    map["cartoonId"] = _cartoonId;
    map["creationTime"] = _creationTime;
    map["cartoonVariableId"] = _cartoonVariableId;
    return map;
  }
}
