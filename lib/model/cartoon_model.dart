/// id : 9800
/// title : "一人之下"
/// descs : "简介：大学生张楚岚清明回乡，遭遇神秘少女冯宝宝。素未谋面的冯宝宝却对张楚岚异常熟悉，并将其带去自己打工的快递公司。为了帮冯宝宝寻找她的身世，也为了查清自己与爷爷身上的秘密，张楚岚的生活被彻底颠覆，与冯宝宝一同踏上\"异人\"之旅。"
/// cover : "https://res1.xiaoqinre.com/images/cover/201802/1519731856haFOHhB8B3uYG4xY.jpg"
/// author : "动漫堂 x 米二"
/// cartoonType : "少年漫画"
/// cartoonId : "2yirenzhixia"
/// updateTime : "2021-02-26 00:00:00.0"
/// creationTime : "2020-12-26T17:22:21.000+00:00"
/// cartoonVariableId : 2
/// 漫画信息
class CartoonModel {
  int _id;
  String _title;
  String _descs;
  String _cover;
  String _author;
  String _cartoonType;
  String _cartoonId;
  String _updateTime;
  String _creationTime;
  int _cartoonVariableId;

  int get id => _id;
  String get title => _title;
  String get descs => _descs;
  String get cover => _cover;
  String get author => _author;
  String get cartoonType => _cartoonType;
  String get cartoonId => _cartoonId;
  String get updateTime => _updateTime;
  String get creationTime => _creationTime;
  int get cartoonVariableId => _cartoonVariableId;

  CartoonModel(
      {int id,
      String title,
      String descs,
      String cover,
      String author,
      String cartoonType,
      String cartoonId,
      String updateTime,
      String creationTime,
      int cartoonVariableId}) {
    _id = id;
    _title = title;
    _descs = descs;
    _cover = cover;
    _author = author;
    _cartoonType = cartoonType;
    _cartoonId = cartoonId;
    _updateTime = updateTime;
    _creationTime = creationTime;
    _cartoonVariableId = cartoonVariableId;
  }

  CartoonModel.fromJson(Map<String, dynamic> json) {
    _id = json["id"];
    _title = json["title"];
    _descs = json["descs"];
    _cover = json["cover"];
    _author = json["author"];
    _cartoonType = json["cartoonType"];
    _cartoonId = json["cartoonId"];
    _updateTime = json["updateTime"];
    _creationTime = json["creationTime"];
    _cartoonVariableId = json["cartoonVariableId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["title"] = _title;
    map["descs"] = _descs;
    map["cover"] = _cover;
    map["author"] = _author;
    map["cartoonType"] = _cartoonType;
    map["cartoonId"] = _cartoonId;
    map["updateTime"] = _updateTime;
    map["creationTime"] = _creationTime;
    map["cartoonVariableId"] = _cartoonVariableId;
    return map;
  }

  @override
  String toString() {
    return 'CartoonModel{_id: $_id, _title: $_title, _descs: $_descs, _cover: $_cover, _author: $_author, _cartoonType: $_cartoonType, _cartoonId: $_cartoonId, _updateTime: $_updateTime, _creationTime: $_creationTime, _cartoonVariableId: $_cartoonVariableId}';
  }
}
