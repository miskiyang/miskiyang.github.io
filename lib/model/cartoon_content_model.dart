/// cartoonVariableId : 2
/// creationTime : 1609003729000
/// chapterId : "2316518"
/// cartoonId : "2yirenzhixia"
/// id : 415175
/// content : ["https://res.xiaoqinre.com/images/comic/159/316518/1519527843Efo9qfJOY9Jb_VP4.jpg"," https://res.xiaoqinre.com/images/comic/159/316518/1519527844GMfoVznVXkoEWSLN.jpg"," https://res.xiaoqinre.com/images/comic/159/316518/1519527844fIPxE1l7oRlFRjd-.jpg"," https://res.xiaoqinre.com/images/comic/159/316518/1519527845mjhIqfGEIN0tRiq9.jpg"," https://res.xiaoqinre.com/images/comic/159/316518/1519527845bO68qo1r4N0X8Hfr.jpg"," https://res.xiaoqinre.com/images/comic/159/316518/1519527845-fYNeLkaFcGP38i-.jpg"," https://res.xiaoqinre.com/images/comic/159/316518/1519527846tgV0x-wAkDEahA3k.jpg"," https://res.xiaoqinre.com/images/comic/159/316518/1519527846p5uRD0AUBh7VAck5.jpg"," https://res.xiaoqinre.com/images/comic/159/316518/15195278469Y6xh_jqDJObWelu.jpg"," https://res.xiaoqinre.com/images/comic/159/316518/1519527847txbRWVPoMcWbh1TS.jpg"," https://res.xiaoqinre.com/images/comic/159/316518/1519527847DTU5whH2NtlfY7v4.jpg"," https://res.xiaoqinre.com/images/comic/159/316518/1519527848ZltMhw4VMGzQ9L_z.jpg"," https://res.xiaoqinre.com/images/comic/159/316518/1519527848dTGU46MD9w4zeeD2.jpg"," https://res.xiaoqinre.com/images/comic/159/316518/1519527848CsevgzpNn_8SfML9.jpg"," https://res.xiaoqinre.com/images/comic/159/316518/1519527849IWDG-ZjBecRW0wbN.jpg"," https://res.xiaoqinre.com/images/comic/159/316518/1519527849YF7JdQQOaWdsCP4d.jpg"," https://res.xiaoqinre.com/images/comic/159/316518/1519527849eYMmWKilAcCz_Dhs.jpg"," https://res.xiaoqinre.com/images/comic/159/316518/1519527850Nbkg49URJs8DRwqC.jpg"]
/// 漫画内容
class CartoonContentModel {
  int _cartoonVariableId;
  int _creationTime;
  String _chapterId;
  String _cartoonId;
  int _id;
  List<String> _content;

  int get cartoonVariableId => _cartoonVariableId;

  int get creationTime => _creationTime;

  String get chapterId => _chapterId;

  String get cartoonId => _cartoonId;

  int get id => _id;

  List<String> get content => _content;

  CartoonContentModel(
      {int cartoonVariableId,
      int creationTime,
      String chapterId,
      String cartoonId,
      int id,
      List<String> content}) {
    _cartoonVariableId = cartoonVariableId;
    _creationTime = creationTime;
    _chapterId = chapterId;
    _cartoonId = cartoonId;
    _id = id;
    _content = content;
  }

  CartoonContentModel.fromJson(dynamic json) {
    _cartoonVariableId = json["cartoonVariableId"];
    _creationTime = json["creationTime"];
    _chapterId = json["chapterId"];
    _cartoonId = json["cartoonId"];
    _id = json["id"];
    _content = json["content"] != null ? json["content"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["cartoonVariableId"] = _cartoonVariableId;
    map["creationTime"] = _creationTime;
    map["chapterId"] = _chapterId;
    map["cartoonId"] = _cartoonId;
    map["id"] = _id;
    map["content"] = _content;
    return map;
  }

  @override
  String toString() {
    return 'CartoonContentModel{_cartoonVariableId: $_cartoonVariableId, _creationTime: $_creationTime, _chapterId: $_chapterId, _cartoonId: $_cartoonId, _id: $_id, _content: $_content}';
  }
}
